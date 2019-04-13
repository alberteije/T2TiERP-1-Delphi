{*******************************************************************************
Title: T2Ti ERP                                                                 
Description:  VO  relacionado à tabela [NFE_DETALHE] 
                                                                                
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
unit NfeDetalheVO;

interface

uses
  JsonVO, Atributos, Classes, Constantes, Generics.Collections, DBXJSON, DBXJSONReflect,
  SysUtils, NfeDeclaracaoImportacaoVO, NfeDetEspecificoVeiculoVO, NfeDetEspecificoMedicamentoVO,
  NfeDetEspecificoArmamentoVO, NfeDetEspecificoCombustivelVO, NfeDetalheImpostoIcmsVO,
  NfeDetalheImpostoIpiVO, NfeDetalheImpostoIiVO, NfeDetalheImpostoPisVO,
  NfeDetalheImpostoCofinsVO, NfeDetalheImpostoIssqnVO;

type
  [TEntity]
  [TTable('NFE_DETALHE')]
  TNfeDetalheVO = class(TJsonVO)
  private
    FID: Integer;
    FID_PRODUTO: Integer;
    FID_NFE_CABECALHO: Integer;
    FNUMERO_ITEM: Integer;
    FCODIGO_PRODUTO: String;
    FGTIN: String;
    FNOME_PRODUTO: String;
    FNCM: String;
    FEX_TIPI: Integer;
    FCFOP: Integer;
    FUNIDADE_COMERCIAL: String;
    FQUANTIDADE_COMERCIAL: Extended;
    FVALOR_UNITARIO_COMERCIAL: Extended;
    FVALOR_BRUTO_PRODUTO: Extended;
    FGTIN_UNIDADE_TRIBUTAVEL: String;
    FUNIDADE_TRIBUTAVEL: String;
    FQUANTIDADE_TRIBUTAVEL: Extended;
    FVALOR_UNITARIO_TRIBUTAVEL: Extended;
    FVALOR_FRETE: Extended;
    FVALOR_SEGURO: Extended;
    FVALOR_DESCONTO: Extended;
    FVALOR_OUTRAS_DESPESAS: Extended;
    FENTRA_TOTAL: String;
    FVALOR_SUBTOTAL: Extended;
    FVALOR_TOTAL: Extended;
    FNUMERO_PEDIDO_COMPRA: String;
    FITEM_PEDIDO_COMPRA: Integer;
    FINFORMACOES_ADICIONAIS: String;

    FNfeDetEspecificoVeiculoVO: TNfeDetEspecificoVeiculoVO; //0:1
    FNfeDetEspecificoCombustivelVO: TNfeDetEspecificoCombustivelVO; //0:1

    FNfeDetalheImpostoIcmsVO: TNfeDetalheImpostoIcmsVO; //1:1
    FNfeDetalheImpostoIpiVO: TNfeDetalheImpostoIpiVO; //0:1
    FNfeDetalheImpostoIiVO: TNfeDetalheImpostoIiVO; //0:1
    FNfeDetalheImpostoPisVO: TNfeDetalheImpostoPisVO; //1:1
    FNfeDetalheImpostoCofinsVO: TNfeDetalheImpostoCofinsVO; //1:1
    FNfeDetalheImpostoIssqnVO: TNfeDetalheImpostoIssqnVO; //0:1

    FListaNfeDeclaracaoImportacaoVO: TObjectList<TNfeDeclaracaoImportacaoVO>; //0:100
    FListaNfeDetEspecificoMedicamentoVO: TObjectList<TNfeDetEspecificoMedicamentoVO>; //0:N
    FListaNfeDetEspecificoArmamentoVO: TObjectList<TNfeDetEspecificoArmamentoVO>; //0:N

  public 
    constructor Create; overload; override;
    constructor Create(pJsonValue: TJSONValue); overload; override;
    destructor Destroy; override;
    function ToJSON: TJSONValue; override;

    [TId('ID')]
    [TGeneratedValue(sAuto)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property Id: Integer  read FID write FID;
    [TColumn('ID_PRODUTO','Id Produto',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdProduto: Integer  read FID_PRODUTO write FID_PRODUTO;
    [TColumn('ID_NFE_CABECALHO','Id Nfe Cabecalho',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdNfeCabecalho: Integer  read FID_NFE_CABECALHO write FID_NFE_CABECALHO;
    [TColumn('NUMERO_ITEM','Numero Item',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property NumeroItem: Integer  read FNUMERO_ITEM write FNUMERO_ITEM;
    [TColumn('CODIGO_PRODUTO','Codigo Produto',450,[ldGrid, ldLookup, ldCombobox], False)]
    property CodigoProduto: String  read FCODIGO_PRODUTO write FCODIGO_PRODUTO;
    [TColumn('GTIN','Gtin',112,[ldGrid, ldLookup, ldCombobox], False)]
    property Gtin: String  read FGTIN write FGTIN;
    [TColumn('NOME_PRODUTO','Nome Produto',450,[ldGrid, ldLookup, ldCombobox], False)]
    property NomeProduto: String  read FNOME_PRODUTO write FNOME_PRODUTO;
    [TColumn('NCM','Ncm',64,[ldGrid, ldLookup, ldCombobox], False)]
    property Ncm: String  read FNCM write FNCM;
    [TColumn('EX_TIPI','Ex Tipi',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property ExTipi: Integer  read FEX_TIPI write FEX_TIPI;
    [TColumn('CFOP','Cfop',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property Cfop: Integer  read FCFOP write FCFOP;
    [TColumn('UNIDADE_COMERCIAL','Unidade Comercial',48,[ldGrid, ldLookup, ldCombobox], False)]
    property UnidadeComercial: String  read FUNIDADE_COMERCIAL write FUNIDADE_COMERCIAL;
    [TColumn('QUANTIDADE_COMERCIAL','Quantidade Comercial',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property QuantidadeComercial: Extended  read FQUANTIDADE_COMERCIAL write FQUANTIDADE_COMERCIAL;
    [TColumn('VALOR_UNITARIO_COMERCIAL','Valor Unitario Comercial',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property ValorUnitarioComercial: Extended  read FVALOR_UNITARIO_COMERCIAL write FVALOR_UNITARIO_COMERCIAL;
    [TColumn('VALOR_BRUTO_PRODUTO','Valor Bruto Produto',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property ValorBrutoProduto: Extended  read FVALOR_BRUTO_PRODUTO write FVALOR_BRUTO_PRODUTO;
    [TColumn('GTIN_UNIDADE_TRIBUTAVEL','Gtin Unidade Tributavel',112,[ldGrid, ldLookup, ldCombobox], False)]
    property GtinUnidadeTributavel: String  read FGTIN_UNIDADE_TRIBUTAVEL write FGTIN_UNIDADE_TRIBUTAVEL;
    [TColumn('UNIDADE_TRIBUTAVEL','Unidade Tributavel',48,[ldGrid, ldLookup, ldCombobox], False)]
    property UnidadeTributavel: String  read FUNIDADE_TRIBUTAVEL write FUNIDADE_TRIBUTAVEL;
    [TColumn('QUANTIDADE_TRIBUTAVEL','Quantidade Tributavel',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property QuantidadeTributavel: Extended  read FQUANTIDADE_TRIBUTAVEL write FQUANTIDADE_TRIBUTAVEL;
    [TColumn('VALOR_UNITARIO_TRIBUTAVEL','Valor Unitario Tributavel',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property ValorUnitarioTributavel: Extended  read FVALOR_UNITARIO_TRIBUTAVEL write FVALOR_UNITARIO_TRIBUTAVEL;
    [TColumn('VALOR_FRETE','Valor Frete',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property ValorFrete: Extended  read FVALOR_FRETE write FVALOR_FRETE;
    [TColumn('VALOR_SEGURO','Valor Seguro',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property ValorSeguro: Extended  read FVALOR_SEGURO write FVALOR_SEGURO;
    [TColumn('VALOR_DESCONTO','Valor Desconto',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property ValorDesconto: Extended  read FVALOR_DESCONTO write FVALOR_DESCONTO;
    [TColumn('VALOR_OUTRAS_DESPESAS','Valor Outras Despesas',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property ValorOutrasDespesas: Extended  read FVALOR_OUTRAS_DESPESAS write FVALOR_OUTRAS_DESPESAS;
    [TColumn('ENTRA_TOTAL','Entra Total',8,[ldGrid, ldLookup, ldCombobox], False)]
    property EntraTotal: String  read FENTRA_TOTAL write FENTRA_TOTAL;
    [TColumn('VALOR_SUBTOTAL','Valor Subtotal',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property ValorSubtotal: Extended  read FVALOR_SUBTOTAL write FVALOR_SUBTOTAL;
    [TColumn('VALOR_TOTAL','Valor Total',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property ValorTotal: Extended  read FVALOR_TOTAL write FVALOR_TOTAL;
    [TColumn('NUMERO_PEDIDO_COMPRA','Numero Pedido Compra',120,[ldGrid, ldLookup, ldCombobox], False)]
    property NumeroPedidoCompra: String  read FNUMERO_PEDIDO_COMPRA write FNUMERO_PEDIDO_COMPRA;
    [TColumn('ITEM_PEDIDO_COMPRA','Item Pedido Compra',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property ItemPedidoCompra: Integer  read FITEM_PEDIDO_COMPRA write FITEM_PEDIDO_COMPRA;
    [TColumn('INFORMACOES_ADICIONAIS','Informacoes Adicionais',450,[ldGrid, ldLookup, ldCombobox], False)]
    property InformacoesAdicionais: String  read FINFORMACOES_ADICIONAIS write FINFORMACOES_ADICIONAIS;

    [TAssociation(False, 'ID_NFE_DETALHE','ID')]
    property NfeDetEspecificoVeiculoVO: TNfeDetEspecificoVeiculoVO read FNfeDetEspecificoVeiculoVO write FNfeDetEspecificoVeiculoVO;

    [TAssociation(False, 'ID_NFE_DETALHE','ID')]
    property NfeDetEspecificoCombustivelVO: TNfeDetEspecificoCombustivelVO read FNfeDetEspecificoCombustivelVO write FNfeDetEspecificoCombustivelVO;

    [TAssociation(False, 'ID_NFE_DETALHE','ID')]
    property NfeDetalheImpostoIcmsVO: TNfeDetalheImpostoIcmsVO read FNfeDetalheImpostoIcmsVO write FNfeDetalheImpostoIcmsVO;

    [TAssociation(False, 'ID_NFE_DETALHE','ID')]
    property NfeDetalheImpostoIpiVO: TNfeDetalheImpostoIpiVO read FNfeDetalheImpostoIpiVO write FNfeDetalheImpostoIpiVO;

    [TAssociation(False, 'ID_NFE_DETALHE','ID')]
    property NfeDetalheImpostoIiVO: TNfeDetalheImpostoIiVO read FNfeDetalheImpostoIiVO write FNfeDetalheImpostoIiVO;

    [TAssociation(False, 'ID_NFE_DETALHE','ID')]
    property NfeDetalheImpostoPisVO: TNfeDetalheImpostoPisVO read FNfeDetalheImpostoPisVO write FNfeDetalheImpostoPisVO;

    [TAssociation(False, 'ID_NFE_DETALHE','ID')]
    property NfeDetalheImpostoCofinsVO: TNfeDetalheImpostoCofinsVO read FNfeDetalheImpostoCofinsVO write FNfeDetalheImpostoCofinsVO;

    [TAssociation(False, 'ID_NFE_DETALHE','ID')]
    property NfeDetalheImpostoIssqnVO: TNfeDetalheImpostoIssqnVO read FNfeDetalheImpostoIssqnVO write FNfeDetalheImpostoIssqnVO;

    [TManyValuedAssociation(False, 'ID_NFE_DETALHE','ID')]
    property ListaNfeDeclaracaoImportacaoVO: TObjectList<TNfeDeclaracaoImportacaoVO>read FListaNfeDeclaracaoImportacaoVO write FListaNfeDeclaracaoImportacaoVO;

    [TManyValuedAssociation(False, 'ID_NFE_DETALHE','ID')]
    property ListaNfeDetEspecificoMedicamentoVO: TObjectList<TNfeDetEspecificoMedicamentoVO>read FListaNfeDetEspecificoMedicamentoVO write FListaNfeDetEspecificoMedicamentoVO;

    [TManyValuedAssociation(False, 'ID_NFE_DETALHE','ID')]
    property ListaNfeDetEspecificoArmamentoVO: TObjectList<TNfeDetEspecificoArmamentoVO>read FListaNfeDetEspecificoArmamentoVO write FListaNfeDetEspecificoArmamentoVO;

  end;

implementation

constructor TNfeDetalheVO.Create;
begin
  inherited;
  FListaNfeDeclaracaoImportacaoVO := TObjectList<TNfeDeclaracaoImportacaoVO>.Create; //0:N
  FListaNfeDetEspecificoMedicamentoVO := TObjectList<TNfeDetEspecificoMedicamentoVO>.Create; //1:990
  FListaNfeDetEspecificoArmamentoVO := TObjectList<TNfeDetEspecificoArmamentoVO>.Create; //0:120
end;

constructor TNfeDetalheVO.Create(pJsonValue: TJSONValue);
var
  Deserializa: TJSONUnMarshal;
begin
  if pJsonValue is TJSONNull then
    Exception.Create('Erro ao criar objeto com um valor nulo.');

  Deserializa := TJSONUnMarshal.Create;
  try
    Self.Free;

    //Lista Nfe Referenciada
    Deserializa.RegisterReverter(TNfeDetalheVO, 'FListaNfeDeclaracaoImportacaoVO', procedure(Data: TObject; Field: String; Args: TListOfObjects)
    var
      Obj: TObject;
    begin
      if not Assigned(TNfeDetalheVO(Data).FListaNfeDeclaracaoImportacaoVO) then
        TNfeDetalheVO(Data).FListaNfeDeclaracaoImportacaoVO := TObjectList<TNfeDeclaracaoImportacaoVO>.Create;

      for Obj in Args do
      begin
        TNfeDetalheVO(Data).FListaNfeDeclaracaoImportacaoVO.Add(TNfeDeclaracaoImportacaoVO(Obj));
      end
    end);

    //Lista Nfe Detalhe
    Deserializa.RegisterReverter(TNfeDetalheVO, 'FListaNfeDetEspecificoMedicamentoVO', procedure(Data: TObject; Field: String; Args: TListOfObjects)
    var
      Obj: TObject;
    begin
      if not Assigned(TNfeDetalheVO(Data).FListaNfeDetEspecificoMedicamentoVO) then
        TNfeDetalheVO(Data).FListaNfeDetEspecificoMedicamentoVO := TObjectList<TNfeDetEspecificoMedicamentoVO>.Create;

      for Obj in Args do
      begin
        TNfeDetalheVO(Data).FListaNfeDetEspecificoMedicamentoVO.Add(TNfeDetEspecificoMedicamentoVO(Obj));
      end
    end);

    //Lista Nfe Duplicata
    Deserializa.RegisterReverter(TNfeDetalheVO, 'FListaNfeDetEspecificoArmamentoVO', procedure(Data: TObject; Field: String; Args: TListOfObjects)
    var
      Obj: TObject;
    begin
      if not Assigned(TNfeDetalheVO(Data).FListaNfeDetEspecificoArmamentoVO) then
        TNfeDetalheVO(Data).FListaNfeDetEspecificoArmamentoVO := TObjectList<TNfeDetEspecificoArmamentoVO>.Create;

      for Obj in Args do
      begin
        TNfeDetalheVO(Data).FListaNfeDetEspecificoArmamentoVO.Add(TNfeDetEspecificoArmamentoVO(Obj));
      end
    end);

    Self := Deserializa.Unmarshal(pJsonValue) as TNfeDetalheVO;
  finally
    Deserializa.Free;
  end;
end;

destructor TNfeDetalheVO.Destroy;
begin
  FListaNfeDeclaracaoImportacaoVO.Free;
  FListaNfeDetEspecificoMedicamentoVO.Free;
  FListaNfeDetEspecificoArmamentoVO.Free;

  if Assigned(FNfeDetEspecificoVeiculoVO) then
    FNfeDetEspecificoVeiculoVO.Free;
  if Assigned(FNfeDetEspecificoCombustivelVO) then
    FNfeDetEspecificoCombustivelVO.Free;
  if Assigned(FNfeDetalheImpostoIcmsVO) then
    FNfeDetalheImpostoIcmsVO.Free;
  if Assigned(FNfeDetalheImpostoIpiVO) then
    FNfeDetalheImpostoIpiVO.Free;
  if Assigned(FNfeDetalheImpostoIiVO) then
    FNfeDetalheImpostoIiVO.Free;
  if Assigned(FNfeDetalheImpostoPisVO) then
    FNfeDetalheImpostoPisVO.Free;
  if Assigned(FNfeDetalheImpostoCofinsVO) then
    FNfeDetalheImpostoCofinsVO.Free;
  if Assigned(FNfeDetalheImpostoIssqnVO) then
    FNfeDetalheImpostoIssqnVO.Free;
  inherited;
end;

function TNfeDetalheVO.ToJSON: TJSONValue;
var
  Serializa: TJSONMarshal;
begin
  Serializa := TJSONMarshal.Create(TJSONConverter.Create);
  try

    //Lista Nfe Referenciada
    Serializa.RegisterConverter(TNfeDetalheVO, 'FListaNfeDeclaracaoImportacaoVO', function(Data: TObject; Field: string): TListOfObjects
      var
        I: Integer;
      begin
        if Assigned(TNfeDetalheVO(Data).FListaNfeDeclaracaoImportacaoVO) then
        begin
          SetLength(Result, TNfeDetalheVO(Data).FListaNfeDeclaracaoImportacaoVO.Count);
          for I := 0 to TNfeDetalheVO(Data).FListaNfeDeclaracaoImportacaoVO.Count - 1 do
          begin
            Result[I] := TNfeDetalheVO(Data).FListaNfeDeclaracaoImportacaoVO.Items[I];
          end;
        end;
      end);

    //Lista Nfe Detalhe
    Serializa.RegisterConverter(TNfeDetalheVO, 'FListaNfeDetEspecificoMedicamentoVO', function(Data: TObject; Field: string): TListOfObjects
      var
        I: Integer;
      begin
        if Assigned(TNfeDetalheVO(Data).FListaNfeDetEspecificoMedicamentoVO) then
        begin
          SetLength(Result, TNfeDetalheVO(Data).FListaNfeDetEspecificoMedicamentoVO.Count);
          for I := 0 to TNfeDetalheVO(Data).FListaNfeDetEspecificoMedicamentoVO.Count - 1 do
          begin
            Result[I] := TNfeDetalheVO(Data).FListaNfeDetEspecificoMedicamentoVO.Items[I];
          end;
        end;
      end);

    //Lista Nfe Duplicata
    Serializa.RegisterConverter(TNfeDetalheVO, 'FListaNfeDetEspecificoArmamentoVO', function(Data: TObject; Field: string): TListOfObjects
      var
        I: Integer;
      begin
        if Assigned(TNfeDetalheVO(Data).FListaNfeDetEspecificoArmamentoVO) then
        begin
          SetLength(Result, TNfeDetalheVO(Data).FListaNfeDetEspecificoArmamentoVO.Count);
          for I := 0 to TNfeDetalheVO(Data).FListaNfeDetEspecificoArmamentoVO.Count - 1 do
          begin
            Result[I] := TNfeDetalheVO(Data).FListaNfeDetEspecificoArmamentoVO.Items[I];
          end;
        end;
      end);

    // Campos Transientes
    {}

    Exit(serializa.Marshal(Self));
  finally
    Serializa.Free;
  end;
end;


end.
