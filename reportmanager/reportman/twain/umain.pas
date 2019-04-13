unit umain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,rptwaincomp, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdHTTP, StdCtrls, XPMan, Menus, ExtCtrls, Spin;

type
  TForm1 = class(TForm)
    XPManifest1: TXPManifest;
    MainMenu1: TMainMenu;
    Archivo1: TMenuItem;
    Empezar1: TMenuItem;
    Panel1: TPanel;
    Label1: TLabel;
    EURL: TEdit;
    Label2: TLabel;
    EURLComplete: TEdit;
    Label3: TLabel;
    EJpeg: TSpinEdit;
    Label4: TLabel;
    ComboDithering: TComboBox;
    EBuffer: TSpinEdit;
    Label5: TLabel;
    Label6: TLabel;
    ETitle: TEdit;
    ComboFormat: TComboBox;
    Label7: TLabel;
    Button1: TButton;
    Label8: TLabel;
    EMaxSize: TSpinEdit;
    procedure FormCreate(Sender: TObject);
    procedure Empezar1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
   awebtwain:TRpTwainWeb;

  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
 combodithering.ItemIndex:=1;
 comboformat.ItemIndex:=0;
 awebtwain:=TRpTwainWeb.Create(Self);
 awebtwain.Align:=alClient;
 awebtwain.Parent:=self;
 awebtwain.BufferSize:=4096;
 awebtwain.ImageFormat:=2;
 awebtwain.GifDither:=1;
 awebtwain.JPegQuality:=100;
// awebtwain.GifColorReduction:=4;
end;

procedure TForm1.Empezar1Click(Sender: TObject);
begin
 awebtwain.CompletedUrlPath:=EURLComplete.Text;
 awebtwain.UrlPath:=EURL.Text;
 awebtwain.ImageFormat:=ComboFormat.ItemIndex;
 awebtwain.BufferSize:=EBuffer.Value;
 awebtwain.JPegQuality:=EJpeg.Value;
 awebtwain.GifDither:=ComboDithering.ItemIndex;
 awebtwain.AppTitle:=ETitle.Text;
 awebtwain.MaxKBytes:=EMaxSize.Value;
 awebtwain.Execute;
end;

end.
