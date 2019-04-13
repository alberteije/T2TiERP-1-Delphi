{*******************************************************************************
Title: T2Ti ERP                                                                 
Description:  VO transiente relacionado à tabela [COLABORADOR] para diminuir o tráfego
na rede trazendo os dados necessários para uma pesquisa simples do colaborador
                                                                                
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
unit ColaboradorPessoaVO;

interface

uses
  JsonVO, Atributos, Classes, Constantes, Generics.Collections, DBXJSON, DBXJSONReflect,
  SysUtils, PessoaFisicaJuridicaVO;

type
  [TEntity]
  [TTable('COLABORADOR')]
  TColaboradorVO = class(TJsonVO)
  private
    FID: Integer;
    FID_PESSOA: Integer;
    FMATRICULA: String;
    FDATA_CADASTRO: TDateTime;
    FDATA_ADMISSAO: TDateTime;
    FDATA_DEMISSAO: TDateTime;
    FPIS_NUMERO: String;

    FPessoaNome: String;
    FPessoaVO: TPessoaVO;

  public
    destructor Destroy; override;
    function ToJSON: TJSONValue; override;

    [TId('ID')]
    [TGeneratedValue(sAuto)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property Id: Integer  read FID write FID;

    [TColumn('ID_PESSOA','Id Pessoa',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdPessoa: Integer  read FID_PESSOA write FID_PESSOA;
    [TColumn('PESSOA.NOME', 'Nome', 250, [ldGrid, ldLookup, ldComboBox], True, 'PESSOA', 'ID_PESSOA', 'ID')]
    property PessoaNome: String read FPessoaNome write FPessoaNome;

    [TColumn('MATRICULA','Matricula',80,[ldGrid, ldLookup, ldCombobox], False)]
    property Matricula: String  read FMATRICULA write FMATRICULA;
    [TColumn('DATA_CADASTRO','Data Cadastro',80,[ldGrid, ldLookup, ldCombobox], False)]
    property DataCadastro: TDateTime  read FDATA_CADASTRO write FDATA_CADASTRO;
    [TColumn('DATA_ADMISSAO','Data Admissao',80,[ldGrid, ldLookup, ldCombobox], False)]
    property DataAdmissao: TDateTime  read FDATA_ADMISSAO write FDATA_ADMISSAO;
    [TColumn('DATA_DEMISSAO','Data Demissao',80,[ldGrid, ldLookup, ldCombobox], False)]
    property DataDemissao: TDateTime  read FDATA_DEMISSAO write FDATA_DEMISSAO;
    [TColumn('PIS_NUMERO','Pis Numero',80,[ldGrid, ldLookup, ldCombobox], False)]
    property PisNumero: String  read FPIS_NUMERO write FPIS_NUMERO;

    [TAssociation(False, 'ID', 'ID_PESSOA', 'PESSOA')]
    property PessoaVO: TPessoaVO read FPessoaVO write FPessoaVO;

  end;

implementation

destructor TColaboradorVO.Destroy;
begin
  if Assigned(FPessoaVO) then
    FPessoaVO.Free;
  inherited;
end;

function TColaboradorVO.ToJSON: TJSONValue;
var
  Serializa: TJSONMarshal;
begin
  Serializa := TJSONMarshal.Create(TJSONConverter.Create);
  try
    if Assigned(Self.PessoaVO) then
      Self.PessoaNome := Self.PessoaVO.Nome;

    Exit(Serializa.Marshal(Self));
  finally
    Serializa.Free;
  end;
end;


end.
