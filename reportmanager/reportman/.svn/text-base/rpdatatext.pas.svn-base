{*******************************************************}
{                                                       }
{       Report Manager                                  }
{                                                       }
{       Rpdatatext                                      }
{       Driver for reading text files                   }
{       common components of Report manager             }
{                                                       }
{                                                       }
{       Copyright (c) 1994-2003 Toni Martir             }
{       toni@pala.com                                   }
{                                                       }
{       This file is under the MPL license              }
{       If you enhace this file you must provide        }
{       source code                                     }
{                                                       }
{                                                       }
{*******************************************************}

unit rpdatatext;

interface

{$I rpconf.inc}

uses
 Sysutils,IniFiles,rpmdshfolder,Classes,rptypes,
{$IFDEF USEVARIANTS}
 Variants,Types,
{$ENDIF}
 DB,
{$IFDEF USERPDATASET}
 {$IFNDEF FPC}
 DBClient,
 {$ENDIF}
 {$IFDEF FPC}
 memds,
 {$ENDIF}
{$ENDIF}
 rpmdconsts;

type
 TRpFieldobj=class(TObject)
  public
   fieldname:String;
   posbegin:Integer;
   fieldsize:Integer;
   precision:integer;
   posbeginprecision:integer;
   fieldtype:TFieldType;
   fieldtrim:Boolean;
   yearpos:Integer;
   yearsize:Integer;
   monthpos:Integer;
   monthsize:Integer;
   daypos:Integer;
   daysize:Integer;
   hourpos:Integer;
   hoursize:Integer;
   minpos:Integer;
   minsize:Integer;
   secpos:Integer;
   secsize:Integer;
  end;

{$IFDEF USERPDATASET}
{$IFDEF FPC}
procedure FillClientDatasetFromFile(data:TMemDataSet;fieldsfile:String;
 textfilename:String;IndexFields:String);
{$ENDIF}
{$IFNDEF FPC}
procedure FillClientDatasetFromFile(data:TClientDataSet;fieldsfile:String;
 textfilename:String;IndexFields:String);
{$ENDIF}
{$ENDIF}
procedure FillFieldObjList(fieldsfile:String;
 lfields:TStringList;
 var recordseparator:char;
 var ignoreafterrecordseparator:char);
procedure FreeFieldObjList(lfields:TStringList);
procedure SaveFieldObjListToFile(lfields:TStringList;fieldsfile:String;
 recordseparator:char;
 ignoreafterrecordseparator:char);


implementation


// Reads the field definition file as a TInifile
// Creates the client dataset and fill with information
// in the file

procedure SaveFieldObjListToFile(lfields:TStringList;fieldsfile:String;
 recordseparator:char;
 ignoreafterrecordseparator:char);
var
 fobj:TRpFieldObj;
 ffile:TInifile;
 i:integer;
begin
 ffile:=TInifile.Create(fieldsfile);
 try
  ffile.WriteInteger('RECORDCONFIG','RECORDSEPARATOR',Ord(recordseparator));
  ffile.WriteInteger('RECORDCONFIG','IGNORERECORDSEPARATOR',Ord(ignoreafterrecordseparator));
  ffile.WriteInteger('RECORDCONFIG','FIELDCOUNT',lfields.count);
  for i:=1 to lfields.count do
  begin
   fobj:=TRpFieldObj(lfields.Objects[i-1]);
   ffile.WriteString('FIELD'+IntToStr(i),'FIELDNAME',fobj.fieldname);
   ffile.WriteInteger('FIELD'+IntToStr(i),'BEGINPOSITION',fobj.posbegin);
   ffile.WriteInteger('FIELD'+IntToStr(i),'SIZE',fobj.fieldsize);
   ffile.WriteBool('FIELD'+IntToStr(i),'TRIM',fobj.fieldtrim);
   ffile.WriteInteger('FIELD'+IntToStr(i),'DATATYPE',Integer(fobj.fieldtype));
   ffile.WriteInteger('FIELD'+IntToStr(i),'BEGINPRECISION',fobj.posbeginprecision);
   ffile.WriteInteger('FIELD'+IntToStr(i),'YEARPOS',fobj.yearpos);
   ffile.WriteInteger('FIELD'+IntToStr(i),'YEARSIZE',fobj.yearsize);
   ffile.WriteInteger('FIELD'+IntToStr(i),'MONTHPOS',fobj.monthpos);
   ffile.WriteInteger('FIELD'+IntToStr(i),'MONTHSIZE',fobj.monthsize);
   ffile.WriteInteger('FIELD'+IntToStr(i),'DAYPOS',fobj.daypos);
   ffile.WriteInteger('FIELD'+IntToStr(i),'DAYSIZE',fobj.daysize);
   ffile.WriteInteger('FIELD'+IntToStr(i),'HOURPOS',fobj.hourpos);
   ffile.WriteInteger('FIELD'+IntToStr(i),'HOURSIZE',fobj.hoursize);
   ffile.WriteInteger('FIELD'+IntToStr(i),'MINPOS',fobj.minpos);
   ffile.WriteInteger('FIELD'+IntToStr(i),'MINSIZE',fobj.minsize);
   ffile.WriteInteger('FIELD'+IntToStr(i),'SECPOS',fobj.secpos);
   ffile.WriteInteger('FIELD'+IntToStr(i),'SECSIZE',fobj.secsize);
  end;

  ffile.UpdateFile;
 finally
  ffile.free;
 end;
