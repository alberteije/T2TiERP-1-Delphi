{*******************************************************************************
Title: T2Ti ERP                                                                 
Description:  VO transiente para confirmar a cotação de compras
relacionado à tabela [COMPRA_FORNECEDOR_COTACAO]
                                                                                
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
unit CompraConfirmaFornecedorCotacaoVO;

interface

uses
  JsonVO, Atributos, Classes, Constantes, Generics.Collections, DBXJSON, DBXJSONReflect,
  SysUtils, FornecedorPessoaVO, CompraCotacaoDetalheVO;

type
  [TEntity]
  [TTable('COMPRA_FORNECEDOR_COTACAO')]
  TCompraConfirmaFornecedorCotacaoVO = class(TJsonVO)
  private
    FID: Integer;
    FID_COMPRA_COTACAO: Integer;
    FID_FORNECEDOR: Integer;
    FPRAZO_ENTREGA: String;
    FCONDICOES_PAGAMENTO: String;
    FVALOR_SUBTOTAL: Extended;
    FTAXA_DESCONTO: Extended;
    FVALOR_DESCONTO: Extended;
    FTOTAL: Extended;

    FFornecedorPessoaNome: String;

    FFornecedorVO: TFornecedorVO;

    FListaCompraCotacaoDetalheVO: TObjectList<TCompraCotacaoDetalheVO>;

  public
    constructor Create; overload; override;
    constructor Create(pJsonValue: TJSONValue); overload; override;
    destructor Destroy; override;
    function ToJSON: TJSONValue; override;

    [TId('ID')]
    [TGeneratedValue(sAuto)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property Id: Integer  read FID write FID;
    [TColumn('ID_COMPRA_COTACAO','Id Compra Cotacao',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdCompraCotacao: Integer  read FID_COMPRA_COTACAO write FID_COMPRA_COTACAO;

    [TColumn('ID_FORNECEDOR','Id Fornecedor',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdFornecedor: Integer  read FID_FORNECEDOR write FID_FORNECEDOR;
    [TColumn('FORNECEDOR.PESSOA.NOME', 'Requisitante', 250, [ldGrid, ldLookup, ldComboBox], True, 'FORNECEDOR', 'ID_FORNECEDOR', 'ID')]
    property FornecedorPessoaNome: String read FFornecedorPessoaNome write FFornecedorPessoaNome;

    [TColumn('PRAZO_ENTREGA','Prazo Entrega',240,[ldGrid, ldLookup, ldCombobox], False)]
    property PrazoEntrega: String  read FPRAZO_ENTREGA write FPRAZO_ENTREGA;
    [TColumn('CONDICOES_PAGAMENTO','Condicoes Pagamento',240,[ldGrid, ldLookup, ldCombobox], False)]
    property CondicoesPagamento: String  read FCONDICOES_PAGAMENTO write FCONDICOES_PAGAMENTO;
    [TColumn('VALOR_SUBTOTAL','Valor Subtotal',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property ValorSubtotal: Extended  read FVALOR_SUBTOTAL write FVALOR_SUBTOTAL;
    [TColumn('TAXA_DESCONTO','Taxa Desconto',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property TaxaDesconto: Extended  read FTAXA_DESCONTO write FTAXA_DESCONTO;
    [TColumn('VALOR_DESCONTO','Valor Desconto',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property ValorDesconto: Extended  read FVALOR_DESCONTO write FVALOR_DESCONTO;
    [TColumn('TOTAL','Total',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property Total: Extended  read FTOTAL write FTOTAL;

    [TAssociation(True, 'ID', 'ID_FORNECEDOR', 'FORNECEDOR')]
    property FornecedorVO: TFornecedorVO read FFornecedorVO write FFornecedorVO;

    [TManyValuedAssociation(False,'ID_COMPRA_FORNECEDOR_COTACAO','ID')]
    property ListaCompraCotacaoDetalheVO: TObjectList<TCompraCotacaoDetalheVO> read FListaCompraCotacaoDetalheVO write FListaCompraCotacaoDetalheVO;

  end;

implementation

constructor TCompraConfirmaFornecedorCotacaoVO.Create;
begin
  inherited;
  ListaCompraCotacaoDetalheVO := TObjectList<TCompraCotacaoDetalheVO>.Create;
end;

constructor TCompraConfirmaFornecedorCotacaoVO.Create(pJsonValue: TJSONValue);
var
  Deserializa: TJSONUnMarshal;
begin
  if pJsonValue is TJSONNull then
    Exception.Create('Erro ao criar objeto com um valor nulo.');

  Deserializa := TJSONUnMarshal.Create;
  try
    Self.Free;

    Deserializa.RegisterReverter(TCompraConfirmaFornecedorCotacaoVO, 'FListaCompraCotacaoDetalheVO', procedure(Data: TObject; Field: String; Args: TListOfObjects)
    var
      Obj: TObject;
    begin
  	  if not Assigned(TCompraConfirmaFornecedorCotacaoVO(Data).FListaCompraCotacaoDetalheVO) then
        TCompraConfirmaFornecedorCotacaoVO(Data).FListaCompraCotacaoDetalheVO := TObjectList<TCompraCotacaoDetalheVO>.Create;

      for Obj in Args do
      begin
        TCompraConfirmaFornecedorCotacaoVO(Data).FListaCompraCotacaoDetalheVO.Add(TCompraCotacaoDetalheVO(Obj));
      end
    end);

    Self := Deserializa.Unmarshal(pJsonValue) as TCompraConfirmaFornecedorCotacaoVO;
  finally
    Deserializa.Free;
  end;
end;

destructor TCompraConfirmaFornecedorCotacaoVO.Destroy;
begin
  ListaCompraCotacaoDetalheVO.Free;
  if Assigned(FFornecedorVO) then
    FFornecedorVO.Free;
  inherited;
end;

function TCompraConfirmaFornecedorCotacaoVO.ToJSON: TJSONValue;
var
  Serializa: TJSONMarshal;
begin
  Serializa := TJSONMarshal.Create(TJSONConverter.Create);
  try

    Serializa.RegisterConverter(TCompraConfirmaFornecedorCotacaoVO, 'FListaCompraCotacaoDetalheVO', function(Data: TObject; Field: string): TListOfObjects
      var
        I: Integer;
      begin
        if Assigned(TCompraConfirmaFornecedorCotacaoVO(Data).FListaCompraCotacaoDetalheVO) then
        begin
          SetLength(Result, TCompraConfirmaFornecedorCotacaoVO(Data).FListaCompraCotacaoDetalheVO.Count);
          for I := 0 to TCompraConfirmaFornecedorCotacaoVO(Data).FListaCompraCotacaoDetalheVO.Count - 1 do
          begin
            Result[I] := TCompraConfirmaFornecedorCotacaoVO(Data).FListaCompraCotacaoDetalheVO.Items[I];
          end;
        end;
      end);

    if Assigned(Self.FornecedorVO) then
      Self.FornecedorPessoaNome := Self.FornecedorVO.PessoaVO.Nome;

  Exit(serializa.Marshal(Self));
  finally
    Serializa.Free;
  end;
end;

end.
