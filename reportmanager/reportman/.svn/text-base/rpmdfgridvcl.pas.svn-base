{*******************************************************}
{                                                       }
{       Report Manager Designer                         }
{                                                       }
{       rpmdfgridvcl                                    }
{       Grid options for the report                     }
{                                                       }
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

unit rpmdfgridvcl;

interface

{$I rpconf.inc}

uses SysUtils, Classes,
  Graphics, Forms,
  Buttons, ExtCtrls, Controls, StdCtrls,Dialogs,
  rpmdconsts,rpmunits,rpreport, Mask, rpmaskedit;

type
  TFRpGridOptionsVCL = class(TForm)
    BOK: TButton;
    BCancel: TButton;
    Lhorizontal: TLabel;
    EGridX: TRpMaskEdit;
    Lvertical: TLabel;
    EGridY: TRpMaskEdit;
    LGridColor: TLabel;
    ColorDialog1: TColorDialog;
    GridColor: TShape;
    CheckEnabled: TCheckBox;
    CheckVisible: TCheckBox;
    LUnits1: TLabel;
    LUnits2: TLabel;
    CheckLines: TCheckBox;
    procedure GridColorMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure BOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    freport:TRpreport;
    procedure SetReport(Value:TRpreport);
  public
    { Public declarations }
    property report:TRpReport read Freport write SetReport;
  end;


procedure ModifyGridProperties(report:TRpReport);

implementation

{$R *.dfm}

procedure ModifyGridProperties(report:TRpReport);
var
 dia:TFRpGridOptionsVCL;
begin
 dia:=TFRpGridOptionsVCL.Create(Application);
 try
  dia.report:=report;
  dia.ShowModal;
 finally
  dia.free;
 end;
end;

procedure TFRpGridOptionsVCL.SetReport(Value:TRpreport);
begin
 freport:=Value;
 // Sets the values
 LUnits1.Caption:=getdefaultunitstring;
 LUnits2.Caption:=LUnits1.Caption;
 EGridX.Text:=rpmunits.gettextfromtwips(report.GridWidth);
 EGridY.Text:=rpmunits.gettextfromtwips(report.GridHeight);
 CheckEnabled.Checked:=report.GridEnabled;
 CheckVisible.Checked:=report.GridVisible;
 CheckLines.Checked:=report.GridLines;
 GridColor.Brush.Color:=report.GridColor;
end;

procedure TFRpGridOptionsVCL.GridColorMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 // Shows color dialog
 ColorDialog1.Color:=GridColor.Brush.Color;
 if ColorDialog1.Execute then
  GridColor.Brush.Color:=ColorDialog1.Color;
end;

procedure TFRpGridOptionsVCL.BOKClick(Sender: TObject);
begin
 // Save and close
 report.GridWidth:=rpmunits.gettwipsfromtext(EGridX.Text);
 report.GridHeight:=rpmunits.gettwipsfromtext(EGridY.Text);
 report.GridEnabled:=CheckEnabled.Checked;
 report.GridVisible:=CheckVisible.Checked;
 report.GridLines:=CheckLines.Checked;
 report.GridColor:=GridColor.Brush.Color;

 Close;
end;

procedure TFRpGridOptionsVCL.FormCreate(Sender: TObject);
begin
 BOK.Caption:=TranslateStr(93,BOK.Caption);
 BCancel.Caption:=TranslateStr(94,BCancel.Caption);
 Caption:=TranslateStr(179,Caption);
 LHorizontal.Caption:=TranslateStr(180,LHorizontal.Caption);
 LVertical.Caption:=TranslateStr(181,LVertical.Caption);
 LGridColor.Caption:=TranslateStr(185,LGridColor.Caption);
 CheckEnabled.Caption:=TranslateStr(182,CheckEnabled.Caption);
 CheckVisible.Caption:=TranslateStr(183,CheckVisible.Caption);
 CheckLines.Caption:=TranslateStr(184,CheckLines.Caption);


end;

end.
