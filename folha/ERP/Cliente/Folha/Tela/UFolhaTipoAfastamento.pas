{ *******************************************************************************
  Title: T2Ti ERP
  Description: Janela Cadastro de Tipos de Afastamento para a Folha de Pagamento

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

  @author Albert Eije (alberteije@gmail.com)
  @version 1.0
  ******************************************************************************* }
unit UFolhaTipoAfastamento;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UTelaCadastro, DB, DBClient, Menus, StdCtrls, ExtCtrls, Buttons, Grids,
  DBGrids, JvExDBGrids, JvDBGrid, JvDBUltimGrid, ComCtrls, FolhaTipoAfastamentoVO,
  FolhaTipoAfastamentoController, Tipos, Atributos, Constantes, LabeledCtrls, Mask,
  JvExMask, JvToolEdit, JvBaseEdits, StrUtils;

type
  [TFormDescription(TConstantes.MODULO_FOLHA_PAGAMENTO, 'Tipo Afastamento')]

  TFFolhaTipoAfastamento = class(TFTelaCadastro)
    BevelEdits: TBevel;
    EditCodigo: TLabeledEdit;
    EditNome: TLabeledEdit;
    MemoDescricao: TLabeledMemo;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure GridParaEdits; override;

    // Controles CRUD
    function DoInserir: Boolean; override;
    function DoEditar: Boolean; override;
    function DoExcluir: Boolean; override;
    function DoSalvar: Boolean; override;
  end;

var
  FFolhaTipoAfastamento: TFFolhaTipoAfastamento;

implementation

{$R *.dfm}

{$REGION 'Controles Infra'}
procedure TFFolhaTipoAfastamento.FormCreate(Sender: TObject);
begin
  ClasseObjetoGridVO := TFolhaTipoAfastamentoVO;
  ObjetoController := TFolhaTipoAfastamentoController.Create;

  inherited;
end;
{$ENDREGION}

{$REGION 'Controles CRUD'}
function TFFolhaTipoAfastamento.DoInserir: Boolean;
begin
  Result := inherited DoInserir;

  if Result then
  begin
    EditCodigo.SetFocus;
  end;
end;

function TFFolhaTipoAfastamento.DoEditar: Boolean;
begin
  Result := inherited DoEditar;

  if Result then
  begin
    EditCodigo.SetFocus;
  end;
end;

function TFFolhaTipoAfastamento.DoExcluir: Boolean;
begin
  if inherited DoExcluir then
  begin
    try
      Result := TFolhaTipoAfastamentoController(ObjetoController).Exclui(IdRegistroSelecionado);
    except
      Result := False;
    end;
  end
  else
  begin
    Result := False;
  end;

  if Result then
    TFolhaTipoAfastamentoController(ObjetoController).Consulta(Filtro, Pagina);
end;

function TFFolhaTipoAfastamento.DoSalvar: Boolean;
begin
  Result := inherited DoSalvar;

  if Result then
  begin
    try
      if not Assigned(ObjetoVO) then
        ObjetoVO := TFolhaTipoAfastamentoVO.Create;

      TFolhaTipoAfastamentoVO(ObjetoVO).IdEmpresa := Sessao.IdEmpresa;
      TFolhaTipoAfastamentoVO(ObjetoVO).Codigo := EditCodigo.Text;
      TFolhaTipoAfastamentoVO(ObjetoVO).Nome := EditNome.Text;
      TFolhaTipoAfastamentoVO(ObjetoVO).Descricao := MemoDescricao.Text;

      if StatusTela = stInserindo then
        Result := TFolhaTipoAfastamentoController(ObjetoController).Insere(TFolhaTipoAfastamentoVO(ObjetoVO))
      else if StatusTela = stEditando then
      begin
        if TFolhaTipoAfastamentoVO(ObjetoVO).ToJSONString <> TFolhaTipoAfastamentoVO(ObjetoOldVO).ToJSONString then
        begin
          TFolhaTipoAfastamentoVO(ObjetoVO).Id := IdRegistroSelecionado;
          Result := TFolhaTipoAfastamentoController(ObjetoController).Altera(TFolhaTipoAfastamentoVO(ObjetoVO), TFolhaTipoAfastamentoVO(ObjetoOldVO));
        end
        else
          Application.MessageBox('Nenhum dado foi alterado.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
      end;
    except
      Result := False;
    end;
  end;
end;
{$ENDREGION}

{$REGION 'Controle de Grid'}
procedure TFFolhaTipoAfastamento.GridParaEdits;
begin
  inherited;

  if not CDSGrid.IsEmpty then
  begin
    ObjetoVO := ObjetoController.VO<TFolhaTipoAfastamentoVO>(IdRegistroSelecionado);
    if StatusTela = stEditando then
      ObjetoOldVO := ObjetoController.VO<TFolhaTipoAfastamentoVO>(IdRegistroSelecionado);
  end;

  if Assigned(ObjetoVO) then
  begin
    EditCodigo.Text := TFolhaTipoAfastamentoVO(ObjetoVO).Codigo;
    EditNome.Text := TFolhaTipoAfastamentoVO(ObjetoVO).Nome;
    MemoDescricao.Text := TFolhaTipoAfastamentoVO(ObjetoVO).Descricao;
  end;
end;
{$ENDREGION}

end.
