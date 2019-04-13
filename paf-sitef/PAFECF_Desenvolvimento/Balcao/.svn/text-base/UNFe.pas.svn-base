unit UNFe;

interface

uses
  SysUtils, Types, Windows, Classes, Forms, ACBrBase,StdCtrls,
  Controls, ComCtrls, ExtCtrls, ACBrEnterTab, Mask, Graphics, Generics.Collections,
  JvExStdCtrls, Dialogs, JvEdit, JvValidateEdit, Buttons,
  JvButton, JvCtrls, JvExButtons, JvBitBtn, ACBrValidador, JvExMask,
  JvToolEdit, JvExControls, JvLabel, JvGradient, COMObj, Grids, DBGrids,
  JvExDBGrids, JvDBGrid, JvDBUltimGrid, DB, NFeController, NFeDetalheVO,
  NFeCabecalhoVO, ClienteController, PessoaVO, Messages, pngimage,
  JvBaseEdits, JvMaskEdit, ACBrNFe, pcnConversao, ACBrNFeDANFEClass,
  ACBrUtil, pcnNFeW, pcnNFeRTXT, pcnAuxiliar, OleCtrls, SHDocVw, ACBrNFeDANFERave, DateUtils, EmpresaVO;

type
  TFNFe = class(TForm)
    ACBrEnterTab1: TACBrEnterTab;
    ACBrValidador1: TACBrValidador;
    GroupBoxDadosProduto: TGroupBox;
    editCodigo: TEdit;
    editQuantidade: TJvValidateEdit;
    Label1: TLabel;
    Label2: TLabel;
    PanelBotoes: TPanel;
    GroupBoxDadosNota: TGroupBox;
    Label3: TLabel;
    GroupBoxGridItens: TGroupBox;
    GridItens: TJvDBUltimGrid;
    Label4: TLabel;
    editUnitario: TJvValidateEdit;
    EditNome: TLabeledEdit;
    editCpfCnpj: TLabeledEdit;
    GroupBox3: TGroupBox;
    labelDescricaoProduto: TJvLabel;
    GroupBoxResumoOperacao: TGroupBox;
    Bevel4: TBevel;
    Bevel2: TBevel;
    Bevel1: TBevel;
    Label7: TLabel;
    lblSubTotal: TLabel;
    LabelDescontoAcrescimo: TLabel;
    Label6: TLabel;
    lblValorTotal: TLabel;
    editTotalItem: TJvValidateEdit;
    Label5: TLabel;
    Image1: TImage;
    panelF8: TPanel;
    labelF8: TLabel;
    imageF8: TImage;
    panelF12: TPanel;
    labelF12: TLabel;
    imageF12: TImage;
    PanelEsc: TPanel;
    LabelESC: TLabel;
    ImageESC: TImage;
    panelF1: TPanel;
    labelF1: TLabel;
    imageF1: TImage;
    PanelF6: TPanel;
    LabelF6: TLabel;
    ImageF6: TImage;
    panelF10: TPanel;
    labelF10: TLabel;
    imageF10: TImage;
    lblDescAcrescDescricao: TLabel;
    editCodigoCliente: TJvCalcEdit;
    Label9: TLabel;
    editCodigoVendedor: TJvCalcEdit;
    cmbNomeVendedor: TComboBox;
    Label12: TLabel;
    EditDataEmissao: TJvDateEdit;
    Label13: TLabel;
    EditHoraEmissao: TJvMaskEdit;
    PanelF9: TPanel;
    LabelF9: TLabel;
    ImageF9: TImage;
    CheckBoxCFVinculado: TCheckBox;
    GroupBoxDadosCF: TGroupBox;
    EditDataEmissaoCF: TJvDateEdit;
    Label8: TLabel;
    Label10: TLabel;
    EditCOO: TJvCalcEdit;
    EditNumeroCaixa: TJvCalcEdit;
    Label11: TLabel;
    Label14: TLabel;
    EditSerieECF: TEdit;
    EditCFOP: TJvCalcEdit;
    Label15: TLabel;
    RadioGroupOpcoesNFe: TRadioGroup;
    PageControl2: TPageControl;
    TabSheet5: TTabSheet;
    MemoResp: TMemo;
    TabSheet10: TTabSheet;
    memoRespWS: TMemo;
    procedure Soma;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure editCodigoClienteKeyPress(Sender: TObject; var Key: Char);
    procedure editCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure editCodigoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure editCodigoEnter(Sender: TObject);
    procedure editCodigoExit(Sender: TObject);
    procedure panelF1Click(Sender: TObject);
    procedure panelF6Click(Sender: TObject);
    procedure panelF8Click(Sender: TObject);
    procedure panelF10Click(Sender: TObject);
    procedure panelF12Click(Sender: TObject);
    procedure PanelEscClick(Sender: TObject);
    procedure panelF1MouseEnter(Sender: TObject);
    procedure panelF1MouseLeave(Sender: TObject);
    procedure panelF6MouseEnter(Sender: TObject);
    procedure panelF6MouseLeave(Sender: TObject);
    procedure panelF8MouseEnter(Sender: TObject);
    procedure panelF8MouseLeave(Sender: TObject);
    procedure panelF10MouseEnter(Sender: TObject);
    procedure panelF10MouseLeave(Sender: TObject);
    procedure panelF12MouseEnter(Sender: TObject);
    procedure panelF12MouseLeave(Sender: TObject);
    procedure PanelEscMouseEnter(Sender: TObject);
    procedure PanelEscMouseLeave(Sender: TObject);
    procedure editCodigoClienteEnter(Sender: TObject);
    procedure editCodigoClienteExit(Sender: TObject);
    procedure CarregaVendedor;
    procedure cmbNomeVendedorChange(Sender: TObject);
    procedure PanelF9MouseEnter(Sender: TObject);
    procedure PanelF9MouseLeave(Sender: TObject);
    procedure PanelF9Click(Sender: TObject);
    procedure CheckBoxCFVinculadoClick(Sender: TObject);
    procedure FormClick(Sender: TObject);
    procedure editQuantidadeExit(Sender: TObject);
    procedure GridItensDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);

  private
    { Private declarations }
    procedure ShowHint(Sender: TObject);
    procedure LimpaCampos;
    procedure LimpaCamposDetalhe;
    procedure ConfiguraCDSGrid;
    procedure LocalizaClienteId;
    procedure LocalizaClienteCpfCnpj;
    procedure IdentificaCliente;
    procedure Confirma;
    procedure AtualizaTotais;
    procedure ConsultaProduto(Codigo: String);
    procedure ConsultaProdutoCodigoBalanca(CodigoBalanca: Integer);
    procedure ConsultaProdutoCodigoInterno(CodigoInterno: string);
    procedure ConsultaProdutoId(id: Integer);
    function DesmembraCodigoDigitado(var CodigoDeBarraOuDescricaoOuIdProduto: string; var Preco, Qtde: Extended): integer;
    procedure MensagemDeProdutoNaoEncontrado;
    procedure VendeItem;
    procedure LocalizaProduto;
    procedure IniciaVendaDeItens;
    procedure ExcluirItem;
    procedure DescontoOuAcrescimo;
    procedure TelaPadrao;
    procedure Grava;
    procedure AssinaSalvaXML;
    procedure EnviaNFe;
    procedure CancelaNFe;
    procedure ImprimeDanfe;
    procedure ConfiguraNfe;
    procedure LimpaCliente;

  public
  end;

var
  FNFe: TFNFe;
  SeqItem: Integer;
  SubTotal, TotalGeral, Desconto, Acrescimo, TaxaDesconto, TaxaAcrescimo: Extended;
  NumeroNF: Integer;
  StatusNFe: Integer; //0-Livre | 1-Inclusão | 2-Alteração | 3-Exclusão
  PodeFinalizar: Integer; // 0-Pode finalizar |1-Não pode finalizar
  Cliente: TPessoaVO;
  Empresa : TEmpresaVO;

implementation

uses UImportaProduto, UDataModule, Biblioteca, ProdutoVO, ProdutoController,
Constantes, ULoginGerenteSupervisor, UDescontoAcrescimo, OperadorController,
NfeCupomFiscalVO, EmpresaController, UProcuraCliente, NfeConfiguracaoController,
NfeConfiguracaoVO, UMenu;

var
  NFeCabecalho: TNFeCabecalhoVO;
  NfeConfiguracao: TNfeConfiguracaoVO;
  ListaNFeDetalhe: TObjectList<TNFeDetalheVO>;
  Produto: TProdutoVO;
  Funcionario: TPessoaVO;
  ListaFuncionario: TObjectList<TPessoaVO>;
  SerieCertificado: String;

{$R *.dfm}


procedure TFNFe.ShowHint(Sender: TObject);
begin
  labelDescricaoProduto.Caption := Application.Hint;
end;

procedure TFNFe.ConfiguraCDSGrid;
var
  i: Integer;
