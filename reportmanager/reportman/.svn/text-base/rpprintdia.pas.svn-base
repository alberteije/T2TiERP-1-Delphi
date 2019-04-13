{*******************************************************}
{                                                       }
{       Report Manager Designer                         }
{                                                       }
{       rpprintdia                                      }
{       Form for selecting ranges of pages to print     }
{       number of copies and collate                    }
{                                                       }
{                                                       }
{                                                       }
{       Copyright (c) 1994-2002 Toni Martir             }
{                                                       }
{       This file is under the MPL license              }
{       If you enhace this file you must provide        }
{       source code                                     }
{                                                       }
{*******************************************************}

unit rpprintdia;

interface

uses SysUtils, Classes, QGraphics, QForms, QControls, QStdCtrls,
  QButtons, QExtCtrls,QPrinters,Qt, QImgList,Types,rpmdconsts;

type
  TFRpPrintDialog = class(TForm)
    BOK: TButton;
    BCancel: TButton;
    LPrinter: TLabel;
    ComboPrinters: TComboBox;
    LOutput: TLabel;
    LPrinterDevice: TLabel;
    Label3: TLabel;
    ComboOutputType: TComboBox;
    LFilename: TLabel;
    LProgram: TLabel;
    LPort: TLabel;
    EPort: TEdit;
    EProgram: TEdit;
    EFilename: TEdit;
    RPages: TRadioGroup;
    LFrom: TLabel;
    EFrom: TEdit;
    LTo: TLabel;
    ETo: TEdit;
    GCopies: TGroupBox;
    LCopies: TLabel;
    ECopies: TEdit;
    CheckCollate: TCheckBox;
    ImageList1: TImageList;
    Image1: TImage;
    procedure FormCreate(Sender: TObject);
    procedure BOKClick(Sender: TObject);
    procedure ComboPrintersChange(Sender: TObject);
    procedure ComboOutputTypeChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RPagesClick(Sender: TObject);
    procedure CheckCollateClick(Sender: TObject);
  private
    { Private declarations }
    allpages,collate:boolean;
    frompage,topage,copies:integer;
  public
    { Public declarations }
    dook:boolean;
  end;


function DoShowPrintDialog(var allpages:boolean;
 var frompage,topage,copies:integer;var collate:boolean;disablecopies:boolean=false):boolean;

implementation

{$R *.xfm}

function DoShowPrintDialog(var allpages:boolean;
 var frompage,topage,copies:integer;var collate:boolean;disablecopies:boolean=false):boolean;
var
 dia:TFRpPrintDialog;
begin
 Result:=False;
 dia:=TFRpPrintDialog.Create(Application);
 try
  dia.allpages:=allpages;
  dia.collate:=collate;
  dia.copies:=copies;
  dia.frompage:=frompage;
  dia.topage:=topage;
  if disablecopies then
  begin
   dia.GCopies.Visible:=false;
   dia.LFilename.Visible:=false;
   dia.ComboPrinters.Visible:=false;
   dia.LFrom.Visible:=false;
   dia.LTo.Visible:=false;
   dia.LPrinterDevice.Visible:=false;
  end;
  dia.ShowModal;
  if dia.dook then
  begin
   allpages:=dia.allpages;
   collate:=dia.collate;
   copies:=dia.copies;
   frompage:=dia.frompage;
   topage:=dia.topage;
   Result:=True;
  end;
 finally
  dia.free;
 end;
end;


procedure TFRpPrintDialog.FormCreate(Sender: TObject);
var
 abuffer:widestring;
 bitmap:TBitmap;
begin
 SetLength(abuffer,500);
 ComboPrinters.Items.Assign(Printer.Printers);
 QPrinter_printerName(QPrinterH(Printer.Handle),@abuffer);
 LPrinterDevice.Caption:=abuffer;
 // If there is no printer selected, selects one
 if Printer.Printers.Count>0 then
 begin
  if Length(LPrinterDevice.Caption)<1 then
  begin
   Printer.SetPrinter(Printer.Printers.Strings[0]);
   QPrinter_printerName(QPrinterH(Printer.Handle),@abuffer);
   LPrinterDevice.Caption:=abuffer;
  end;
 end;
 ComboPrinters.ItemIndex:=Printer.Printers.Indexof(LPrinterDevice.Caption);
 LPrinterDevice.Font.Style:=[fsBold];
 ComboOutputType.ItemIndex:=Integer(Printer.OutPutType);
 ComboOutPutTypeChange(Self);
 bitmap:=TBitmap.Create;
 Bitmap.PixelFormat:=pf32bit;
 Bitmap.Width:=Image1.Width;
 Bitmap.Height:=Image1.height;

 Image1.Picture.Bitmap:=bitmap;

 BOK.Caption:=TranslateStr(93,BOK.Caption);
 BCancel.Caption:=TranslateStr(94,BCancel.Caption);
 RPages.Caption:=TranslateStr(254,RPages.Caption);
 LFrom.Caption:=TranslateStr(255,LFrom.Caption);
 LTo.Caption:=TranslateStr(256,LTo.Caption);
 RPages.Items.Strings[0]:=TranslateStr(257,RPages.Items.Strings[0]);
 RPages.Items.Strings[1]:=TranslateStr(258,RPages.Items.Strings[1]);
 Caption:=TranslateStr(259,Caption);
 LPrinter.Caption:=TranslateStr(260,LPrinter.Caption);
 LOutput.Caption:=TranslateStr(261,LOutput.Caption);
 LCopies.Caption:=TranslateStr(108,LCopies.Caption);
 CheckCollate.Caption:=TranslateStr(109,CheckCollate.Caption);


 SetInitialBounds;
