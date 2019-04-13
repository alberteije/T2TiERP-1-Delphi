{*******************************************************************************
Title: T2Ti ERP
Description: Controle da Carga.

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

@author Albert Eije (T2Ti.COM) | Jose Rodrigues de Oliveira Junior
@version 1.0
*******************************************************************************}

unit UCargaPDV;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, JvProgressBar, ComCtrls, JvExComCtrls, Generics.Collections,
  ContasParcelasVO;

type
  TFCargaPDV = class(TForm)
    Timer1: TTimer;
    JvProgressBar1: TJvProgressBar;
    function ImportaCarga(RemoteApp: String): Boolean;
    function ExportaCarga(RemoteApp: String): Boolean;
    function ExportaCancelamentoCupom(RemoteApp: String): Boolean;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Timer1Timer(Sender: TObject);
    procedure ImprimeParcelasECF(Nome, CPF, COO: String; TotalParcela:currency; ListaParcela: TObjectList<TContasParcelasVO>);
    function ExportaTabela(PathTabela: String): Boolean;
  private
    PathVenda: String;
    { Private declarations }
  public
    Tipo: Integer;
    NomeArquivo:string;
    { Public declarations }
  end;

var
  FCargaPDV: TFCargaPDV;

implementation

uses Biblioteca, ProdutoController, UnidadeController,
     UCaixa, VendaCabecalhoVO, VendaController, VendaDetalheVO,
     SituacaoClienteController, ClienteController,
     TotalTipoPagamentoVO, TotalTipoPagamentoController , UDataModule,
     ContasPagarReceberVO,  ParcelaController, EmpresaController,
     ContadorController, TurnoController,
     VendedorController, OperadorController, BancoController,
     CFOPController, FichaTecnicaController,
     ProdutoPromocaoController, LogImportacaoController,
     UPenDrive, ResolucaoController,
     ComponentesController, ImpressoraController, ConfiguracaoVO;

{$R *.dfm}

function TFCargaPDV.ImportaCarga(RemoteApp: String): Boolean;
var
  i : Integer;
  LocalApp, Tupla, Compara, LogTupla: String;
  atcarga: TextFile;
begin
  Result := False;
  i := 0;
  LocalApp:=  ExtractFilePath(Application.ExeName)+'Script\carga.txt';

  if CopyFile(PChar(RemoteApp), PChar(LocalApp), False) then
  begin
    Application.ProcessMessages;
    AssignFile(atcarga,LocalApp);
    Reset(atcarga);
    while not Eof(atcarga) do
    begin
      Readln(atcarga);
      inc(i);
    end;

    JvProgressBar1.Max := i;
    i := 0;
    Reset(atcarga);
    try

      JvProgressBar1.Position := i;
      while not Eof(atcarga) do
      begin
        inc(i);
        JvProgressBar1.Position:= i;
        Read(atcarga, Tupla);
        LogTupla:=copy(Tupla,1,250);
        Compara:= DevolveConteudoDelimitado('|',Tupla);
        Application.ProcessMessages;

        if Compara = 'UNIDADE' then
        begin
          if not TUnidadeController.GravaCargaUnidadeProduto(Tupla) then
            TLogImportacaoController.GravaLogImportacao(LogTupla);
        end

        else if Compara = 'PRODUTO' then
        begin
          if not TProdutoController.GravaCargaProduto(Tupla) then
            TLogImportacaoController.GravaLogImportacao(LogTupla);
        end

        else if Compara = 'SITUACAO_CLI' then
        begin
          if not TSituacaoClienteController.GravaCargaSituacaoCliente(Tupla) then
            TLogImportacaoController.GravaLogImportacao(LogTupla);
        end
        else if Compara = 'CLIENTE' then
        begin
          if not TClienteController.GravaCargaCliente(Tupla)then
            TLogImportacaoController.GravaLogImportacao(LogTupla);
        end

        else if Compara = 'EMPRESA' then
        begin
          if not TEmpresaController.GravaCargaEmpresa(Tupla)then
            TLogImportacaoController.GravaLogImportacao(LogTupla);
        end

        else if Compara = 'CONTADOR' then
        begin
          if not TContadorController.GravaCargaContador(Tupla)then
            TLogImportacaoController.GravaLogImportacao(LogTupla);
        end

        else if Compara = 'TURNO' then
        begin
          if not TTurnoController.GravaCargaTurno(Tupla)then
            TLogImportacaoController.GravaLogImportacao(LogTupla);
        end

        else if Compara = 'FUNCIONARIO' then
        begin
          if not TVendedorController.GravaCargaFuncionario(Tupla)then
            TLogImportacaoController.GravaLogImportacao(LogTupla);
        end

        else if Compara = 'OPERADOR' then
        begin
          if not TOperadorController.GravaCargaOperador(Tupla)then
            TLogImportacaoController.GravaLogImportacao(LogTupla);
        end

        else if Compara = 'BANCO' then
        begin
          if not TBancoController.GravaCargaBanco(Tupla) then
            TLogImportacaoController.GravaLogImportacao(LogTupla);
        end

        else if Compara = 'CFOP' then
        begin
          if not TCFOPController.GravaCargaCFOP(Tupla) then
            TLogImportacaoController.GravaLogImportacao(LogTupla);
        end

        else if Compara = 'FICHA' then
        begin
          if not TFichaTecnicaController.GravaCargaFichaTecnica(Tupla) then
            TLogImportacaoController.GravaLogImportacao(LogTupla);
        end

        else if Compara = 'PROMOCAO' then
        begin
          if not TProdutoPromocaoController.GravaCargaProdutoPromocao(Tupla) then
            TLogImportacaoController.GravaLogImportacao(LogTupla);
        end

        else if Compara = 'RESOLUCAO' then
        begin
          if not TResolucaoController.GravaCargaResolucao(Tupla) then
            TLogImportacaoController.GravaLogImportacao(LogTupla);
        end

        else if Compara = 'COMPONENTES' then
        begin
          if not TComponentesController.GravaCargaComponentes(Tupla) then
            TLogImportacaoController.GravaLogImportacao(LogTupla);
        end

        else if Compara = 'IMPRESSORA' then
        begin
          if not TImpressoraController.GravaCargaImpressora(Tupla) then
            TLogImportacaoController.GravaLogImportacao(LogTupla);
        end

        else if Compara = 'CONFIGURACAO' then
        begin
          if not TComponentesController.GravaCargaComponentes(Tupla) then
            TLogImportacaoController.GravaLogImportacao(LogTupla);
        end;

      Readln(atcarga);
    end;
    finally
      CloseFile(atcarga);
      Result := true;
    end;
    Result := true;
  end;
end;

function TFCargaPDV.ExportaCancelamentoCupom(RemoteApp: String): Boolean;
var
  i, idVendaParcela: Integer;
  atvenda: TextFile;
  VendaCabecalho: TVendaCabecalhoVO;
  ListaVenda: TObjectList<TVendaDetalheVO>;
  ListaTotalTipoPagamento: TObjectList<TTotalTipoPagamentoVO>;
  ParcelaCabecalho: TContasPagarReceberVO;
  ListaParcela: TObjectList<TContasParcelasVO>;
  ParcelaDetalhe: TContasParcelasVO;
  CPFCNPJ, NomeCliente, Cupom, Identificacao: String;
  TotalParcelado: Currency;
