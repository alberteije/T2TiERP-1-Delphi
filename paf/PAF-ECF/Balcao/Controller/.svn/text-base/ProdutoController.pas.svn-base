{*******************************************************************************
Title: T2Ti ERP
Description: Classe de controle do produto.

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

@author Albert Eije (T2Ti.COM) | José Rodrigues  | Eri Brito   | Gilson Santos Lima
@version 1.0
*******************************************************************************}
unit ProdutoController;

interface

uses
  Classes, SQLExpr, SysUtils, ProdutoVO, Generics.Collections, UnidadeProdutoVO;

type
  TProdutoController = class
  protected
  public
    class Function Consulta(Codigo: String): TProdutoVO; overload;
    class Function Consulta(Codigo: String;Tipo:integer): TProdutoVO; overload;
    class Function ConsultaId(Id: Integer): TProdutoVO;

    class Function ConsultaCodigoBalanca(CodigoBalanca: Integer): TProdutoVO;
    class Function ConsultaCodigoInterno(CodigoInterno: String): TProdutoVO;
  end;

implementation

uses UDataModule;

var
  ConsultaSQL, ClausulaWhere: String;
  Query: TSQLQuery;

class Function TProdutoController.Consulta(Codigo: String): TProdutoVO;
var
  Produto: TProdutoVO;
begin
  ConsultaSQL :=
      'select ' +
      ' P.ID, ' +
      ' P.ID_UNIDADE_PRODUTO, ' +
      ' P.GTIN, ' +
      ' P.CODIGO_INTERNO, ' +
      ' P.NOME AS NOME_PRODUTO, ' +
      ' P.DESCRICAO, ' +
      ' P.DESCRICAO_PDV, ' +
      ' P.VALOR_VENDA, ' +
      ' P.QTD_ESTOQUE, ' +
      ' P.ESTOQUE_MIN, ' +
      ' P.ESTOQUE_MAX, ' +
      ' P.IAT, ' +
      ' P.IPPT, ' +
      ' P.NCM, ' +
      ' P.TIPO_ITEM_SPED, ' +
      ' P.DATA_ESTOQUE, ' +
      ' P.TAXA_IPI, ' +
      ' P.TAXA_ISSQN, ' +
      ' P.TAXA_PIS, ' +
      ' P.TAXA_COFINS, ' +
      ' P.TAXA_ICMS, ' +
      ' P.CST, ' +
      ' P.CSOSN, ' +
      ' P.TOTALIZADOR_PARCIAL, ' +
      ' P.ECF_ICMS_ST, ' +
      ' P.CODIGO_BALANCA, ' +
      ' P.PAF_P_ST, ' +
      ' U.NOME AS NOME_UNIDADE, ' +
      ' U.PODE_FRACIONAR ' +
      'from ' +
      ' PRODUTO P, ' +
      ' UNIDADE_PRODUTO U ' +
      'where ' +
      ' (P.GTIN = ' + QuotedStr(Codigo) + ' or P.CODIGO_INTERNO = ' + QuotedStr(Codigo) + ')' +
      ' and P.ID_UNIDADE_PRODUTO = U.ID';
  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;

      Produto := TProdutoVO.Create;
      Produto.UnidadeProduto := TUnidadeProdutoVO.Create;
      Produto.Id := Query.FieldByName('ID').AsInteger;
      Produto.IdUnidadeProduto := Query.FieldByName('ID_UNIDADE_PRODUTO').AsInteger;
      Produto.GTIN := Query.FieldByName('GTIN').AsString;
      Produto.CodigoInterno := Query.FieldByName('CODIGO_INTERNO').AsString;
      Produto.Nome := Query.FieldByName('NOME_PRODUTO').AsString;
      Produto.Descricao := Query.FieldByName('DESCRICAO').AsString;
      Produto.DescricaoPDV := Query.FieldByName('DESCRICAO_PDV').AsString;
      Produto.ValorVenda := Query.FieldByName('VALOR_VENDA').AsFloat;
      Produto.QtdEstoque := Query.FieldByName('QTD_ESTOQUE').AsFloat;
      Produto.EstoqueMax := Query.FieldByName('ESTOQUE_MAX').AsFloat;
      Produto.EstoqueMin := Query.FieldByName('ESTOQUE_MIN').AsFloat;
      Produto.IAT := Query.FieldByName('IAT').AsString;
      Produto.IPPT := Query.FieldByName('IPPT').AsString;
      Produto.NCM := Query.FieldByName('NCM').AsString;
      Produto.TipoItemSped := Query.FieldByName('TIPO_ITEM_SPED').AsString;
      Produto.DataEstoque := Query.FieldByName('DATA_ESTOQUE').AsString;
      Produto.TaxaIPI := Query.FieldByName('TAXA_IPI').AsFloat;
      Produto.TaxaISSQN := Query.FieldByName('TAXA_ISSQN').AsFloat;
      Produto.TaxaPIS := Query.FieldByName('TAXA_PIS').AsFloat;
      Produto.TaxaCOFINS := Query.FieldByName('TAXA_COFINS').AsFloat;
      Produto.TaxaICMS := Query.FieldByName('TAXA_ICMS').AsFloat;
      Produto.CST := Query.FieldByName('CST').AsString;
      Produto.CSOSN := Query.FieldByName('CSOSN').AsString;
      Produto.TotalizadorParcial := Query.FieldByName('TOTALIZADOR_PARCIAL').AsString;
      Produto.EcfIcmsSt := Query.FieldByName('ECF_ICMS_ST').AsString;
      Produto.CodigoBalanca:= Query.FieldByName('CODIGO_BALANCA').AsInteger;
      Produto.PafPSt := Query.FieldByName('PAF_P_ST').AsString;
      Produto.UnidadeProduto.Nome := Query.FieldByName('NOME_UNIDADE').AsString;
      Produto.UnidadeProduto.PodeFracionar:= Query.FieldByName('PODE_FRACIONAR').AsString;
      result := Produto;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;