end;

procedure TFRpPrintDialog.BOKClick(Sender: TObject);
var
 astring:WideString;
 acopies:integer;
begin
 collate:=CheckCollate.Checked;
 acopies:=StrToInt(ECopies.Text);
 if acopies<=0 then
  acopies:=1;
 copies:=acopies;
 allpages:=RPages.Itemindex=0;
 frompage:=StrToInt(EFrom.Text);
 topage:=StrToInt(ETo.Text);
 if frompage<=0 then
  frompage:=1;
 if topage<frompage then
  topage:=frompage;
 if ComboPrinters.Itemindex>=0 then
 begin
  Printer.SetPrinter(ComboPrinters.Items.Strings[ComboPrinters.Itemindex]);
  astring:='';
  case TOutputType(ComboOutputType.Itemindex) of
   otProgram:
    begin
     astring:=EProgram.Text;
     Printer.PrintAdapter.SetOutput(TOutPutType(ComboOutputType.ItemIndex),astring);
    end;
   otFileName:
    begin
     astring:=EFilename.Text;
     Printer.PrintAdapter.SetOutput(TOutPutType(ComboOutputType.ItemIndex),astring);
    end;
   otPort:
    begin
     astring:=EPort.Text;
     Printer.PrintAdapter.SetOutput(TOutPutType(ComboOutputType.ItemIndex),astring);
    end;
  end;
 end;
 dook:=true;
 close;
end;

procedure TFRpPrintDialog.ComboPrintersChange(Sender: TObject);
begin
 Printer.SetPrinter(ComboPrinters.Items.Strings[ComboPrinters.Itemindex]);
 LPrinterDevice.Caption:=Printer.OutputDevice;
 ComboOutputType.ItemIndex:=Integer(Printer.OutPutType);
 ComboOutputTypeChange(Self);
end;

procedure TFRpPrintDialog.ComboOutputTypeChange(Sender: TObject);
begin
 case TOutputType(ComboOutputType.Itemindex) of
  otPrinter:
   begin
    LFilename.Visible:=false;
    EFilename.Visible:=false;
    LPort.Visible:=false;
    EPort.Visible:=false;
    LProgram.Visible:=false;
    EProgram.Visible:=false;
   end;
  otProgram:
   begin
    LFilename.Visible:=false;
    EFilename.Visible:=false;
    LPort.Visible:=false;
    EPort.Visible:=false;
    LProgram.Visible:=true;
    EProgram.Visible:=true;
   end;
  otFileName:
   begin
    LFilename.Visible:=true;
    EFilename.Visible:=true;
    LPort.Visible:=false;
    EPort.Visible:=false;
    LProgram.Visible:=false;
    EProgram.Visible:=false;
   end;
  otPort:
   begin
    LFilename.Visible:=false;
    EFilename.Visible:=false;
    LPort.Visible:=true;
    EPort.Visible:=true;
    LProgram.Visible:=false;
    EProgram.Visible:=false;
   end;
  otCustom:
   begin
    LFilename.Visible:=false;
    EFilename.Visible:=false;
    LPort.Visible:=false;
    EPort.Visible:=false;
    LProgram.Visible:=false;
    EProgram.Visible:=false;
   end;
 end;
end;

procedure TFRpPrintDialog.FormShow(Sender: TObject);
begin
 // Set default values
 if allpages then
  RPages.Itemindex:=0
 else
  RPages.Itemindex:=1;
 RPAgesClick(Self);
 EFrom.Text:=IntToStr(frompage);
 ETo.Text:=IntToStr(topage);
 ECopies.Text:=IntToStr(copies);
 CheckCollate.Checked:=collate;
 CheckCollateClick(Self);
end;

procedure TFRpPrintDialog.RPagesClick(Sender: TObject);
begin
 if RPages.ItemIndex=0 then
 begin
  EFrom.Enabled:=false;
  ETo.Enabled:=false;
 end
 else
 begin
  EFrom.Enabled:=true;
  ETo.Enabled:=true;
 end;
end;

procedure TFRpPrintDialog.CheckCollateClick(Sender: TObject);
var
 bitmap:TBitmap;
 rec:TRect;
begin
 bitmap:=Image1.Picture.Bitmap;
 rec.Top:=0;rec.Left:=0;
 rec.Right:=Image1.Width-1;
 rec.Bottom:=Image1.Height-1;
 bitmap.Canvas.Brush.Style:=bsSolid;
 bitmap.Canvas.Brush.Color:=GCopies.Color;
 bitmap.Canvas.FillRect(rec);
 // Sets the image collation
 if CheckCollate.checked then
 begin
  ImageList1.Draw(Bitmap.Canvas,0,0,1);
 end
 else
 begin
  ImageList1.Draw(Bitmap.Canvas,0,0,0);
 end;
 Image1.Invalidate;
end;

end.
