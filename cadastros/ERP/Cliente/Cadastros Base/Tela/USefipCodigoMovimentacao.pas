{*******************************************************************************
Title: T2Ti ERP
Description: Janela Cadastro de SefipCodigoMovimentacao

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

t2ti.com@gmail.com | fernandololiver@gmail.com
@author Albert Eije (T2Ti.COM) | Fernando L Oliveira
@version 1.0
*******************************************************************************}
unit USefipCodigoMovimentacao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UTelaCadastro, DB, DBClient, Menus, StdCtrls, ExtCtrls, Buttons, Grids,
  DBGrids, JvExDBGrids, JvDBGrid, JvDBUltimGrid, ComCtrls, SefipCodigoMovimentacaoVO,
  SefipCodigoMovimentacaoController, Tipos, Atributos, Constantes, LabeledCtrls;

type
  [TFormDescription(TConstantes.MODULO_CADASTROS,'Sefip C�digo de Movimenta��o')]
  TFSefipCodigoMovimentacao = class(TFTelaCadastro)
    BevelEdits: TBevel;
    EditCodigo: TLabeledEdit;
    MemoDescricao: TLabeledMemo;
    MemoAplicacao: TLabeledMemo;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure GridParaEdits; override;
    procedure ControlaBotoes; override;
  end;

var
  FSefipCodigoMovimentacao: TFSefipCodigoMovimentacao;

implementation

{$R *.dfm}

{$REGION 'Infra'}
procedure TFSefipCodigoMovimentacao.FormCreate(Sender: TObject);
begin
  ClasseObjetoGridVO := TSefipCodigoMovimentacaoVO;
  ObjetoController := TSefipCodigoMovimentacaoController.Create;

  inherited;
end;

procedure TFSefipCodigoMovimentacao.ControlaBotoes;
begin
  inherited;

  BotaoInserir.Visible := False;
  BotaoAlterar.Visible := False;
  BotaoExcluir.Visible := False;
  BotaoSalvar.Visible := False;
end;
{$ENDREGION}

{$REGION 'Controle de Grid'}
procedure TFSefipCodigoMovimentacao.GridParaEdits;
begin
  inherited;

  if not CDSGrid.IsEmpty then
  begin
    ObjetoVO := ObjetoController.VO<TSefipCodigoMovimentacaoVO>(IdRegistroSelecionado);
  end;

  if Assigned(ObjetoVO) then
  begin
    EditCodigo.Text := TSefipCodigoMovimentacaoVO(ObjetoVO).Codigo;
    MemoDescricao.Text := TSefipCodigoMovimentacaoVO(ObjetoVO).Descricao;
    MemoAplicacao.Text := TSefipCodigoMovimentacaoVO(ObjetoVO).Aplicacao;
  end;
end;

{$ENDREGION}

end.