class function TProdutoController.Consulta(Codigo: String; Tipo:integer): TProdutoVO;
var
  Produto: TProdutoVO;
begin
  case Tipo of
    1:begin      // pesquisa pelo codigo da balanca
      ClausulaWhere := ' where ' +
                      '(P.CODIGO_BALANCA = ' + QuotedStr(Codigo)+')' +
                      ' and (P.ID_UNIDADE_PRODUTO = U.ID)';
    end;
    2:begin     // pesquisa pelo GTIN
       ClausulaWhere := ' where ' +
                       ' (P.GTIN = ' + QuotedStr(Codigo)+ ')' +
                       ' and (P.ID_UNIDADE_PRODUTO = U.ID)';
    end;
    3:begin     // pesquisa pelo CODIGO_INTERNO ou GTIN
       ClausulaWhere := 'where ' +
                       ' ((P.CODIGO_INTERNO = ' + QuotedStr(Codigo)+ ')'+
                       ' or  (P.GTIN = ' + QuotedStr(copy(Codigo,1,14))+  '))' +
                       ' and (P.ID_UNIDADE_PRODUTO = U.ID)';
    end;

    4:begin     // pesquisa pelo Id
       ClausulaWhere := 'where ' +
                       ' (P.ID = ' + QuotedStr(Codigo) + ') '+
                       ' and (P.ID_UNIDADE_PRODUTO = U.ID) ';

    end;
  end;

  ConsultaSQL :=
      'select ' +
      ' P.ID, ' +
      ' P.ID_UNIDADE_PRODUTO, ' +
      ' P.GTIN, ' +
      ' P.CODIGO_INTERNO, ' +
      ' P.NOME AS NOME_PRODUTO, ' +
      ' P.DESCRICAO, ' +
      ' P.DESCRICAO_PDV, ' +
      ' P.VALOR_VENDA, ' +
      ' P.QTD_ESTOQUE, ' +
      ' P.ESTOQUE_MIN, ' +
      ' P.ESTOQUE_MAX, ' +
      ' P.IAT, ' +
      ' P.IPPT, ' +
      ' P.NCM, ' +
      ' P.TIPO_ITEM_SPED, ' +
      ' P.DATA_ESTOQUE, ' +
      ' P.TAXA_IPI, ' +
      ' P.TAXA_ISSQN, ' +
      ' P.TAXA_PIS, ' +
      ' P.TAXA_COFINS, ' +
      ' P.TAXA_ICMS, ' +
      ' P.CST, ' +
      ' P.CSOSN, ' +
      ' P.TOTALIZADOR_PARCIAL, ' +
      ' P.ECF_ICMS_ST, ' +
      ' P.CODIGO_BALANCA, ' +
      ' P.PAF_P_ST, ' +
      ' U.NOME AS NOME_UNIDADE, ' +
      ' U.PODE_FRACIONAR ' +
      'from ' +
      ' PRODUTO P, ' +
      ' UNIDADE_PRODUTO U ' +
      ClausulaWhere;

  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;

      Produto := TProdutoVO.Create;
      Produto.UnidadeProduto := TUnidadeProdutoVO.Create;
      Produto.Id := Query.FieldByName('ID').AsInteger;
      Produto.IdUnidadeProduto := Query.FieldByName('ID_UNIDADE_PRODUTO').AsInteger;
      Produto.GTIN := Query.FieldByName('GTIN').AsString;
      Produto.CodigoInterno := Query.FieldByName('CODIGO_INTERNO').AsString;
      Produto.Nome := Query.FieldByName('NOME_PRODUTO').AsString;
      Produto.Descricao := Query.FieldByName('DESCRICAO').AsString;
      Produto.DescricaoPDV := Query.FieldByName('DESCRICAO_PDV').AsString;
      Produto.ValorVenda := Query.FieldByName('VALOR_VENDA').AsFloat;
      Produto.QtdEstoque := Query.FieldByName('QTD_ESTOQUE').AsFloat;
      Produto.EstoqueMax := Query.FieldByName('ESTOQUE_MAX').AsFloat;
      Produto.EstoqueMin := Query.FieldByName('ESTOQUE_MIN').AsFloat;
      Produto.IAT := Query.FieldByName('IAT').AsString;
      Produto.IPPT := Query.FieldByName('IPPT').AsString;
      Produto.NCM := Query.FieldByName('NCM').AsString;
      Produto.TipoItemSped := Query.FieldByName('TIPO_ITEM_SPED').AsString;
      Produto.DataEstoque := Query.FieldByName('DATA_ESTOQUE').AsString;
      Produto.TaxaIPI := Query.FieldByName('TAXA_IPI').AsFloat;
      Produto.TaxaISSQN := Query.FieldByName('TAXA_ISSQN').AsFloat;
      Produto.TaxaPIS := Query.FieldByName('TAXA_PIS').AsFloat;
      Produto.TaxaCOFINS := Query.FieldByName('TAXA_COFINS').AsFloat;
      Produto.TaxaICMS := Query.FieldByName('TAXA_ICMS').AsFloat;
      Produto.CST := Query.FieldByName('CST').AsString;
      Produto.CSOSN := Query.FieldByName('CSOSN').AsString;
      Produto.TotalizadorParcial := Query.FieldByName('TOTALIZADOR_PARCIAL').AsString;
      Produto.EcfIcmsSt := Query.FieldByName('ECF_ICMS_ST').AsString;
      Produto.CodigoBalanca:= Query.FieldByName('CODIGO_BALANCA').AsInteger;
      Produto.PafPSt := Query.FieldByName('PAF_P_ST').AsString;
      Produto.UnidadeProduto.Nome := Query.FieldByName('NOME_UNIDADE').AsString;
      Produto.UnidadeProduto.PodeFracionar:= Query.FieldByName('PODE_FRACIONAR').AsString;
      result := Produto;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;

