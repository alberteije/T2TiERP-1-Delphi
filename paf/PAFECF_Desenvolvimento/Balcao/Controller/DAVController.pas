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

@author Albert Eije (T2Ti.COM) | Eri Brito
@version 1.0
*******************************************************************************}
unit DAVController;

interface

uses
  Classes, SQLExpr, SysUtils, DavDetalheVO, Generics.Collections, DB, DavCabecalhoVO;

type
  TDAVController = class
  protected
  public
    Function InsereDAV(DAVCabecalho:TDavCabecalhoVO; ListaDAVDetalhe:TObjectList<TDAVDetalheVO>): TDavCabecalhoVO;
  end;

implementation

uses UDataModule;

var
  ConsultaSQL: String;
  Query: TSQLQuery;

function TDAVController.InsereDAV(DAVCabecalho: TDavCabecalhoVO; ListaDAVDetalhe:TObjectList<TDAVDetalheVO>): TDavCabecalhoVO;
var
  i: Integer;
  NumeroUltimoDav, NumeroNovoDav: String;
begin
  //insere o novo dav no cabecalho
  ConsultaSQL :=
    'insert into DAV_CABECALHO (' +
    'ID_PESSOA,' +
    'ID_EMPRESA,' +
    'NUMERO_DAV,' +
    'NOME_DESTINATARIO,' +
    'CPF_CNPJ_DESTINATARIO,' +
    'DATA_EMISSAO,' +
    'HORA_EMISSAO,' +
    'SITUACAO,' +
    'TAXA_ACRESCIMO,' +
    'ACRESCIMO,' +
    'TAXA_DESCONTO,' +
    'DESCONTO,' +
    'SUBTOTAL,' +
    'VALOR) values (' +
    ':pIdCliente,' +
    ':pIdEmpresa,' +
    ':pNumeroDav,' +
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
      Query.sql.Text := 'select NUMERO_DAV from DAV_CABECALHO where id = (select max(id) from dav_cabecalho)';
      Query.Open();
      NumeroUltimoDav := Query.FieldByName('NUMERO_DAV').AsString;
      Query.Free;

      if (NumeroUltimoDav = '') or (NumeroUltimoDav = '9999999999') then
        NumeroNovoDav := '0000000001'
      else
      begin
        NumeroNovoDav := FloatToStr(StrToFloat(NumeroUltimoDav) + 1);
        NumeroNovoDav := StringOfChar('0',10-Length(NumeroNovoDav)) + NumeroNovoDav;
      end;

      DavCabecalho.NumeroDav := NumeroNovoDav;

      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.ParamByName('pIdCliente').AsInteger := DAVCabecalho.IdPessoa;
      Query.ParamByName('pIdEmpresa').AsInteger := DAVCabecalho.IdEmpresa;
      Query.ParamByName('pNumeroDav').AsString := NumeroNovoDav;
      Query.ParamByName('pDestinatario').AsString := DAVCabecalho.NomeDestinatario;
      Query.ParamByName('pCPFCNPJ').AsString := DAVCabecalho.CpfCnpjDestinatario;
      Query.ParamByName('pDataEmissao').AsString := DAVCabecalho.DataEmissao;
      Query.ParamByName('pHoraEmissao').AsString := DAVCabecalho.HoraEmissao;
      Query.ParamByName('pSituacao').AsString := DAVCabecalho.Situacao;
      Query.ParamByName('pTaxaAcrescimo').AsFloat := DAVCabecalho.TaxaAcrescimo;
      Query.ParamByName('pAcrescimo').AsFloat := DAVCabecalho.Acrescimo;
      Query.ParamByName('pTaxaDesconto').AsFloat := DAVCabecalho.TaxaDesconto;
      Query.ParamByName('pDesconto').AsFloat := DAVCabecalho.Desconto;
      Query.ParamByName('pSubTotal').AsFloat := DAVCabecalho.SubTotal;
      Query.ParamByName('pValor').AsFloat := DAVCabecalho.Valor;
      Query.ParamByName('pCPFCNPJ').AsString := DAVCabecalho.CpfCnpjDestinatario;
      Query.ExecSQL();

      ConsultaSQL := 'select max(ID) as ID from DAV_CABECALHO';
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
    'insert into DAV_DETALHE (' +
    'ID_PRODUTO,' +
    'ID_DAV_CABECALHO,' +
    'NUMERO_DAV,' +
    'DATA_EMISSAO,' +
    'ITEM,' +
    'QUANTIDADE,' +
    'VALOR_UNITARIO,' +
    'VALOR_TOTAL,' +
    'CANCELADO,' +
    'MESCLA_PRODUTO,' +
    'GTIN_PRODUTO,' +
    'NOME_PRODUTO,' +
    'TOTALIZADOR_PARCIAL,' +
    'UNIDADE_PRODUTO) values (' +
    ':pIdProduto,' +
    ':pIdDavCabecalho,' +
    ':pNumeroDav,' +
    ':pDataEmissao,' +
    ':pItem,' +
    ':pQuantidade,' +
    ':pValorUnitario,' +
    ':pValorTotal,' +
    ':pCancelado,' +
    ':pMesclaProduto,' +
    ':pGtinProduto,' +
    ':pNomeProduto,' +
    ':pTOTALIZADOR_PARCIAL,' +
    ':pUnidadeProduto)';
  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      for i := 0 to ListaDAVDetalhe.Count - 1 do
      begin
        Query.ParamByName('pIdProduto').AsInteger := TDAVDetalheVO(ListaDAVDetalhe.Items[i]).IdProduto;
        Query.ParamByName('pIdDavCabecalho').AsInteger := DAVCabecalho.Id;
        Query.ParamByName('pNumeroDav').AsString := DAVCabecalho.NumeroDav;
        Query.ParamByName('pDataEmissao').AsString := DAVCabecalho.DataEmissao;
        Query.ParamByName('pItem').AsInteger := TDAVDetalheVO(ListaDAVDetalhe.Items[i]).Item;
        Query.ParamByName('pQuantidade').AsFloat := TDAVDetalheVO(ListaDAVDetalhe.Items[i]).Quantidade;
        Query.ParamByName('pValorUnitario').AsFloat := TDAVDetalheVO(ListaDAVDetalhe.Items[i]).ValorUnitario;
        Query.ParamByName('pValorTotal').AsFloat := TDAVDetalheVO(ListaDAVDetalhe.Items[i]).ValorTotal;
        Query.ParamByName('pCancelado').AsString := TDAVDetalheVO(ListaDAVDetalhe.Items[i]).Cancelado;
        Query.ParamByName('pMesclaProduto').AsString := TDAVDetalheVO(ListaDAVDetalhe.Items[i]).MesclaProduto;
        Query.ParamByName('pGtinProduto').AsString := TDAVDetalheVO(ListaDAVDetalhe.Items[i]).GtinProduto;
        Query.ParamByName('pNomeProduto').AsString := TDAVDetalheVO(ListaDAVDetalhe.Items[i]).NomeProduto;
        Query.ParamByName('pTOTALIZADOR_PARCIAL').AsString := TDAVDetalheVO(ListaDAVDetalhe.Items[i]).TotalizadorParcial;
        Query.ParamByName('pUnidadeProduto').AsString := TDAVDetalheVO(ListaDAVDetalhe.Items[i]).UnidadeProduto;
        Query.ExecSQL();
      end;
    except
    end;

    Result := DAVCabecalho;
  finally
    Query.Free;
  end;
end;

end.
