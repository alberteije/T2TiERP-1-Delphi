{ *******************************************************************************
  Title: T2Ti ERP
  Description: Janela Configura��o do boleto

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

  @author Albert Eije (t2ti.com@gmail.com)
  @version 1.0
  ******************************************************************************* }
unit UFinConfiguracaoBoleto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UTelaCadastro, DB, DBClient, Menus, StdCtrls, ExtCtrls, Buttons, Grids,
  DBGrids, JvExDBGrids, JvDBGrid, JvDBUltimGrid, ComCtrls, FinConfiguracaoBoletoVO,
  FinConfiguracaoBoletoController, Tipos, Atributos, Constantes, LabeledCtrls, JvToolEdit,
  Mask, JvExMask, JvBaseEdits, Math, StrUtils, ActnList, Generics.Collections,
  RibbonSilverStyleActnCtrls, ActnMan, ToolWin, ActnCtrls, ShellApi, ACBrBoleto;

type
  [TFormDescription(TConstantes.MODULO_CONTAS_RECEBER, 'Configura��es do Boleto')]

  TFFinConfiguracaoBoleto = class(TFTelaCadastro)
    PanelParcelas: TPanel;
    PanelMestre: TPanel;
    EditInstrucao01: TLabeledEdit;
    EditTaxaMulta: TLabeledCalcEdit;
    EditIdContaCaixa: TLabeledCalcEdit;
    EditContaCaixa: TLabeledEdit;
    EditInstrucao02: TLabeledEdit;
    EditCaminhoArquivoRemessa: TLabeledEdit;
    SpeedButton1: TSpeedButton;
    EditCaminhoArquivoRetorno: TLabeledEdit;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    EditCaminhoArquivoLogotipoBanco: TLabeledEdit;
    SpeedButton4: TSpeedButton;
    EditCaminhoArquivoPdfBoleto: TLabeledEdit;
    MemoMensagem: TLabeledMemo;
    EditLocalPagamento: TLabeledEdit;
    ComboBoxLayoutRemessa: TLabeledComboBox;
    ComboBoxAceite: TLabeledComboBox;
    ComboBoxEspecie: TLabeledComboBox;
    EditCarteira: TLabeledEdit;
    EditCodigoConvenio: TLabeledEdit;
    EditCodigoCedente: TLabeledEdit;
    procedure FormCreate(Sender: TObject);
    procedure EditIdContaCaixaExit(Sender: TObject);
    procedure EditIdContaCaixaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditIdContaCaixaKeyPress(Sender: TObject; var Key: Char);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
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
  FFinConfiguracaoBoleto: TFFinConfiguracaoBoleto;

implementation

uses ULookup, Biblioteca, UDataModule, ContaCaixaVO, ContaCaixaController;
{$R *.dfm}

{$REGION 'Infra'}
procedure TFFinConfiguracaoBoleto.FormCreate(Sender: TObject);
begin
  ClasseObjetoGridVO := TFinConfiguracaoBoletoVO;
  ObjetoController := TFinConfiguracaoBoletoController.Create;

  inherited;
end;

