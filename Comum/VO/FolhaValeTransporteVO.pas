{*******************************************************************************
Title: T2Ti ERP                                                                 
Description:  VO  relacionado à tabela [FOLHA_VALE_TRANSPORTE] 
                                                                                
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
unit FolhaValeTransporteVO;

interface

uses
  JsonVO, Atributos, Classes, Constantes, Generics.Collections, DBXJSON, DBXJSONReflect,
  SysUtils, ColaboradorPessoaVO, EmpresaTransporteItinerarioVO;

type
  [TEntity]
  [TTable('FOLHA_VALE_TRANSPORTE')]
  TFolhaValeTransporteVO = class(TJsonVO)
  private
    FID: Integer;
    FID_EMPRESA_TRANSP_ITIN: Integer;
    FID_COLABORADOR: Integer;
    FQUANTIDADE: Integer;

    FColaboradorPessoaNome: String;
    FEmpresaTransporteItinerarioNome: String;

    FColaboradorVO: TColaboradorVO;
    FEmpresaTransporteItinerarioVO: TEmpresaTransporteItinerarioVO;

  public
    destructor Destroy; override;
    function ToJSON: TJSONValue; override;

    [TId('ID')]
    [TGeneratedValue(sAuto)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property Id: Integer  read FID write FID;

    [TColumn('ID_EMPRESA_TRANSP_ITIN','Id Itinerário',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdEmpresaTranspItin: Integer  read FID_EMPRESA_TRANSP_ITIN write FID_EMPRESA_TRANSP_ITIN;
    [TColumn('EMPRESA_TRANSPORTE_ITINERARIO.NOME', 'Itinerário', 250, [ldGrid, ldLookup, ldComboBox], True, 'EMPRESA_TRANSPORTE_ITINERARIO', 'ID_EMPRESA_TRANSP_ITIN', 'ID')]
    property EmpresaTransporteItinerarioNome: String read FEmpresaTransporteItinerarioNome write FEmpresaTransporteItinerarioNome;

    [TColumn('ID_COLABORADOR','Id Colaborador',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdColaborador: Integer  read FID_COLABORADOR write FID_COLABORADOR;
    [TColumn('COLABORADOR.PESSOA.NOME', 'Requisitante', 250, [ldGrid, ldLookup, ldComboBox], True, 'COLABORADOR.PESSOA', 'ID_COLABORADOR', 'ID')]
    property ColaboradorPessoaNome: String read FColaboradorPessoaNome write FColaboradorPessoaNome;

    [TColumn('QUANTIDADE','Quantidade',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property Quantidade: Integer  read FQUANTIDADE write FQUANTIDADE;

    [TAssociation(False, 'ID', 'ID_EMPRESA_TRANSP_ITIN', 'EMPRESA_TRANSPORTE_ITINERARIO')]
    property EmpresaTransporteItinerarioVO: TEmpresaTransporteItinerarioVO read FEmpresaTransporteItinerarioVO write FEmpresaTransporteItinerarioVO;

    [TAssociation(True, 'ID', 'ID_COLABORADOR', 'COLABORADOR')]
    property ColaboradorVO: TColaboradorVO read FColaboradorVO write FColaboradorVO;

  end;

implementation

destructor TFolhaValeTransporteVO.Destroy;
begin

  if Assigned(FEmpresaTransporteItinerarioVO) then
    FEmpresaTransporteItinerarioVO.Free;
  if Assigned(FColaboradorVO) then
    FColaboradorVO.Free;
  inherited;
end;

function TFolhaValeTransporteVO.ToJSON: TJSONValue;
var
  Serializa: TJSONMarshal;
begin
  Serializa := TJSONMarshal.Create(TJSONConverter.Create);
  try

    // Campos Transientes
     if Assigned(Self.EmpresaTransporteItinerarioVO) then
       Self.EmpresaTransporteItinerarioNome := Self.EmpresaTransporteItinerarioVO.Nome;
     if Assigned(Self.ColaboradorVO) then
       Self.ColaboradorPessoaNome := Self.ColaboradorVO.PessoaVO.Nome;

  Exit(serializa.Marshal(Self));
  finally
    Serializa.Free;
  end;
end;


end.
