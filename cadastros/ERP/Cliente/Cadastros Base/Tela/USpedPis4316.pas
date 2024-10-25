{*******************************************************************************
Title: T2Ti ERP
Description: Janela Cadastro de SpedPis4316

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
unit USpedPis4316;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UTelaCadastro, DB, DBClient, Menus, StdCtrls, ExtCtrls, Buttons, Grids,
  DBGrids, JvExDBGrids, JvDBGrid, JvDBUltimGrid, ComCtrls, SpedPis4316VO,
  SpedPis4316Controller, Tipos, Atributos, Constantes, LabeledCtrls,
  Mask, JvExMask, JvToolEdit, JvBaseEdits;

type
  [TFormDescription(TConstantes.MODULO_CADASTROS,'Sped Pis 4316')]
  TFSpedPis4316 = class(TFTelaCadastro)
    BevelEdits: TBevel;
    MemoDescricao: TLabeledMemo;
    MemoObservacao: TLabeledMemo;
    EditInicioVigencia: TLabeledDateEdit;
    EditFimVigencia: TLabeledDateEdit;
    EditCodigo: TLabeledCalcEdit;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure GridParaEdits; override;
    procedure ControlaBotoes; override;
  end;

var
  FSpedPis4316: TFSpedPis4316;

implementation

{$R *.dfm}

{$REGION 'Infra'}
procedure TFSpedPis4316.FormCreate(Sender: TObject);
begin
  ClasseObjetoGridVO := TSpedPis4316VO;
  ObjetoController := TSpedPis4316Controller.Create;

  inherited;
end;

procedure TFSpedPis4316.ControlaBotoes;
begin
  inherited;

  BotaoInserir.Visible := False;
  BotaoAlterar.Visible := False;
  BotaoExcluir.Visible := False;
  BotaoSalvar.Visible := False;
end;
{$ENDREGION}

{$REGION 'Controle de Grid'}
procedure TFSpedPis4316.GridParaEdits;
begin
  inherited;

  if not CDSGrid.IsEmpty then
  begin
    ObjetoVO := ObjetoController.VO<TSpedPis4316VO>(IdRegistroSelecionado);
  end;

  if Assigned(ObjetoVO) then
  begin
    EditCodigo.AsInteger    := TSpedPis4316VO(ObjetoVO).Codigo;
    MemoDescricao.Text      := TSpedPis4316VO(ObjetoVO).Descricao;
    MemoOBservacao.Text     := TSpedPis4316VO(ObjetoVO).Observacao;
    EditInicioVigencia.Date := TSpedPis4316VO(ObjetoVO).InicioVigencia;
    EditFimVigencia.Date    := TSpedPis4316VO(ObjetoVO).FimVigencia;
  end;
end;
{$ENDREGION}

end.
