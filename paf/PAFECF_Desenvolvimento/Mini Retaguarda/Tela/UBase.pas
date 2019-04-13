{*******************************************************************************
Title: T2Ti ERP
Description: Janela Cadastro de Bancos

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
           fabio_thz@yahoo.com.br</p>

@author Fábio Thomaz (T2Ti.COM)
@version 1.0
*******************************************************************************}
unit UBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SessaoUsuario, JvArrowButton, Buttons, Tipos, UDataModule,
  JvPageList;

type
  TFBase = class(TForm)
  private
    function GetSessaoUsuario: TSessaoUsuario;
    { Private declarations }
  public
    { Public declarations }
    property Sessao: TSessaoUsuario read GetSessaoUsuario;

    procedure IconeBotao(pBotao: TBitBtn; pTipo: TImagem;
      pStatus: TStatusImagem; pTamanho: TTamanhoImagem); overload;
    procedure IconeBotao(pBotao: TJvArrowButton; pTipo: TImagem;
      pStatus: TStatusImagem; pTamanho: TTamanhoImagem); overload;
    procedure IconeBotao(pBotao: TSpeedButton; pTipo: TImagem;
      pStatus: TStatusImagem; pTamanho: TTamanhoImagem); overload;

    procedure FechaFormulario;
  end;

var
  FBase: TFBase;

implementation

uses UMenu;

{$R *.dfm}

{ TFBase }

procedure TFBase.FechaFormulario;
begin
  if (Self.Owner is TJvStandardPage) and (Assigned(FMenu)) then
    FMenu.FecharPagina(TJvStandardPage(Self.Owner))
  else
    Self.Close;
end;

function TFBase.GetSessaoUsuario: TSessaoUsuario;
begin
  Result := TSessaoUsuario.Instance;
end;

procedure TFBase.IconeBotao(pBotao: TBitBtn; pTipo: TImagem;
  pStatus: TStatusImagem; pTamanho: TTamanhoImagem);
begin
  if Assigned(pBotao.Glyph) then
    pBotao.Glyph.Free;

  pBotao.Glyph := FDataModule.Imagem(pTipo,pStatus,pTamanho);
end;

procedure TFBase.IconeBotao(pBotao: TJvArrowButton; pTipo: TImagem;
  pStatus: TStatusImagem; pTamanho: TTamanhoImagem);
begin
  if Assigned(pBotao.Glyph) then
    pBotao.Glyph.Free;

  pBotao.Glyph := FDataModule.Imagem(pTipo,pStatus,pTamanho);
end;

procedure TFBase.IconeBotao(pBotao: TSpeedButton; pTipo: TImagem;
  pStatus: TStatusImagem; pTamanho: TTamanhoImagem);
begin
  if Assigned(pBotao.Glyph) then
    pBotao.Glyph.Free;

  pBotao.Glyph := FDataModule.Imagem(pTipo,pStatus,pTamanho);
end;

end.
