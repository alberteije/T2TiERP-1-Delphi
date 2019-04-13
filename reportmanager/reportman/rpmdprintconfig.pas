{*******************************************************}
{                                                       }
{       Report Manager                                  }
{                                                       }
{       rpmdprintconfig                                }
{                                                       }
{       Configuration dialog for user printers          }
{       it stores all info in config files              }
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

unit rpmdprintconfig;

interface

{$I rpconf.inc}

uses SysUtils, Classes,
  QGraphics, QForms, QControls, QStdCtrls,
  QButtons, QExtCtrls,QPrinters,
  rpmdconsts,IniFiles,rpmdshfolder,
  rptypes,rpmunits;

type
  TFRpPrinterConfig = class(TForm)
    BOK: TButton;
    BCancel: TButton;
    LSelPrinter: TListBox;
    LSelectPrinter: TLabel;
    ComboPrinters: TComboBox;
    CheckPrinterFonts: TCheckBox;
    GConfigFile: TGroupBox;
    EConfigFile: TEdit;
    RadioUser: TRadioButton;
    RadioSystem: TRadioButton;
    GPageMargins: TGroupBox;
    LLeft: TLabel;
    ELeftMargin: TEdit;
    ETopMargin: TEdit;
    LTop: TLabel;
    LMetrics3: TLabel;
    LMetrics4: TLabel;
    LOperations: TLabel;
    LExample: TLabel;
    CheckCutPaper: TCheckBox;
    ECutPaper: TEdit;
    CheckOpenDrawer: TCheckBox;
    EOpenDrawer: TEdit;
    LExample2: TLabel;
    ComboTextOnly: TComboBox;
    LTextDriver: TLabel;
    CheckOem: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure LSelPrinterClick(Sender: TObject);
    procedure RadioUserClick(Sender: TObject);
    procedure BOKClick(Sender: TObject);
    procedure CheckPrinterFontsClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ComboPrintersChange(Sender: TObject);
    procedure ELeftMarginChange(Sender: TObject);
    procedure ECutPaperChange(Sender: TObject);
    procedure CheckCutPaperClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ComboTextOnlyChange(Sender: TObject);
    procedure CheckOemClick(Sender: TObject);
  private
    { Private declarations }
   configfilename:string;
   userconfigfilename:string;
   systemconfigfilename:string;
   configinifile:TMemInifile;
   printernames:TStringList;
   userconfig:boolean;
   procedure DoSave;
   procedure ReadPrintersConfig;
  public
    { Public declarations }
  end;

procedure ShowPrintersConfiguration;

implementation

{$R *.xfm}


procedure ShowPrintersConfiguration;
var
 dia:TFRpPrinterConfig;
begin
 dia:=TFRpPrinterConfig.Create(Application);
 try
  dia.showmodal;
 finally
  dia.free;
 end;
end;

procedure TFRpPrinterConfig.FormCreate(Sender: TObject);
begin
 printernames:=TStringList.Create;
 ReadPrintersConfig;
 printernames.Assign(Printer.Printers);

 GetTextOnlyPrintDrivers(ComboTextOnly.Items);
 BOK.Caption:=TranslateStr(93,BOK.Caption);
 BCancel.Caption:=TranslateStr(94,BCancel.Caption);
 CheckPrinterFonts.Caption:=TranslateStr(113,CheckPrinterFonts.Caption);
 LSelectPrinter.Caption:=TranslateStr(741,LSelectPrinter.Caption);
 GConfigFile.Caption:=TranslateStr(743,GConfigFile.Caption);
 RadioUser.Caption:=TranslateStr(744,RadioUser.Caption);
 RadioSystem.Caption:=TranslateStr(745,RadioSystem.Caption);
 Caption:=TranslateStr(742,Caption);
 GPageMargins.Caption:=TranslateStr(746,GPagemargins.Caption);
 LLeft.Caption:=TranslateStr(100,LLeft.Caption);
 LTop.Caption:=TranslateStr(102,LTop.Caption);
 LMetrics3.Caption:=rpunitlabels[defaultunit];
 LMetrics4.Caption:=LMetrics3.Caption;
 LOperations.Caption:=TranslateStr(763,LOperations.Caption);
 LExample.Caption:=TranslateStr(764,LExample.Caption);
 LExample2.Caption:=TranslateStr(765,LExample2.Caption);
 CheckCutPaper.Caption:=TranslateStr(766,CheckCutPaper.Caption);
 CheckOpenDrawer.Caption:=TranslateStr(767,CheckOpenDrawer.Caption);
 LTextDriver.Caption:=TranslateStr(1058,LtextDriver.Caption);
 with LSelPrinter.Items do
 begin
  Add(SRpDefaultPrinter);
  Add(SRpReportPrinter);
  Add(SRpTicketPrinter);
  Add(SRpGraphicprinter);
  Add(SRpCharacterprinter);
  Add(SRpReportPrinter2);
  Add(SRpTicketPrinter2);
  Add(SRpUserPrinter1);
  Add(SRpUserPrinter2);
  Add(SRpUserPrinter3);
  Add(SRpUserPrinter4);
  Add(SRpUserPrinter5);
  Add(SRpUserPrinter6);
  Add(SRpUserPrinter7);
  Add(SRpUserPrinter8);
  Add(SRpUserPrinter9);
  Add(SRpPlainPrinter);
  Add(SRpPlainFullPrinter);
 end;
 LSelPrinter.ItemIndex:=0;
 LSelPrinterClick(Self);
 RadioSystem.Checked:=not userconfig;
 RadioUser.Checked:=userconfig;
 RadioUserClick(Self);

 ComboPrinters.Items.Assign(printernames);
 ComboPrinters.Items.Insert(0,SRpDefaultPrinter);
 SetInitialBounds;
