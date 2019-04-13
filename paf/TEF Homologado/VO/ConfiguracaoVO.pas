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
    FPORTA_PINPAD: String;
    FPORTA_BALANCA: String;
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
    FINDICE_GERENCIAL_DAV: Integer;
    FDECIMAIS_QUANTIDADE: Integer;
    FDECIMAIS_VALOR: Integer;
    FSINCRONIZADO: String;
    FBITS_POR_SEGUNDO: Integer;
    FQTDE_MAXIMA_CARTOES: Integer;
    FResolucaoVO: TResolucaoVO;
    FModeloImpressora: String;

  published

    property Id: Integer read FID write FID;
    property IdImpressora: Integer read FID_ECF_IMPRESSORA write FID_ECF_IMPRESSORA;
    property IdResolucao: Integer read FID_ECF_RESOLUCAO write FID_ECF_RESOLUCAO;
    property IdCaixa: Integer read FID_ECF_CAIXA write FID_ECF_CAIXA;
    property IdEmpresa: Integer read FID_ECF_EMPRESA write FID_ECF_EMPRESA;
    property MensagemCupom: String read FMENSAGEM_CUPOM write FMENSAGEM_CUPOM;
    property PortaECF: String read FPORTA_ECF write FPORTA_ECF;
    property PortaPinPad: String read FPORTA_PINPAD write FPORTA_PINPAD;
    property PortaBalanca: String read FPORTA_BALANCA write FPORTA_BALANCA;
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
    property IndiceGerencialDAV: Integer read FINDICE_GERENCIAL_DAV write FINDICE_GERENCIAL_DAV;
    property DecimaisQuantidade: Integer read FDECIMAIS_QUANTIDADE write FDECIMAIS_QUANTIDADE;
    property DecimaisValor: Integer read FDECIMAIS_VALOR write FDECIMAIS_VALOR;
    property Sincronizado: String read FSINCRONIZADO write FSINCRONIZADO;
    property BitsPorSegundo: Integer read FBITS_POR_SEGUNDO write FBITS_POR_SEGUNDO;
    property QuantidadeMaximaCartoes: Integer read FQTDE_MAXIMA_CARTOES write FQTDE_MAXIMA_CARTOES;
    property ResolucaoVO: TResolucaoVO read FResolucaoVO write FResolucaoVO;
    property ModeloImpressora: String read FModeloImpressora write FModeloImpressora;

  end;

implementation

end.