end;

procedure FillFieldObjList(fieldsfile:String;
 lfields:TStringList;
 var recordseparator:char;
 var ignoreafterrecordseparator:char);
var
 fobj:TRpFieldObj;
 fieldcount:integer;
 i:integer;
 ffile:TInifile;
begin
 ffile:=TInifile.Create(fieldsfile);
 try
  recordseparator:=chr(ffile.ReadInteger('RECORDCONFIG','RECORDSEPARATOR',10));
  ignoreafterrecordseparator:=chr(ffile.ReadInteger('RECORDCONFIG','IGNORERECORDSEPARATOR',13));
  fieldcount:=ffile.ReadInteger('RECORDCONFIG','FIELDCOUNT',1);
  if fieldcount<=0 then
   fieldcount:=1;
  for i:=1 to fieldcount do
  begin
   fobj:=TRpFieldObj.Create;
   lfields.AddObject('FIELD'+IntToStr(i),fobj);
   fobj.fieldname:=ffile.ReadString('FIELD'+IntToStr(i),'FIELDNAME','FIELD'+IntToStr(i));
   fobj.posbegin:=ffile.ReadInteger('FIELD'+IntToStr(i),'BEGINPOSITION',1);
   fobj.fieldsize:=ffile.ReadInteger('FIELD'+IntToStr(i),'SIZE',0);
   fobj.fieldtrim:=ffile.ReadBool('FIELD'+IntToStr(i),'TRIM',true);
   fobj.fieldtype:=TFieldType(ffile.ReadInteger('FIELD'+IntToStr(i),'DATATYPE',Integer(ftMemo)));
   fobj.posbeginprecision:=ffile.ReadInteger('FIELD'+IntToStr(i),'BEGINPRECISION',0);
   fobj.yearpos:=ffile.ReadInteger('FIELD'+IntToStr(i),'YEARPOS',0);
   fobj.yearsize:=ffile.ReadInteger('FIELD'+IntToStr(i),'YEARSIZE',0);
   fobj.monthpos:=ffile.ReadInteger('FIELD'+IntToStr(i),'MONTHPOS',0);
   fobj.monthsize:=ffile.ReadInteger('FIELD'+IntToStr(i),'MONTHSIZE',0);
   fobj.daypos:=ffile.ReadInteger('FIELD'+IntToStr(i),'DAYPOS',0);
   fobj.daysize:=ffile.ReadInteger('FIELD'+IntToStr(i),'DAYSIZE',0);
   fobj.hourpos:=ffile.ReadInteger('FIELD'+IntToStr(i),'HOURPOS',0);
   fobj.hoursize:=ffile.ReadInteger('FIELD'+IntToStr(i),'HOURSIZE',0);
   fobj.minpos:=ffile.ReadInteger('FIELD'+IntToStr(i),'MINPOS',0);
   fobj.minsize:=ffile.ReadInteger('FIELD'+IntToStr(i),'MINSIZE',0);
   fobj.secpos:=ffile.ReadInteger('FIELD'+IntToStr(i),'SECPOS',0);
   fobj.secsize:=ffile.ReadInteger('FIELD'+IntToStr(i),'SECSIZE',0);
  end;
 finally
  ffile.free;
 end;
end;

procedure FreeFieldObjList(lfields:TStringList);
var
 i:integer;
