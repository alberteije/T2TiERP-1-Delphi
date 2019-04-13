{*******************************************************}
{                                                       }
{       Report Manager                                  }
{                                                       }
{       rpfmainMetaview                                 }
{       TFRpMeta                                        }
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

unit rpfmainmetaview;

interface

{$I rpconf.inc}

uses
  SysUtils,Inifiles,
{$IFDEF VCLANDCLX}
  Windows,Dialogs,rpgdidriver,
{$ENDIF}
  Types, Classes, QGraphics, QControls, QForms, QDialogs,
  QStdCtrls,rpmetafile, QComCtrls,rpqtdriver, QExtCtrls,rpmdclitree,
  QActnList, QImgList,QPrinters,Qt,rpmdconsts,rptypes, QMenus,
  rpmdfabout,QTypes,QStyle,rpmdshfolder,rpmdprintconfig,
  rpmdfhelpform,rpfmetaview;

type
  TFRpMainMeta = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    MFrame:TFRpMeta;
    browsecommandline:Boolean;
  end;

var
 FRpMainMeta:TFRpMainMeta;

procedure PreviewMetafile(metafile:TRpMetafileReport;aform:TForm;
 ShowPrintDialog:Boolean;showexit:Boolean);

implementation

uses rpprintdia,rppdfdriver;

{$R *.xfm}

procedure PreviewMetafile(metafile:TRpMetafileReport;aform:TForm;ShowPrintDialog:Boolean;
 showexit:Boolean);
var
 dia:TFRpMainMeta;
// memstream:TMemoryStream;
 MFrame:TFRpMeta;
 FForm:TForm;
begin
 if not assigned(aform) then
 begin
  dia:=TFRpMainMeta.Create(Application);
  MFrame:=dia.MFrame;
  FForm:=dia;
 end
 else
 begin
  dia:=nil;
  MFrame:=TFRpMeta.Create(aform);
  MFrame.Parent:=aform;
  MFrame.SetMenu:=false;
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
   MFrame.Splitter1.Visible:=false;
   MFrame.printerindex:=metafile.PrinterSelect;
   MFrame.UpdatePrintSel;
   MFrame.clitree.visible:=false;
   if metafile.PreviewWindow=spwMaximized then
    FForm.WindowState:=wsMaximized;
   MFrame.AScale100.Checked:=False;
   MFrame.AScaleFull.Checked:=False;
   MFrame.AScaleWide.Checked:=False;
   if Not Assigned(aform) then
    dia.ShowModal;
 finally
  if not assigned(aform) then
   dia.free;
 end;
end;



procedure TFRpMainMeta.FormCreate(Sender: TObject);
begin
 MFrame:=TFRpMeta.Create(Self);
 MFrame.AForm:=self;
 MFrame.Parent:=Self;
 Caption:=SRpRepMetafile;
// Application.Title:=SRpRepMetafile;
end;


procedure TFRpMainMeta.FormShow(Sender: TObject);
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

end.
