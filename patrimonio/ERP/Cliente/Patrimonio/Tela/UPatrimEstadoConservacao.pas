{ *******************************************************************************
  Title: T2Ti ERP
  Description: Janela de Cadastro do Estado de Conserva��o dos Bens - M�dulo Patrim�nio

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
  t2ti.com@gmail.com

  @author Albert Eije (alberteije@gmail.com)
  @version 1.0
  ******************************************************************************* }
unit UPatrimEstadoConservacao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UTelaCadastro, Menus, StdCtrls, ExtCtrls, Buttons, Grids, DBGrids,
  JvExDBGrids, JvDBGrid, JvDBUltimGrid, ComCtrls, LabeledCtrls, Atributos, Constantes,
  Mask, JvExMask, JvToolEdit, JvBaseEdits, Biblioteca;

type
  [TFormDescription(TConstantes.MODULO_PATRIMONIO, 'Estado Conserva��o Bem')]

  TFPatrimEstadoConservacao = class(TFTelaCadastro)
    EditNome: TLabeledEdit;
    MemoDescricao: TLabeledMemo;
    BevelEdits: TBevel;
    EditCodigo: TLabeledEdit;
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
  FPatrimEstadoConservacao: TFPatrimEstadoConservacao;

implementation

uses PatrimEstadoConservacaoController, PatrimEstadoConservacaoVo, NotificationService;
{$R *.dfm}

{$REGION 'Infra'}
procedure TFPatrimEstadoConservacao.FormCreate(Sender: TObject);
begin
  ClasseObjetoGridVO := TPatrimEstadoConservacaoVO;
  ObjetoController := TPatrimEstadoConservacaoController.Create;

  inherited;
end;
{$ENDREGION}

{$REGION 'Controles CRUD'}
function TFPatrimEstadoConservacao.DoInserir: Boolean;
begin
  Result := inherited DoInserir;

  if Result then
  begin
    EditCodigo.ReadOnly := False;
    EditNome.ReadOnly := False;
    EditCodigo.SetFocus;
  end;
end;

function TFPatrimEstadoConservacao.DoEditar: Boolean;
begin
  Result := inherited DoEditar;

  if Result then
  begin
    if VerificaInteiro(CDSGrid.FieldByName('CODIGO').AsString) and (CDSGrid.FieldByName('CODIGO').AsInteger in [1, 2, 3, 4]) then
    begin
      EditCodigo.ReadOnly := True;
      EditNome.ReadOnly := True;
    end
    else
    begin
      EditCodigo.ReadOnly := False;
      EditNome.ReadOnly := False;
    end;
    EditCodigo.SetFocus;
  end;
end;

function TFPatrimEstadoConservacao.DoExcluir: Boolean;
begin
  if inherited DoExcluir then
  begin
    if VerificaInteiro(CDSGrid.FieldByName('CODIGO').AsString) and (CDSGrid.FieldByName('CODIGO').AsInteger in [1, 2, 3, 4]) then
    begin
      Application.MessageBox('Esse registro n�o pode ser exclu�do.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
      Exit(False);
    end;
    //
    try
      Result := TPatrimEstadoConservacaoController(ObjetoController).Exclui(IdRegistroSelecionado);
    except
      Result := False;
    end;
  end
  else
  begin
    Result := False;
  end;

  if Result then
    TPatrimEstadoConservacaoController(ObjetoController).Consulta(Filtro, Pagina);
end;

function TFPatrimEstadoConservacao.DoSalvar: Boolean;
begin
  Result := inherited DoSalvar;

  if Result then
  begin
    try
      if not Assigned(ObjetoVO) then
        ObjetoVO := TPatrimEstadoConservacaoVO.Create;

      TPatrimEstadoConservacaoVO(ObjetoVO).IdEmpresa := Sessao.IdEmpresa;
      TPatrimEstadoConservacaoVO(ObjetoVO).Codigo := EditCodigo.Text;
      TPatrimEstadoConservacaoVO(ObjetoVO).Nome := EditNome.Text;
      TPatrimEstadoConservacaoVO(ObjetoVO).Descricao := MemoDescricao.Text;

      if StatusTela = stInserindo then
        Result := TPatrimEstadoConservacaoController(ObjetoController).Insere(TPatrimEstadoConservacaoVO(ObjetoVO))
      else if StatusTela = stEditando then
        if TPatrimEstadoConservacaoVO(ObjetoVO).ToJSONString <> TPatrimEstadoConservacaoVO(ObjetoOldVO).ToJSONString then
        begin
          TPatrimEstadoConservacaoVO(ObjetoVO).Id := IdRegistroSelecionado;
          Result := TPatrimEstadoConservacaoController(ObjetoController).Altera(TPatrimEstadoConservacaoVO(ObjetoVO), TPatrimEstadoConservacaoVO(ObjetoOldVO));
        end
        else
          Application.MessageBox('Nenhum dado foi alterado.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
    except
      Result := False;
    end;
  end;
end;
{$ENDREGION}

{$REGION 'Controle de Grid'}
procedure TFPatrimEstadoConservacao.GridParaEdits;
begin
  inherited;

  if not CDSGrid.IsEmpty then
  begin
    ObjetoVO := ObjetoController.VO<TPatrimEstadoConservacaoVO>(IdRegistroSelecionado);
    if StatusTela = stEditando then
      ObjetoOldVO := ObjetoController.VO<TPatrimEstadoConservacaoVO>(IdRegistroSelecionado);
  end;

  if Assigned(ObjetoVO) then
  begin
    EditCodigo.Text := TPatrimEstadoConservacaoVO(ObjetoVO).Codigo;
    EditNome.Text := TPatrimEstadoConservacaoVO(ObjetoVO).Nome;
    MemoDescricao.Text := TPatrimEstadoConservacaoVO(ObjetoVO).Descricao;
  end;
end;
{$ENDREGION}

end.
