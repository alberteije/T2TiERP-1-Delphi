{*******************************************************************************
Title: T2Ti ERP                                                                 
Description:  VO  relacionado à tabela [VENDA_ORCAMENTO_CABECALHO] 
                                                                                
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
           t2ti.com@gmail.com                                                   
                                                                                
@author Albert Eije (t2ti.com@gmail.com)                    
@version 1.0                                                                    
*******************************************************************************}
unit VendaOrcamentoCabecalhoVO;

interface

uses
  JsonVO, Atributos, Classes, Constantes, Generics.Collections, DBXJSON, DBXJSONReflect,
  SysUtils, VendedorVO, TransportadoraPessoaVO, ClientePessoaVO, VendaCondicoesPagamentoVO,
  VendaOrcamentoDetalheVO;
type
  [TEntity]
  [TTable('VENDA_ORCAMENTO_CABECALHO')]
  TVendaOrcamentoCabecalhoVO = class(TJsonVO)
  private
    FID: Integer;
    FID_VENDA_CONDICOES_PAGAMENTO: Integer;
    FID_VENDEDOR: Integer;
    FID_TRANSPORTADORA: Integer;
    FID_CLIENTE: Integer;
    FTIPO: String;
    FCODIGO: String;
    FDATA_CADASTRO: TDateTime;
    FDATA_ENTREGA: TDateTime;
    FVALIDADE: TDateTime;
    FTIPO_FRETE: String;
    FVALOR_SUBTOTAL: Extended;
    FVALOR_FRETE: Extended;
    FTAXA_COMISSAO: Extended;
    FVALOR_COMISSAO: Extended;
    FTAXA_DESCONTO: Extended;
    FVALOR_DESCONTO: Extended;
    FVALOR_TOTAL: Extended;
    FOBSERVACAO: String;
    FSITUACAO: String;

    FVendedorNome: String;
    FTransportadoraNome: String;
    FClienteNome: String;
    FVendaCondicoesPagamentoNome: String;

    FVendedorVO: TVendedorVO;
    FTransportadoraVO: TTransportadoraVO;
    FClienteVO: TClienteVO;
    FVendaCondicoesPagamentoVO: TVendaCondicoesPagamentoVO;

    FListaVendaOrcamentoDetalheVO: TObjectList<TVendaOrcamentoDetalheVO>;

  public
    constructor Create; overload; override;
    constructor Create(pJsonValue: TJSONValue); overload; override;
    destructor Destroy; override;
    function ToJSON: TJSONValue; override;

    [TId('ID')]
    [TGeneratedValue(sAuto)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property Id: Integer  read FID write FID;

    [TColumn('ID_VENDEDOR','Id Vendedor',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdVendedor: Integer  read FID_VENDEDOR write FID_VENDEDOR;
    [TColumn('VENDEDOR.NOME', 'Vendedor Nome', 300, [ldGrid, ldLookup, ldComboBox], True, 'VENDEDOR', 'ID_VENDEDOR', 'ID')]
    property VendedorNome: String read FVendedorNome write FVendedorNome;

    [TColumn('ID_TRANSPORTADORA','Id Transportadora',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdTransportadora: Integer  read FID_TRANSPORTADORA write FID_TRANSPORTADORA;
    [TColumn('TRANSPORTADORA.NOME', 'Transportadora Nome', 300, [ldGrid, ldLookup, ldComboBox], True, 'TRANSPORTADORA', 'ID_TRANSPORTADORA', 'ID')]
    property TransportadoraNome: String read FTransportadoraNome write FTransportadoraNome;

    [TColumn('ID_CLIENTE','Id Cliente',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdCliente: Integer  read FID_CLIENTE write FID_CLIENTE;
    [TColumn('CLIENTE.NOME', 'Cliente Nome', 300, [ldGrid, ldLookup, ldComboBox], True, 'CLIENTE', 'ID_CLIENTE', 'ID')]
    property ClienteNome: String read FClienteNome write FClienteNome;

    [TColumn('ID_VENDA_CONDICOES_PAGAMENTO','Id Condicoes Pagamento',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdVendaCondicoesPagamento: Integer  read FID_VENDA_CONDICOES_PAGAMENTO write FID_VENDA_CONDICOES_PAGAMENTO;
    [TColumn('CONDICOESPAGAMENTO.NOME', 'Condições Pagamento', 300, [ldGrid, ldLookup, ldComboBox], True, 'VENDA_CONDICOES_PAGAMENTO', 'ID_VENDA_CONDICOES_PAGAMENTO', 'ID')]
    property VendaCondicoesPagamentoNome: String read FVendaCondicoesPagamentoNome write FVendaCondicoesPagamentoNome;

    [TColumn('TIPO','Tipo',8,[ldGrid, ldLookup, ldCombobox], False)]
    property Tipo: String  read FTIPO write FTIPO;
    [TColumn('CODIGO','Codigo',160,[ldGrid, ldLookup, ldCombobox], False)]
    property Codigo: String  read FCODIGO write FCODIGO;
    [TColumn('DATA_CADASTRO','Data Cadastro',80,[ldGrid, ldLookup, ldCombobox], False)]
    property DataCadastro: TDateTime  read FDATA_CADASTRO write FDATA_CADASTRO;
    [TColumn('DATA_ENTREGA','Data Entrega',80,[ldGrid, ldLookup, ldCombobox], False)]
    property DataEntrega: TDateTime  read FDATA_ENTREGA write FDATA_ENTREGA;
    [TColumn('VALIDADE','Validade',80,[ldGrid, ldLookup, ldCombobox], False)]
    property Validade: TDateTime  read FVALIDADE write FVALIDADE;
    [TColumn('TIPO_FRETE','Tipo Frete',8,[ldGrid, ldLookup, ldCombobox], False)]
    property TipoFrete: String  read FTIPO_FRETE write FTIPO_FRETE;
    [TColumn('VALOR_SUBTOTAL','Valor Subtotal',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property ValorSubtotal: Extended  read FVALOR_SUBTOTAL write FVALOR_SUBTOTAL;
    [TColumn('VALOR_FRETE','Valor Frete',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property ValorFrete: Extended  read FVALOR_FRETE write FVALOR_FRETE;
    [TColumn('TAXA_COMISSAO','Taxa Comissao',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property TaxaComissao: Extended  read FTAXA_COMISSAO write FTAXA_COMISSAO;
    [TColumn('VALOR_COMISSAO','Valor Comissao',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property ValorComissao: Extended  read FVALOR_COMISSAO write FVALOR_COMISSAO;
    [TColumn('TAXA_DESCONTO','Taxa Desconto',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property TaxaDesconto: Extended  read FTAXA_DESCONTO write FTAXA_DESCONTO;
    [TColumn('VALOR_DESCONTO','Valor Desconto',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property ValorDesconto: Extended  read FVALOR_DESCONTO write FVALOR_DESCONTO;
    [TColumn('VALOR_TOTAL','Valor Total',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property ValorTotal: Extended  read FVALOR_TOTAL write FVALOR_TOTAL;
    [TColumn('OBSERVACAO','Observacao',450,[ldGrid, ldLookup, ldCombobox], False)]
    property Observacao: String  read FOBSERVACAO write FOBSERVACAO;
    [TColumn('SITUACAO','Situacao',8,[ldGrid, ldLookup, ldCombobox], False)]
    property Situacao: String  read FSITUACAO write FSITUACAO;

    [TAssociation(True, 'ID', 'ID_VENDEDOR', 'VENDEDOR')]
    property VendedorVO: TVendedorVO read FVendedorVO write FVendedorVO;

    [TAssociation(True, 'ID', 'ID_TRANSPORTADORA', 'TRANSPORTADORA')]
    property TransportadoraVO: TTransportadoraVO read FTransportadoraVO write FTransportadoraVO;

    [TAssociation(True, 'ID', 'ID_CLIENTE', 'CLIENTE')]
    property ClienteVO: TClienteVO read FClienteVO write FClienteVO;

    [TAssociation(False, 'ID', 'ID_VENDA_CONDICOES_PAGAMENTO', 'VENDA_CONDICOES_PAGAMENTO')]
    property VendaCondicoesPagamentoVO: TVendaCondicoesPagamentoVO read FVendaCondicoesPagamentoVO write FVendaCondicoesPagamentoVO;

    [TManyValuedAssociation(False,'ID_VENDA_ORCAMENTO_CABECALHO','ID')]
    property ListaVendaOrcamentoDetalheVO: TObjectList<TVendaOrcamentoDetalheVO> read FListaVendaOrcamentoDetalheVO write FListaVendaOrcamentoDetalheVO;

  end;

implementation

constructor TVendaOrcamentoCabecalhoVO.Create;
begin
  inherited;
  ListaVendaOrcamentoDetalheVO := TObjectList<TVendaOrcamentoDetalheVO>.Create;
end;

constructor TVendaOrcamentoCabecalhoVO.Create(pJsonValue: TJSONValue);
var
  Deserializa: TJSONUnMarshal;
begin
  if pJsonValue is TJSONNull then
    Exception.Create('Erro ao criar objeto com um valor nulo.');

  Deserializa := TJSONUnMarshal.Create;
  try
    Self.Free;

    //Lista Orçamento Pedido Venda
    Deserializa.RegisterReverter(TVendaOrcamentoCabecalhoVO, 'FListaVendaOrcamentoDetalheVO', procedure(Data: TObject; Field: String; Args: TListOfObjects)
    var
      Obj: TObject;
    begin
      if not Assigned(TVendaOrcamentoCabecalhoVO(Data).FListaVendaOrcamentoDetalheVO) then
        TVendaOrcamentoCabecalhoVO(Data).FListaVendaOrcamentoDetalheVO := TObjectList<TVendaOrcamentoDetalheVO>.Create;

      for Obj in Args do
      begin
        TVendaOrcamentoCabecalhoVO(Data).FListaVendaOrcamentoDetalheVO.Add(TVendaOrcamentoDetalheVO(Obj));
      end
    end);

    Self := Deserializa.Unmarshal(pJsonValue) as TVendaOrcamentoCabecalhoVO;
  finally
    Deserializa.Free;
  end;
end;

destructor TVendaOrcamentoCabecalhoVO.Destroy;
begin
  ListaVendaOrcamentoDetalheVO.Free;

  if Assigned(FVendedorVO) then
    FVendedorVO.Free;
  if Assigned(FTransportadoraVO) then
    FTransportadoraVO.Free;
  if Assigned(FClienteVO) then
    FClienteVO.Free;
  if Assigned(FVendaCondicoesPagamentoVO) then
    FVendaCondicoesPagamentoVO.Free;

  inherited;
end;

function TVendaOrcamentoCabecalhoVO.ToJSON: TJSONValue;
var
  Serializa: TJSONMarshal;
begin
  Serializa := TJSONMarshal.Create(TJSONConverter.Create);
  try
    //Lista Orçamento Pedido Venda
    Serializa.RegisterConverter(TVendaOrcamentoCabecalhoVO, 'FListaVendaOrcamentoDetalheVO', function(Data: TObject; Field: string): TListOfObjects
      var
        I: Integer;
      begin
        if Assigned(TVendaOrcamentoCabecalhoVO(Data).FListaVendaOrcamentoDetalheVO) then
        begin
          SetLength(Result, TVendaOrcamentoCabecalhoVO(Data).FListaVendaOrcamentoDetalheVO.Count);
          for I := 0 to TVendaOrcamentoCabecalhoVO(Data).FListaVendaOrcamentoDetalheVO.Count - 1 do
          begin
            Result[I] := TVendaOrcamentoCabecalhoVO(Data).FListaVendaOrcamentoDetalheVO.Items[I];
          end;
        end;
      end);

    // Campos Transientes
    if Assigned(Self.VendedorVO) then
      Self.VendedorNome := Self.VendedorVO.ColaboradorVO.PessoaVO.Nome;
    if Assigned(Self.TransportadoraVO) then
      Self.TransportadoraNome := Self.TransportadoraVO.PessoaVO.Nome;
    if Assigned(Self.ClienteVO) then
      Self.ClienteNome := Self.ClienteVO.PessoaVO.Nome;
    if Assigned(Self.VendaCondicoesPagamentoVO) then
      Self.VendaCondicoesPagamentoNome := Self.VendaCondicoesPagamentoVO.Nome;

  Exit(serializa.Marshal(Self));
  finally
    Serializa.Free;
  end;
end;


end.