begin
  // Configuramos o ClientDataSet do Detalhe da NFe
  FDataModule.CDSNF.Close;
  FDataModule.CDSNF.FieldDefs.Clear;

  FDataModule.CDSNF.FieldDefs.add('NUMERO_ITEM', ftInteger);
  FDataModule.CDSNF.FieldDefs.add('GTIN', ftString, 14);
  FDataModule.CDSNF.FieldDefs.add('NOME_PRODUTO', ftString, 100); //transiente
  FDataModule.CDSNF.FieldDefs.add('QUANTIDADE_COMERCIAL', ftFloat);
  FDataModule.CDSNF.FieldDefs.add('VALOR_UNITARIO_COMERCIAL', ftFloat);
  FDataModule.CDSNF.FieldDefs.add('VALOR_TOTAL', ftFloat);
  FDataModule.CDSNF.FieldDefs.add('CFOP', ftInteger);
  FDataModule.CDSNF.FieldDefs.add('CODIGO_PRODUTO', ftString, 60);
  FDataModule.CDSNF.FieldDefs.add('NCM', ftString, 8);
  FDataModule.CDSNF.FieldDefs.add('EX_TIPI', ftInteger);
  FDataModule.CDSNF.FieldDefs.add('UNIDADE_COMERCIAL', ftString, 6);
  FDataModule.CDSNF.FieldDefs.add('VALOR_BRUTO_PRODUTOS', ftFloat);
  FDataModule.CDSNF.FieldDefs.add('GTIN_UNIDADE_TRIBUTAVEL', ftString, 14);
  FDataModule.CDSNF.FieldDefs.add('UNIDADE_TRIBUTAVEL', ftString, 6);
  FDataModule.CDSNF.FieldDefs.add('QUANTIDADE_TRIBUTAVEL', ftFloat);
  FDataModule.CDSNF.FieldDefs.add('VALOR_UNITARIO_TRIBUTACAO', ftFloat);
  FDataModule.CDSNF.FieldDefs.add('VALOR_FRETE', ftFloat);
  FDataModule.CDSNF.FieldDefs.add('VALOR_SEGURO', ftFloat);
  FDataModule.CDSNF.FieldDefs.add('VALOR_DESCONTO', ftFloat);
  FDataModule.CDSNF.FieldDefs.add('VALOR_OUTRAS_DESPESAS', ftFloat);
  FDataModule.CDSNF.FieldDefs.add('ENTRA_TOTAL', ftString, 1);
  FDataModule.CDSNF.FieldDefs.add('ORIGEM_MERCADORIA', ftString, 1);
  FDataModule.CDSNF.FieldDefs.add('CST_ICMS', ftString, 3);
  FDataModule.CDSNF.FieldDefs.add('CSOSN', ftString, 4);
  FDataModule.CDSNF.FieldDefs.add('MODALIDADE_BC_ICMS', ftString, 1);
  FDataModule.CDSNF.FieldDefs.add('TAXA_REDUCAO_BC_ICMS', ftFloat);
  FDataModule.CDSNF.FieldDefs.add('BASE_CALCULO_ICMS', ftFloat);
  FDataModule.CDSNF.FieldDefs.add('ALIQUOTA_ICMS', ftFloat);
  FDataModule.CDSNF.FieldDefs.add('VALOR_ICMS', ftFloat);
  FDataModule.CDSNF.FieldDefs.add('MOTIVO_DESONERACAO_ICMS', ftString, 1);
  FDataModule.CDSNF.FieldDefs.add('MODALIDE_BC_ICMS_ST', ftString, 1);
  FDataModule.CDSNF.FieldDefs.add('PERCENTUAL_MVA_ICMS_ST', ftFloat);
  FDataModule.CDSNF.FieldDefs.add('REDUCAO_BC_ICMS_ST', ftFloat);
  FDataModule.CDSNF.FieldDefs.add('BASE_CALCULO_ICMS_ST', ftFloat);
  FDataModule.CDSNF.FieldDefs.add('ALIQUOTA_ICMS_ST', ftFloat);
  FDataModule.CDSNF.FieldDefs.add('VALOR_ICMS_ST', ftFloat);
  FDataModule.CDSNF.FieldDefs.add('VALOR_BC_ICMS_ST_RETIDO', ftFloat);
  FDataModule.CDSNF.FieldDefs.add('VALOR_ICMS_ST_RETIDO', ftFloat);
  FDataModule.CDSNF.FieldDefs.add('ALIQUOTA_CREDITO_ICMS_SN', ftFloat);
  FDataModule.CDSNF.FieldDefs.add('VALOR_CREDITO_ICMS_SN', ftFloat);
  FDataModule.CDSNF.FieldDefs.add('VALOR_SUBTOTAL', ftFloat);
  FDataModule.CDSNF.FieldDefs.add('ID', ftInteger);
  FDataModule.CDSNF.FieldDefs.add('ID_PRODUTO', ftInteger);
  FDataModule.CDSNF.FieldDefs.add('ID_NFE_CABECALHO', ftInteger);
  FDataModule.CDSNF.CreateDataSet;

  TFloatField(FDataModule.CDSNF.FieldByName('QUANTIDADE_COMERCIAL')).displayFormat:='#########0.00';
  TFloatField(FDataModule.CDSNF.FieldByName('VALOR_UNITARIO_COMERCIAL')).displayFormat:='#########0.00';
  TFloatField(FDataModule.CDSNF.FieldByName('VALOR_TOTAL')).displayFormat:='#########0.00';

  // Definimos os cabeçalhos da Grid Principal
  GridItens.Columns[0].Title.Caption := 'Item';
  GridItens.Columns[0].Title.Alignment := taCenter;
  GridItens.Columns[0].Alignment := taCenter;
  GridItens.Columns[0].Width := 40;

  GridItens.Columns[1].Title.Caption := 'Produto GTIN';
  GridItens.Columns[1].Title.Alignment := taCenter;
  GridItens.Columns[1].Alignment := taLeftJustify;
  GridItens.Columns[1].Width := 100;

  GridItens.Columns[2].Title.Caption := 'Descrição';
  GridItens.Columns[2].Title.Alignment := taCenter;
  GridItens.Columns[2].Width := 250;

  GridItens.Columns[3].Title.Caption := 'Quantidade';
  GridItens.Columns[3].Title.Alignment := taCenter;
  GridItens.Columns[3].Width := 80;

  GridItens.Columns[4].Title.Caption := 'Unitário';
  GridItens.Columns[4].Title.Alignment := taCenter;
  GridItens.Columns[4].Alignment := taRightJustify;
  GridItens.Columns[4].Width := 80;

  GridItens.Columns[5].Title.Caption := 'Total';
  GridItens.Columns[5].Title.Alignment := taCenter;
  GridItens.Columns[5].Alignment := taRightJustify;
  GridItens.Columns[5].Width := 100;

  GridItens.Columns[6].Title.Caption := 'CFOP';
  GridItens.Columns[6].Title.Alignment := taCenter;
  GridItens.Columns[6].Alignment := taLeftJustify;
  GridItens.Columns[6].Width := 80;

  GridItens.Columns[7].Title.Caption := '#';
  GridItens.Columns[7].Title.Alignment := taCenter;
  GridItens.Columns[7].Alignment := taRightJustify;
  GridItens.Columns[7].Width := 20;

  for i := 0 to GridItens.Columns.Count -1 do
  begin
    if I > 7 then
      GridItens.Columns[i].Visible := False;
  end;
end;

procedure TFNFe.Soma;
begin
  SubTotal := SubTotal + FDataModule.CDSNF.FieldByName('VALOR_TOTAL').AsFloat;
  AtualizaTotais;
end;

procedure TFNFe.CarregaVendedor;
var
  i: Integer;
begin
  ListaFuncionario := TOperadorController.RetornaFuncionario;
  for i := 0 to ListaFuncionario.Count - 1 do
  begin
    cmbNomeVendedor.Items.Add(IntToStr(TPessoaVO(ListaFuncionario.Items[i]).Id)+'] '+ TPessoaVO(ListaFuncionario.Items[i]).Nome);
  end;
end;

