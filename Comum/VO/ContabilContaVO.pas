{*******************************************************************************
Title: T2Ti ERP                                                                 
Description:  VO  relacionado à tabela [CONTABIL_CONTA] 
                                                                                
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
unit ContabilContaVO;

interface

uses
  JsonVO, Atributos, Classes, Constantes, Generics.Collections, DBXJSON, DBXJSONReflect,
  SysUtils, PlanoContaVO, PlanoContaRefSpedVO;

type
  [TEntity]
  [TTable('CONTABIL_CONTA')]
  TContabilContaVO = class(TJsonVO)
  private
    FID: Integer;
    FID_PLANO_CONTA: Integer;
    FID_PLANO_CONTA_REF_SPED: Integer;
    FID_CONTABIL_CONTA: Integer;
    FCLASSIFICACAO: String;
    FTIPO: String;
    FDESCRICAO: String;
    FDATA_INCLUSAO: TDateTime;
    FSITUACAO: String;
    FNATUREZA: String;
    FPATRIMONIO_RESULTADO: String;
    FLIVRO_CAIXA: String;
    FDFC: String;
    FORDEM: String;
    FCODIGO_REDUZIDO: String;
    FCODIGO_EFD: String;

    FPlanoContaNome: String;
    FPlanoContaSpedDescricao: String;
    FContabilContaPai: String;

    FPlanoContaVO: TPlanoContaVO;
    FPlanoContaRefSpedVO: TPlanoContaRefSpedVO;
    FContabilContaPaiVO: TContabilContaVO;

  public 
    destructor Destroy; override;
    function ToJSON: TJSONValue; override;

    [TId('ID')]
    [TGeneratedValue(sAuto)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property Id: Integer  read FID write FID;

    [TColumn('ID_PLANO_CONTA','Id Plano Conta',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdPlanoConta: Integer  read FID_PLANO_CONTA write FID_PLANO_CONTA;
    [TColumn('PLANO_CONTA.NOME', 'Plano Conta', 250, [ldGrid, ldLookup, ldComboBox], True, 'PLANO_CONTA', 'ID_PLANO_CONTA', 'ID')]
    property PlanoContaNome: String read FPlanoContaNome write FPlanoContaNome;

    [TColumn('ID_PLANO_CONTA_REF_SPED','Id Plano Conta Ref Sped',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdPlanoContaRefSped: Integer  read FID_PLANO_CONTA_REF_SPED write FID_PLANO_CONTA_REF_SPED;
    [TColumn('PLANO_CONTA_REF_SPED.DESCRICAO', 'Plano Conta Sped', 250, [ldGrid, ldLookup, ldComboBox], True, 'PLANO_CONTA_REF_SPED', 'ID_PLANO_CONTA_REF_SPED', 'ID')]
    property PlanoContaSpedDescricao: String read FPlanoContaSpedDescricao write FPlanoContaSpedDescricao;

    [TColumn('ID_CONTABIL_CONTA','Id Contabil Conta',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdContabilConta: Integer  read FID_CONTABIL_CONTA write FID_CONTABIL_CONTA;
    [TColumn('CONTABIL_CONTA.DESCRICAO', 'Conta Pai', 250, [ldGrid, ldLookup, ldComboBox], True, 'CONTABIL_CONTA', 'ID_CONTABIL_CONTA', 'ID')]
    property ContabilContaPai: String read FContabilContaPai write FContabilContaPai;

    [TColumn('CLASSIFICACAO','Classificacao',240,[ldGrid, ldLookup, ldCombobox], False)]
    property Classificacao: String  read FCLASSIFICACAO write FCLASSIFICACAO;
    [TColumn('TIPO','Tipo',8,[ldGrid, ldLookup, ldCombobox], False)]
    property Tipo: String  read FTIPO write FTIPO;
    [TColumn('DESCRICAO','Descricao',450,[ldGrid, ldLookup, ldCombobox], False)]
    property Descricao: String  read FDESCRICAO write FDESCRICAO;
    [TColumn('DATA_INCLUSAO','Data Inclusao',80,[ldGrid, ldLookup, ldCombobox], False)]
    property DataInclusao: TDateTime  read FDATA_INCLUSAO write FDATA_INCLUSAO;
    [TColumn('SITUACAO','Situacao',8,[ldGrid, ldLookup, ldCombobox], False)]
    property Situacao: String  read FSITUACAO write FSITUACAO;
    [TColumn('NATUREZA','Natureza',8,[ldGrid, ldLookup, ldCombobox], False)]
    property Natureza: String  read FNATUREZA write FNATUREZA;
    [TColumn('PATRIMONIO_RESULTADO','Patrimonio Resultado',8,[ldGrid, ldLookup, ldCombobox], False)]
    property PatrimonioResultado: String  read FPATRIMONIO_RESULTADO write FPATRIMONIO_RESULTADO;
    [TColumn('LIVRO_CAIXA','Livro Caixa',8,[ldGrid, ldLookup, ldCombobox], False)]
    property LivroCaixa: String  read FLIVRO_CAIXA write FLIVRO_CAIXA;
    [TColumn('DFC','Dfc',8,[ldGrid, ldLookup, ldCombobox], False)]
    property Dfc: String  read FDFC write FDFC;
    [TColumn('ORDEM','Ordem',160,[ldGrid, ldLookup, ldCombobox], False)]
    property Ordem: String  read FORDEM write FORDEM;
    [TColumn('CODIGO_REDUZIDO','Codigo Reduzido',80,[ldGrid, ldLookup, ldCombobox], False)]
    property CodigoReduzido: String  read FCODIGO_REDUZIDO write FCODIGO_REDUZIDO;
    [TColumn('CODIGO_EFD','Codigo Efd',16,[ldGrid, ldLookup, ldCombobox], False)]
    property CodigoEfd: String  read FCODIGO_EFD write FCODIGO_EFD;

    [TAssociation(False, 'ID', 'ID_PLANO_CONTA', 'PLANO_CONTA')]
    property PlanoContaVO: TPlanoContaVO read FPlanoContaVO write FPlanoContaVO;

    [TAssociation(False, 'ID', 'ID_PLANO_CONTA_REF_SPED', 'PLANO_CONTA_REF_SPED')]
    property PlanoContaRefSpedVO: TPlanoContaRefSpedVO read FPlanoContaRefSpedVO write FPlanoContaRefSpedVO;

    [TAssociation(False, 'ID', 'ID_CONTABIL_CONTA', 'CONTABIL_CONTA')]
    property ContabilContaPaiVO: TContabilContaVO read FContabilContaPaiVO write FContabilContaPaiVO;

  end;

implementation

destructor TContabilContaVO.Destroy;
begin
  if Assigned(FPlanoContaVO) then
    FPlanoContaVO.Free;
  if Assigned(FPlanoContaRefSpedVO) then
    FPlanoContaRefSpedVO.Free;
  if Assigned(FContabilContaPaiVO) then
    FContabilContaPaiVO.Free;
  inherited;
end;

function TContabilContaVO.ToJSON: TJSONValue;
var
  Serializa: TJSONMarshal;
begin
  Serializa := TJSONMarshal.Create(TJSONConverter.Create);
  try
    // Campos Transientes
     if Assigned(Self.FPlanoContaVO) then
       Self.PlanoContaNome := Self.FPlanoContaVO.Nome;
     if Assigned(Self.FPlanoContaRefSpedVO) then
       Self.PlanoContaSpedDescricao := Self.FPlanoContaRefSpedVO.Descricao;
     if Assigned(Self.FContabilContaPaiVO) then
       Self.ContabilContaPai := Self.FContabilContaPaiVO.Descricao;

  Exit(serializa.Marshal(Self));
  finally
    Serializa.Free;
  end;
end;


end.
