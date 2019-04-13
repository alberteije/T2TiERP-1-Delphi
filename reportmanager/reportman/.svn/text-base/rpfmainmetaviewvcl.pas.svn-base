{*******************************************************}
{                                                       }
{       Report Manager                                  }
{                                                       }
{       rpfmainMetaviewvcl                              }
{       TFRpMetaVCL                                     }
{       A form to include the frame for                 }
{        report metafiles                               }
{                                                       }
{       Copyright (c) 1994-2002 Toni Martir             }
{       toni@pala.com                                   }
{                                                       }
{       This file is under the MPL license              }
{       If you enhace this file you must provide        }
{       source code                                     }
{                                                       }
{                                                       }
{*******************************************************}

unit rpfmainmetaviewvcl;

interface

{$I rpconf.inc}


uses
  SysUtils,Inifiles,
  Windows,Dialogs,rpgdidriver,ShellApi,rpgraphutilsvcl,
{$IFDEF USEVARIANTS}
  Types,
{$ENDIF}
  Classes, Graphics, Controls, Forms,
  StdCtrls,rpmetafile, ComCtrls,ExtCtrls,
  ActnList, ImgList,Printers,rpmdconsts,rptypes, Menus,
  rpmdfaboutvcl,rpmdshfolder,rpmdprintconfigvcl,
  ToolWin,rpfmetaviewvcl,rppreviewmeta;

type
  TFRpMainMetaVCL = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    MFrame:TFRpMetaVCL;
    browsecommandline:boolean;
  end;

var
 FRpMainMetaVCL:TFRpMainMetaVCL;

function PreviewMetafile(metafile:TRpMetafileReport;aform:TWinControl;
 ShowPrintDialog:Boolean;ShowExit:Boolean):TFRpMetaVCL;

implementation

uses rppdfdriver;

{$R *.dfm}

function PreviewMetafile(metafile:TRpMetafileReport;aform:TWinControl;
 ShowPrintDialog:Boolean;ShowExit:Boolean):TFRpMetaVCL;
var
 dia:TFRpMainMetaVCL;
 MFrame:TFRpMetaVCL;
 FForm:TWinControl;
begin
 if not assigned(aform) then
 begin
  dia:=TFRpMainMetaVCL.Create(Application);
  MFrame:=dia.MFrame;
  MFrame.Parent:=dia;
  FForm:=dia;
 end
 else
 begin
  dia:=nil;
  MFrame:=TFRpMetaVCL.Create(aform);
  MFrame.Parent:=aform;
  MFrame.AForm:=aform;
  FForm:=aform;
 end;
 MFrame.BExit.Visible:=ShowExit;
 MFrame.Exit1.Visible:=ShowExit;
 try
   MFrame.ShowPrintDialog:=ShowPrintDialog;
   MFrame.metafile:=metafile;
   MFrame.ASave.Enabled:=True;
   MFrame.AMailTo.Enabled:=True;
   MFrame.APrint.Enabled:=True;
   MFrame.AFirst.Enabled:=True;
   MFrame.APrevious.Enabled:=True;
   MFrame.ANext.Enabled:=True;
   MFrame.ALast.Enabled:=True;
   MFrame.AViewConnect.Checked:=false;
   MFrame.AViewConnect.Enabled:=false;
{$IFDEF USEINDY}
   if assigned(MFrame.clitree) then
    MFrame.clitree.Visible:=false;
{$ENDIF}
   MFrame.Splitter1.Visible:=false;
   MFrame.printerindex:=metafile.PrinterSelect;
   MFrame.UpdatePrintSel;
   if metafile.PreviewWindow=spwMaximized then
   begin
    if (FForm is TForm) then
     TForm(FForm).WindowState:=wsMaximized;
   end;
   MFrame.AScale100.Checked:=False;
   MFrame.AScaleFull.Checked:=False;
   MFrame.AScaleWide.Checked:=False;
   if not assigned(aform) then
    dia.ShowModal;
 finally
  if not assigned(aform) then
   dia.free;
 end;
 Result:=MFrame;
end;


procedure TFRpMainMetaVCL.FormCreate(Sender: TObject);
begin
 MFrame:=TFRpMetaVCL.Create(Self);
 MFrame.Parent:=Self;
 MFrame.AForm:=self;
 Caption:=SRpRepMetafile;
// Application.Title:=SRpRepMetafile;
 // Bugfix for TEdit height
 MFrame.EPageNum.Left:=MFrame.EPageNum.Left+1;
end;


procedure TFRpMainMetaVCL.FormShow(Sender: TObject);
begin
 if browsecommandline then
 begin
  if Length(ParamStr(1))>0 then
  begin
   if Assigned(MFrame) then
    MFrame.DoOpen(ParamStr(1));
  end;
 end;
end;

procedure TFRpMainMetaVCL.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
 increment:integer;
begin
 if not Assigned(MFrame) then
  exit;
 if not Assigned(MFrame.PreviewControl) then
  exit;
 if (ssShift in Shift) then
  increment:=REP_C_WHEELINC
 else
  increment:=REP_C_WHEELINC*REP_C_WHEELSCALE;
 if Key=VK_DOWN then
  MFrame.previewcontrol.Scroll(true,increment);
 if Key=VK_UP then
  MFrame.previewcontrol.Scroll(true,-increment);
 if Key=VK_RIGHT then
  MFrame.previewcontrol.Scroll(false,increment);
 if Key=VK_LEFT then
  MFrame.previewcontrol.Scroll(false,-increment);
 if Key=VK_SPACE then
 begin
  if MFrame.previewcontrol.AutoScale=AScaleEntirePage then
   MFrame.previewcontrol.AutoScale:=AScaleReal
  else
   MFrame.previewcontrol.AutoScale:=AScaleEntirePage;
  Key:=0;
 end;
 if Key=VK_F5 then
 begin
  MFrame.PreviewControl.ShowPageMargins:=not MFrame.PreviewControl.ShowPageMargins;
 end;
end;

end.