class function TProdutoController.ConsultaCodigoBalanca(CodigoBalanca: Integer): TProdutoVO;
var
  Produto: TProdutoVO;
begin
  ConsultaSQL :=
      'select ' +
      ' P.ID, ' +
      ' P.ID_UNIDADE_PRODUTO, ' +
      ' P.GTIN, ' +
      ' P.CODIGO_INTERNO, ' +
      ' P.NOME AS NOME_PRODUTO, ' +
      ' P.DESCRICAO, ' +
      ' P.DESCRICAO_PDV, ' +
      ' P.VALOR_VENDA, ' +
      ' P.QTD_ESTOQUE, ' +
      ' P.ESTOQUE_MIN, ' +
      ' P.ESTOQUE_MAX, ' +
      ' P.IAT, ' +
      ' P.IPPT, ' +
      ' P.NCM, ' +
      ' P.TIPO_ITEM_SPED, ' +
      ' P.DATA_ESTOQUE, ' +
      ' P.TAXA_IPI, ' +
      ' P.TAXA_ISSQN, ' +
      ' P.TAXA_PIS, ' +
      ' P.TAXA_COFINS, ' +
      ' P.TAXA_ICMS, ' +
      ' P.CST, ' +
      ' P.CSOSN, ' +
      ' P.TOTALIZADOR_PARCIAL, ' +
      ' P.ECF_ICMS_ST, ' +
      ' P.CODIGO_BALANCA, ' +
      ' P.PAF_P_ST, ' +
      ' U.NOME AS NOME_UNIDADE, ' +
      ' U.PODE_FRACIONAR ' +
      'from ' +
      ' PRODUTO P, ' +
      ' UNIDADE_PRODUTO U ' +
      'where ' +
      ' (P.CODIGO_BALANCA = ' + IntToStr(CodigoBalanca)+')' +
      ' and P.ID_UNIDADE_PRODUTO = U.ID';
  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;

      Produto := TProdutoVO.Create;
      Produto.UnidadeProduto := TUnidadeProdutoVO.Create;
      Produto.Id := Query.FieldByName('ID').AsInteger;
      Produto.IdUnidadeProduto := Query.FieldByName('ID_UNIDADE_PRODUTO').AsInteger;
      Produto.GTIN := Query.FieldByName('GTIN').AsString;
      Produto.CodigoInterno := Query.FieldByName('CODIGO_INTERNO').AsString;
      Produto.Nome := Query.FieldByName('NOME_PRODUTO').AsString;
      Produto.Descricao := Query.FieldByName('DESCRICAO').AsString;
      Produto.DescricaoPDV := Query.FieldByName('DESCRICAO_PDV').AsString;
      Produto.ValorVenda := Query.FieldByName('VALOR_VENDA').AsFloat;
      Produto.QtdEstoque := Query.FieldByName('QTD_ESTOQUE').AsFloat;
      Produto.EstoqueMax := Query.FieldByName('ESTOQUE_MAX').AsFloat;
      Produto.EstoqueMin := Query.FieldByName('ESTOQUE_MIN').AsFloat;
      Produto.IAT := Query.FieldByName('IAT').AsString;
      Produto.IPPT := Query.FieldByName('IPPT').AsString;
      Produto.NCM := Query.FieldByName('NCM').AsString;
      Produto.TipoItemSped := Query.FieldByName('TIPO_ITEM_SPED').AsString;
      Produto.DataEstoque := Query.FieldByName('DATA_ESTOQUE').AsString;
      Produto.TaxaIPI := Query.FieldByName('TAXA_IPI').AsFloat;
      Produto.TaxaISSQN := Query.FieldByName('TAXA_ISSQN').AsFloat;
      Produto.TaxaPIS := Query.FieldByName('TAXA_PIS').AsFloat;
      Produto.TaxaCOFINS := Query.FieldByName('TAXA_COFINS').AsFloat;
      Produto.TaxaICMS := Query.FieldByName('TAXA_ICMS').AsFloat;
      Produto.CST := Query.FieldByName('CST').AsString;
      Produto.CSOSN := Query.FieldByName('CSOSN').AsString;
      Produto.TotalizadorParcial := Query.FieldByName('TOTALIZADOR_PARCIAL').AsString;
      Produto.EcfIcmsSt := Query.FieldByName('ECF_ICMS_ST').AsString;
      Produto.CodigoBalanca:= Query.FieldByName('CODIGO_BALANCA').AsInteger;
      Produto.PafPSt := Query.FieldByName('PAF_P_ST').AsString;
      Produto.UnidadeProduto.Nome := Query.FieldByName('NOME_UNIDADE').AsString;
      Produto.UnidadeProduto.PodeFracionar:= Query.FieldByName('PODE_FRACIONAR').AsString;
      result := Produto;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;

