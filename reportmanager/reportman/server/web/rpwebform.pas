unit rpwebform;

interface

uses
  SysUtils, Classes, Forms;

type
  TFRpWebForm = class(TForm)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FRpWebForm: TFRpWebForm;

implementation

uses SockApp;

{$R *.dfm}

initialization
  TWebAppSockObjectFactory.Create('WebReportServer')

end.