end;

procedure TFRpPrinterConfig.LSelPrinterClick(Sender: TObject);
var
 index:integer;
 defdriver:String;
begin
 if LSelPrinter.ItemIndex=0 then
 begin
  LSelectPrinter.Visible:=False;
  ComboPrinters.ItemIndex:=0;
  ComboPrinters.Visible:=false;
  // Reads the configuration for the default printer
  CheckPrinterFonts.Checked:=configinifile.ReadBool('PrinterFonts','Default',false);
 end
 else
 begin
  LSelectPrinter.Visible:=True;
  ComboPrinters.Visible:=True;
  // Read the configuration for the selected printer
  CheckPrinterFonts.Checked:=configinifile.ReadBool('PrinterFonts','Printer'+IntToStr(LSelPrinter.ItemIndex),false);
  ComboPrinters.ItemIndex:=ComboPrinters.Items.IndexOf(configinifile.ReadString('PrinterNames','Printer'+IntToStr(LSelPrinter.ItemIndex),''));
  if ComboPrinters.ItemIndex<0 then
  begin
   ComboPrinters.ItemIndex:=0;
   ComboPrintersChange(Self);
  end;
 end;
 ELeftMargin.Text:=gettextfromtwips(configinifile.ReadInteger('PrinterOffsetX','Printer'+IntToStr(LSelPrinter.ItemIndex),0));
 ETopMargin.Text:=gettextfromtwips(configinifile.ReadInteger('PrinterOffsetY','Printer'+IntToStr(LSelPrinter.ItemIndex),0));
 CheckCutPaper.Checked:=configinifile.ReadBool('CutPaperOn','Printer'+IntToStr(LSelPrinter.ItemIndex),false);
 ECutPaper.Text:=configinifile.ReadString('CutPaper','Printer'+IntToStr(LSelPrinter.ItemIndex),'');
 CheckOpenDrawer.Checked:=configinifile.ReadBool('OpenDrawerOn','Printer'+IntToStr(LSelPrinter.ItemIndex),false);
 EOpenDrawer.Text:=configinifile.ReadString('OpenDrawer','Printer'+IntToStr(LSelPrinter.ItemIndex),'#27#112#0#100#100');
 ComboTextOnly.ItemIndex:=0;
 defdriver:=' ';
 if LSelPrinter.ItemIndex=Integer(pRpCharacterprinter) then
  defdriver:='EPSON';
 if LSelPrinter.ItemIndex=Integer(pRpTicketprinter) then
  defdriver:='EPSONTMU210';
 defdriver:=configinifile.ReadString('PrinterDriver','Printer'+IntToStr(LSelPrinter.ItemIndex),defdriver);
 if Length(defdriver)<1 then
  defdriver:=' ';
 index:=ComboTextOnly.Items.IndexOf(defdriver);
 if index>=0 then
  ComboTextOnly.ItemIndex:=index;
 CheckOem.Checked:=configinifile.ReadBool('PrinterEscapeOem','Printer'+IntToStr(LSelPrinter.ItemIndex),true);
end;

procedure TFRpPrinterConfig.ReadPrintersConfig;
begin
 userconfig:=true;
 systemconfigfilename:=Obtainininamecommonconfig('','','reportman');
 userconfigfilename:=Obtainininameuserconfig('','','reportman');
 if FileExists(systemconfigfilename) then
 begin
  configfilename:=systemconfigfilename;
  userconfig:=false;
 end
 else
 begin
  configfilename:=userconfigfilename;
 end;
 if assigned(configinifile) then
 begin
  configinifile.free;
  configinifile:=nil;
 end;
 configinifile:=TMemInifile.Create(configfilename);
