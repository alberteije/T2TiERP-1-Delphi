{*******************************************************************************
Title: T2Ti ERP
Description: Classe de controle da pre-venda para o sistema de balcão do PAF-ECF.

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
unit PreVendaController;

interface

uses
  Classes, SQLExpr, SysUtils, PreVendaDetalheVO, PreVendaVO, Generics.Collections, DB;

type
  TPreVendaController = class
  protected
  public
    function InserePreVenda(PreVendaCabecalho:TPreVendaVO;ListaPreVendaDetalhe:TObjectList<TPreVendaDetalheVO>): Integer;
  end;

implementation

uses UDataModule;

var
  ConsultaSQL: String;
  Query: TSQLQuery;

function TPreVendaController.InserePreVenda(PreVendaCabecalho:TPreVendaVO;ListaPreVendaDetalhe:TObjectList<TPreVendaDetalheVO>): Integer;
var
  i:integer;
begin
  //insere a PV no cabecalho
  ConsultaSQL :=
    'insert into ECF_PRE_VENDA_CABECALHO (' +
    'DATA_HORA_PV,' +
    'VALOR,' +
    'SITUACAO) values (' +
    ':pDataHoraEmissao,' +
    ':pValor,' +
    ':pSituacao)';
  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.ParamByName('pDataHoraEmissao').AsString := FormatDateTime('yyyy-mm-dd hh:nn:ss', now);
      Query.ParamByName('pValor').AsFloat := PreVendaCabecalho.Valor;
      Query.ParamByName('psituacao').AsString := 'P';
      Query.ExecSQL();

      { TODO : Esse sistema pode estar rodando em rede. E agora? Como pegar o ID correto da PV? }
      ConsultaSQL := 'select max(ID) as ID from ECF_PRE_VENDA_CABECALHO';
      Query.sql.Text := ConsultaSQL;
      Query.Open();

      PreVendaCabecalho.Id := Query.FieldByName('ID').AsInteger;
    except
    end;
  finally
    Query.Free;
  end;

  //insere os dados na tabela de detalhes
  ConsultaSQL :=
    'insert into ECF_PRE_VENDA_DETALHE (' +
    'ID_PRODUTO,' +
    'ID_ECF_PRE_VENDA_CABECALHO,' +
    'QUANTIDADE,' +
    'VALOR_UNITARIO,' +
    'VALOR_TOTAL) values (' +
    ':pIdProduto,' +
    ':pIdPreVenda,' +
    ':pQuantidade,' +
    ':pValorUnitario,' +
    ':pValorTotal)';
  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      for i := 0 to ListaPreVendaDetalhe.Count - 1 do
      begin
        Query.ParamByName('pIdProduto').AsInteger := TPreVendaDetalheVO(ListaPreVendaDetalhe.Items[i]).IdProduto;
        Query.ParamByName('pIdPreVenda').AsInteger := PreVendaCabecalho.Id;
        Query.ParamByName('pQuantidade').AsFloat := TPreVendaDetalheVO(ListaPreVendaDetalhe.Items[i]).Quantidade;
        Query.ParamByName('pValorUnitario').AsFloat := TPreVendaDetalheVO(ListaPreVendaDetalhe.Items[i]).ValorUnitario;
        Query.ParamByName('pValorTotal').AsFloat := TPreVendaDetalheVO(ListaPreVendaDetalhe.Items[i]).ValorTotal;
        Query.ExecSQL();
      end;
    except
    end;
  finally
    Query.Free;
  end;

  result := PreVendaCabecalho.Id;
end;


end.
