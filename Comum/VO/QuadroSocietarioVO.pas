{*******************************************************************************
Title: T2Ti ERP                                                                 
Description:  VO  relacionado à tabela [QUADRO_SOCIETARIO] 
                                                                                
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
                                                                                
       t2ti.com@gmail.com
@author Albert Eije
@version 1.0                                                                    
*******************************************************************************}
unit QuadroSocietarioVO;

interface

uses
  JsonVO, Atributos, Classes, Constantes, Generics.Collections, DBXJSON,
  DBXJSONReflect, SysUtils, EmpresaVO;

type
  [TEntity]
  [TTable('QUADRO_SOCIETARIO')]
  TQuadroSocietarioVO = class(TJsonVO)
  private
    FID: Integer;
    FID_EMPRESA: Integer;
    FDATA_REGISTRO: TDateTime;
    FCAPITAL_SOCIAL: Extended;
    FVALOR_QUOTA: Extended;
    FQUANTIDADE_COTAS: Integer;

    FRazaoSocial: String;

    FEmpresaVO: TEmpresaVO;

  public
    destructor Destroy; override;
    function ToJSON: TJSONValue; override;

    [TId('ID')]
    [TGeneratedValue(sAuto)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property Id: Integer  read FID write FID;

    [TColumn('ID_EMPRESA','Id Empresa',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdEmpresa: Integer  read FID_EMPRESA write FID_EMPRESA;

    [TColumn('EMPRESA.RAZAOSOCIAL','Razão Social da Empresa',250,[ldGrid, ldLookup], True)]
    property RazaoSocial: String  read FRazaoSocial write FRazaoSocial;

    [TColumn('DATA_REGISTRO','Data Registro',80,[ldGrid, ldLookup, ldCombobox], False)]
    property DataRegistro: TDateTime  read FDATA_REGISTRO write FDATA_REGISTRO;
    [TColumn('CAPITAL_SOCIAL','Capital Social',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property CapitalSocial: Extended  read FCAPITAL_SOCIAL write FCAPITAL_SOCIAL;
    [TColumn('VALOR_QUOTA','Valor Quota',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property ValorQuota: Extended  read FVALOR_QUOTA write FVALOR_QUOTA;
    [TColumn('QUANTIDADE_COTAS','Quantidade Cotas',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property QuantidadeCotas: Integer  read FQUANTIDADE_COTAS write FQUANTIDADE_COTAS;

    [TAssociation(False, 'ID', 'ID_EMPRESA')]
    property EmpresaVO: TEmpresaVO read FEmpresaVO write FEmpresaVO;

  end;

implementation



{ TQuadroSocietarioVO }

destructor TQuadroSocietarioVO.Destroy;
begin
  if Assigned(FEmpresaVO) then
    FEmpresaVO.Free;

  inherited;
end;

function TQuadroSocietarioVO.ToJSON: TJSONValue;
var
  Serializa: TJSONMarshal;
begin
  Serializa := TJSONMarshal.Create(TJSONConverter.Create);
  try
    if Assigned(Self.EmpresaVO) then
      Self.RazaoSocial := Self.EmpresaVO.RazaoSocial;

    Exit(Serializa.Marshal(Self));
  finally
    Serializa.Free;
  end;
end;

end.