begin
 for i:=0 to lfields.count-1 do
 begin
  lfields.Objects[i].free;
 end;
end;


{$IFDEF USERPDATASET}
procedure FillFieldsFromLine(fieldsep,fieldenc:char;line:string;fields:TStringList);
var
 afield:string;
 achar:char;
 process:Boolean;
begin
 while Length(line)>0 do
 begin
  afield:='';
  while Length(line)>0 do
  begin
   achar:=line[1];
   line:=Copy(line,2,Length(line));
   if achar=fieldenc then
    break;
  end;
  process:=true;
  if Length(line)>0 then
  begin
   achar:=line[1];
   if achar=fieldenc then
    process:=false;
  end;
  if process then
  while Length(line)>0 do
  begin
   achar:=line[1];
   line:=Copy(line,2,Length(line));
   if achar<>fieldenc then
   begin
    afield:=afield+achar;
   end
   else
   begin
    if Length(line)>0 then
    begin
     if line[1]=fieldenc then
     begin
      line:=Copy(line,2,Length(line));
      afield:=afield+achar;
     end
     else
     begin
      break;
     end;
    end;
   end;
  end;
  fields.Add(afield);
  while Length(line)>0 do
  begin
   achar:=line[1];
   line:=Copy(line,2,Length(line));
   if achar=fieldsep then
    break;
  end;
 end;
end;

{$IFDEF FPC}
procedure FillDatasetFromSeparated(data:TMemDataset;textfilename:String;indexfields:string);
{$ENDIF}
{$IFNDEF FPC}
procedure FillDatasetFromSeparated(data:TClientDataset;textfilename:String;indexfields:string);
{$ENDIF}
var
 memstream:TMemoryStream;
 buf:array of Byte;
 line,oldline:string;
 position:integer;
 recorddone:boolean;
 readed:integer;
 recordseparator:char;
 ignoreafterrecordseparator:char;
 fieldsep:char;
 fieldenc:char;
 cuenta,i:integer;
 fields:TStringList;
begin
 fieldsep:=',';
 fieldenc:='"';
 cuenta:=1;
 recordseparator:=#10;
 ignoreafterrecordseparator:=#13;
 data.FieldDefs.Clear;
 data.FieldDefs.Add('LNUMBER',ftInteger,0,false);
 // parse first line to get number of fields
 fields:=TStringList.Create;
 try
  // Load the file inside the dataset
  memstream:=TMemoryStream.Create;
  try
   memstream.LoadFromFile(textfilename);
   memstream.Seek(0,soFromBeginning);
   SetLength(buf,1);
   line:='';
   oldline:='';
   position:=0;
   recorddone:=false;
   while position<memstream.Size do
   begin
    while position<memstream.Size do
    begin
     readed:=memstream.Read(buf[0],1);
     position:=position+readed;
     if readed=0 then
      break;
     if Char(buf[0])=recordseparator then
     begin
      recorddone:=true;
      oldline:='';
      // Ignore after record chars
      while position<memstream.Size do
      begin
       readed:=memstream.Read(buf[0],1);
       position:=position+readed;
       if readed=0 then
        break;
       if Char(buf[0])<>ignoreafterrecordseparator then
       begin
        oldline:=char(buf[0]);
        break;
       end;
      end;
     end
     else
      line:=line+char(buf[0]);
     if recorddone then
     begin
      recorddone:=false;
      break;
     end;
    end;
//    if Length(line)>0 then
    begin
     fields.clear;
     FillFieldsFromLine(fieldsep,fieldenc,line,fields);
     if not data.Active then
     begin
      for i:=0 to fields.count-1 do
      begin
       data.FieldDefs.Add('FIELD'+IntToStr(i+1),ftString,255,false);
      end;
{$IFNDEF FPC}
      if Length(Trim(IndexFields))<1 then
      begin
       data.IndexDefs.Clear;
       data.IndexDefs.Add('IPRIMINDEX','LNUMBER',[]);
       data.IndexFieldNames:='LNUMBER';
      end
      else
      begin
       data.IndexDefs.Clear;
       data.IndexDefs.Add('IPRIMINDEX',IndexFields,[]);
       data.IndexFieldNames:=IndexFields;
      end;
      data.CreateDataSet;
{$ENDIF}
{$IFDEF FPC}
      data.CreateTable;
{$ENDIF}
     end;
     data.Append;
     try
      data.FieldByName('LNUMBER').Value:=cuenta;
      for i:=0 to fields.count-1 do
      begin
       if i<data.fields.Count-1 then
       begin
        data.FieldByName('FIELD'+IntToStr(i+1)).AsString:=fields.Strings[i];
       end
       else
        break;
      end;
      data.post;
     except
      data.cancel;
      raise;
     end;
     inc(cuenta);
     line:=oldline;
    end;
   end;
  finally
   memstream.free;
  end;
 finally
  fields.free;
 end;