begin
  try
    DecimalSeparator := '.';
    Application.ProcessMessages;
    VendaCabecalho := TVendaController.RetornaCabecalhoDaUltimaVenda;
    CPFCNPJ := VendaCabecalho.CPFouCNPJCliente;
    NomeCliente := VendaCabecalho.NomeCliente;
    Cupom := IntToStr(VendaCabecalho.COO);

    Identificacao := 'E'+IntToStr(Configuracao.IdEmpresa)+'X'+DevolveInteiro(Configuracao.NomeCaixa)+'V'+IntToStr(VendaCabecalho.Id)+'C'+Cupom+'D'+DevolveInteiro(DateTimeToStr(now));

    PathVenda := ExtractFilePath(Application.ExeName)+'Script\'+'C'+IntToStr(Configuracao.IdCaixa)+'E'+IntToStr(Configuracao.IdEmpresa)+'-'+FormatDateTime('dd-mm-yyyy',now)+'.txt';

    AssignFile(atvenda,PathVenda);
    Application.ProcessMessages;

    if FileExists(PathVenda) then
      Append(atvenda)
    else
      Rewrite(atvenda);

    Write(atvenda,'CANCELAVCB|'+Identificacao+ '|'+
                  IntToStr(Configuracao.IdEmpresa)+ '|'+
                  Configuracao.NomeCaixa+'|'+
                  IntToStr(VendaCabecalho.id)+ '|'+
                  QuotedStr(Cupom)+ '|'+

                  QuotedStr(Configuracao.NomeCaixa)+'|'+             // NOME_CAIXA                  VARCHAR(30),
                  IntToStr(VendaCabecalho.id)+ '|'+                  // ID_GERADO_CAIXA             INTEGER,
                  IntToStr(Configuracao.IdEmpresa)+ '|'+             // ID_EMPRESA                  INTEGER,
                  IntToStr(VendaCabecalho.IdCliente)+ '|'+           // ID_CLIENTE                  INTEGER,
                  IntToStr(VendaCabecalho.IdVendedor)+ '|'+          // ID_ECF_FUNCIONARIO          INTEGER,
                  IntToStr(VendaCabecalho.IdMovimento)+ '|'+         // ID_ECF_MOVIMENTO            INTEGER,
                  IntToStr(VendaCabecalho.IdDAV)+ '|'+               // ID_ECF_DAV                  INTEGER,
                  IntToStr(VendaCabecalho.IdPreVenda)+ '|'+          // ID_ECF_PRE_VENDA_CABECALHO  INTEGER,
                  QuotedStr(VendaCabecalho.SerieEcf)+ '|'+           // SERIE_ECF                   VARCHAR(20),
                  IntToStr(VendaCabecalho.CFOP)+ '|'+                // CFOP                        INTEGER NOT NULL,
                  QuotedStr(Cupom)+ '|'+                             // COO                         INTEGER,
                  IntToStr(VendaCabecalho.CCF)+ '|'+                 // CCF                         INTEGER,
                  QuotedStr(VendaCabecalho.DataVenda)+ '|'+          // DATA_VENDA                  DATE,
                  QuotedStr(VendaCabecalho.HoraVenda)+ '|'+          // HORA_VENDA                  VARCHAR(8),
                  FloatToStr(VendaCabecalho.ValorVenda)+ '|'+        // VALOR_VENDA                 DECIMAL(18,6),
                  FloatToStr(VendaCabecalho.TaxaDesconto)+ '|'+      // TAXA_DESCONTO               DECIMAL(18,6),
                  FloatToStr(VendaCabecalho.Desconto)+ '|'+          // DESCONTO                    DECIMAL(18,6),
                  FloatToStr(VendaCabecalho.TaxaAcrescimo)+ '|'+     // TAXA_ACRESCIMO              DECIMAL(18,6),
                  FloatToStr(VendaCabecalho.Acrescimo)+ '|'+         // ACRESCIMO                   DECIMAL(18,6),
                  FloatToStr(VendaCabecalho.ValorFinal)+ '|'+        // VALOR_FINAL                 DECIMAL(18,6),
                  FloatToStr(VendaCabecalho.ValorRecebido)+ '|'+     // VALOR_RECEBIDO              DECIMAL(18,6),
                  FloatToStr(VendaCabecalho.Troco)+ '|'+             // TROCO                       DECIMAL(18,6),
                  FloatToStr(VendaCabecalho.ValorCancelado)+ '|'+    // VALOR_CANCELADO             DECIMAL(18,6),
                  FloatToStr(VendaCabecalho.TotalProdutos)+ '|'+     // TOTAL_PRODUTOS              DECIMAL(18,6),
                  FloatToStr(VendaCabecalho.TotalDocumentos)+ '|'+   // TOTAL_DOCUMENTO             DECIMAL(18,6),
                  FloatToStr(VendaCabecalho.BaseICMS)+ '|'+          // BASE_ICMS                   DECIMAL(18,6),
                  FloatToStr(VendaCabecalho.ICMS)+ '|'+              // ICMS                        DECIMAL(18,6),
                  FloatToStr(VendaCabecalho.ICMSOutras)+ '|'+        // ICMS_OUTRAS                 DECIMAL(18,6),
                  FloatToStr(VendaCabecalho.ISSQN)+ '|'+             // ISSQN                       DECIMAL(18,6),
                  FloatToStr(VendaCabecalho.PIS)+ '|'+               // PIS                         DECIMAL(18,6),
                  FloatToStr(VendaCabecalho.COFINS)+ '|'+            // COFINS                      DECIMAL(18,6),
                  FloatToStr(VendaCabecalho.AcrescimoItens)+ '|'+    // ACRESCIMO_ITENS             DECIMAL(18,6),
                  FloatToStr(VendaCabecalho.DescontoItens)+ '|'+     // DESCONTO_ITENS              DECIMAL(18,6),
                  QuotedStr(VendaCabecalho.StatusVenda)+ '|'+        // STATUS_VENDA                CHAR(1),
                  QuotedStr(NomeCliente)+ '|'+                       // NOME_CLIENTE                VARCHAR(100),
                  QuotedStr(CPFCNPJ)+ '|'+                           // CPF_CNPJ_CLIENTE            VARCHAR(14),
                  QuotedStr(VendaCabecalho.CupomFoiCancelado)+ '|'+  // CUPOM_CANCELADO             CHAR(1),
                  QuotedStr(VendaCabecalho.HashTripa)+ '|'+          // HASH_TRIPA                  VARCHAR(32),
                  IntToStr(VendaCabecalho.CCF)+ '|');                // HASH_INCREMENTO             INTEGER,
                                                                     // DATA_SINCRONIZACAO          DATE,
                                                                     // HORA_SINCRONIZACAO          VARCHAR(8)


    Writeln(atvenda);
    ListaVenda := TVendaController.RetornaDetalheDaUltimaVenda(VendaCabecalho.id);
    Application.ProcessMessages;

    for i := 0 to ListaVenda.Count - 1 do
    begin
      Write(atvenda,'CANCELAVDT|'+
                    Identificacao+'I'+IntToStr(TVendaDetalheVO(ListaVenda.Items[i]).id)+'|'+
                    IntToStr(Configuracao.IdEmpresa)+ '|'+
                    Configuracao.NomeCaixa+'|'+
                    IntToStr(TVendaDetalheVO(ListaVenda.Items[i]).id)+ '|'+
                    IntToStr(TVendaDetalheVO(ListaVenda.Items[i]).IdVendaCabecalho)+ '|'+
                    IntToStr(TVendaDetalheVO(ListaVenda.Items[i]).IdProduto)+ '|'+
                    FloatToStr(TVendaDetalheVO(ListaVenda.Items[i]).Quantidade)+ '|'+
                    TVendaDetalheVO(ListaVenda.Items[i]).MovimentaEstoque+ '|' +

                    QuotedStr(Configuracao.NomeCaixa)+'|'+                                     // NOME_CAIXA              VARCHAR(30),
                    IntToStr(TVendaDetalheVO(ListaVenda.Items[i]).id)+ '|'+                    // ID_GERADO_CAIXA         INTEGER,
                    IntToStr(Configuracao.IdEmpresa)+ '|'+                                     // ID_EMPRESA              INTEGER,
                    IntToStr(TVendaDetalheVO(ListaVenda.Items[i]).IdProduto)+ '|'+             // ID_ECF_PRODUTO          INTEGER,
                    IntToStr(TVendaDetalheVO(ListaVenda.Items[i]).IdVendaCabecalho)+ '|'+      // ID_ECF_VENDA_CABECALHO  INTEGER,
                    QuotedStr(TVendaDetalheVO(ListaVenda.Items[i]).SerieECF)+ '|'+             // SERIE_ECF               VARCHAR(20),
                    QuotedStr(TVendaDetalheVO(ListaVenda.Items[i]).GTIN)+ '|'+                 // GTIN                    VARCHAR(14),
                    IntToStr(TVendaDetalheVO(ListaVenda.Items[i]).Ccf)+ '|'+                   // CCF                     INTEGER,
                    IntToStr(TVendaDetalheVO(ListaVenda.Items[i]).Coo)+ '|'+                   // COO                     INTEGER,
                    IntToStr(TVendaDetalheVO(ListaVenda.Items[i]).CFOP)+ '|'+                  // CFOP                    INTEGER NOT NULL,
                    IntToStr(TVendaDetalheVO(ListaVenda.Items[i]).Item)+ '|'+                  // ITEM                    INTEGER,
                    FloatToStr(TVendaDetalheVO(ListaVenda.Items[i]).Quantidade)+ '|'+          // QUANTIDADE              DECIMAL(18,6),
                    FloatToStr(TVendaDetalheVO(ListaVenda.Items[i]).ValorUnitario)+ '|'+       // VALOR_UNITARIO          DECIMAL(18,6),
                    FloatToStr(TVendaDetalheVO(ListaVenda.Items[i]).ValorTotal)+ '|'+          // VALOR_TOTAL             DECIMAL(18,6),
                    FloatToStr(TVendaDetalheVO(ListaVenda.Items[i]).TotalItem)+ '|'+           // TOTAL_ITEM              DECIMAL(18,6),
                    FloatToStr(TVendaDetalheVO(ListaVenda.Items[i]).BaseICMS)+ '|'+            // BASE_ICMS               DECIMAL(18,6),
                    FloatToStr(TVendaDetalheVO(ListaVenda.Items[i]).TaxaICMS)+ '|'+            // TAXA_ICMS               DECIMAL(18,6),
                    FloatToStr(TVendaDetalheVO(ListaVenda.Items[i]).ICMS)+ '|'+                // ICMS                    DECIMAL(18,6),
                    FloatToStr(TVendaDetalheVO(ListaVenda.Items[i]).TaxaDesconto)+ '|'+        // TAXA_DESCONTO           DECIMAL(18,6),
                    FloatToStr(TVendaDetalheVO(ListaVenda.Items[i]).Desconto)+ '|'+            // DESCONTO                DECIMAL(18,6),
                    FloatToStr(TVendaDetalheVO(ListaVenda.Items[i]).TaxaISSQN)+ '|'+           // TAXA_ISSQN              DECIMAL(18,6),
                    FloatToStr(TVendaDetalheVO(ListaVenda.Items[i]).ISSQN)+ '|'+               // ISSQN                   DECIMAL(18,6),
                    FloatToStr(TVendaDetalheVO(ListaVenda.Items[i]).TaxaPIS)+ '|'+             // TAXA_PIS                DECIMAL(18,6),
                    FloatToStr(TVendaDetalheVO(ListaVenda.Items[i]).PIS)+ '|'+                 // PIS                     DECIMAL(18,6),
                    FloatToStr(TVendaDetalheVO(ListaVenda.Items[i]).TaxaCOFINS)+ '|'+          // TAXA_COFINS             DECIMAL(18,6),
                    FloatToStr(TVendaDetalheVO(ListaVenda.Items[i]).COFINS)+ '|'+              // COFINS                  DECIMAL(18,6),
                    FloatToStr(TVendaDetalheVO(ListaVenda.Items[i]).TaxaAcrescimo)+ '|'+       // TAXA_ACRESCIMO          DECIMAL(18,6),
                    FloatToStr(TVendaDetalheVO(ListaVenda.Items[i]).Acrescimo)+ '|'+           // ACRESCIMO               DECIMAL(18,6),
                    FloatToStr(TVendaDetalheVO(ListaVenda.Items[i]).AcrescimoRateio)+ '|'+     // ACRESCIMO_RATEIO        DECIMAL(18,6),
                    FloatToStr(TVendaDetalheVO(ListaVenda.Items[i]).DescontoRateio)+ '|'+      // DESCONTO_RATEIO         DECIMAL(18,6),
                    QuotedStr(TVendaDetalheVO(ListaVenda.Items[i]).TotalizadorParcial)+ '|'+   // TOTALIZADOR_PARCIAL     VARCHAR(10),
                    QuotedStr(TVendaDetalheVO(ListaVenda.Items[i]).CST)+ '|'+                  // CST                     CHAR(3),
                    QuotedStr(TVendaDetalheVO(ListaVenda.Items[i]).Cancelado)+ '|'+            // CANCELADO               CHAR(1),
                    QuotedStr(TVendaDetalheVO(ListaVenda.Items[i]).MovimentaEstoque)+ '|'+     // MOVIMENTA_ESTOQUE       CHAR(1),
                    QuotedStr(TVendaDetalheVO(ListaVenda.Items[i]).ECFIcmsST)+ '|'+            // ECF_ICMS_ST             VARCHAR(4),
                    QuotedStr(TVendaDetalheVO(ListaVenda.Items[i]).HashTripa)+ '|'+            // HASH_TRIPA              VARCHAR(32),
                    IntToStr(TVendaDetalheVO(ListaVenda.Items[i]).HashIncremento)+ '|');       // HASH_INCREMENTO         INTEGER,
                                                                                               // DATA_SINCRONIZACAO      DATE,
                                                                                               // HORA_SINCRONIZACAO      VARCHAR(8)


      Writeln(atvenda);
      Application.ProcessMessages;
    end;

    ListaTotalTipoPagamento := TTotalTipoPagamentoController.RetornaMeiosPagamentoDaUltimaVenda(VendaCabecalho.id);
    Application.ProcessMessages;

    for i := 0 to ListaTotalTipoPagamento.Count - 1 do
    begin
      Write(atvenda,'CANCELATTP|'+
                    Identificacao+'T'+IntToStr(TTotalTipoPagamentoVO(ListaTotalTipoPagamento.Items[i]).id)+
                    'P'+IntToStr(TTotalTipoPagamentoVO(ListaTotalTipoPagamento.Items[i]).IdTipoPagamento)+'|'+
                    IntToStr(Configuracao.IdEmpresa)+ '|'+
                    Configuracao.NomeCaixa+'|'+
                    IntToStr(TTotalTipoPagamentoVO(ListaTotalTipoPagamento.Items[i]).id)+ '|'+
                    IntToStr(TTotalTipoPagamentoVO(ListaTotalTipoPagamento.Items[i]).IdVenda)+ '|'+


                    QuotedStr(Configuracao.NomeCaixa)+'|'+                                                          //  NOME_CAIXA              VARCHAR(30),
                    IntToStr(TTotalTipoPagamentoVO(ListaTotalTipoPagamento.Items[i]).id)+ '|'+                      //  ID_GERADO_CAIXA         INTEGER,
                    IntToStr(Configuracao.IdEmpresa)+ '|'+                                                          //  ID_EMPRESA              INTEGER,
                    IntToStr(TTotalTipoPagamentoVO(ListaTotalTipoPagamento.Items[i]).IdVenda)+ '|'+                 //  ID_ECF_VENDA_CABECALHO  INTEGER,
                    IntToStr(TTotalTipoPagamentoVO(ListaTotalTipoPagamento.Items[i]).IdTipoPagamento)+ '|'+         //  ID_ECF_TIPO_PAGAMENTO   INTEGER,
                    QuotedStr(TTotalTipoPagamentoVO(ListaTotalTipoPagamento.Items[i]).SerieEcf)+ '|'+               //  SERIE_ECF               VARCHAR(20),
                    IntToStr(TTotalTipoPagamentoVO(ListaTotalTipoPagamento.Items[i]).Coo)+ '|'+                     //  COO                     INTEGER,
                    IntToStr(TTotalTipoPagamentoVO(ListaTotalTipoPagamento.Items[i]).Ccf)+ '|'+                     //  CCF                     INTEGER,
                    IntToStr(TTotalTipoPagamentoVO(ListaTotalTipoPagamento.Items[i]).Gnf)+ '|'+                     //  GNF                     INTEGER,
                    FloatToStr(TTotalTipoPagamentoVO(ListaTotalTipoPagamento.Items[i]).Valor)+ '|'+                 //  VALOR                   DECIMAL(18,6),
                    QuotedStr(TTotalTipoPagamentoVO(ListaTotalTipoPagamento.Items[i]).NSU)+ '|'+                    //  NSU                     VARCHAR(30),
                    QuotedStr(TTotalTipoPagamentoVO(ListaTotalTipoPagamento.Items[i]).Estorno)+ '|'+                //  ESTORNO                 CHAR(1),
                    QuotedStr(TTotalTipoPagamentoVO(ListaTotalTipoPagamento.Items[i]).Rede)+ '|'+                   //  REDE                    VARCHAR(10),
                    QuotedStr(TTotalTipoPagamentoVO(ListaTotalTipoPagamento.Items[i]).CartaoDebitoOuCredito)+ '|'+  //  CARTAO_DC               CHAR(1),
                    QuotedStr(TTotalTipoPagamentoVO(ListaTotalTipoPagamento.Items[i]).HashTripa)+ '|'+              //  HASH_TRIPA              VARCHAR(32),
                    IntToStr(TTotalTipoPagamentoVO(ListaTotalTipoPagamento.Items[i]).HashIncremento)+ '|');         //  HASH_INCREMENTO         INTEGER,
                                                                                                                    //  DATA_SINCRONIZACAO      DATE,
                                                                                                                    //  HORA_SINCRONIZACAO      VARCHAR(8)



      Writeln(atvenda);
      Application.ProcessMessages;
    end;

    idVendaParcela := VendaCabecalho.id;
    ParcelaCabecalho := TParcelaController.RetornaCabecalhoDaParcela(idVendaParcela);
    if idVendaParcela > 0 then
    begin
      Write(atvenda,'CANCELACPR|'+
                    Identificacao+'C'+IntToStr(ParcelaCabecalho.Id)+'|'+
                    Configuracao.NomeCaixa+'|'+
                    IntToStr(ParcelaCabecalho.Id)+ '|'+
                    IntToStr(ParcelaCabecalho.IdEcfVendaCabecalho)+ '|'+

                    IntToStr(ParcelaCabecalho.IdPlanoContas)+ '|'+       // ID_PLANO_CONTAS      INTEGER NOT NULL,
                    IntToStr(ParcelaCabecalho.IdPessoa)+ '|'+            // ID_PESSOA            INTEGER NOT NULL,
                    IntToStr(ParcelaCabecalho.IdTipoDocumento)+ '|'+     // ID_TIPO_DOCUMENTO    INTEGER NOT NULL,
                    QuotedStr(ParcelaCabecalho.Tipo)+ '|'+               // TIPO                 CHAR(1),
                    QuotedStr(ParcelaCabecalho.NumeroDocumento)+ '|'+    // NUMERO_DOCUMENTO     VARCHAR(20),
                    FloatToStr(ParcelaCabecalho.Valor)+ '|'+             // VALOR                DECIMAL(18,6),
                    QuotedStr(ParcelaCabecalho.DataLancamento)+ '|'+     // DATA_LANCAMENTO      DATE,
                    QuotedStr(ParcelaCabecalho.PrimeiroVencimento)+ '|'+ // PRIMEIRO_VENCIMENTO  DATE,
                    QuotedStr(ParcelaCabecalho.NaturezaLancamento)+ '|'+ // NATUREZA_LANCAMENTO  CHAR(1),
                    IntToStr(ParcelaCabecalho.QuantidadeParcela)+ '|');  // QUANTIDADE_PARCELA   INTEGER
      Writeln(atvenda);

      TotalParcelado := ParcelaCabecalho.Valor;
      ListaParcela := TParcelaController.RetornaDetalheDaParcela(ParcelaCabecalho.Id);

      for i := 0 to ListaParcela.Count - 1 do
      begin
        Write(atvenda,'CANCELAPAR|'+
              Identificacao+'P'+intToStr(TContasParcelasVO(ListaParcela.Items[i]).id)+
              Configuracao.NomeCaixa+'|'+
              intToStr(TContasParcelasVO(ListaParcela.Items[i]).NumeroParcela)+'|'+
              intToStr(TContasParcelasVO(ListaParcela.Items[i]).id)+ '|'+
              ParcelaCabecalho.NumeroDocumento+ '|'+
              //   intToStr(TContasParcelasVO(ListaParcela.Items[i]).IdChequeEmitido)+ '|'+      //   ID_CHEQUE_EMITIDO        INTEGER,
              //   intToStr(TContasParcelasVO(ListaParcela.Items[i]).IdContaCaixa)+ '|'+         //   ID_CONTA_CAIXA           INTEGER,
              //   intToStr(TContasParcelasVO(ListaParcela.Items[i]).IdMeiosPagamento)+ '|'+     //   ID_MEIOS_PAGAMENTO       INTEGER,
              //   intToStr(TContasParcelasVO(ListaParcela.Items[i]).IdContasPagarReceber)+ '|'+ //   ID_CONTAS_PAGAR_RECEBER  INTEGER NOT NULL,

              QuotedStr(TContasParcelasVO(ListaParcela.Items[i]).DataEmissao)+ '|'+              //  DATA_EMISSAO             DATE,
              QuotedStr(TContasParcelasVO(ListaParcela.Items[i]).DataVencimento)+ '|'+           //  DATA_VENCIMENTO          DATE,
              intToStr(TContasParcelasVO(ListaParcela.Items[i]).NumeroParcela)+ '|'+             //  NUMERO_PARCELA           INTEGER,
              FloatToStr(TContasParcelasVO(ListaParcela.Items[i]).Valor)+ '|'+                   //  VALOR                    DECIMAL(18,6),
              FloatToStr(TContasParcelasVO(ListaParcela.Items[i]).TaxaJuros)+ '|'+               //  TAXA_JUROS               DECIMAL(18,6),
              FloatToStr(TContasParcelasVO(ListaParcela.Items[i]).TaxaMulta)+ '|'+               //  TAXA_MULTA               DECIMAL(18,6),
              FloatToStr(TContasParcelasVO(ListaParcela.Items[i]).TaxaDesconto)+ '|'+            //  TAXA_DESCONTO            DECIMAL(18,6),
              FloatToStr(TContasParcelasVO(ListaParcela.Items[i]).ValorJuros)+ '|'+              //  VALOR_JUROS              DECIMAL(18,6),
              FloatToStr(TContasParcelasVO(ListaParcela.Items[i]).ValorMulta)+ '|'+              //  VALOR_MULTA              DECIMAL(18,6),
              FloatToStr(TContasParcelasVO(ListaParcela.Items[i]).ValorDesconto)+ '|'+           //  VALOR_DESCONTO           DECIMAL(18,6),
              FloatToStr(TContasParcelasVO(ListaParcela.Items[i]).TotalParcela)+ '|'+            //  TOTAL_PARCELA            DECIMAL(18,6),
              QuotedStr(TContasParcelasVO(ListaParcela.Items[i]).Historico)+ '|'+                //  HISTORICO                BLOB_TEXT /* BLOB_TEXT = BLOB SUB_TYPE 1 SEGMENT SIZE 1024 */,
              QuotedStr(TContasParcelasVO(ListaParcela.Items[i]).Situacao)+ '|');                //  SITUACAO                 CHAR(1)



        Writeln(atvenda);
        Application.ProcessMessages;
      end;
      DecimalSeparator := ',';
      Application.ProcessMessages;
      ImprimeParcelasECF(NomeCliente, CPFCNPJ, Cupom, TotalParcelado, ListaParcela);
    end;
  finally
    DecimalSeparator := ',';
    CloseFile(atvenda);

    if Assigned(VendaCabecalho) then
      FreeAndNil(VendaCabecalho);

    if Assigned(ListaVenda) then
      FreeAndNil(ListaVenda);

    if Assigned(ListaTotalTipoPagamento) then
      FreeAndNil(ListaTotalTipoPagamento);

    if Assigned(ParcelaCabecalho) then
      FreeAndNil(ParcelaCabecalho);

    if Assigned(ListaParcela) then
      FreeAndNil(ListaParcela);

    Result:=True;
    Application.ProcessMessages;
  end;
