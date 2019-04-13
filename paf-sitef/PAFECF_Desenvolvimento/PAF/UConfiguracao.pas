unit UConfiguracao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, JvExDBGrids, JvDBGrid, FMTBcd, Provider, DBClient,
  DB, SqlExpr, StdCtrls, Mask, DBCtrls, Buttons, pngimage, ExtCtrls,
  JvExStdCtrls, JvButton, JvCtrls, JvExButtons, JvBitBtn, ComCtrls, JvCombobox,
  JvColorCombo, JvExExtCtrls, JvExtComponent, JvPanel, JvOfficeColorPanel,
  JvColorBox, JvColorButton, JvBaseDlg, JvBrowseFolder, ACBrECF,
  JvExMask, JvToolEdit, JvBaseEdits;

type
  TFConfiguracao = class(TForm)
    QConfiguracao: TSQLQuery;
    DSConfiguracao: TDataSource;
    CDSConfiguracao: TClientDataSet;
    DSPConfiguracao: TDataSetProvider;
    QPosicaoComponentes: TSQLQuery;
    DSPosicaoComponentes: TDataSource;
    CDSPosicaoComponentes: TClientDataSet;
    DSPPosicaoComponentes: TDataSetProvider;
    QImpressora: TSQLQuery;
    DSImpressora: TDataSource;
    DSPImpressora: TDataSetProvider;
    CDSImpressora: TClientDataSet;
    botaoConfirma: TJvBitBtn;
    botaoCancela: TJvImgBtn;
    Image1: TImage;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    ScrollBox1: TScrollBox;
    DBLookupComboBox1: TDBLookupComboBox;
    Label1: TLabel;
    Label2: TLabel;
    DBLookupComboBox2: TDBLookupComboBox;
    QCaixa: TSQLQuery;
    DSCaixa: TDataSource;
    DSPCaixa: TDataSetProvider;
    CDSCaixa: TClientDataSet;
    DBLookupComboBox4: TDBLookupComboBox;
    Label4: TLabel;
    QEmpresa: TSQLQuery;
    DSEmpresa: TDataSource;
    DSPEmpresa: TDataSetProvider;
    CDSEmpresa: TClientDataSet;
    QResolucao: TSQLQuery;
    DSResolucao: TDataSource;
    DSPResolucao: TDataSetProvider;
    CDSResolucao: TClientDataSet;
    TabSheet2: TTabSheet;
    GridPrincipal: TJvDBGrid;
    Label3: TLabel;
    DBLookupComboBox3: TDBLookupComboBox;
    Label5: TLabel;
    DBEdit1: TDBEdit;
    Label6: TLabel;
    DBEdit2: TDBEdit;
    Label7: TLabel;
    DBEdit3: TDBEdit;
    Label9: TLabel;
    DBEdit5: TDBEdit;
    Label10: TLabel;
    PaletaCores: TJvOfficeColorPanel;
    Label11: TLabel;
    DBEdit6: TDBEdit;
    Label12: TLabel;
    DBEdit7: TDBEdit;
    Label13: TLabel;
    DBEdit8: TDBEdit;
    Folder: TJvBrowseForFolderDialog;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    Label14: TLabel;
    DBEdit9: TDBEdit;
    Label15: TLabel;
    DBEdit10: TDBEdit;
    DBCheckBox1: TDBCheckBox;
    QCFOP: TSQLQuery;
    DSCFOP: TDataSource;
    DSPCFOP: TDataSetProvider;
    CDSCFOP: TClientDataSet;
    DBLookupComboBox5: TDBLookupComboBox;
    Label17: TLabel;
    DBLookupComboBox6: TDBLookupComboBox;
    Label18: TLabel;
    Label19: TLabel;
    DBEdit11: TDBEdit;
    Label21: TLabel;
    DBEdit13: TDBEdit;
    Label22: TLabel;
    DBEdit14: TDBEdit;
    PanelScroll: TPanel;
    GroupBox1: TGroupBox;
    Label24: TLabel;
    DBEdit16: TDBEdit;
    Label25: TLabel;
    DBEdit17: TDBEdit;
    Label26: TLabel;
    DBEdit18: TDBEdit;
    Label23: TLabel;
    DBEdit15: TDBEdit;
    DBComboBox1: TDBComboBox;
    Label16: TLabel;
    Label20: TLabel;
    DBEdit12: TDBEdit;
    TabSheet3: TTabSheet;
    Label28: TLabel;
    JvDBGrid1: TJvDBGrid;
    QFormasPagamento: TSQLQuery;
    DSPFormasPagamento: TDataSetProvider;
    CDSFormasPagamento: TClientDataSet;
    DSFormasPagamento: TDataSource;
    CDSFormasPagamentoCODIGO: TStringField;
    CDSFormasPagamentoDESCRICAO: TStringField;
    CDSFormasPagamentoTEF: TStringField;
    CDSFormasPagamentoIMPRIME_VINCULADO: TStringField;
    CDSFormasPagamentoPERMITE_TROCO: TStringField;
    CDSFormasPagamentoID: TIntegerField;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    QFormasPagamentoID: TIntegerField;
    QFormasPagamentoCODIGO: TStringField;
    QFormasPagamentoDESCRICAO: TStringField;
    QFormasPagamentoTEF: TStringField;
    QFormasPagamentoIMPRIME_VINCULADO: TStringField;
    QFormasPagamentoPERMITE_TROCO: TStringField;
    TabSheet4: TTabSheet;
    GroupBox2: TGroupBox;
    cmbTipoConfiguracaoBalanca: TComboBox;
    Label38: TLabel;
    GroupBox3: TGroupBox;
    Label29: TLabel;
    cmbBalanca: TComboBox;
    Label30: TLabel;
    cmbPortaSerial: TComboBox;
    Label31: TLabel;
    Label32: TLabel;
    cmbDataBits: TComboBox;
    Label33: TLabel;
    cmbParity: TComboBox;
    Label35: TLabel;
    cmbStopBits: TComboBox;
    Label34: TLabel;
    cmbHandShaking: TComboBox;
    Label36: TLabel;
    editTimeOut: TEdit;
    DBEdit20: TDBEdit;
    cmbBaudRate: TComboBox;
    TabSheet5: TTabSheet;
    Label37: TLabel;
    cmbPesquisaSQL: TComboBox;
    Label39: TLabel;
    cmbPedeCPF: TComboBox;
    cmbTipoIntegracao: TComboBox;
    Label40: TLabel;
    cmbTimerIntegracao: TComboBox;
    Label41: TLabel;
    cmbGavetaDinheiro: TComboBox;
    Label42: TLabel;
    cmbSinalInvertido: TComboBox;
    Label43: TLabel;
    QFormasPagamentoTEF_TIPO_GP: TStringField;
    QFormasPagamentoGERA_PARCELAS: TStringField;
    CDSFormasPagamentoTEF_TIPO_GP: TStringField;
    CDSFormasPagamentoGERA_PARCELAS: TStringField;
    GroupBox4: TGroupBox;
    cmbUsaLeitorSerial: TComboBox;
    Label44: TLabel;
    Label45: TLabel;
    cmbPortaLeitorSerial: TComboBox;
    Label46: TLabel;
    cmbBaudLeitorSerial: TComboBox;
    Label47: TLabel;
    editSufixoLeitorSerial: TEdit;
    Label48: TLabel;
    editIntervaloLeitorSerial: TEdit;
    Label49: TLabel;
    Label50: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    editDataLeitorSerial: TEdit;
    cmbParidadeLeitorSerial: TComboBox;
    cmbHandShakeLeitorSerial: TComboBox;
    cmbStopLeitorSerial: TComboBox;
    cmbHardFlowSerial: TComboBox;
    cmbFilaLeitorSerial: TComboBox;
    cmbSufixoLeitorSerial: TComboBox;
    Label53: TLabel;
    Label54: TLabel;
    Label55: TLabel;
    editQtdeParcelas: TJvCalcEdit;
    Label56: TLabel;
    cmbSoftFlowSerial: TComboBox;
    Label57: TLabel;
    btFormaPgtoECF: TSpeedButton;
    DBGrid1: TDBGrid;
    btSincPgto: TSpeedButton;
    Label58: TLabel;
    Label59: TLabel;
    cmbImprimeParcela: TComboBox;
    cmbTecladoReduzido: TComboBox;
    Label60: TLabel;
    botaoBancoDados: TJvBitBtn;
    cmbNF2: TComboBox;
    Label61: TLabel;
    CDSConfiguracaoID: TIntegerField;
    CDSConfiguracaoID_ECF_IMPRESSORA: TIntegerField;
    CDSConfiguracaoID_ECF_RESOLUCAO: TIntegerField;
    CDSConfiguracaoID_ECF_CAIXA: TIntegerField;
    CDSConfiguracaoID_ECF_EMPRESA: TIntegerField;
    CDSConfiguracaoMENSAGEM_CUPOM: TStringField;
    CDSConfiguracaoPORTA_ECF: TStringField;
    CDSConfiguracaoIP_SERVIDOR: TStringField;
    CDSConfiguracaoIP_SITEF: TStringField;
    CDSConfiguracaoTIPO_TEF: TStringField;
    CDSConfiguracaoTITULO_TELA_CAIXA: TStringField;
    CDSConfiguracaoCAMINHO_IMAGENS_PRODUTOS: TStringField;
    CDSConfiguracaoCAMINHO_IMAGENS_MARKETING: TStringField;
    CDSConfiguracaoCAMINHO_IMAGENS_LAYOUT: TStringField;
    CDSConfiguracaoCOR_JANELAS_INTERNAS: TStringField;
    CDSConfiguracaoMARKETING_ATIVO: TStringField;
    CDSConfiguracaoCFOP_ECF: TIntegerField;
    CDSConfiguracaoCFOP_NF2: TIntegerField;
    CDSConfiguracaoTIMEOUT_ECF: TIntegerField;
    CDSConfiguracaoINTERVALO_ECF: TIntegerField;
    CDSConfiguracaoDESCRICAO_SUPRIMENTO: TStringField;
    CDSConfiguracaoDESCRICAO_SANGRIA: TStringField;
    CDSConfiguracaoTEF_TIPO_GP: TIntegerField;
    CDSConfiguracaoTEF_TEMPO_ESPERA: TIntegerField;
    CDSConfiguracaoTEF_ESPERA_STS: TIntegerField;
    CDSConfiguracaoTEF_NUMERO_VIAS: TIntegerField;
    CDSConfiguracaoDECIMAIS_QUANTIDADE: TIntegerField;
    CDSConfiguracaoDECIMAIS_VALOR: TIntegerField;
    CDSConfiguracaoBITS_POR_SEGUNDO: TIntegerField;
    CDSConfiguracaoQTDE_MAXIMA_CARTOES: TIntegerField;
    CDSConfiguracaoPESQUISA_PARTE: TStringField;
    CDSConfiguracaoCONFIGURACAO_BALANCA: TStringField;
    CDSConfiguracaoPARAMETROS_DIVERSOS: TStringField;
    CDSConfiguracaoULTIMA_EXCLUSAO: TIntegerField;
    CDSConfiguracaoLAUDO: TStringField;
    CDSConfiguracaoINDICE_GERENCIAL: TStringField;
    CDSConfiguracaoSINCRONIZADO: TStringField;
    procedure Confirma;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure botaoConfirmaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure PaletaCoresColorChange(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure PreparaConfiguracaoBalancaParaGravacao;
    procedure PreparaParametrosDiversosParaGravacao;
    procedure FormShow(Sender: TObject);
    procedure CarregaEditsConfiguracaoBalanca;
    procedure CarregaEditsParametrosDiversos;
    procedure editTimeOutKeyPress(Sender: TObject; var Key: Char);
    procedure cmbPesquisaSQLChange(Sender: TObject);
    procedure btFormaPgtoECFClick(Sender: TObject);
    procedure btSincPgtoClick(Sender: TObject);
    procedure botaoBancoDadosClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FConfiguracao: TFConfiguracao;
  CDS: TClientDataSet;
  DS: TDataSource;
implementation

uses UDataModule, UCaixa, TotalTipoPagamentoController, Biblioteca,
  UConfigConexao, ConfiguracaoController;

{$R *.dfm}

procedure TFConfiguracao.botaoConfirmaClick(Sender: TObject);
begin
  Confirma;
end;

procedure TFConfiguracao.cmbPesquisaSQLChange(Sender: TObject);
begin
  CDSConfiguracao.Edit;
  CDSConfiguracao.FieldByName('PESQUISA_PARTE').AsString := copy(trim(cmbPesquisaSQL.Text),1,1);
end;

procedure TFConfiguracao.confirma;
begin
  PreparaConfiguracaoBalancaParaGravacao;
  PreparaParametrosDiversosParaGravacao;
  Application.ProcessMessages;
  if CDSConfiguracao.State in [dsEdit] then
  begin
    CDSConfiguracao.Post;
    CDSConfiguracao.ApplyUpdates(0);
  end;
  if CDSPosicaoComponentes.State in [dsEdit] then
  begin
    CDSPosicaoComponentes.Post;
    CDSPosicaoComponentes.ApplyUpdates(0);
  end;
  TConfiguracaoController.IntegracaoConfiguracao;
  Close;
end;

procedure TFConfiguracao.editTimeOutKeyPress(Sender: TObject; var Key: Char);
begin
  if not CharInSet(Key,['0'..'9',#8,#13]) then
    key:=#0;
end;

procedure TFConfiguracao.FormActivate(Sender: TObject);
begin
  Color := StringToColor(UCaixa.Configuracao.CorJanelasInternas);
end;

procedure TFConfiguracao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Assigned(CDS) then
    FreeAndNil(CDS);
  Action := caFree;
end;

procedure TFConfiguracao.FormCreate(Sender: TObject);
begin
  CDSCaixa.Active := True;
  CDSCFOP.Active := True;
  CDSConfiguracao.Active := True;
  CDSEmpresa.Active := True;
  CDSImpressora.Active := True;
  CDSResolucao.Active := True;
  CDSPosicaoComponentes.Active := True;
  CDSFormasPagamento.Active := True;
  //
  CDSPosicaoComponentes.MasterSource := DSResolucao;
  CDSPosicaoComponentes.MasterFields := 'ID';
  CDSPosicaoComponentes.IndexFieldNames := 'ID_ECF_RESOLUCAO';

  //  Adicionado por Daniel Wanderley
  CDS := TClientDataSet.Create(nil);
  CDS.FieldDefs.Add('Codigo', ftString, 3);
  CDS.FieldDefs.Add('Descricao',ftString,40);
  CDS.FieldDefs.Add('Vinculado',ftString,1);
  CDS.FieldDefs.Add('Sincronizado',ftString,1);
  CDS.CreateDataSet;

  DS := TDataSource.Create(nil);
  DS.DataSet := CDS;

  DBGrid1.DataSource :=  DS;
  DBGrid1.Columns[0].Title.Caption := 'Codigo';
  DBGrid1.Columns[1].Title.Caption := 'Descricao';
  DBGrid1.Columns[2].Title.Caption := 'Vinculado';
  DBGrid1.Columns[3].Title.Caption := 'Sincronizado';
end;

procedure TFConfiguracao.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key = 123 then
    Confirma;
end;

procedure TFConfiguracao.FormShow(Sender: TObject);
begin
  PageControl1.ActivePageIndex:=0;
  CarregaEditsConfiguracaoBalanca;
  CarregaEditsParametrosDiversos;
end;

procedure TFConfiguracao.botaoBancoDadosClick(Sender: TObject);
begin
  Application.CreateForm(TFConfigConexao,FConfigConexao);
  FConfigConexao.ShowModal;
end;

procedure TFConfiguracao.PaletaCoresColorChange(Sender: TObject);
begin
  CDSConfiguracao.Edit;
  CDSConfiguracao.FieldByName('COR_JANELAS_INTERNAS').AsString := ColorToString(PaletaCores.SelectedColor);
end;

procedure TFConfiguracao.SpeedButton1Click(Sender: TObject);
begin
  Folder.Execute;
  DBEdit6.Text := Folder.Directory + '\';
  CDSConfiguracao.Edit;
end;

procedure TFConfiguracao.SpeedButton2Click(Sender: TObject);
begin
  Folder.Execute;
  DBEdit7.Text := Folder.Directory + '\';
  CDSConfiguracao.Edit;
end;

procedure TFConfiguracao.SpeedButton3Click(Sender: TObject);
begin
  Folder.Execute;
  DBEdit8.Text := Folder.Directory + '\';
  CDSConfiguracao.Edit;
end;

procedure TFConfiguracao.SpeedButton4Click(Sender: TObject);
var
  i: Integer;
begin
  if TTotalTipoPagamentoController.QuantidadeRegistroTabela > 0 then
  begin
    Application.MessageBox('Já foram efetuadas vendas com as formas de pagamento cadastradas no sistema'
    +#13+#13+'OU ocorreu algum erro ao tentar efetuar a operação.', 'Informação do Sistema', Mb_OK + MB_ICONINFORMATION);
  end
  else
  begin
    //limpa a tabela
    CDSFormasPagamento.First;
    while not CDSFormasPagamento.Eof do
      CDSFormasPagamento.Delete;

    //Bematech e NaoFiscal permitem cadastrar formas de Pagamento dinamicamente
    if (FDataModule.ACBrECF.Modelo in [ecfBematech, ecfNaoFiscal])then
      FDataModule.ACBrECF.CarregaFormasPagamento
    else
      FDataModule.ACBrECF.AchaFPGIndice('') ;  { força carregar, se ainda nao o fez }

    for i := 0 to FDataModule.ACBrECF.FormasPagamento.Count - 1 do
    begin
      CDSFormasPagamento.Append;
      //CDSFormasPagamento.FieldByName('ID').AsInteger := i+1;
      CDSFormasPagamento.FieldByName('CODIGO').AsString := FDataModule.ACBrECF.FormasPagamento[i].Indice;
      CDSFormasPagamento.FieldByName('DESCRICAO').AsString := FDataModule.ACBrECF.FormasPagamento[i].Descricao;
      CDSFormasPagamento.FieldByName('GERA_PARCELAS').AsString := 'N';
      if FDataModule.ACBrECF.FormasPagamento[i].PermiteVinculado then
        CDSFormasPagamento.FieldByName('IMPRIME_VINCULADO').AsString := 'S'
      else
        CDSFormasPagamento.FieldByName('IMPRIME_VINCULADO').AsString := 'N';
      CDSFormasPagamento.Post;
    end;
  end;
end;

procedure TFConfiguracao.SpeedButton5Click(Sender: TObject);
begin
  if CDSFormasPagamento.State in [DsEdit,DsInsert] then
    CDSFormasPagamento.Post;
  CDSFormasPagamento.ApplyUpdates(0);
  CDSFormasPagamento.Close;
  CDSFormasPagamento.Open;
end;

procedure TFConfiguracao.btFormaPgtoECFClick(Sender: TObject);
var
  i: Integer;
begin
  try
    CDS.Close;
    CDS.CreateDataSet;
    CDS.DisableControls;
    //Bematech e NaoFiscal permitem cadastrar formas de Pagamento dinamicamente
    if (FDataModule.ACBrECF.Modelo in [ecfBematech, ecfNaoFiscal])then
      FDataModule.ACBrECF.CarregaFormasPagamento
    else
      FDataModule.ACBrECF.AchaFPGIndice('') ;  { força carregar, se ainda nao o fez }

    for i := 0 to FDataModule.ACBrECF.FormasPagamento.Count - 1 do
    begin
      CDS.Append;
      CDS.FieldByName('CODIGO').AsString := FDataModule.ACBrECF.FormasPagamento[i].Indice;
      CDS.FieldByName('DESCRICAO').AsString := FDataModule.ACBrECF.FormasPagamento[i].Descricao;
      if FDataModule.ACBrECF.FormasPagamento[i].PermiteVinculado then
        CDS.FieldByName('VINCULADO').AsString := 'S'
      else
        CDS.FieldByName('VINCULADO').AsString := 'N';
      if CDSFormasPagamento.Locate('Descricao',CDS.FieldByName('Descricao').AsString,[loCaseInsensitive]) then
      begin
        if CDS.FieldByName('Codigo').AsString = CDSFormasPagamentoCODIGO.AsString then
          CDS.FieldByName('Sincronizado').AsString := 'S'
        else
          CDS.FieldByName('Sincronizado').AsString := 'N';
      end
      else
        CDS.FieldByName('Sincronizado').AsString := 'N';
      CDS.Post;
    end;
  finally
    CDS.EnableControls;
    CDSFormasPagamento.EnableControls;
  end;
end;

procedure TFConfiguracao.btSincPgtoClick(Sender: TObject);
var
  vDescricao: String;
  vBoolean: Boolean;
begin
  try
    if Application.MessageBox('Esta operação grava formas de pagamento no ECF e não é possível reverter este processo. Deseja Continuar?', 'Pergunta do Sistema', Mb_YesNo + Mb_IconQuestion) = IdNo then
      Exit;

    btFormaPgtoECF.Click;

    CDS.DisableControls;
    CDSFormasPagamento.DisableControls;

    CDSFormasPagamento.First;
    while not CDSFormasPagamento.eof do
    begin
      if CDS.Locate('Descricao',CDSFormasPagamentoDESCRICAO.AsString,[loCaseInsensitive]) then
      begin
        if CDS.FieldByName('Sincronizado').AsString <> 'S' then
        begin
          CDSFormasPagamento.Edit;
          CDSFormasPagamentoCODIGO.AsString := CDS.FieldByName('Codigo').AsString;
          CDSFormasPagamento.Post;

          CDS.Edit;
          CDS.FieldByName('Sincronizado').AsString := 'S';
          CDS.Post
        end;
      end
      else
      begin
        vDescricao := CDSFormasPagamentoDESCRICAO.AsString;
        vBoolean := (CDSFormasPagamentoIMPRIME_VINCULADO.AsString = 'S');
        FDataModule.ACBrECF.ProgramaFormaPagamento(vDescricao,vBoolean);
        CDS.Append;
        CDS.FieldByName('Descricao').AsString    := CDSFormasPagamentoDESCRICAO.AsString;
        CDS.FieldByName('Vinculado').AsString    := CDSFormasPagamentoIMPRIME_VINCULADO.AsString;
        CDS.FieldByName('Sincronizado').AsString := 'N';
      end;
      CDSFormasPagamento.Next;
    end;
    CDSFormasPagamento.ApplyUpdates(0);
    btFormaPgtoECF.Click;
  finally
    CDS.EnableControls;
    CDSFormasPagamento.EnableControls;
  end;
end;

procedure TFConfiguracao.PreparaConfiguracaoBalancaParaGravacao;
begin
   CDSConfiguracao.Edit;
   CDSConfiguracaoCONFIGURACAO_BALANCA.AsString:= IntToStr(cmbBalanca.ItemIndex)+'|'+
                                                  copy(cmbTipoConfiguracaoBalanca.Text,1,1)+'|'+
                                                  IntToStr(cmbHandShaking.ItemIndex)+'|'+
                                                  IntToStr(cmbParity.ItemIndex)+'|'+
                                                  IntToStr(cmbStopBits.ItemIndex)+'|'+
                                                  trim(cmbDataBits.Text)+'|'+
                                                  trim(cmbBaudRate.Text)+'|'+
                                                  trim(cmbPortaSerial.Text)+'|'+
                                                  trim(editTimeOut.Text)+'|'+
                                                  trim(cmbTipoConfiguracaoBalanca.Text)+'|';
end;

procedure TFConfiguracao.PreparaParametrosDiversosParaGravacao;
begin
  CDSConfiguracao.Edit;
  CDSConfiguracaoPARAMETROS_DIVERSOS.AsString:= IntToStr(cmbPedeCPF.ItemIndex)+'|'+
                                                IntToStr(cmbTipoIntegracao.ItemIndex)+'|'+
                                                IntToStr(cmbTimerIntegracao.ItemIndex)+'|'+
                                                IntToStr(cmbGavetaDinheiro.ItemIndex)+'|'+
                                                IntToStr(cmbSinalInvertido.ItemIndex)+'|'+
                                                IntToStr(editQtdeParcelas.AsInteger)+'|'+
                                                IntToStr(cmbImprimeParcela.ItemIndex)+'|'+
                                                IntToStr(cmbTecladoReduzido.ItemIndex)+'|'+

                                                IntToStr(cmbUsaLeitorSerial.ItemIndex)+'|'+
                                                Trim(cmbPortaLeitorSerial.Text)+'|'+
                                                Trim(cmbBaudLeitorSerial.Text)+'|'+
                                                Trim(editSufixoLeitorSerial.Text)+'|'+
                                                Trim(editIntervaloLeitorSerial.Text)+'|'+
                                                Trim(editDataLeitorSerial.Text)+'|'+
                                                IntToStr(cmbParidadeLeitorSerial.ItemIndex)+'|'+
                                                IntToStr(cmbHardFlowSerial.ItemIndex)+'|'+
                                                IntToStr(cmbSoftFlowSerial.ItemIndex)+'|'+
                                                IntToStr(cmbHandShakeLeitorSerial.ItemIndex)+'|'+
                                                IntToStr(cmbStopLeitorSerial.ItemIndex)+'|'+
                                                IntToStr(cmbFilaLeitorSerial.ItemIndex)+'|'+
                                                IntToStr(cmbSufixoLeitorSerial.ItemIndex)+'|'+

                                                IntToStr(cmbNF2.ItemIndex)+'|';
end;

procedure TFConfiguracao.CarregaEditsConfiguracaoBalanca;
var
  Linha: String;
begin
  Linha:= trim(CDSConfiguracao.FieldByName('CONFIGURACAO_BALANCA').AsString);

  cmbBalanca.ItemIndex := StrToIntDef(DevolveConteudoDelimitado('|',Linha),0);
  DevolveConteudoDelimitado('|',Linha);
  cmbHandShaking.ItemIndex := StrToIntDef(DevolveConteudoDelimitado('|',Linha),0);
  cmbParity.ItemIndex := StrToIntDef(DevolveConteudoDelimitado('|',Linha),0);
  cmbStopBits.ItemIndex := StrToIntDef(DevolveConteudoDelimitado('|',Linha),0);
  cmbDataBits.ItemIndex := StrToIntDef(DevolveConteudoDelimitado('|',Linha),0);
  cmbBaudRate.Text := DevolveConteudoDelimitado('|',Linha);
  cmbPortaSerial.Text := DevolveConteudoDelimitado('|',Linha);
  editTimeOut.Text := DevolveConteudoDelimitado('|',Linha);
  cmbTipoConfiguracaoBalanca.Text := DevolveConteudoDelimitado('|',Linha);
end;

procedure TFConfiguracao.CarregaEditsParametrosDiversos;
var
  Linha: String;
begin
  cmbPesquisaSQL.ItemIndex:=StrToIntDef(CDSConfiguracao.FieldByName('PESQUISA_PARTE').AsString,0);

  Linha:= trim(CDSConfiguracao.FieldByName('PARAMETROS_DIVERSOS').AsString);

  cmbPedeCPF.ItemIndex := StrToIntDef(DevolveConteudoDelimitado('|',Linha),0);
  cmbTipoIntegracao.ItemIndex := StrToIntDef(DevolveConteudoDelimitado('|',Linha),0);
  cmbTimerIntegracao.ItemIndex := StrToIntDef(DevolveConteudoDelimitado('|',Linha),0);
  cmbGavetaDinheiro.ItemIndex := StrToIntDef(DevolveConteudoDelimitado('|',Linha),0);
  cmbSinalInvertido.ItemIndex := StrToIntDef(DevolveConteudoDelimitado('|',Linha),0);
  editQtdeParcelas.AsInteger := StrToIntDef(DevolveConteudoDelimitado('|',Linha),0);
  cmbImprimeParcela.ItemIndex := StrToIntDef(DevolveConteudoDelimitado('|',Linha),0);
  cmbTecladoReduzido.ItemIndex := StrToIntDef(DevolveConteudoDelimitado('|',Linha),0);
  cmbUsaLeitorSerial.ItemIndex := StrToIntDef(DevolveConteudoDelimitado('|',Linha),0);
  cmbPortaLeitorSerial.Text := DevolveConteudoDelimitado('|',Linha);
  cmbBaudLeitorSerial.Text := DevolveConteudoDelimitado('|',Linha);
  editSufixoLeitorSerial.Text := DevolveConteudoDelimitado('|',Linha);
  editIntervaloLeitorSerial.Text := DevolveConteudoDelimitado('|',Linha);
  editDataLeitorSerial.Text := DevolveConteudoDelimitado('|',Linha);
  cmbParidadeLeitorSerial.ItemIndex := StrToIntDef(DevolveConteudoDelimitado('|',Linha),0);
  cmbHardFlowSerial.ItemIndex := StrToIntDef(DevolveConteudoDelimitado('|',Linha),0);
  cmbSoftFlowSerial.ItemIndex := StrToIntDef(DevolveConteudoDelimitado('|',Linha),0);
  cmbHandShakeLeitorSerial.ItemIndex := StrToIntDef(DevolveConteudoDelimitado('|',Linha),0);
  cmbStopLeitorSerial.ItemIndex := StrToIntDef(DevolveConteudoDelimitado('|',Linha),0);
  cmbFilaLeitorSerial.ItemIndex := StrToIntDef(DevolveConteudoDelimitado('|',Linha),0);
  cmbSufixoLeitorSerial.ItemIndex := StrToIntDef(DevolveConteudoDelimitado('|',Linha),0);
  cmbNF2.ItemIndex := StrToIntDef(DevolveConteudoDelimitado('|',Linha),0);
end;

end.
