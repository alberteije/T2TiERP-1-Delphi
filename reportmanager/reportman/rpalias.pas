{*******************************************************}
{                                                       }
{       Rpalias                                         }
{       TRpAlias: A component that stores relations     }
{       between a name (alias) and datasets             }
{                                                       }
{       The utility is to use the expresion evaluator   }
{       With syntax alias.field                         }
{       Report Manager                                  }
{                                                       }
{       Copyright (c) 1994-2002 Toni Martir             }
{                                                       }
{       This file is under the MPL license              }
{       If you enhace this file you must provide        }
{       source code                                     }
{                                                       }
{*******************************************************}


unit rpalias;

interface

{$I rpconf.inc}

uses SysUtils,Classes,DB,TypInfo,
{$IFDEF USEREPORTFUNC}
  rpdatainfo,
{$ENDIF}
{$IFDEF USEEVALHASH}
  rpstringhash,
{$ENDIF}
  rptypeval;
type
  // Forward definitions
  TRpAliaslist=class;
  TRpAlias=class;



  // TRpAlias component non visual component that
  // can store the list relation between aliases and
  // datasets
  TRpAlias=Class(TComponent)
   private
    Iden:TIdenField;
    FList:TRpAliaslist;
{$IFDEF USEREPORTFUNC}
    FConnections:TRpDatabaseInfoList;
    procedure SetConnections(Newconn:TRpDatabaseInfoList);
{$ENDIF}
    procedure SetList(Newlist:TRpAliaslist);
   protected
    procedure Notification(AComponent:TComponent;Operation:TOperation);override;
   public
    constructor Create(AOWner:TComponent);override;
    destructor Destroy;override;
    function searchfield(aname,datasetname:ShortString;var duplicated:Boolean):TRpIdentifier;
    procedure fillwithfields(lines:TStrings);
    function IndexOf(Dataset:TDataSet):integer;
   published
    property List:TRpAliaslist read FList write SetList;
{$IFDEF USEREPORTFUNC}
    property Connections:TRpDatabaseInfoList read FConnections write SetConnections;
{$ENDIF}
   end;


  // Item of  TRpAliaslist
  TRpAliaslistItem=class(TCollectionitem)
   private
    FDataset:TDataSet;
    FAlias:string;
    FCachedFields:Boolean;
//    FFields:TStringList;
{$IFDEF USEEVALHASH}
    FFields:TStringHash;
{$ENDIF}
{$IFNDEF USEEVALHASH}
    FFields:TStringList;
{$ENDIF}
    procedure SetAlias(NewAlias:string);
    function GetDataset:TDataSet;
    procedure SetDataset(NewDataset:TDataSet);
   public
    Constructor Create(Collection:TCollection);override;
    procedure Assign(Source:TPersistent);override;
    procedure CacheFields(Sender:TDataset);
    procedure UnCacheFields(Sender:TDataset);
    destructor Destroy;override;
   published
    property Alias:string read FAlias write SetAlias;
    property Dataset:TDataSet read GetDataset write SetDataset;
   end;

  // TRpAliaslistItem Collection
  TRpAliaslist=Class(TCollection)
   private
    FRpAlias:TRpAlias;
    function GetItem(Index:Integer):TRpAliaslistItem;
    procedure SetItem(index:integer;Value:TRpAliaslistItem);
   public
    constructor Create(RpAlias1:TRpAlias);
    function Add:TRpAliaslistItem;
    function indexof(alias:string):integer;
    property Items[index:integer]:TRpAliaslistitem read GetItem write SetItem;default;
  end;


implementation


// TRpAliaslistItem

Constructor TRpAliaslistItem.Create(Collection:TCollection);
begin
 inherited Create(Collection);
 FDataset:=nil;
 FAlias:=chr(0);
 FCachedFields:=false;
{$IFDEF USEEVALHASH}
 FFields:=TStringHash.Create;
{$ENDIF}
{$IFNDEF USEEVALHASH}
 FFields:=TStringList.Create;
 FFields.Sorted:=true;
{$ENDIF}
end;