end;

function TFCargaPDV.ExportaCarga(RemoteApp: String): Boolean;
var
  i, idVendaParcela: Integer;
  atvenda: TextFile;
  VendaCabecalho: TVendaCabecalhoVO;
  ListaVenda: TObjectList<TVendaDetalheVO>;
  ListaTotalTipoPagamento: TObjectList<TTotalTipoPagamentoVO>;
  ParcelaCabecalho: TContasPagarReceberVO;
  ListaParcela: TObjectList<TContasParcelasVO>;
  ParcelaDetalhe: TContasParcelasVO;
  CPFCNPJ, NomeCliente, Cupom,  Identificacao: String;
  TotalParcelado: Currency;
begin
  try
    DecimalSeparator := '.';
    Application.ProcessMessages;
    VendaCabecalho := TVendaController.RetornaCabecalhoDaUltimaVenda;
    CPFCNPJ := VendaCabecalho.CPFouCNPJCliente;
    NomeCliente := VendaCabecalho.NomeCliente;
    Cupom := IntToStr(VendaCabecalho.COO);
    Identificacao:='E'+IntToStr(Configuracao.IdEmpresa)+'X'+DevolveInteiro(Configuracao.NomeCaixa)+'V'+IntToStr(VendaCabecalho.Id)+'C'+Cupom+'D'+DevolveInteiro(DateTimeToStr(now));

    PathVenda := ExtractFilePath(Application.ExeName)+'Script\'+'C'+IntToStr(Configuracao.IdCaixa)+'E'+IntToStr(Configuracao.IdEmpresa)+'-'+FormatDateTime('dd-mm-yyyy',now)+'.txt';
    AssignFile(atvenda,PathVenda);
    Application.ProcessMessages;

    if FileExists(PathVenda) then
      Append(atvenda)
    else
      Rewrite(atvenda);
                                                                     //  ECF_VENDA_CABECALHO (
    Write(atvenda,'VCB|'+ Identificacao+'|'+                         //   ID                          INTEGER NOT NULL,
                  QuotedStr(Configuracao.NomeCaixa)+'|'+             //   NOME_CAIXA                  VARCHAR(30),
                  IntToStr(VendaCabecalho.id)+ '|'+                  //   ID_GERADO_CAIXA             INTEGER,
                  IntToStr(Configuracao.IdEmpresa)+ '|'+             //   ID_EMPRESA                  INTEGER,
                  IntToStr(VendaCabecalho.IdCliente)+ '|'+           //   ID_CLIENTE                  INTEGER,
                  IntToStr(VendaCabecalho.IdVendedor)+ '|'+          //   ID_ECF_FUNCIONARIO          INTEGER,
                  IntToStr(VendaCabecalho.IdMovimento)+ '|'+         //   ID_ECF_MOVIMENTO            INTEGER,
                  IntToStr(VendaCabecalho.IdDAV)+ '|'+               //   ID_ECF_DAV                  INTEGER,
                  IntToStr(VendaCabecalho.IdPreVenda)+ '|'+          //   ID_ECF_PRE_VENDA_CABECALHO  INTEGER,
                  QuotedStr(VendaCabecalho.SerieEcf)+ '|'+           //   SERIE_ECF                   VARCHAR(20),
                  IntToStr(VendaCabecalho.CFOP)+ '|'+                //   CFOP                        INTEGER NOT NULL,
                  IntToStr(VendaCabecalho.COO)+ '|'+                 //   COO                         INTEGER,
                  IntToStr(VendaCabecalho.CCF)+ '|'+                 //   CCF                         INTEGER,
                  QuotedStr(VendaCabecalho.DataVenda)+ '|'+          //   DATA_VENDA                  DATE,
                  QuotedStr(VendaCabecalho.HoraVenda)+ '|'+          //   HORA_VENDA                  VARCHAR(8),
                  FloatToStr(VendaCabecalho.ValorVenda)+ '|'+        //   VALOR_VENDA                 DECIMAL(18,6),
                  FloatToStr(VendaCabecalho.TaxaDesconto)+ '|'+      //   TAXA_DESCONTO               DECIMAL(18,6),
                  FloatToStr(VendaCabecalho.Desconto)+ '|'+          //   DESCONTO                    DECIMAL(18,6),
                  FloatToStr(VendaCabecalho.TaxaAcrescimo)+ '|'+     //   TAXA_ACRESCIMO              DECIMAL(18,6),
                  FloatToStr(VendaCabecalho.Acrescimo)+ '|'+         //   ACRESCIMO                   DECIMAL(18,6),
                  FloatToStr(VendaCabecalho.ValorFinal)+ '|'+        //   VALOR_FINAL                 DECIMAL(18,6),
                  FloatToStr(VendaCabecalho.ValorRecebido)+ '|'+     //   VALOR_RECEBIDO              DECIMAL(18,6),
                  FloatToStr(VendaCabecalho.Troco)+ '|'+             //   TROCO                       DECIMAL(18,6),
                  FloatToStr(VendaCabecalho.ValorCancelado)+ '|'+    //   VALOR_CANCELADO             DECIMAL(18,6),
                  FloatToStr(VendaCabecalho.TotalProdutos)+ '|'+     //   TOTAL_PRODUTOS              DECIMAL(18,6),
                  FloatToStr(VendaCabecalho.TotalDocumentos)+ '|'+   //   TOTAL_DOCUMENTO             DECIMAL(18,6),
                  FloatToStr(VendaCabecalho.BaseICMS)+ '|'+          //   BASE_ICMS                   DECIMAL(18,6),
                  FloatToStr(VendaCabecalho.ICMS)+ '|'+              //   ICMS                        DECIMAL(18,6),
                  FloatToStr(VendaCabecalho.ICMSOutras)+ '|'+        //   ICMS_OUTRAS                 DECIMAL(18,6),
                  FloatToStr(VendaCabecalho.ISSQN)+ '|'+             //   ISSQN                       DECIMAL(18,6),
                  FloatToStr(VendaCabecalho.PIS)+ '|'+               //   PIS                         DECIMAL(18,6),
                  FloatToStr(VendaCabecalho.COFINS)+ '|'+            //   COFINS                      DECIMAL(18,6),
                  FloatToStr(VendaCabecalho.AcrescimoItens)+ '|'+    //   ACRESCIMO_ITENS             DECIMAL(18,6),
                  FloatToStr(VendaCabecalho.DescontoItens)+ '|'+     //   DESCONTO_ITENS              DECIMAL(18,6),
                  QuotedStr(VendaCabecalho.StatusVenda)+ '|'+        //   STATUS_VENDA                CHAR(1),
                  QuotedStr(VendaCabecalho.NomeCliente)+ '|'+        //   NOME_CLIENTE                VARCHAR(100),
                  QuotedStr(VendaCabecalho.CPFouCNPJCliente)+ '|'+   //   CPF_CNPJ_CLIENTE            VARCHAR(14),
                  QuotedStr(VendaCabecalho.CupomFoiCancelado)+ '|'+  //   CUPOM_CANCELADO             CHAR(1),
                  QuotedStr(VendaCabecalho.HashTripa)+ '|'+          //   HASH_TRIPA                  VARCHAR(32),
                  IntToStr(VendaCabecalho.HashIncremento)+ '|');     //   HASH_INCREMENTO             INTEGER,
                                                                     //   DATA_SINCRONIZACAO          DATE,
                                                                     //   HORA_SINCRONIZACAO          VARCHAR(8)



    Writeln(atvenda);
    ListaVenda := TVendaController.RetornaDetalheDaUltimaVenda(VendaCabecalho.id);
    Application.ProcessMessages;

    for i := 0 to ListaVenda.Count - 1 do
    begin
      Write(atvenda,'VDT|'+
                    Identificacao+'I'+IntToStr(TVendaDetalheVO(ListaVenda.Items[i]).id)+'|'+   //  ID,

                    IntToStr(TVendaDetalheVO(ListaVenda.Items[i]).IdProduto)+ '|'+             //  ID_ECF_PRODUTO,    usado para dar baixa estoque
                    FloatToStr(TVendaDetalheVO(ListaVenda.Items[i]).Quantidade)+ '|'+          //  QUANTIDADE,        usado para dar baixa estoque
                    TVendaDetalheVO(ListaVenda.Items[i]).MovimentaEstoque+ '|'+                //  MOVIMENTA_ESTOQUE, usado para dar baixa estoque
                                                                                               //                        ECF_VENDA_DETALHE (
                    QuotedStr(Configuracao.NomeCaixa)+'|'+                                     //  NOME_CAIXA              VARCHAR(30),
                    IntToStr(TVendaDetalheVO(ListaVenda.Items[i]).id)+ '|'+                    //  ID_GERADO_CAIXA         INTEGER,
                    IntToStr(Configuracao.IdEmpresa)+ '|'+                                     //  ID_EMPRESA              INTEGER,
                    IntToStr(TVendaDetalheVO(ListaVenda.Items[i]).IdProduto)+ '|'+             //  ID_ECF_PRODUTO          INTEGER,
                    IntToStr(TVendaDetalheVO(ListaVenda.Items[i]).IdVendaCabecalho)+ '|'+      //  ID_ECF_VENDA_CABECALHO  INTEGER,
                    QuotedStr(TVendaDetalheVO(ListaVenda.Items[i]).SerieECF)+ '|'+             //  SERIE_ECF               VARCHAR(20),
                    QuotedStr(TVendaDetalheVO(ListaVenda.Items[i]).GTIN)+ '|'+                 //  GTIN                    VARCHAR(14),
                    IntToStr(TVendaDetalheVO(ListaVenda.Items[i]).Ccf)+ '|'+                   //  CCF                     INTEGER,
                    IntToStr(TVendaDetalheVO(ListaVenda.Items[i]).Coo)+ '|'+                   //  COO                     INTEGER,
                    IntToStr(TVendaDetalheVO(ListaVenda.Items[i]).CFOP)+ '|'+                  //  CFOP                    INTEGER NOT NULL,
                    IntToStr(TVendaDetalheVO(ListaVenda.Items[i]).Item)+ '|'+                  //  ITEM                    INTEGER,
                    FloatToStr(TVendaDetalheVO(ListaVenda.Items[i]).Quantidade)+ '|'+          //  QUANTIDADE              DECIMAL(18,6),
                    FloatToStr(TVendaDetalheVO(ListaVenda.Items[i]).ValorUnitario)+ '|'+       //  VALOR_UNITARIO          DECIMAL(18,6),
                    FloatToStr(TVendaDetalheVO(ListaVenda.Items[i]).ValorTotal)+ '|'+          //  VALOR_TOTAL             DECIMAL(18,6),
                    FloatToStr(TVendaDetalheVO(ListaVenda.Items[i]).TotalItem)+ '|'+           //  TOTAL_ITEM              DECIMAL(18,6),
                    FloatToStr(TVendaDetalheVO(ListaVenda.Items[i]).BaseICMS)+ '|'+            //  BASE_ICMS               DECIMAL(18,6),
                    FloatToStr(TVendaDetalheVO(ListaVenda.Items[i]).TaxaICMS)+ '|'+            //  TAXA_ICMS               DECIMAL(18,6),
                    FloatToStr(TVendaDetalheVO(ListaVenda.Items[i]).ICMS)+ '|'+                //  ICMS                    DECIMAL(18,6),
                    FloatToStr(TVendaDetalheVO(ListaVenda.Items[i]).TaxaDesconto)+ '|'+        //  TAXA_DESCONTO           DECIMAL(18,6),
                    FloatToStr(TVendaDetalheVO(ListaVenda.Items[i]).Desconto)+ '|'+            //  DESCONTO                DECIMAL(18,6),
                    FloatToStr(TVendaDetalheVO(ListaVenda.Items[i]).TaxaISSQN)+ '|'+           //  TAXA_ISSQN              DECIMAL(18,6),
                    FloatToStr(TVendaDetalheVO(ListaVenda.Items[i]).ISSQN)+ '|'+               //  ISSQN                   DECIMAL(18,6),
                    FloatToStr(TVendaDetalheVO(ListaVenda.Items[i]).TaxaPIS)+ '|'+             //  TAXA_PIS                DECIMAL(18,6),
                    FloatToStr(TVendaDetalheVO(ListaVenda.Items[i]).PIS)+ '|'+                 //  PIS                     DECIMAL(18,6),
                    FloatToStr(TVendaDetalheVO(ListaVenda.Items[i]).TaxaCOFINS)+ '|'+          //  TAXA_COFINS             DECIMAL(18,6),
                    FloatToStr(TVendaDetalheVO(ListaVenda.Items[i]).COFINS)+ '|'+              //  COFINS                  DECIMAL(18,6),
                    FloatToStr(TVendaDetalheVO(ListaVenda.Items[i]).TaxaAcrescimo)+ '|'+       //  TAXA_ACRESCIMO          DECIMAL(18,6),
                    FloatToStr(TVendaDetalheVO(ListaVenda.Items[i]).Acrescimo)+ '|'+           //  ACRESCIMO               DECIMAL(18,6),
                    FloatToStr(TVendaDetalheVO(ListaVenda.Items[i]).AcrescimoRateio)+ '|'+     //  ACRESCIMO_RATEIO        DECIMAL(18,6),
                    FloatToStr(TVendaDetalheVO(ListaVenda.Items[i]).DescontoRateio)+ '|'+      //  DESCONTO_RATEIO         DECIMAL(18,6),
                    QuotedStr(TVendaDetalheVO(ListaVenda.Items[i]).TotalizadorParcial)+ '|'+   //  TOTALIZADOR_PARCIAL     VARCHAR(10),
                    QuotedStr(TVendaDetalheVO(ListaVenda.Items[i]).CST)+ '|'+                  //  CST                     CHAR(3),
                    QuotedStr(TVendaDetalheVO(ListaVenda.Items[i]).Cancelado)+ '|'+            //  CANCELADO               CHAR(1),
                    QuotedStr(TVendaDetalheVO(ListaVenda.Items[i]).MovimentaEstoque)+ '|'+     //  MOVIMENTA_ESTOQUE       CHAR(1),
                    QuotedStr(TVendaDetalheVO(ListaVenda.Items[i]).ECFIcmsST)+ '|'+            //  ECF_ICMS_ST             VARCHAR(4),
                    QuotedStr(TVendaDetalheVO(ListaVenda.Items[i]).HashTripa)+ '|'+            //  HASH_TRIPA              VARCHAR(32),
                    IntToStr(TVendaDetalheVO(ListaVenda.Items[i]).HashIncremento)+ '|');       //  HASH_INCREMENTO         INTEGER,
                                                                                               //  DATA_SINCRONIZACAO      DATE,
                                                                                               //  HORA_SINCRONIZACAO      VARCHAR(8)


      Writeln(atvenda);
      Application.ProcessMessages;
    end;

    ListaTotalTipoPagamento := TTotalTipoPagamentoController.RetornaMeiosPagamentoDaUltimaVenda(VendaCabecalho.id);
    Application.ProcessMessages;

    for i := 0 to ListaTotalTipoPagamento.Count - 1 do
    begin
      Write(atvenda,'TTP|'+                                                                                         // ECF_TOTAL_TIPO_PGTO (
                    Identificacao+'T'+IntToStr(TTotalTipoPagamentoVO(ListaTotalTipoPagamento.Items[i]).id)+
                    'P'+IntToStr(TTotalTipoPagamentoVO(ListaTotalTipoPagamento.Items[i]).IdTipoPagamento)+'|'+      //  ID                      INTEGER NOT NULL,
                    QuotedStr(Configuracao.NomeCaixa)+'|'+                                                          //  NOME_CAIXA              VARCHAR(30),
                    IntToStr(TTotalTipoPagamentoVO(ListaTotalTipoPagamento.Items[i]).id)+ '|'+                      //  ID_GERADO_CAIXA         INTEGER,
                    IntToStr(Configuracao.IdEmpresa)+ '|'+                                                          //  ID_EMPRESA              INTEGER,
                    IntToStr(TTotalTipoPagamentoVO(ListaTotalTipoPagamento.Items[i]).IdVenda)+ '|'+                 //  ID_ECF_VENDA_CABECALHO  INTEGER,
                    IntToStr(TTotalTipoPagamentoVO(ListaTotalTipoPagamento.Items[i]).IdTipoPagamento)+ '|'+         //  ID_ECF_TIPO_PAGAMENTO   INTEGER,
                    QuotedStr(TTotalTipoPagamentoVO(ListaTotalTipoPagamento.Items[i]).SerieEcf)+ '|'+               //  SERIE_ECF               VARCHAR(20),
                    IntToStr(TTotalTipoPagamentoVO(ListaTotalTipoPagamento.Items[i]).Coo)+ '|'+                     //  COO                     INTEGER,
                    IntToStr(TTotalTipoPagamentoVO(ListaTotalTipoPagamento.Items[i]).Ccf)+ '|'+                     //  CCF                     INTEGER,
                    IntToStr(TTotalTipoPagamentoVO(ListaTotalTipoPagamento.Items[i]).Gnf)+ '|'+                     //  GNF                     INTEGER,
                    FloatToStr(TTotalTipoPagamentoVO(ListaTotalTipoPagamento.Items[i]).Valor)+ '|'+                 //  VALOR                   DECIMAL(18,6),
                    QuotedStr(TTotalTipoPagamentoVO(ListaTotalTipoPagamento.Items[i]).NSU)+ '|'+                    //  NSU                     VARCHAR(30),
                    QuotedStr(TTotalTipoPagamentoVO(ListaTotalTipoPagamento.Items[i]).Estorno)+ '|'+                //  ESTORNO                 CHAR(1),
                    QuotedStr(TTotalTipoPagamentoVO(ListaTotalTipoPagamento.Items[i]).Rede)+ '|'+                   //  REDE                    VARCHAR(10),
                    QuotedStr(TTotalTipoPagamentoVO(ListaTotalTipoPagamento.Items[i]).CartaoDebitoOuCredito)+ '|'+  //  CARTAO_DC               CHAR(1),
                    QuotedStr(TTotalTipoPagamentoVO(ListaTotalTipoPagamento.Items[i]).HashTripa)+ '|'+              //  HASH_TRIPA              VARCHAR(32),
                    IntToStr(TTotalTipoPagamentoVO(ListaTotalTipoPagamento.Items[i]).HashIncremento)+ '|');         //  HASH_INCREMENTO         INTEGER,
                                                                                                                    //  DATA_SINCRONIZACAO      DATE,
                                                                                                                    //  HORA_SINCRONIZACAO      VARCHAR(8)



      Writeln(atvenda);
      Application.ProcessMessages;
    end;

    idVendaParcela := VendaCabecalho.id;
    ParcelaCabecalho := TParcelaController.RetornaCabecalhoDaParcela(idVendaParcela);
    if idVendaParcela > 0 then
    begin
      Write(atvenda,'CPR|'+
                    Identificacao+'Q'+IntToStr(ParcelaCabecalho.QuantidadeParcela)+ '|'+    //   ID,

                    IntToStr(ParcelaCabecalho.IdPlanoContas)+ '|'+       // ID_PLANO_CONTAS      INTEGER NOT NULL,
                    IntToStr(ParcelaCabecalho.IdPessoa)+ '|'+            // ID_PESSOA            INTEGER NOT NULL,
                    IntToStr(ParcelaCabecalho.IdTipoDocumento)+ '|'+     // ID_TIPO_DOCUMENTO    INTEGER NOT NULL,
                    QuotedStr(ParcelaCabecalho.Tipo)+ '|'+               // TIPO                 CHAR(1),
                    QuotedStr(ParcelaCabecalho.NumeroDocumento)+ '|'+    // NUMERO_DOCUMENTO     VARCHAR(20),
                    FloatToStr(ParcelaCabecalho.Valor)+ '|'+             // VALOR                DECIMAL(18,6),
                    QuotedStr(ParcelaCabecalho.DataLancamento)+ '|'+     // DATA_LANCAMENTO      DATE,
                    QuotedStr(ParcelaCabecalho.PrimeiroVencimento)+ '|'+ // PRIMEIRO_VENCIMENTO  DATE,
                    QuotedStr(ParcelaCabecalho.NaturezaLancamento)+ '|'+ // NATUREZA_LANCAMENTO  CHAR(1),
                    IntToStr(ParcelaCabecalho.QuantidadeParcela)+ '|');  // QUANTIDADE_PARCELA   INTEGER

      Writeln(atvenda);

      TotalParcelado := ParcelaCabecalho.Valor;
      ListaParcela := TParcelaController.RetornaDetalheDaParcela(ParcelaCabecalho.Id);

      for i := 0 to ListaParcela.Count - 1 do
      begin
        Write(atvenda,'PAR|'+
                            Identificacao+'P'+intToStr(TContasParcelasVO(ListaParcela.Items[i]).NumeroParcela)+
                            intToStr(TContasParcelasVO(ListaParcela.Items[i]).id)+ '|'+                    //   ID,
                            ParcelaCabecalho.NumeroDocumento+ '|'+

                         //   intToStr(TContasParcelasVO(ListaParcela.Items[i]).IdChequeEmitido)+ '|'+        //   ID_CHEQUE_EMITIDO        INTEGER,
                         //   intToStr(TContasParcelasVO(ListaParcela.Items[i]).IdContaCaixa)+ '|'+           //   ID_CONTA_CAIXA           INTEGER,
                         //   intToStr(TContasParcelasVO(ListaParcela.Items[i]).IdMeiosPagamento)+ '|'+       //   ID_MEIOS_PAGAMENTO       INTEGER,
                         //   intToStr(TContasParcelasVO(ListaParcela.Items[i]).IdContasPagarReceber)+ '|'+   //   ID_CONTAS_PAGAR_RECEBER  INTEGER NOT NULL,
                            QuotedStr(TContasParcelasVO(ListaParcela.Items[i]).DataEmissao)+ '|'+           //   DATA_EMISSAO,        DATA_EMISSAO             DATE,
                            QuotedStr(TContasParcelasVO(ListaParcela.Items[i]).DataVencimento)+ '|'+        //   DATA_VENCIMENTO,     DATA_VENCIMENTO          DATE,
                            intToStr(TContasParcelasVO(ListaParcela.Items[i]).NumeroParcela)+ '|'+          //   NUMERO_PARCELA,      NUMERO_PARCELA           INTEGER,
                            FloatToStr(TContasParcelasVO(ListaParcela.Items[i]).Valor)+ '|'+                //   VALOR,               VALOR                    DECIMAL(18,6),
                            FloatToStr(TContasParcelasVO(ListaParcela.Items[i]).TaxaJuros)+ '|'+            //   TAXA_JUROS,          TAXA_JUROS               DECIMAL(18,6),
                            FloatToStr(TContasParcelasVO(ListaParcela.Items[i]).TaxaMulta)+ '|'+            //   TAXA_MULTA,          TAXA_MULTA               DECIMAL(18,6),
                            FloatToStr(TContasParcelasVO(ListaParcela.Items[i]).TaxaDesconto)+ '|'+         //   TAXA_DESCONTO,       TAXA_DESCONTO            DECIMAL(18,6),
                            FloatToStr(TContasParcelasVO(ListaParcela.Items[i]).ValorJuros)+ '|'+           //   VALOR_JUROS,         VALOR_JUROS              DECIMAL(18,6),
                            FloatToStr(TContasParcelasVO(ListaParcela.Items[i]).ValorMulta)+ '|'+           //   VALOR_MULTA,         VALOR_MULTA              DECIMAL(18,6),
                            FloatToStr(TContasParcelasVO(ListaParcela.Items[i]).ValorDesconto)+ '|'+        //   VALOR_DESCONTO,      VALOR_DESCONTO           DECIMAL(18,6),
                            FloatToStr(TContasParcelasVO(ListaParcela.Items[i]).TotalParcela)+ '|'+         //   TOTAL_PARCELA,       TOTAL_PARCELA            DECIMAL(18,6),
                            QuotedStr(TContasParcelasVO(ListaParcela.Items[i]).Historico)+ '|'+             //   HISTORICO,           HISTORICO                BLOB_TEXT /* BLOB_TEXT = BLOB SUB_TYPE 1 SEGMENT SIZE 1024 */,
                            QuotedStr(TContasParcelasVO(ListaParcela.Items[i]).Situacao)+ '|');             //   SITUACAO);           SITUACAO                 CHAR(1)


        Writeln(atvenda);
        Application.ProcessMessages;
      end;

      Writeln(atvenda);
      DecimalSeparator := ',';
      Application.ProcessMessages;
      ImprimeParcelasECF(NomeCliente, CPFCNPJ, Cupom, TotalParcelado, ListaParcela);
    end;

    CloseFile(atvenda);

  finally
    if Assigned(VendaCabecalho) then
      FreeAndNil(VendaCabecalho);

    if Assigned(ListaVenda) then
      FreeAndNil(ListaVenda);

    if Assigned(ListaTotalTipoPagamento) then
      FreeAndNil(ListaTotalTipoPagamento);

    if Assigned(ParcelaCabecalho) then
      FreeAndNil(ParcelaCabecalho);

    if Assigned(ListaParcela) then
      FreeAndNil(ListaParcela);

    Result := True;
    DecimalSeparator := ',';
    Application.ProcessMessages;
  end;
