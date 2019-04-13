{
  Part of Kylix / Delphi open source DbExpress driver for ODBC
  Version 3.017, 2007-08-11

  Copyright (c) 2002 by Vadim V.Lopushansky

  This library is free software; you can redistribute it and/or
  modify it under the terms of the GNU Lesser General Public License
  as published by the Free Software Foundation; either version 2.1
  of the License, or (at your option) any later version.

  This library is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
  See the GNU Lesser General Public License for more details.
}

unit DbxObjectParser;
{$B-}

{.$DEFINE _DEBUG_}

{$IFDEF _DEBUG_}
  // - Debugger options
 {$O-,D+,L+}
 {$UNDEF _TRACE_CALLS_}
 {.$DEFINE _TRACE_CALLS_} // logging of calls
{$ELSE}
  // - Release options:
 {$O+}
 {$UNDEF _TRACE_CALLS_}
{$ENDIF}

{
 - Some warnings:
    -  Diferent quotes support only in "Fixed Templates":
        Examples of different quotes:
                   [catalog].[schema].(table)
                   <c:catalog>.<s:schema>.<t:table>
    - "Fixed Templates" do not allowed change Quote at runtime.
       "Fixed tamplate" marked as:
         ...
         QuoteTemplate :#0
         ...
}

interface

uses
  SysUtils,
  RegExpr, // Regular Expression Library.
           // Author: Andrey V. Sorokin,  St-Petersburg,  Russia
           // home pages: http://anso.da.ru ,  http://anso.virtualave.net
           // e-mail: anso@mail.ru, anso@usa.net
{$IFDEF _TRACE_CALLS_}
  DbxOpenOdbcTrace,
{$ENDIF _TRACE_CALLS_}
  DbxOpenOdbcInterface;

Type

 TArrayOfInteger    = array of integer;
 PArrayOfInteger    = ^TArrayOfInteger;
 TArrayOf3Boolean   = array[1..3]of Boolean;

 PObjectNameTemplateInfo = ^TObjectNameTemplateInfo;
 TObjectNameTemplateInfo = record
   sRegExpr            :String;
   QuoteTemplate       :String; // if Quoted then replace template quote in regexp to
                                // driver current quote string(char)
   RegexpMathesIndexes :PArrayOfInteger; // result position of catalog,schema,table. If index<0 or
                                         // mathes[index] not found then result:=value[nextIndex] else result:=''
   FullNameTemplate    :String; // full name format without internal dividers. Only external dividers
   CatalogTemplate     :String;
   SchemaTemplate      :String;
   ObjectTemplate      :String;
   RequiredParts       :TArrayOf3Boolean;
 end;

 TObjectNameParser = class
 private
   fObjectNameTemplateInfo :TObjectNameTemplateInfo;
   fRegExpr :TRegExpr;
 public
   constructor Create(AObjectNameTemplateInfo:PObjectNameTemplateInfo; const DbQuote:String);
   destructor Destroy;override;
   procedure DecodeObjectFullName(const ObjectFullName:string;
                                   var CatalogName, SchemaName, ObjectName:string);
   function EncodeObjectFullName(const CatalogName, SchemaName, ObjectName:string):string;
   function GetQuotedObjectName(const ObjectName:string):string; overload;
 end;

Const

// Indexes to accessing to TObjectNameTemplateInfo.RegexpMathesIndexes and
// TObjectNameTemplateInfo.RequiredParts

idxLength  = 0;
idxCatalog = 1;
idxSchema  = 2;
idxObject  = 3;

//=================================================================
// DEFAULT DATABASE OBJECT NAME FORMAT: "catalog"."schema"."object"
//=================================================================

DefaultMathesIndexes :array [0..9] of integer = (
   10,    // array length
   4,6,8, // position info for diferent parts. For accessing usage indexes: idxCatalog, idxSchema, idxObject
   6,7,   // array of catalog name matches indexes
   11,12, // array of schema  name matches indexes
   14,13  // array of object  name matches indexes
);

