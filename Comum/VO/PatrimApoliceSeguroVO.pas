{*******************************************************************************
Title: T2Ti ERP                                                                 
Description:  VO  relacionado à tabela [PATRIM_APOLICE_SEGURO] 
                                                                                
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
unit PatrimApoliceSeguroVO;

interface

uses
  JsonVO, Atributos, Classes, Constantes, Generics.Collections, DBXJSON, DBXJSONReflect,
  SysUtils, PatrimBemVO, SeguradoraVO;

type
  [TEntity]
  [TTable('PATRIM_APOLICE_SEGURO')]
  TPatrimApoliceSeguroVO = class(TJsonVO)
  private
    FID: Integer;
    FID_PATRIM_BEM: Integer;
    FID_SEGURADORA: Integer;
    FNUMERO: String;
    FDATA_CONTRATACAO: TDateTime;
    FDATA_VENCIMENTO: TDateTime;
    FVALOR_PREMIO: Extended;
    FVALOR_SEGURADO: Extended;
    FOBSERVACAO: String;
    FIMAGEM: String;

    FPatrimBemNome: String;
    FSeguradoraNome: String;

    FPatrimBemVO: TPatrimBemVO;
    FSeguradoraVO: TSeguradoraVO;

  public
    destructor Destroy; override;
    function ToJSON: TJSONValue; override;

    [TId('ID')]
    [TGeneratedValue(sAuto)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property Id: Integer  read FID write FID;

    [TColumn('ID_PATRIM_BEM','Id Patrim Bem',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdPatrimBem: Integer  read FID_PATRIM_BEM write FID_PATRIM_BEM;
    [TColumn('PATRIM_BEM.NOME', 'Nome do Bem', 250, [ldGrid, ldLookup, ldComboBox], True, 'PATRIM_BEM', 'ID_PATRIM_BEM', 'ID')]
    property PatrimBemNome: String read FPatrimBemNome write FPatrimBemNome;

    [TColumn('ID_SEGURADORA','Id Seguradora',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdSeguradora: Integer  read FID_SEGURADORA write FID_SEGURADORA;
    [TColumn('SEGURADORA.NOME', 'Nome da Seguradora', 250, [ldGrid, ldLookup, ldComboBox], True, 'SEGURADORA', 'ID_SEGURADORA', 'ID')]
    property SeguradoraNome: String read FSeguradoraNome write FSeguradoraNome;

    [TColumn('NUMERO','Numero',160,[ldGrid, ldLookup, ldCombobox], False)]
    property Numero: String  read FNUMERO write FNUMERO;
    [TColumn('DATA_CONTRATACAO','Data Contratacao',80,[ldGrid, ldLookup, ldCombobox], False)]
    property DataContratacao: TDateTime  read FDATA_CONTRATACAO write FDATA_CONTRATACAO;
    [TColumn('DATA_VENCIMENTO','Data Vencimento',80,[ldGrid, ldLookup, ldCombobox], False)]
    property DataVencimento: TDateTime  read FDATA_VENCIMENTO write FDATA_VENCIMENTO;
    [TColumn('VALOR_PREMIO','Valor Premio',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property ValorPremio: Extended  read FVALOR_PREMIO write FVALOR_PREMIO;
    [TColumn('VALOR_SEGURADO','Valor Segurado',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property ValorSegurado: Extended  read FVALOR_SEGURADO write FVALOR_SEGURADO;
    [TColumn('OBSERVACAO','Observacao',450,[ldGrid, ldLookup, ldCombobox], False)]
    property Observacao: String  read FOBSERVACAO write FOBSERVACAO;
    [TColumn('IMAGEM','Imagem',450,[ldGrid, ldLookup, ldCombobox], False)]
    property Imagem: String  read FIMAGEM write FIMAGEM;

    [TAssociation(False, 'ID', 'ID_PATRIM_BEM', 'PATRIM_BEM')]
    property PatrimBemVO: TPatrimBemVO read FPatrimBemVO write FPatrimBemVO;

    [TAssociation(False, 'ID', 'ID_SEGURADORA', 'SEGURADORA')]
    property SeguradoraVO: TSeguradoraVO read FSeguradoraVO write FSeguradoraVO;
  end;

implementation

destructor TPatrimApoliceSeguroVO.Destroy;
begin
  if Assigned(FPatrimBemVO) then
    FPatrimBemVO.Free;
  if Assigned(FSeguradoraVO) then
    FSeguradoraVO.Free;
  inherited;
end;

function TPatrimApoliceSeguroVO.ToJSON: TJSONValue;
var
  Serializa: TJSONMarshal;
begin
  Serializa := TJSONMarshal.Create(TJSONConverter.Create);
  try

    if Assigned(Self.PatrimBemVO) then
      Self.PatrimBemNome := Self.PatrimBemVO.Nome;
    if Assigned(Self.SeguradoraVO) then
      Self.SeguradoraNome := Self.SeguradoraVO.Nome;

  Exit(serializa.Marshal(Self));
  finally
    Serializa.Free;
  end;
end;

end.