end;


function TFCargaPDV.ExportaTabela(PathTabela: String): Boolean;
var
  Lista: TStringList;
  atTabela: TextFile;
  i: Integer;
begin
  try
    PathVenda := ExtractFilePath(Application.ExeName)+'Script\'+'C'+IntToStr(Configuracao.IdCaixa)+'E'+IntToStr(Configuracao.IdEmpresa)+'-'+FormatDateTime('dd-mm-yyyy',now)+'.txt';
    Application.ProcessMessages;
    if FileExists(PathTabela)  then
    begin
      if FileExists(PathVenda) then
      begin
        try
          Lista := TStringList.Create;
          Lista.LoadFromFile(PathTabela);
          AssignFile(atTabela,PathVenda);
          Application.ProcessMessages;
          Append(atTabela);
          for i := 0 to Lista.Count - 1 do
          begin
            Writeln(atTabela,Lista.Strings[i]);
            Application.ProcessMessages;
          end;
        finally
          Lista.Free;
          CloseFile(atTabela);
        end;
      end else
        CopyFile(Pchar(PathTabela),pchar(PathVenda),false);
    end;
  finally
    Result := True;
    Application.ProcessMessages;
  end;
end;

procedure TFCargaPDV.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:=caFree;
  FCargaPDV:=nil;
