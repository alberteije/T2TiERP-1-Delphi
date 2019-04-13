{*******************************************************************************
Title: T2Ti ERP                                                                 
Description:  VO  relacionado à tabela [CONTA_CAIXA] 
                                                                                
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
unit ContaCaixaVO;

interface

uses
  JsonVO, Atributos, Classes, Constantes, Generics.Collections, DBXJSON, DBXJSONReflect, SysUtils,
  ContabilContaVO, AgenciaBancoVO;

type
  [TEntity]
  [TTable('CONTA_CAIXA')]
  TContaCaixaVO = class(TJsonVO)
  private
    FID: Integer;
    FID_CONTABIL_CONTA: Integer;
    FID_EMPRESA: Integer;
    FID_AGENCIA_BANCO: Integer;
    FCODIGO: String;
    FDIGITO: String;
    FNOME: String;
    FDESCRICAO: String;
    FTIPO: String;

    FAgenciaBancoNome: String;
    FContabilContaClassificacao: String;

    FAgenciaBancoVO: TAgenciaBancoVO;
    FContabilContaVO: TContabilContaVO;

  public

    destructor Destroy; override;
    function ToJSON: TJSONValue; override;

    [TId('ID')]
    [TGeneratedValue(sAuto)]
    property Id: Integer  read FID write FID;
    [TColumn('ID_CONTABIL_CONTA','Id Contábil Conta',80,[ldGrid, ldLookup], False)]
    property IdContabilConta: Integer  read FID_CONTABIL_CONTA write FID_CONTABIL_CONTA;
    [TColumn('CONTABIL_CONTA.CLASSIFICACAO','Conta Contábil',150,[ldGrid],True,'CONTABIL_CONTA','ID_CONTABIL_CONTA','ID')]
    property ContabilContaClassificacao: String read FContabilContaClassificacao write FContabilContaClassificacao;

    [TColumn('ID_EMPRESA','Id Empresa',80,[], False)]
    property IdEmpresa: Integer  read FID_EMPRESA write FID_EMPRESA;

    [TColumn('ID_AGENCIA_BANCO','Id Agência Banco',80,[ldGrid, ldLookup], False)]
    property IdAgenciaBanco: Integer  read FID_AGENCIA_BANCO write FID_AGENCIA_BANCO;
    [TColumn('AGENCIA_BANCO.NOME','Nome',300,[ldGrid],True,'AGENCIA_BANCO','ID_AGENCIA_BANCO','ID')]
    property AgenciaBancoNome: String read FAgenciaBancoNome write FAgenciaBancoNome;

    [TColumn('CODIGO','Código',160,[ldGrid, ldLookup, ldComboBox], False)]
    property Codigo: String  read FCODIGO write FCODIGO;
    [TColumn('DIGITO','Dígito',80,[ldGrid, ldLookup, ldComboBox], False)]
    property Digito: String  read FDIGITO write FDIGITO;
    [TColumn('NOME','Nome',400,[ldGrid, ldLookup, ldComboBox], False)]
    property Nome: String  read FNOME write FNOME;
    [TColumn('DESCRICAO','Descrição',450,[ldGrid, ldLookup], False)]
    property Descricao: String  read FDESCRICAO write FDESCRICAO;
    [TColumn('TIPO','Tipo',32,[ldGrid, ldLookup], False)]
    property Tipo: String  read FTIPO write FTIPO;

    [TAssociation(False,'ID','ID_CONTABIL_CONTA','CONTABIL_CONTA')]
    property ContabilContaVO: TContabilContaVO read FContabilContaVO write FContabilContaVO;

    [TAssociation(True,'ID','ID_AGENCIA_BANCO', 'AGENCIA_BANCO' )]
    property AgenciaBancoVO: TAgenciaBancoVO read FAgenciaBancoVO write FAgenciaBancoVO;


  end;

implementation

destructor TContaCaixaVO.Destroy;
begin
  if Assigned(FAgenciaBancoVO) then
    FAgenciaBancoVO.Free;
  if Assigned(FContabilContaVO) then
    FContabilContaVO.Free;
  inherited;
end;

function TContaCaixaVO.ToJSON: TJSONValue;
var
  Serializa: TJSONMarshal;
begin
  Serializa := TJSONMarshal.Create(TJSONConverter.Create);
  try
    if Assigned(Self.AgenciaBancoVO) then
    Self.AgenciaBancoNome := Self.AgenciaBancoVO.Nome;
    if Assigned(Self.ContabilContaVO) then
    Self.ContabilContaClassificacao := Self.ContabilContaVO.Classificacao;

    Exit(serializa.Marshal(Self));
  finally
    Serializa.Free;
  end;
end;

end.