end;


{$IFDEF FPC}
procedure FillClientDatasetFromFile(data:TMemDataSet;fieldsfile:String;textfilename:String;indexfields:String);
{$ENDIF}
{$IFNDEF FPC}
procedure FillClientDatasetFromFile(data:TClientDataSet;fieldsfile:String;textfilename:String;indexfields:String);
{$ENDIF}
var
 recordseparator:char;
 ignoreafterrecordseparator:char;
 lfields:TStringList;
 fobj:TRpFieldObj;
 i:integer;
 fdef:TFieldDef;
 line,oldline,precision:String;
 memstream:TMemoryStream;
 position,readed:LongInt;
 fieldvalue:Variant;
 buf:array of Byte;
 reccount:integer;
 recorddone:boolean;
 ayear,amonth,aday:Word;
 ahour,amin,asec:Word;
begin
 data.Close;
 data.fielddefs.Clear;
 lfields:=TStringList.Create;
 try
  if Copy(fieldsfile,1,1)=',' then
  begin
   FillDatasetFromSeparated(data,textfilename,IndexFields);
  end
  else
  begin
   FillFieldObjList(fieldsfile,lfields,recordseparator,ignoreafterrecordseparator);
   fdef:=data.FieldDefs.AddFieldDef;
   fdef.Name:='LNUMBER';
   fdef.DataType:=ftInteger;
   for i:=0 to lfields.Count-1 do
   begin
    fobj:=TRpFieldobj(lfields.Objects[i]);
    fdef:=data.FieldDefs.AddFieldDef;
    fdef.Name:=fobj.fieldname;
    fdef.DataType:=fobj.fieldtype;
    if fobj.fieldsize>0 then
     fdef.Size:=fobj.fieldsize;
    fdef.Precision:=fobj.Precision;
   end;
{$IFNDEF FPC}
   if Length(Trim(IndexFields))<1 then
   begin
    data.IndexDefs.Clear;
    data.IndexDefs.Add('IPRIMINDEX','LNUMBER',[]);
    data.IndexFieldNames:='LNUMBER';
   end
   else
   begin
    data.IndexDefs.Clear;
    data.IndexDefs.Add('IPRIMINDEX',IndexFields,[]);
    data.IndexFieldNames:=IndexFields;
   end;
   data.CreateDataSet;
{$ENDIF}
{$IFDEF FPC}
   data.CreateTable;
{$ENDIF}
   reccount:=0;
   // Load the file inside the dataset
   memstream:=TMemoryStream.Create;
   try
    memstream.LoadFromFile(textfilename);
    memstream.Seek(0,soFromBeginning);
    SetLength(buf,1);
    line:='';
    oldline:='';
    position:=0;
    recorddone:=false;
    while position<memstream.Size do
    begin
     while position<memstream.Size do
     begin
      readed:=memstream.Read(buf[0],1);
      position:=position+readed;
      if readed=0 then
       break;
      if Char(buf[0])=recordseparator then
      begin
       recorddone:=true;
       oldline:='';
       // Ignore after record chars
       while position<memstream.Size do
       begin
        readed:=memstream.Read(buf[0],1);
        position:=position+readed;
        if readed=0 then
         break;
        if Char(buf[0])<>ignoreafterrecordseparator then
        begin
         oldline:=char(buf[0]);
         break;
        end;
       end;
      end
      else
       line:=line+char(buf[0]);
      if recorddone then
      begin
       recorddone:=false;
       break;
      end;
     end;
     if Length(line)>0 then
     begin
      // Add a record
      data.Append;
      try
       for i:=0 to lfields.count-1 do
       begin
        fobj:=TRpFieldobj(lfields.Objects[i]);
        // Reads the field
        fieldvalue:=Null;
        case fobj.fieldtype of
         ftInteger:
          begin
           if fobj.fieldsize=0 then
            fieldvalue:=Copy(line,fobj.posbegin,Length(line))
           else
            fieldvalue:=Copy(line,fobj.posbegin,fobj.fieldsize);
           if fobj.fieldtrim then
            fieldvalue:=Trim(string(fieldvalue));
           if Length(fieldvalue)<1 then
            fieldvalue:=Null
           else
            fieldvalue:=StrToInt(fieldvalue);
          end;
         ftString,ftMemo:
          begin
           if fobj.fieldsize=0 then
            fieldvalue:=Copy(line,fobj.posbegin,Length(line))
           else
            fieldvalue:=Copy(line,fobj.posbegin,fobj.fieldsize);
           if fobj.fieldtrim then
            fieldvalue:=Trim(string(fieldvalue));
           if Length(fieldvalue)<1 then
             fieldvalue:=Null;
          end;
         ftBoolean:
          begin
           if fobj.fieldsize=0 then
            fieldvalue:=Copy(line,fobj.posbegin,Length(line))
           else
            fieldvalue:=Copy(line,fobj.posbegin,fobj.fieldsize);
           if fobj.fieldtrim then
            fieldvalue:=Trim(string(fieldvalue));
           if Length(fieldvalue)<1 then
             fieldvalue:=Null
           else
            fieldvalue:=StrToBool(fieldvalue);
          end;
         ftCurrency:
          begin
           if fobj.fieldsize=0 then
            fieldvalue:=Copy(line,fobj.posbegin,Length(line))
           else
            fieldvalue:=Copy(line,fobj.posbegin,fobj.fieldsize);
           if fobj.fieldtrim then
            fieldvalue:=Trim(string(fieldvalue));
           if Length(fieldvalue)<1 then
            fieldvalue:=Null
           else
            fieldvalue:=StrToCurr(fieldvalue);
           if Not VarIsNull(fieldvalue) then
           begin
            if fobj.posbeginprecision>0 then
             if fobj.precision>0 then
             begin
              precision:=Trim(Copy(line,fobj.posbeginprecision,fobj.precision));
              if Length(precision)>0 then
               fieldvalue:=fieldvalue+StrToCurr('0'+decimalseparator+precision);
             end;
           end;
          end;
         ftDate:
          begin
           try
            ayear:=StrToInt(Copy(line,fobj.yearpos,fobj.yearsize));
            amonth:=StrToInt(Copy(line,fobj.monthpos,fobj.monthsize));
            aday:=StrToInt(Copy(line,fobj.daypos,fobj.daysize));
            fieldvalue:=EncodeDate(ayear,amonth,aday);
           except
            fieldvalue:=Null;
           end;
          end;
         ftTime:
          begin
           try
            ahour:=StrToInt(Copy(line,fobj.yearpos,fobj.hoursize));
            amin:=StrToInt(Copy(line,fobj.monthpos,fobj.minsize));
            asec:=StrToInt(Copy(line,fobj.yearpos,fobj.secsize));
            fieldvalue:=EncodeTime(ahour,amin,asec,0);
           except
            fieldvalue:=Null;
           end;
          end;
         ftDateTime:
          begin
           try
            ayear:=StrToInt(Copy(line,fobj.yearpos,fobj.yearsize));
            amonth:=StrToInt(Copy(line,fobj.monthpos,fobj.monthsize));
            aday:=StrToInt(Copy(line,fobj.daypos,fobj.daysize));
            ahour:=StrToInt(Copy(line,fobj.yearpos,fobj.hoursize));
            amin:=StrToInt(Copy(line,fobj.monthpos,fobj.minsize));
            asec:=StrToInt(Copy(line,fobj.yearpos,fobj.secsize));
            fieldvalue:=EncodeDate(ayear,amonth,aday);
            fieldvalue:=fieldvalue+EncodeTime(ahour,amin,asec,0);
           except
            fieldvalue:=Null;
           end;
          end;
        end;
        data.FieldByName(fobj.fieldname).AsVariant:=fieldvalue;
       end;
       inc(reccount);
       data.FieldByName('LNUMBER').Value:=reccount;
       data.post;
      except
       data.cancel;
       raise;
      end;
     end;
     line:=oldline;
    end;
   finally
    memstream.free;
   end;
  end;
 finally
  FreeFieldObjList(lfields);
  lfields.free;
 end;
 data.first;
end;
{$ENDIF}

end.
