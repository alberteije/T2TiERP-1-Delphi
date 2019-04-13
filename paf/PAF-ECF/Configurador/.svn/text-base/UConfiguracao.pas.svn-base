unit UConfiguracao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, JvExDBGrids, JvDBGrid, FMTBcd, Provider, DBClient,
  DB, SqlExpr, StdCtrls, Mask, DBCtrls, Buttons, pngimage, ExtCtrls,
  JvExStdCtrls, JvButton, JvCtrls, JvExButtons, JvBitBtn, ComCtrls, JvCombobox,
  JvColorCombo, JvExExtCtrls, JvExtComponent, JvPanel, JvOfficeColorPanel,
  JvExControls, JvColorBox, JvColorButton, JvBaseDlg, JvBrowseFolder, ACBrECF,
  JvExMask, JvToolEdit, JvBaseEdits, ConfiguracaoVO, TypInfo, jpeg, IniFiles,
  JvSpin, ACBrNFe, FileCtrl;


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
    CDSConfiguracaoSINCRONIZADO: TStringField;
    QImpressora: TSQLQuery;
    DSImpressora: TDataSource;
    DSPImpressora: TDataSetProvider;
    CDSImpressora: TClientDataSet;
    botaoConfirma: TJvBitBtn;
    botaoSair: TJvImgBtn;
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
    Label8: TLabel;
    DBEdit4: TDBEdit;
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
    Label27: TLabel;
    DBEdit19: TDBEdit;
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
    btnCarregaFormasPgto: TSpeedButton;
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
    CDSConfiguracaoCONFIGURACAO_BALANCA: TStringField;
    DBEdit20: TDBEdit;
    cmbBaudRate: TComboBox;
    TabSheet5: TTabSheet;
    Label37: TLabel;
    cmbPesquisaSQL: TComboBox;
    CDSConfiguracaoPESQUISA_PARTE: TStringField;
    Label39: TLabel;
    cmbPedeCPF: TComboBox;
    cmbTipoIntegracao: TComboBox;
    Label40: TLabel;
    CDSConfiguracaoPARAMETROS_DIVERSOS: TStringField;
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
    CDSConfiguracaoDECIMAIS_QUANTIDADE: TIntegerField;
    CDSConfiguracaoDECIMAIS_VALOR: TIntegerField;
    CDSConfiguracaoBITS_POR_SEGUNDO: TIntegerField;
    CDSConfiguracaoQTDE_MAXIMA_CARTOES: TIntegerField;
    CDSConfiguracaoULTIMA_EXCLUSAO: TIntegerField;
    CDSConfiguracaoLAUDO: TStringField;
    botaoBancoDados: TJvBitBtn;
    botaoConfiguraTurno: TJvBitBtn;
    btnReconectaImpressora: TJvBitBtn;
    Label61: TLabel;
    SinalVerde: TImage;
    SinalVermelho: TImage;
    JvBitBtn1: TJvBitBtn;
    DBEdit21: TDBEdit;
    Label62: TLabel;
    TabSheet6: TTabSheet;
    GroupBox5: TGroupBox;
    GroupBox7: TGroupBox;
    GroupBox8: TGroupBox;
    GroupBox9: TGroupBox;
    GroupBox10: TGroupBox;
    GroupBox11: TGroupBox;
    GroupBox12: TGroupBox;
    GroupBox13: TGroupBox;
    Label64: TLabel;
    Label67: TLabel;
    Label69: TLabel;
    Label71: TLabel;
    Label73: TLabel;
    Label75: TLabel;
    Label77: TLabel;
    Label79: TLabel;
    Label81: TLabel;
    Label83: TLabel;
    Label85: TLabel;
    GroupBox6: TGroupBox;
    GroupBox15: TGroupBox;
    Label87: TLabel;
    Label88: TLabel;
    editValor: TEdit;
    editMD5: TEdit;
    geraMD5: TButton;
    editBD: TEdit;
    editBDBalcao: TEdit;
    editImporta: TEdit;
    editCNPJEstabelecimento: TEdit;
    editGT: TEdit;
    editQuantidade: TEdit;
    editEmpesa: TEdit;
    editCNPJ: TEdit;
    editNome_PAF: TEdit;
    editMD5PrincipalEXE: TEdit;
    editArquivos: TEdit;
    JvBitBtn2: TJvBitBtn;
    JvBitBtn4: TJvBitBtn;
    JvBitBtn3: TJvBitBtn;
    Label65: TLabel;
    Label66: TLabel;
    SerieECF: TEdit;
    GTECF: TEdit;
    GroupBox14: TGroupBox;
    MemoSerieEcf: TMemo;
    Label63: TLabel;
    editRegistraPreVenda: TEdit;
    Label68: TLabel;
    editImprimeDAV: TEdit;
    Label70: TLabel;
    edtIndiceGerencial: TDBEdit;
    TabSheet7: TTabSheet;
    GroupBox16: TGroupBox;
    Label72: TLabel;
    cmbFun1: TComboBox;
    Label74: TLabel;
    Label76: TLabel;
    cmbFun2: TComboBox;
    cmbFun3: TComboBox;
    GroupBox17: TGroupBox;
    Label78: TLabel;
    Label80: TLabel;
    Label82: TLabel;
    Label84: TLabel;
    cmbPar1: TComboBox;
    cmbPar2: TComboBox;
    cmbPar3: TComboBox;
    cmbPar4: TComboBox;
    GroupBox18: TGroupBox;
    cmbApl1: TComboBox;
    cmbApl2: TComboBox;
    cmbApl3: TComboBox;
    cmbApl4: TComboBox;
    cmbApl5: TComboBox;
    cmbApl6: TComboBox;
    cmbApl7: TComboBox;
    Label86: TLabel;
    Label89: TLabel;
    Label90: TLabel;
    Label91: TLabel;
    Label92: TLabel;
    Label93: TLabel;
    Label94: TLabel;
    GroupBox19: TGroupBox;
    Label95: TLabel;
    Label96: TLabel;
    Label97: TLabel;
    Label98: TLabel;
    cmbCri1: TComboBox;
    cmbCri2: TComboBox;
    cmbCri3: TComboBox;
    cmbCri4: TComboBox;
    GroupBox20: TGroupBox;
    Label99: TLabel;
    Label100: TLabel;
    cmbXXII1: TComboBox;
    cmbXXII2: TComboBox;
    GroupBox21: TGroupBox;
    Label101: TLabel;
    cmbXXXVI1: TComboBox;
    tsNfeConfig: TTabSheet;
    GroupBox23: TGroupBox;
    Label105: TLabel;
    Label106: TLabel;
    Label107: TLabel;
    Label108: TLabel;
    Label115: TLabel;
    Label116: TLabel;
    edtSmtpHost: TEdit;
    edtSmtpPort: TEdit;
    edtSmtpUser: TEdit;
    edtSmtpPass: TEdit;
    edtEmailAssunto: TEdit;
    cbEmailSSL: TCheckBox;
    mmEmailMsg: TMemo;
    gbProxy: TGroupBox;
    Label120: TLabel;
    Label121: TLabel;
    Label126: TLabel;
    Label127: TLabel;
    edtProxyHost: TEdit;
    edtProxyPorta: TEdit;
    edtProxyUser: TEdit;
    edtProxySenha: TEdit;
    GroupBox25: TGroupBox;
    Label110: TLabel;
    sbtnLogoMarca: TSpeedButton;
    sbtnPathSalvar: TSpeedButton;
    Label117: TLabel;
    Label118: TLabel;
    Label119: TLabel;
    edtLogoMarca: TEdit;
    edtPathLogs: TEdit;
    cbSalvar: TCheckBox;
    edtFonteAtt: TJvSpinEdit;
    edtFontRazao: TJvSpinEdit;
    edtOutrosCampos: TJvSpinEdit;
    GroupBox24: TGroupBox;
    Label103: TLabel;
    Label104: TLabel;
    sbtnCaminhoCert: TSpeedButton;
    Label109: TLabel;
    sbtnGetCert: TSpeedButton;
    edtCaminho: TEdit;
    edtSenha: TEdit;
    edtNumSerie: TEdit;
    rgTipoAmb: TRadioGroup;
    rgTipoDanfe: TRadioGroup;
    GroupBox22: TGroupBox;
    Label102: TLabel;
    cbUF: TComboBox;
    cbPrintUser: TCheckBox;
    qNFe: TSQLQuery;
    dspNFe: TDataSetProvider;
    cdsNFe: TClientDataSet;
    dsNfe: TDataSource;
    oArquivos: TOpenDialog;
    nfeFiscal: TACBrNFe;
    CDSConfiguracaoINDICE_GERENCIAL: TStringField;
    cdsNFeID: TIntegerField;
    cdsNFeCERTIFICADO_DIGITAL: TStringField;
    cdsNFeCAMINHO_CERTIFICADO: TStringField;
    cdsNFeSENHA_CERTIFICADO: TStringField;
    cdsNFeFORMATO_IMPRESSAO_DANFE: TStringField;
    cdsNFeLOGOMARCA: TStringField;
    cdsNFeCAMINHO_SALVAR_XML: TStringField;
    cdsNFeSALVA_XML: TStringField;
    cdsNFeFONTE_ATT: TIntegerField;
    cdsNFeFONTE_OUTROS_CAMPOS: TIntegerField;
    cdsNFeFONTE_RAZAO_SOCIAL: TIntegerField;
    cdsNFeIMPRIMIR_DETALHE_ESPECIFICO: TIntegerField;
    cdsNFeUF_WEBSERVICE: TStringField;
    cdsNFeAMBIENTE: TStringField;
    cdsNFeNOME_HOST: TStringField;
    cdsNFePORTA: TIntegerField;
    cdsNFeUSUARIO: TStringField;
    cdsNFeSENHA: TStringField;
    cdsNFeASSUNTO: TStringField;
    cdsNFeAUTENTICA_SSL: TStringField;
    cdsNFePROXY_HOST: TStringField;
    cdsNFePROXY_PORTA: TStringField;
    cdsNFePROXY_USER: TStringField;
    cdsNFePROXY_SENHA: TStringField;
    cdsNFeIMPRIMIR_USUARIO_RODAPE: TStringField;
    cdsNFeTEXTO_EMAIL: TMemoField;
    CDSConfiguracaoDATA_ATUALIZACAO_ESTOQUE: TDateField;
    procedure confirma;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure botaoConfirmaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure PaletaCoresColorChange(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCarregaFormasPgtoClick(Sender: TObject);
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
    procedure botaoConfiguraTurnoClick(Sender: TObject);
    procedure CarregaArquivoAuxiliar;
    procedure ConfiguraACBr;
    procedure PegaConfiguracao;
    procedure SalvaNFEConfiguracao;
    procedure PegaNFEConfiguracao;
    procedure btnReconectaImpressoraClick(Sender: TObject);
    procedure JvBitBtn1Click(Sender: TObject);
    procedure EditClick(Sender: TObject);
    procedure geraMD5Click(Sender: TObject);
    procedure JvBitBtn2Click(Sender: TObject);
    procedure JvBitBtn3Click(Sender: TObject);
    procedure JvBitBtn4Click(Sender: TObject);
    procedure sbtnGetCertClick(Sender: TObject);
    procedure sbtnCaminhoCertClick(Sender: TObject);
    procedure sbtnLogoMarcaClick(Sender: TObject);
    procedure sbtnPathSalvarClick(Sender: TObject);
    procedure GroupBox10Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    PodeLogar: Boolean;
  end;

var
  FConfiguracao: TFConfiguracao;
  CDS: TClientDataSet;
  DS: TDataSource;
  Configuracao: TConfiguracaoVO;


implementation

uses UDataModule, TotalTipoPagamentoController, Biblioteca,
  UConfigConexao, UTurno, USplash, ConfiguracaoController, UUsuario, ULogin;

const
  SELDIRHELP = 1000;

{$R *.dfm}

procedure TFConfiguracao.botaoConfiguraTurnoClick(Sender: TObject);
begin
  Application.CreateForm(TFTurno, FTurno);
  FTurno.ShowModal;
end;

procedure TFConfiguracao.botaoConfirmaClick(Sender: TObject);
begin
  confirma;
  SalvaNFEConfiguracao;
  Application.MessageBox('Dados salvos corretamente.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
end;

procedure TFConfiguracao.cmbPesquisaSQLChange(Sender: TObject);
begin
  CDSConfiguracao.Edit;
  CDSConfiguracao.FieldByName('PESQUISA_PARTE').AsString := copy(trim(cmbPesquisaSQL.Text),1,1);
end;

procedure TFConfiguracao.confirma;
begin
  try
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
  except
    Application.MessageBox('Erro ao salvar modificações.', 'Informação do Sistema', MB_OK + MB_ICONERROR);
    Abort;
  end;
end;

procedure TFConfiguracao.EditClick(Sender: TObject);
begin
  (Sender as TEdit).SelectAll;
end;

procedure TFConfiguracao.editTimeOutKeyPress(Sender: TObject; var Key: Char);
begin
  if not CharInSet(Key,['0'..'9',#8,#13]) then
    key:=#0;
end;

procedure TFConfiguracao.FormActivate(Sender: TObject);
begin
  //Color := StringToColor(Configuracao.CorJanelasInternas);
end;

procedure TFConfiguracao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Assigned(CDS) then
    FreeAndNil(CDS);
  cdsNFe.Close;
  Action := caFree;
end;

procedure TFConfiguracao.FormCreate(Sender: TObject);
begin
  FConfiguracao.Caption := 'Configurações do Sistema  -  Versão: '+VersaoExe(Application.ExeName,'V');
  PodeLogar := false;
  Application.CreateForm(TFSplash,FSplash);
  Application.CreateForm(TFDataModule, FDataModule);
  Application.CreateForm(TFLogin, FLogin);
  FLogin.ShowModal;

  if PodeLogar = false then
  begin
    Application.Terminate;
  end
  else
  begin
    try
    FSplash.Show;
    FSplash.BringToFront;


    PegaConfiguracao;

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
//    CDSPosicaoComponentes.IndexFieldNames := 'ID_ECF_RESOLUCAO';


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

    try
      ConfiguraACBr;
    except
    end;
    PegaNFEConfiguracao;
    CarregaArquivoAuxiliar;
    finally
    FreeAndNil(FSplash);
    FConfiguracao.Show;
    end;
  end;
end;

procedure TFConfiguracao.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key = 123 then
    confirma;
end;

procedure TFConfiguracao.FormShow(Sender: TObject);
begin
  PageControl1.ActivePageIndex:=0;
  CarregaEditsConfiguracaoBalanca;
  CarregaEditsParametrosDiversos;
end;

procedure TFConfiguracao.JvBitBtn1Click(Sender: TObject);
begin
  Application.CreateForm(TFUsuario, FUsuario);
  FUsuario.ShowModal;
end;

procedure TFConfiguracao.JvBitBtn2Click(Sender: TObject);
begin
  CarregaArquivoAuxiliar;
  editValor.Clear;
  editMD5.Clear;
end;

procedure TFConfiguracao.JvBitBtn3Click(Sender: TObject);
var
  ini: TIniFile;
  I,X : integer;
  Serie : Boolean;
  Serial : string;

begin
 try
    try
      if Application.MessageBox('Tem certeza que deseja salvar estes dados no ArquivoAuxiliar.ini?' + #13 +
        'Os dados antigos do arquivo serão perdidos.', 'Informação do Sistema', MB_YESNO + MB_ICONQUESTION) = mryes then
      begin
        // dados arquivo auxiliar
        ini := TIniFile.Create(ExtractFilePath(Application.ExeName)+'ArquivoAuxiliar.ini');
        ini.WriteString('ECF','GT',Codifica('C',trim(GTECF.Text)));
        Serie := False;

        for I := 0 to MemoSerieEcf.Lines.Count - 1 do
        begin
          if (trim(MemoSerieEcf.Lines.Strings[I])) =  (trim(SerieECF.Text)) then
            Serie := True;
        end;

        if not Serie  then
        begin
          MemoSerieEcf.Lines.Add(trim(SerieECF.Text));
        end;

        X := 0;
        for I := 0 to MemoSerieEcf.Lines.Count - 1 do
        begin
          if trim(MemoSerieEcf.Lines.Strings[I]) <> '' then
          begin
            Inc(X);
            Serial := 'SERIE'+IntToStr(I+1);
            ini.WriteString('ECF',pchar(Serial), Codifica('C', trim(MemoSerieEcf.Lines.Strings[I])));
          end;
          Application.ProcessMessages;
        end;

        editQuantidade.Text:= IntToStr(X);

        ini.WriteString('MD5','ARQUIVOS',Codifica('C',trim(editArquivos.Text)));
        ini.WriteString('ESTABELECIMENTO','CNPJ',Codifica('C',trim(editCNPJEstabelecimento.Text)));
        ini.WriteString('ESTABELECIMENTO','REGISTRAPREVENDA',Codifica('C',trim(editRegistraPreVenda.Text)));
        ini.WriteString('ESTABELECIMENTO','IMPRIMEDAV',Codifica('C',trim(editImprimeDAV.Text)));
        ini.WriteString('SHOUSE','CNPJ',Codifica('C',trim(editCNPJ.Text)));
        ini.WriteString('SHOUSE','NOME_PAF',Codifica('C',trim(editNome_PAF.Text)));
        ini.WriteString('SHOUSE','MD5PrincipalEXE',Codifica('C',trim(editMD5PrincipalEXE.Text)));
        ini.WriteString('SGBD','BD',editBD.Text);
        ini.WriteString('SGBD','BDBalcao',editBDBalcao.Text);
        ini.WriteString('IMPORTA','REMOTEAPP',editImporta.Text);
        ini.WriteString('ECFS','QUANTIDADE',IntToStr(X));
        ini.WriteString('ECFS','EMPRESA',editEmpesa.Text);
        //******************************************************
        ini.WriteString('FUNCIONALIDADES','FUN1',Codifica('C',trim(cmbFun1.Text)));
        ini.WriteString('FUNCIONALIDADES','FUN2',Codifica('C',trim(cmbFun2.Text)));
        ini.WriteString('FUNCIONALIDADES','FUN3',Codifica('C',trim(cmbFun3.Text)));

        ini.WriteString('PARAMETROSPARANAOCONCOMITANCIA','PAR1',Codifica('C',trim(cmbPar1.Text)));
        ini.WriteString('PARAMETROSPARANAOCONCOMITANCIA','PAR2',Codifica('C',trim(cmbPar2.Text)));
        ini.WriteString('PARAMETROSPARANAOCONCOMITANCIA','PAR3',Codifica('C',trim(cmbPar3.Text)));
        ini.WriteString('PARAMETROSPARANAOCONCOMITANCIA','PAR4',Codifica('C',trim(cmbPar4.Text)));

        ini.WriteString('APLICATIVOSESPECIAIS','APL1',Codifica('C',trim(cmbApl1.Text)));
        ini.WriteString('APLICATIVOSESPECIAIS','APL2',Codifica('C',trim(cmbApl2.Text)));
        ini.WriteString('APLICATIVOSESPECIAIS','APL3',Codifica('C',trim(cmbApl3.Text)));
        ini.WriteString('APLICATIVOSESPECIAIS','APL4',Codifica('C',trim(cmbApl4.Text)));
        ini.WriteString('APLICATIVOSESPECIAIS','APL5',Codifica('C',trim(cmbApl5.Text)));
        ini.WriteString('APLICATIVOSESPECIAIS','APL6',Codifica('C',trim(cmbApl6.Text)));
        ini.WriteString('APLICATIVOSESPECIAIS','APL7',Codifica('C',trim(cmbApl7.Text)));

        ini.WriteString('CRITERIOSPORUNIDADEFEDERADA','CRI1',Codifica('C',trim(cmbCri1.Text)));
        ini.WriteString('CRITERIOSPORUNIDADEFEDERADA','CRI2',Codifica('C',trim(cmbCri2.Text)));
        ini.WriteString('CRITERIOSPORUNIDADEFEDERADA','CRI3',Codifica('C',trim(cmbCri3.Text)));
        ini.WriteString('CRITERIOSPORUNIDADEFEDERADA','CRI4',Codifica('C',trim(cmbCri4.Text)));

        ini.WriteString('XXIIREQUISITO','XXII1',Codifica('C',trim(cmbXXII1.Text)));
        ini.WriteString('XXIIREQUISITO','XXII2',Codifica('C',trim(cmbXXII2.Text)));

        ini.WriteString('XXXVIREQUISITO','XXXVI1',Codifica('C',trim(cmbXXXVI1.Text)));





      end;
    except
      Application.MessageBox('Não foi possível carregar dados do ArquivoAuxiliar.ini.', 'Informação do Sistema', MB_OK + MB_ICONERROR);
    end;
  finally
    ini.Free;
  end;
end;

procedure TFConfiguracao.JvBitBtn4Click(Sender: TObject);
begin
  try
    FDataModule.ACBrECF.Desativar;
    SinalVerde.Visible := false;
    SinalVermelho.Visible := true;
  except
  end;
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


procedure TFConfiguracao.SalvaNFEConfiguracao;
begin
   if cdsNFe.RecordCount > 0 then
      cdsNFe.Edit
   else
      cdsNFe.Append;
      cdsNFeCERTIFICADO_DIGITAL.AsString  := edtNumSerie.Text;
      cdsNFeCAMINHO_CERTIFICADO.AsString  := edtCaminho.Text;
      cdsNFeSENHA_CERTIFICADO.AsString  := edtSenha.Text;
      cdsNFeFORMATO_IMPRESSAO_DANFE.AsString := inttostr(rgTipoDanfe.ItemIndex + 1);
      cdsNFeLOGOMARCA.AsString := edtLogoMarca.Text;

      if cbSalvar.Checked then
         cdsNFeSALVA_XML.AsString := 'S'
      else
         cdsNFeSALVA_XML.AsString := 'N';

      if cbPrintUser.Checked then
         cdsNFeIMPRIMIR_USUARIO_RODAPE.AsString := 'S'
      else
         cdsNFeIMPRIMIR_USUARIO_RODAPE.AsString := 'N';

      cdsNFeCAMINHO_SALVAR_XML.AsString := edtPathLogs.Text;

      cdsNFeFONTE_ATT.AsInteger :=  strToInt(edtFonteAtt.Text);
      cdsNFeFONTE_OUTROS_CAMPOS.AsInteger :=  strToInt(edtOutrosCampos.Text) ;
      cdsNFeFONTE_RAZAO_SOCIAL.AsInteger :=  strToInt(edtFontRazao.Text) ;

      cdsNFeUF_WEBSERVICE.AsString := cbUF.Text;

      if rgTipoAmb.ItemIndex = 0 then
         cdsNFeAMBIENTE.AsString := '1'
      else
         cdsNFeAMBIENTE.AsString := '2';

      cdsNFePROXY_HOST.AsString := edtProxyHost.Text;
      cdsNFePROXY_PORTA.AsString := edtProxyPorta.Text;
      cdsNFePROXY_USER.AsString := edtProxyUser.Text ;
      cdsNFePROXY_SENHA.AsString := edtProxySenha.Text ;

      cdsNFeNOME_HOST.AsString := edtSmtpHost.Text;
      cdsNFePORTA.AsString := edtSmtpPort.Text;
      cdsNFeUSUARIO.AsString := edtSmtpUser.Text;
      cdsNFeSENHA.AsString := edtSmtpPass.Text;
      cdsNFeASSUNTO.AsString := edtEmailAssunto.Text;
      cdsNFeTEXTO_EMAIL.AsString := mmEmailMsg.Text;


      if cbEmailSSL.Checked then
         cdsNFeAUTENTICA_SSL.AsString := 'S'
      else
         cdsNFeAUTENTICA_SSL.AsString := 'N';

      cdsNFe.Post;
      cdsNFe.ApplyUpdates(-1);
end;

procedure TFConfiguracao.sbtnCaminhoCertClick(Sender: TObject);
begin
  oArquivos.Title := 'Selecione o Certificado';
  oArquivos.DefaultExt := '*.pfx';
  oArquivos.Filter := 'Arquivos PFX (*.pfx)|*.pfx|Todos os Arquivos (*.*)|*.*';
  oArquivos.InitialDir := ExtractFileDir(application.ExeName);
  if oArquivos.Execute then
  begin
    edtCaminho.Text := oArquivos.FileName;
  end;
end;

procedure TFConfiguracao.sbtnGetCertClick(Sender: TObject);
begin
   {$IFNDEF ACBrNFeOpenSSL}
     edtNumSerie.Text := nfeFiscal.Configuracoes.Certificados.SelecionarCertificado;
   {$ENDIF}
end;

procedure TFConfiguracao.sbtnLogoMarcaClick(Sender: TObject);
begin
  oArquivos.Title := 'Selecione o Logo';
  oArquivos.DefaultExt := '*.bmp';
  oArquivos.Filter := 'Arquivos BMP (*.bmp)|*.bmp|Todos os Arquivos (*.*)|*.*';
  oArquivos.InitialDir := ExtractFileDir(application.ExeName);
  if oArquivos.Execute then
  begin
    edtLogoMarca.Text := oArquivos.FileName;
  end;
end;

procedure TFConfiguracao.sbtnPathSalvarClick(Sender: TObject);
var
  Dir: string;
begin
  if Length(edtPathLogs.Text) <= 0 then
     Dir := ExtractFileDir(application.ExeName)
  else
     Dir := edtPathLogs.Text;

  if SelectDirectory(Dir, [sdAllowCreate, sdPerformCreate, sdPrompt], SELDIRHELP) then
    edtPathLogs.Text := Dir;
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

procedure TFConfiguracao.btnCarregaFormasPgtoClick(Sender: TObject);
var
  i: integer;
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

procedure TFConfiguracao.btnReconectaImpressoraClick(Sender: TObject);
begin
  confirma;
  Application.CreateForm(TFSplash,FSplash);
  FSplash.Show;
  FSplash.BringToFront;
  PegaConfiguracao;
  FDataModule.ACBrECF.Desativar;
  try
    ConfiguraACBr;
  except
  end;
  FreeAndNil(FSplash);
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
  i: integer;
begin
  try
    CDS.Close;
    CDS.CreateDataSet;
    CDS.DisableControls;
    //Bematech e NaoFiscal permitem cadastrar formas de Pagamento dinamicamente a sweda tambem
    if (FDataModule.ACBrECF.Modelo in [ecfBematech, ecfNaoFiscal, ecfSweda])then
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
  vDescricao: string;
  vBoolean: Boolean;

begin

 try
  if MessageDlg('Esta operação grava formas de pagamento no ECF'+
                ' e não é possível reverter este processo'+sLineBreak+
                'Deseja continuar?',mtWarning,mbYesNo,0) = mrNo then exit;

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
//      FDataModule.ACBrECF.ProgramaFormaPagamento(vDescricao,vBoolean);
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

// contribuicao marco chagas costa 08/2011
procedure TFConfiguracao.CarregaArquivoAuxiliar;
var
  ini: TIniFile;
  I, Qtde:integer;

begin
  try
    try
      // dados arquivo auxiliar
      ini := TIniFile.Create(ExtractFilePath(Application.ExeName)+'ArquivoAuxiliar.ini');
      MemoSerieEcf.Text:='';
    //  editQuantidade.Text := ini.ReadString('ECFS','QUANTIDADE','');

      ini.ReadSectionValues('ECF',MemoSerieEcf.Lines);

      qtde := (MemoSerieEcf.Lines.Count -1);  //(Const Seção:String; ListaEntradas: TStrings);
      MemoSerieEcf.Text:='';
      for I := 1 to qtde do
      begin
        if trim(ini.ReadString('ECF','SERIE'+IntToStr(I),'')) <> '' then
          MemoSerieEcf.Lines.Add(Codifica('D',trim(ini.ReadString('ECF','SERIE'+IntToStr(I),''))));
      end;

      {for I := 1 to (StrToIntDef(editQuantidade.Text,0)) do
      begin
        if trim(ini.ReadString('ECF','SERIE'+IntToStr(I),'')) <> '' then
          MemoSerieEcf.Lines.Add(Codifica('D',trim(ini.ReadString('ECF','SERIE'+IntToStr(I),''))));
      end; }

      editQuantidade.Text := ini.ReadString('ECFS','QUANTIDADE','');

      editGT.Text :=  Codifica('D',trim(ini.ReadString('ECF','GT','')));
      editArquivos.Text := Codifica('D',trim(ini.ReadString('MD5','ARQUIVOS','')));
      editCNPJEstabelecimento.Text :=  Codifica('D',trim(ini.ReadString('ESTABELECIMENTO','CNPJ','')));
      editRegistraPreVenda.Text :=  Codifica('D',trim(ini.ReadString('ESTABELECIMENTO','REGISTRAPREVENDA','')));
      editImprimeDAV.Text :=  Codifica('D',trim(ini.ReadString('ESTABELECIMENTO','IMPRIMEDAV','')));
      editCNPJ.Text :=  Codifica('D',trim(ini.ReadString('SHOUSE','CNPJ','')));
      editNome_PAF.Text :=  Codifica('D',trim(ini.ReadString('SHOUSE','NOME_PAF','')));
      editMD5PrincipalEXE.Text :=  Codifica('D',trim(ini.ReadString('SHOUSE','MD5PrincipalEXE','')));
      editBD.Text :=  ini.ReadString('SGBD','BD','');
      editBDBalcao.Text :=  ini.ReadString('SGBD','BDBalcao','');
      editImporta.Text :=  ini.ReadString('IMPORTA','REMOTEAPP','');
      editEmpesa.Text :=  ini.ReadString('ECFS','EMPRESA','');

      //*******************************************************************************************

      cmbFun1.Text := (Codifica('D',trim(ini.ReadString('FUNCIONALIDADES','FUN1',''))));
      cmbFun2.Text := (Codifica('D',trim(ini.ReadString('FUNCIONALIDADES','FUN2',''))));
      cmbFun3.Text := (Codifica('D',trim(ini.ReadString('FUNCIONALIDADES','FUN3',''))));

      cmbPar1.Text := (Codifica('D',trim(ini.ReadString('PARAMETROSPARANAOCONCOMITANCIA','PAR1',''))));
      cmbPar2.Text := (Codifica('D',trim(ini.ReadString('PARAMETROSPARANAOCONCOMITANCIA','PAR2',''))));
      cmbPar3.Text := (Codifica('D',trim(ini.ReadString('PARAMETROSPARANAOCONCOMITANCIA','PAR3',''))));
      cmbPar4.Text := (Codifica('D',trim(ini.ReadString('PARAMETROSPARANAOCONCOMITANCIA','PAR4',''))));

      cmbApl1.Text := (Codifica('D',trim(ini.ReadString('APLICATIVOSESPECIAIS','APL1',''))));
      cmbApl2.Text := (Codifica('D',trim(ini.ReadString('APLICATIVOSESPECIAIS','APL2',''))));
      cmbApl3.Text := (Codifica('D',trim(ini.ReadString('APLICATIVOSESPECIAIS','APL3',''))));
      cmbApl4.Text := (Codifica('D',trim(ini.ReadString('APLICATIVOSESPECIAIS','APL4',''))));
      cmbApl5.Text := (Codifica('D',trim(ini.ReadString('APLICATIVOSESPECIAIS','APL5',''))));
      cmbApl6.Text := (Codifica('D',trim(ini.ReadString('APLICATIVOSESPECIAIS','APL6',''))));
      cmbApl7.Text := (Codifica('D',trim(ini.ReadString('APLICATIVOSESPECIAIS','APL7',''))));

      cmbCri1.Text := (Codifica('D',trim(ini.ReadString('CRITERIOSPORUNIDADEFEDERADA','CRI1',''))));
      cmbCri2.Text := (Codifica('D',trim(ini.ReadString('CRITERIOSPORUNIDADEFEDERADA','CRI2',''))));
      cmbCri3.Text := (Codifica('D',trim(ini.ReadString('CRITERIOSPORUNIDADEFEDERADA','CRI3',''))));
      cmbCri4.Text := (Codifica('D',trim(ini.ReadString('CRITERIOSPORUNIDADEFEDERADA','CRI4',''))));

      cmbXXII1.Text := (Codifica('D',trim(ini.ReadString('XXIIREQUISITO','XXII1',''))));
      cmbXXII2.Text := (Codifica('D',trim(ini.ReadString('XXIIREQUISITO','XXII2',''))));

      cmbXXXVI1.Text := (Codifica('D',trim(ini.ReadString('XXXVIREQUISITO','XXXVI1',''))));

      // Dadso ECF
      if FDataModule.ACBrECF.Ativo then
      begin
        SerieECF.Text := FDataModule.ACBrECF.NumSerie;
        GTECF.Text := FloatToStr(FDataModule.ACBrECF.GrandeTotal);
      end;
    except
      Application.MessageBox('Não foi possível carregar dados do ArquivoAuxiliar.ini.', 'Informação do Sistema', MB_OK + MB_ICONERROR);
    end;
  finally
    ini.Free;
  end;
end;

procedure TFConfiguracao.geraMD5Click(Sender: TObject);
begin
  editMD5.Text := MD5String(editValor.Text);
end;

procedure TFConfiguracao.GroupBox10Click(Sender: TObject);
begin

end;

// como este form não tem um padrão definido fiz outro padrão...
procedure TFConfiguracao.PreparaConfiguracaoBalancaParaGravacao;   // Modificar
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
                                                IntToStr(cmbSufixoLeitorSerial.ItemIndex)+'|';
end;

procedure TFConfiguracao.CarregaEditsConfiguracaoBalanca;    // Modificar
var
  Linha:string;
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
  Linha:string;
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

end;

procedure TFConfiguracao.ConfiguraACBr;
begin
  FDataModule.ACBrECF.Modelo := TACBrECFModelo(GetEnumValue(TypeInfo(TACBrECFModelo), Configuracao.ModeloImpressora));
  FDataModule.ACBrECF.Porta := Configuracao.PortaECF;
  FDataModule.ACBrECF.TimeOut := Configuracao.TimeOutECF;
  FDataModule.ACBrECF.IntervaloAposComando := Configuracao.IntervaloECF;
  FDataModule.ACBrECF.Device.Baud := Configuracao.BitsPorSegundo;
  try
    FSplash.lbMensagem.caption := 'Conectando ao ECF...';
    FSplash.lbMensagem.Refresh;
    FDataModule.ACBrECF.Ativar;
    FSplash.lbMensagem.caption := 'ECF conectado!';
    FSplash.lbMensagem.Refresh;
    FSplash.imgECF.Visible := True;
    FSplash.imgTEF.Visible := True;
    SinalVerde.Visible := true;
    SinalVermelho.Visible := false;
  except
    FSplash.lbMensagem.caption := 'Falha ao tentar conectar ECF!';
    FSplash.lbMensagem.Refresh;
    Application.MessageBox('ECF com problemas ou desligado. Configurações diretas com o ECF não funcionarão.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
    SinalVerde.Visible := false;
    SinalVermelho.Visible := true;
  end;
  FDataModule.ACBrECF.CarregaAliquotas;
  if FDataModule.ACBrECF.Aliquotas.Count <= 0 then
  begin
    Application.MessageBox('ECF sem alíquotas cadastradas. Aplicação será aberta para somente consulta.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
//    StatusCaixa := 3;
  end;
  FDataModule.ACBrECF.CarregaFormasPagamento;

  if FDataModule.ACBrECF.FormasPagamento.Count <= 0 then
  begin
    Application.MessageBox('ECF sem formas de pagamento cadastradas. Aplicação será aberta para somente consulta.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
//    StatusCaixa := 3;
  end;
end;

procedure TFConfiguracao.PegaConfiguracao;
var
  Linha:string;
begin
  Configuracao := TConfiguracaoController.PegaConfiguracao;
  //******* ConfiguracaoBalanca **********************************************************
  Linha:=Configuracao.ConfiguracaoBalanca;

  Configuracao.BalancaModelo := StrToIntDef(DevolveConteudoDelimitado('|',Linha),0);
  Configuracao.BalancaIdentificadorBalanca := DevolveConteudoDelimitado('|',Linha);
  Configuracao.BalancaHandShaking := StrToIntDef(DevolveConteudoDelimitado('|',Linha),0);
  Configuracao.BalancaParity := StrToIntDef(DevolveConteudoDelimitado('|',Linha),0);
  Configuracao.BalancaStopBits := StrToIntDef(DevolveConteudoDelimitado('|',Linha),0);
  Configuracao.BalancaDataBits := StrToIntDef(DevolveConteudoDelimitado('|',Linha),0);
  Configuracao.BalancaBaudRate := StrToIntDef(DevolveConteudoDelimitado('|',Linha),0);
  Configuracao.BalancaPortaSerial := DevolveConteudoDelimitado('|',Linha);
  Configuracao.BalancaTimeOut := StrToIntDef(DevolveConteudoDelimitado('|',Linha),0);
  Configuracao.BalancaTipoConfiguracaoBalanca := DevolveConteudoDelimitado('|',Linha);
  //*******  Fim ConfiguracaoBalanca ****************************************************

  //******* ParametrosDiversos **********************************************************
  Linha:=Configuracao.ParametrosDiversos;

  Configuracao.PedeCPFCupom := StrToIntDef(DevolveConteudoDelimitado('|',Linha),0);
  Configuracao.UsaIntegracao := StrToIntDef(DevolveConteudoDelimitado('|',Linha),0);
  Configuracao.TimerIntegracao := StrToIntDef(DevolveConteudoDelimitado('|',Linha),8);
  Configuracao.GavetaDinheiro := StrToIntDef(DevolveConteudoDelimitado('|',Linha),0);
  Configuracao.SinalInvertido := StrToIntDef(DevolveConteudoDelimitado('|',Linha),0);
  Configuracao.QtdeMaximaParcelas := StrToIntDef(DevolveConteudoDelimitado('|',Linha),0);
  Configuracao.ImprimeParcelas := StrToIntDef(DevolveConteudoDelimitado('|',Linha),0);
  Configuracao.TecladoReduzido := StrToIntDef(DevolveConteudoDelimitado('|',Linha),0);
  //******* Fim ParametrosDiversos ******************************************************

  //******* Parametros do Leitor Serial ******************************************************
  Configuracao.UsaLeitorSerial := StrToIntDef(DevolveConteudoDelimitado('|',Linha),0);
  Configuracao.PortaLeitorSerial := DevolveConteudoDelimitado('|',Linha);
  Configuracao.BaudLeitorSerial := DevolveConteudoDelimitado('|',Linha);
  Configuracao.SufixoLeitorSerial := DevolveConteudoDelimitado('|',Linha);
  Configuracao.IntervaloLeitorSerial := DevolveConteudoDelimitado('|',Linha);
  Configuracao.DataLeitorSerial := DevolveConteudoDelimitado('|',Linha);
  Configuracao.ParidadeLeitorSerial := StrToIntDef(DevolveConteudoDelimitado('|',Linha),0);
  Configuracao.HardFlowLeitorSerial := StrToIntDef(DevolveConteudoDelimitado('|',Linha),0);
  Configuracao.SoftFlowLeitorSerial := StrToIntDef(DevolveConteudoDelimitado('|',Linha),0);
  Configuracao.HandShakeLeitorSerial := StrToIntDef(DevolveConteudoDelimitado('|',Linha),0);
  Configuracao.StopLeitorSerial := StrToIntDef(DevolveConteudoDelimitado('|',Linha),0);
  Configuracao.FilaLeitorSerial := StrToIntDef(DevolveConteudoDelimitado('|',Linha),0);
  Configuracao.ExcluiSufixoLeitorSerial := StrToIntDef(DevolveConteudoDelimitado('|',Linha),0);
  //******* fim Parametros do Leitor Serial ******************************************************
end;

procedure TFConfiguracao.PegaNFEConfiguracao;
begin
      cdsNFe.Close;
      cdsNFe.Open;
      {$IFDEF ACBrNFeOpenSSL}
         edtCaminho.Text  := cdsNFeCAMINHO_CERTIFICADO.AsString;
         edtSenha.Text    := cdsNFeSENHA_CERTIFICADO.AsString;
         edtNumSerie.Visible := False;
         sbtnGetCert.Visible := False;
      {$ELSE}
         edtNumSerie.Text := cdsNFeCERTIFICADO_DIGITAL.AsString;
         edtCaminho.Visible := False;
         edtSenha.Visible   := False;
         Label104.Visible   := False;
         Label103.Visible   := False;
         sbtnCaminhoCert.Visible := False;
      {$ENDIF}

      rgTipoDanfe.ItemIndex := StrToInt(cdsNFeFORMATO_IMPRESSAO_DANFE.AsString) - 1;
      edtLogoMarca.Text := cdsNFeLOGOMARCA.AsString;

      if   cdsNFeSALVA_XML.AsString = 'S' then
           cbSalvar.Checked := true
      else
           cbSalvar.Checked := false;

       if  cdsNFeIMPRIMIR_USUARIO_RODAPE.AsString = 'S' then
           cbPrintUser.Checked := true
      else
           cbPrintUser.Checked := false;

      edtPathLogs.Text := cdsNFeCAMINHO_SALVAR_XML.AsString;
      edtFonteAtt.value := cdsNFeFONTE_ATT.AsInteger;
      edtOutrosCampos.value := cdsNFeFONTE_OUTROS_CAMPOS.AsInteger;
      edtFontRazao.value := cdsNFeFONTE_RAZAO_SOCIAL.AsInteger;
      //cbUF.Text := cdsNFeUF_WEBSERVICE.AsString;
      cbUF.ItemIndex       := cbUF.Items.IndexOf(cdsNFeUF_WEBSERVICE.AsString);

      if cdsNFeAMBIENTE.AsString = '1' then
           rgTipoAmb.ItemIndex := 0
      else
           rgTipoAmb.ItemIndex := 1;

      edtProxyHost.Text  := cdsNFePROXY_HOST.AsString;
      edtProxyPorta.Text := cdsNFePROXY_PORTA.AsString;
      edtProxyUser.Text  := cdsNFePROXY_USER.AsString ;
      edtProxySenha.Text := cdsNFePROXY_SENHA.AsString ;

      edtSmtpHost.Text := cdsNFeNOME_HOST.AsString;
      edtSmtpPort.Text := cdsNFePORTA.AsString;
      edtSmtpUser.Text := cdsNFeUSUARIO.AsString;
      edtSmtpPass.Text := cdsNFeSENHA.AsString;
      edtEmailAssunto.Text := cdsNFeASSUNTO.AsString;
      mmEmailMsg.Text      := cdsNFeTEXTO_EMAIL.AsString;

      if cdsNFeAUTENTICA_SSL.AsString = 'S' then
         cbEmailSSL.Checked := true;

end;
end.