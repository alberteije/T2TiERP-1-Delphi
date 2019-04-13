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

@author Albert Eije (T2Ti.COM)  | Eri Brito
@version 1.0
*******************************************************************************}
unit PreVendaController;

interface

uses
  Classes, SQLExpr, SysUtils, PreVendaDetalheVO, PreVendaCabecalhoVO, Generics.Collections, DB;

type
  TPreVendaController = class
  protected
  public
    function InserePreVenda(PreVendaCabecalho:TPreVendaCabecalhoVO;ListaPreVendaDetalhe:TObjectList<TPreVendaDetalheVO>): Integer;
  end;

implementation

uses UDataModule;

var
  ConsultaSQL: String;
  Query: TSQLQuery;

function TPreVendaController.InserePreVenda(PreVendaCabecalho:TPreVendaCabecalhoVO;ListaPreVendaDetalhe:TObjectList<TPreVendaDetalheVO>): Integer;
var
  i:integer;
begin
  ConsultaSQL :=
    'insert into PRE_VENDA_CABECALHO (' +
    'ID_PESSOA,' +
    'ID_EMPRESA,' +
    'NOME_DESTINATARIO,' +
    'CPF_CNPJ_DESTINATARIO,' +
    'DATA_PV,' +
    'HORA_PV,' +
    'SITUACAO,' +
    'TAXA_ACRESCIMO,' +
    'ACRESCIMO,' +
    'TAXA_DESCONTO,' +
    'DESCONTO,' +
    'SUBTOTAL,' +
    'VALOR) values (' +
    ':pIdCliente,' +
    ':pIdEmpresa,' +
    ':pDestinatario,' +
    ':pCPFCNPJ,' +
    ':pDataEmissao,' +
    ':pHoraEmissao,' +
    ':pSituacao,' +
    ':pTaxaAcrescimo,' +
    ':pAcrescimo,' +
    ':pTaxaDesconto,' +
    ':pDesconto,' +
    ':pSubTotal,' +
    ':pValor)';
  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;

      Query.ParamByName('pIdCliente').AsInteger := PreVendaCabecalho.IdPessoa;
      Query.ParamByName('pIdEmpresa').AsInteger := PreVendaCabecalho.IdEmpresa;
      Query.ParamByName('pDestinatario').AsString := PreVendaCabecalho.NomeDestinatario;
      Query.ParamByName('pCPFCNPJ').AsString := PreVendaCabecalho.CpfCnpjDestinatario;
      Query.ParamByName('pDataEmissao').AsString := PreVendaCabecalho.DataPv;
      Query.ParamByName('pHoraEmissao').AsString := PreVendaCabecalho.HoraPv;
      Query.ParamByName('pSituacao').AsString := PreVendaCabecalho.Situacao;
      Query.ParamByName('pTaxaAcrescimo').AsFloat := PreVendaCabecalho.TaxaAcrescimo;
      Query.ParamByName('pAcrescimo').AsFloat := PreVendaCabecalho.Acrescimo;
      Query.ParamByName('pTaxaDesconto').AsFloat := PreVendaCabecalho.TaxaDesconto;
      Query.ParamByName('pDesconto').AsFloat := PreVendaCabecalho.Desconto;
      Query.ParamByName('pSubTotal').AsFloat := PreVendaCabecalho.SubTotal;
      Query.ParamByName('pValor').AsFloat := PreVendaCabecalho.Valor;
      Query.ExecSQL();

      ConsultaSQL := 'select max(ID) as ID from PRE_VENDA_CABECALHO';
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
    'insert into PRE_VENDA_DETALHE (' +
    'ID_PRODUTO,' +
    'ID_PRE_VENDA_CABECALHO,' +
    'ITEM,' +
    'QUANTIDADE,' +
    'VALOR_UNITARIO,' +
    'VALOR_TOTAL,' +
    'CANCELADO,' +
    'GTIN_PRODUTO,' +
    'NOME_PRODUTO,' +
    'UNIDADE_PRODUTO,'+
    'ECF_ICMS_ST) values (' +
    ':pIdProduto,' +
    ':pIdPvCabecalho,' +
    ':pItem,' +
    ':pQuantidade,' +
    ':pValorUnitario,' +
    ':pValorTotal,' +
    ':pCancelado,' +
    ':pGtinProduto,' +
    ':pNomeProduto,' +
    ':pUnidadeProduto,'+
    ':pEcfIcmsSt)';
  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      for i := 0 to ListaPreVendaDetalhe.Count - 1 do
      begin
        Query.ParamByName('pIdProduto').AsInteger := TPreVendaDetalheVO(ListaPreVendaDetalhe.Items[i]).IdProduto;
        Query.ParamByName('pIdPvCabecalho').AsInteger := PreVendaCabecalho.Id;
        Query.ParamByName('pItem').AsInteger := TPreVendaDetalheVO(ListaPreVendaDetalhe.Items[i]).Item;
        Query.ParamByName('pQuantidade').AsFloat := TPreVendaDetalheVO(ListaPreVendaDetalhe.Items[i]).Quantidade;
        Query.ParamByName('pValorUnitario').AsFloat := TPreVendaDetalheVO(ListaPreVendaDetalhe.Items[i]).ValorUnitario;
        Query.ParamByName('pValorTotal').AsFloat := TPreVendaDetalheVO(ListaPreVendaDetalhe.Items[i]).ValorTotal;
        Query.ParamByName('pCancelado').AsString := TPreVendaDetalheVO(ListaPreVendaDetalhe.Items[i]).Cancelado;
        Query.ParamByName('pGtinProduto').AsString := TPreVendaDetalheVO(ListaPreVendaDetalhe.Items[i]).GtinProduto;
        Query.ParamByName('pNomeProduto').AsString := TPreVendaDetalheVO(ListaPreVendaDetalhe.Items[i]).NomeProduto;
        Query.ParamByName('pUnidadeProduto').AsString := TPreVendaDetalheVO(ListaPreVendaDetalhe.Items[i]).UnidadeProduto;
        Query.ParamByName('pEcfIcmsSt').AsString := TPreVendaDetalheVO(ListaPreVendaDetalhe.Items[i]).EcfIcmsSt;
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