end;

procedure TFRpPrinterConfig.RadioUserClick(Sender: TObject);
begin
 // Sets the filename
 if RadioSystem.Checked then
 begin
  EConfigFile.Text:=systemconfigfilename;
 end
 else
 begin
  EConfigFile.Text:=userconfigfilename;
 end;
end;

procedure TFRpPrinterConfig.BOKClick(Sender: TObject);
begin
 DoSave;
 Close;
end;

procedure TFRpPrinterConfig.DoSave;
begin
 if configinifile.FileName=EConfigFile.TExt then
  configinifile.UpdateFile
 else
 begin
  configinifile.Rename(EConfigFile.Text,false);
  configinifile.UpdateFile
 end;
end;

procedure TFRpPrinterConfig.CheckPrinterFontsClick(Sender: TObject);
begin
 if LSelPrinter.ItemIndex=0 then
 begin
  configinifile.WriteBool('PrinterFonts','Default',CheckPrinterFonts.Checked);
 end
 else
 begin
  configinifile.WriteBool('PrinterFonts','Printer'+IntToStr(LSelPrinter.ItemIndex),CheckPrinterFonts.Checked);
 end;
end;

procedure TFRpPrinterConfig.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 ReadPrintersConfig;
 ReloadPrinterConfig;
end;


procedure TFRpPrinterConfig.ComboPrintersChange(Sender: TObject);
var
 printername:String;
begin
 if LSelPrinter.ItemIndex<0 then
  exit;
 if ComboPrinters.ItemIndex=0 then
  printername:=''
 else
  printername:=ComboPrinters.Text;
 configinifile.WriteString('PrinterNames','Printer'+IntToStr(LSelPrinter.ItemIndex),printername);
end;

procedure TFRpPrinterConfig.ELeftMarginChange(Sender: TObject);
var
 margin:integer;
begin
 if LSelPrinter.ItemIndex<0 then
  exit;
 try
  margin:=gettwipsfromtext(TEdit(Sender).Text);
 except
  margin:=0;
 end;
 if Sender=ELeftMargin then
  configinifile.WriteInteger('PrinterOffsetX','Printer'+IntToStr(LSelPrinter.ItemIndex),margin)
 else
  configinifile.WriteInteger('PrinterOffsetY','Printer'+IntToStr(LSelPrinter.ItemIndex),margin);
end;

procedure TFRpPrinterConfig.ECutPaperChange(Sender: TObject);
var
 Operation:String;
begin
 if Sender=ECutPaper then
  Operation:='CutPaper'
 else
  Operation:='OpenDrawer';
 configinifile.WriteString(Operation,'Printer'+IntToStr(LSelPrinter.ItemIndex),(Sender As TEdit).Text);
end;

procedure TFRpPrinterConfig.CheckCutPaperClick(Sender: TObject);
var
 Operation:String;
begin
 if Sender=CheckCutPaper then
  Operation:='CutPaper'
 else
  Operation:='OpenDrawer';
 configinifile.WriteBool(Operation+'On','Printer'+IntToStr(LSelPrinter.ItemIndex),(Sender As TCheckBox).Checked);
end;

procedure TFRpPrinterConfig.FormDestroy(Sender: TObject);
begin
 if assigned(configinifile) then
 begin
  configinifile.free;
  configinifile:=nil;
 end;
 printernames.free;
 printernames:=nil;
end;

procedure TFRpPrinterConfig.ComboTextOnlyChange(Sender: TObject);
var
 drivername:String;
begin
 if LSelPrinter.ItemIndex<0 then
  exit;
 drivername:=Uppercase(Trim(ComboTextOnly.Text));
 if Length(DriverName)>0 then
 begin
  configinifile.WriteInteger('PrinterEscapeStyle','Printer'+IntToStr(LSelPrinter.ItemIndex),Integer(rpPrinterDatabase));
  configinifile.WriteString('PrinterDriver','Printer'+IntToStr(LSelPrinter.ItemIndex),drivername);
 end
 else
 begin
  configinifile.WriteInteger('PrinterEscapeStyle','Printer'+IntToStr(LSelPrinter.ItemIndex),Integer(rpPrinterDefault));
  configinifile.WriteString('PrinterDriver','Printer'+IntToStr(LSelPrinter.ItemIndex),' ');
 end;
end;

procedure TFRpPrinterConfig.CheckOemClick(Sender: TObject);
begin
 configinifile.WriteBool('PrinterEscapeOem','Printer'+IntToStr(LSelPrinter.ItemIndex),CheckOem.Checked);
end;


end.
