{*******************************************************************************
Title: T2Ti ERP                                                                 
Description:  VO  relacionado à tabela [FORNECEDOR] 
                                                                                
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
                                                                                
t2ti.com@gmail.com | fernandololiver@gmail.com
@author Albert Eije (T2Ti.COM) | Fernando L Oliveira
@version 1.0                                                                    
*******************************************************************************}
unit FornecedorVO;

interface

uses
  JsonVO, Atributos, Classes, Constantes, Generics.Collections, DBXJSON, DBXJSONReflect, SysUtils,
  ContabilContaVO, PessoaVO, AtividadeForCliVO, SituacaoForCliVO;

type
  [TEntity]
  [TTable('FORNECEDOR')]
  TFornecedorVO = class(TJsonVO)
  private
    FID: Integer;
    FID_CONTABIL_CONTA: Integer;
    FID_PESSOA: Integer;
    FID_ATIVIDADE_FOR_CLI: Integer;
    FID_SITUACAO_FOR_CLI: Integer;
    FDESDE: TDateTime;
    FOPTANTE_SIMPLES_NACIONAL: String;
    FLOCALIZACAO: String;
    FDATA_CADASTRO: TDateTime;
    FSOFRE_RETENCAO: String;
    FCHEQUE_NOMINAL_A: String;
    FOBSERVACAO: String;
    FCONTA_REMETENTE: String;
    FPRAZO_MEDIO_ENTREGA: Integer;
    FGERA_FATURAMENTO: String;
    FNUM_DIAS_PRIMEIRO_VENCIMENTO: Integer;
    FNUM_DIAS_INTERVALO: Integer;
    FQUANTIDADE_PARCELAS: Integer;


    FContabilContaClassificacao: String;
    FPessoaNome: String;
    FAtividadeForCliNome: String;
    FSituacaoForCliNome: String;


    FContabilContaVO: TContabilContaVO;
    FPessoaVO: TPessoaVO;
    FAtividadeForCliVO: TAtividadeForCliVO;
    FSituacaoForCliVO: TSituacaoForCliVO;

  public
    destructor Destroy; override;
    function ToJSON: TJSONValue; override;

    [TId('ID')]
    [TGeneratedValue(sAuto)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property Id: Integer  read FID write FID;
    // Contabil Conta
    [TColumn('ID_CONTABIL_CONTA','Id Contabil Conta',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdContabilConta: Integer  read FID_CONTABIL_CONTA write FID_CONTABIL_CONTA;
    [TColumn('CONTABIL_CONTA.CLASSIFICACAO', 'Conta Contábil', 150, [ldGrid], True, 'CONTABIL_CONTA', 'ID_CONTABIL_CONTA', 'ID')]
    property ContabilContaClassificacao: String read FContabilContaClassificacao write FContabilContaClassificacao;
    // Pessoa
    [TColumn('ID_PESSOA','Id Pessoa',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdPessoa: Integer  read FID_PESSOA write FID_PESSOA;
    [TColumn('PESSOA.NOME', 'Nome', 250, [ldGrid, ldLookup, ldComboBox], True, 'PESSOA', 'ID_PESSOA', 'ID')]
    property PessoaNome: String read FPessoaNome write FPessoaNome;
    // Atividade For Cli
    [TColumn('ID_ATIVIDADE_FOR_CLI','Id Atividade For Cli',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdAtividadeForCli: Integer  read FID_ATIVIDADE_FOR_CLI write FID_ATIVIDADE_FOR_CLI;
    [TColumn('ATIVIDADEFORCLI.NOME', 'Atividade', 150, [ldGrid, ldLookup, ldComboBox], True, 'ATIVIDADE_FOR_CLI', 'ID_ATIVIDADE_FOR_CLI', 'ID')]
    property AtividadeForCliNome: String read FAtividadeForCliNome write FAtividadeForCliNome;
    // Situação For Cli
    [TColumn('ID_SITUACAO_FOR_CLI','Id Situacao For Cli',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdSituacaoForCli: Integer  read FID_SITUACAO_FOR_CLI write FID_SITUACAO_FOR_CLI;
    [TColumn('SITUACAOFORCLI.NOME', 'Nome', 250, [ldGrid, ldLookup, ldComboBox], True, 'SITUACAO_FOR_CLI', 'ID_SITUACAO_FOR_CLI', 'ID')]
    property SituacaoForCliNome: String read FSituacaoForCliNome write FsituacaoForCliNome;


    [TColumn('DESDE','Desde',80,[ldGrid, ldLookup, ldCombobox], False)]
    property Desde: TDateTime  read FDESDE write FDESDE;
    [TColumn('OPTANTE_SIMPLES_NACIONAL','Optante Simples Nacional',8,[ldGrid, ldLookup, ldCombobox], False)]
    property OptanteSimplesNacional: String  read FOPTANTE_SIMPLES_NACIONAL write FOPTANTE_SIMPLES_NACIONAL;
    [TColumn('LOCALIZACAO','Localizacao',8,[ldGrid, ldLookup, ldCombobox], False)]
    property Localizacao: String  read FLOCALIZACAO write FLOCALIZACAO;
    [TColumn('DATA_CADASTRO','Data Cadastro',80,[ldGrid, ldLookup, ldCombobox], False)]
    property DataCadastro: TDateTime  read FDATA_CADASTRO write FDATA_CADASTRO;
    [TColumn('SOFRE_RETENCAO','Sofre Retencao',8,[ldGrid, ldLookup, ldCombobox], False)]
    property SofreRetencao: String  read FSOFRE_RETENCAO write FSOFRE_RETENCAO;
    [TColumn('CHEQUE_NOMINAL_A','Cheque Nominal A',450,[ldGrid, ldLookup, ldCombobox], False)]
    property ChequeNominalA: String  read FCHEQUE_NOMINAL_A write FCHEQUE_NOMINAL_A;
    [TColumn('OBSERVACAO','Observacao',450,[ldGrid, ldLookup, ldCombobox], False)]
    property Observacao: String  read FOBSERVACAO write FOBSERVACAO;
    [TColumn('CONTA_REMETENTE','Conta Remetente',240,[ldGrid, ldLookup, ldCombobox], False)]
    property ContaRemetente: String  read FCONTA_REMETENTE write FCONTA_REMETENTE;
    [TColumn('PRAZO_MEDIO_ENTREGA','Prazo Medio Entegra',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property PrazoMedioEntrega: Integer  read FPRAZO_MEDIO_ENTREGA write FPRAZO_MEDIO_ENTREGA;
    [TColumn('GERA_FATURAMENTO','Gera Faturamento',8,[ldGrid, ldLookup, ldCombobox], False)]
    property GeraFaturamento: String  read FGERA_FATURAMENTO write FGERA_FATURAMENTO;
    [TColumn('NUM_DIAS_PRIMEIRO_VENCIMENTO','Numero Dias Primeiro Venciment',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property NumeroDiasPrimeiroVencimento: Integer  read FNUM_DIAS_PRIMEIRO_VENCIMENTO write FNUM_DIAS_PRIMEIRO_VENCIMENTO;
    [TColumn('NUM_DIAS_INTERVALO','Numero Dias Intervalo',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property NumeroDiasIntervalo: Integer  read FNUM_DIAS_INTERVALO write FNUM_DIAS_INTERVALO;
    [TColumn('QUANTIDADE_PARCELAS','Quantidade Parcelas',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property QuantidadeParcelas: Integer  read FQUANTIDADE_PARCELAS write FQUANTIDADE_PARCELAS;


    [TAssociation(False,'ID','ID_CONTABIL_CONTA','CONTABIL_CONTA')]
    property ContabilContaVO: TContabilContaVO read FContabilContaVO write FContabilContaVO;

    [TAssociation(False, 'ID', 'ID_PESSOA', 'PESSOA')]
    property PessoaVO: TPessoaVO read FPessoaVO write FPessoaVO;

    [TAssociation(False, 'ID', 'ID_ATIVIDADE_FOR_CLI', 'ATIVIDADE_FOR_CLI')]
    property AtividadeForCliVO: TAtividadeForCliVO read FAtividadeForCliVO write FAtividadeForCliVO;

    [TAssociation(False, 'ID', 'ID_SITUACAO_FOR_CLI', 'SITUACAO_FOR_CLI')]
    property SituacaoForCliVO: TSituacaoForCliVO read FSituacaoForCliVO write FSituacaoForCliVO;

  end;

implementation

destructor TFornecedorVO.Destroy;
begin
  if Assigned(FContabilContaVO) then
    FContabilContaVO.Free;
  if Assigned(FPessoaVO) then
    FPessoaVO.Free;
  if Assigned(FAtividadeForCliVO) then
    FAtividadeForCliVO.Free;
  if Assigned(FSituacaoForCliVO) then
    FSituacaoForCliVO.Free;
  inherited;
end;

function TFornecedorVO.ToJSON: TJSONValue;
var
  Serializa: TJSONMarshal;
begin
  Serializa := TJSONMarshal.Create(TJSONConverter.Create);
  try
    if Assigned(Self.ContabilContaVO) then
      Self.ContabilContaClassificacao := Self.ContabilContaVO.Classificacao;
    if Assigned(Self.PessoaVO) then
      Self.PessoaNome := Self.PessoaVO.Nome;
    if Assigned(Self.AtividadeForCliVO) then
      Self.AtividadeForCliNome := Self.AtividadeForCliVO.Nome;
    if Assigned(Self.SituacaoForCliVO) then
      Self.SituacaoForCliNome := Self.SituacaoForCliVO.Nome;


    Exit(Serializa.Marshal(Self));
  finally
    Serializa.Free;
  end;
end;

end.
