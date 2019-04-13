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
    //FPORTA_PINPAD: String;
    //FPORTA_BALANCA: String;
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
    //FINDICE_GERENCIAL_DAV: Integer;
    FDECIMAIS_QUANTIDADE: Integer;
    FDECIMAIS_VALOR: Integer;
    FSINCRONIZADO: String;
    FBITS_POR_SEGUNDO: Integer;
    FQTDE_MAXIMA_CARTOES: Integer;
    FResolucaoVO: TResolucaoVO;
    FModeloImpressora: String;
    FPESQUISA_PARTE: String;
    FLAUDO : String; //Gilson
    FCONFIGURACAO_BALANCA: String;
    FPARAMETROS_DIVERSOS: String;
    FULTIMA_EXCLUSAO: Integer;
    //FINDICE_GERENCIAL_IDENTIFICA: Integer;
    FBalanca_IdentificadorBalanca:string;
    FBalanca_Modelo: Integer;
    FBalanca_HandShaking :Integer;
    FBalanca_Parity :Integer;
    FBalanca_StopBits :Integer;
    FBalanca_DataBits :Integer;
    FBalanca_BaudRate :Integer;
    FBalanca_PortaSerial :string;
    FBalanca_TimeOut:Integer;
    FBalanca_TipoConfiguracaoBalanca:string;

    FPedeCPFCupom :Integer;
    FUsaIntegracao :Integer;
    FTimerIntegracao :Integer;
    FGavetaDinheiro :Integer;
    FSinalInvertido :Integer;
    FQtdeMaximaParcelas :Integer;
    FImprimeParcelas :Integer;
    FTecladoReduzido :Integer;

    FUsaLeitorSerial :Integer;
    FPortaLeitorSerial : string;
    FBaudLeitorSerial : string;
    FSufixoLeitorSerial : string;
    FIntervaloLeitorSerial : string;
    FDataLeitorSerial : string;
    FParidadeLeitorSerial :Integer;
    FHardFlowLeitorSerial :Integer;
    FSoftFlowLeitorSerial :Integer;
    FHandShakeLeitorSerial :Integer;
    FStopLeitorSerial :Integer;
    FFilaLeitorSerial :Integer;
    FExcluiSufixoLeitorSerial :Integer;
    FTEF_TIPO_GP :Integer;
    FTEF_TEMPO_ESPERA :integer;
    FTEF_ESPERA_STS :Integer;
    FTEF_NUMERO_VIAS :Integer;
    FDATA_ATUALIZACAO_ESTOQUE : string;
    FINDICE_GERENCIAL :String;

  published

    property Id: Integer                                read FID                                  write FID;
    property IdImpressora: Integer                      read FID_ECF_IMPRESSORA                   write FID_ECF_IMPRESSORA;
    property IdResolucao: Integer                       read FID_ECF_RESOLUCAO                    write FID_ECF_RESOLUCAO;
    property IdCaixa: Integer                           read FID_ECF_CAIXA                        write FID_ECF_CAIXA;
    property IdEmpresa: Integer                         read FID_ECF_EMPRESA                      write FID_ECF_EMPRESA;
    property MensagemCupom: String                      read FMENSAGEM_CUPOM                      write FMENSAGEM_CUPOM;
    property PortaECF: String                           read FPORTA_ECF                           write FPORTA_ECF;
    //property PortaPinPad: String read FPORTA_PINPAD write FPORTA_PINPAD;
    //property PortaBalanca: String read FPORTA_BALANCA write FPORTA_BALANCA;
    property IpServidor: String                         read FIP_SERVIDOR                         write FIP_SERVIDOR;
    property IpSitef: String                            read FIP_SITEF                            write FIP_SITEF;
    property TipoTEF: String                            read FTIPO_TEF                            write FTIPO_TEF;
    property TituloTelaCaixa: String                    read FTITULO_TELA_CAIXA                   write FTITULO_TELA_CAIXA;
    property CaminhoImagensProdutos: String             read FCAMINHO_IMAGEM_PRODUTOS             write FCAMINHO_IMAGEM_PRODUTOS;
    property CaminhoImagensMarketing: String            read FCAMINHO_IMAGENS_MARKETING           write FCAMINHO_IMAGENS_MARKETING;
    property CaminhoImagensLayout: String               read FCAMINHO_IMAGENS_LAYOUT              write FCAMINHO_IMAGENS_LAYOUT;
    property CorJanelasInternas: String                 read FCOR_JANELAS_INTERNAS                write FCOR_JANELAS_INTERNAS;
    property MarketingAtivo: String                     read FMARKETING_ATIVO                     write FMARKETING_ATIVO;
    property CFOPECF: Integer                           read FCFOP_ECF                            write FCFOP_ECF;
    property CFOPNF2: Integer                           read FCFOP_NF2                            write FCFOP_NF2;
    property TimeOutECF: Integer                        read FTIMEOUT_ECF                         write FTIMEOUT_ECF;
    property IntervaloECF: Integer                      read FINTERVALO_ECF                       write FINTERVALO_ECF;
    property DescricaoSuprimento: String                read FDESCRICAO_SUPRIMENTO                write FDESCRICAO_SUPRIMENTO;
    property DescricaoSangria: String                   read FDESCRICAO_SANGRIA                   write FDESCRICAO_SANGRIA;
    property TefTipoGP: Integer                         read FTEF_TIPO_GP                         write FTEF_TIPO_GP;
    property TefTempoEspera: Integer                    read FTEF_TEMPO_ESPERA                    write FTEF_TEMPO_ESPERA;
    property TTefEsperaSTS: Integer                     read FTEF_ESPERA_STS                      write FTEF_ESPERA_STS;
    property TTefNumeroVias: Integer                    read FTEF_NUMERO_VIAS                     write FTEF_NUMERO_VIAS;
    property DecimaisQuantidade: Integer                read FDECIMAIS_QUANTIDADE                 write FDECIMAIS_QUANTIDADE;
    property DecimaisValor: Integer                     read FDECIMAIS_VALOR                      write FDECIMAIS_VALOR;
    property BitsPorSegundo: Integer                    read FBITS_POR_SEGUNDO                    write FBITS_POR_SEGUNDO;
    property QuantidadeMaximaCartoes: Integer           read FQTDE_MAXIMA_CARTOES                 write FQTDE_MAXIMA_CARTOES;
    property PesquisaParte: String                      read FPESQUISA_PARTE                      write FPESQUISA_PARTE;
    property ConfiguracaoBalanca: String                read FCONFIGURACAO_BALANCA                write FCONFIGURACAO_BALANCA;
    property ParametrosDiversos: String                 read FPARAMETROS_DIVERSOS                 write FPARAMETROS_DIVERSOS;
    property UltimaExclusao: Integer                    read FULTIMA_EXCLUSAO                     write FULTIMA_EXCLUSAO;
    property Laudo: String                              read FLAUDO                               write FLAUDO; //Gilson
    property IndiceGerencial: String                    read FINDICE_GERENCIAL                    write FINDICE_GERENCIAL;
    //property IndiceGerencialDAV: Integer                read FINDICE_GERENCIAL_DAV                write FINDICE_GERENCIAL_DAV;
    property Sincronizado: String                       read FSINCRONIZADO                        write FSINCRONIZADO;
    property DataAtualizacaoEstoque: String             read FDATA_ATUALIZACAO_ESTOQUE            write FDATA_ATUALIZACAO_ESTOQUE;

    property ResolucaoVO: TResolucaoVO                  read FResolucaoVO                         write FResolucaoVO;
    property ModeloImpressora: String                   read FModeloImpressora                    write FModeloImpressora;

    property BalancaIdentificadorBalanca:string         read FBalanca_IdentificadorBalanca        write FBalanca_IdentificadorBalanca;
    property BalancaModelo: Integer                     read FBalanca_Modelo                      write FBalanca_Modelo;
    property BalancaHandShaking :Integer                read FBalanca_HandShaking                 write FBalanca_HandShaking;
    property BalancaParity :Integer                     read FBalanca_Parity                      write FBalanca_Parity;
    property BalancaStopBits :Integer                   read FBalanca_StopBits                    write FBalanca_StopBits;
    property BalancaDataBits :Integer                   read FBalanca_DataBits                    write FBalanca_DataBits;
    property BalancaBaudRate :Integer                   read FBalanca_BaudRate                    write FBalanca_BaudRate;
    property BalancaPortaSerial :string                 read FBalanca_PortaSerial                 write FBalanca_PortaSerial;
    property BalancaTimeOut:Integer                     read FBalanca_TimeOut                     write FBalanca_TimeOut;
    property BalancaTipoConfiguracaoBalanca:string      read FBalanca_TipoConfiguracaoBalanca     write FBalanca_TipoConfiguracaoBalanca;

    property PedeCPFCupom :Integer                      read FPedeCPFCupom                        write FPedeCPFCupom;
    property UsaIntegracao :Integer                     read FUsaIntegracao                       write FUsaIntegracao;
    property TimerIntegracao :Integer                   read FTimerIntegracao                     write FTimerIntegracao;
    property GavetaDinheiro :Integer                    read FGavetaDinheiro                      write FGavetaDinheiro;
    property SinalInvertido :Integer                    read FSinalInvertido                      write FSinalInvertido;
    property QtdeMaximaParcelas :Integer                read FQtdeMaximaParcelas                  write FQtdeMaximaParcelas;
    property ImprimeParcelas :Integer                   read FImprimeParcelas                     write FImprimeParcelas;
    property TecladoReduzido :Integer                   read FTecladoReduzido                     write FTecladoReduzido;

    property UsaLeitorSerial :Integer                   read FUsaLeitorSerial                     write FUsaLeitorSerial;
    property PortaLeitorSerial : string                 read FPortaLeitorSerial                   write FPortaLeitorSerial;
    property BaudLeitorSerial : string                  read FBaudLeitorSerial                    write FBaudLeitorSerial;
    property SufixoLeitorSerial : string                read FSufixoLeitorSerial                  write FSufixoLeitorSerial;
    property IntervaloLeitorSerial : string             read FIntervaloLeitorSerial               write FIntervaloLeitorSerial;
    property DataLeitorSerial : string                  read FDataLeitorSerial                    write FDataLeitorSerial;
    property ParidadeLeitorSerial :Integer              read FParidadeLeitorSerial                write FParidadeLeitorSerial;
    property HardFlowLeitorSerial :Integer              read FHardFlowLeitorSerial                write FHardFlowLeitorSerial;
    property SoftFlowLeitorSerial :Integer              read FSoftFlowLeitorSerial                write FSoftFlowLeitorSerial;
    property HandShakeLeitorSerial :Integer             read FHandShakeLeitorSerial               write FHandShakeLeitorSerial;
    property StopLeitorSerial :Integer                  read FStopLeitorSerial                    write FStopLeitorSerial;
    property FilaLeitorSerial :Integer                  read FFilaLeitorSerial                    write FFilaLeitorSerial;
    property ExcluiSufixoLeitorSerial :Integer          read FExcluiSufixoLeitorSerial            write FExcluiSufixoLeitorSerial;
    //property IndiceGerencialIdentificacao :Integer      read FINDICE_GERENCIAL_IDENTIFICA         write FINDICE_GERENCIAL_IDENTIFICA;
  end;

implementation

end.
