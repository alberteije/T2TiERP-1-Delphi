unit rpmdexpdbf;

interface


{$I rpconf.inc}


uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
{$IFDEF USEVARIANTS}
  Variants,
{$ENDIF}
  db,dbtables, StdCtrls, ComCtrls,registry,rpmdconsts;

type
  TFRpExpDBF = class(TForm)
    Animate1: TAnimate;
    BCancelar: TButton;
    LRegCopy: TLabel;
    LCount: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BCancelarClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
    procedure AppIdle(Sender:TObject;var done:Boolean);
  public
    { Public declarations }
    numfiles:integer;
    desti:TTable;
    origen:TDataset;
    cancelar:boolean;
    maxrecords:integer;
  end;


procedure SaveToDBF(data:TDataset);
function CopyTableNoIndex(origen:TDataSet;databasename,tablename:string;tabletype:TTableType;maxrecords:integer=MAXINT):integer;
function CheckDBaseLevel(level:integer;langdriver:String):boolean;

implementation

{$R *.DFM}


procedure SaveToDBF(data:TDataset);
var
 savedialog1:TSavedialog;
begin
 savedialog1:=TSaveDialog.Create(Application);
 try
  savedialog1.Title:=SRpSelectDest;
  savedialog1.filter:=SRpDbfFiles+'|*.DBF';
  savedialog1.filename:='*.dbf';
  savedialog1.FilterIndex:=0;
  savedialog1.DefaultExt:='DBF';
  if savedialog1.execute then
   CopyTableNoIndex(data,ExtractFilePath(savedialog1.filename),ExtractFileName(savedialog1.Filename),ttdbase);
 finally
  savedialog1.free;
 end;
end;

function CopyTableNoIndex(origen:TDataSet;databasename,tablename:string;tabletype:TTableType;maxrecords:integer=MAXINT):integer;
var
 desti:TTable;
 dia:TFRpExpDBF;
 i:integer;
 anticAppidle:TIdleEvent;
begin
 desti:=TTable.Create(Application);
 try
  desti.databasename:=databasename;
  desti.tablename:=tablename;
  desti.FieldDefs.Assign(origen.fielddefs);
  for i:=0 to desti.fielddefs.count-1 do
  begin
   if desti.FieldDefs.Items[i].DataType=ftDateTime then
    desti.FieldDefs.Items[i].DataType:=ftDate;
  end;
  desti.CreateTable;
  desti.tabletype:=tabletype;
  desti.open;
  // Insertem
  anticAppidle:=Application.Onidle;
  try
   dia:=TFRpExpDBF.Create(Application);
   try
    dia.desti:=desti;
    dia.origen:=origen;
    dia.maxrecords:=maxrecords;
    application.onidle:=dia.appidle;
    dia.ShowModal;
    Result:=dia.numfiles;
   finally
    dia.free;
   end;
  finally
   application.onidle:=anticappidle;
  end;
 finally
  desti.free;
 end;
end;

procedure TFRpExpDBF.FormShow(Sender: TObject);
begin
 Animate1.Active:=True;
end;

procedure TFRpExpDBF.FormCreate(Sender: TObject);
begin
 cancelar:=false;
 Caption:=SRpProcessing;
 LRegCopy.Caption:=SrpRegCopy;
 BCancelar.Caption:=SRpCancel;
 Caption:=SRpProcessing;
end;

procedure TFRpExpDBF.BCancelarClick(Sender: TObject);
begin
 cancelar:=true;
 Close;
end;

procedure TFRpExpDBF.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
 canclose:=cancelar;
end;

procedure TFRpExpDBF.AppIdle(Sender:TObject;var done:Boolean);
var
 contador:integer;
 i:integer;
 reccount:integer;
 atablename:String;
 fileext:String;
begin
 fileext:=ExtractFileExt(Desti.TableName);
 atablename:=ChangeFileExt(Desti.TableName,'');
 numfiles:=1;
 reccount:=0;
 contador:=0;
 try
  origen.first;
  While not Origen.EOF do
  begin
   desti.insert;
   try
    for i:=0 to origen.fieldcount-1 do
    begin
     desti.fields[i].Value:=Origen.fields[i].Value;
    end;
    desti.post;
   except
    desti.cancel;
    raise;
   end;
   Application.ProcessMessages;
   if cancelar then
    Raise Exception.Create(SRpOperationAborted);
   Origen.Next;
   inc(contador);
   if (contador mod 500)=0 then
   begin
    LCount.Caption:=IntToStr(contador);
    LCount.Update;
   end;
   // numfiles
   inc(reccount);
   if reccount>maxrecords then
   begin
    reccount:=0;
    numfiles:=numfiles+1;
    Desti.Close;
    Desti.TableName:=ChangeFileExt(atablename+inttostr(numfiles),fileext);
    Desti.CreateTable;
    Desti.Open;
   end;
  end;
 finally
  cancelar:=true;
  Close;
 end;
end;


function CheckDBaseLevel(level:integer;langdriver:String):boolean;
var
 reg:TRegistry;
 akey,akey2:String;
 version,Lang:String;
begin
 Result:=false;
 reg:=TRegistry.Create;
 try
  reg.RootKey:=HKEY_LOCAL_MACHINE;
  akey:='SOFTWARE\Borland\Database Engine\Settings\DRIVERS\DBASE\INIT';
  akey2:='SOFTWARE\Borland\Database Engine\Settings\DRIVERS\DBASE\TABLE CREATE';
  if reg.OpenKeyReadOnly(akey) then
  begin
   version:=reg.ReadString('VERSION');
   lang:=reg.ReadString('LANGDRIVER');
   if version<>IntToStr(level)+'.0' then
   begin
    if ID_YES=MessageDlg(SrpChangeLevel+' - Level '
     +IntToStr(level),mtWarning,[mbYes,mbNo],0) then
    begin
     reg.CloseKey;
     if reg.OpenKey(akey,false) then
     begin
      reg.WriteString('VERSION',IntToStr(level)+'.0');
      ShowMessage(SrpReboot);
      reg.CloseKey;
      if reg.OpenKey(akey2,false) then
      begin
       reg.WriteString('VERSION',IntToStr(level));
      end;
     end;
    end;
   end
   else
    Result:=true;
   if Length(Langdriver)>0 then
   begin
    if Langdriver<>lang then
    begin
     reg.CloseKey;
     if reg.OpenKey(akey,false) then
     begin
      reg.WriteString('LANGDRIVER',langdriver);
     end;
    end;
   end;
  end;
 finally
  reg.free;
 end;
end;


end.
