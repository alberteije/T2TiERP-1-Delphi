{*******************************************************************************
Title: T2Ti ERP                                                                 
Description:  VO  relacionado à tabela [FOLHA_AFASTAMENTO] 
                                                                                
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
unit FolhaAfastamentoVO;

interface

uses
  JsonVO, Atributos, Classes, Constantes, Generics.Collections, DBXJSON, DBXJSONReflect,
  SysUtils, ColaboradorPessoaVO, FolhaTipoAfastamentoVO;

type
  [TEntity]
  [TTable('FOLHA_AFASTAMENTO')]
  TFolhaAfastamentoVO = class(TJsonVO)
  private
    FID: Integer;
    FID_COLABORADOR: Integer;
    FID_FOLHA_TIPO_AFASTAMENTO: Integer;
    FDATA_INICIO: TDateTime;
    FDATA_FIM: TDateTime;
    FDIAS_AFASTADO: Integer;

    FColaboradorPessoaNome: String;
    FTipoAfastamentoNome: String;

    FColaboradorVO: TColaboradorVO;
    FFolhaTipoAfastamentoVO: TFolhaTipoAfastamentoVO;

  public
    destructor Destroy; override;
    function ToJSON: TJSONValue; override;

    [TId('ID')]
    [TGeneratedValue(sAuto)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property Id: Integer  read FID write FID;

    [TColumn('ID_COLABORADOR','Id Colaborador',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdColaborador: Integer  read FID_COLABORADOR write FID_COLABORADOR;
    [TColumn('COLABORADOR.PESSOA.NOME', 'Colaborador', 250, [ldGrid, ldLookup, ldComboBox], True, 'COLABORADOR.PESSOA', 'ID_COLABORADOR', 'ID')]
    property ColaboradorPessoaNome: String read FColaboradorPessoaNome write FColaboradorPessoaNome;

    [TColumn('ID_FOLHA_TIPO_AFASTAMENTO','Id Tipo Afastamento',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdFolhaTipoAfastamento: Integer  read FID_FOLHA_TIPO_AFASTAMENTO write FID_FOLHA_TIPO_AFASTAMENTO;
    [TColumn('FOLHA_TIPO_AFASTAMENTO.NOME', 'Tipo Afastamento', 250, [ldGrid, ldLookup, ldComboBox], True, 'FOLHA_TIPO_AFASTAMENTO', 'ID_FOLHA_TIPO_AFASTAMENTO', 'ID')]
    property TipoAfastamentoNome: String read FTipoAfastamentoNome write FTipoAfastamentoNome;

    [TColumn('DATA_INICIO','Data Inicio',80,[ldGrid, ldLookup, ldCombobox], False)]
    property DataInicio: TDateTime  read FDATA_INICIO write FDATA_INICIO;
    [TColumn('DATA_FIM','Data Fim',80,[ldGrid, ldLookup, ldCombobox], False)]
    property DataFim: TDateTime  read FDATA_FIM write FDATA_FIM;
    [TColumn('DIAS_AFASTADO','Dias Afastado',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZeroInvisivel, taCenter)]
    property DiasAfastado: Integer  read FDIAS_AFASTADO write FDIAS_AFASTADO;

    [TAssociation(True, 'ID', 'ID_COLABORADOR', 'COLABORADOR')]
    property ColaboradorVO: TColaboradorVO read FColaboradorVO write FColaboradorVO;

    [TAssociation(True, 'ID', 'ID_FOLHA_TIPO_AFASTAMENTO', 'FOLHA_TIPO_AFASTAMENTO')]
    property FolhaTipoAfastamentoVO: TFolhaTipoAfastamentoVO read FFolhaTipoAfastamentoVO write FFolhaTipoAfastamentoVO;
  end;

implementation

destructor TFolhaAfastamentoVO.Destroy;
begin
  if Assigned(FColaboradorVO) then
    FColaboradorVO.Free;
  if Assigned(FFolhaTipoAfastamentoVO) then
    FFolhaTipoAfastamentoVO.Free;

  inherited;
end;

function TFolhaAfastamentoVO.ToJSON: TJSONValue;
var
  Serializa: TJSONMarshal;
begin
  Serializa := TJSONMarshal.Create(TJSONConverter.Create);
  try

    // Campos Transientes
    if Assigned(Self.FColaboradorVO) then
      Self.ColaboradorPessoaNome := Self.FColaboradorVO.PessoaVO.Nome;
    if Assigned(Self.FFolhaTipoAfastamentoVO) then
      Self.TipoAfastamentoNome := Self.FFolhaTipoAfastamentoVO.Nome;

    Exit(serializa.Marshal(Self));
  finally
    Serializa.Free;
  end;
end;


end.