DefaultObjectNameTemplateInfo:TObjectNameTemplateInfo = (
  sRegExpr              :'^((((("(.*)")|([^."]*))\.))?((("(.*)")|([^."]*))\.))?("(.*)"|.*)$';
  //                      |                          ||                       ||          |
  //                       \                        /  \                     /  \        /
  //                         ---------   ----------      ---------   -------      --  --
  //                                   Y                           Y                 Y
  //                                   |                           |                 |
  //                                catalog                      schema            object
  //
  QuoteTemplate       :'"'; // Quote can be redefined at runtime ...
  RegexpMathesIndexes :@DefaultMathesIndexes;// result position of catalog, schema, table
  {
   the next chars is reserved:
   #1 - catalog name
   #2 - schema name
   #3 - object name
  }
  FullNameTemplate    :'"'#1'"."'#2'"."'#3'"';
  CatalogTemplate     :'"'#1'".';
  SchemaTemplate      :'"'#2'".';
  ObjectTemplate      :'"'#3'"';
  RequiredParts       :(True,True,True); // if format is <"catalog"."schema"."table">
    // then call TObjectNameParser.EncodeObjectFullName( catalog='catalog', schema='', object='table')
    // returned empty schema name: <"catalog'.""."table">. But if RequiredParts[idxSchema] will
    // equal False then it returned error result: <"catalog'."table">
);

//=================================================================
// INFORMIX DATABASE OBJECT NAME FORMAT: "catalog":"schema"."object"
//=================================================================

InformixMathesIndexes :array [0..6] of integer = (
   7,     // array length
   4,5,6, // position info for diferent parts. For accessing usage indexes: idxCatalog, idxSchema, idxObject
   2,     // array of catalog name matches indexes
   5,     // array of schema  name matches indexes
   6      // array of object  name matches indexes
);

InformixObjectNameTemplateInfo:TObjectNameTemplateInfo = (
  sRegExpr             :'^(([^:.]*)(\:){1,2})?(([^.]*)\.)?(.*)$';
  //                     |                   ||          ||   |
  //                      \                 /  \        /  \ /
  //                        ------   ------      -   --     Y
  //                               Y               Y        |
  //                               |               |        |
  //                            catalog          schema   object
  //
  QuoteTemplate       :#0; // identify informix do not supported of quote. Or identify fixed template (do not changed in runtime).
  RegexpMathesIndexes :@InformixMathesIndexes;// result position of catalog, schema, table
  //OLD:
  {
  FullNameTemplate    :#1'::'#2'.'#3; // Two characters ":" it is necessary for the taking into account of logic
  CatalogTemplate     :#1'::';        // of work of the parser of parameters "db.pas:TPasrams.ParseSQL".
  }
  //NEW: Fixed: You should use module "SqlExprFix.pas".
  FullNameTemplate    :#1':'#2'.'#3;
  CatalogTemplate     :#1':';
  SchemaTemplate      :#2'.';
  ObjectTemplate      :#3;
 RequiredParts       :(False,False,False); // for informix format <catalog:schema.table>
    // call TObjectNameParser.EncodeObjectFullName( catalog='catalog', schema='', object='table')
    // returned: <catalog:table>. Informix format allows to not indicate a name of the scheme.
    // In classic version it would be impossible.
);

//=================================================================
// TEXT(CSV) DATABASE OBJECT NAME FORMAT: "FileNameWithExtension"
//=================================================================

TextMathesIndexes :array [0..5] of integer = (
   6,       // array length
   0, 0, 4, // position info for diferent parts. For accessing usage indexes: idxCatalog, idxSchema, idxObject
   2, 1     // array of object  name matches indexes
);

TextObjectNameTemplateInfo:TObjectNameTemplateInfo = (
  sRegExpr              :'^("(.*)"|.*)$';
  //                       |           |
  //                        \         /
  //                          --- ---
  //                             Y
  //                             |
  //                           object = file name with extension
  //
  QuoteTemplate       :'"'; // Quote can be redefined at runtime ...
  RegexpMathesIndexes :@TextMathesIndexes;// result position of catalog, schema, table
  FullNameTemplate    :'"'#3'"';
  CatalogTemplate     :'';
  SchemaTemplate      :'';
  ObjectTemplate      :'"'#3'"';
  RequiredParts       :(False,False,True);
);


