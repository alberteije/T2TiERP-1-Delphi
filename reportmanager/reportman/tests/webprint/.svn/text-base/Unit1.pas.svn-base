unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,rpwebmetaclient, StdCtrls,ActiveX,Axctrls;

const
 TestString='http://plutonio/cgi-bin/repwebexe.exe/execute?reportname=%5Csample6&aliasname=TEST2&username=Admin&password=&ParamDETAIL=True&ParamFIRSTORDER=1000&ParamLASTORDER=1010&METAFILE=1';

type
  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses rpwebreportx;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
 acontrol:TrpWebMetaPrint;
 thecontrol:TWebReportman;
begin
 thecontrol:=TWebReportman.Create(Self);
 thecontrol.Align:=alclient;
 thecontrol.Parent:=Self;
// rpwebmetaclient.PrintHttpReport(Edit1.Text);
 acontrol:=TrpWebMetaPrint.Create(Self);
 acontrol.parent:=Self;
 acontrol.Width:=100;
 acontrol.Height:=100;
 acontrol.Left:=200;
 acontrol.Top:=200;
 acontrol.caption:='Hello';
 acontrol.preview:=true;
 acontrol.aForm:=acontrol;
 acontrol.align:=alclient;
// acontrol.visible:=false;
 thecontrol.BringToFront;
 acontrol.PrinterConfig:=false;
 acontrol.MetaUrl:=Edit1.Text;
 acontrol.Execute;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
 Edit1.Text:=TestString;
end;

end.
