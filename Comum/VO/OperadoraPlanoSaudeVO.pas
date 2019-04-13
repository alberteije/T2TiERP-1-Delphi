{*******************************************************************************
Title: T2Ti ERP                                                                 
Description:  VO  relacionado à tabela [OPERADORA_PLANO_SAUDE] 
                                                                                
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
unit OperadoraPlanoSaudeVO;

interface

uses
  JsonVO, Atributos, Classes, Constantes, Generics.Collections, DBXJSON, DBXJSONReflect, SysUtils,
  ContabilContaVO;

type
  [TEntity]
  [TTable('OPERADORA_PLANO_SAUDE')]
  TOperadoraPlanoSaudeVO = class(TJsonVO)
  private
    FID: Integer;
    FID_CONTABIL_CONTA: Integer;
    FREGISTRO_ANS: String;
    FNOME: String;

    FContabilContaClassificacao: String;

    FContabilContaVO: TContabilContaVO;

   public
    destructor Destroy; override;
    function ToJSON: TJSONValue; override;

    [TId('ID')]
    [TGeneratedValue(sAuto)]
    [TFormatter('000', taCenter)]
    property Id: Integer  read FID write FID;
    [TColumn('NOME','Nome',500,[ldGrid, ldLookup,ldComboBox],False)]
    property Nome: String read FNOME write FNOME;

    [TColumn('ID_CONTABIL_CONTA','Id Contábil Conta',80,[ldGrid], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdContabilConta: Integer  read FID_CONTABIL_CONTA write FID_CONTABIL_CONTA;
    [TColumn('CONTABIL_CONTA.CLASSIFICACAO','Conta Contábil',300,[ldGrid],True,'CONTABIL_CONTA','ID_CONTABIL_CONTA','ID')]
    property ContabilContaClassificacao: String read FContabilContaClassificacao write FContabilContaClassificacao;

    [TColumn('REGISTRO_ANS','Registro Ans',100,[ldGrid, ldLookup, ldComboBox], False)]
    property RegistroAns: String  read FREGISTRO_ANS write FREGISTRO_ANS;

    [TAssociation(False,'ID','ID_CONTABIL_CONTA','CONTABIL_CONTA')]
    property ContabilContaVO: TContabilContaVO read FContabilContaVO write FContabilContaVO;
  end;


implementation

destructor TOperadoraPlanoSaudeVO.Destroy;
begin
  if Assigned(FContabilContaVO) then
    FContabilContaVO.Free;
  inherited;
end;

function TOperadoraPlanoSaudeVO.ToJSON: TJSONValue;
var
  Serializa: TJSONMarshal;
begin
  Serializa := TJSONMarshal.Create(TJSONConverter.Create);
  try
    if Assigned(Self.ContabilContaVO) then
    Self.ContabilContaClassificacao := Self.ContabilContaVO.Classificacao;

    Exit(serializa.Marshal(Self));
  finally
    Serializa.Free;
  end;
end;

end.
