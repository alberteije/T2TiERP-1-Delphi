{*******************************************************************************
Title: T2Ti ERP
Description: Tela principal do sistema de balcão do PAF-ECF.

The MIT License

Copyright: Copyright (C) 2010 T2Ti.COM

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

       The author may be contacted at:
           t2ti.com@gmail.com</p>

@author Albert Eije (T2Ti.COM) | Eri Brito | FC Costa
@version 1.0
*******************************************************************************}
unit UMenu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, Menus, ExtCtrls, Buttons, StdCtrls, JvExControls,
  JvEnterTab, pngimage, inifiles;

type
  TFMenu = class(TForm)
    PanelBarra: TPanel;
    MainMenu1: TMainMenu;
    LinhaStatus: TStatusBar;
    Cadastro1: TMenuItem;
    Movimento1: TMenuItem;
    Compras1: TMenuItem;
    Ajuda1: TMenuItem;
    Sobre1: TMenuItem;
    Image1: TImage;
    CFOP1: TMenuItem;
    N1: TMenuItem;
    Sair1: TMenuItem;
    PanelBotaoDAV: TPanel;
    ImageBotaoDAV: TImage;
    PanelBotaoPV: TPanel;
    ImageBotaoPV: TImage;
    PanelBotaoSair: TPanel;
    ImageBotaoSair: TImage;
    PanelBotaoNFe: TPanel;
    ImageNFe: TImage;
    PanelBotaoProduto: TPanel;
    ImageProduto: TImage;
    NFe1: TMenuItem;
    Produto1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton11Click(Sender: TObject);
    procedure Sair1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ImageBotaoDAVMouseEnter(Sender: TObject);
    procedure ImageBotaoDAVMouseLeave(Sender: TObject);
    procedure ImageBotaoDAVClick(Sender: TObject);
    procedure ImageBotaoSairClick(Sender: TObject);
    procedure ImageBotaoSairMouseEnter(Sender: TObject);
    procedure ImageBotaoSairMouseLeave(Sender: TObject);
    procedure ImageBotaoPVMouseEnter(Sender: TObject);
    procedure ImageBotaoPVMouseLeave(Sender: TObject);
    procedure ImageBotaoPVClick(Sender: TObject);
    procedure ImageNFeClick(Sender: TObject);
    procedure ImageNFeMouseEnter(Sender: TObject);
    procedure ImageNFeMouseLeave(Sender: TObject);
    procedure ImageProdutoMouseEnter(Sender: TObject);
    procedure ImageProdutoMouseLeave(Sender: TObject);
    procedure ImageProdutoClick(Sender: TObject);
  private
    Procedure ShowHint(Sender: TObject);
    { Private declarations }
  public
  var
  UsuarioLogado: string;
  end;

var
  FMenu: TFMenu;

implementation

uses UDAV, UDataModule, UPreVenda, ULogin, UNFe, UProduto, Biblioteca;
{$R *.dfm}

procedure TFMenu.Sair1Click(Sender: TObject);
begin
  Application.Terminate;
end;

Procedure TFMenu.ShowHint(Sender: TObject);
Begin
  LinhaStatus.Panels.items[0].text := Application.Hint;
End;

procedure TFMenu.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Application.MessageBox('Deseja Realmente Sair?', 'Sair do Sistema', MB_YesNo + MB_IconQuestion) <> IdYes then
    Application.Run;
end;

procedure TFMenu.FormCreate(Sender: TObject);
begin
  Application.OnHint := ShowHint;
  Application.CreateForm(TFLogin, FLogin);
  FLogin.ShowModal;
end;

procedure TFMenu.ImageNFeClick(Sender: TObject);
begin
  Application.CreateForm(TFNFe, FNFe);
  FNFe.ShowModal;
end;

procedure TFMenu.ImageBotaoDAVClick(Sender: TObject);
begin
  Application.CreateForm(TFDAV, FDAV);
  FDAV.ShowModal;
end;

procedure TFMenu.ImageBotaoPVClick(Sender: TObject);
var
ini : Tinifile;
RegistraPreVenda : String;
begin
  try
    ini := TIniFile.Create(ExtractFilePath(Application.ExeName)+'ArquivoAuxiliar.ini');
    RegistraPreVenda := UpperCase(Codifica('D', ini.ReadString('ESTABELECIMENTO','REGISTRAPREVENDA','')));
  finally
    ini.Free;
  end;

  if RegistraPreVenda = 'REGISTRA' then
     Begin
      Application.CreateForm(TFPreVenda, FPreVenda);
      FPreVenda.ShowModal;
     End
  else
    Application.MessageBox('Sistema Não Preparado Para Registrar Pré-Venda!', 'Erro', MB_OK + MB_ICONERROR);

end;

procedure TFMenu.ImageProdutoClick(Sender: TObject);
begin
  Application.CreateForm(TFProduto, FProduto);
  FProduto.ShowModal;
end;

procedure TFMenu.ImageBotaoSairClick(Sender: TObject);
begin
  Close;
end;

procedure TFMenu.SpeedButton11Click(Sender: TObject);
begin
  Close;
end;

procedure TFMenu.ImageBotaoDAVMouseEnter(Sender: TObject);
begin
  PanelBotaoDAV.BevelOuter := bvRaised;
  PanelBotaoDAV.BevelWidth := 2;
end;

procedure TFMenu.ImageBotaoDAVMouseLeave(Sender: TObject);
begin
  PanelBotaoDAV.BevelOuter := bvNone;
end;

procedure TFMenu.ImageBotaoPVMouseEnter(Sender: TObject);
begin
  PanelBotaoPV.BevelOuter := bvRaised;
  PanelBotaoPV.BevelWidth := 2;
end;

procedure TFMenu.ImageBotaoPVMouseLeave(Sender: TObject);
begin
  PanelBotaoPV.BevelOuter := bvNone;
end;

procedure TFMenu.ImageBotaoSairMouseEnter(Sender: TObject);
begin
  PanelBotaoSair.BevelOuter := bvRaised;
  PanelBotaoSair.BevelWidth := 2;
end;

procedure TFMenu.ImageBotaoSairMouseLeave(Sender: TObject);
begin
  PanelBotaoSair.BevelOuter := bvNone;
end;

procedure TFMenu.ImageNFeMouseEnter(Sender: TObject);
begin
  PanelBotaoNFe.BevelOuter := bvRaised;
  PanelBotaoNFe.BevelWidth := 2;
end;

procedure TFMenu.ImageNFeMouseLeave(Sender: TObject);
begin
  PanelBotaoNFe.BevelOuter := bvNone;
end;

procedure TFMenu.ImageProdutoMouseEnter(Sender: TObject);
begin
  PanelBotaoProduto.BevelOuter := bvRaised;
  PanelBotaoProduto.BevelWidth := 2;
end;

procedure TFMenu.ImageProdutoMouseLeave(Sender: TObject);
begin
  PanelBotaoProduto.BevelOuter := bvNone;
end;

end.
