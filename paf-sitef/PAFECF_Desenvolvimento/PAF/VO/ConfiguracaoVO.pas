{*******************************************************************************
Title: T2Ti ERP
Description: VO da configuraçao.

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

@author Albert Eije (T2Ti.COM)
@version 1.0
*******************************************************************************}
unit ConfiguracaoVO;

interface

uses
  ResolucaoVO;

type
  TConfiguracaoVO = class
  private
    FID: Integer;
    FID_ECF_IMPRESSORA: Integer;
    FID_ECF_RESOLUCAO: Integer;
    FID_ECF_CAIXA: Integer;
    FID_ECF_EMPRESA: Integer;
    FMENSAGEM_CUPOM: String;
    FPORTA_ECF: String;
    FIP_SERVIDOR: String;
    FIP_SITEF: String;
    FTIPO_TEF: String;
    FTITULO_TELA_CAIXA: String;
    FCAMINHO_IMAGEM_PRODUTOS: String;
    FCAMINHO_IMAGENS_MARKETING: String;
    FCAMINHO_IMAGENS_LAYOUT: String;
    FCOR_JANELAS_INTERNAS: String;
    FMARKETING_ATIVO: String;
    FCFOP_ECF: Integer;
    FCFOP_NF2: Integer;
    FTIMEOUT_ECF: Integer;
    FINTERVALO_ECF: Integer;
    FDESCRICAO_SUPRIMENTO: String;
    FDESCRICAO_SANGRIA: String;
    FTEF_TIPO_GP : Integer;
    FTEF_TEMPO_ESPERA : Integer;
    FTEF_ESPERA_STS : Integer;
    FTEF_NUMERO_VIAS : Integer;
    FDECIMAIS_QUANTIDADE: Integer;
    FDECIMAIS_VALOR: Integer;
    FBITS_POR_SEGUNDO: Integer;
    FQTDE_MAXIMA_CARTOES: Integer;
    FPESQUISA_PARTE: String;
    FCONFIGURACAO_BALANCA: String;
    FPARAMETROS_DIVERSOS: String;
    FULTIMA_EXCLUSAO: Integer;
    FLAUDO : String; //Gilson
    FINDICE_GERENCIAL: String;   // José Moacir
    FDATA_ATUALIZACAO_ESTOQUE: String;   // José Moacir
    FSINCRONIZADO: String;

    FResolucaoVO: TResolucaoVO;
    FModeloImpressora: String;
    FNomeCaixa: String;

    FBalancaIdentificadorBalanca:String;
    FBalancaModelo: Integer;
    FBalancaHandShaking: Integer;
    FBalancaParity: Integer;
    FBalancaStopBits: Integer;
    FBalancaDataBits: Integer;
    FBalancaBaudRate: Integer;
    FBalancaPortaSerial: String;
    FBalancaTimeOut: Integer;
    FBalancaTipoConfiguracaoBalanca: String;

    FPedeCPFCupom: Integer;
    FUsaIntegracao: Integer;
    FTimerIntegracao: Integer;
    FGavetaDinheiro: Integer;
    FSinalInvertido: Integer;
    FQtdeMaximaParcelas: Integer;
    FImprimeParcelas: Integer;
    FTecladoReduzido: Integer;

//******* IndiceGerencial   // José Moacir
    FGerencialX: Integer;
    FMeiosDePagamento: Integer;
    FDavEmitidos: Integer;
    FIdentificacaoPaf: Integer;
    FParametrosDeConfiguracao: Integer;
    FRelatorio: Integer;