end;

class function TProdutoController.ConsultaCodigoInterno(CodigoInterno: String): TProdutoVO;
var
  Produto: TProdutoVO;
begin
  ConsultaSQL :=
      'select ' +
      ' P.ID, ' +
      ' P.ID_UNIDADE_PRODUTO, ' +
      ' P.GTIN, ' +
      ' P.CODIGO_INTERNO, ' +
      ' P.NOME AS NOME_PRODUTO, ' +
      ' P.DESCRICAO, ' +
      ' P.DESCRICAO_PDV, ' +
      ' P.VALOR_VENDA, ' +
      ' P.QTD_ESTOQUE, ' +
      ' P.ESTOQUE_MIN, ' +
      ' P.ESTOQUE_MAX, ' +
      ' P.IAT, ' +
      ' P.IPPT, ' +
      ' P.NCM, ' +
      ' P.TIPO_ITEM_SPED, ' +
      ' P.DATA_ESTOQUE, ' +
      ' P.TAXA_IPI, ' +
      ' P.TAXA_ISSQN, ' +
      ' P.TAXA_PIS, ' +
      ' P.TAXA_COFINS, ' +
      ' P.TAXA_ICMS, ' +
      ' P.CST, ' +
      ' P.CSOSN, ' +
      ' P.TOTALIZADOR_PARCIAL, ' +
      ' P.ECF_ICMS_ST, ' +
      ' P.CODIGO_BALANCA, ' +
      ' P.PAF_P_ST, ' +
      ' U.NOME AS NOME_UNIDADE, ' +
      ' U.PODE_FRACIONAR ' +
      'from ' +
       ' PRODUTO P, ' +
       ' UNIDADE_PRODUTO U ' +
       'where ' +
       ' (P.GTIN = ' + QuotedStr(copy(CodigoInterno,1,14)) + ' or P.CODIGO_INTERNO = ' + QuotedStr(CodigoInterno) + ')' +
       ' and P.ID_UNIDADE_PRODUTO = U.ID';
  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;

      Produto := TProdutoVO.Create;
      Produto.UnidadeProduto := TUnidadeProdutoVO.Create;
      Produto.Id := Query.FieldByName('ID').AsInteger;
      Produto.IdUnidadeProduto := Query.FieldByName('ID_UNIDADE_PRODUTO').AsInteger;
      Produto.GTIN := Query.FieldByName('GTIN').AsString;
      Produto.CodigoInterno := Query.FieldByName('CODIGO_INTERNO').AsString;
      Produto.Nome := Query.FieldByName('NOME_PRODUTO').AsString;
      Produto.Descricao := Query.FieldByName('DESCRICAO').AsString;
      Produto.DescricaoPDV := Query.FieldByName('DESCRICAO_PDV').AsString;
      Produto.ValorVenda := Query.FieldByName('VALOR_VENDA').AsFloat;
      Produto.QtdEstoque := Query.FieldByName('QTD_ESTOQUE').AsFloat;
      Produto.EstoqueMax := Query.FieldByName('ESTOQUE_MAX').AsFloat;
      Produto.EstoqueMin := Query.FieldByName('ESTOQUE_MIN').AsFloat;
      Produto.IAT := Query.FieldByName('IAT').AsString;
      Produto.IPPT := Query.FieldByName('IPPT').AsString;
      Produto.NCM := Query.FieldByName('NCM').AsString;
      Produto.TipoItemSped := Query.FieldByName('TIPO_ITEM_SPED').AsString;
      Produto.DataEstoque := Query.FieldByName('DATA_ESTOQUE').AsString;
      Produto.TaxaIPI := Query.FieldByName('TAXA_IPI').AsFloat;
      Produto.TaxaISSQN := Query.FieldByName('TAXA_ISSQN').AsFloat;
      Produto.TaxaPIS := Query.FieldByName('TAXA_PIS').AsFloat;
      Produto.TaxaCOFINS := Query.FieldByName('TAXA_COFINS').AsFloat;
      Produto.TaxaICMS := Query.FieldByName('TAXA_ICMS').AsFloat;
      Produto.CST := Query.FieldByName('CST').AsString;
      Produto.CSOSN := Query.FieldByName('CSOSN').AsString;
      Produto.TotalizadorParcial := Query.FieldByName('TOTALIZADOR_PARCIAL').AsString;
      Produto.EcfIcmsSt := Query.FieldByName('ECF_ICMS_ST').AsString;
      Produto.CodigoBalanca:= Query.FieldByName('CODIGO_BALANCA').AsInteger;
      Produto.PafPSt := Query.FieldByName('PAF_P_ST').AsString;
      Produto.UnidadeProduto.Nome := Query.FieldByName('NOME_UNIDADE').AsString;
      Produto.UnidadeProduto.PodeFracionar:= Query.FieldByName('PODE_FRACIONAR').AsString;
      result := Produto;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;