procedure TFNFe.IdentificaCliente;
begin
  if (StatusNFe <> 2) and (StatusNFe <> 3) then
  begin
    Application.CreateForm(TFProcuraCliente, FProcuraCliente);
    FProcuraCliente.ShowModal;
    if FProcuraCliente.IdClientePassou > 0 then
    begin
      editCodigoCliente.Text := IntToStr(FProcuraCliente.IdClientePassou);
      EditNome.Text := FProcuraCliente.NomePassou;
      editCpfCnpj.Text := FProcuraCliente.CpfCnpjPassou;
      editCodigoCliente.SetFocus;
    end
    else
     keybd_event(VK_Return, 0, 0, 0);
  end
  else
    Application.MessageBox('Emissão de Nota Fiscal em estado de alteração ou exclusão.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
end;

procedure TFNFe.Confirma;
begin
  if (EditNome.Text <> '') and (editCpfCnpj.Text <> '') then
  begin
    if editCodigoVendedor.AsInteger <= 0 then
    begin
      Application.MessageBox('É necessário identificar o vendedor.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
      cmbNomeVendedor.SetFocus;
    end
    else
    begin
      if CheckBoxCFVinculado.Checked then
      begin
        if (EditCOO.Text = '') or (EditNumeroCaixa.Text = '') or (EditSerieECF.Text = '') then
        begin
          Application.MessageBox('É necessário informar os dados do cupom vinculado.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
          EditDataEmissaoCF.SetFocus;
        end
        else
          Grava;
      end
      else
        Grava;
    end;
  end
  else
  begin
    Application.MessageBox('É necessário identificar o cliente.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
    editCodigoCliente.SetFocus
  end;
end;

procedure TFNFe.Grava;
var
  NFeControl: TNFeController;
  NFeDetalhe: TNFeDetalheVO;
  NumeroNF: Integer;
  ValorICMS: Extended;
  OK: boolean;
  Csosn, CstIcms: String;
begin
  if Application.MessageBox('Deseja armazenar a NFe no banco de dados?', 'Pergunta do sistema', MB_YESNO + MB_ICONQUESTION) = IDYES then
  begin
    ValorICMS := 0;

    NFeControl := TNFeController.Create;
    ListaNFeDetalhe := TObjectList<TNFeDetalheVO>.Create;

    if Assigned(Cliente) then
      NFeCabecalho.IdCliente := Cliente.Id;

    NFeCabecalho.IdFuncionario := editCodigoVendedor.AsInteger;
    NFeCabecalho.NaturezaOperacao := 'Venda';
    NFeCabecalho.IndicadorFormaPagamento := '0';
    NFeCabecalho.CodigoModelo := '55';
    NFeCabecalho.Serie := '000';
    NFeCabecalho.DataEmissao := DateToStr(Date);
    NFeCabecalho.DataEntradaSaida := EditDataEmissao.Text;
    NFeCabecalho.HoraEntradaSaida := EditHoraEmissao.Text;
    NFeCabecalho.TipoOperacao := '1';
    NFeCabecalho.CodigoMunicipio := Empresa.CodigoIbgeCidade;
    NFeCabecalho.FormatoImpressaoDanfe := NfeConfiguracao.FormaImpressaoDanfe;
    NFeCabecalho.TipoEmissao := '1';
    NFeCabecalho.Ambiente := NfeConfiguracao.Ambiente; //TpAmbToStr(FDataModule.ACBrNFe.Configuracoes.WebServices.Ambiente);
    NFeCabecalho.FinalidadeEmissao := '1';
    NFeCabecalho.ProcessoEmissao := '0';
    NFeCabecalho.VersaoProcessoEmissao := 100;
    NFeCabecalho.ValorTotalProdutos := SubTotal;
    NFeCabecalho.ValorDesconto := Desconto;
    NFeCabecalho.ValorTotal := TotalGeral;

    if CheckBoxCFVinculado.Checked then
    begin
      NFeCabecalho.CupomVinculado := True;
      NFeCabecalho.NfeCupomFiscalVO := TNfeCupomFiscalVO.Create;
      NFeCabecalho.NfeCupomFiscalVO.ModeloDocumentoFiscal := '2D';
      NFeCabecalho.NfeCupomFiscalVO.DataEmissaoCupom := FormatDateTime('yyyy-mm-dd', StrToDate(EditDataEmissaoCF.Text));
      NFeCabecalho.NfeCupomFiscalVO.NumeroOrdemEcf := EditNumeroCaixa.AsInteger;
      NFeCabecalho.NfeCupomFiscalVO.NumeroCaixa := EditNumeroCaixa.AsInteger;
      NFeCabecalho.NfeCupomFiscalVO.Coo := EditCOO.AsInteger;
      NFeCabecalho.NfeCupomFiscalVO.NumeroSerieEcf := EditSerieECF.Text;
      NFeCabecalho.BaseCalculoIcms := 0;
      NFeCabecalho.ValorIcms := 0;
      NFeCabecalho.InformacoesComplementares :=
         'LANCAMENTO efetuado em decorrencia de emissao do CUPOM FISCAL '+EditCOO.Text+
         'ECF numero '+EditNumeroCaixa.Text+', ECF SN. '+EditSerieECF.Text+', de '+EditDataEmissaoCF.Text+'.';
    end;

    FDataModule.CDSNF.DisableControls;
    FDataModule.CDSNF.First;
    while not FDataModule.CDSNF.Eof do
    begin
      NFeDetalhe := TNFeDetalheVO.Create;

      NFeDetalhe.NumeroItem := FDataModule.CDSNF.FieldByName('NUMERO_ITEM').AsInteger;
      NFeDetalhe.IdProduto := FDataModule.CDSNF.FieldByName('ID_PRODUTO').AsInteger;
      NFeDetalhe.Gtin := FDataModule.CDSNF.FieldByName('GTIN').AsString;
      NFeDetalhe.NomeProduto := FDataModule.CDSNF.FieldByName('NOME_PRODUTO').AsString;
      NFeDetalhe.Ncm := FDataModule.CDSNF.FieldByName('NCM').AsString;
      NFeDetalhe.Cfop := FDataModule.CDSNF.FieldByName('CFOP').AsInteger;
      NFeDetalhe.UnidadeComercial := FDataModule.CDSNF.FieldByName('UNIDADE_COMERCIAL').AsString;
      NFeDetalhe.QuantidadeComercial := FDataModule.CDSNF.FieldByName('QUANTIDADE_COMERCIAL').AsFloat;
      NFeDetalhe.ValorUnitarioComercial := FDataModule.CDSNF.FieldByName('VALOR_UNITARIO_COMERCIAL').AsFloat;
      NFeDetalhe.GtinUnidadeTributavel := FDataModule.CDSNF.FieldByName('GTIN').AsString;
      NFeDetalhe.UnidadeTributavel := FDataModule.CDSNF.FieldByName('UNIDADE_TRIBUTAVEL').AsString;
      NFeDetalhe.QuantidadeTributavel := FDataModule.CDSNF.FieldByName('QUANTIDADE_TRIBUTAVEL').AsFloat;
      NFeDetalhe.ValorUnitarioTributacao := FDataModule.CDSNF.FieldByName('VALOR_UNITARIO_TRIBUTACAO').AsFloat;
      NFeDetalhe.ValorSubTotal := FDataModule.CDSNF.FieldByName('VALOR_SUBTOTAL').AsFloat;
      NFeDetalhe.ValorTotal := FDataModule.CDSNF.FieldByName('VALOR_TOTAL').AsFloat;
      NFeDetalhe.OrigemMercadoria := '0';
      NFeDetalhe.Csosn := FDataModule.CDSNF.FieldByName('CSOSN').AsString;
      NFeDetalhe.CstIcms := FDataModule.CDSNF.FieldByName('CST_ICMS').AsString;

      Csosn := Copy(NFeDetalhe.Csosn,2,3);
      CstIcms := Copy(NFeDetalhe.CstIcms,2,2);

      if StrToCRT(OK, Empresa.Crt) = crtSimplesNacional  then
      begin
        if not CheckBoxCFVinculado.Checked then
        begin
          if Csosn = '101' then  // Tributada pelo Simples Nacional com permissão de crédito
          begin
            NFeDetalhe.BaseCalculoIcms := FDataModule.CDSNF.FieldByName('BASE_CALCULO_ICMS').AsFloat;
            NFeDetalhe.ValorIcms        := FDataModule.CDSNF.FieldByName('VALOR_ICMS').AsFloat;;
          end;

          if Csosn = '102' then  // Tributada pelo Simples Nacional sem permissão de crédito
          begin
            NFeDetalhe.BaseCalculoIcms := FDataModule.CDSNF.FieldByName('BASE_CALCULO_ICMS').AsFloat;
            NFeDetalhe.ValorIcms        := FDataModule.CDSNF.FieldByName('VALOR_ICMS').AsFloat;

            NFeDetalhe.BaseCalculoIcms  := 0;
            NFeDetalhe.ValorIcms        := 0;
            NFeDetalhe.AliquotaIcms     := 0;
          end;

          if Csosn = '103' then  //  Isenção do ICMS no Simples Nacional para faixa de receita bruta
          begin
            NFeDetalhe.BaseCalculoIcms  := 0;
            NFeDetalhe.ValorIcms        := 0;
            NFeDetalhe.AliquotaIcms     := 0;
          end;

          if Csosn = '201' then //Tributada pelo Simples Nacional com permissão de crédito e com cobrança do ICMS por substituição tributária
          begin
            NFeDetalhe.BaseCalculoIcms  := 0;
            NFeDetalhe.ValorIcms        := 0;
            NFeDetalhe.AliquotaIcms     := 0;
          end;

          if Csosn = '202' then // Tributada pelo Simples Nacional sem permissão de crédito e com cobrança do ICMS por substituição tributária
          begin
            NFeDetalhe.BaseCalculoIcms  := 0;
            NFeDetalhe.ValorIcms        := 0;
            NFeDetalhe.AliquotaIcms     := 0;
          end;

          if Csosn = '300' then // 300 - Imune - Classificam-se neste código as operações praticadas por optantes pelo Simples Nacional contempladas com imunidade do ICMS.
          begin
            NFeDetalhe.BaseCalculoIcms  := 0;
            NFeDetalhe.ValorIcms        := 0;
            NFeDetalhe.AliquotaIcms     := 0;
          end;

          if Csosn = '400' then // 400 - Não tributada pelo Simples Nacional - Classificam-se neste código as operações praticadas por optantes pelo Simples Nacional não sujeitas à tributação pelo ICMS dentro do Simples Nacional.
          begin
            NFeDetalhe.BaseCalculoIcms  := 0;
            NFeDetalhe.ValorIcms        := 0;
            NFeDetalhe.AliquotaIcms     := 0;
          end;

          if Csosn = '500' then //500 - ICMS cobrado anteriormente por substituição tributária (substituído) ou por antecipação - Classificam-se neste código as operações sujeitas exclusivamente ao regime de substituição tributária na condição de substituído tributário ou no caso de antecipações.
          begin
            NFeDetalhe.BaseCalculoIcms  := 0;
            NFeDetalhe.ValorIcms        := 0;
            NFeDetalhe.AliquotaIcms     := 0;
          end;

          if Csosn = '900' then //900 - Outros - Classificam-se neste código as demais operações que não se enquadrem nos códigos 101, 102, 103, 201, 202, 203, 300, 400 e 500.
          begin
            NfeDetalhe.BaseCalculoIcms := 0;
            nfeDetalhe.ValorIcms  := 0;
            NFeDetalhe.AliquotaIcms := 0;
          end;

        end //if not CheckBoxCFVinculado.Checked then
        else
        begin
          NfeDetalhe.BaseCalculoIcms := 0;
          nfeDetalhe.ValorIcms  := 0;
          NFeDetalhe.AliquotaIcms := 0;
        end;

        NfeDetalhe.CstIpi    := '99';
        NfeDetalhe.BaseCalculoIpi := 0;
        NFeDetalhe.AliquotaIpi := 0;
        NFeDetalhe.ValorIpi := 0;

        NfeDetalhe.CstCofins := '99';
        NfeDetalhe.BaseCalculoCofins := 0;
        NfeDetalhe.ValorCofins := 0;
        NFeDetalhe.AliquotaCofinsReais := 0 ;

        NfeDetalhe.CtsPis    := '99';
        NfeDetalhe.ValorBaseCalculoPis := 0;
        NFeDetalhe.AliquotaPisReais := 0;
        NFeDetalhe.ValorPis := 0;
      end; //if StrToCRT(OK, Empresa.Crt) = crtSimplesNacional  then

      if (StrToCRT(OK, Empresa.Crt) = crtRegimeNormal) or (StrToCRT(OK, Empresa.Crt) = crtSimplesExcessoReceita )  then
      begin
        if CstIcms = '00' then
        begin
          NFeDetalhe.BaseCalculoIcms := FDataModule.CDSNF.FieldByName('VALOR_UNITARIO_COMERCIAL').AsFloat;
          NFeDetalhe.AliquotaIcms := FDataModule.CDSNF.FieldByName('ALIQUOTA_ICMS').AsFloat;
          NFeDetalhe.ValorIcms := (NFeDetalhe.AliquotaIcms/100) * NFeDetalhe.BaseCalculoIcms;
          NFeDetalhe.ValorSubtotal := FDataModule.CDSNF.FieldByName('VALOR_SUBTOTAL').AsFloat;
          NFeDetalhe.ValorTotal := FDataModule.CDSNF.FieldByName('VALOR_TOTAL').AsFloat;
          ValorICMS := ValorICMS + (NFeDetalhe.ValorTotal * (NFeDetalhe.AliquotaIcms / 100));
        end;
        if CstIcms = '10' then
        begin
          NFeDetalhe.BaseCalculoIcms := 0;
          NFeDetalhe.AliquotaIcms := 0;
          NFeDetalhe.ValorIcms := 0;
        end;
        if CstIcms = '20' then
        begin
          NFeDetalhe.BaseCalculoIcms := 0;
          NFeDetalhe.AliquotaIcms := 0;
          NFeDetalhe.ValorIcms := 0;
        end;
        if CstIcms = '30' then
        begin
          NFeDetalhe.BaseCalculoIcms := 0;
          NFeDetalhe.AliquotaIcms := 0;
          NFeDetalhe.ValorIcms := 0;
        end;
        if CstIcms = '40' then //40 - Isenta;
        begin
          NFeDetalhe.BaseCalculoIcms := 0;
          NFeDetalhe.AliquotaIcms := 0;
          NFeDetalhe.ValorIcms := 0;
        end;
        if CstIcms = '41' then //41 - Nao tributada;
        begin
          NFeDetalhe.BaseCalculoIcms := 0;
          NFeDetalhe.AliquotaIcms := 0;
          NFeDetalhe.ValorIcms := 0;
        end;
        if CstIcms = '50' then //50 nao Suspensao;
        begin
          NFeDetalhe.BaseCalculoIcms := 0;
          NFeDetalhe.AliquotaIcms := 0;
          NFeDetalhe.ValorIcms := 0;
        end;
        if CstIcms = '51' then
        begin
          NFeDetalhe.BaseCalculoIcms := 0;
          NFeDetalhe.AliquotaIcms := 0;
          NFeDetalhe.ValorIcms := 0;
        end;
        if CstIcms = '60' then
        begin
          NFeDetalhe.BaseCalculoIcms := 0;
          NFeDetalhe.AliquotaIcms := 0;
          NFeDetalhe.ValorIcms := 0;
        end;
        if CstIcms = '70' then
        begin
          NFeDetalhe.BaseCalculoIcms := 0;
          NFeDetalhe.AliquotaIcms := 0;
          NFeDetalhe.ValorIcms := 0;
         end;
        if CstIcms = '90' then
        begin
          NFeDetalhe.BaseCalculoIcms := 0;
          NFeDetalhe.AliquotaIcms := 0;
          NFeDetalhe.ValorIcms := 0;
        end;
      end //if (StrToCRT(OK, Empresa.Crt) = crtRegimeNormal) or (StrToCRT(OK, Empresa.Crt) = crtSimplesExcessoReceita )  then
      else
      begin
        NFeDetalhe.BaseCalculoIcms := 0;
        NFeDetalhe.AliquotaIcms := 0;
        NFeDetalhe.ValorIcms := 0;
      end;

      if (NfeDetalhe.CstIpi = '01') or
         (NfeDetalhe.CstIpi = '02') or
         (NfeDetalhe.CstIpi = '03') or
         (NfeDetalhe.CstIpi = '04') or
         (NfeDetalhe.CstIpi = '05') or
         (NfeDetalhe.CstIpi = '51') or
         (NfeDetalhe.CstIpi = '52') or
         (NfeDetalhe.CstIpi = '53') or
         (NfeDetalhe.CstIpi = '54') or
         (NfeDetalhe.CstIpi = '55') then
      begin
        NfeDetalhe.BaseCalculoIpi := 0;
        NFeDetalhe.AliquotaIpi := 0;
        NFeDetalhe.ValorIpi := 0;
      end;

      if (NfeDetalhe.CstIpi = '00') or
         (NfeDetalhe.CstIpi = '49') or
         (NfeDetalhe.CstIpi = '50') or
         (NfeDetalhe.CstIpi = '99') then
      begin
        if true then // Percentual
        begin
          NfeDetalhe.BaseCalculoIpi := 0;
          NFeDetalhe.AliquotaIpi    := 0;
          NFeDetalhe.ValorIpi       := 0;
        end
        else
        begin
          NfeDetalhe.BaseCalculoIpi := 0;
          NFeDetalhe.AliquotaIpi    := 0;
          NFeDetalhe.ValorIpi       := 0;
        end;
      end;

      NfeDetalhe.CstCofins := '99';
      NfeDetalhe.BaseCalculoCofins := 0;
      NfeDetalhe.ValorCofins := 0;
      NFeDetalhe.AliquotaCofinsReais := 0 ;

      NfeDetalhe.CtsPis    := '99';
      NfeDetalhe.ValorBaseCalculoPis := 0;
      NFeDetalhe.AliquotaPisReais := 0;
      NFeDetalhe.ValorPis := 0;

      NFeDetalhe.ModalidadeBcIcms := '3';
      ListaNFeDetalhe.Add(NFeDetalhe);
      FDataModule.CDSNF.Next;
    end; //while not FDataModule.CDSNF.Eof do


    if not CheckBoxCFVinculado.Checked then
    begin
      NFeCabecalho.CupomVinculado := False;
      NFeCabecalho.BaseCalculoIcms := TotalGeral;
      NFeCabecalho.ValorIcms := ValorICMS;
    end;

    NFeCabecalho.BaseCalculoIcms := TotalGeral;
    NFeCabecalho.ValorIcms := ValorICMS;

    NFeCabecalho := NFeControl.InsereNFe(NFeCabecalho, ListaNFeDetalhe);
  {  TelaPadrao;
    AtualizaTotais;
    Cliente := nil;}
    FDataModule.CDSNF.EnableControls;
    EditCodigo.SetFocus;
    Application.MessageBox('Nota Fiscal Eletrônica armazenada com sucesso no banco de dados.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
  end;
end;

procedure TFNFe.ExcluirItem;
begin
  if FDataModule.CDSNF.RecordCount > 0 then
  begin
    if Application.MessageBox('Deseja realmente excluir o registro selecionado?', 'Pergunta do sistema', MB_YESNO + MB_ICONQUESTION) = IDYES then
    begin
      try
        SubTotal := SubTotal - FDataModule.CDSNF.FieldByName('VALOR_TOTAL').AsFloat;
        AtualizaTotais;
        FDataModule.CDSNF.Delete;
        EditCodigo.SetFocus;
      except
        Application.MessageBox('Ocorreu um erro. Exclusão não realizada.', 'Erro do sistema', MB_OK + MB_ICONERROR);
      end;
      end;
  end
  else
  Application.MessageBox('Não Existe Produto Disponível Para Exclusão.', 'Não autorizado!', MB_OK + MB_ICONERROR);
end;

procedure TFNFe.AssinaSalvaXML;
var
  OK : Boolean;
  i: Integer;
begin
  if FDataModule.ACBrNFe.Configuracoes.Certificados.NumeroSerie = '' then
  begin
    SerieCertificado := FDataModule.ACBrNFe.Configuracoes.Certificados.SelecionarCertificado;
  end;

  FDataModule.ACBrNFe.NotasFiscais.Clear;
  with FDataModule.ACBrNFe.NotasFiscais.Add.NFe do
  begin
    Ide.cNF       := StrToInt(NFeCabecalho.CodigoNumerico);
    Ide.natOp     := NFeCabecalho.NaturezaOperacao;
    Ide.indPag    := ipVista;
    Ide.modelo    := StrToInt(NFeCabecalho.CodigoModelo);
    Ide.serie     := StrToInt(NFeCabecalho.Serie);
    Ide.nNF       := StrToInt(NFeCabecalho.Numero);
    Ide.dEmi      := StrToDate(NFeCabecalho.DataEmissao);
    Ide.dSaiEnt   := StrToDate(NFeCabecalho.DataEntradaSaida);
    Ide.tpEmis    := teNormal;
    Ide.verProc   := IntToStr(NFeCabecalho.VersaoProcessoEmissao);
    Ide.cUF       := Empresa.CodigoIbgeUf;
    Ide.cMunFG    := NFeCabecalho.CodigoMunicipio;
    Ide.finNFe    := fnNormal;
    if NFeCabecalho.TipoOperacao = '0' then
      Ide.tpNF      := tnEntrada
    else
      Ide.tpNF      := tnSaida;

    Emit.CNPJCPF           := Empresa.Cnpj;
    Emit.IE                := Empresa.InscricaoEstadual;
    Emit.xNome             := Empresa.RazaoSocial;
    Emit.xFant             := Empresa.NomeFantasia;
    Emit.EnderEmit.fone    := Empresa.Fone;
    if Empresa.Cep <> '' then
      Emit.EnderEmit.CEP     := StrToInt(Empresa.Cep)
    else
      Emit.EnderEmit.CEP     := 0;
    Emit.EnderEmit.xLgr    := Empresa.Logradouro;
    Emit.EnderEmit.nro     := Empresa.Numero;
    Emit.EnderEmit.xCpl    := Empresa.Complemento;
    Emit.EnderEmit.xBairro := Empresa.Bairro;
    Emit.EnderEmit.cMun    := Empresa.CodigoIbgeCidade;
    Emit.EnderEmit.xMun    := Empresa.Cidade;
    Emit.EnderEmit.UF      := Empresa.Uf;
    Emit.CRT               := StrToCRT(ok ,Empresa.Crt);
    Emit.enderEmit.cPais   := 1058;
    Emit.enderEmit.xPais   := 'BRASIL';

    Dest.CNPJCPF           := Cliente.CpfCnpj;
    Dest.IE                := Cliente.InscricaoEstadual;
    Dest.xNome             := Cliente.Nome;
    Dest.EnderDest.Fone    := '';

    Dest.EnderDest.xLgr    := Cliente.PessoaEndereco.Logradouro;
    Dest.EnderDest.nro     := Cliente.PessoaEndereco.Numero;
    Dest.EnderDest.xCpl    := Cliente.PessoaEndereco.Complemento;
    Dest.EnderDest.xBairro := Cliente.PessoaEndereco.Bairro;
    Dest.EnderDest.cMun    := Cliente.PessoaEndereco.CodigoIbgeCidade;
    Dest.EnderDest.xMun    := Cliente.PessoaEndereco.Cidade;
    Dest.EnderDest.UF      := Cliente.PessoaEndereco.Uf;
    Dest.EnderDest.cPais   := 1058;
    Dest.EnderDest.xPais   := 'BRASIL';
    if Cliente.PessoaEndereco.Cep <> '' then
      Dest.EnderDest.CEP     := StrToInt(Cliente.PessoaEndereco.Cep)
    else
      Dest.EnderDest.CEP     := 0;

    infAdic.infCpl := NFeCabecalho.InformacoesComplementares;

    for i := 0 to ListaNFeDetalhe.Count - 1 do
    begin
      with Det.Add do
      begin
        Prod.nItem    := TNFeDetalheVO(ListaNFeDetalhe.Items[i]).NumeroItem;
        Prod.cProd    := TNFeDetalheVO(ListaNFeDetalhe.Items[i]).Gtin;
        Prod.cEAN     := TNFeDetalheVO(ListaNFeDetalhe.Items[i]).Gtin;
        Prod.xProd    := TNFeDetalheVO(ListaNFeDetalhe.Items[i]).NomeProduto;
        Prod.NCM      := TNFeDetalheVO(ListaNFeDetalhe.Items[i]).Ncm;
        Prod.EXTIPI   := '';
        Prod.CFOP     := IntToStr(TNFeDetalheVO(ListaNFeDetalhe.Items[i]).Cfop);
        Prod.uCom     := TNFeDetalheVO(ListaNFeDetalhe.Items[i]).UnidadeComercial;
        Prod.qCom     := TNFeDetalheVO(ListaNFeDetalhe.Items[i]).QuantidadeComercial;
        Prod.vUnCom   := TNFeDetalheVO(ListaNFeDetalhe.Items[i]).ValorUnitarioComercial;
        Prod.vProd    := TNFeDetalheVO(ListaNFeDetalhe.Items[i]).ValorTotal;
        Prod.cEANTrib  := TNFeDetalheVO(ListaNFeDetalhe.Items[i]).GtinUnidadeTributavel;
        Prod.uTrib     := TNFeDetalheVO(ListaNFeDetalhe.Items[i]).UnidadeTributavel;
        Prod.qTrib     := TNFeDetalheVO(ListaNFeDetalhe.Items[i]).QuantidadeTributavel;
        Prod.vUnTrib   := TNFeDetalheVO(ListaNFeDetalhe.Items[i]).ValorUnitarioTributacao;
        Prod.vFrete    := 0;
        Prod.vSeg      := 0;
        Prod.vDesc     := 0;
        infAdProd      := '';

        with Imposto do
        begin
          with ICMS do
          begin
            if Emit.CRT = crtSimplesNacional then
              CSOSN        := StrToCSOSNIcms(ok, TNFeDetalheVO(ListaNFeDetalhe.Items[i]).Csosn)
            else
              CST          := StrToCSTICMS(ok, TNFeDetalheVO(ListaNFeDetalhe.Items[i]).CstIcms);
            ICMS.orig    := oeNacional;
            ICMS.modBC   := dbiValorOperacao;
            ICMS.vBC     := TNFeDetalheVO(ListaNFeDetalhe.Items[i]).BaseCalculoIcms;
            ICMS.pICMS   := TNFeDetalheVO(ListaNFeDetalhe.Items[i]).AliquotaIcms;
            ICMS.vICMS   := TNFeDetalheVO(ListaNFeDetalhe.Items[i]).ValorIcms;
            ICMS.modBCST := dbisMargemValorAgregado;
            ICMS.pMVAST  := 0;
            ICMS.pRedBCST:= 0;
            ICMS.vBCST   := 0;
            ICMS.pICMSST := 0;
            ICMS.vICMSST := 0;
            ICMS.pRedBC  := 0;
          end; //with ICMS do

          with IPI do
          begin
            CST := StrToCSTIPI(ok, TNFeDetalheVO(ListaNFeDetalhe.Items[i]).CstIPI);
            vBC := TNFeDetalheVO(ListaNFeDetalhe.Items[i]).BaseCalculoIpi;
            vIPI := TNFeDetalheVO(ListaNFeDetalhe.Items[i]).ValorIpi;
          end; //with IPI do

          with PIS do
          begin
            CST := StrToCSTPIS(ok, TNFeDetalheVO(ListaNFeDetalhe.Items[i]).CtsPis);
            vBC := TNFeDetalheVO(ListaNFeDetalhe.Items[i]).ValorBaseCalculoPis;
            vPIS := TNFeDetalheVO(ListaNFeDetalhe.Items[i]).ValorPis;
          end; //with PIS do

          with COFINS do
          begin
            CST := StrToCSTCOFINS(ok, TNFeDetalheVO(ListaNFeDetalhe.Items[i]).CstCofins);
            vBC := TNFeDetalheVO(ListaNFeDetalhe.Items[i]).BaseCalculoCofins;
            vCOFINS := TNFeDetalheVO(ListaNFeDetalhe.Items[i]).ValorCofins;
          end; //with COFINS do
        end; //with Imposto do
      end; //with Det.Add do
    end; //for i := 0 to ListaNFeDetalhe.Count - 1 do

    Total.ICMSTot.vBC     := NFeCabecalho.BaseCalculoIcms;
    Total.ICMSTot.vICMS   := NFeCabecalho.ValorIcms;
    Total.ICMSTot.vBCST   := NFeCabecalho.BaseCalculoIcmsSt;
    Total.ICMSTot.vST     := NFeCabecalho.ValorIcmsSt;
    Total.ICMSTot.vProd   := NFeCabecalho.ValorTotalProdutos;
    Total.ICMSTot.vFrete  := 0;
    Total.ICMSTot.vSeg    := 0;
    Total.ICMSTot.vDesc   := 0;
    Total.ICMSTot.vII     := 0;
    Total.ICMSTot.vIPI    := 0;
    Total.ICMSTot.vPIS    := 0;
    Total.ICMSTot.vCOFINS := 0;
    Total.ICMSTot.vOutro  := 0;
    Total.ICMSTot.vNF     := NFeCabecalho.ValorTotal;

    Transp.modFrete := mfContaEmitente;
    Transp.Transporta.CNPJCPF  := '';
    Transp.Transporta.xNome    := '';
    Transp.Transporta.IE       := '';
    Transp.Transporta.xEnder   := '';
    Transp.Transporta.xMun     := '';
    Transp.Transporta.UF       := '';
  end; //with FDataModule.ACBrNFe.NotasFiscais.Add.NFe do

  FDataModule.ACBrNFe.NotasFiscais.Assinar;
  FDataModule.ACBrNFe.NotasFiscais.Items[0].SaveToFile;
  ShowMessage('Arquivo gerado em: '+FDataModule.ACBrNFe.NotasFiscais.Items[0].NomeArq);
end;

procedure TFNFe.FormActivate(Sender: TObject);
begin
  PodeFinalizar := 1;
  StatusNFe := 1;
  TelaPadrao;
  NFeCabecalho := TNFeCabecalhoVO.Create;
  cmbNomeVendedor.SetFocus;
end;

procedure TFNFe.AtualizaTotais;
begin
  TotalGeral := SubTotal + (Acrescimo - Desconto);

  if Desconto >  0 then
  begin
    lblDescAcrescDescricao.Caption := 'Desconto:';
    LabelDescontoAcrescimo.Caption := FormatFloat('0.00', Desconto);
    lblDescAcrescDescricao.Font.Color := clRed;
    LabelDescontoAcrescimo.Font.Color := clRed;
  end
  else if Acrescimo >  0 then
  begin
    lblDescAcrescDescricao.Caption := 'Acréscimo:';
    LabelDescontoAcrescimo.Caption := FormatFloat('0.00', Acrescimo);
    lblDescAcrescDescricao.Font.Color := clGreen;
    LabelDescontoAcrescimo.Font.Color := clGreen;
  end
  else
  begin
    LabelDescontoAcrescimo.Caption := '';
    lblDescAcrescDescricao.Caption := '';
  end;

  lblSubTotal.Caption := FormatFloat('0.00', SubTotal);
  lblValorTotal.Caption := FormatFloat('0.00', TotalGeral);
end;

procedure TFNFe.TelaPadrao;
begin
  LimpaCampos;
  TotalGeral    := 0;
  SubTotal      := 0;
  Desconto      := 0;
  Acrescimo     := 0;
  TaxaDesconto  := 0;
  TaxaAcrescimo := 0;
  SeqItem       := 0;
end;

procedure TFNFe.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Application.MessageBox('Deseja Realmente Fechar a Tela de Nota Fiscal?', 'Sair do Sistema', MB_YesNo + MB_IconQuestion) <> IdYes then
    Action := caNone
  else
  begin
    Action := caFree;
    FNFe := Nil;
  end;
end;

procedure TFNFe.FormCreate(Sender: TObject);
begin
  ConfiguraCDSGrid;
  CarregaVendedor;
  Application.OnHint := ShowHint;
  Empresa := TEmpresaVO.Create;
  Empresa := TEmpresaController.PegaEmpresa(1);

  ConfiguraNfe;
end;

procedure TFNFe.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key = 112 then
    LocalizaProduto;
  if key = 117 then
    IdentificaCliente;
  if key = 119 then
    ExcluirItem;
  if key = 121 then
    DescontoOuAcrescimo;
  if key = 123 then
    Confirma;
  if key = 27 then
    Close;
end;

procedure TFNFe.LimpaCampos;
begin
  editcpfcnpj.Text                  := '';
  editNome.Text                     := '';
  editQuantidade.Text               := '1,000';
  editUnitario.Text                 := '0,000';
  editTotalItem.Text                := '0,000';
  labelDescricaoProduto.Caption     := '';
  editCodigoCliente.Text            := '';
  editCodigo.Text                   := '';
  FDataModule.CDSNF.EmptyDataSet;
  editCodigoVendedor.Text           := '';
  cmbNomeVendedor.ItemIndex         := -1;
  EditDataEmissao.Date              := now;
  EditHoraEmissao.Text              := '';
  CheckBoxCFVinculado.Checked       := True;
  EditDataEmissaoCF.Date            := now;
  EditCOO.Text                      := '';
  EditNumeroCaixa.Text              := '';
  EditSerieECF.Text                 := '';
  EditCFOP.Text                     := '5929';
  EditCFOP.ReadOnly                 := True;
end;

procedure TFNFe.LimpaCamposDetalhe;
begin
  editCodigo.Text                   := '';
  editQuantidade.Text               := '1,000';
  EditCFOP.Text                     := '5929';
  editUnitario.Text                 := '0,000';
  editTotalItem.Text                := '0,000';
  labelDescricaoProduto.Caption     := '';
end;

procedure TFNFe.LocalizaClienteId;
begin
  Cliente := TClienteController.ConsultaPeloID(StrToint(editCodigoCliente.Text));
  LimpaCliente;

  if Cliente.Id <> 0 then
  begin
    editCodigoCliente.Text    := IntToStr(Cliente.Id);
    EditNome.Text             := Cliente.Nome;
    if Length(DevolveInteiro(Cliente.CPFCNPJ)) = 11 then
       editCPFCNPJ.Text := MascTexto(Cliente.CPFCNPJ,'999.999.999-99');
    if Length(DevolveInteiro(Cliente.CPFCNPJ)) = 14 then
       editCPFCNPJ.Text := MascTexto(Cliente.CPFCNPJ,'99.999.999/9999-99');
  end;
end;

procedure TFNFe.LimpaCliente;
begin
  EditNome.Text    := '';
  editCPFCNPJ.Text := '';
end;

procedure TFNFe.LocalizaClienteCpfCnpj;
begin
  Cliente := TClienteController.ConsultaCPFCNPJ(editCpfCnpj.Text);

  if Cliente.Id <> 0 then
  begin
    editCodigoCliente.Text    := IntToStr(Cliente.Id);
    EditNome.Text             := Cliente.Nome;
    if Length(DevolveInteiro(Cliente.CPFCNPJ)) = 11 then
       editCPFCNPJ.Text := MascTexto(Cliente.CPFCNPJ,'999.999.999-99');
    if Length(DevolveInteiro(Cliente.CPFCNPJ)) = 14 then
       editCPFCNPJ.Text := MascTexto(Cliente.CPFCNPJ,'99.999.999/9999-99');
  end;
end;

procedure TFNFe.IniciaVendaDeItens;
var
  Unitario, Quantidade, Total: Extended;
  vTipo:integer;
  vCodigoDeBarraOuDescricaoOuIdProduto: string;
  vPreco, vQtde: Extended;
begin
  if StatusNFe <> 3 then
  begin
    if trim(editCodigo.Text) <> '' then
    begin
      vCodigoDeBarraOuDescricaoOuIdProduto := Trim(editCodigo.Text);
      vpreco := 0;
      vQtde := 0;

      vTipo := DesmembraCodigoDigitado(vCodigoDeBarraOuDescricaoOuIdProduto, vPreco,vQtde);

      case vTipo of
        0:
        begin
          MensagemDeProdutoNaoEncontrado;
          abort;
        end;
        1:
          ConsultaProdutoCodigoBalanca(StrToInt(vCodigoDeBarraOuDescricaoOuIdProduto));
        2:
          ConsultaProduto(vCodigoDeBarraOuDescricaoOuIdProduto);
        3:
        begin
          Application.CreateForm(TFImportaProduto, FImportaProduto);
          UImportaProduto.QuemChamou := 'NF';
          FImportaProduto.EditLocaliza.Text := vCodigoDeBarraOuDescricaoOuIdProduto;
          FImportaProduto.ShowModal;
          if (Length(DevolveInteiro(editCodigo.text))) = (Length(trim(editCodigo.text))) then
          begin
            Produto.Id := 0;
            ConsultaProdutoId(StrToInt64(editCodigo.text));
          end else
          begin
            MensagemDeProdutoNaoEncontrado;
            abort;
          end;
        end;
        4:
          ConsultaProdutoId(StrToInt64(vCodigoDeBarraOuDescricaoOuIdProduto));

      end;
      Application.ProcessMessages;

      if Produto.Id <> 0 then
      begin
        if vQtde > 0  then
           editQuantidade.Value:= vQtde;

        if vpreco > 0 then
           editQuantidade.Text:= FormataFloat('Q',(vPreco/Produto.ValorVenda));

        if (Produto.UnidadeProduto.PodeFracionar = 'N') and (Frac(StrToFloat(EditQuantidade.Text))>0) then
        begin
          Application.MessageBox('Produto não pode ser vendido com quantidade fracionada.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
          LimpaCamposDetalhe;
          editCodigo.SetFocus;
        end
        else if (Produto.PafPSt = 'S') then
        begin
          Application.MessageBox('Serviço não pode ser inserido na NF-e.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
          LimpaCamposDetalhe;
          editCodigo.SetFocus;
        end
        else
        begin
          editUnitario.Text := FormataFloat('V',Produto.ValorVenda);
          labelDescricaoProduto.Caption := Produto.DescricaoPDV;
          Unitario := StrToFloat(editUnitario.Text);
          Quantidade := StrToFloat(editQuantidade.Text);

          VendeItem;

          Total := TruncaValor(Unitario * Quantidade, Constantes.TConstantes.DECIMAIS_VALOR);

          AtualizaTotais;
          editCodigo.Clear;
          editCodigo.SetFocus;
          editQuantidade.Text := '1';
          Application.ProcessMessages;
        end;
      end
      else
      begin
        MensagemDeProdutoNaoEncontrado;
      end;
    end;
  end;
end;

procedure TFNFe.VendeItem;
begin
  if Produto.ValorVenda > 0 then
  begin
    inc(SeqItem);
    FDataModule.CDSNF.Append;
    FDataModule.CDSNF.FieldByName('CFOP').AsInteger := EditCFOP.AsInteger;
    FDataModule.CDSNF.FieldByName('NUMERO_ITEM').AsInteger := SeqItem;
    FDataModule.CDSNF.FieldByName('GTIN').AsString := Produto.GTIN;
    FDataModule.CDSNF.FieldByName('NOME_PRODUTO').AsString := Produto.Nome;
    FDataModule.CDSNF.FieldByName('QUANTIDADE_COMERCIAL').AsFloat := StrToFloat(editQuantidade.Text);
    FDataModule.CDSNF.FieldByName('VALOR_UNITARIO_COMERCIAL').AsString := editUnitario.Text;
    FDataModule.CDSNF.FieldByName('ID_PRODUTO').AsInteger := Produto.Id;
    FDataModule.CDSNF.FieldByName('NCM').AsString := Produto.NCM;
    FDataModule.CDSNF.FieldByName('UNIDADE_COMERCIAL').AsString := Produto.UnidadeProduto.Nome;
    FDataModule.CDSNF.FieldByName('UNIDADE_TRIBUTAVEL').AsString := Produto.UnidadeProduto.Nome;
    FDataModule.CDSNF.FieldByName('QUANTIDADE_TRIBUTAVEL').AsFloat := StrToFloat(editQuantidade.Text);
    FDataModule.CDSNF.FieldByName('VALOR_UNITARIO_TRIBUTACAO').AsString := editUnitario.Text;
    FDataModule.CDSNF.FieldByName('CSOSN').AsString := Produto.Csosn;
    FDataModule.CDSNF.FieldByName('CST_ICMS').AsString := Produto.Cst;
    FDataModule.CDSNF.FieldByName('VALOR_TOTAL').AsFloat := FDataModule.CDSNF.FieldByName('VALOR_UNITARIO_COMERCIAL').AsFloat * FDataModule.CDSNF.FieldByName('QUANTIDADE_COMERCIAL').AsFloat;
    FDataModule.CDSNF.FieldByName('VALOR_SUBTOTAL').AsFloat := FDataModule.CDSNF.FieldByName('VALOR_UNITARIO_COMERCIAL').AsFloat * FDataModule.CDSNF.FieldByName('QUANTIDADE_COMERCIAL').AsFloat;
    FDataModule.CDSNF.FieldByName('ALIQUOTA_ICMS').AsFloat := Produto.TaxaICMS;
    FDataModule.CDSNF.Post;
    Soma;
    LimpaCamposDetalhe;
  end
  else
    Application.MessageBox('Produto não pode ser vendido com valor zerado ou negativo.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
end;

procedure TFNFe.LocalizaProduto;
begin
  Application.CreateForm(TFImportaProduto, FImportaProduto);
  UImportaProduto.QuemChamou := 'NF';
  FImportaProduto.ShowModal;
  if (trim(editCodigo.Text)<>'') then
  begin
    editCodigo.SetFocus;
    IniciaVendaDeItens;
  end;
end;

function TFNFe.DesmembraCodigoDigitado(var CodigoDeBarraOuDescricaoOuIdProduto: string; var Preco, Qtde: Extended): integer; // criado por jose rodrigues
var
  IdentificadorBalanca, vCodDescrId , vPesoOuValor: String;
  DigitosUsadosCodigoBalanca, DigitosUsadosPrecoQtde: Integer;
begin
 { Apenas para complementar, podem haver algumas variações na etiqueta impressa pela impressora.

  Essas variações podem ser:

  A - 2 C C C C 0 T T T T T T DV           Onde:         2 - Digito 2 sempre
  B - 2 C C C C 0 0 P P P P P DV                         C - Código do Produto
  C - 2 C C C C C T T T T T T DV                         0 - Espaço, não utilizado
  D - 2 C C C C C 0 P P P P P DV                         T - Valor Total a Pagar
  E - 2 C C C C C C P P P P P DV                         P - Peso ou Quantidade
                                                         DV- Digito Verificador EAN-13    }

  IdentificadorBalanca := '2';     // colocar na configuração do caixa
  DigitosUsadosCodigoBalanca := 4; //  colocar na configuração do caixa -- pode ser 4 , 5 ou 6
  DigitosUsadosPrecoQtde := 6;    // colocar na configuração do caixa pode ser 5 ou 6
  vPesoOuValor := 'VALOR';         // colocar na configuração do caixa -- pode ser VALOR OU PESO
  vCodDescrId := CodigoDeBarraOuDescricaoOuIdProduto;

  Result:= 0;

  if Length(CodigoDeBarraOuDescricaoOuIdProduto) <= 20 then
  begin
     ConsultaProdutoCodigoInterno(CodigoDeBarraOuDescricaoOuIdProduto);
     if Produto.Id <> 0 then
     begin
       Result:=5;
       exit;
     end;
  end;

  if (Length(DevolveInteiro(vCodDescrId))= 13) or (Length(DevolveInteiro(vCodDescrId))= 14) then
  begin
    if (Length(DevolveInteiro(vCodDescrId))= 13) and (IdentificadorBalanca=Copy(vCodDescrId,1,1)) then
    begin
      if vPesoOuValor = 'VALOR' then
      begin
        Preco:=StrToFloat(Copy(vCodDescrId,13-DigitosUsadosPrecoQtde,DigitosUsadosPrecoQtde))/100;
        CodigoDeBarraOuDescricaoOuIdProduto:=Copy(vCodDescrId,2,DigitosUsadosCodigoBalanca);
        Result:= 1;
      end
      else
      begin
        CodigoDeBarraOuDescricaoOuIdProduto:=Copy(vCodDescrId,2,DigitosUsadosCodigoBalanca);
        Qtde:=StrToFloat(Copy(vCodDescrId,13-DigitosUsadosPrecoQtde,DigitosUsadosPrecoQtde))/1000;
        Result:=1;
      end;
    end
    else
    begin
      CodigoDeBarraOuDescricaoOuIdProduto:=vCodDescrId;
      Result:= 2;
    end;
  end
  else if Length(DevolveInteiro(vCodDescrId))= Length(vCodDescrId) then
  begin
    CodigoDeBarraOuDescricaoOuIdProduto:=copy(vCodDescrId,1,14);
    Result := 4;
  end
  else
  begin
    CodigoDeBarraOuDescricaoOuIdProduto:=vCodDescrId;
    Result := 3;
  end;
end;

procedure TFNFe.ConsultaProduto(Codigo:String);
begin
  Produto := TProdutoController.Consulta(Codigo,2);
end;

procedure TFNFe.ConsultaProdutoCodigoBalanca(CodigoBalanca: Integer);
begin
  Produto := TProdutoController.Consulta(IntToStr(CodigoBalanca),1);
end;

procedure TFNFe.ConsultaProdutoCodigoInterno(CodigoInterno: string);
begin
  Produto := TProdutoController.Consulta(CodigoInterno,3);
end;

procedure TFNFe.ConsultaProdutoId(id: Integer);
begin
  Produto := TProdutoController.ConsultaId(Id);
end;

procedure TFNFe.MensagemDeProdutoNaoEncontrado;
begin
  Application.MessageBox('Código não encontrado.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
  LimpaCamposDetalhe;
  editCodigo.SetFocus;
end;

procedure TFNFe.DescontoOuAcrescimo;
var
  Operacao: integer;
  {
  0-Desconto em Dinheiro
  1-Desconto Percentual
  2-Acréscimo em Dinheiro
  3-Acréscimo Percentual
  5-Cancela o Desconto ou Acréscimo
  }
  Valor: Extended;
begin
  Application.CreateForm(TFDescontoAcrescimo, FDescontoAcrescimo);
  FDescontoAcrescimo.Caption := 'Desconto em Dinheiro';
  try
    if (FDescontoAcrescimo.ShowModal = MROK) then
    begin
      Operacao := FDescontoAcrescimo.ComboOperacao.ItemIndex;
      Valor := StrToFloat(FDescontoAcrescimo.EditEntrada.Text);

      //desconto em valor
      if Operacao = 0 then
      begin
        if Valor >= SubTotal then
          Application.MessageBox('Desconto não pode ser superior ou igual ao valor da venda.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION)
        else
        begin
          if Valor <= 0 then
            Application.MessageBox('Valor zerado ou negativo. Operação não realizada.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION)
          else
          begin
            Desconto := Valor;
            TaxaDesconto := TruncaValor((Valor/SubTotal)*100,Constantes.TConstantes.DECIMAIS_VALOR);
            TaxaAcrescimo := 0;
            Acrescimo := 0;
            AtualizaTotais;
          end;
        end;
      end;

      //desconto em taxa
      if Operacao = 1 then
      begin
        if Valor > 99 then
          Application.MessageBox('Desconto não pode ser superior a 100%.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION)
        else
        begin
          if Valor <= 0 then
            Application.MessageBox('Valor zerado ou negativo. Operação não realizada.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION)
          else
          begin
            TaxaDesconto := Valor;
            Desconto := TruncaValor(SubTotal * (Valor/100),Constantes.TConstantes.DECIMAIS_VALOR);
            TaxaAcrescimo := 0;
            Acrescimo := 0;
            AtualizaTotais;
          end;
        end;
      end;

      //acrescimo em valor
      if Operacao = 2 then
      begin
        if Valor <= 0 then
          Application.MessageBox('Valor zerado ou negativo. Operação não realizada.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION)
        else
        begin
          Acrescimo := Valor;
          TaxaAcrescimo := TruncaValor((Valor/SubTotal)*100,Constantes.TConstantes.DECIMAIS_VALOR);
          TaxaDesconto := 0;
          Desconto := 0;
          AtualizaTotais;
        end;
      end;

      //acrescimo em taxa
      if Operacao = 3 then
      begin
        if Valor <= 0 then
          Application.MessageBox('Valor zerado ou negativo. Operação não realizada.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION)
        else
        begin
          TaxaAcrescimo := Valor;
          Acrescimo := TruncaValor(SubTotal * (Valor/100),Constantes.TConstantes.DECIMAIS_VALOR);
          TaxaDesconto := 0;
          Desconto := 0;
          AtualizaTotais;
        end;
      end;

      //cancela desconto ou acrescimo
      if Operacao = 5 then
      begin
        TaxaAcrescimo := 0;
        TaxaDesconto := 0;
        Acrescimo := 0;
        Desconto := 0;
        AtualizaTotais;
      end;

    end;
  finally
    if Assigned(FDescontoAcrescimo) then
      FDescontoAcrescimo.Free;
  end;
end;

procedure TFNFe.editCodigoKeyPress(Sender: TObject; var Key: Char);
var
  Quantidade: Extended;
begin
  If key = #13 then
  Begin
    Key := #0;
    Perform(Wm_NextDlgCtl,0,0);
  End;

  If key = '*' then
  Begin
    Key := #0;
    try
      Quantidade := StrToFloat(editCodigo.Text);
      if (Quantidade <= 0) or (Quantidade > 999) then
      begin
        Application.MessageBox('Quantidade inválida.', 'Erro', MB_OK + MB_ICONERROR);
        editCodigo.Text := '';
        editQuantidade.Text := '1';
      end
      else
      begin
        editQuantidade.Text := editCodigo.Text;
        editCodigo.Text := '';
      end;
    except
      Application.MessageBox('Quantidade inválida.', 'Erro', MB_OK + MB_ICONERROR);
      editCodigo.Text := '';
      editQuantidade.Text := '1';
    end;
  end;
end;

procedure TFNFe.editCodigoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case key of
    VK_RETURN:
    begin
      IniciaVendaDeItens;
    end;
  end;
end;

procedure TFNFe.editCodigoClienteKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    if trim(editCodigoCliente.Text) <> '' then
    begin
      if Length(DevolveInteiro(editCodigoCliente.Text)) <= 9 then
        LocalizaClienteId;
      if Length(DevolveInteiro(editCodigoCliente.Text)) > 9 then
        LocalizaClienteCpfCnpj;
    end;
    if (trim(editCodigoCliente.Text) <> '') and (trim(editNome.Text) <> '') and (trim(editCpfCnpj.Text) <> '') then
    begin
      if CheckBoxCFVinculado.Checked then
        EditDataEmissaoCF.SetFocus
      else
        editCodigo.SetFocus;
    end;
  end;
end;

procedure TFNFe.editQuantidadeExit(Sender: TObject);
begin
  Editcodigo.SetFocus;
end;

procedure TFNFe.editCodigoEnter(Sender: TObject);
begin
  ACBrEnterTab1.EnterAsTab := False;
end;

procedure TFNFe.editCodigoExit(Sender: TObject);
begin
  ACBrEnterTab1.EnterAsTab := True;
end;

procedure TFNFe.editCodigoClienteEnter(Sender: TObject);
begin
  ACBrEnterTab1.EnterAsTab := False;
end;

procedure TFNFe.editCodigoClienteExit(Sender: TObject);
begin
  ACBrEnterTab1.EnterAsTab := False;
end;

procedure TFNFe.CheckBoxCFVinculadoClick(Sender: TObject);
begin
  if CheckBoxCFVinculado.Checked then
    EditCFOP.ReadOnly := True
  else
    EditCFOP.ReadOnly := False;
end;

procedure TFNFe.cmbNomeVendedorChange(Sender: TObject);
var
  Linha: string;
begin
  Linha := trim(cmbNomeVendedor.Text);
  if Linha <> '' then
   editCodigoVendedor.Text := DevolveConteudoDelimitado(']',linha);
end;

procedure TFNFe.FormClick(Sender: TObject);
begin
  PageControl2.Visible := False;
  PageControl2.SendToBack;
end;

procedure TFNFe.configuraNfe;
var
  Ok: Boolean;
  Diretorio, Ano: String;
  Mes: Word;
begin
  NfeConfiguracao := TNfeConfiguracaoVO.Create;
  NfeConfiguracao := TNfeConfiguracaoController.PegaConfiguracao;

  {$IFDEF ACBrNFeOpenSSL}
    FDataModule.ACBrNFe.Configuracoes.Certificados.Certificado := NfeConfiguracao.CaminhoCertificado;
    FDataModule.ACBrNFe.Configuracoes.Certificados.Senha := NfeConfiguracao.SenhaCertificado;
    edtNumSerie.Visible := False;
    sbtnGetCert.Visible := False;
  {$ELSE}
    FDataModule.ACBrNFe.Configuracoes.Certificados.NumeroSerie := NfeConfiguracao.CertificaDigital;
  {$ENDIF}


  if NfeConfiguracao.SalvaXml = 'S' then
    FDataModule.ACBrNFe.Configuracoes.Geral.Salvar := true
  else
    FDataModule.ACBrNFe.Configuracoes.Geral.Salvar := False;

  FDataModule.ACBrNFe.Configuracoes.Geral.PathSalvar := NfeConfiguracao.CaminhoSalvarXml;

  FDataModule.ACBrNFe.Configuracoes.WebServices.UF :=  NfeConfiguracao.UfWebservice;
  FDataModule.ACBrNFe.Configuracoes.WebServices.Ambiente := StrToTpAmb(OK, NfeConfiguracao.Ambiente);

  FDataModule.ACBrNFe.Configuracoes.WebServices.Visualizar := true;

  FDataModule.ACBrNFe.Configuracoes.WebServices.ProxyHost := NfeConfiguracao.ProxyHost;
  FDataModule.ACBrNFe.Configuracoes.WebServices.ProxyPort := NfeConfiguracao.ProxyPorta;
  FDataModule.ACBrNFe.Configuracoes.WebServices.ProxyUser := NfeConfiguracao.ProxyUser;
  FDataModule.ACBrNFe.Configuracoes.WebServices.ProxyPass := NfeConfiguracao.ProxySenha;

  if FDataModule.ACBrNFe.DANFE <> nil then
  begin
    FDataModule.ACBrNFe.DANFE.TipoDANFE := StrToTpImp(OK, NfeConfiguracao.FormaImpressaoDanfe);
    FDataModule.ACBrNFe.DANFE.Logo := NfeConfiguracao.Logomarca;
  end;

  FDataModule.ACBrNFe.DANFE.TamanhoFonte_DemaisCampos := NfeConfiguracao.FonteOutrosCampos;

  if FDataModule.ACBrNFe.DANFE is TACBrNFeDANFERave then
  begin
    (FDataModule.ACBrNFe.DANFE as TACBrNFeDANFERave).TamanhoFonte_ANTT := NfeConfiguracao.FonteAtt;
    (FDataModule.ACBrNFe.DANFE as TACBrNFeDANFERave).TamanhoFonte_RazaoSocial := NfeConfiguracao.FonteRazaoSocial;
    (FDataModule.ACBrNFe.DANFE as TACBrNFeDANFERave).RavFile := ExtractFilePath(Application.ExeName) + 'NotaFiscalEletronica.rav';
    if NfeConfiguracao.ImprimirUsuarioRodape = 'S' then
      (FDataModule.ACBrNFe.DANFE as TACBrNFeDANFERave).Usuario := FMenu.UsuarioLogado
    else
      (FDataModule.ACBrNFe.DANFE as TACBrNFeDANFERave).Usuario := '';
   (FDataModule.ACBrNFe.DANFE as TACBrNFeDANFERave).CasasDecimais._qCom := Constantes.TConstantes.DECIMAIS_QUANTIDADE;
   (FDataModule.ACBrNFe.DANFE as TACBrNFeDANFERave).CasasDecimais._vUnCom := Constantes.TConstantes.DECIMAIS_VALOR;
   (FDataModule.ACBrNFe.DANFE as TACBrNFeDANFERave).TipoDANFE := StrToTpImp(OK, NfeConfiguracao.FormaImpressaoDanfe);
  end;

  Ano := inttostr(YearOf(now));
  Mes := MonthOf(now);
  Diretorio := ExtractFilePath(Application.ExeName) + 'Retorno\' + NomeMonth(Mes, false)+Ano;

  ForceDirectories(Diretorio);
  FDataModule.ACBrNFe.Configuracoes.Geral.PathSalvar := Diretorio;
end;

procedure TFNFe.EnviaNFe;
begin
  FDataModule.ACBrNFe.Enviar(1,True);

  PageControl2.Visible := True;
  PageControl2.BringToFront;
  MemoResp.Lines.Text := UTF8Encode(FDataModule.ACBrNFe.WebServices.Retorno.RetWS);
  memoRespWS.Lines.Text := UTF8Encode(FDataModule.ACBrNFe.WebServices.Retorno.RetornoWS);
end;

procedure TFNFe.CancelaNFe;
var
 Chave, Protocolo, Justificativa : string;
begin
  if not(InputQuery('Cancelamento NF-e', 'Chave da NF-e', Chave)) then
     exit;
  if not(InputQuery('Cancelamento NF-e', 'Protocolo de Autorização', Protocolo)) then
     exit;
  if not(InputQuery('Cancelamento NF-e', 'Justificativa', Justificativa)) then
     exit;
  FDataModule.ACBrNFe.WebServices.Cancelamento.NFeChave      := Chave;
  FDataModule.ACBrNFe.WebServices.Cancelamento.Protocolo     := Protocolo;
  FDataModule.ACBrNFe.WebServices.Cancelamento.Justificativa := Justificativa;
  FDataModule.ACBrNFe.WebServices.Cancelamento.Executar;

  PageControl2.Visible := True;
  PageControl2.BringToFront;
  MemoResp.Lines.Text :=  UTF8Encode(FDataModule.ACBrNFe.WebServices.Cancelamento.RetWS);
  memoRespWS.Lines.Text :=  UTF8Encode(FDataModule.ACBrNFe.WebServices.Cancelamento.RetornoWS);
end;

procedure TFNFe.ImprimeDanfe;
begin
  FDataModule.ACBrNFe.NotasFiscais.Imprimir;
end;

procedure TFNFe.GridItensDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  GridItens.Canvas.Brush.Color := clWhite;
  If gdselected in state then
  begin
    GridItens.Canvas.Font.Style := [fsbold];
    GridItens.Canvas.Font.Color := clBlack;
  end;
  GridItens.DefaultDrawDataCell(Rect, GridItens.columns[datacol].field, State);
end;

//****************************************************************************//
// Aparência e controle dos painéis com as funções do programa                //
//****************************************************************************//

procedure TFNFe.panelF1MouseEnter(Sender: TObject);
begin
  panelF1.BevelOuter := bvRaised;
  panelF1.BevelWidth := 2;
end;

procedure TFNFe.panelF1MouseLeave(Sender: TObject);
begin
  panelF1.BevelOuter := bvNone;
end;

procedure TFNFe.panelF1Click(Sender: TObject);
begin
  LocalizaProduto;
end;

procedure TFNFe.panelF6MouseEnter(Sender: TObject);
begin
  panelF6.BevelOuter := bvRaised;
  panelF6.BevelWidth := 2;
end;

procedure TFNFe.panelF6MouseLeave(Sender: TObject);
begin
  panelF6.BevelOuter := bvNone;
end;

procedure TFNFe.panelF6Click(Sender: TObject);
begin
  IdentificaCliente;
end;

procedure TFNFe.panelF8MouseEnter(Sender: TObject);
begin
  panelF8.BevelOuter := bvRaised;
  panelF8.BevelWidth := 2;
end;

procedure TFNFe.panelF8MouseLeave(Sender: TObject);
begin
  panelF8.BevelOuter := bvNone;
end;

procedure TFNFe.panelF8Click(Sender: TObject);
begin
   ExcluirItem;
end;

procedure TFNFe.panelF10MouseEnter(Sender: TObject);
begin
  panelF10.BevelOuter := bvRaised;
  panelF10.BevelWidth := 2;
end;

procedure TFNFe.panelF10MouseLeave(Sender: TObject);
begin
  panelF10.BevelOuter := bvNone;
end;

procedure TFNFe.panelF10Click(Sender: TObject);
begin
  DescontoOuAcrescimo;
end;

procedure TFNFe.panelF12MouseEnter(Sender: TObject);
begin
  panelF12.BevelOuter := bvRaised;
  panelF12.BevelWidth := 2;
end;

procedure TFNFe.panelF12MouseLeave(Sender: TObject);
begin
  panelF12.BevelOuter := bvNone;
end;

procedure TFNFe.panelF12Click(Sender: TObject);
begin
  Confirma;
end;

procedure TFNFe.PanelEscMouseEnter(Sender: TObject);
begin
 PanelEsc.BevelOuter := bvRaised;
 PanelEsc.BevelWidth := 2;
end;

procedure TFNFe.PanelEscMouseLeave(Sender: TObject);
begin
  PanelEsc.BevelOuter := bvNone;
end;

procedure TFNFe.PanelEscClick(Sender: TObject);
begin
   Close;
end;

procedure TFNFe.PanelF9MouseEnter(Sender: TObject);
begin
  panelF9.BevelOuter := bvRaised;
  panelF9.BevelWidth := 2;
end;

procedure TFNFe.PanelF9MouseLeave(Sender: TObject);
begin
  panelF9.BevelOuter := bvNone;
end;

procedure TFNFe.PanelF9Click(Sender: TObject);
begin
  if RadioGroupOpcoesNFe.ItemIndex = 0 then
    AssinaSalvaXML
  else if RadioGroupOpcoesNFe.ItemIndex = 1 then
    EnviaNFe
  else if RadioGroupOpcoesNFe.ItemIndex = 2 then
    ImprimeDanfe
  else if RadioGroupOpcoesNFe.ItemIndex = 3 then
    CancelaNFe;
end;

end.