end;

procedure TFCargaPDV.FormShow(Sender: TObject);
begin
  ForceDirectories(ExtractFilePath(Application.ExeName)+'Script');
  Timer1.Enabled:=True;
end;

procedure TFCargaPDV.ImprimeParcelasECF(Nome, CPF, COO: String; TotalParcela: Currency; ListaParcela: TObjectList<TContasParcelasVO>);
begin
  if (Configuracao.ImprimeParcelas =1) and (Assigned(ListaParcela)) then
  begin
    TParcelaController.ImprimeParcelas(Nome, CPF, COO, TotalParcela, ListaParcela);
  end;
end;

procedure TFCargaPDV.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled := false;

  try
    case Tipo of
      0:
      begin
        if ImportaCarga(FCaixa.PathCarga) then
        begin
          UCaixa.CargaOk := True;
          if (DeleteFile(FCaixa.PathSemaforo)) and (DeleteFile(FCaixa.PathCarga)) then  // habilitar para produção
          begin
            FCaixa.TimeIntegracao.Enabled := True;
          end;
        end;
      end;

      1:
      begin
        if ExportaCarga(FCaixa.PathCarga) then
        begin
           if CopyFile(PChar(ExtractFilePath(Application.ExeName)+'ArquivoAuxiliar.ini'), PChar(FDataModule.RemoteAppPath+'Semaforo'), False) then
             if CopyFile(PChar(PathVenda), PChar(FDataModule.RemoteAppPath+'C'+IntToStr(Configuracao.IdCaixa)+'E'+IntToStr(Configuracao.IdEmpresa)+'-'+FormatDateTime('dd-mm-yyyy',now)+'.txt'), False) then
             begin
               Application.ProcessMessages;
               DeleteFile(PChar(FDataModule.RemoteAppPath+'Semaforo'));
             end;
          FCaixa.TimeIntegracao.Enabled := True;
        end;
      end;

      2:
      begin
        if ExportaCancelamentoCupom(FCaixa.PathCarga) then
        begin
           if CopyFile(PChar(ExtractFilePath(Application.ExeName)+'ArquivoAuxiliar.ini'), PChar(FDataModule.RemoteAppPath+'Semaforo'), False) then
             if CopyFile(PChar(PathVenda), PChar(FDataModule.RemoteAppPath+'C'+IntToStr(Configuracao.IdCaixa)+'E'+IntToStr(Configuracao.IdEmpresa)+'-'+FormatDateTime('dd-mm-yyyy',now)+'.txt'), False) then
             begin
               Application.ProcessMessages;
               DeleteFile(PChar(FDataModule.RemoteAppPath+'Semaforo'));
             end;
          FCaixa.TimeIntegracao.Enabled := True;
        end;
      end;

      3:
      begin
        if ExportaTabela(ExtractFilePath(Application.ExeName)+'Script\'+NomeArquivo)then
        begin
          if CopyFile(PChar(ExtractFilePath(Application.ExeName)+'ArquivoAuxiliar.ini'), PChar(FDataModule.RemoteAppPath+'Semaforo'), False) then
             if CopyFile(PChar(PathVenda), PChar(FDataModule.RemoteAppPath+'C'+IntToStr(Configuracao.IdCaixa)+'E'+IntToStr(Configuracao.IdEmpresa)+'-'+FormatDateTime('dd-mm-yyyy',now)+'.txt'), False) then
             begin
               Application.ProcessMessages;
               DeleteFile(PChar(FDataModule.RemoteAppPath+'Semaforo'));
             end;
          DeleteFile(ExtractFilePath(Application.ExeName)+'Script\'+NomeArquivo);
          Application.ProcessMessages;
        end;
      end;

      4:
      begin
        if ImportaCarga(FPenDrive.editPath.Text+'\carga.txt') then
        begin
          ShowMessage('Arquivo '+FPenDrive.editPath.Text+'\carga.txt'+#13+'Importado com sucesso!');
        end;
      end;

      5:
      begin
        TProdutoController.AtualizaEstoque;
      end;

    end;

  finally
    FCaixa.labelMensagens.Caption := 'CAIXA ABERTO';
    Application.ProcessMessages;
    Close;
  end;
end;

end.
