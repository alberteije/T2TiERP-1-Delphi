{*******************************************************************************
Title: T2Ti ERP                                                                 
Description:  VO  relacionado à tabela [VENDA_FRETE] 
                                                                                
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
unit VendaFreteVO;

interface

uses
  JsonVO, Atributos, Classes, Constantes, Generics.Collections, DBXJSON, DBXJSONReflect, SysUtils,
  TransportadoraPessoaVO, VendaCabecalhoVO;

type
  [TEntity]
  [TTable('VENDA_FRETE')]
  TVendaFreteVO = class(TJsonVO)
  private
    FID: Integer;
    FID_TRANSPORTADORA: Integer;
    FID_VENDA_CABECALHO: Integer;
    FCONHECIMENTO: Integer;
    FRESPONSAVEL: String;
    FPLACA: String;
    FUF_PLACA: String;
    FSELO_FISCAL: Integer;
    FQUANTIDADE_VOLUME: Extended;
    FMARCA_VOLUME: String;
    FESPECIE_VOLUME: String;
    FPESO_BRUTO: Extended;
    FPESO_LIQUIDO: Extended;

    FTransportadoraNome: String;
    FVendaCabecalhoNumeroFatura: Integer;

    FTransportadoraVO: TTransportadoraVO;
    FVendaCabecalhoVO: TVendaCabecalhoVO;

  public 
    destructor Destroy; override;
    function ToJSON: TJSONValue; override;

    [TId('ID')]
    [TGeneratedValue(sAuto)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property Id: Integer  read FID write FID;

    [TColumn('ID_TRANSPORTADORA','Id Transportadora',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdTransportadora: Integer  read FID_TRANSPORTADORA write FID_TRANSPORTADORA;
    [TColumn('TRANSPORTADORA.NOME', 'Nome Transportadora', 250, [ldGrid, ldLookup, ldComboBox], True, 'TRANSPORTADORA', 'ID_TRANSPORTADORA', 'ID')]
    property TransportadoraNome: String read FTransportadoraNome write FTransportadoraNome;

    [TColumn('ID_VENDA_CABECALHO','Id Venda Cabecalho',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdVendaCabecalho: Integer  read FID_VENDA_CABECALHO write FID_VENDA_CABECALHO;
    [TColumn('VENDACABECALHO.NUMEROFATURA', 'Número Fatura', 80, [ldGrid, ldLookup, ldComboBox], True, 'VENDA_CABECALHO', 'ID_VENDA_CABECALHO', 'ID')]
    property VendaCabecalhoNumeroFatura: Integer read FVendaCabecalhoNumeroFatura write FVendaCabecalhoNumeroFatura;

    [TColumn('CONHECIMENTO','Conhecimento',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property Conhecimento: Integer  read FCONHECIMENTO write FCONHECIMENTO;
    [TColumn('RESPONSAVEL','Responsavel',8,[ldGrid, ldLookup, ldCombobox], False)]
    property Responsavel: String  read FRESPONSAVEL write FRESPONSAVEL;
    [TColumn('PLACA','Placa',56,[ldGrid, ldLookup, ldCombobox], False)]
    property Placa: String  read FPLACA write FPLACA;
    [TColumn('UF_PLACA','Uf Placa',16,[ldGrid, ldLookup, ldCombobox], False)]
    property UfPlaca: String  read FUF_PLACA write FUF_PLACA;
    [TColumn('SELO_FISCAL','Selo Fiscal',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property SeloFiscal: Integer  read FSELO_FISCAL write FSELO_FISCAL;
    [TColumn('QUANTIDADE_VOLUME','Quantidade Volume',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property QuantidadeVolume: Extended  read FQUANTIDADE_VOLUME write FQUANTIDADE_VOLUME;
    [TColumn('MARCA_VOLUME','Marca Volume',400,[ldGrid, ldLookup, ldCombobox], False)]
    property MarcaVolume: String  read FMARCA_VOLUME write FMARCA_VOLUME;
    [TColumn('ESPECIE_VOLUME','Especie Volume',160,[ldGrid, ldLookup, ldCombobox], False)]
    property EspecieVolume: String  read FESPECIE_VOLUME write FESPECIE_VOLUME;
    [TColumn('PESO_BRUTO','Peso Bruto',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property PesoBruto: Extended  read FPESO_BRUTO write FPESO_BRUTO;
    [TColumn('PESO_LIQUIDO','Peso Liquido',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property PesoLiquido: Extended  read FPESO_LIQUIDO write FPESO_LIQUIDO;

    [TAssociation(True,'ID','ID_TRANSPORTADORA','TRANSPORTADORA')]
    property TransportadoraVO: TTransportadoraVO read FTransportadoraVO write FTransportadoraVO;

    [TAssociation(False,'ID','ID_VENDA_CABECALHO','VENDA_CABECALHO')]
    property VendaCabecalhoVO: TVendaCabecalhoVO read FVendaCabecalhoVO write FVendaCabecalhoVO;
  end;

implementation

destructor TVendaFreteVO.Destroy;
begin
  if Assigned(FTransportadoraVO) then
    FTransportadoraVO.Free;
  if Assigned(FVendaCabecalhoVO) then
    FVendaCabecalhoVO.Free;
  inherited;
end;

function TVendaFreteVO.ToJSON: TJSONValue;
var
  Serializa: TJSONMarshal;
begin
  Serializa := TJSONMarshal.Create(TJSONConverter.Create);
  try
    if Assigned(Self.TransportadoraVO) then
    Self.TransportadoraNome := Self.TransportadoraVO.PessoaVO.Nome;
    if Assigned(Self.VendaCabecalhoVO) then
    Self.VendaCabecalhoNumeroFatura := Self.VendaCabecalhoVO.NumeroFatura;

    Exit(serializa.Marshal(Self));
  finally
    Serializa.Free;
  end;
end;


end.
