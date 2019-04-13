{*******************************************************************************
Title: T2Ti ERP                                                                 
Description:  VO  relacionado à tabela [FIN_LANCAMENTO_PAGAR] 
                                                                                
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
unit FinLancamentoPagarVO;

interface

uses
  JsonVO, Atributos, Classes, Constantes, Generics.Collections, DBXJSON, DBXJSONReflect,
  SysUtils, FornecedorPessoaVO, FinParcelaPagarVO, FinDocumentoOrigemVO, FinLctoPagarNtFinanceiraVO;

type
  [TEntity]
  [TTable('FIN_LANCAMENTO_PAGAR')]
  TFinLancamentoPagarVO = class(TJsonVO)
  private
    FID: Integer;
    FID_FIN_DOCUMENTO_ORIGEM: Integer;
    FID_FORNECEDOR: Integer;
    FPAGAMENTO_COMPARTILHADO: String;
    FQUANTIDADE_PARCELA: Integer;
    FVALOR_TOTAL: Extended;
    FVALOR_A_PAGAR: Extended;
    FDATA_LANCAMENTO: TDateTime;
    FNUMERO_DOCUMENTO: String;
    FIMAGEM_DOCUMENTO: String;
    FPRIMEIRO_VENCIMENTO: TDateTime;
    FCODIGO_MODULO_LCTO: String;
    FINTERVALO_ENTRE_PARCELAS: Integer;

    FFornecedorPessoaNome: String;
    FDocumentoOrigemSigla: String;

    FFornecedorVO: TFornecedorVO;
    FDocumentoOrigemVO: TFinDocumentoOrigemVO;

    FListaParcelaPagarVO: TObjectList<TFinParcelaPagarVO>;
    FListaLancPagarNatFinanceiraVO: TObjectList<TFinLctoPagarNtFinanceiraVO>;

  public 
    constructor Create; overload; override;
    constructor Create(pJsonValue: TJSONValue); overload; override;
    destructor Destroy; override;
    function ToJSON: TJSONValue; override;

    [TId('ID')]
    [TGeneratedValue(sAuto)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property Id: Integer  read FID write FID;

    [TColumn('ID_FORNECEDOR','Id Fornecedor',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdFornecedor: Integer  read FID_FORNECEDOR write FID_FORNECEDOR;
    [TColumn('FORNECEDOR.PESSOA.NOME', 'Fornecedor', 250, [ldGrid, ldLookup, ldComboBox], True, 'FORNECEDOR', 'ID_FORNECEDOR', 'ID')]
    property FornecedorPessoaNome: String read FFornecedorPessoaNome write FFornecedorPessoaNome;

    [TColumn('ID_FIN_DOCUMENTO_ORIGEM','Id Documento Origem',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdFinDocumentoOrigem: Integer  read FID_FIN_DOCUMENTO_ORIGEM write FID_FIN_DOCUMENTO_ORIGEM;
    [TColumn('FIN_DOCUMENTO_ORIGEM.SIGLA', 'Sigla Documento', 60, [ldGrid, ldLookup, ldComboBox], True, 'FIN_DOCUMENTO_ORIGEM', 'ID_FIN_DOCUMENTO_ORIGEM', 'ID')]
    property DocumentoOrigemSigla: String read FDocumentoOrigemSigla write FDocumentoOrigemSigla;

    [TColumn('PAGAMENTO_COMPARTILHADO','Pagamento Compartilhado',8,[ldGrid, ldLookup, ldCombobox], False)]
    property PagamentoCompartilhado: String  read FPAGAMENTO_COMPARTILHADO write FPAGAMENTO_COMPARTILHADO;
    [TColumn('QUANTIDADE_PARCELA','Quantidade Parcela',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property QuantidadeParcela: Integer  read FQUANTIDADE_PARCELA write FQUANTIDADE_PARCELA;
    [TColumn('VALOR_TOTAL','Valor Total',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property ValorTotal: Extended  read FVALOR_TOTAL write FVALOR_TOTAL;
    [TColumn('VALOR_A_PAGAR','Valor A Pagar',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property ValorAPagar: Extended  read FVALOR_A_PAGAR write FVALOR_A_PAGAR;
    [TColumn('DATA_LANCAMENTO','Data Lancamento',80,[ldGrid, ldLookup, ldCombobox], False)]
    property DataLancamento: TDateTime  read FDATA_LANCAMENTO write FDATA_LANCAMENTO;
    [TColumn('NUMERO_DOCUMENTO','Numero Documento',400,[ldGrid, ldLookup, ldCombobox], False)]
    property NumeroDocumento: String  read FNUMERO_DOCUMENTO write FNUMERO_DOCUMENTO;
    [TColumn('IMAGEM_DOCUMENTO','Imagem Documento',450,[ldGrid, ldLookup, ldCombobox], False)]
    property ImagemDocumento: String  read FIMAGEM_DOCUMENTO write FIMAGEM_DOCUMENTO;
    [TColumn('PRIMEIRO_VENCIMENTO','Primeiro Vencimento',80,[ldGrid, ldLookup, ldCombobox], False)]
    property PrimeiroVencimento: TDateTime  read FPRIMEIRO_VENCIMENTO write FPRIMEIRO_VENCIMENTO;
    [TColumn('INTERVALO_ENTRE_PARCELAS','Intervalo Entre Parcelas',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IntervaloEntreParcelas: Integer  read FINTERVALO_ENTRE_PARCELAS write FINTERVALO_ENTRE_PARCELAS;
    [TColumn('CODIGO_MODULO_LCTO','Codigo Modulo Lcto',24,[ldGrid, ldLookup, ldCombobox], False)]
    property CodigoModuloLcto: String  read FCODIGO_MODULO_LCTO write FCODIGO_MODULO_LCTO;

    [TAssociation(True, 'ID', 'ID_FORNECEDOR', 'FORNECEDOR')]
    property FornecedorVO: TFornecedorVO read FFornecedorVO write FFornecedorVO;

    [TAssociation(False, 'ID', 'ID_FIN_DOCUMENTO_ORIGEM', 'DOCUMENTO_ORIGEM')]
    property DocumentoOrigemVO: TFinDocumentoOrigemVO read FDocumentoOrigemVO write FDocumentoOrigemVO;

    [TManyValuedAssociation(True,'ID_FIN_LANCAMENTO_PAGAR','ID')]
    property ListaParcelaPagarVO: TObjectList<TFinParcelaPagarVO> read FListaParcelaPagarVO write FListaParcelaPagarVO;

    [TManyValuedAssociation(True,'ID_FIN_LANCAMENTO_PAGAR','ID')]
    property ListaLancPagarNatFinanceiraVO: TObjectList<TFinLctoPagarNtFinanceiraVO> read FListaLancPagarNatFinanceiraVO write FListaLancPagarNatFinanceiraVO;

  end;

implementation

constructor TFinLancamentoPagarVO.Create;
begin
  inherited;
  ListaParcelaPagarVO := TObjectList<TFinParcelaPagarVO>.Create;
  ListaLancPagarNatFinanceiraVO := TObjectList<TFinLctoPagarNtFinanceiraVO>.Create;
end;

constructor TFinLancamentoPagarVO.Create(pJsonValue: TJSONValue);
var
  Deserializa: TJSONUnMarshal;
begin
  if pJsonValue is TJSONNull then
    Exception.Create('Erro ao criar objeto com um valor nulo.');

  Deserializa := TJSONUnMarshal.Create;
  try
    Self.Free;

    //Lista Parcelas
    Deserializa.RegisterReverter(TFinLancamentoPagarVO, 'FListaParcelaPagarVO', procedure(Data: TObject; Field: String; Args: TListOfObjects)
    var
      Obj: TObject;
    begin
      if not Assigned(TFinLancamentoPagarVO(Data).FListaParcelaPagarVO) then
        TFinLancamentoPagarVO(Data).FListaParcelaPagarVO := TObjectList<TFinParcelaPagarVO>.Create;

      for Obj in Args do
      begin
        TFinLancamentoPagarVO(Data).FListaParcelaPagarVO.Add(TFinParcelaPagarVO(Obj));
      end
    end);

    //Lista Lancamento Pagar Natureza Financeira
    Deserializa.RegisterReverter(TFinLancamentoPagarVO, 'FListaLancPagarNatFinanceiraVO', procedure(Data: TObject; Field: String; Args: TListOfObjects)
    var
      Obj: TObject;
    begin
      if not Assigned(TFinLancamentoPagarVO(Data).FListaLancPagarNatFinanceiraVO) then
        TFinLancamentoPagarVO(Data).FListaLancPagarNatFinanceiraVO := TObjectList<TFinLctoPagarNtFinanceiraVO>.Create;

      for Obj in Args do
      begin
        TFinLancamentoPagarVO(Data).FListaLancPagarNatFinanceiraVO.Add(TFinLctoPagarNtFinanceiraVO(Obj));
      end
    end);

    Self := Deserializa.Unmarshal(pJsonValue) as TFinLancamentoPagarVO;
  finally
    Deserializa.Free;
  end;
end;

destructor TFinLancamentoPagarVO.Destroy;
begin
  ListaParcelaPagarVO.Free;
  ListaLancPagarNatFinanceiraVO.Free;

  if Assigned(FFornecedorVO) then
    FFornecedorVO.Free;

  if Assigned(FDocumentoOrigemVO) then
    FDocumentoOrigemVO.Free;

  inherited;
end;

function TFinLancamentoPagarVO.ToJSON: TJSONValue;
var
  Serializa: TJSONMarshal;
begin
  Serializa := TJSONMarshal.Create(TJSONConverter.Create);
  try
    //Lista Parcelas
    Serializa.RegisterConverter(TFinLancamentoPagarVO, 'FListaParcelaPagarVO', function(Data: TObject; Field: string): TListOfObjects
      var
        I: Integer;
      begin
        if Assigned(TFinLancamentoPagarVO(Data).FListaParcelaPagarVO) then
        begin
          SetLength(Result, TFinLancamentoPagarVO(Data).FListaParcelaPagarVO.Count);
          for I := 0 to TFinLancamentoPagarVO(Data).FListaParcelaPagarVO.Count - 1 do
          begin
            Result[I] := TFinLancamentoPagarVO(Data).FListaParcelaPagarVO.Items[I];
          end;
        end;
      end);

    //Lista Lancamento Pagar Natureza Financeira
    Serializa.RegisterConverter(TFinLancamentoPagarVO, 'FListaLancPagarNatFinanceiraVO', function(Data: TObject; Field: string): TListOfObjects
      var
        I: Integer;
      begin
        if Assigned(TFinLancamentoPagarVO(Data).FListaLancPagarNatFinanceiraVO) then
        begin
          SetLength(Result, TFinLancamentoPagarVO(Data).FListaLancPagarNatFinanceiraVO.Count);
          for I := 0 to TFinLancamentoPagarVO(Data).FListaLancPagarNatFinanceiraVO.Count - 1 do
          begin
            Result[I] := TFinLancamentoPagarVO(Data).FListaLancPagarNatFinanceiraVO.Items[I];
          end;
        end;
      end);

    // Campos Transientes
    if Assigned(Self.FornecedorVO) then
      Self.FornecedorPessoaNome := Self.FornecedorVO.PessoaVO.Nome;
    if Assigned(Self.DocumentoOrigemVO) then
      Self.DocumentoOrigemSigla := Self.DocumentoOrigemVO.SiglaDocumento;

  Exit(serializa.Marshal(Self));
  finally
    Serializa.Free;
  end;
end;


end.