procedure TFFinConfiguracaoBoleto.SpeedButton1Click(Sender: TObject);
begin
  FDataModule.Folder.Execute;
  EditCaminhoArquivoRemessa.Text := StringReplace(FDataModule.Folder.Directory,'\','/',[rfReplaceAll]) + '/';
end;

procedure TFFinConfiguracaoBoleto.SpeedButton2Click(Sender: TObject);
begin
  FDataModule.Folder.Execute;
  EditCaminhoArquivoRetorno.Text := StringReplace(FDataModule.Folder.Directory,'\','/',[rfReplaceAll]) + '/';
end;

procedure TFFinConfiguracaoBoleto.SpeedButton3Click(Sender: TObject);
begin
  FDataModule.Folder.Execute;
  EditCaminhoArquivoLogotipoBanco.Text := StringReplace(FDataModule.Folder.Directory,'\','/',[rfReplaceAll]) + '/';
end;

procedure TFFinConfiguracaoBoleto.SpeedButton4Click(Sender: TObject);
begin
  FDataModule.Folder.Execute;
  EditCaminhoArquivoPdfBoleto.Text := StringReplace(FDataModule.Folder.Directory,'\','/',[rfReplaceAll]) + '/';
end;
{$ENDREGION}

{$REGION 'Controles CRUD'}
function TFFinConfiguracaoBoleto.DoInserir: Boolean;
begin
  Result := inherited DoInserir;

  if Result then
  begin
    EditIdContaCaixa.SetFocus;
  end;
end;

function TFFinConfiguracaoBoleto.DoEditar: Boolean;
begin
  Result := inherited DoEditar;

  if Result then
  begin
    EditIdContaCaixa.SetFocus;
  end;
end;

function TFFinConfiguracaoBoleto.DoExcluir: Boolean;
begin
  if inherited DoExcluir then
  begin
    try
      Result := TFinConfiguracaoBoletoController(ObjetoController).Exclui(IdRegistroSelecionado);
    except
      Result := False;
    end;
  end
  else
  begin
    Result := False;
  end;

  if Result then
    TFinConfiguracaoBoletoController(ObjetoController).Consulta(Filtro, Pagina);
end;

function TFFinConfiguracaoBoleto.DoSalvar: Boolean;
begin
  Result := inherited DoSalvar;

  if Result then
  begin
    try
      if not Assigned(ObjetoVO) then
        ObjetoVO := TFinConfiguracaoBoletoVO.Create;

      TFinConfiguracaoBoletoVO(ObjetoVO).IdEmpresa := Sessao.IdEmpresa;
      TFinConfiguracaoBoletoVO(ObjetoVO).IdContaCaixa := EditIdContaCaixa.AsInteger;
      TFinConfiguracaoBoletoVO(ObjetoVO).ContaCaixaNome := EditContaCaixa.Text;
      TFinConfiguracaoBoletoVO(ObjetoVO).Instrucao01 := EditInstrucao01.Text;
      TFinConfiguracaoBoletoVO(ObjetoVO).Instrucao02 := EditInstrucao02.Text;
      TFinConfiguracaoBoletoVO(ObjetoVO).CaminhoArquivoRemessa := EditCaminhoArquivoRemessa.Text;
      TFinConfiguracaoBoletoVO(ObjetoVO).CaminhoArquivoRetorno := EditCaminhoArquivoRetorno.Text;
      TFinConfiguracaoBoletoVO(ObjetoVO).CaminhoArquivoLogotipo := EditCaminhoArquivoLogotipoBanco.Text;
      TFinConfiguracaoBoletoVO(ObjetoVO).CaminhoArquivoPdf := EditCaminhoArquivoPdfBoleto.Text;
      TFinConfiguracaoBoletoVO(ObjetoVO).Mensagem := MemoMensagem.Text;
      TFinConfiguracaoBoletoVO(ObjetoVO).LocalPagamento := EditLocalPagamento.Text;
      TFinConfiguracaoBoletoVO(ObjetoVO).LayoutRemessa := ComboBoxLayoutRemessa.Text;
      TFinConfiguracaoBoletoVO(ObjetoVO).Aceite := IfThen(ComboBoxAceite.ItemIndex = 0, 'S', 'N');
      TFinConfiguracaoBoletoVO(ObjetoVO).Especie := Copy(ComboBoxEspecie.Text, 1, 2);
      TFinConfiguracaoBoletoVO(ObjetoVO).Carteira := EditCarteira.Text;
      TFinConfiguracaoBoletoVO(ObjetoVO).CodigoConvenio := EditCodigoConvenio.Text;
      TFinConfiguracaoBoletoVO(ObjetoVO).CodigoCedente := EditCodigoCedente.Text;
      TFinConfiguracaoBoletoVO(ObjetoVO).TaxaMulta := EditTaxaMulta.Value;

      if StatusTela = stEditando then
        TFinConfiguracaoBoletoVO(ObjetoVO).Id := IdRegistroSelecionado;

      // ObjetoVO - libera objetos vinculados (TAssociation) - n�o tem necessidade de subir
      TFinConfiguracaoBoletoVO(ObjetoVO).ContaCaixaVO := Nil;
      if Assigned(ObjetoOldVO) then
      begin
        TFinConfiguracaoBoletoVO(ObjetoOldVO).ContaCaixaVO := Nil;
      end;

      if StatusTela = stInserindo then
        Result := TFinConfiguracaoBoletoController(ObjetoController).Insere(TFinConfiguracaoBoletoVO(ObjetoVO))
      else if StatusTela = stEditando then
      begin
        if TFinConfiguracaoBoletoVO(ObjetoVO).ToJSONString <> TFinConfiguracaoBoletoVO(ObjetoOldVO).ToJSONString then
        begin
          Result := TFinConfiguracaoBoletoController(ObjetoController).Altera(TFinConfiguracaoBoletoVO(ObjetoVO), TFinConfiguracaoBoletoVO(ObjetoOldVO));
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
procedure TFFinConfiguracaoBoleto.GridParaEdits;
begin
  inherited;

  if not CDSGrid.IsEmpty then
  begin
    ObjetoVO := ObjetoController.VO<TFinConfiguracaoBoletoVO>(IdRegistroSelecionado);
    if StatusTela = stEditando then
      ObjetoOldVO := ObjetoController.VO<TFinConfiguracaoBoletoVO>(IdRegistroSelecionado);
  end;

  if Assigned(ObjetoVO) then
  begin
    EditIdContaCaixa.AsInteger := TFinConfiguracaoBoletoVO(ObjetoVO).IdContaCaixa;
    EditContaCaixa.Text := TFinConfiguracaoBoletoVO(ObjetoVO).ContaCaixaNome;
    EditInstrucao01.Text := TFinConfiguracaoBoletoVO(ObjetoVO).Instrucao01;
    EditInstrucao02.Text := TFinConfiguracaoBoletoVO(ObjetoVO).Instrucao02;
    EditCaminhoArquivoRemessa.Text := TFinConfiguracaoBoletoVO(ObjetoVO).CaminhoArquivoRemessa;
    EditCaminhoArquivoRetorno.Text := TFinConfiguracaoBoletoVO(ObjetoVO).CaminhoArquivoRetorno;
    EditCaminhoArquivoLogotipoBanco.Text := TFinConfiguracaoBoletoVO(ObjetoVO).CaminhoArquivoLogotipo;
    EditCaminhoArquivoPdfBoleto.Text := TFinConfiguracaoBoletoVO(ObjetoVO).CaminhoArquivoPdf;
    MemoMensagem.Text := TFinConfiguracaoBoletoVO(ObjetoVO).Mensagem;
    EditLocalPagamento.Text := TFinConfiguracaoBoletoVO(ObjetoVO).LocalPagamento;
    ComboBoxLayoutRemessa.Text := TFinConfiguracaoBoletoVO(ObjetoVO).LayoutRemessa;
    ComboBoxAceite.ItemIndex := AnsiIndexStr(TFinConfiguracaoBoletoVO(ObjetoVO).Aceite, ['S', 'N']);
    ComboBoxEspecie.ItemIndex := AnsiIndexStr(TFinConfiguracaoBoletoVO(ObjetoVO).Especie, ['DM', 'DS', 'RC', 'NP']);
    EditCarteira.Text := TFinConfiguracaoBoletoVO(ObjetoVO).Carteira;
    EditCodigoConvenio.Text := TFinConfiguracaoBoletoVO(ObjetoVO).CodigoConvenio;
    EditCodigoCedente.Text := TFinConfiguracaoBoletoVO(ObjetoVO).CodigoCedente;
    EditTaxaMulta.Value := TFinConfiguracaoBoletoVO(ObjetoVO).TaxaMulta;
  end;
end;
{$ENDREGION}

{$REGION 'Campos Transientes'}
procedure TFFinConfiguracaoBoleto.EditIdContaCaixaExit(Sender: TObject);
var
  Filtro: String;
begin
  if EditIdContaCaixa.Value <> 0 then
  begin
    try
      Filtro := 'ID = ' + EditIdContaCaixa.Text;
      EditIdContaCaixa.Clear;
      EditContaCaixa.Clear;
      if not PopulaCamposTransientes(Filtro, TContaCaixaVO, TContaCaixaController) then
        PopulaCamposTransientesLookup(TContaCaixaVO, TContaCaixaController);
      if CDSTransiente.RecordCount > 0 then
      begin
        EditIdContaCaixa.Text := CDSTransiente.FieldByName('ID').AsString;
        EditContaCaixa.Text := CDSTransiente.FieldByName('NOME').AsString;
      end
      else
      begin
        Exit;
        EditIdContaCaixa.SetFocus;
      end;
    finally
      CDSTransiente.Close;
    end;
  end
  else
  begin
    EditContaCaixa.Clear;
  end;
end;

procedure TFFinConfiguracaoBoleto.EditIdContaCaixaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditIdContaCaixa.Value := -1;
    EditInstrucao01.SetFocus;
  end;
end;

procedure TFFinConfiguracaoBoleto.EditIdContaCaixaKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    EditInstrucao01.SetFocus;
  end;
end;
{$ENDREGION}

end.