//==================================
// DBMS ARRAY ObjectNameTemplateInfo
//==================================

DbmsObjectNameTemplateInfo : array[TDbmsType] of PObjectNameTemplateInfo = (
  nil,//eDbmsTypeUnspecified ( "nil" is equal to "@DefaultObjectNameTemplateInfo" )
  nil,//eDbmsTypeGupta
  nil,//eDbmsTypeMsSqlServer
  nil,//eDbmsTypeIbmDb2
  nil,//eDbmsTypeMySql
  nil,//eDbmsTypeMySqlMax
  nil,//eDbmsTypeMsAccess
  nil,//eDbmsTypeExcel
  @TextObjectNameTemplateInfo, //eDbmsTypeText
  nil,//eDbmsTypeDBase
  nil,//eDbmsTypeParadox
  nil,//eDbmsTypeOracle
  nil,//eDbmsTypeInterbase
  @InformixObjectNameTemplateInfo, //eDbmsTypeInformix
  nil,//eDbmsTypeSybase
  nil,//eDbmsTypeSQLLite
  nil,//eDbmsTypeThinkSQL
  nil,//eDbmsTypeSapDb
  nil,//eDbmsTypePervasiveSQL
  nil,//eDbmsTypeFlashFiler
  nil,//eDbmsTypePostgreSQL
  nil,//eDbmsTypeInterSystemCache
  nil,//eDbmsTypeFoxPro
  nil,//eDbmsTypeClipper
  nil,//eDbmsTypeBtrieve
  nil,//eDbmsTypeOpenIngres
  nil,//eDbmsTypeProgress
  nil //eDbmsTypeOterroRBase
);

implementation

{ TObjectNameParser }

