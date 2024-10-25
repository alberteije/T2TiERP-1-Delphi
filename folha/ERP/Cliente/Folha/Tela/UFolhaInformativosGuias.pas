{ *******************************************************************************
  Title: T2Ti ERP
  Description: Janela Informativos e Guias para a Folha de Pagamento

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
unit UFolhaInformativosGuias;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, Grids, DBGrids, StdCtrls, rpgraphicex, ExtCtrls,
  JvExDBGrids, JvDBGrid, JvDBUltimGrid, ActnList, RibbonSilverStyleActnCtrls,
  ActnMan, ToolWin, ActnCtrls, DBXJSON, ACBrPonto_AFD_Class, Mask, JvExMask,
  JvToolEdit, LabeledCtrls, ACBrPonto_AFDT_Class, ComCtrls, JvBaseEdits,
  ACBrFolha, SessaoUsuario;

type
  TFFolhaInformativosGuias = class(TForm)
    PanelCabecalho: TPanel;
    Bevel1: TBevel;
    Image1: TImage;
    Label2: TLabel;
    ActionToolBarPrincipal: TActionToolBar;
    ActionManagerLocal: TActionManager;
    ActionCancelar: TAction;
    ActionGerarSefip: TAction;
    ActionGerarCaged: TAction;
    ActionGerarFichaFinanceira: TAction;
    PageControlItens: TPageControl;
    tsInformativosMensais: TTabSheet;
    PanelInformativosMensais: TPanel;
    ActionSair: TAction;
    GroupBox1: TGroupBox;
    ComboBoxGfipCodigoRecolhimento: TLabeledComboBox;
    EditGfipCompetencia: TLabeledMaskEdit;
    GroupBox2: TGroupBox;
    ComboBoxCagedAlteracao: TLabeledComboBox;
    EditCagedCompetencia: TLabeledMaskEdit;
    ActionToolBarInformativosMensais: TActionToolBar;
    tsInformativosAnuais: TTabSheet;
    PanelInformativosAnuais: TPanel;
    GroupBox3: TGroupBox;
    ComboBoxFichaFinanceiraOrdem: TLabeledComboBox;
    EditFichaFinanceiraAnoBase: TLabeledMaskEdit;
    GroupBox4: TGroupBox;
    ActionToolBar1: TActionToolBar;
    ActionGerarComprovanteRendimentos: TAction;
    EditComprovanteRendimentosAnoBase: TLabeledMaskEdit;
    ComboBoxComprovanteRendimentosOrdem: TLabeledComboBox;
    GroupBox5: TGroupBox;
    EditRaisAnoBase: TLabeledMaskEdit;
    ComboBoxRaisTipoInformativo: TLabeledComboBox;
    ComboBoxRaisOrdem: TLabeledComboBox;
    ActionGerarRais: TAction;
    GroupBox6: TGroupBox;
    EditDirfAnoBase: TLabeledMaskEdit;
    ActionGerarDirf: TAction;
    tsInformativosEventuais: TTabSheet;
    PanelInformativosEventuais: TPanel;
    GroupBox7: TGroupBox;
    ComboBoxManadCentralizacaoEscrituracao: TLabeledComboBox;
    EditManadPeriodoDe: TLabeledMaskEdit;
    ActionToolBar2: TActionToolBar;
    EditManadPediodoA: TLabeledMaskEdit;
    ComboBoxManadFinalidadeArquivo: TLabeledComboBox;
    ActionGerarManad: TAction;
    tsGuias: TTabSheet;
    Panel1: TPanel;
    GroupBox8: TGroupBox;
    EditGpsCompetencia: TLabeledMaskEdit;
    ActionToolBar3: TActionToolBar;
    ActionGerarGps: TAction;
    ActionGerarIrrf: TAction;
    ActionGerarPis: TAction;
    GroupBox9: TGroupBox;
    EditGrrfPeriodoDe: TLabeledMaskEdit;
    EditGrrfPeriodoA: TLabeledMaskEdit;
    EditGrrfDataPagamento: TLabeledDateEdit;
    ActionGerarGrrf: TAction;
    GroupBox13: TGroupBox;
    EditGrcsuCompetencia: TLabeledMaskEdit;
    EditGrcsuMulta: TLabeledCalcEdit;
    EditGrcsuJuros: TLabeledCalcEdit;
    ActionGerarGrscu: TAction;
    ACBrFolha: TACBrFolha;
    CDSColaborador: TClientDataSet;
    CDSColaboradorID: TIntegerField;
    CDSColaboradorID_CONTABIL_CONTA: TIntegerField;
    CDSColaboradorID_SINDICATO: TIntegerField;
    CDSColaboradorID_TIPO_ADMISSAO: TIntegerField;
    CDSColaboradorID_SITUACAO_COLABORADOR: TIntegerField;
    CDSColaboradorID_PESSOA: TIntegerField;
    CDSColaboradorID_TIPO_COLABORADOR: TIntegerField;
    CDSColaboradorID_NIVEL_FORMACAO: TIntegerField;
    CDSColaboradorID_CARGO: TIntegerField;
    CDSColaboradorID_SETOR: TIntegerField;
    CDSColaboradorMATRICULA: TStringField;
    CDSColaboradorFOTO_34: TMemoField;
    CDSColaboradorDATA_CADASTRO: TDateField;
    CDSColaboradorDATA_ADMISSAO: TDateField;
    CDSColaboradorVENCIMENTO_FERIAS: TDateField;
    CDSColaboradorDATA_TRANSFERENCIA: TDateField;
    CDSColaboradorFGTS_OPTANTE: TStringField;
    CDSColaboradorFGTS_DATA_OPCAO: TDateField;
    CDSColaboradorFGTS_CONTA: TIntegerField;
    CDSColaboradorPAGAMENTO_FORMA: TStringField;
    CDSColaboradorPAGAMENTO_BANCO: TStringField;
    CDSColaboradorPAGAMENTO_AGENCIA: TStringField;
    CDSColaboradorPAGAMENTO_AGENCIA_DIGITO: TStringField;
    CDSColaboradorPAGAMENTO_CONTA: TStringField;
    CDSColaboradorPAGAMENTO_CONTA_DIGITO: TStringField;
    CDSColaboradorEXAME_MEDICO_ULTIMO: TDateField;
    CDSColaboradorEXAME_MEDICO_VENCIMENTO: TDateField;
    CDSColaboradorPIS_DATA_CADASTRO: TDateField;
    CDSColaboradorPIS_NUMERO: TStringField;
    CDSColaboradorPIS_BANCO: TStringField;
    CDSColaboradorPIS_AGENCIA: TStringField;
    CDSColaboradorPIS_AGENCIA_DIGITO: TStringField;
    CDSColaboradorCTPS_NUMERO: TStringField;
    CDSColaboradorCTPS_SERIE: TStringField;
    CDSColaboradorCTPS_DATA_EXPEDICAO: TDateField;
    CDSColaboradorCTPS_UF: TStringField;
    CDSColaboradorDESCONTO_PLANO_SAUDE: TStringField;
    CDSColaboradorSAI_NA_RAIS: TStringField;
    CDSColaboradorCATEGORIA_SEFIP: TStringField;
    CDSColaboradorOBSERVACAO: TMemoField;
    CDSColaboradorOCORRENCIA_SEFIP: TIntegerField;
    CDSColaboradorCODIGO_ADMISSAO_CAGED: TIntegerField;
    CDSColaboradorCODIGO_DEMISSAO_CAGED: TIntegerField;
    CDSColaboradorCODIGO_DEMISSAO_SEFIP: TIntegerField;
    CDSColaboradorDATA_DEMISSAO: TDateField;
    CDSColaboradorCODIGO_TURMA_PONTO: TStringField;
    CDSColaboradorLOGRADOURO: TStringField;
    CDSColaboradorNUMERO: TStringField;
    CDSColaboradorCOMPLEMENTO: TStringField;
    CDSColaboradorBAIRRO: TStringField;
    CDSColaboradorCIDADE: TStringField;
    CDSColaboradorCEP: TStringField;
    CDSColaboradorMUNICIPIO_IBGE: TIntegerField;
    CDSColaboradorUF: TStringField;
    CDSColaboradorFONE: TStringField;
    CDSColaboradorFAX: TStringField;
    CDSColaboradorNOME: TStringField;
    CDSColaboradorTIPO: TStringField;
    CDSColaboradorEMAIL: TStringField;
    CDSColaboradorSITE: TStringField;
    CDSColaboradorCPF_CNPJ: TStringField;
    CDSColaboradorRG_IE: TStringField;
    GroupBox12: TGroupBox;
    EditValorMulta: TLabeledCalcEdit;
    EditValorJuros: TLabeledCalcEdit;
    EditDataVencimento: TLabeledDateEdit;
    EditPeriodoApuracao: TLabeledDateEdit;
    EditCodigoReceita: TLabeledMaskEdit;
    EditNumeroReferencia: TLabeledMaskEdit;
    EditValorPrincipal: TLabeledCalcEdit;
    EditValorTotal: TLabeledCalcEdit;
    EditGpsCodigoPagamento: TLabeledMaskEdit;
    EditGpsIdentificador: TLabeledMaskEdit;
    EditGpsValorInss: TLabeledCalcEdit;
    EditGpsValorOutrasEntidades: TLabeledCalcEdit;
    EditGpsValorJuros: TLabeledCalcEdit;
    EditGpsValorTotal: TLabeledCalcEdit;
    procedure ActionCancelarExecute(Sender: TObject);
    procedure ActionSairExecute(Sender: TObject);
    procedure ActionGerarSefipExecute(Sender: TObject);
    procedure ActionGerarCagedExecute(Sender: TObject);
    procedure ActionGerarFichaFinanceiraExecute(Sender: TObject);
    procedure ActionGerarComprovanteRendimentosExecute(Sender: TObject);
    procedure ActionGerarRaisExecute(Sender: TObject);
    procedure ActionGerarDirfExecute(Sender: TObject);
    procedure ActionGerarManadExecute(Sender: TObject);
    procedure ActionGerarGpsExecute(Sender: TObject);
    procedure ActionGerarIrrfExecute(Sender: TObject);
    procedure ActionGerarPisExecute(Sender: TObject);
    procedure ActionGerarGrrfExecute(Sender: TObject);
    procedure ActionGerarGrfcExecute(Sender: TObject);
    procedure ActionGerarGrscuExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure EmiteDarf;

    class function Sessao: TSessaoUsuario;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FFolhaInformativosGuias: TFFolhaInformativosGuias;

implementation

uses
  UDataModule, EnderecoVO, ViewPessoaColaboradorController, ViewPessoaColaboradorVO,
  UPreview;
{$R *.dfm}

class function TFFolhaInformativosGuias.Sessao: TSessaoUsuario;
begin
  Result := TSessaoUsuario.Instance;
end;

procedure TFFolhaInformativosGuias.ActionCancelarExecute(Sender: TObject);
begin
  Close;
end;

procedure TFFolhaInformativosGuias.ActionSairExecute(Sender: TObject);
begin
  Close;
end;

procedure TFFolhaInformativosGuias.FormShow(Sender: TObject);
begin
  EditGfipCompetencia.Clear;
  EditCagedCompetencia.Clear;
  EditFichaFinanceiraAnoBase.Clear;
  EditComprovanteRendimentosAnoBase.Clear;
  EditRaisAnoBase.Clear;
  EditDirfAnoBase.Clear;
  EditManadPeriodoDe.Clear;
  EditManadPediodoA.Clear;
  EditGpsCompetencia.Clear;
  EditGrrfPeriodoDe.Clear;
  EditGrrfPeriodoA.Clear;
  EditGrcsuCompetencia.Clear;
end;

procedure TFFolhaInformativosGuias.ActionGerarSefipExecute(Sender: TObject);
begin
  ACBrFolha.Path := ExtractFilePath(Application.ExeName);
  ACBrFolha.Folha_Sefip.LimpaRegistros;

  // REGISTRO TIPO 00 � Informa��es do Respons�vel (Header do arquivo)
  ACBrFolha.Folha_Sefip.RegistroTipo00.TipoRemessa := '1'; //1=GFIP
  ACBrFolha.Folha_Sefip.RegistroTipo00.TipoInscricaoResponsavel := '1'; //1=CNPJ
  ACBrFolha.Folha_Sefip.RegistroTipo00.InscricaoResponsavel := Sessao.Empresa.Cnpj;
  ACBrFolha.Folha_Sefip.RegistroTipo00.NomeResponsavel := Sessao.Empresa.RazaoSocial;
  ACBrFolha.Folha_Sefip.RegistroTipo00.NomePessoaContato := Sessao.Empresa.RazaoSocial;
  ACBrFolha.Folha_Sefip.RegistroTipo00.Logradouro := TEnderecoVO(Sessao.Empresa.ListaEnderecoVO[0]).Logradouro;
  ACBrFolha.Folha_Sefip.RegistroTipo00.Bairro := TEnderecoVO(Sessao.Empresa.ListaEnderecoVO[0]).Bairro;
  ACBrFolha.Folha_Sefip.RegistroTipo00.Cep := TEnderecoVO(Sessao.Empresa.ListaEnderecoVO[0]).Cep;
  ACBrFolha.Folha_Sefip.RegistroTipo00.Cidade := TEnderecoVO(Sessao.Empresa.ListaEnderecoVO[0]).Cidade;
  ACBrFolha.Folha_Sefip.RegistroTipo00.UnidadeFederacao := TEnderecoVO(Sessao.Empresa.ListaEnderecoVO[0]).Uf;
  ACBrFolha.Folha_Sefip.RegistroTipo00.TelefoneContato := TEnderecoVO(Sessao.Empresa.ListaEnderecoVO[0]).Fone;
  ACBrFolha.Folha_Sefip.RegistroTipo00.EnderecoInternetContato := Sessao.Empresa.Email;
  ACBrFolha.Folha_Sefip.RegistroTipo00.Competencia := Copy(EditGfipCompetencia.Text, 4, 4) + Copy(EditGfipCompetencia.Text, 1, 2);
  ACBrFolha.Folha_Sefip.RegistroTipo00.CodigoRecolhimento := Copy(ComboBoxGfipCodigoRecolhimento.Text, 1, 3);
  ACBrFolha.Folha_Sefip.RegistroTipo00.IndicadorRecolhimentoFGTS := '1'; //1 (GRF no prazo)
  ACBrFolha.Folha_Sefip.RegistroTipo00.ModalidadeArquivo := '1'; //1 - Declara��o ao FGTS e � Previd�ncia
  ACBrFolha.Folha_Sefip.RegistroTipo00.TipoInscricaoFornecedorFolhaPagamento := '1'; //1=CNPJ
  ACBrFolha.Folha_Sefip.RegistroTipo00.DataRecolhimentoFGTS := Now;
  ACBrFolha.Folha_Sefip.RegistroTipo00.IndicadorRecolhimentoPrevidenciaSocial := '1'; //1 (no prazo)
  ACBrFolha.Folha_Sefip.RegistroTipo00.DataRecolhimentoPrevidenciaSocial := Now;
  ACBrFolha.Folha_Sefip.RegistroTipo00.TipoInscricaoFornecedorFolhaPagamento := '1'; //1=CNPJ
  ACBrFolha.Folha_Sefip.RegistroTipo00.InscricaoFornecedorFolhaPagamento := Sessao.Empresa.Cnpj;

  //REGISTRO TIPO 10 � Informa��es da Empresa (Header da empresa )
  ACBrFolha.Folha_Sefip.RegistroTipo10.TipoInscricaoEmpresa := '1'; //1=CNPJ
  ACBrFolha.Folha_Sefip.RegistroTipo10.InscricaoEmpresa := Sessao.Empresa.Cnpj;
  ACBrFolha.Folha_Sefip.RegistroTipo10.NomeEmpresaRazaoSocial := Sessao.Empresa.RazaoSocial;
  ACBrFolha.Folha_Sefip.RegistroTipo10.Logradouro := TEnderecoVO(Sessao.Empresa.ListaEnderecoVO[0]).Logradouro;
  ACBrFolha.Folha_Sefip.RegistroTipo10.Bairro := TEnderecoVO(Sessao.Empresa.ListaEnderecoVO[0]).Bairro;
  ACBrFolha.Folha_Sefip.RegistroTipo10.Cep := TEnderecoVO(Sessao.Empresa.ListaEnderecoVO[0]).Cep;
  ACBrFolha.Folha_Sefip.RegistroTipo10.Cidade := TEnderecoVO(Sessao.Empresa.ListaEnderecoVO[0]).Cidade;
  ACBrFolha.Folha_Sefip.RegistroTipo10.UnidadeFederacao := TEnderecoVO(Sessao.Empresa.ListaEnderecoVO[0]).Uf;
  ACBrFolha.Folha_Sefip.RegistroTipo10.TelefoneContato := TEnderecoVO(Sessao.Empresa.ListaEnderecoVO[0]).Fone;
  ACBrFolha.Folha_Sefip.RegistroTipo10.IndicadorAlteracaoEndereco := 'N';
  ACBrFolha.Folha_Sefip.RegistroTipo10.CNAE:= Sessao.Empresa.CodigoCnaePrincipal;
  ACBrFolha.Folha_Sefip.RegistroTipo10.IndicadorAlteracaoCNAE := 'N';
  ACBrFolha.Folha_Sefip.RegistroTipo10.AliquotaRAT := '00'; //Ser� zeros para FPAS 604, 647, 825, 833 e 868 (empregador dom�stico) e para a empresa optante pelo SIMPLES.
  ACBrFolha.Folha_Sefip.RegistroTipo10.CodigoCentralizacao := '1'; //1 (centralizadora)
  ACBrFolha.Folha_Sefip.RegistroTipo10.SIMPLES := '2'; //2 � Optante;
  ACBrFolha.Folha_Sefip.RegistroTipo10.FPAS := Sessao.Empresa.DescricaoFpas;
  ACBrFolha.Folha_Sefip.RegistroTipo10.CodigoOutrasEntidades := IntToStr(Sessao.Empresa.CodigoTerceiros);
  ACBrFolha.Folha_Sefip.RegistroTipo10.CodigoPagamentoGPS := IntToStr(Sessao.Empresa.CodigoGps);

  //REGISTRO TIPO 12 � Informa��es Adicionais do Recolhimento da Empresa (Opcional)
  { Implementado a crit�rio do Participante do T2Ti ERP }

  //REGISTRO TIPO 13 � Altera��o Cadastral Trabalhador (Opcional)
  { Implementado a crit�rio do Participante do T2Ti ERP }

  //REGISTRO TIPO 14 � Inclus�o/Altera��o Endere�o do Trabalhador (Opcional)
  { Implementado a crit�rio do Participante do T2Ti ERP }

  //REGISTRO TIPO 20 � Registro do Tomador de Servi�o/Obra de Constru��o Civil (Opcional)
  { Implementado a crit�rio do Participante do T2Ti ERP }

  //REGISTRO TIPO 21 - Registro de informa��es adicionais do Tomador de Servi�o/Obra de Const. Civil (Opcional)
  { Implementado a crit�rio do Participante do T2Ti ERP }

  //REGISTRO TIPO 30 - Registro do Trabalhador
  TViewPessoaColaboradorController.SetDataSet(CDSColaborador);
  TViewPessoaColaboradorController.Consulta('ID>0', -1);

  CDSColaborador.First;
  while not CDSColaborador.Eof do
  begin
    with ACBrFolha.Folha_Sefip.RegistroTipo30.New do
    begin
      TipoInscricaoEmpresa := ACBrFolha.Folha_Sefip.RegistroTipo10.TipoInscricaoEmpresa;
      InscricaoEmpresa := ACBrFolha.Folha_Sefip.RegistroTipo10.InscricaoEmpresa;
      PISPASEPCI := CDSColaboradorPIS_NUMERO.AsString;
      DataAdmissao := CDSColaboradorDATA_ADMISSAO.AsDateTime;
      CategoriaTrabalhador := CDSColaboradorCATEGORIA_SEFIP.AsString;
      NomeTrabalhador := CDSColaboradorNOME.AsString;
      MatriculaEmpregado := CDSColaboradorMATRICULA.AsString;
      NumeroCTPS := CDSColaboradorCTPS_NUMERO.AsString;
      SerieCTPS := CDSColaboradorCTPS_SERIE.AsString;
      DataOpcao := CDSColaboradorFGTS_DATA_OPCAO.AsDateTime;
    end;
    CDSColaborador.Next;
  end;

  //REGISTRO TIPO 32 � Movimenta��o do Trabalhador (Opcional)
  { Implementado a crit�rio do Participante do T2Ti ERP }

  //REGISTRO TIPO 50� Empresa Com Recolhimento pelos c�digos 027, 046, 604 e 736 (Header da empresa ) (PARA IMPLEMENTA��O FUTURA)
  { Implementado a crit�rio do Participante do T2Ti ERP }

  //REGISTRO TIPO 51 - Registro de Individualiza��o de valores recolhidos pelos c�digos 027, 046, 604 e 736 (PARA IMPLEMENTA��O FUTURA)
  { Implementado a crit�rio do Participante do T2Ti ERP }

  //Gera arquivo
  ACBrFolha.SaveFileTXT_Sefip('SEFIP.RE');
  Application.CreateForm(TFPreview, FPreview);
  FPreview.RichEdit.Lines.LoadFromFile(ACBrFolha.Path + 'SEFIP.RE');
  FPreview.ShowModal;
end;

procedure TFFolhaInformativosGuias.ActionGerarCagedExecute(Sender: TObject);
begin
  ACBrFolha.Path := ExtractFilePath(Application.ExeName);
  ACBrFolha.Folha_Caged.LimpaRegistros;

  // REGISTRO A (AUTORIZADO)
  ACBrFolha.Folha_Caged.RegistroTipoA.Competencia := Copy(EditCagedCompetencia.Text, 1, 2) + Copy(EditCagedCompetencia.Text, 4, 4);
  ACBrFolha.Folha_Caged.RegistroTipoA.Alteracao := Copy(ComboBoxCagedAlteracao.Text, 1, 1);
  ACBrFolha.Folha_Caged.RegistroTipoA.TipoIdentificador := '1'; //CNPJ
  ACBrFolha.Folha_Caged.RegistroTipoA.NumeroIdentificadorDoAutorizado := Sessao.Empresa.Cnpj;
  ACBrFolha.Folha_Caged.RegistroTipoA.NomeRazaoSocialDoAutorizado := Sessao.Empresa.RazaoSocial;
  ACBrFolha.Folha_Caged.RegistroTipoA.Endereco := TEnderecoVO(Sessao.Empresa.ListaEnderecoVO[0]).Logradouro + ' ' + TEnderecoVO(Sessao.Empresa.ListaEnderecoVO[0]).Numero;
  ACBrFolha.Folha_Caged.RegistroTipoA.Cep := TEnderecoVO(Sessao.Empresa.ListaEnderecoVO[0]).Cep;
  ACBrFolha.Folha_Caged.RegistroTipoA.UF := TEnderecoVO(Sessao.Empresa.ListaEnderecoVO[0]).Uf;
  ACBrFolha.Folha_Caged.RegistroTipoA.Telefone := TEnderecoVO(Sessao.Empresa.ListaEnderecoVO[0]).Fone;

  // REGISTRO B (ESTABELECIMENTO)
  ACBrFolha.Folha_Caged.RegistroTipoB.TipoIdentificador := '1'; //CNPJ
  ACBrFolha.Folha_Caged.RegistroTipoB.NumeroIdentificadorDoEstabelecimento := Sessao.Empresa.Cnpj;
  ACBrFolha.Folha_Caged.RegistroTipoB.PrimeiraDeclaracao := '1';
  ACBrFolha.Folha_Caged.RegistroTipoB.Alteracao := Copy(ComboBoxCagedAlteracao.Text, 1, 1);
  ACBrFolha.Folha_Caged.RegistroTipoB.Cep := TEnderecoVO(Sessao.Empresa.ListaEnderecoVO[0]).Cep;
  ACBrFolha.Folha_Caged.RegistroTipoB.NomeRazaoSocialDoEstabelecimento := Sessao.Empresa.RazaoSocial;
  ACBrFolha.Folha_Caged.RegistroTipoB.Endereco := TEnderecoVO(Sessao.Empresa.ListaEnderecoVO[0]).Logradouro + ' ' + TEnderecoVO(Sessao.Empresa.ListaEnderecoVO[0]).Numero;
  ACBrFolha.Folha_Caged.RegistroTipoB.Bairro := TEnderecoVO(Sessao.Empresa.ListaEnderecoVO[0]).Bairro;
  ACBrFolha.Folha_Caged.RegistroTipoB.UF := TEnderecoVO(Sessao.Empresa.ListaEnderecoVO[0]).Uf;
  ACBrFolha.Folha_Caged.RegistroTipoB.TotalDeEmpregadosExistentesNoPrimeiroDia := '0';
  ACBrFolha.Folha_Caged.RegistroTipoB.PorteDoEstabelecimento := '1';
  ACBrFolha.Folha_Caged.RegistroTipoB.Cnae2ComSubClasse := Sessao.Empresa.CodigoCnaePrincipal;
  ACBrFolha.Folha_Caged.RegistroTipoB.Telefone := TEnderecoVO(Sessao.Empresa.ListaEnderecoVO[0]).Fone;
  ACBrFolha.Folha_Caged.RegistroTipoB.Email := Sessao.Empresa.Email;

  //REGISTRO C (MOVIMENTA��O)
  TViewPessoaColaboradorController.SetDataSet(CDSColaborador);
  TViewPessoaColaboradorController.Consulta('ID>0', -1);

  CDSColaborador.First;
  while not CDSColaborador.Eof do
  begin
    with ACBrFolha.Folha_Caged.RegistroTipoC.New do
    begin
      TipoIdentificador := '1';
      NumeroIdentificadorDoEstabelecimento := Sessao.Empresa.Cnpj;
      PisPasep := CDSColaboradorPIS_NUMERO.AsString;
      Admissao := CDSColaboradorDATA_ADMISSAO.AsDateTime;
      Cpf := CDSColaboradorCPF_CNPJ.AsString;
    end;
    CDSColaborador.Next;
  end;


    //REGISTRO X (ACERTO)
    { Implementado a crit�rio do Participante do T2Ti ERP }

  //Gera arquivo
  ACBrFolha.SaveFileTXT_Caged('CAGED.TXT');
  Application.CreateForm(TFPreview, FPreview);
  FPreview.RichEdit.Lines.LoadFromFile(ACBrFolha.Path + 'CAGED.TXT');
  FPreview.ShowModal;
end;

procedure TFFolhaInformativosGuias.ActionGerarFichaFinanceiraExecute(Sender: TObject);
begin
  Showmessage('Implementado a crit�rio do Participante do T2Ti ERP');
  { Relat�rio dos valores calculados para os colaboradores m�s a m�s dentro de determinado ano. }
  { Implementado a crit�rio do Participante do T2Ti ERP }
end;

procedure TFFolhaInformativosGuias.ActionGerarComprovanteRendimentosExecute(Sender: TObject);
begin
  Showmessage('Implementado a crit�rio do Participante do T2Ti ERP');
  { Relat�rio com todos os rendimentos de um determinado per�odo, por colaborador. }
  { Implementado a crit�rio do Participante do T2Ti ERP }
end;

procedure TFFolhaInformativosGuias.ActionGerarRaisExecute(Sender: TObject);
begin
  Showmessage('Aguardar levantamento de requisitos do segundo ciclo por conta do eSocial');
  { Aguardar levantamento de requisitos do segundo ciclo por conta do eSocial }
end;

procedure TFFolhaInformativosGuias.ActionGerarDirfExecute(Sender: TObject);
begin
  Showmessage('Aguardar levantamento de requisitos do segundo ciclo por conta do eSocial');
  { Aguardar levantamento de requisitos do segundo ciclo por conta do eSocial }
end;

procedure TFFolhaInformativosGuias.ActionGerarManadExecute(Sender: TObject);
begin
  Showmessage('Aguardar levantamento de requisitos do segundo ciclo por conta do eSocial');
  { Aguardar levantamento de requisitos do segundo ciclo por conta do eSocial }
end;

procedure TFFolhaInformativosGuias.ActionGerarGpsExecute(Sender: TObject);
var
  RemoteDataInfo: TStringList;
  ConsultaSQL, NomeArquivo: String;
  i: Integer;
begin
  try
    try
      NomeArquivo := 'GPS.rep';

      FDataModule.VCLReport.GetRemoteParams(Sessao.ServidorImpressao.Servidor, Sessao.ServidorImpressao.Porta, Sessao.ServidorImpressao.Usuario, Sessao.ServidorImpressao.Senha, Sessao.ServidorImpressao.Alias, NomeArquivo);
      FDataModule.VCLReport.Report.Params.ParamByName('CODIGOPAGAMENTO').Value := EditGpsCodigoPagamento.Text;
      FDataModule.VCLReport.Report.Params.ParamByName('COMPETENCIA').Value := EditGpsCompetencia.Text;
      FDataModule.VCLReport.Report.Params.ParamByName('IDENTIFICADOR').Value := EditGpsIdentificador.Text;
      FDataModule.VCLReport.Report.Params.ParamByName('VALORINSS').Value := EditGpsValorInss.Value;
      FDataModule.VCLReport.Report.Params.ParamByName('VALOROUTRASENTIDADES').Value := EditGpsValorOutrasEntidades.Value;
      FDataModule.VCLReport.Report.Params.ParamByName('VALORJURO').Value := EditGpsValorJuros.Value;
      FDataModule.VCLReport.Report.Params.ParamByName('VALORTOTAL').Value := EditGpsValorTotal.Value;
      //
      FDataModule.VCLReport.GetRemoteDataInfo(Sessao.ServidorImpressao.Servidor, Sessao.ServidorImpressao.Porta, Sessao.ServidorImpressao.Usuario, Sessao.ServidorImpressao.Senha, Sessao.ServidorImpressao.Alias, NomeArquivo);
      RemoteDataInfo := FDataModule.VCLReport.Report.RemoteDataInfo;
      //
      ConsultaSQL := '';

      FDataModule.VCLReport.ExecuteRemote(Sessao.ServidorImpressao.Servidor, Sessao.ServidorImpressao.Porta, Sessao.ServidorImpressao.Usuario, Sessao.ServidorImpressao.Senha, Sessao.ServidorImpressao.Alias, NomeArquivo, ConsultaSQL);
    except
      on E: Exception do
        Application.MessageBox(PChar('Ocorreu um erro na constru��o do relat�rio. Informe a mensagem ao Administrador do sistema.' + #13 + #13 + E.Message), 'Erro do sistema', MB_OK + MB_ICONERROR);
    end;
  finally
  end;
end;

procedure TFFolhaInformativosGuias.ActionGerarIrrfExecute(Sender: TObject);
begin
  EmiteDarf;
end;

procedure TFFolhaInformativosGuias.ActionGerarPisExecute(Sender: TObject);
begin
  EmiteDarf;
end;

procedure TFFolhaInformativosGuias.ActionGerarGrrfExecute(Sender: TObject);
begin
  Showmessage('Aguardar levantamento de requisitos do segundo ciclo por conta do eSocial');
  { Aguardar levantamento de requisitos do segundo ciclo por conta do eSocial }
end;

procedure TFFolhaInformativosGuias.ActionGerarGrfcExecute(Sender: TObject);
begin
  Showmessage('Aguardar levantamento de requisitos do segundo ciclo por conta do eSocial');
  { Aguardar levantamento de requisitos do segundo ciclo por conta do eSocial }
end;

procedure TFFolhaInformativosGuias.ActionGerarGrscuExecute(Sender: TObject);
begin
  Showmessage('Aguardar levantamento de requisitos do segundo ciclo por conta do eSocial');
  { Aguardar levantamento de requisitos do segundo ciclo por conta do eSocial }
end;

procedure TFFolhaInformativosGuias.EmiteDarf;
var
  RemoteDataInfo: TStringList;
  ConsultaSQL, NomeArquivo: String;
  i: Integer;
begin
  try
    try
      NomeArquivo := 'DARF.rep';

      FDataModule.VCLReport.GetRemoteParams(Sessao.ServidorImpressao.Servidor, Sessao.ServidorImpressao.Porta, Sessao.ServidorImpressao.Usuario, Sessao.ServidorImpressao.Senha, Sessao.ServidorImpressao.Alias, NomeArquivo);
      FDataModule.VCLReport.Report.Params.ParamByName('PERIODOAPURACAO').Value := EditPeriodoApuracao.Text;
      FDataModule.VCLReport.Report.Params.ParamByName('DATAVENCIMENTO').Value := EditDataVencimento.Text;
      FDataModule.VCLReport.Report.Params.ParamByName('CODIGORECEITA').Value := EditCodigoReceita.Text;
      FDataModule.VCLReport.Report.Params.ParamByName('NUMEROREFERENCIA').Value := EditNumeroReferencia.Text;
      FDataModule.VCLReport.Report.Params.ParamByName('VALORPRINCIPAL').Value := EditValorPrincipal.Value;
      FDataModule.VCLReport.Report.Params.ParamByName('VALORMULTA').Value := EditValorMulta.Value;
      FDataModule.VCLReport.Report.Params.ParamByName('VALORJURO').Value := EditValorJuros.Value;
      FDataModule.VCLReport.Report.Params.ParamByName('VALORTOTAL').Value := EditValorTotal.Value;
      //
      FDataModule.VCLReport.GetRemoteDataInfo(Sessao.ServidorImpressao.Servidor, Sessao.ServidorImpressao.Porta, Sessao.ServidorImpressao.Usuario, Sessao.ServidorImpressao.Senha, Sessao.ServidorImpressao.Alias, NomeArquivo);
      RemoteDataInfo := FDataModule.VCLReport.Report.RemoteDataInfo;
      //
      ConsultaSQL := '';

      FDataModule.VCLReport.ExecuteRemote(Sessao.ServidorImpressao.Servidor, Sessao.ServidorImpressao.Porta, Sessao.ServidorImpressao.Usuario, Sessao.ServidorImpressao.Senha, Sessao.ServidorImpressao.Alias, NomeArquivo, ConsultaSQL);
    except
      on E: Exception do
        Application.MessageBox(PChar('Ocorreu um erro na constru��o do relat�rio. Informe a mensagem ao Administrador do sistema.' + #13 + #13 + E.Message), 'Erro do sistema', MB_OK + MB_ICONERROR);
    end;
  finally
  end;
end;

end.
