unit Unit1;

interface

uses
  SysUtils, Types, Classes, QGraphics, QControls, QForms, QDialogs,
  QStdCtrls,rpparams,rpdatainfo;

type
  TForm1 = class(TForm)
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    params:TRpParamList;
    datainfo:TRpDatainfoList;
  end;

var
  Form1: TForm1;

implementation

uses rpfparams;

{$R *.xfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
 params:=TRpParamList.Create(Self);
 datainfo:=TRpDataInfoList.Create(Self);
 datainfo.Add('PROVA1');
 datainfo.Add('PROVA2');
 datainfo.Add('PROVA3');
 ShowParamDef(params,datainfo);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
 ShowParamDef(params,datainfo);
end;

end.
