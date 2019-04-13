{*******************************************************************************
Title: T2Ti ERP                                                                 
Description:  VO  relacionado à tabela [TALONARIO_CHEQUE] 
                                                                                
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
unit TalonarioChequeVO;

interface

uses
  JsonVO, Atributos, Classes, Constantes, Generics.Collections, DBXJSON, DBXJSONReflect, SysUtils,
  ContaCaixaVO;

type
  [TEntity]
  [TTable('TALONARIO_CHEQUE')]
  TTalonarioChequeVO = class(TJsonVO)
  private
    FID: Integer;
    FID_CONTA_CAIXA: Integer;
    FID_EMPRESA: Integer;
    FTALAO: String;
    FNUMERO: Integer;
    FSTATUS_TALAO: String;

    FContaCaixaNome: String;
    FContaCaixaVO: TContaCaixaVO;



  public

    destructor Destroy; override;
    function ToJSON: TJSONValue; override;

    [TId('ID')]
    [TGeneratedValue(sAuto)]
    property Id: Integer  read FID write FID;
    [TColumn('ID_CONTA_CAIXA','Id Conta Caixa',80,[ldGrid, ldLookup], False)]
    property IdContaCaixa: Integer  read FID_CONTA_CAIXA write FID_CONTA_CAIXA;
    [TColumn('CONTA_CAIXA.NOME', 'Conta Caixa',180,[ldGrid, ldLookup, ldComboBox], True,'CONTA_CAIXA','ID_CONTA_CAIXA','ID')]
    property ContaCaixaNome: String read FContaCaixaNome write FContaCaixaNome;

    [TColumn('ID_EMPRESA','Id Empresa',80,[], False)]
    property IdEmpresa: Integer  read FID_EMPRESA write FID_EMPRESA;

    [TColumn('TALAO','Talao',80,[ldGrid, ldLookup, ldComboBox], False)]
    property Talao: String  read FTALAO write FTALAO;
    [TColumn('NUMERO','Número',80,[ldGrid, ldLookup, ldComboBox], False)]
    property Numero: Integer  read FNUMERO write FNUMERO;
    [TColumn('STATUS_TALAO','Status Talão',80,[ldGrid, ldLookup], False)]
    property StatusTalao: String  read FSTATUS_TALAO write FSTATUS_TALAO;

    [TAssociation(False,'ID','ID_CONTA_CAIXA','CONTA_CAIXA')]
    property ContaCaixaVO: TContaCaixaVO read FContaCaixaVO write FContaCaixaVO;



  end;

implementation

destructor TTalonarioChequeVO.Destroy;
begin
  if Assigned(FContaCaixaVO) then
    FContaCaixaVO.Free;
  inherited;
end;

function TTalonarioChequeVO.ToJSON: TJSONValue;
var
  Serializa: TJSONMarshal;
begin
  Serializa := TJSONMarshal.Create(TJSONConverter.Create);
  try
    if Assigned(Self.ContaCaixaVO) then
    Self.ContaCaixaNome := Self.ContaCaixaVO.Nome;

    Exit(serializa.Marshal(Self));
  finally
    Serializa.Free;
  end;
end;

end.
