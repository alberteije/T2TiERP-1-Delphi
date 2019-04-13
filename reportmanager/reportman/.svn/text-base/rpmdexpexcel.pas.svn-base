unit rpmdexpexcel;

interface


{$I rpconf.inc}


uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
{$IFDEF USEVARIANTS}
  Variants,
{$ENDIF}
  db,StdCtrls, ComCtrls,rpmdconsts,comobj;

type
  TFRpExpExcel = class(TForm)
    Animate1: TAnimate;
    BCancelar: TButton;
    LRegCopy: TLabel;
    LCount: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BCancelarClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    procedure AppIdle(Sender:TObject;var done:Boolean);
  public
    { Public declarations }
    Columnas:TStringList;
    numfiles:integer;
    origen:TDataset;
    desti:string;
    cancelar:boolean;
    maxrecords:integer;
  end;


procedure SaveToExcel(data:TDataset);
function ExportDatasetExcel(origen:TDataSet;filename:string;maxrecords:integer=MAXINT):integer;

implementation

{$R *.DFM}


procedure SaveToExcel(data:TDataset);
var
 savedialog1:TSavedialog;
begin
 savedialog1:=TSaveDialog.Create(Application);
 try
  savedialog1.Title:=SRpSelectDest;
  savedialog1.filter:=SRpExcelFiles+'|*.xls';
  savedialog1.filename:='*.xls';
  savedialog1.FilterIndex:=0;
  savedialog1.DefaultExt:='XLS';
  if savedialog1.execute then
   ExportDatasetExcel(data,savedialog1.Filename);
 finally
  savedialog1.free;
 end;
end;

function ExportDatasetExcel(origen:TDataSet;filename:string;maxrecords:integer=MAXINT):integer;
var
 dia:TFRpExpExcel;
 anticAppidle:TIdleEvent;
begin
 // Insertem
 anticAppidle:=Application.Onidle;
 try
  dia:=TFRpExpExcel.Create(Application);
  try
   dia.desti:=filename;
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
end;

procedure TFRpExpExcel.FormShow(Sender: TObject);
begin
 Animate1.Active:=True;
end;

procedure TFRpExpExcel.FormCreate(Sender: TObject);
begin
 cancelar:=false;
 LRegCopy.Caption:=SrpRegCopy;
 BCancelar.Caption:=SRpCancel;
 Caption:=SRpProcessing;
 columnas:=TStringList.Create;
end;

procedure TFRpExpExcel.BCancelarClick(Sender: TObject);
begin
 cancelar:=true;
 Close;
end;

procedure TFRpExpExcel.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
 canclose:=cancelar;
end;

procedure TFRpExpExcel.AppIdle(Sender:TObject;var done:Boolean);
var
 contador:integer;
 i:integer;
 reccount:integer;
 excel:Variant;
 wb,sh:Variant;
 fila:integer;
 c,k:char;
 olddec:char;
begin
 olddec:=DecimalSeparator;
 excel:=CreateOleObject('Excel.Application');
 try
  DecimalSeparator:='.';
  contador:=0;
  for c:='A' to 'Z' do
  begin
   columnas.Add(c+'');
   inc(contador);
  end;
  for c:='A' to 'Z' do
  begin
   for k:='A' to 'Z' do
   begin
    columnas.Add(''+c+k);
    inc(contador);
    if contador>origen.FieldCount then
     break;
   end;
  end;
  wb:=excel.Workbooks.Add;
  sh:=wb.Sheets[1];
  numfiles:=1;
  reccount:=0;
  contador:=0;
  fila:=1;
  origen.first;
  for i:=0 to origen.fieldcount-1 do
  begin
   sh.Cells[fila,columnas[i]]:=Origen.fields[i].DisplayLabel;
  end;
  inc(fila);
  While not Origen.EOF do
  begin
   for i:=0 to origen.fieldcount-1 do
   begin
    if (Origen.Fields[i].DataType in [ftString,ftWideString]) then
     sh.Cells[fila,columnas[i]]:=''''+Origen.fields[i].AsString
    else
     sh.Cells[fila,columnas[i]]:=Origen.fields[i].AsString;
   end;
   Application.ProcessMessages;
   if cancelar then
    Raise Exception.Create(SRpOperationAborted);
   Origen.Next;
   inc(fila);
   inc(contador);
   LCount.Caption:=IntToStr(contador);
   LCount.Update;
   // numfiles
   inc(reccount);
   if reccount>maxrecords then
   begin
    sh:=wb.Sheets.Add;
    fila:=1;
    origen.first;
    for i:=0 to origen.fieldcount-1 do
    begin
     sh.Cells[fila,columnas[i]]:=Origen.fields[i].DisplayLabel;
    end;
    inc(fila);
    reccount:=0;
    numfiles:=numfiles+1;
   end;
  end;
  wb.SaveAs(desti);
 finally
  DecimalSeparator:=olddec;
  cancelar:=true;
  Close;
  excel.Quit;
 end;
end;


procedure TFRpExpExcel.FormDestroy(Sender: TObject);
begin
 columnas.free;
end;

end.