destructor TRpAliaslistItem.Destroy;
begin
 FFields.free;
 inherited Destroy;
end;

function TRpAliaslistItem.GetDataset:TDataSet;
var aname:string;
begin
 if FDataset=nil then
 begin
  Result:=fDataset;
  Exit;
 end;
 aname:='';
 aname:=aname+FDataset.Name;
 Result:=FDataset;
end;

// When a component is removed we need to remove the reference
procedure TRpAlias.Notification(AComponent:TComponent;Operation:TOperation);
var i:integer;
begin
 inherited Notification(AComponent,Operation);
 if Operation=OpRemove then
 begin
  if (AComponent is TDataset) then
  begin
   with FList do
   begin
    for i:=0 to Count -1 do
    begin
     if items[i]<>nil then
      if Items[i].Dataset=AComponent then
       Items[i].Dataset:=nil;
    end;
   end;
  end;
 end;
end;

procedure TRpAliaslistItem.SetAlias(NewAlias:string);
begin
 if FAlias<>NewAlias then
 begin
  FAlias:=AnsiUpperCase(NewAlias);
  Changed(False);
 end;
end;

procedure TRpAliaslistItem.SetDataset(NewDataset:TDataSet);
begin
 if FDataset<>NewDataset then
 begin
  FDataset:=NewDataset;
  Changed(False);
 end;
end;

procedure TRpAliaslistItem.Assign(Source:TPersistent);
begin
 if Source is TRpAliaslistItem then
 begin
  Alias:=TRpAliaslistItem(Source).Alias;
  Dataset:=(Source As TRpAliaslistItem).Dataset;
  Exit;
 end;
 inherited Assign(Source);
end;

// TRpAliaslist

constructor TRpAliaslist.Create(RpAlias1:TRpAlias);
begin
 inherited Create(TRpAliaslistItem);
 FRpAlias:=RpAlias1;
end;

function TRpAliaslist.Add:TRpAliaslistItem;
begin
 // Then function is defined by teh class TCollectionItem
 Result:=TRpAliaslistItem(inherited Add);
end;

function TRpAliaslist.GetItem(Index:Integer):TRpAliaslistItem;
begin
 // Then function is defined by teh class TCollectionItem
 Result:=TRpAliaslistItem(inherited GetItem(index));
end;

procedure TRpAliaslist.SetItem(index:integer;Value:TRpAliaslistItem);
begin
 // Then function is defined by teh class TCollectionItem
 inherited SetItem(Index,Value);
end;

function TRpAliaslist.indexof(alias:string):integer;
var
 i:integer;
 aalias:String;
begin
 Result:=-1;
 i:=0;
 aalias:=AnsiUppercase(alias);
 While i<count do
 begin
  if items[i].alias=aalias then
  begin
   Result:=i;
   break;
  end;
  inc(i);
 end;
end;


// TRpAlias

constructor TRpAlias.Create(AOWner:TComponent);
begin
 inherited Create(AOWner);
 FList:=TRpAliaslist.Create(Self);
 Iden:=TIdenField.CreateField(Self,'');
{$IFDEF USEREPORTFUNC}
 FConnections:=TRpDatabaseInfoList.Create(Self);
{$ENDIF}
end;

destructor TRpAlias.Destroy;
begin
 FList.free;
{$IFDEF USEREPORTFUNC}
 FConnections.free;
{$ENDIF}
 inherited Destroy;
end;

procedure TRpAlias.SetList(Newlist:TRpAliaslist);
begin
 FList.Assign(Newlist);
end;

{$IFDEF USEREPORTFUNC}
procedure TRpAlias.SetConnections(Newconn:TRpDatabaseInfoList);
begin
 FConnections.Assign(Newconn);
end;
{$ENDIF}

