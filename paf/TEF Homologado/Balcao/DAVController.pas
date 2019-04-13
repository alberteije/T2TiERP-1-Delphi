{*******************************************************************************
Title: T2Ti ERP
Description: Classe de controle do DAV para o sistema de balcão do PAF-ECF.

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

@author Albert Eije (T2Ti.COM)
@version 1.0
*******************************************************************************}
unit DAVController;

interface

uses
  Classes, SQLExpr, SysUtils, DAVDetalheVO, Generics.Collections, DB, DAVVO;

type
  TDAVController = class
  protected
  public
    Function InsereDAV(DAVCabecalho:TDAVVO;ListaDAVDetalhe:TObjectList<TDAVDetalheVO>):Integer;
  end;

implementation

uses UDataModule;

var
  ConsultaSQL: String;
  Query: TSQLQuery;

Function TDAVController.InsereDAV(DAVCabecalho:TDAVVO;ListaDAVDetalhe:TObjectList<TDAVDetalheVO>):Integer;
var
  i:integer;
begin
  //insere o novo dav no cabecalho
  ConsultaSQL :=
    'insert into ECF_DAV_CABECALHO (' +
    'NOME_DESTINATARIO,' +
    'CPF_CNPJ_DESTINATARIO,' +
    'DATA_HORA_EMISSAO,' +
    'VALOR,' +
    'SITUACAO) values (' +
    ':pDestinatario,' +
    ':pCPFCNPJ,' +
    ':pDataHoraEmissao,' +
    ':pValor,' +
    ':pSituacao)';
  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.ParamByName('pDestinatario').AsString := DAVCabecalho.NomeDestinatario;
      Query.ParamByName('pCPFCNPJ').AsString := DAVCabecalho.CpfCnpjDestinatario;
      Query.ParamByName('pValor').AsFloat := DAVCabecalho.Valor;
      Query.ParamByName('pDataHoraEmissao').AsString := FormatDateTime('yyyy-mm-dd hh:nn:ss', now);
      Query.ParamByName('pSituacao').AsString := 'P';
      Query.ExecSQL();

      { TODO : Esse sistema pode estar rodando em rede. E agora? Como pegar o ID correto do DAV? }
      ConsultaSQL := 'select max(ID) as ID from ECF_DAV_CABECALHO';
      Query.sql.Text := ConsultaSQL;
      Query.Open();

      DAVCabecalho.Id := Query.FieldByName('ID').AsInteger;
    except
    end;
  finally
    Query.Free;
  end;

  //insere os dados na tabela de detalhes
  ConsultaSQL :=
    'insert into ECF_DAV_DETALHE (' +
    'ID_PRODUTO,' +
    'ID_ECF_DAV,' +
    'QUANTIDADE,' +
    'VALOR_UNITARIO,' +
    'VALOR_TOTAL) values (' +
    ':pIdProduto,' +
    ':pIdDav,' +
    ':pQuantidade,' +
    ':pValorUnitario,' +
    ':pValorTotal)';
  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      for i := 0 to ListaDAVDetalhe.Count - 1 do
      begin
        Query.ParamByName('pIdProduto').AsInteger := TDAVDetalheVO(ListaDAVDetalhe.Items[i]).IdProduto;
        Query.ParamByName('pIdDav').AsInteger := DAVCabecalho.Id;
        Query.ParamByName('pQuantidade').AsFloat := TDAVDetalheVO(ListaDAVDetalhe.Items[i]).Quantidade;
        Query.ParamByName('pValorUnitario').AsFloat := TDAVDetalheVO(ListaDAVDetalhe.Items[i]).ValorUnitario;
        Query.ParamByName('pValorTotal').AsFloat := TDAVDetalheVO(ListaDAVDetalhe.Items[i]).ValorTotal;
        Query.ExecSQL();
      end;
    except
    end;

    Result := DAVCabecalho.Id;
  finally
    Query.Free;
  end;
end;

end.
