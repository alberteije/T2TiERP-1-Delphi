{*******************************************************************************
Title: T2Ti ERP                                                                 
Description:  VO  relacionado à tabela [CHEQUE] 
                                                                                
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
unit ChequeVO;

interface

uses
  JsonVO, Atributos, Classes, Constantes, Generics.Collections, DBXJSON, DBXJSONReflect, SysUtils,
  TalonarioChequeVO;

type
  [TEntity]
  [TTable('CHEQUE')]
  TChequeVO = class(TJsonVO)
  private
    FID: Integer;
    FID_TALONARIO_CHEQUE: Integer;
    FNUMERO: Integer;
    FSTATUS_CHEQUE: String;
    FDATA_STATUS: TDateTime;

    FTalonarioChequeTalao: String;
    FTalonarioChequeVO: TTalonarioChequeVO;

  public

    destructor Destroy; override;
    function ToJSON: TJSONValue; override;

    [TId('ID')]
    [TGeneratedValue(sAuto)]
    property Id: Integer  read FID write FID;
    [TColumn('ID_TALONARIO_CHEQUE','Id Talonário Cheque',80,[ldGrid, ldLookup], False)]
    property IdTalonarioCheque: Integer  read FID_TALONARIO_CHEQUE write FID_TALONARIO_CHEQUE;
    [TColumn('TALONARIO_CHEQUE','Talonário Cheque',140,[ldGrid,ldLookup], True,'TALONARIO_CHEQUE','ID_TALONARIO_CHEQUE','ID')]
    property TalonarioChequeTalao: String read FTalonarioChequeTalao write FTalonarioChequeTalao;


    [TColumn('NUMERO','Numero',80,[ldGrid, ldLookup], False)]
    property Numero: Integer  read FNUMERO write FNUMERO;
    [TColumn('STATUS_CHEQUE','Status Cheque',80,[ldGrid, ldLookup], False)]
    property StatusCheque: String  read FSTATUS_CHEQUE write FSTATUS_CHEQUE;
    [TColumn('DATA_STATUS','Data Status',120,[ldGrid, ldLookup], False)]
    property DataStatus: TDateTime  read FDATA_STATUS write FDATA_STATUS;

   [TAssociation(False,'ID','ID_TALONARIO_CHEQUE','TALONARIO_CHEQUE')]
    property TalonarioChequeVO: TTalonarioChequeVO read FTalonarioChequeVO write FTalonarioChequeVO;

  end;

implementation

destructor TChequeVO.Destroy;
begin
  if Assigned(FTalonarioChequeVO) then
    FTalonarioChequeVO.Free;
  inherited;
end;

function TChequeVO.ToJSON: TJSONValue;
var
  Serializa: TJSONMarshal;
begin
  Serializa := TJSONMarshal.Create(TJSONConverter.Create);
  try
    if Assigned(Self.TalonarioChequeVO) then
    Self.TalonarioChequeTalao := Self.TalonarioChequeVO.Talao;

    Exit(serializa.Marshal(Self));
  finally
    Serializa.Free;
  end;
end;

end.