//******* Fim

    FUsaLeitorSerial: Integer;
    FPortaLeitorSerial: String;
    FBaudLeitorSerial: String;
    FSufixoLeitorSerial: String;
    FIntervaloLeitorSerial: String;
    FDataLeitorSerial: String;
    FParidadeLeitorSerial: Integer;
    FHardFlowLeitorSerial: Integer;
    FSoftFlowLeitorSerial: Integer;
    FHandShakeLeitorSerial: Integer;
    FStopLeitorSerial: Integer;
    FFilaLeitorSerial: Integer;
    FExcluiSufixoLeitorSerial: Integer;
    FLancamentoNotasManuais: Integer;
    FNumSerieECF: String;

  published

    property Id: Integer read FID write FID;
    property IdImpressora: Integer read FID_ECF_IMPRESSORA write FID_ECF_IMPRESSORA;
    property IdResolucao: Integer read FID_ECF_RESOLUCAO write FID_ECF_RESOLUCAO;
    property IdCaixa: Integer read FID_ECF_CAIXA write FID_ECF_CAIXA;
    property IdEmpresa: Integer read FID_ECF_EMPRESA write FID_ECF_EMPRESA;
    property MensagemCupom: String read FMENSAGEM_CUPOM write FMENSAGEM_CUPOM;
    property PortaECF: String read FPORTA_ECF write FPORTA_ECF;
    property IpServidor: String read FIP_SERVIDOR write FIP_SERVIDOR;
    property IpSitef: String read FIP_SITEF write FIP_SITEF;
    property TipoTEF: String read FTIPO_TEF write FTIPO_TEF;
    property TituloTelaCaixa: String read FTITULO_TELA_CAIXA write FTITULO_TELA_CAIXA;
    property CaminhoImagensProdutos: String read FCAMINHO_IMAGEM_PRODUTOS write FCAMINHO_IMAGEM_PRODUTOS;
    property CaminhoImagensMarketing: String read FCAMINHO_IMAGENS_MARKETING write FCAMINHO_IMAGENS_MARKETING;
    property CaminhoImagensLayout: String read FCAMINHO_IMAGENS_LAYOUT write FCAMINHO_IMAGENS_LAYOUT;
    property CorJanelasInternas: String read FCOR_JANELAS_INTERNAS write FCOR_JANELAS_INTERNAS;
    property MarketingAtivo: String read FMARKETING_ATIVO write FMARKETING_ATIVO;
    property CFOPECF: Integer read FCFOP_ECF write FCFOP_ECF;
    property CFOPNF2: Integer read FCFOP_NF2 write FCFOP_NF2;
    property TimeOutECF: Integer read FTIMEOUT_ECF write FTIMEOUT_ECF;
    property IntervaloECF: Integer read FINTERVALO_ECF write FINTERVALO_ECF;
    property DescricaoSuprimento: String read FDESCRICAO_SUPRIMENTO write FDESCRICAO_SUPRIMENTO;
    property DescricaoSangria: String read FDESCRICAO_SANGRIA write FDESCRICAO_SANGRIA;
    property TEFTipoGP: Integer        read FTEF_TIPO_GP        write  FTEF_TIPO_GP;
    property TEFTempoEspera: Integer   read FTEF_TEMPO_ESPERA   write  FTEF_TEMPO_ESPERA;
    property TEFEsperaSTS: Integer     read FTEF_ESPERA_STS     write  FTEF_ESPERA_STS;
    property TEFNumeroVias: Integer    read FTEF_NUMERO_VIAS    write  FTEF_NUMERO_VIAS;
    property DecimaisQuantidade: Integer read FDECIMAIS_QUANTIDADE write FDECIMAIS_QUANTIDADE;
    property DecimaisValor: Integer read FDECIMAIS_VALOR write FDECIMAIS_VALOR;
    property BitsPorSegundo: Integer read FBITS_POR_SEGUNDO write FBITS_POR_SEGUNDO;
    property QuantidadeMaximaCartoes: Integer read FQTDE_MAXIMA_CARTOES write FQTDE_MAXIMA_CARTOES;
    property PesquisaParte: String read FPESQUISA_PARTE write FPESQUISA_PARTE;
    property ConfiguracaoBalanca: String read FCONFIGURACAO_BALANCA write FCONFIGURACAO_BALANCA;
    property ParametrosDiversos: String                 read FPARAMETROS_DIVERSOS                 write FPARAMETROS_DIVERSOS;
    property UltimaExclusao: Integer                    read FULTIMA_EXCLUSAO                     write FULTIMA_EXCLUSAO;
    property Laudo: String read FLAUDO write FLAUDO; //Gilson
    property IndiceGerencial: String                    read FINDICE_GERENCIAL                    write FINDICE_GERENCIAL;  // José Moacir
    property DataAtualizacaoEstoque: String                    read FDATA_ATUALIZACAO_ESTOQUE                    write FDATA_ATUALIZACAO_ESTOQUE;
    property Sincronizado: String read FSINCRONIZADO write FSINCRONIZADO;

    property ResolucaoVO: TResolucaoVO read FResolucaoVO write FResolucaoVO;
    property ModeloImpressora: String read FModeloImpressora write FModeloImpressora;
    property NomeCaixa: String read FNomeCaixa write FNomeCaixa;

    property BalancaIdentificadorBalanca: String         read FBalancaIdentificadorBalanca        write FBalancaIdentificadorBalanca;
    property BalancaModelo: Integer                     read FBalancaModelo                      write FBalancaModelo;
    property BalancaHandShaking: Integer                read FBalancaHandShaking                 write FBalancaHandShaking;
    property BalancaParity: Integer                     read FBalancaParity                      write FBalancaParity;
    property BalancaStopBits: Integer                   read FBalancaStopBits                    write FBalancaStopBits;
    property BalancaDataBits: Integer                   read FBalancaDataBits                    write FBalancaDataBits;
    property BalancaBaudRate: Integer                   read FBalancaBaudRate                    write FBalancaBaudRate;
    property BalancaPortaSerial: String                 read FBalancaPortaSerial                 write FBalancaPortaSerial;
    property BalancaTimeOut: Integer                     read FBalancaTimeOut                     write FBalancaTimeOut;
    property BalancaTipoConfiguracaoBalanca: String      read FBalancaTipoConfiguracaoBalanca     write FBalancaTipoConfiguracaoBalanca;

    property PedeCPFCupom: Integer                      read FPedeCPFCupom                        write FPedeCPFCupom;
    property UsaIntegracao: Integer                     read FUsaIntegracao                       write FUsaIntegracao;
    property TimerIntegracao: Integer                   read FTimerIntegracao                     write FTimerIntegracao;
    property GavetaDinheiro: Integer                    read FGavetaDinheiro                      write FGavetaDinheiro;
    property SinalInvertido: Integer                    read FSinalInvertido                      write FSinalInvertido;
    property QtdeMaximaParcelas: Integer                read FQtdeMaximaParcelas                  write FQtdeMaximaParcelas;
    property ImprimeParcelas: Integer                   read FImprimeParcelas                     write FImprimeParcelas;
    property TecladoReduzido: Integer                   read FTecladoReduzido                     write FTecladoReduzido;

    property GerencialX: Integer                        read FGerencialX                          write FGerencialX;
    property MeiosDePagamento: Integer                  read FMeiosDePagamento                    write FMeiosDePagamento;
    property DavEmitidos: Integer                       read FDavEmitidos                         write FDavEmitidos;
    property IdentificacaoPaf: Integer                  read FIdentificacaoPaf                    write FIdentificacaoPaf;
    property ParametrosDeConfiguracao: Integer          read FParametrosDeConfiguracao            write FParametrosDeConfiguracao;
    property Relatorio: Integer                         read FRelatorio                           write FRelatorio;

    property UsaLeitorSerial: Integer                   read FUsaLeitorSerial                     write FUsaLeitorSerial;
    property PortaLeitorSerial: String                 read FPortaLeitorSerial                   write FPortaLeitorSerial;
    property BaudLeitorSerial: String                  read FBaudLeitorSerial                    write FBaudLeitorSerial;
    property SufixoLeitorSerial: String                read FSufixoLeitorSerial                  write FSufixoLeitorSerial;
    property IntervaloLeitorSerial: String             read FIntervaloLeitorSerial               write FIntervaloLeitorSerial;
    property DataLeitorSerial: String                  read FDataLeitorSerial                    write FDataLeitorSerial;
    property ParidadeLeitorSerial: Integer              read FParidadeLeitorSerial                write FParidadeLeitorSerial;
    property HardFlowLeitorSerial: Integer              read FHardFlowLeitorSerial                write FHardFlowLeitorSerial;
    property SoftFlowLeitorSerial: Integer              read FSoftFlowLeitorSerial                write FSoftFlowLeitorSerial;
    property HandShakeLeitorSerial: Integer             read FHandShakeLeitorSerial               write FHandShakeLeitorSerial;
    property StopLeitorSerial: Integer                  read FStopLeitorSerial                    write FStopLeitorSerial;
    property FilaLeitorSerial: Integer                  read FFilaLeitorSerial                    write FFilaLeitorSerial;
    property ExcluiSufixoLeitorSerial: Integer          read FExcluiSufixoLeitorSerial            write FExcluiSufixoLeitorSerial;
    property LancamentoNotasManuais: Integer            read FLancamentoNotasManuais              write FLancamentoNotasManuais;
    property NumSerieECF: String                       read FNumSerieECF                         write FNumSerieECF;
  end;

implementation

end.
