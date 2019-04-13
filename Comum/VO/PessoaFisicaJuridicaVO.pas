{*******************************************************************************
Title: T2Ti ERP
Description:  VO transiente para carregar os dados das tabelas [PESSOA, PESSOA_FISICA, PESSOA_JURIDICA]

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

@author Albert Eije (t2ti.com@gmail.com)
@version 1.0
*******************************************************************************}
unit PessoaFisicaJuridicaVO;

interface

uses
  JsonVO, Atributos, Classes, Constantes, Generics.Collections, DBXJSON, DBXJSONReflect, SysUtils,
  PessoaFisicaVO, PessoaJuridicaVO;

type
  [TEntity]
  [TTable('PESSOA')]
  TPessoaVO = class(TJsonVO)
  private
    FID: Integer;
    FNOME: String;
    FTIPO: String;
    FEMAIL: String;
    FSITE: String;
    FCLIENTE: String;
    FFORNECEDOR: String;
    FCOLABORADOR: String;
    FCONVENIO: String;
    FCONTADOR: String;
    FTRANSPORTADORA: String;

    FPessoaFisicaVO: TPessoaFisicaVO;
    FPessoaJuridicaVO: TPessoaJuridicaVO;
  public
    destructor Destroy; override;

    [TId('ID')]
    [TGeneratedValue(sAuto)]
    property Id: Integer  read FID write FID;
    [TColumn('NOME','Nome',[ldGrid, ldLookup,ldComboBox] ,False)]
    property Nome: String  read FNOME write FNOME;
    [TColumn('TIPO','Tipo',40,[ldGrid, ldLookup] ,False)]
    property Tipo: String  read FTIPO write FTIPO;
    [TColumn('EMAIL','Email',[ldGrid, ldLookup] ,False)]
    property Email: String  read FEMAIL write FEMAIL;
    [TColumn('SITE','Site',[ldGrid, ldLookup] ,False)]
    property Site: String  read FSITE write FSITE;
    [TColumn('CLIENTE','Cliente',50,[],False)]
    property Cliente: String  read FCLIENTE write FCLIENTE;
    [TColumn('FORNECEDOR','Fornecedor',60,[],False)]
    property Fornecedor: String  read FFORNECEDOR write FFORNECEDOR;
    [TColumn('COLABORADOR','Colaborador',70,[],False)]
    property Colaborador: String  read FCOLABORADOR write FCOLABORADOR;
    [TColumn('CONVENIO','Convênio',50,[],False)]
    property Convenio: String  read FCONVENIO write FCONVENIO;
    [TColumn('CONTADOR','Contador',50,[],False)]
    property Contador: String  read FCONTADOR write FCONTADOR;
    [TColumn('TRANSPORTADORA','Transportadora',80,[],False)]
    property Transportadora: String  read FTRANSPORTADORA write FTRANSPORTADORA;

    [TAssociation(False,'ID_PESSOA','ID')]
    property PessoaFisicaVO: TPessoaFisicaVO read FPessoaFisicaVO write FPessoaFisicaVO;

    [TAssociation(False,'ID_PESSOA','ID')]
    property PessoaJuridicaVO: TPessoaJuridicaVO read FPessoaJuridicaVO write FPessoaJuridicaVO;
  end;

implementation

{ TPessoaVO }

destructor TPessoaVO.Destroy;
begin
  if Assigned(FPessoaFisicaVO) then
    FPessoaFisicaVO.Free;

  if Assigned(FPessoaJuridicaVO) then
    FPessoaJuridicaVO.Free;

  inherited;
end;

end.
