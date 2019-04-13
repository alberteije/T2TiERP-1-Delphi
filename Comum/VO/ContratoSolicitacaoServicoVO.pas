{*******************************************************************************
Title: T2Ti ERP                                                                 
Description:  VO  relacionado à tabela [CONTRATO_SOLICITACAO_SERVICO] 
                                                                                
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
unit ContratoSolicitacaoServicoVO;

interface

uses
  JsonVO, Atributos, Classes, Constantes, Generics.Collections, DBXJSON, DBXJSONReflect,
  SysUtils, FornecedorPessoaVO, ClientePessoaVO, SetorVO, ColaboradorPessoaVO, ContratoTipoServicoVO;

type
  [TEntity]
  [TTable('CONTRATO_SOLICITACAO_SERVICO')]
  TContratoSolicitacaoServicoVO = class(TJsonVO)
  private
    FID: Integer;
    FID_SETOR: Integer;
    FID_COLABORADOR: Integer;
    FID_CONTRATO_TIPO_SERVICO: Integer;
    FDESCRICAO: String;
    FDATA_SOLICITACAO: TDateTime;
    FDATA_DESEJADA_INICIO: TDateTime;
    FURGENTE: String;
    FSTATUS_SOLICITACAO: String;
    FID_FORNECEDOR: Integer;
    FID_CLIENTE: Integer;

    FFornecedorPessoaNome: String;
    FClientePessoaNome: String;
    FSetorNome: String;
    FColaboradorPessoaNome: String;
    FContratoTipoServicoNome: String;

    FFornecedorVO: TFornecedorVO;
    FClienteVO: TClienteVO;
    FSetorVO: TSetorVO;
    FColaboradorVO: TColaboradorVO;
    FContratoTipoServicoVO: TContratoTipoServicoVO;

  public
    destructor Destroy; override;
    function ToJSON: TJSONValue; override;

    [TId('ID')]
    [TGeneratedValue(sAuto)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property Id: Integer  read FID write FID;

    [TColumn('ID_SETOR','Id Setor',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdSetor: Integer  read FID_SETOR write FID_SETOR;
    [TColumn('SETOR.NOME', 'Setor', 250, [ldGrid, ldLookup, ldComboBox], True, 'SETOR', 'ID_SETOR', 'ID')]
    property SetorNome: String read FSetorNome write FSetorNome;

    [TColumn('ID_COLABORADOR','Id Colaborador',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdColaborador: Integer  read FID_COLABORADOR write FID_COLABORADOR;
    [TColumn('COLABORADOR.PESSOA.NOME', 'Solicitante', 250, [ldGrid, ldLookup, ldComboBox], True, 'COLABORADOR.PESSOA', 'ID_COLABORADOR', 'ID')]
    property ColaboradorPessoaNome: String read FColaboradorPessoaNome write FColaboradorPessoaNome;

    [TColumn('ID_CONTRATO_TIPO_SERVICO','Id Contrato Tipo Servico',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdContratoTipoServico: Integer  read FID_CONTRATO_TIPO_SERVICO write FID_CONTRATO_TIPO_SERVICO;
    [TColumn('CONTRATO_TIPO_SERVICO.NOME', 'Tipo Serviço', 250, [ldGrid, ldLookup, ldComboBox], True, 'CONTRATO_TIPO_SERVICO', 'ID_CONTRATO_TIPO_SERVICO', 'ID')]
    property ContratoTipoServicoNome: String read FContratoTipoServicoNome write FContratoTipoServicoNome;

    [TColumn('DESCRICAO','Descrição',200,[ldGrid, ldLookup, ldCombobox], False)]
    property Descricao: String  read FDESCRICAO write FDESCRICAO;
    [TColumn('DATA_SOLICITACAO','Data Solicitacao',80,[ldGrid, ldLookup, ldCombobox], False)]
    property DataSolicitacao: TDateTime  read FDATA_SOLICITACAO write FDATA_SOLICITACAO;
    [TColumn('DATA_DESEJADA_INICIO','Data Desejada Inicio',80,[ldGrid, ldLookup, ldCombobox], False)]
    property DataDesejadaInicio: TDateTime  read FDATA_DESEJADA_INICIO write FDATA_DESEJADA_INICIO;
    [TColumn('URGENTE','Urgente',8,[ldGrid, ldLookup, ldCombobox], False)]
    property Urgente: String  read FURGENTE write FURGENTE;
    [TColumn('STATUS_SOLICITACAO','Status Solicitacao',120,[ldGrid, ldLookup, ldCombobox], False)]
    property StatusSolicitacao: String  read FSTATUS_SOLICITACAO write FSTATUS_SOLICITACAO;

    [TColumn('ID_FORNECEDOR','Id Fornecedor',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdFornecedor: Integer  read FID_FORNECEDOR write FID_FORNECEDOR;
    [TColumn('FORNECEDOR.PESSOA.NOME', 'Fornecedor', 250, [ldGrid, ldLookup, ldComboBox], True, 'FORNECEDOR', 'ID_FORNECEDOR', 'ID')]
    property FornecedorPessoaNome: String read FFornecedorPessoaNome write FFornecedorPessoaNome;

    [TColumn('ID_CLIENTE','Id Cliente',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdCliente: Integer  read FID_CLIENTE write FID_CLIENTE;
    [TColumn('CLIENTE.PESSOA.NOME', 'Cliente', 250, [ldGrid, ldLookup, ldComboBox], True, 'CLIENTE', 'ID_CLIENTE', 'ID')]
    property ClientePessoaNome: String read FClientePessoaNome write FClientePessoaNome;

    [TAssociation(True, 'ID', 'ID_FORNECEDOR', 'FORNECEDOR')]
    property FornecedorVO: TFornecedorVO read FFornecedorVO write FFornecedorVO;

    [TAssociation(True, 'ID', 'ID_CLIENTE', 'CLIENTE')]
    property ClienteVO: TClienteVO read FClienteVO write FClienteVO;

    [TAssociation(False, 'ID', 'ID_SETOR', 'SETOR')]
    property SetorVO: TSetorVO read FSetorVO write FSetorVO;

    [TAssociation(True, 'ID', 'ID_COLABORADOR', 'COLABORADOR')]
    property ColaboradorVO: TColaboradorVO read FColaboradorVO write FColaboradorVO;

    [TAssociation(False, 'ID', 'ID_CONTRATO_TIPO_SERVICO', 'CONTRATO_TIPO_SERVICO')]
    property ContratoTipoServicoVO: TContratoTipoServicoVO read FContratoTipoServicoVO write FContratoTipoServicoVO;

  end;

implementation

destructor TContratoSolicitacaoServicoVO.Destroy;
begin
  if Assigned(FFornecedorVO) then
    FFornecedorVO.Free;
  if Assigned(FClienteVO) then
    FClienteVO.Free;
  if Assigned(FSetorVO) then
    FSetorVO.Free;
  if Assigned(FColaboradorVO) then
    FColaboradorVO.Free;
  if Assigned(FContratoTipoServicoVO) then
    FContratoTipoServicoVO.Free;
  inherited;
end;

function TContratoSolicitacaoServicoVO.ToJSON: TJSONValue;
var
  Serializa: TJSONMarshal;
begin
  Serializa := TJSONMarshal.Create(TJSONConverter.Create);
  try

    if Assigned(Self.FornecedorVO) then
      Self.FornecedorPessoaNome := Self.FornecedorVO.PessoaVO.Nome;
    if Assigned(Self.ClienteVO) then
      Self.ClientePessoaNome := Self.ClienteVO.PessoaVO.Nome;
    if Assigned(Self.ColaboradorVO) then
      Self.ColaboradorPessoaNome := Self.ColaboradorVO.PessoaVO.Nome;
    if Assigned(Self.SetorVO) then
      Self.SetorNome := Self.SetorVO.Nome;
    if Assigned(Self.ContratoTipoServicoVO) then
      Self.ContratoTipoServicoNome := Self.ContratoTipoServicoVO.Nome;

  Exit(serializa.Marshal(Self));
  finally
    Serializa.Free;
  end;
end;

end.
