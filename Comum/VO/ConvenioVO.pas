{ *******************************************************************************
  Title: T2Ti ERP
  Description:  VO  relacionado à tabela [CONVENIO]

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
  ******************************************************************************* }
unit ConvenioVO;

interface

uses
  JsonVO, Atributos, Classes, Constantes, Generics.Collections, DBXJSON, DBXJSONReflect, SysUtils,
  PessoaVO, ContabilContaVO;

type
  [TEntity]
  [TTable('CONVENIO')]

  TConvenioVO = class(TJsonVO)
  private
    FID: Integer;
    FID_PESSOA: Integer;
    FID_CONTABIL_CONTA: Integer;
    FID_EMPRESA: Integer;
    FDESCONTO: Extended;
    FDATA_VENCIMENTO: TDateTime;
    FLOGRADOURO: String;
    FNUMERO: String;
    FBAIRRO: String;
    FMUNICIPIO_IBGE: Integer;
    FUF: String;
    FCONTATO: String;
    FTELEFONE: String;
    FDATA_CADASTRO: TDateTime;
    FDESCRICAO: String;

    FPessoaNome: String;
    FContabilContaClassificacao: String;

    FPessoaVO: TPessoaVO;
    FContabilContaVO: TContabilContaVO;

  public
    destructor Destroy; override;
    function ToJSON: TJSONValue; override;

    [TId('ID')]
    [TGeneratedValue(sAuto)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property Id: Integer read FID write FID;

    [TColumn('ID_PESSOA', 'Id Pessoa', 80, [ldGrid, ldComboBox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdPessoa: Integer read FID_PESSOA write FID_PESSOA;

    [TColumn('PESSOA.NOME', 'Pessoa Nome', 300, [ldGrid, ldLookup, ldComboBox], True, 'PESSOA', 'ID_PESSOA', 'ID')]
    property PessoaNome: String read FPessoaNome write FPessoaNome;

    [TColumn('ID_CONTABIL_CONTA', 'Id Conta', 80, [], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdContabilConta: Integer read FID_CONTABIL_CONTA write FID_CONTABIL_CONTA;

    [TColumn('CONTABIL_CONTA.CLASSIFICACAO', 'Conta Contábil', 150, [ldGrid], True, 'CONTABIL_CONTA', 'ID_CONTABIL_CONTA', 'ID')]
    property ContabilContaClassificacao: String read FContabilContaClassificacao write FContabilContaClassificacao;

    [TColumn('ID_EMPRESA', 'Id Empresa', 80, [], False)]
    property IdEmpresa: Integer read FID_EMPRESA write FID_EMPRESA;

    [TColumn('DESCONTO', 'Desconto', 128, [ldGrid, ldLookup, ldComboBox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property Desconto: Extended read FDESCONTO write FDESCONTO;

    [TColumn('DATA_VENCIMENTO', 'Data Vencimento', 120, [ldGrid, ldLookup], False)]
    property DataVencimento: TDateTime read FDATA_VENCIMENTO write FDATA_VENCIMENTO;

    [TColumn('LOGRADOURO', 'Logradouro', 300, [ldGrid, ldLookup], False)]
    property Logradouro: String read FLOGRADOURO write FLOGRADOURO;

    [TColumn('NUMERO', 'Número', 80, [ldGrid, ldLookup], False)]
    property Numero: String read FNUMERO write FNUMERO;

    [TColumn('BAIRRO', 'Bairro', 300, [ldGrid, ldLookup], False)]
    property Bairro: String read FBAIRRO write FBAIRRO;

    [TColumn('MUNICIPIO_IBGE', 'Município Ibge', 120, [ldGrid, ldLookup], False)]
    [TFormatter(ftInteiroComSeparador, taLeftJustify)]
    property MunicipioIbge: Integer read FMUNICIPIO_IBGE write FMUNICIPIO_IBGE;

    [TColumn('UF', 'Uf', 25, [ldGrid, ldLookup], False)]
    [TFormatter(taLeftJustify)]
    property Uf: String read FUF write FUF;

    [TColumn('CONTATO', 'Contato', 240, [ldGrid, ldLookup], False)]
    property Contato: String read FCONTATO write FCONTATO;

    [TColumn('TELEFONE', 'Telefone', 112, [ldGrid, ldLookup], False)]
    [TFormatter(ftTelefone, taLeftJustify)]
    property Telefone: String read FTELEFONE write FTELEFONE;

    [TColumn('DATA_CADASTRO', 'Data Cadastro', 120, [ldGrid, ldLookup, ldComboBox], False)]
    property DataCadastro: TDateTime read FDATA_CADASTRO write FDATA_CADASTRO;

    [TColumn('DESCRICAO', 'Descrição', 450, [ldGrid, ldLookup], False)]
    property Descricao: String read FDESCRICAO write FDESCRICAO;

    [TAssociation(False, 'ID', 'ID_PESSOA', 'PESSOA')]
    property PessoaVO: TPessoaVO read FPessoaVO write FPessoaVO;

    [TAssociation(False, 'ID', 'ID_CONTABIL_CONTA', 'CONTABIL_CONTA')]
    property ContabilContaVO: TContabilContaVO read FContabilContaVO write FContabilContaVO;
  end;

implementation

destructor TConvenioVO.Destroy;
begin
  if Assigned(FPessoaVO) then
    FPessoaVO.Free;
  if Assigned(FContabilContaVO) then
    FContabilContaVO.Free;
  inherited;
end;

function TConvenioVO.ToJSON: TJSONValue;
var
  Serializa: TJSONMarshal;
begin
  Serializa := TJSONMarshal.Create(TJSONConverter.Create);
  try
    if Assigned(Self.PessoaVO) then
      Self.PessoaNome := Self.PessoaVO.Nome;
    if Assigned(Self.ContabilContaVO) then
      Self.ContabilContaClassificacao := Self.ContabilContaVO.Classificacao;

    Exit(Serializa.Marshal(Self));
  finally
    Serializa.Free;
  end;
end;

end.

