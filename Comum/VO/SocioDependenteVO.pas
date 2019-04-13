{*******************************************************************************
Title: SOMAR ERP                                                                 
Description:  VO  relacionado à tabela [SOCIO_DEPENDENTE] 
                                                                                
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

@author Antonio Luiz Arantes (alaran@terra.com.br)
@version 1.0
*******************************************************************************}
unit SocioDependenteVO;

interface

uses
  JsonVO, Atributos, PessoaVO, Generics.Collections, DBXJSON, DBXJSONReflect,
  TipoRelacionamentoVO, SysUtils, Classes, Constantes;

type
  [TEntity]
  [TTable('SOCIO_DEPENDENTE')]
  TSocioDependenteVO = class(TJsonVO)
  private
    FID: Integer;
    FID_SOCIO: Integer;
    FID_TIPO_RELACIONAMENTO: Integer;
    FNOME: String;
    FDATA_NASCIMENTO: TDateTime;
    FDATA_INICIO_DEPEDENCIA: TDateTime;
    FDATA_FIM_DEPENDENCIA: TDateTime;
    FCPF: String;

    FRelacionamentoNome: String;
    FTipoRelacionamentoVO: TTipoRelacionamentoVO;


  public
    destructor Destroy; override;
    function ToJSON: TJSONValue; override;

    [TId('ID')]
    [TGeneratedValue(sAuto)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property Id: Integer  read FID write FID;

    [TColumn('ID_SOCIO','Id Socio',80,[ldLookup], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdSocio: Integer  read FID_SOCIO write FID_SOCIO;

    [TColumn('ID_TIPO_RELACIONAMENTO','Id Tipo Relacionamento',80,[ldLookup], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdTipoRelacionamento: Integer  read FID_TIPO_RELACIONAMENTO write FID_TIPO_RELACIONAMENTO;
    [TColumn('TIPO_RELACIONAMENTO.NOME','Relacionamento',150,[ldGrid, ldLookup,ldComboBox], True)]
    property RelacionamentoNome: String  read FRelacionamentoNome write FRelacionamentoNome;

    [TColumn('NOME','Sócio',450,[ldGrid, ldLookup], False)]
    property Nome: String  read FNOME write FNOME;
    [TColumn('DATA_NASCIMENTO','Data Nascimento',90,[ldGrid, ldLookup], False)]
    property DataNascimento: TDateTime  read FDATA_NASCIMENTO write FDATA_NASCIMENTO;
    [TColumn('DATA_INICIO_DEPEDENCIA','Inicio Depedencia',90,[ldGrid, ldLookup], False)]
    property DataInicioDepedencia: TDateTime  read FDATA_INICIO_DEPEDENCIA write FDATA_INICIO_DEPEDENCIA;
    [TColumn('DATA_FIM_DEPENDENCIA','Fim Dependencia',90,[ldGrid, ldLookup], False)]
    property DataFimDependencia: TDateTime  read FDATA_FIM_DEPENDENCIA write FDATA_FIM_DEPENDENCIA;
    [TColumn('CPF','Cpf',88,[ldGrid, ldLookup], False)]
    [TFormatter(ftCpf, taCenter)]
    property Cpf: String  read FCPF write FCPF;

    [TAssociation(True,'ID','ID_TIPO_RELACIONAMENTO')]
    property TipoRelacionamentoVO: TTipoRelacionamentoVO read FTipoRelacionamentoVO write FTipoRelacionamentoVO;

  end;

implementation



{ TSocioDependenteVO }

destructor TSocioDependenteVO.Destroy;
begin
  if Assigned(FTipoRelacionamentoVO) then
    FTipoRelacionamentoVO.Free;

  inherited;
end;

function TSocioDependenteVO.ToJSON: TJSONValue;
var
  Serializa: TJSONMarshal;
begin
  Serializa := TJSONMarshal.Create(TJSONConverter.Create);
  try
    if Assigned(Self.TipoRelacionamentoVO) then
      Self.RelacionamentoNome := Self.TipoRelacionamentoVO.Nome;

    Exit(serializa.Marshal(Self));
  finally
    Serializa.Free;
  end;
end;

end.
