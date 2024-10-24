{ *******************************************************************************
  Title: T2Ti ERP
  Description: Janela de Cadastro das Ap�lices de Seguro - Patrim�nio

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
unit UPatrimApoliceSeguro;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UTelaCadastro, Menus, StdCtrls, ExtCtrls, Buttons, Grids, DBGrids,
  JvExDBGrids, JvDBGrid, JvDBUltimGrid, ComCtrls, LabeledCtrls, Atributos, Constantes,
  Mask, JvExMask, JvToolEdit, JvBaseEdits, StrUtils, pngimage, ActnList,
  PlatformDefaultStyleActnCtrls, ActnMan, ToolWin, ActnCtrls, ShellApi;

type
  [TFormDescription(TConstantes.MODULO_PATRIMONIO, 'Ap�lice de Seguro')]

  TFPatrimApoliceSeguro = class(TFTelaCadastro)
    BevelEdits: TBevel;
    EditIdBem: TLabeledCalcEdit;
    EditNomeBem: TLabeledEdit;
    EditIdSeguradora: TLabeledCalcEdit;
    EditNomeSeguradora: TLabeledEdit;
    EditDataContratacao: TLabeledDateEdit;
    EditDataVencimento: TLabeledDateEdit;
    EditNumero: TLabeledEdit;
    EditValorPremio: TLabeledCalcEdit;
    EditValorSegurado: TLabeledCalcEdit;
    MemoObservacao: TLabeledMemo;
    ActionManager1: TActionManager;
    ActionAcionarGed: TAction;
    ActionToolBar1: TActionToolBar;
    procedure FormCreate(Sender: TObject);
    procedure EditIdBemKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditIdSeguradoraKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ActionAcionarGedExecute(Sender: TObject);
    procedure EditIdBemKeyPress(Sender: TObject; var Key: Char);
    procedure EditIdBemExit(Sender: TObject);
    procedure EditIdSeguradoraExit(Sender: TObject);
    procedure EditIdSeguradoraKeyPress(Sender: TObject; var Key: Char);
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
  FPatrimApoliceSeguro: TFPatrimApoliceSeguro;

implementation

uses PatrimApoliceSeguroController, PatrimApoliceSeguroVO, SeguradoraVO,
  ULookup, UDataModule, PatrimBemVO, PatrimBemController, SeguradoraController;
{$R *.dfm}

{$REGION 'Infra'}
procedure TFPatrimApoliceSeguro.FormCreate(Sender: TObject);
begin
  ClasseObjetoGridVO := TPatrimApoliceSeguroVO;
  ObjetoController := TPatrimApoliceSeguroController.Create;

  inherited;
end;
{$ENDREGION

{$REGION 'Controles CRUD'}
function TFPatrimApoliceSeguro.DoInserir: Boolean;
begin
  Result := inherited DoInserir;

  if Result then
  begin
    EditIdBem.SetFocus;
  end;
end;

function TFPatrimApoliceSeguro.DoEditar: Boolean;
begin
  Result := inherited DoEditar;

  if Result then
  begin
    EditIdBem.SetFocus;
  end;
end;

function TFPatrimApoliceSeguro.DoExcluir: Boolean;
begin
  if inherited DoExcluir then
  begin
    try
      Result := TPatrimApoliceSeguroController(ObjetoController).Exclui(IdRegistroSelecionado);
    except
      Result := False;
    end;
  end
  else
  begin
    Result := False;
  end;

  if Result then
    TPatrimApoliceSeguroController(ObjetoController).Consulta(Filtro, Pagina);
end;

function TFPatrimApoliceSeguro.DoSalvar: Boolean;
begin
  Result := inherited DoSalvar;

  if Result then
  begin
    try
      if not Assigned(ObjetoVO) then
        ObjetoVO := TPatrimApoliceSeguroVO.Create;

      TPatrimApoliceSeguroVO(ObjetoVO).IdPatrimBem := EditIdBem.AsInteger;
      TPatrimApoliceSeguroVO(ObjetoVO).PatrimBemNome := EditNomeBem.Text;
      TPatrimApoliceSeguroVO(ObjetoVO).IdSeguradora := EditIdSeguradora.AsInteger;
      TPatrimApoliceSeguroVO(ObjetoVO).SeguradoraNome := EditNomeSeguradora.Text;
      TPatrimApoliceSeguroVO(ObjetoVO).Numero := EditNumero.Text;
      TPatrimApoliceSeguroVO(ObjetoVO).DataContratacao := EditDataContratacao.Date;
      TPatrimApoliceSeguroVO(ObjetoVO).DataVencimento := EditDataVencimento.Date;
      TPatrimApoliceSeguroVO(ObjetoVO).ValorPremio := EditValorPremio.Value;
      TPatrimApoliceSeguroVO(ObjetoVO).ValorSegurado := EditValorSegurado.Value;
      TPatrimApoliceSeguroVO(ObjetoVO).Observacao := MemoObservacao.Text;
      TPatrimApoliceSeguroVO(ObjetoVO).Imagem := 'PATRIMONIO_APOLICE_' + EditNumero.Text;

      if StatusTela = stInserindo then
        Result := TPatrimApoliceSeguroController(ObjetoController).Insere(TPatrimApoliceSeguroVO(ObjetoVO))
      else if StatusTela = stEditando then
        if TPatrimApoliceSeguroVO(ObjetoVO).ToJSONString <> TPatrimApoliceSeguroVO(ObjetoOldVO).ToJSONString then
        begin
          TPatrimApoliceSeguroVO(ObjetoVO).Id := IdRegistroSelecionado;
          Result := TPatrimApoliceSeguroController(ObjetoController).Altera(TPatrimApoliceSeguroVO(ObjetoVO), TPatrimApoliceSeguroVO(ObjetoOldVO));
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
procedure TFPatrimApoliceSeguro.EditIdBemExit(Sender: TObject);
var
  Filtro: String;
begin
  if EditIdBem.Value <> 0 then
  begin
    try
      Filtro := 'ID = ' + EditIdBem.Text;
      EditIdBem.Clear;
      EditNomeBem.Clear;
      if not PopulaCamposTransientes(Filtro, TPatrimBemVO, TPatrimBemController) then
        PopulaCamposTransientesLookup(TPatrimBemVO, TPatrimBemController);
      if CDSTransiente.RecordCount > 0 then
      begin
        EditIdBem.Text := CDSTransiente.FieldByName('ID').AsString;
        EditNomeBem.Text := CDSTransiente.FieldByName('NOME').AsString;
      end
      else
      begin
        Exit;
        EditIdBem.SetFocus;
      end;
    finally
      CDSTransiente.Close;
    end;
  end
  else
  begin
    EditNomeBem.Clear;
  end;
end;

procedure TFPatrimApoliceSeguro.EditIdBemKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditIdBem.Value := -1;
    EditIdSeguradora.SetFocus;
  end;
end;

procedure TFPatrimApoliceSeguro.EditIdBemKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    EditIdSeguradora.SetFocus;
  end;
end;

procedure TFPatrimApoliceSeguro.EditIdSeguradoraExit(Sender: TObject);
var
  Filtro: String;
begin
  if EditIdSeguradora.Value <> 0 then
  begin
    try
      Filtro := 'ID = ' + EditIdSeguradora.Text;
      EditIdSeguradora.Clear;
      EditNomeSeguradora.Clear;
      if not PopulaCamposTransientes(Filtro, TSeguradoraVO, TSeguradoraController) then
        PopulaCamposTransientesLookup(TSeguradoraVO, TSeguradoraController);
      if CDSTransiente.RecordCount > 0 then
      begin
        EditIdSeguradora.Text := CDSTransiente.FieldByName('ID').AsString;
        EditNomeSeguradora.Text := CDSTransiente.FieldByName('NOME').AsString;
      end
      else
      begin
        Exit;
        EditIdSeguradora.SetFocus;
      end;
    finally
      CDSTransiente.Close;
    end;
  end
  else
  begin
    EditNomeSeguradora.Clear;
  end;
end;

procedure TFPatrimApoliceSeguro.EditIdSeguradoraKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditIdSeguradora.Value := -1;
    EditNumero.SetFocus;
  end;
end;

procedure TFPatrimApoliceSeguro.EditIdSeguradoraKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    EditNumero.SetFocus;
  end;
end;
{$ENDREGION}

{$REGION 'Controle de Grid'}
procedure TFPatrimApoliceSeguro.GridParaEdits;
begin
  inherited;

  if not CDSGrid.IsEmpty then
  begin
    ObjetoVO := ObjetoController.VO<TPatrimApoliceSeguroVO>(IdRegistroSelecionado);
    if StatusTela = stEditando then
      ObjetoOldVO := ObjetoController.VO<TPatrimApoliceSeguroVO>(IdRegistroSelecionado);
  end;

  if Assigned(ObjetoVO) then
  begin
    EditIdBem.AsInteger := TPatrimApoliceSeguroVO(ObjetoVO).IdPatrimBem;
    EditNomeBem.Text := TPatrimApoliceSeguroVO(ObjetoVO).PatrimBemNome;
    EditIdSeguradora.AsInteger := TPatrimApoliceSeguroVO(ObjetoVO).IdSeguradora;
    EditNomeSeguradora.Text := TPatrimApoliceSeguroVO(ObjetoVO).SeguradoraNome;
    EditNumero.Text := TPatrimApoliceSeguroVO(ObjetoVO).Numero;
    EditDataContratacao.Date := TPatrimApoliceSeguroVO(ObjetoVO).DataContratacao;
    EditDataVencimento.Date := TPatrimApoliceSeguroVO(ObjetoVO).DataVencimento;
    EditValorPremio.Value := TPatrimApoliceSeguroVO(ObjetoVO).ValorPremio;
    EditValorSegurado.Value := TPatrimApoliceSeguroVO(ObjetoVO).ValorSegurado;
    MemoObservacao.Text := TPatrimApoliceSeguroVO(ObjetoVO).Observacao;
  end;
end;
{$ENDREGION}

{$REGION 'Actions'}
procedure TFPatrimApoliceSeguro.ActionAcionarGedExecute(Sender: TObject);
var
  Parametros: String;
begin
  if EditNumero.Text <> '' then
  begin
    {
      Parametros
      1 - Login
      2 - Senha
      3 - Aplica��o que chamou
      4 - Nome do arquivo (Aplicacao que chamou + Tela que chamou + Numero Ap�lice
      }

    try
      Parametros := Sessao.Usuario.Login + ' ' +
                    Sessao.Usuario.Senha + ' ' +
                    'PATRIMONIO' + ' ' +
                    'PATRIMONIO_APOLICE_' + EditNumero.Text;
      ShellExecute(
            Handle,
            'open',
            'T2TiERPGed.exe',
            PChar(Parametros),
            '',
            SW_SHOWNORMAL
            );
    except
      Application.MessageBox('Erro ao tentar executar o m�dulo.', 'Erro do Sistema', MB_OK + MB_ICONERROR);
    end;
  end
  else
  begin
    Application.MessageBox('� preciso informar o n�mero da ap�lice.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
    EditNumero.SetFocus;
  end;
end;
{$ENDREGION}

end.
