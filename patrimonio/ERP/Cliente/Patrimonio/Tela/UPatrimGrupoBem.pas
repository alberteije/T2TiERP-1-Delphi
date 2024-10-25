{ *******************************************************************************
  Title: T2Ti ERP
  Description: Janela de Cadastro do Grupo do Bem - M�dulo Patrim�nio

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
unit UPatrimGrupoBem;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UTelaCadastro, Menus, StdCtrls, ExtCtrls, Buttons, Grids, DBGrids,
  JvExDBGrids, JvDBGrid, JvDBUltimGrid, ComCtrls, LabeledCtrls, Atributos, Constantes,
  Mask, JvExMask, JvToolEdit, JvBaseEdits;

type
  [TFormDescription(TConstantes.MODULO_PATRIMONIO, 'Grupo Bem')]

  TFPatrimGrupoBem = class(TFTelaCadastro)
    EditNome: TLabeledEdit;
    MemoDescricao: TLabeledMemo;
    BevelEdits: TBevel;
    EditCodigo: TLabeledEdit;
    EditContaAtivoImobilizadoDescricao: TLabeledEdit;
    EditContaAtivoImobilizado: TLabeledEdit;
    EditContaDepreciacaoAcumulada: TLabeledEdit;
    EditContaDepreciacaoAcumuladaDescricao: TLabeledEdit;
    EditContaDespesaDepreciacao: TLabeledEdit;
    EditContaDespesaDepreciacaoDescricao: TLabeledEdit;
    EditCodigoHistorico: TLabeledEdit;
    EditCodigoHistoricoDescricao: TLabeledEdit;
    procedure FormCreate(Sender: TObject);
    procedure EditContaAtivoImobilizadoExit(Sender: TObject);
    procedure EditContaAtivoImobilizadoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditContaAtivoImobilizadoKeyPress(Sender: TObject; var Key: Char);
    procedure EditContaDepreciacaoAcumuladaExit(Sender: TObject);
    procedure EditContaDepreciacaoAcumuladaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditContaDepreciacaoAcumuladaKeyPress(Sender: TObject; var Key: Char);
    procedure EditContaDespesaDepreciacaoKeyPress(Sender: TObject; var Key: Char);
    procedure EditContaDespesaDepreciacaoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditContaDespesaDepreciacaoExit(Sender: TObject);
    procedure EditCodigoHistoricoExit(Sender: TObject);
    procedure EditCodigoHistoricoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditCodigoHistoricoKeyPress(Sender: TObject; var Key: Char);
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
  FPatrimGrupoBem: TFPatrimGrupoBem;

implementation

uses PatrimGrupoBemController, PatrimGrupoBemVo, ContabilContaVO, ContabilContaController,
ContabilHistoricoVO, ContabilHistoricoController;
{$R *.dfm}

{$REGION 'Infra'}
procedure TFPatrimGrupoBem.FormCreate(Sender: TObject);
begin
  ClasseObjetoGridVO := TPatrimGrupoBemVO;
  ObjetoController := TPatrimGrupoBemController.Create;

  inherited;
end;
{$ENDREGION}

{$REGION 'Controles CRUD'}
function TFPatrimGrupoBem.DoInserir: Boolean;
begin
  Result := inherited DoInserir;

  if Result then
  begin
    EditCodigo.SetFocus;
  end;
end;

function TFPatrimGrupoBem.DoEditar: Boolean;
begin
  Result := inherited DoEditar;

  if Result then
  begin
    EditCodigo.SetFocus;
  end;
end;

function TFPatrimGrupoBem.DoExcluir: Boolean;
begin
  if inherited DoExcluir then
  begin
    try
      Result := TPatrimGrupoBemController(ObjetoController).Exclui(IdRegistroSelecionado);
    except
      Result := False;
    end;
  end
  else
  begin
    Result := False;
  end;

  if Result then
    TPatrimGrupoBemController(ObjetoController).Consulta(Filtro, Pagina);
end;

function TFPatrimGrupoBem.DoSalvar: Boolean;
begin
  Result := inherited DoSalvar;

  if Result then
  begin
    try
      if not Assigned(ObjetoVO) then
        ObjetoVO := TPatrimGrupoBemVO.Create;

      TPatrimGrupoBemVO(ObjetoVO).IdEmpresa := Sessao.IdEmpresa;
      TPatrimGrupoBemVO(ObjetoVO).Codigo := EditCodigo.Text;
      TPatrimGrupoBemVO(ObjetoVO).Nome := EditNome.Text;
      TPatrimGrupoBemVO(ObjetoVO).Descricao := MemoDescricao.Text;
      TPatrimGrupoBemVO(ObjetoVO).ContaAtivoImobilizado := EditContaAtivoImobilizado.Text;
      TPatrimGrupoBemVO(ObjetoVO).DescricaoContaAtivoImobilizado := EditContaAtivoImobilizadoDescricao.Text;
      TPatrimGrupoBemVO(ObjetoVO).ContaDepreciacaoAcumulada := EditContaDepreciacaoAcumulada.Text;
      TPatrimGrupoBemVO(ObjetoVO).DescricaoContaDepreciacaoAcumulada := EditContaDepreciacaoAcumuladaDescricao.Text;
      TPatrimGrupoBemVO(ObjetoVO).ContaDespesaDepreciacao := EditContaDespesaDepreciacao.Text;
      TPatrimGrupoBemVO(ObjetoVO).DescricaoContaDespesaDepreciacao := EditContaDespesaDepreciacaoDescricao.Text;
      TPatrimGrupoBemVO(ObjetoVO).CodigoHistorico := StrToInt(EditCodigoHistorico.Text);
      TPatrimGrupoBemVO(ObjetoVO).DescricaoHistorico := EditCodigoHistoricoDescricao.Text;

      // ObjetoVO - libera objetos vinculados (TAssociation) - n�o tem necessidade de subir
      TPatrimGrupoBemVO(ObjetoVO).DescricaoContaAtivoImobilizadoVO := Nil;
      TPatrimGrupoBemVO(ObjetoVO).DescricaoContaDepreciacaoAcumuladaVO := Nil;
      TPatrimGrupoBemVO(ObjetoVO).DescricaoContaDespesaDepreciacaoVO := Nil;
      TPatrimGrupoBemVO(ObjetoVO).DescricaoHistoricoVO := Nil;

      // ObjetoOldVO - libera objetos vinculados (TAssociation) - n�o tem necessidade de subir
      if Assigned(ObjetoOldVO) then
      begin
        TPatrimGrupoBemVO(ObjetoOldVO).DescricaoContaAtivoImobilizadoVO := Nil;
        TPatrimGrupoBemVO(ObjetoOldVO).DescricaoContaDepreciacaoAcumuladaVO := Nil;
        TPatrimGrupoBemVO(ObjetoOldVO).DescricaoContaDespesaDepreciacaoVO := Nil;
        TPatrimGrupoBemVO(ObjetoOldVO).DescricaoHistoricoVO := Nil;
      end;

      if StatusTela = stInserindo then
        Result := TPatrimGrupoBemController(ObjetoController).Insere(TPatrimGrupoBemVO(ObjetoVO))
      else if StatusTela = stEditando then
        if TPatrimGrupoBemVO(ObjetoVO).ToJSONString <> TPatrimGrupoBemVO(ObjetoOldVO).ToJSONString then
        begin
          TPatrimGrupoBemVO(ObjetoVO).Id := IdRegistroSelecionado;
          Result := TPatrimGrupoBemController(ObjetoController).Altera(TPatrimGrupoBemVO(ObjetoVO), TPatrimGrupoBemVO(ObjetoOldVO));
        end
        else
          Application.MessageBox('Nenhum dado foi alterado.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
    except
      Result := False;
    end;
  end;
end;
{$ENDREGION}

{$REGION 'Campos Transientes'}
procedure TFPatrimGrupoBem.EditCodigoHistoricoExit(Sender: TObject);
var
  Filtro: String;
begin
  if EditCodigoHistorico.Text <> '' then
  begin
    try
      Filtro := 'ID = ' + QuotedStr(EditCodigoHistorico.Text);
      EditCodigoHistorico.Clear;
      EditCodigoHistoricoDescricao.Clear;
      if not PopulaCamposTransientes(Filtro, TContabilHistoricoVO, TContabilHistoricoController) then
        PopulaCamposTransientesLookup(TContabilHistoricoVO, TContabilHistoricoController);
      if CDSTransiente.RecordCount > 0 then
      begin
        EditCodigoHistorico.Text := CDSTransiente.FieldByName('ID').AsString;
        EditCodigoHistoricoDescricao.Text := CDSTransiente.FieldByName('DESCRICAO').AsString;
      end
      else
      begin
        Exit;
        EditCodigoHistorico.SetFocus;
      end;
    finally
      CDSTransiente.Close;
    end;
  end
  else
  begin
    EditCodigoHistoricoDescricao.Clear;
  end;
end;

procedure TFPatrimGrupoBem.EditCodigoHistoricoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditCodigoHistorico.Text := ' ';
    EditCodigo.SetFocus;
  end;
end;

procedure TFPatrimGrupoBem.EditCodigoHistoricoKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    EditCodigo.SetFocus;
  end;
end;

procedure TFPatrimGrupoBem.EditContaAtivoImobilizadoExit(Sender: TObject);
var
  Filtro: String;
begin
  if EditContaAtivoImobilizado.Text <> '' then
  begin
    try
      Filtro := 'CLASSIFICACAO = ' + QuotedStr(EditContaAtivoImobilizado.Text);
      EditContaAtivoImobilizado.Clear;
      EditContaAtivoImobilizadoDescricao.Clear;
      if not PopulaCamposTransientes(Filtro, TContabilContaVO, TContabilContaController) then
        PopulaCamposTransientesLookup(TContabilContaVO, TContabilContaController);
      if CDSTransiente.RecordCount > 0 then
      begin
        EditContaAtivoImobilizado.Text := CDSTransiente.FieldByName('CLASSIFICACAO').AsString;
        EditContaAtivoImobilizadoDescricao.Text := CDSTransiente.FieldByName('DESCRICAO').AsString;
      end
      else
      begin
        Exit;
        EditContaAtivoImobilizado.SetFocus;
      end;
    finally
      CDSTransiente.Close;
    end;
  end
  else
  begin
    EditContaAtivoImobilizadoDescricao.Clear;
  end;
end;

procedure TFPatrimGrupoBem.EditContaAtivoImobilizadoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditContaAtivoImobilizado.Text := ' ';
    EditContaDepreciacaoAcumulada.SetFocus;
  end;
end;

procedure TFPatrimGrupoBem.EditContaAtivoImobilizadoKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    EditContaDepreciacaoAcumulada.SetFocus;
  end;
end;

procedure TFPatrimGrupoBem.EditContaDepreciacaoAcumuladaExit(Sender: TObject);
var
  Filtro: String;
begin
  if EditContaDepreciacaoAcumulada.Text <> '' then
  begin
    try
      Filtro := 'CLASSIFICACAO = ' + QuotedStr(EditContaDepreciacaoAcumulada.Text);
      EditContaDepreciacaoAcumulada.Clear;
      EditContaDepreciacaoAcumuladaDescricao.Clear;
      if not PopulaCamposTransientes(Filtro, TContabilContaVO, TContabilContaController) then
        PopulaCamposTransientesLookup(TContabilContaVO, TContabilContaController);
      if CDSTransiente.RecordCount > 0 then
      begin
        EditContaDepreciacaoAcumulada.Text := CDSTransiente.FieldByName('CLASSIFICACAO').AsString;
        EditContaDepreciacaoAcumuladaDescricao.Text := CDSTransiente.FieldByName('DESCRICAO').AsString;
      end
      else
      begin
        Exit;
        EditContaDepreciacaoAcumulada.SetFocus;
      end;
    finally
      CDSTransiente.Close;
    end;
  end
  else
  begin
    EditContaDepreciacaoAcumuladaDescricao.Clear;
  end;
end;

procedure TFPatrimGrupoBem.EditContaDepreciacaoAcumuladaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditContaDepreciacaoAcumulada.Text := ' ';
    EditContaDespesaDepreciacao.SetFocus;
  end;
end;

procedure TFPatrimGrupoBem.EditContaDepreciacaoAcumuladaKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    EditContaDespesaDepreciacao.SetFocus;
  end;
end;

procedure TFPatrimGrupoBem.EditContaDespesaDepreciacaoExit(Sender: TObject);
var
  Filtro: String;
begin
  if EditContaDespesaDepreciacao.Text <> '' then
  begin
    try
      Filtro := 'CLASSIFICACAO = ' + QuotedStr(EditContaDespesaDepreciacao.Text);
      EditContaDespesaDepreciacao.Clear;
      EditContaDespesaDepreciacaoDescricao.Clear;
      if not PopulaCamposTransientes(Filtro, TContabilContaVO, TContabilContaController) then
        PopulaCamposTransientesLookup(TContabilContaVO, TContabilContaController);
      if CDSTransiente.RecordCount > 0 then
      begin
        EditContaDespesaDepreciacao.Text := CDSTransiente.FieldByName('CLASSIFICACAO').AsString;
        EditContaDespesaDepreciacaoDescricao.Text := CDSTransiente.FieldByName('DESCRICAO').AsString;
      end
      else
      begin
        Exit;
        EditContaDespesaDepreciacao.SetFocus;
      end;
    finally
      CDSTransiente.Close;
    end;
  end
  else
  begin
    EditContaDespesaDepreciacaoDescricao.Clear;
  end;
end;

procedure TFPatrimGrupoBem.EditContaDespesaDepreciacaoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditContaDespesaDepreciacao.Text := ' ';
    EditCodigoHistorico.SetFocus;
  end;
end;

procedure TFPatrimGrupoBem.EditContaDespesaDepreciacaoKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    EditCodigoHistorico.SetFocus;
  end;
end;
{$ENDREGION}

{$REGION 'Controle de Grid'}
procedure TFPatrimGrupoBem.GridParaEdits;
begin
  inherited;

  if not CDSGrid.IsEmpty then
  begin
    ObjetoVO := ObjetoController.VO<TPatrimGrupoBemVO>(IdRegistroSelecionado);
    if StatusTela = stEditando then
      ObjetoOldVO := ObjetoController.VO<TPatrimGrupoBemVO>(IdRegistroSelecionado);
  end;

  if Assigned(ObjetoVO) then
  begin
    EditCodigo.Text := TPatrimGrupoBemVO(ObjetoVO).Codigo;
    EditNome.Text := TPatrimGrupoBemVO(ObjetoVO).Nome;
    MemoDescricao.Text := TPatrimGrupoBemVO(ObjetoVO).Descricao;
    EditContaAtivoImobilizado.Text := TPatrimGrupoBemVO(ObjetoVO).ContaAtivoImobilizado;
    EditContaDepreciacaoAcumulada.Text := TPatrimGrupoBemVO(ObjetoVO).ContaDepreciacaoAcumulada;
    EditContaDespesaDepreciacao.Text := TPatrimGrupoBemVO(ObjetoVO).ContaDespesaDepreciacao;
    EditCodigoHistorico.Text := IntToStr(TPatrimGrupoBemVO(ObjetoVO).CodigoHistorico);
    EditContaAtivoImobilizadoDescricao.Text := TPatrimGrupoBemVO(ObjetoVO).DescricaoContaAtivoImobilizado;
    EditContaDepreciacaoAcumuladaDescricao.Text := TPatrimGrupoBemVO(ObjetoVO).DescricaoContaDepreciacaoAcumulada;
    EditContaDespesaDepreciacaoDescricao.Text := TPatrimGrupoBemVO(ObjetoVO).DescricaoContaDespesaDepreciacao;
    EditCodigoHistoricoDescricao.Text := TPatrimGrupoBemVO(ObjetoVO).DescricaoHistorico;
  end;
end;
{$ENDREGION}

end.
