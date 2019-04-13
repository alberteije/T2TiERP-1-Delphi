{*******************************************************************************
Title: T2Ti ERP
Description:  VO  relacionado à tabela [VENDA_CABECALHO]

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

t2ti.com@gmail.com | fernandololiver@gmail.com
@author Albert Eije (T2Ti.COM) | Fernando L Oliveira
@version 1.0
*******************************************************************************}
unit VendaCabecalhoVO;

interface

uses
  JsonVO, Atributos, Classes, Constantes, Generics.Collections, DBXJSON, DBXJSONReflect,
  SysUtils, TransportadoraPessoaVO, TipoNotaFiscalVO, ClientePessoaVO, VendedorVO,
  VendaCondicoesPagamentoVO, VendaOrcamentoCabecalhoVO, VendaDetalheVO, VendaComissaoVO;

type
  [TEntity]
  [TTable('VENDA_CABECALHO')]
  TVendaCabecalhoVO = class(TJsonVO)
  private
    FID: Integer;
    FID_TRANSPORTADORA: Integer;
    FID_TIPO_NOTA_FISCAL: Integer;
    FID_CLIENTE: Integer;
    FID_VENDEDOR: Integer;
    FID_CONDICOES_PAGAMENTO: Integer;
    FID_ORCAMENTO_VENDA_CABECALHO: Integer;
    FID_VENDA_ROMANEIO_ENTREGA: Integer;
    FDATA_VENDA: TDateTime;
    FDATA_SAIDA: TDateTime;
    FHORA_SAIDA: String;
    FNUMERO_FATURA: Integer;
    FLOCAL_ENTREGA: String;
    FLOCAL_COBRANCA: String;
    FVALOR_SUBTOTAL: Extended;
    FTAXA_COMISSAO: Extended;
    FVALOR_COMISSAO: Extended;
    FTAXA_DESCONTO: Extended;
    FVALOR_DESCONTO: Extended;
    FVALOR_TOTAL: Extended;
    FTIPO_FRETE: String;
    FFORMA_PAGAMENTO: String;
    FVALOR_FRETE: Extended;
    FVALOR_SEGURO: Extended;
    FOBSERVACAO: String;
    FSITUACAO: String;

    FTransportadoraNome: String;
    FTipoNotaFiscalModelo: String;
    FClienteNome: String;
    FVendedorNome: String;
    FVendaCondicoesPagamentoNome: String;
    FVendaOrcamentoCabecalhoCodigo: String;

    FTransportadoraVO: TTransportadoraVO;
    FTipoNotaFiscalVO: TTipoNotaFiscalVO;
    FClienteVO: TClienteVO;
    FVendedorVO: TVendedorVO;
    FVendaCondicoesPagamentoVO: TVendaCondicoesPagamentoVO;
    FVendaOrcamentoCabecalhoVO: TVendaOrcamentoCabecalhoVO;
    FVendaComissaoVO: TVendaComissaoVO;

    FListaVendaDetalheVO: TObjectList<TVendaDetalheVO>;

  public
    constructor Create; overload; override;
    constructor Create(pJsonValue: TJSONValue); overload; override;
    destructor Destroy; override;
    function ToJSON: TJSONValue; override;

    [TId('ID')]
    [TGeneratedValue(sAuto)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property Id: Integer  read FID write FID;

    //Romaneio
    [TColumn('ID_VENDA_ROMANEIO_ENTREGA','Id Romaneio',80,[], False)]
    property IdVendaRomaneioEntrega: Integer  read FID_VENDA_ROMANEIO_ENTREGA write FID_VENDA_ROMANEIO_ENTREGA;

    //Transportadora
    [TColumn('ID_TRANSPORTADORA','Id Transportadora',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdTransportadora: Integer  read FID_TRANSPORTADORA write FID_TRANSPORTADORA;
    [TColumn('TRANSPORTADORA.NOME', 'Transportadora Nome', 300, [ldGrid, ldLookup, ldComboBox], True, 'TRANSPORTADORA', 'ID_TRANSPORTADORA', 'ID')]
    property TransportadoraNome: String read FTransportadoraNome write FTransportadoraNome;

    //Tipo NOta Fiscal
    [TColumn('ID_TIPO_NOTA_FISCAL','Id Tipo Nota Fiscal',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdTipoNotaFiscal: Integer  read FID_TIPO_NOTA_FISCAL write FID_TIPO_NOTA_FISCAL;
    [TColumn('TIPONOTAFISCAL.MODELO', 'Tipo Nota Fiscal', 90, [ldGrid, ldLookup, ldComboBox], True, 'TIPO_NOTA_FISCAL', 'ID_TIPO_NOTA_FISCAL', 'ID')]
    property TipoNotaFiscalModelo: String read FTipoNotaFiscalModelo write FTipoNotaFiscalModelo;

    //Cliente
    [TColumn('ID_CLIENTE','Id Cliente',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdCliente: Integer  read FID_CLIENTE write FID_CLIENTE;
    [TColumn('CLIENTE.NOME', 'Cliente Nome', 300, [ldGrid, ldLookup, ldComboBox], True, 'CLIENTE', 'ID_CLIENTE', 'ID')]
    property ClienteNome: String read FClienteNome write FClienteNome;

    //Vendedor
    [TColumn('ID_VENDEDOR','Id Vendedor',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdVendedor: Integer  read FID_VENDEDOR write FID_VENDEDOR;
    [TColumn('VENDEDOR.NOME', 'Vendedor Nome', 300, [ldGrid, ldLookup, ldComboBox], True, 'VENDEDOR', 'ID_VENDEDOR', 'ID')]
    property VendedorNome: String read FVendedorNome write FVendedorNome;

    //Condições Pagamento
    [TColumn('ID_VENDA_CONDICOES_PAGAMENTO','Id Condicoes Pagamento',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdVendaCondicoesPagamento: Integer  read FID_CONDICOES_PAGAMENTO write FID_CONDICOES_PAGAMENTO;
    [TColumn('CONDICOESPAGAMENTO.NOME', 'Condições Pagamento', 100, [ldGrid, ldLookup, ldComboBox], True, 'VENDA_CONDICOES_PAGAMENTO', 'ID_VENDA_CONDICOES_PAGAMENTO', 'ID')]
    property VendaCondicoesPagamentoNome: String read FVendaCondicoesPagamentoNome write FVendaCondicoesPagamentoNome;

    //Orçamento Venda Cabeclaho
    [TColumn('ID_VENDA_ORCAMENTO_CABECALHO','Id Orcamento Venda Cabecalho',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdOrcamentoVendaCabecalho: Integer  read FID_ORCAMENTO_VENDA_CABECALHO write FID_ORCAMENTO_VENDA_CABECALHO;
    [TColumn('ORCAMENTO_VENDA_CABECALHO.CODIGO', 'Código Orçamento', 300, [ldGrid, ldLookup, ldComboBox], True, 'VENDA_ORCAMENTO_CABECALHO', 'ID_VENDA_ORCAMENTO_CABECALHO', 'ID')]
    property VendaOrcamentoCabecalhoCodigo: String read FVendaOrcamentoCabecalhoCodigo write FVendaOrcamentoCabecalhoCodigo;


    [TColumn('DATA_VENDA','Data Venda',80,[ldGrid, ldLookup, ldCombobox], False)]
    property DataVenda: TDateTime  read FDATA_VENDA write FDATA_VENDA;
    [TColumn('DATA_SAIDA','Data Saída',80,[ldGrid, ldLookup, ldCombobox], False)]
    property DataSaida: TDateTime  read FDATA_SAIDA write FDATA_SAIDA;
    [TColumn('HORA_SAIDA','Hora Saída',64,[ldGrid, ldLookup, ldCombobox], False)]
    property HoraSaida: String  read FHORA_SAIDA write FHORA_SAIDA;
    [TColumn('NUMERO_FATURA','Número Fatura',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property NumeroFatura: Integer  read FNUMERO_FATURA write FNUMERO_FATURA;
    [TColumn('LOCAL_ENTREGA','Local Entrega',450,[ldGrid, ldLookup, ldCombobox], False)]
    property LocalEntrega: String  read FLOCAL_ENTREGA write FLOCAL_ENTREGA;
    [TColumn('LOCAL_COBRANCA','Local Cobrança',450,[ldGrid, ldLookup, ldCombobox], False)]
    property LocalCobranca: String  read FLOCAL_COBRANCA write FLOCAL_COBRANCA;
    [TColumn('VALOR_SUBTOTAL','Valor Subtotal',128,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property ValorSubtotal: Extended  read FVALOR_SUBTOTAL write FVALOR_SUBTOTAL;
    [TColumn('TAXA_COMISSAO','Taxa Comissão',128,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property TaxaComissao: Extended  read FTAXA_COMISSAO write FTAXA_COMISSAO;
    [TColumn('VALOR_COMISSAO','Valor Comissão',128,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property ValorComissao: Extended  read FVALOR_COMISSAO write FVALOR_COMISSAO;
    [TColumn('TAXA_DESCONTO','Taxa Desconto',128,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property TaxaDesconto: Extended  read FTAXA_DESCONTO write FTAXA_DESCONTO;
    [TColumn('VALOR_DESCONTO','Valor Desconto',128,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property ValorDesconto: Extended  read FVALOR_DESCONTO write FVALOR_DESCONTO;
    [TColumn('VALOR_TOTAL','Valor Total',128,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property ValorTotal: Extended  read FVALOR_TOTAL write FVALOR_TOTAL;
    [TColumn('TIPO_FRETE','Tipo Frete',8,[ldGrid, ldLookup, ldCombobox], False)]
    property TipoFrete: String  read FTIPO_FRETE write FTIPO_FRETE;
    [TColumn('FORMA_PAGAMENTO','Forma Pagamento',8,[ldGrid, ldLookup, ldCombobox], False)]
    property FormaPagamento: String  read FFORMA_PAGAMENTO write FFORMA_PAGAMENTO;
    [TColumn('VALOR_FRETE','Valor Frete',128,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property ValorFrete: Extended  read FVALOR_FRETE write FVALOR_FRETE;
    [TColumn('VALOR_SEGURO','Valor Seguro',128,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property ValorSeguro: Extended  read FVALOR_SEGURO write FVALOR_SEGURO;
    [TColumn('OBSERVACAO','Observação',450,[ldGrid, ldLookup, ldCombobox], False)]
    property Observacao: String  read FOBSERVACAO write FOBSERVACAO;
    [TColumn('SITUACAO','Situacao',8,[ldGrid, ldLookup, ldCombobox], False)]
    property Situacao: String  read FSITUACAO write FSITUACAO;

    [TAssociation(True, 'ID', 'ID_TRANSPORTADORA', 'TRANSPORTADORA')]
    property TransportadoraVO: TTransportadoraVO read FTransportadoraVO write FTransportadoraVO;

    [TAssociation(False, 'ID', 'ID_TIPO_NOTA_FISCAL', 'TIPO_NOTA_FISCAL')]
    property TipoNotaFiscalVO: TTipoNotaFiscalVO read FTipoNotaFiscalVO write FTipoNotaFiscalVO;

    [TAssociation(True, 'ID', 'ID_CLIENTE', 'CLIENTE')]
    property ClienteVO: TClienteVO read FClienteVO write FClienteVO;

    [TAssociation(True, 'ID', 'ID_VENDEDOR', 'VENDEDOR')]
    property VendedorVO: TVendedorVO read FVendedorVO write FVendedorVO;

    [TAssociation(False, 'ID', 'ID_VENDA_CONDICOES_PAGAMENTO', 'VENDA_CONDICOES_PAGAMENTO')]
    property VendaCondicoesPagamentoVO: TVendaCondicoesPagamentoVO read FVendaCondicoesPagamentoVO write FVendaCondicoesPagamentoVO;

    [TAssociation(False, 'ID', 'ID_VENDA_ORCAMENTO_CABECALHO', 'VENDA_ORCAMENTO_CABECALHO')]
    property VendaOrcamentoCabecalhoVO: TVendaOrcamentoCabecalhoVO read FVendaOrcamentoCabecalhoVO write FVendaOrcamentoCabecalhoVO;

    [TAssociation(False, 'ID', 'ID_VENDA_CABECALHO', 'VENDA_COMISSAO')]
    property VendaComissaoVO: TVendaComissaoVO read FVendaComissaoVO write FVendaComissaoVO;

    [TManyValuedAssociation(False,'ID_VENDA_CABECALHO','ID')]
    property ListaVendaDetalheVO: TObjectList<TVendaDetalheVO> read FListaVendaDetalheVO write FListaVendaDetalheVO;

  end;

implementation

constructor TVendaCabecalhoVO.Create;
begin
  inherited;
  ListaVendaDetalheVO := TObjectList<TVendaDetalheVO>.Create;
end;

constructor TVendaCabecalhoVO.Create(pJsonValue: TJSONValue);
var
  Deserializa: TJSONUnMarshal;
begin
  if pJsonValue is TJSONNull then
    Exception.Create('Erro ao criar objeto com um valor nulo.');

  Deserializa := TJSONUnMarshal.Create;
  try
    Self.Free;

    //Lista Venda Detalhe
    Deserializa.RegisterReverter(TVendaCabecalhoVO, 'FListaVendaDetalheVO', procedure(Data: TObject; Field: String; Args: TListOfObjects)
    var
      Obj: TObject;
    begin
      if not Assigned(TVendaCabecalhoVO(Data).FListaVendaDetalheVO) then
        TVendaCabecalhoVO(Data).FListaVendaDetalheVO := TObjectList<TVendaDetalheVO>.Create;

      for Obj in Args do
      begin
        TVendaCabecalhoVO(Data).FListaVendaDetalheVO.Add(TVendaDetalheVO(Obj));
      end
    end);

    Self := Deserializa.Unmarshal(pJsonValue) as TVendaCabecalhoVO;
  finally
    Deserializa.Free;
  end;
end;

destructor TVendaCabecalhoVO.Destroy;
begin
  ListaVendaDetalheVO.Free;

  if Assigned(FTransportadoraVO) then
    FTransportadoraVO.Free;
  if Assigned(FTipoNotaFiscalVO) then
    FTipoNotaFiscalVO.Free;
  if Assigned(FClienteVO) then
    FClienteVO.Free;
  if Assigned(FVendedorVO) then
    FVendedorVO.Free;
  if Assigned(FVendaCondicoesPagamentoVO) then
    FVendaCondicoesPagamentoVO.Free;
  if Assigned(FVendaOrcamentoCabecalhoVO) then
    FVendaOrcamentoCabecalhoVO.Free;
  if Assigned(FVendaComissaoVO) then
    FVendaComissaoVO.Free;

  inherited;
end;

function TVendaCabecalhoVO.ToJSON: TJSONValue;
var
  Serializa: TJSONMarshal;
begin
  Serializa := TJSONMarshal.Create(TJSONConverter.Create);
  try
    //Lista Venda Detalhe
    Serializa.RegisterConverter(TVendaCabecalhoVO, 'FListaVendaDetalheVO', function(Data: TObject; Field: string): TListOfObjects
      var
        I: Integer;
      begin
        if Assigned(TVendaCabecalhoVO(Data).FListaVendaDetalheVO) then
        begin
          SetLength(Result, TVendaCabecalhoVO(Data).FListaVendaDetalheVO.Count);
          for I := 0 to TVendaCabecalhoVO(Data).FListaVendaDetalheVO.Count - 1 do
          begin
            Result[I] := TVendaCabecalhoVO(Data).FListaVendaDetalheVO.Items[I];
          end;
        end;
      end);

    // Campos Transientes
     if Assigned(Self.TransportadoraVO) then
       Self.TransportadoraNome := Self.TransportadoraVO.PessoaVO.Nome;
     if Assigned(Self.TipoNotaFiscalVO) then
       Self.TipoNotaFiscalModelo := Self.TipoNotaFiscalVO.Modelo;
     if Assigned(Self.ClienteVO) then
       Self.ClienteNome := Self.ClienteVO.PessoaVO.Nome;
     if Assigned(Self.VendedorVO) then
       Self.VendedorNome := Self.VendedorVO.ColaboradorVO.PessoaVO.Nome;
     if Assigned(Self.VendaCondicoesPagamentoVO) then
       Self.VendaCondicoesPagamentoNome := Self.VendaCondicoesPagamentoVO.Nome;
     if Assigned(Self.VendaOrcamentoCabecalhoVO) then
      Self.FVendaOrcamentoCabecalhoCodigo := Self.VendaOrcamentoCabecalhoVO.Codigo;


  Exit(serializa.Marshal(Self));
  finally
    Serializa.Free;
  end;
end;


end.