constructor TObjectNameParser.Create(
  AObjectNameTemplateInfo: PObjectNameTemplateInfo;
  const DbQuote: String
);
 var vRegexpQuote :String;
     i :integer;
 const
     cRegExprSpesialSymbols = '[]\^.$*+?{},&()/|:=!';
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc(ClassName+'.'+'Create','DbQuote=<'+DbQuote+'>'); try try{$ENDIF _TRACE_CALLS_}
  if AObjectNameTemplateInfo=nil then
   begin
     fObjectNameTemplateInfo := DefaultObjectNameTemplateInfo;
     AObjectNameTemplateInfo := @DefaultObjectNameTemplateInfo;
   end
  else
   fObjectNameTemplateInfo := AObjectNameTemplateInfo^;

  if  // #0 identify template unsupported correction in runtime
      (fObjectNameTemplateInfo.QuoteTemplate <> #0) and
      (DbQuote<>#0) and
      (fObjectNameTemplateInfo.QuoteTemplate <> DbQuote)
  then
  begin

    fObjectNameTemplateInfo.QuoteTemplate := DbQuote;

    if Length(fObjectNameTemplateInfo.QuoteTemplate)>0 then
    begin
      // Replace RegExp spesial symbols
      vRegexpQuote :='';
      for i:=1 to Length(DbQuote) do
      begin
          if ( pos(DbQuote[i], cRegExprSpesialSymbols) > 0 ) then
            vRegexpQuote := vRegexpQuote + '\' + DbQuote[i]
          else
            vRegexpQuote := vRegexpQuote + DbQuote[i];
      end;

      fObjectNameTemplateInfo.sRegExpr :=
        StringReplace(
         fObjectNameTemplateInfo.sRegExpr,
         AObjectNameTemplateInfo.QuoteTemplate,
         vRegexpQuote,
         [rfReplaceAll, rfIgnoreCase]
        );
    end;

    // Updating of templates accordingly to new QuoteTemplate
    fObjectNameTemplateInfo.FullNameTemplate :=
      StringReplace(
       fObjectNameTemplateInfo.FullNameTemplate,
       AObjectNameTemplateInfo.QuoteTemplate,
       DbQuote,
       [rfReplaceAll, rfIgnoreCase]
      );

    fObjectNameTemplateInfo.CatalogTemplate :=
      StringReplace(
       fObjectNameTemplateInfo.CatalogTemplate,
       AObjectNameTemplateInfo.QuoteTemplate,
       DbQuote,
       [rfReplaceAll, rfIgnoreCase]
      );

    fObjectNameTemplateInfo.SchemaTemplate :=
      StringReplace(
       fObjectNameTemplateInfo.SchemaTemplate,
       AObjectNameTemplateInfo.QuoteTemplate,
       DbQuote,
       [rfReplaceAll, rfIgnoreCase]
      );

    fObjectNameTemplateInfo.ObjectTemplate :=
      StringReplace(
       fObjectNameTemplateInfo.ObjectTemplate,
       AObjectNameTemplateInfo.QuoteTemplate,
       DbQuote,
       [rfReplaceAll, rfIgnoreCase]
      );
  end;

  fRegExpr := TRegExpr.Create;
  fRegExpr.Expression := fObjectNameTemplateInfo.sRegExpr;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc(ClassName+'.'+'Create', e);  raise; end; end;
    finally LogExitProc(ClassName+'.'+'Create. LasError='+IntToStr(fRegExpr.LastError)); end;
  {$ENDIF _TRACE_CALLS_}
end;

destructor TObjectNameParser.Destroy;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc(ClassName+'.'+'Destroy'); try try {$ENDIF _TRACE_CALLS_}
  fRegExpr.Free;
  inherited;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc(ClassName+'.'+'Destroy', e);  raise; end; end;
    finally LogExitProc(ClassName+'.'+'Destroy'); end;
  {$ENDIF _TRACE_CALLS_}
end;

procedure TObjectNameParser.DecodeObjectFullName(
  const ObjectFullName: string;
  var CatalogName, SchemaName, ObjectName: string
);
 var
   i:integer;
   MathesIndexes:PArrayOfInteger;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc(ClassName+'.'+'DecodeObjectFullName','ObjectFullName='+ObjectFullName); try try {$ENDIF _TRACE_CALLS_}
  // Parse FullName:
  if fRegExpr.Exec(ObjectFullName) then
  begin
    MathesIndexes := PArrayOfInteger(@fObjectNameTemplateInfo.RegexpMathesIndexes);
  // Build Results:
    // CATALOG
    i := MathesIndexes^[idxCatalog];
    CatalogName := '';
    if i>0 then
    begin
       for i:=i to MathesIndexes^[idxSchema]-1 do
       begin
           if (MathesIndexes^[i]>0) and
              (MathesIndexes^[i]<=fRegExpr.SubExprMatchCount) and
              (fRegExpr.MatchPos[ MathesIndexes^[i] ]>0)
           then
           begin
               CatalogName := fRegExpr.Match[ MathesIndexes^[i] ];
               break;
           end;
       end;
    end;
    // SCHEMA
    i := MathesIndexes^[idxSchema];
    SchemaName := '';
    if i>0 then
    begin
       for i:=i to MathesIndexes^[idxObject]-1 do
       begin
           if (MathesIndexes^[i]>0) and
              (MathesIndexes^[i]<=fRegExpr.SubExprMatchCount) and
              (fRegExpr.MatchPos[ MathesIndexes^[i] ]>0)
           then
           begin
               SchemaName := fRegExpr.Match[ MathesIndexes^[i] ];
               break;
           end;
       end;
    end;
    // OBJECT
    i := MathesIndexes^[idxObject];
    ObjectName := '';
    if i>0 then
    begin
       for i:=i to (MathesIndexes^[idxLength])-1 do
       begin
           if (MathesIndexes^[i]>0) and
              (MathesIndexes^[i]<=fRegExpr.SubExprMatchCount) and
              (fRegExpr.MatchPos[ MathesIndexes^[i] ]>0)
           then
           begin
               ObjectName := fRegExpr.Match[ MathesIndexes^[i] ];
               break;
           end;
       end;
    end;
  end
  else
  begin
    CatalogName := '';
    SchemaName  := '';
    ObjectName  := ObjectFullName;
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc(ClassName+'.'+'DecodeObjectFullName', e);  raise; end; end;
    finally LogExitProc(ClassName+'.'+'DecodeObjectFullName', 'CatalogName, SchemaName, ObjectName='+CatalogName+', '+SchemaName+', '+ObjectName); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TObjectNameParser.EncodeObjectFullName(const CatalogName,
  SchemaName, ObjectName: string): string;
 var S:String;
     i:integer;
     S1,S2,S3:String;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc(ClassName+'.'+'EncodeObjectFullName','CatalogName, SchemaName, ObjectName='+CatalogName+', '+SchemaName+', '+ObjectName); try try {$ENDIF _TRACE_CALLS_}
  // Aggregation of a parts name into a full name of dbms object according to a template

  Result := fObjectNameTemplateInfo.FullNameTemplate;

  // Empty parts of templates
    //catalog:
  S1 := StringReplace(fObjectNameTemplateInfo.CatalogTemplate, #1, '', [rfIgnoreCase]);
    // schema:
  S2 := StringReplace(fObjectNameTemplateInfo.SchemaTemplate, #2, '', [rfIgnoreCase]);
    // object:
  S3 := StringReplace(fObjectNameTemplateInfo.ObjectTemplate, #3, '', [rfIgnoreCase]);

  // CATALOG:
  if Length(CatalogName)>0 then
    S := StringReplace(fObjectNameTemplateInfo.CatalogTemplate, #1, CatalogName, [rfIgnoreCase] )
  else
  if fObjectNameTemplateInfo.RequiredParts[idxCatalog] then
    S := S1
  else
    S:='';
  Result := StringReplace( Result, fObjectNameTemplateInfo.CatalogTemplate, S, [rfIgnoreCase] );

  // SCHEMA:
  if Length(SchemaName)>0 then
    S := StringReplace(fObjectNameTemplateInfo.SchemaTemplate, #2, SchemaName, [rfIgnoreCase])
  else
  if fObjectNameTemplateInfo.RequiredParts[idxSchema] then
    S := S2
   else
    S:='';
  Result := StringReplace( Result, fObjectNameTemplateInfo.SchemaTemplate, S, [rfIgnoreCase] );

  // OBJECT:
  if Length(ObjectName)>0 then
    S := StringReplace(fObjectNameTemplateInfo.ObjectTemplate, #3, ObjectName, [rfIgnoreCase])
  else
  if fObjectNameTemplateInfo.RequiredParts[idxObject] then
    S := S3
   else
     S:='';

  // Formation of a name on a template:
  Result := StringReplace( Result, fObjectNameTemplateInfo.ObjectTemplate, S, [rfIgnoreCase] );

  // Prepare result - remove leading empty parts:
  for i:=0 to 2 do
  begin
    if pos(S1, Result)=1 then
      Result := Copy( Result,
                      Length(S1)+1,
                      Length(Result)-Length(S1)
                );
    if pos(S2, Result)=1 then
      Result := Copy( Result,
                      Length(S2)+1,
                      Length(Result)-Length(S2)
                );
    if pos(S3, Result)=1 then
      Result := Copy( Result,
                      Length(S3)+1,
                      Length(Result)-Length(S3)
                );
  end;
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc(ClassName+'.'+'EncodeObjectFullName', e);  raise; end; end;
    finally LogExitProc(ClassName+'.'+'EncodeObjectFullName', 'Result='+Result); end;
  {$ENDIF _TRACE_CALLS_}
end;

function TObjectNameParser.GetQuotedObjectName(const ObjectName: string): string;
  var vCatalogName, vSchemaName, vObjectName: string;
begin
  {$IFDEF _TRACE_CALLS_} LogEnterProc(ClassName+'.'+'GetQuotedObjectName', 'ObjectName='+ObjectName); try try {$ENDIF _TRACE_CALLS_}
  // Extract of parts name from full name
  DecodeObjectFullName( ObjectName, vCatalogName, vSchemaName, vObjectName );
  // Agregate of parts name into full dbms name ...
  Result := EncodeObjectFullName( vCatalogName, vSchemaName, vObjectName );
  {$IFDEF _TRACE_CALLS_}
    except on e:exception do begin LogExceptProc(ClassName+'.'+'GetQuotedObjectName', e);  raise; end; end;
    finally LogExitProc(ClassName+'.'+'GetQuotedObjectName', 'Result='+Result); end;
  {$ENDIF _TRACE_CALLS_}
end;

end.
