{*******************************************************************************
Title: T2Ti ERP                                                                 
Description:  VO  relacionado à tabela [FOLHA_PLANO_SAUDE] 
                                                                                
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
unit FolhaPlanoSaudeVO;

interface

uses
  JsonVO, Atributos, Classes, Constantes, Generics.Collections, DBXJSON, DBXJSONReflect,
  SysUtils, ColaboradorPessoaVO, OperadoraPlanoSaudeVO;

type
  [TEntity]
  [TTable('FOLHA_PLANO_SAUDE')]
  TFolhaPlanoSaudeVO = class(TJsonVO)
  private
    FID: Integer;
    FID_OPERADORA_PLANO_SAUDE: Integer;
    FID_COLABORADOR: Integer;
    FDATA_INICIO: TDateTime;
    FBENEFICIARIO: String;

    FColaboradorPessoaNome: String;
    FOperadoraNome: String;

    FColaboradorVO: TColaboradorVO;
    FOperadoraPlanoSaudeVO: TOperadoraPlanoSaudeVO;

  public 
    destructor Destroy; override;
    function ToJSON: TJSONValue; override;

    [TId('ID')]
    [TGeneratedValue(sAuto)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property Id: Integer  read FID write FID;

    [TColumn('ID_OPERADORA_PLANO_SAUDE','Id Operadora Plano Saude',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdOperadoraPlanoSaude: Integer  read FID_OPERADORA_PLANO_SAUDE write FID_OPERADORA_PLANO_SAUDE;
    [TColumn('OPERADORA_PLANO_SAUDE.NOME', 'Operadora', 250, [ldGrid, ldLookup, ldComboBox], True, 'OPERADORA_PLANO_SAUDE', 'ID_OPERADORA_PLANO_SAUDE', 'ID')]
    property OperadoraNome: String read FOperadoraNome write FOperadoraNome;

    [TColumn('ID_COLABORADOR','Id Colaborador',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdColaborador: Integer  read FID_COLABORADOR write FID_COLABORADOR;
    [TColumn('COLABORADOR.PESSOA.NOME', 'Colaborador', 250, [ldGrid, ldLookup, ldComboBox], True, 'COLABORADOR.PESSOA', 'ID_COLABORADOR', 'ID')]
    property ColaboradorPessoaNome: String read FColaboradorPessoaNome write FColaboradorPessoaNome;

    [TColumn('DATA_INICIO','Data Inicio',80,[ldGrid, ldLookup, ldCombobox], False)]
    property DataInicio: TDateTime  read FDATA_INICIO write FDATA_INICIO;
    [TColumn('BENEFICIARIO','Beneficiario',8,[ldGrid, ldLookup, ldCombobox], False)]
    property Beneficiario: String  read FBENEFICIARIO write FBENEFICIARIO;

    [TAssociation(True, 'ID', 'ID_COLABORADOR', 'COLABORADOR')]
    property ColaboradorVO: TColaboradorVO read FColaboradorVO write FColaboradorVO;

    [TAssociation(True, 'ID', 'ID_OPERADORA_PLANO_SAUDE', 'OPERADORA_PLANO_SAUDE')]
    property OperadoraPlanoSaudeVO: TOperadoraPlanoSaudeVO read FOperadoraPlanoSaudeVO write FOperadoraPlanoSaudeVO;
  end;

implementation

destructor TFolhaPlanoSaudeVO.Destroy;
begin
  if Assigned(FColaboradorVO) then
    FColaboradorVO.Free;
  if Assigned(FOperadoraPlanoSaudeVO) then
    FOperadoraPlanoSaudeVO.Free;

  inherited;
end;

function TFolhaPlanoSaudeVO.ToJSON: TJSONValue;
var
  Serializa: TJSONMarshal;
begin
  Serializa := TJSONMarshal.Create(TJSONConverter.Create);
  try

    // Campos Transientes
    if Assigned(Self.FColaboradorVO) then
      Self.ColaboradorPessoaNome := Self.FColaboradorVO.PessoaVO.Nome;
    if Assigned(Self.FOperadoraPlanoSaudeVO) then
      Self.OperadoraNome := Self.FOperadoraPlanoSaudeVO.Nome;

    Exit(serializa.Marshal(Self));
  finally
    Serializa.Free;
  end;
end;


end.
