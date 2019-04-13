{*******************************************************************************
Title: T2Ti ERP                                                                 
Description:  VO  relacionado à tabela [FIN_LANCAMENTO_RECEBER] 
                                                                                
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
unit FinLancamentoReceberVO;

interface

uses
  JsonVO, Atributos, Classes, Constantes, Generics.Collections, DBXJSON, DBXJSONReflect,
  SysUtils, ClientePessoaVO, FinParcelaReceberVO, FinDocumentoOrigemVO, FinLctoReceberNtFinanceiraVO;

type
  [TEntity]
  [TTable('FIN_LANCAMENTO_RECEBER')]
  TFinLancamentoReceberVO = class(TJsonVO)
  private
    FID: Integer;
    FID_FIN_DOCUMENTO_ORIGEM: Integer;
    FID_CLIENTE: Integer;
    FQUANTIDADE_PARCELA: Integer;
    FVALOR_TOTAL: Extended;
    FVALOR_A_RECEBER: Extended;
    FDATA_LANCAMENTO: TDateTime;
    FNUMERO_DOCUMENTO: String;
    FPRIMEIRO_VENCIMENTO: TDateTime;
    FTAXA_COMISSAO: Extended;
    FVALOR_COMISSAO: Extended;
    FINTERVALO_ENTRE_PARCELAS: Integer;
    FCODIGO_MODULO_LCTO: String;

    FClientePessoaNome: String;
    FDocumentoOrigemSigla: String;

    FClienteVO: TClienteVO;
    FDocumentoOrigemVO: TFinDocumentoOrigemVO;

    FListaParcelaReceberVO: TObjectList<TFinParcelaReceberVO>;
    FListaLancReceberNatFinanceiraVO: TObjectList<TFinLctoReceberNtFinanceiraVO>;
	
  public 
    constructor Create; overload; override;
    constructor Create(pJsonValue: TJSONValue); overload; override;
    destructor Destroy; override;
    function ToJSON: TJSONValue; override;
  
    [TId('ID')]
    [TGeneratedValue(sAuto)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property Id: Integer  read FID write FID;
	
    [TColumn('ID_CLIENTE','Id Cliente',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdCliente: Integer  read FID_CLIENTE write FID_CLIENTE;
    [TColumn('CLIENTE.PESSOA.NOME', 'Cliente', 250, [ldGrid, ldLookup, ldComboBox], True, 'CLIENTE', 'ID_CLIENTE', 'ID')]
    property ClientePessoaNome: String read FClientePessoaNome write FClientePessoaNome;

    [TColumn('ID_FIN_DOCUMENTO_ORIGEM','Id Documento Origem',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdFinDocumentoOrigem: Integer  read FID_FIN_DOCUMENTO_ORIGEM write FID_FIN_DOCUMENTO_ORIGEM;
    [TColumn('FIN_DOCUMENTO_ORIGEM.SIGLA', 'Sigla Documento', 60, [ldGrid, ldLookup, ldComboBox], True, 'FIN_DOCUMENTO_ORIGEM', 'ID_FIN_DOCUMENTO_ORIGEM', 'ID')]
    property DocumentoOrigemSigla: String read FDocumentoOrigemSigla write FDocumentoOrigemSigla;

    [TColumn('QUANTIDADE_PARCELA','Quantidade Parcela',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property QuantidadeParcela: Integer  read FQUANTIDADE_PARCELA write FQUANTIDADE_PARCELA;
    [TColumn('VALOR_TOTAL','Valor Total',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property ValorTotal: Extended  read FVALOR_TOTAL write FVALOR_TOTAL;
    [TColumn('VALOR_A_RECEBER','Valor A Receber',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property ValorAReceber: Extended  read FVALOR_A_RECEBER write FVALOR_A_RECEBER;
    [TColumn('DATA_LANCAMENTO','Data Lancamento',80,[ldGrid, ldLookup, ldCombobox], False)]
    property DataLancamento: TDateTime  read FDATA_LANCAMENTO write FDATA_LANCAMENTO;
    [TColumn('NUMERO_DOCUMENTO','Numero Documento',400,[ldGrid, ldLookup, ldCombobox], False)]
    property NumeroDocumento: String  read FNUMERO_DOCUMENTO write FNUMERO_DOCUMENTO;
    [TColumn('PRIMEIRO_VENCIMENTO','Primeiro Vencimento',80,[ldGrid, ldLookup, ldCombobox], False)]
    property PrimeiroVencimento: TDateTime  read FPRIMEIRO_VENCIMENTO write FPRIMEIRO_VENCIMENTO;
    [TColumn('TAXA_COMISSAO','Taxa Comissao',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property TaxaComissao: Extended  read FTAXA_COMISSAO write FTAXA_COMISSAO;
    [TColumn('VALOR_COMISSAO','Valor Comissao',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property ValorComissao: Extended  read FVALOR_COMISSAO write FVALOR_COMISSAO;
    [TColumn('INTERVALO_ENTRE_PARCELAS','Intervalo Entre Parcelas',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IntervaloEntreParcelas: Integer  read FINTERVALO_ENTRE_PARCELAS write FINTERVALO_ENTRE_PARCELAS;
    [TColumn('CODIGO_MODULO_LCTO','Codigo Modulo Lcto',24,[ldGrid, ldLookup, ldCombobox], False)]
    property CodigoModuloLcto: String  read FCODIGO_MODULO_LCTO write FCODIGO_MODULO_LCTO;

    [TAssociation(True, 'ID', 'ID_CLIENTE', 'CLIENTE')]
    property ClienteVO: TClienteVO read FClienteVO write FClienteVO;

    [TAssociation(False, 'ID', 'ID_FIN_DOCUMENTO_ORIGEM', 'DOCUMENTO_ORIGEM')]
    property DocumentoOrigemVO: TFinDocumentoOrigemVO read FDocumentoOrigemVO write FDocumentoOrigemVO;

    [TManyValuedAssociation(True,'ID_FIN_LANCAMENTO_Receber','ID')]
    property ListaParcelaReceberVO: TObjectList<TFinParcelaReceberVO> read FListaParcelaReceberVO write FListaParcelaReceberVO;

    [TManyValuedAssociation(True,'ID_FIN_LANCAMENTO_Receber','ID')]
    property ListaLancReceberNatFinanceiraVO: TObjectList<TFinLctoReceberNtFinanceiraVO> read FListaLancReceberNatFinanceiraVO write FListaLancReceberNatFinanceiraVO;
	
  end;

implementation

constructor TFinLancamentoReceberVO.Create;
begin
  inherited;
  ListaParcelaReceberVO := TObjectList<TFinParcelaReceberVO>.Create;
  ListaLancReceberNatFinanceiraVO := TObjectList<TFinLctoReceberNtFinanceiraVO>.Create;
end;

constructor TFinLancamentoReceberVO.Create(pJsonValue: TJSONValue);
var
  Deserializa: TJSONUnMarshal;
begin
  if pJsonValue is TJSONNull then
    Exception.Create('Erro ao criar objeto com um valor nulo.');

  Deserializa := TJSONUnMarshal.Create;
  try
    Self.Free;

    //Lista Parcelas
    Deserializa.RegisterReverter(TFinLancamentoReceberVO, 'FListaParcelaReceberVO', procedure(Data: TObject; Field: String; Args: TListOfObjects)
    var
      Obj: TObject;
    begin
      if not Assigned(TFinLancamentoReceberVO(Data).FListaParcelaReceberVO) then
        TFinLancamentoReceberVO(Data).FListaParcelaReceberVO := TObjectList<TFinParcelaReceberVO>.Create;

      for Obj in Args do
      begin
        TFinLancamentoReceberVO(Data).FListaParcelaReceberVO.Add(TFinParcelaReceberVO(Obj));
      end
    end);

    //Lista Lancamento Receber Natureza Financeira
    Deserializa.RegisterReverter(TFinLancamentoReceberVO, 'FListaLancReceberNatFinanceiraVO', procedure(Data: TObject; Field: String; Args: TListOfObjects)
    var
      Obj: TObject;
    begin
      if not Assigned(TFinLancamentoReceberVO(Data).FListaLancReceberNatFinanceiraVO) then
        TFinLancamentoReceberVO(Data).FListaLancReceberNatFinanceiraVO := TObjectList<TFinLctoReceberNtFinanceiraVO>.Create;

      for Obj in Args do
      begin
        TFinLancamentoReceberVO(Data).FListaLancReceberNatFinanceiraVO.Add(TFinLctoReceberNtFinanceiraVO(Obj));
      end
    end);

    Self := Deserializa.Unmarshal(pJsonValue) as TFinLancamentoReceberVO;
  finally
    Deserializa.Free;
  end;
end;

destructor TFinLancamentoReceberVO.Destroy;
begin
  ListaParcelaReceberVO.Free;
  ListaLancReceberNatFinanceiraVO.Free;

  if Assigned(FClienteVO) then
    FClienteVO.Free;

  if Assigned(FDocumentoOrigemVO) then
    FDocumentoOrigemVO.Free;

  inherited;
end;

function TFinLancamentoReceberVO.ToJSON: TJSONValue;
var
  Serializa: TJSONMarshal;
begin
  Serializa := TJSONMarshal.Create(TJSONConverter.Create);
  try
    //Lista Parcelas
    Serializa.RegisterConverter(TFinLancamentoReceberVO, 'FListaParcelaReceberVO', function(Data: TObject; Field: string): TListOfObjects
      var
        I: Integer;
      begin
        if Assigned(TFinLancamentoReceberVO(Data).FListaParcelaReceberVO) then
        begin
          SetLength(Result, TFinLancamentoReceberVO(Data).FListaParcelaReceberVO.Count);
          for I := 0 to TFinLancamentoReceberVO(Data).FListaParcelaReceberVO.Count - 1 do
          begin
            Result[I] := TFinLancamentoReceberVO(Data).FListaParcelaReceberVO.Items[I];
          end;
        end;
      end);

    //Lista Lancamento Receber Natureza Financeira
    Serializa.RegisterConverter(TFinLancamentoReceberVO, 'FListaLancReceberNatFinanceiraVO', function(Data: TObject; Field: string): TListOfObjects
      var
        I: Integer;
      begin
        if Assigned(TFinLancamentoReceberVO(Data).FListaLancReceberNatFinanceiraVO) then
        begin
          SetLength(Result, TFinLancamentoReceberVO(Data).FListaLancReceberNatFinanceiraVO.Count);
          for I := 0 to TFinLancamentoReceberVO(Data).FListaLancReceberNatFinanceiraVO.Count - 1 do
          begin
            Result[I] := TFinLancamentoReceberVO(Data).FListaLancReceberNatFinanceiraVO.Items[I];
          end;
        end;
      end);

    // Campos Transientes
    if Assigned(Self.ClienteVO) then
      Self.ClientePessoaNome := Self.ClienteVO.PessoaVO.Nome;
    if Assigned(Self.DocumentoOrigemVO) then
      Self.DocumentoOrigemSigla := Self.DocumentoOrigemVO.SiglaDocumento;

  Exit(serializa.Marshal(Self));
  finally
    Serializa.Free;
  end;
end;



end.
