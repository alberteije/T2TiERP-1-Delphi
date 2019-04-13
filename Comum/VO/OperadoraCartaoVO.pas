{*******************************************************************************
Title: T2Ti ERP                                                                 
Description:  VO  relacionado à tabela [OPERADORA_CARTAO] 
                                                                                
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
                                                                                
@author Fernando Lúcio Oliveira (fsystem.br@gmail.com)                    
@version 1.0                                                                    
*******************************************************************************}
unit OperadoraCartaoVO;

interface

uses
  JsonVO, Atributos, Classes, Constantes, Generics.Collections, DBXJSON, DBXJSONReflect, SysUtils,
  ContabilContaVO, ContaCaixaVO;

type
  [TEntity]
  [TTable('OPERADORA_CARTAO')]
  TOperadoraCartaoVO = class(TJsonVO)
  private
    FID: Integer;
    FID_CONTABIL_CONTA: Integer;
    FID_CONTA_CAIXA: Integer;
    FBANDEIRA: String;
    FNOME: String;
    FTAXA_ADM: Extended;
    FTAXA_ADM_DEBITO: Extended;
    FVALOR_ALUGUEL_POS_PIN: Extended;
    FVENCIMENTO_ALUGUEL: Integer;
    FFONE1: String;
    FFONE2: String;

    FContabilContaClassificacao: String;
    FContaCaixaNome: String;

    FContabilContaVO: TContabilContaVO;
    FContaCaixaVO: TContaCaixaVO;

  public
    destructor Destroy; override;
    function ToJSON: TJSONValue; override;

    [TId('ID')]
    [TGeneratedValue(sAuto)]
    [TFormatter('000', taCenter)]
    property Id: Integer  read FID write FID;
    [TColumn('ID_CONTABIL_CONTA','Id Contábil Conta',80,[], False)]
    property IdContabilConta: Integer  read FID_CONTABIL_CONTA write FID_CONTABIL_CONTA;

    [TColumn('CONTABIL_CONTA.CLASSIFICACAO','Conta Contábil',150,[ldGrid, ldLookup, ldComboBox],True,'CONTABIL_CONTA','ID_CONTABIL_CONTA','ID')]
    property ContabilContaClassificacao: String read FContabilContaClassificacao write FContabilContaClassificacao;

    [TColumn('ID_CONTA_CAIXA','Id Conta Caixa',80,[ldComboBox], False)]
    property IdContaCaixa: Integer  read FID_CONTA_CAIXA write FID_CONTA_CAIXA;

    [TColumn('CONTA_CAIXA.NOME','Conta Caixa',150,[ldGrid, ldLookup, ldComboBox],True,'CONTA_CAIXA','ID_CONTA_CAIXA','ID')]
    property ContaCaixaNome: String read FContaCaixaNome write FContaCaixaNome;

    [TColumn('BANDEIRA','Bandeira',240,[ldGrid, ldLookup, ldComboBox], False)]
    property Bandeira: String  read FBANDEIRA write FBANDEIRA;
    [TColumn('NOME','Nome',400,[ldGrid, ldLookup, ldComboBox], False)]
    property Nome: String  read FNOME write FNOME;
    [TColumn('TAXA_ADM','Taxa Adm',128,[ldGrid, ldLookup, ldComboBox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property TaxaAdm: Extended  read FTAXA_ADM write FTAXA_ADM;
    [TColumn('TAXA_ADM_DEBITO','Taxa Adm Débito',128,[ldGrid, ldLookup], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property TaxaAdmDebito: Extended  read FTAXA_ADM_DEBITO write FTAXA_ADM_DEBITO;
    [TColumn('VALOR_ALUGUEL_POS_PIN','Valor Aluguel Pos Pin',128,[ldGrid, ldLookup], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property ValorAluguelPosPin: Extended  read FVALOR_ALUGUEL_POS_PIN write FVALOR_ALUGUEL_POS_PIN;
    [TColumn('VENCIMENTO_ALUGUEL','Vencimento Aluguel',80,[ldGrid, ldLookup], False)]
    property VencimentoAluguel: Integer  read FVENCIMENTO_ALUGUEL write FVENCIMENTO_ALUGUEL;
    [TColumn('FONE1','Telefone 1',112,[ldGrid, ldLookup], False)]
    [TFormatter(ftTelefone,taCenter)]
    property Fone1: String  read FFONE1 write FFONE1;
    [TColumn('FONE2','Telefone 2',112,[ldGrid, ldLookup], False)]
    [TFormatter(ftTelefone,taCenter)]
    property Fone2: String  read FFONE2 write FFONE2;

    [TAssociation(False,'ID','ID_CONTABIL_CONTA','CONTABIL_CONTA')]
    property ContabilContaVO: TContabilContaVO read FContabilContaVO write FContabilContaVO;

    [TAssociation(False,'ID','ID_CONTA_CAIXA','CONTA_CAIXA')]
    property ContaCaixaVO: TContaCaixaVO read FContaCaixaVO write FContaCaixaVO;

  end;

implementation

destructor TOperadoraCartaoVO.Destroy;
begin
  if Assigned(FContabilContaVO) then
    FContabilContaVO.Free;
  if Assigned(FContaCaixaVO) then
    FContaCaixaVO.Free;
  inherited;
end;

function TOperadoraCartaoVO.ToJSON: TJSONValue;
var
  Serializa: TJSONMarshal;
begin
  Serializa := TJSONMarshal.Create(TJSONConverter.Create);
  try
    if Assigned(Self.ContabilContaVO) then
    Self.ContabilContaClassificacao := Self.ContabilContaVO.Classificacao;
    if Assigned(Self.ContaCaixaVO) then
    Self.ContaCaixaNome := Self.ContaCaixaVO.Nome;

    Exit(serializa.Marshal(Self));
  finally
    Serializa.Free;
  end;
end;

end.