end;

class Function TProdutoController.ConsultaId(Id: Integer): TProdutoVO;
var
  Produto: TProdutoVO;
begin
  ConsultaSQL :=

      'select ' +
      ' P.ID, ' +
      ' P.ID_UNIDADE_PRODUTO, ' +
      ' P.GTIN, ' +
      ' P.CODIGO_INTERNO, ' +
      ' P.NOME AS NOME_PRODUTO, ' +
      ' P.DESCRICAO, ' +
      ' P.DESCRICAO_PDV, ' +
      ' P.VALOR_VENDA, ' +
      ' P.QTD_ESTOQUE, ' +
      ' P.ESTOQUE_MIN, ' +
      ' P.ESTOQUE_MAX, ' +
      ' P.IAT, ' +
      ' P.IPPT, ' +
      ' P.NCM, ' +
      ' P.TIPO_ITEM_SPED, ' +
      ' P.DATA_ESTOQUE, ' +
      ' P.TAXA_IPI, ' +
      ' P.TAXA_ISSQN, ' +
      ' P.TAXA_PIS, ' +
      ' P.TAXA_COFINS, ' +
      ' P.TAXA_ICMS, ' +
      ' P.CST, ' +
      ' P.CSOSN, ' +
      ' P.TOTALIZADOR_PARCIAL, ' +
      ' P.ECF_ICMS_ST, ' +
      ' P.CODIGO_BALANCA, ' +
      ' P.PAF_P_ST, ' +
      ' U.NOME AS NOME_UNIDADE, ' +
      ' U.PODE_FRACIONAR ' +
      'from ' +
      ' PRODUTO P, ' +
      ' UNIDADE_PRODUTO U ' +
      'where ' +
      ' P.ID = ' + IntToStr(Id) +
      ' and P.ID_UNIDADE_PRODUTO = U.ID';
  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;

      Produto := TProdutoVO.Create;
      Produto.UnidadeProduto := TUnidadeProdutoVO.Create;
      Produto.Id := Query.FieldByName('ID').AsInteger;
      Produto.IdUnidadeProduto := Query.FieldByName('ID_UNIDADE_PRODUTO').AsInteger;
      Produto.GTIN := Query.FieldByName('GTIN').AsString;
      Produto.CodigoInterno := Query.FieldByName('CODIGO_INTERNO').AsString;
      Produto.Nome := Query.FieldByName('NOME_PRODUTO').AsString;
      Produto.Descricao := Query.FieldByName('DESCRICAO').AsString;
      Produto.DescricaoPDV := Query.FieldByName('DESCRICAO_PDV').AsString;
      Produto.ValorVenda := Query.FieldByName('VALOR_VENDA').AsFloat;
      Produto.QtdEstoque := Query.FieldByName('QTD_ESTOQUE').AsFloat;
      Produto.EstoqueMax := Query.FieldByName('ESTOQUE_MAX').AsFloat;
      Produto.EstoqueMin := Query.FieldByName('ESTOQUE_MIN').AsFloat;
      Produto.IAT := Query.FieldByName('IAT').AsString;
      Produto.IPPT := Query.FieldByName('IPPT').AsString;
      Produto.NCM := Query.FieldByName('NCM').AsString;
      Produto.TipoItemSped := Query.FieldByName('TIPO_ITEM_SPED').AsString;
      Produto.DataEstoque := Query.FieldByName('DATA_ESTOQUE').AsString;
      Produto.TaxaIPI := Query.FieldByName('TAXA_IPI').AsFloat;
      Produto.TaxaISSQN := Query.FieldByName('TAXA_ISSQN').AsFloat;
      Produto.TaxaPIS := Query.FieldByName('TAXA_PIS').AsFloat;
      Produto.TaxaCOFINS := Query.FieldByName('TAXA_COFINS').AsFloat;
      Produto.TaxaICMS := Query.FieldByName('TAXA_ICMS').AsFloat;
      Produto.CST := Query.FieldByName('CST').AsString;
      Produto.CSOSN := Query.FieldByName('CSOSN').AsString;
      Produto.TotalizadorParcial := Query.FieldByName('TOTALIZADOR_PARCIAL').AsString;
      Produto.EcfIcmsSt := Query.FieldByName('ECF_ICMS_ST').AsString;
      Produto.CodigoBalanca:= Query.FieldByName('CODIGO_BALANCA').AsInteger;
      Produto.PafPSt := Query.FieldByName('PAF_P_ST').AsString;
      Produto.UnidadeProduto.Nome := Query.FieldByName('NOME_UNIDADE').AsString;
      Produto.UnidadeProduto.PodeFracionar:= Query.FieldByName('PODE_FRACIONAR').AsString;
      result := Produto;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;

end.
