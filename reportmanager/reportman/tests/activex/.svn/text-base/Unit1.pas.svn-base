unit Unit1;

interface

uses
  Windows, Messages, SysUtils,
{$IFDEF USEVARIANTS}
  Variants,
{$ENDIF}
  Classes, Graphics, Controls, Forms,
  Dialogs,rpactivexreport, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    axreport:TRpActiveXReport;

  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
 axreport:=TRpActiveXReport.Create(Self);
 axreport.Parent:=self;
 axreport.Left:=100;
 axreport.Top:=100;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
 axreport.Filename:='c:\prog\toni\cvsroot\reportman\reportman\repman\repsamples\sample2.rep';
 axreport.Title:='Test';
 axreport.Execute;
end;

end.
 