// Seartching a field in the List
function TRpAlias.searchfield(aname,datasetname:ShortString;var duplicated:Boolean):TRpIdentifier;
var i:integer;
    found:Boolean;
    Field:TField;
    Dataset:TDataset;
    aitem:TRpAliasListItem;
{$IFNDEF USEEVALHASH}
   index:integer;
{$ENDIF}
begin
 Result:=nil;
 duplicated:=False;
 found:=False;
 if Length(datasetname)=0 then
 begin
  with List do
  begin
   for i:=0 to count-1 do
   begin
    aitem:=items[i];
    Dataset:=aitem.Dataset;
    if Dataset<>nil then
    begin
     if aitem.FCachedFields then
     begin
{$IFNDEF USEEVALHASH}
      index:=aitem.FFields.IndexOf(aname);
      if index>=0 then
       Field:=TField(aitem.FFields.Objects[index])
      else
       Field:=nil;
{$ENDIF}
{$IFDEF USEEVALHASH}
      Field:=TField(aitem.FFields.getValue(aname));
{$ENDIF}
     end
     else
      Field:=Dataset.Findfield(aname);
     if Field<>nil then
     begin
      iden.Field:=Field;
      Result:=iden;
      if found then
      begin
       duplicated:=True;
       break;
      end
      else
       found:=True;
     end;
    end;
   end;
  end;
 end
 else
 begin
  with List do
  begin
   for i:=0 to count-1 do
   begin
    aitem:=items[i];
    if (datasetname=aitem.alias) then
    begin
     Dataset:=aitem.Dataset;
     if Dataset<>nil then
     begin
      if aitem.FCachedFields then
      begin
{$IFDEF USEEVALHASH}
      Field:=TField(aitem.FFields.getValue(aname));
{$ENDIF}
{$IFNDEF USEEVALHASH}
       index:=aitem.FFields.IndexOf(aname);
       if index>=0 then
        Field:=TField(aitem.FFields.Objects[index])
       else
        Field:=nil;
{$ENDIF}
      end
      else
       Field:=Dataset.Findfield(aname);
      if Field<>nil then
      begin
       iden.Field:=Field;
       result:=iden;
       break;
      end
      else
      begin
       break;
      end;
     end;
    end;
   end;
  end;
 end;
end;



// Fills a string list with the fieldnames in a
// Aliaslist as alias.field
procedure TRpAlias.fillwithfields(lines:TStrings);
var i,j:integer;
    Dataset:TDataSet;
begin
 lines.clear;
 for i:=0 to List.Count-1 do
 begin
  Dataset:=List.items[i].Dataset;
  if Dataset<>nil then
  begin
   for j:=0 to Dataset.FieldCount-1 do
   begin
    lines.Add(List.items[i].alias+'.'+Dataset.Fields[j].fieldName);
   end;
  end;
 end;
end;

// Index of a dataset in a list
function TRpAlias.IndexOf(Dataset:TDataSet):integer;
var
 i:integer;
 found:Boolean;
begin
 i:=0;
 found:=False;
 While i<List.Count do
 begin
  if List.items[i].Dataset=Dataset then
  begin
   found:=true;
   break;
  end;
  Inc(i);
 end;
 if found then
  Result:=i
 else
  Result:=-1;
end;

procedure TRpAliaslistItem.CacheFields(Sender:TDataset);
var
 i:integer;
begin
 if Not Assigned(Sender) then
  exit;
 FCachedFields:=true;
 FFields.clear;
 for i:=0 to Sender.Fields.Count-1 do
 begin
{$IFNDEF USEEVALHASH}
  FFields.AddObject(AnsiUpperCase(Sender.Fields[i].FieldName),Sender.Fields[i]);
{$ENDIF}
{$IFDEF USEEVALHASH}
  FFields.setValue(AnsiUpperCase(Sender.Fields[i].FieldName),Sender.Fields[i]);
{$ENDIF}
 end;
end;

procedure TRpAliaslistItem.UnCacheFields(Sender:TDataset);
begin
 FCachedFields:=false;
 FFields.clear;
end;

end.
