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

@author Albert Eije (T2Ti.COM) | Jose Rodrigues de Oliveira Junior
@version 1.0
*******************************************************************************}
unit ProdutoController;

interface

uses
  Classes, SQLExpr, SysUtils, ProdutoVO, Generics.Collections;

type
  TProdutoController = class
  protected
  public
    class function Consulta(Codigo: String; Tipo: Integer): TProdutoVO;
    class function ConsultaId(Id: Integer): TProdutoVO;
    class function ConsultaIdProduto(Id: Integer): Boolean;
    class function TabelaProduto: TObjectList<TProdutoVO>; overload;
    class function TabelaProduto(CodigoInicio: Integer; CodigoFim: Integer): TObjectList<TProdutoVO>; overload;
    class function TabelaProduto(NomeInicio: String; NomeFim : String): TObjectList<TProdutoVO>; overload;
    class function ConsultaProdutoSPED(pDataInicial, pDataFinal: String; pPerfilApresentacao: Integer): TObjectList<TProdutoVO>;
    class function AtualizaEstoque: Boolean;
    class function GravaCargaProduto(vTupla: String): Boolean;
  end;

implementation

uses UDataModule, Biblioteca, UCargaPDV, ConfiguracaoController,
  AliquotasController;

var
  ConsultaSQL, ClausulaWhere: String;
  Query: TSQLQuery;

class function TProdutoController.Consulta(Codigo: String; Tipo: Integer): TProdutoVO;
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
                  ' P.QTD_ESTOQUE_ANTERIOR, ' +
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
                  ' P.HASH_TRIPA, ' +
                  ' P.HASH_INCREMENTO, ' +
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
      Produto.Id := Query.FieldByName('ID').AsInteger;
      Produto.IdUnidade := Query.FieldByName('ID_UNIDADE_PRODUTO').AsInteger;
      Produto.GTIN := Query.FieldByName('GTIN').AsString;
      Produto.CodigoInterno := Query.FieldByName('CODIGO_INTERNO').AsString;
      Produto.Nome := Query.FieldByName('NOME_PRODUTO').AsString;
      Produto.Descricao := Query.FieldByName('DESCRICAO').AsString;
      Produto.DescricaoPDV := Query.FieldByName('DESCRICAO_PDV').AsString;
      Produto.ValorVenda := Query.FieldByName('VALOR_VENDA').AsFloat;
      Produto.QtdeEstoque := Query.FieldByName('QTD_ESTOQUE').AsFloat;
      Produto.QtdeEstoqueAnterior := Query.FieldByName('QTD_ESTOQUE_ANTERIOR').AsFloat;
      Produto.EstoqueMinimo := Query.FieldByName('ESTOQUE_MIN').AsFloat;
      Produto.EstoqueMaximo := Query.FieldByName('ESTOQUE_MAX').AsFloat;
      Produto.IAT := Query.FieldByName('IAT').AsString;
      Produto.IPPT := Query.FieldByName('IPPT').AsString;
      Produto.NCM := Query.FieldByName('NCM').AsString;
      Produto.TipoItemSped := Query.FieldByName('TIPO_ITEM_SPED').AsString;
      Produto.DataEstoque := Query.FieldByName('DATA_ESTOQUE').AsString;
      Produto.AliquotaIpi := Query.FieldByName('TAXA_IPI').AsFloat;
      Produto.AliquotaIssqn := Query.FieldByName('TAXA_ISSQN').AsFloat;
      Produto.AliquotaPis := Query.FieldByName('TAXA_PIS').AsFloat;
      Produto.AliquotaCofins := Query.FieldByName('TAXA_COFINS').AsFloat;
      Produto.AliquotaIcms := Query.FieldByName('TAXA_ICMS').AsFloat;
      Produto.Cst := Query.FieldByName('CST').AsString;
      Produto.Csosn := Query.FieldByName('CSOSN').AsString;
      Produto.TotalizadorParcial := Query.FieldByName('TOTALIZADOR_PARCIAL').AsString;
      Produto.ECFICMS := Query.FieldByName('ECF_ICMS_ST').AsString;
      Produto.CodigoBalanca:= Query.FieldByName('CODIGO_BALANCA').AsInteger;
      Produto.PafProdutoSt := Query.FieldByName('PAF_P_ST').AsString;
      Produto.HashTripa := Query.FieldByName('HASH_TRIPA').AsString;
      Produto.HashIncremento := Query.FieldByName('HASH_INCREMENTO').AsInteger;
      Produto.UnidadeProduto := Query.FieldByName('NOME_UNIDADE').AsString;
      Produto.PodeFracionarUnidade := Query.FieldByName('PODE_FRACIONAR').AsString;
      result := Produto;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;

class function TProdutoController.ConsultaId(Id: Integer): TProdutoVO;
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
                  ' P.QTD_ESTOQUE_ANTERIOR, ' +
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
                  ' P.HASH_TRIPA, ' +
                  ' P.HASH_INCREMENTO, ' +
                  ' U.NOME AS NOME_UNIDADE, ' +
                  ' U.PODE_FRACIONAR ' +
                  'from ' +
                  ' PRODUTO P, ' +
                  ' UNIDADE_PRODUTO U ' +
                  'where ' +
                  ' (P.ID = ' + IntToStr(Id) + ') '+
                  ' and (P.ID_UNIDADE_PRODUTO = U.ID) ';
  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;

      Produto := TProdutoVO.Create;
      Produto.Id := Query.FieldByName('ID').AsInteger;
      Produto.IdUnidade := Query.FieldByName('ID_UNIDADE_PRODUTO').AsInteger;
      Produto.GTIN := Query.FieldByName('GTIN').AsString;
      Produto.CodigoInterno := Query.FieldByName('CODIGO_INTERNO').AsString;
      Produto.Nome := Query.FieldByName('NOME_PRODUTO').AsString;
      Produto.Descricao := Query.FieldByName('DESCRICAO').AsString;
      Produto.DescricaoPDV := Query.FieldByName('DESCRICAO_PDV').AsString;
      Produto.ValorVenda := Query.FieldByName('VALOR_VENDA').AsFloat;
      Produto.QtdeEstoque := Query.FieldByName('QTD_ESTOQUE').AsFloat;
      Produto.QtdeEstoqueAnterior := Query.FieldByName('QTD_ESTOQUE_ANTERIOR').AsFloat;
      Produto.EstoqueMinimo := Query.FieldByName('ESTOQUE_MIN').AsFloat;
      Produto.EstoqueMaximo := Query.FieldByName('ESTOQUE_MAX').AsFloat;
      Produto.IAT := Query.FieldByName('IAT').AsString;
      Produto.IPPT := Query.FieldByName('IPPT').AsString;
      Produto.NCM := Query.FieldByName('NCM').AsString;
      Produto.TipoItemSped := Query.FieldByName('TIPO_ITEM_SPED').AsString;
      Produto.DataEstoque := Query.FieldByName('DATA_ESTOQUE').AsString;
      Produto.AliquotaIpi := Query.FieldByName('TAXA_IPI').AsFloat;
      Produto.AliquotaIssqn := Query.FieldByName('TAXA_ISSQN').AsFloat;
      Produto.AliquotaPis := Query.FieldByName('TAXA_PIS').AsFloat;
      Produto.AliquotaCofins := Query.FieldByName('TAXA_COFINS').AsFloat;
      Produto.AliquotaIcms := Query.FieldByName('TAXA_ICMS').AsFloat;
      Produto.Cst := Query.FieldByName('CST').AsString;
      Produto.Csosn := Query.FieldByName('CSOSN').AsString;
      Produto.TotalizadorParcial := Query.FieldByName('TOTALIZADOR_PARCIAL').AsString;
      Produto.ECFICMS := Query.FieldByName('ECF_ICMS_ST').AsString;
      Produto.CodigoBalanca:= Query.FieldByName('CODIGO_BALANCA').AsInteger;
      Produto.PafProdutoSt := Query.FieldByName('PAF_P_ST').AsString;
      Produto.HashTripa := Query.FieldByName('HASH_TRIPA').AsString;
      Produto.HashIncremento := Query.FieldByName('HASH_INCREMENTO').AsInteger;
      Produto.UnidadeProduto := Query.FieldByName('NOME_UNIDADE').AsString;
      Produto.PodeFracionarUnidade := Query.FieldByName('PODE_FRACIONAR').AsString;
      result := Produto;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;

class function TProdutoController.ConsultaIdProduto(Id: Integer): Boolean;
begin
  ConsultaSQL := 'select ID from PRODUTO where (ID = :pID) ';
  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.ParamByName('pID').AsInteger:=Id;
      Query.Open;
      if not Query.IsEmpty then
        result := true
      else
        result := false;
    except
    end;
  finally
    Query.Free;
  end;
end;

class function TProdutoController.TabelaProduto: TObjectList<TProdutoVO>;
var
  ListaProduto: TObjectList<TProdutoVO>;
  Produto: TProdutoVO;
  TotalRegistros: Integer;
begin
  try
    try
      //verifica se existem produtos
      ConsultaSQL :=
        'select count(*) as TOTAL '+
        'from PRODUTO P, UNIDADE_PRODUTO U '+
        'where (P.ID_UNIDADE_PRODUTO = U.ID)';

      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      TotalRegistros := Query.FieldByName('TOTAL').AsInteger;

      if TotalRegistros > 0 then
      begin
        //continua com a execução do procedimento
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
                      ' P.QTD_ESTOQUE_ANTERIOR, ' +
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
                      ' P.HASH_TRIPA, ' +
                      ' P.HASH_INCREMENTO, ' +
                      ' U.NOME AS NOME_UNIDADE, ' +
                      ' U.PODE_FRACIONAR ' +
                      'from ' +
                      ' PRODUTO P, UNIDADE_PRODUTO U '+
                      'where ' +
                      ' (P.ID_UNIDADE_PRODUTO = U.ID)';

        Query.sql.Text := ConsultaSQL;
        Query.Open;

        ListaProduto := TObjectList<TProdutoVO>.Create;

        Query.First;
        while not Query.Eof do
        begin
          Produto := TProdutoVO.Create;
          Produto.Id := Query.FieldByName('ID').AsInteger;
          Produto.IdUnidade := Query.FieldByName('ID_UNIDADE_PRODUTO').AsInteger;
          Produto.GTIN := Query.FieldByName('GTIN').AsString;
          Produto.CodigoInterno := Query.FieldByName('CODIGO_INTERNO').AsString;
          Produto.Nome := Query.FieldByName('NOME_PRODUTO').AsString;
          Produto.Descricao := Query.FieldByName('DESCRICAO').AsString;
          Produto.DescricaoPDV := Query.FieldByName('DESCRICAO_PDV').AsString;
          Produto.ValorVenda := Query.FieldByName('VALOR_VENDA').AsFloat;
          Produto.QtdeEstoque := Query.FieldByName('QTD_ESTOQUE').AsFloat;
          Produto.QtdeEstoqueAnterior := Query.FieldByName('QTD_ESTOQUE_ANTERIOR').AsFloat;
          Produto.EstoqueMinimo := Query.FieldByName('ESTOQUE_MIN').AsFloat;
          Produto.EstoqueMaximo := Query.FieldByName('ESTOQUE_MAX').AsFloat;
          Produto.IAT := Query.FieldByName('IAT').AsString;
          Produto.IPPT := Query.FieldByName('IPPT').AsString;
          Produto.NCM := Query.FieldByName('NCM').AsString;
          Produto.TipoItemSped := Query.FieldByName('TIPO_ITEM_SPED').AsString;
          Produto.DataEstoque := Query.FieldByName('DATA_ESTOQUE').AsString;
          Produto.AliquotaIpi := Query.FieldByName('TAXA_IPI').AsFloat;
          Produto.AliquotaIssqn := Query.FieldByName('TAXA_ISSQN').AsFloat;
          Produto.AliquotaPis := Query.FieldByName('TAXA_PIS').AsFloat;
          Produto.AliquotaCofins := Query.FieldByName('TAXA_COFINS').AsFloat;
          Produto.AliquotaIcms := Query.FieldByName('TAXA_ICMS').AsFloat;
          Produto.Cst := Query.FieldByName('CST').AsString;
          Produto.Csosn := Query.FieldByName('CSOSN').AsString;
          Produto.TotalizadorParcial := Query.FieldByName('TOTALIZADOR_PARCIAL').AsString;
          Produto.ECFICMS := Query.FieldByName('ECF_ICMS_ST').AsString;
          Produto.CodigoBalanca:= Query.FieldByName('CODIGO_BALANCA').AsInteger;
          Produto.PafProdutoSt := Query.FieldByName('PAF_P_ST').AsString;
          Produto.HashTripa := Query.FieldByName('HASH_TRIPA').AsString;
          Produto.HashIncremento := Query.FieldByName('HASH_INCREMENTO').AsInteger;
          Produto.UnidadeProduto := Query.FieldByName('NOME_UNIDADE').AsString;
          Produto.PodeFracionarUnidade := Query.FieldByName('PODE_FRACIONAR').AsString;
          ListaProduto.Add(Produto);
          Query.next;
        end;
        result := ListaProduto;
      end
      else
        result := nil;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;

class function TProdutoController.TabelaProduto(CodigoInicio: Integer; CodigoFim : Integer) : TObjectList<TProdutoVO>;
var
  ListaProduto: TObjectList<TProdutoVO>;
  Produto: TProdutoVO;
  TotalRegistros: Integer;
begin
  try
    try
      //verifica se existem produtos
      ConsultaSQL :=
        'select count(*) as TOTAL '+
        'from PRODUTO P, UNIDADE_PRODUTO U '+
        'where (P.ID_UNIDADE_PRODUTO = U.ID) '+
        'and P.ID between '+IntToStr(CodigoInicio)+' and '+IntToStr(CodigoFim);

      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      TotalRegistros := Query.FieldByName('TOTAL').AsInteger;

      if TotalRegistros > 0 then
      begin
        //continua com a execução do procedimento
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
                      ' P.QTD_ESTOQUE_ANTERIOR, ' +
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
                      ' P.HASH_TRIPA, ' +
                      ' P.HASH_INCREMENTO, ' +
                      ' U.NOME AS NOME_UNIDADE, ' +
                      ' U.PODE_FRACIONAR ' +
                      'from ' +
                      ' PRODUTO P, UNIDADE_PRODUTO U '+
                      'where ' +
                      ' (P.ID_UNIDADE_PRODUTO = U.ID) '+
                      'and P.ID between '+IntToStr(CodigoInicio)+' and '+IntToStr(CodigoFim);

        Query.sql.Text := ConsultaSQL;
        Query.Open;

        ListaProduto := TObjectList<TProdutoVO>.Create;

        Query.First;
        while not Query.Eof do
        begin
          Produto := TProdutoVO.Create;
          Produto.Id := Query.FieldByName('ID').AsInteger;
          Produto.IdUnidade := Query.FieldByName('ID_UNIDADE_PRODUTO').AsInteger;
          Produto.GTIN := Query.FieldByName('GTIN').AsString;
          Produto.CodigoInterno := Query.FieldByName('CODIGO_INTERNO').AsString;
          Produto.Nome := Query.FieldByName('NOME_PRODUTO').AsString;
          Produto.Descricao := Query.FieldByName('DESCRICAO').AsString;
          Produto.DescricaoPDV := Query.FieldByName('DESCRICAO_PDV').AsString;
          Produto.ValorVenda := Query.FieldByName('VALOR_VENDA').AsFloat;
          Produto.QtdeEstoque := Query.FieldByName('QTD_ESTOQUE').AsFloat;
          Produto.QtdeEstoqueAnterior := Query.FieldByName('QTD_ESTOQUE_ANTERIOR').AsFloat;
          Produto.EstoqueMinimo := Query.FieldByName('ESTOQUE_MIN').AsFloat;
          Produto.EstoqueMaximo := Query.FieldByName('ESTOQUE_MAX').AsFloat;
          Produto.IAT := Query.FieldByName('IAT').AsString;
          Produto.IPPT := Query.FieldByName('IPPT').AsString;
          Produto.NCM := Query.FieldByName('NCM').AsString;
          Produto.TipoItemSped := Query.FieldByName('TIPO_ITEM_SPED').AsString;
          Produto.DataEstoque := Query.FieldByName('DATA_ESTOQUE').AsString;
          Produto.AliquotaIpi := Query.FieldByName('TAXA_IPI').AsFloat;
          Produto.AliquotaIssqn := Query.FieldByName('TAXA_ISSQN').AsFloat;
          Produto.AliquotaPis := Query.FieldByName('TAXA_PIS').AsFloat;
          Produto.AliquotaCofins := Query.FieldByName('TAXA_COFINS').AsFloat;
          Produto.AliquotaIcms := Query.FieldByName('TAXA_ICMS').AsFloat;
          Produto.Cst := Query.FieldByName('CST').AsString;
          Produto.Csosn := Query.FieldByName('CSOSN').AsString;
          Produto.TotalizadorParcial := Query.FieldByName('TOTALIZADOR_PARCIAL').AsString;
          Produto.ECFICMS := Query.FieldByName('ECF_ICMS_ST').AsString;
          Produto.CodigoBalanca:= Query.FieldByName('CODIGO_BALANCA').AsInteger;
          Produto.PafProdutoSt := Query.FieldByName('PAF_P_ST').AsString;
          Produto.HashTripa := Query.FieldByName('HASH_TRIPA').AsString;
          Produto.HashIncremento := Query.FieldByName('HASH_INCREMENTO').AsInteger;
          Produto.UnidadeProduto := Query.FieldByName('NOME_UNIDADE').AsString;
          Produto.PodeFracionarUnidade := Query.FieldByName('PODE_FRACIONAR').AsString;
          ListaProduto.Add(Produto);
          Query.next;
        end;
        result := ListaProduto;
      end
      else
        result := nil;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;

class function TProdutoController.TabelaProduto(NomeInicio: String ; NomeFim: String): TObjectList<TProdutoVO>;
var
  ListaProduto: TObjectList<TProdutoVO>;
  Produto: TProdutoVO;
  TotalRegistros: Integer;
begin
  try
    try
      //verifica se existem produtos
      ConsultaSQL :=
        'select count(*) as TOTAL '+
        'from PRODUTO P, UNIDADE_PRODUTO U '+
        'where (P.ID_UNIDADE_PRODUTO = U.ID) '+
        'and (P.NOME like "%'+Trim(NomeInicio)+'%" or P.NOME like "%'+Trim(NomeFim) + '%")';


      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      TotalRegistros := Query.FieldByName('TOTAL').AsInteger;

      if TotalRegistros > 0 then
      begin
        //continua com a execução do procedimento
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
                      ' P.QTD_ESTOQUE_ANTERIOR, ' +
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
                      ' P.HASH_TRIPA, ' +
                      ' P.HASH_INCREMENTO, ' +
                      ' U.NOME AS NOME_UNIDADE, ' +
                      ' U.PODE_FRACIONAR ' +
                      'from ' +
                      ' PRODUTO P, UNIDADE_PRODUTO U '+
                      ' where (P.ID_UNIDADE_PRODUTO = U.ID) '+
                      ' and (P.NOME like "%'+Trim(NomeInicio)+'%" or P.NOME like "%'+Trim(NomeFim) + '%")';

        Query.sql.Text := ConsultaSQL;
        Query.Open;

        ListaProduto := TObjectList<TProdutoVO>.Create;

        Query.First;
        while not Query.Eof do
        begin
          Produto := TProdutoVO.Create;
          Produto.Id := Query.FieldByName('ID').AsInteger;
          Produto.IdUnidade := Query.FieldByName('ID_UNIDADE_PRODUTO').AsInteger;
          Produto.GTIN := Query.FieldByName('GTIN').AsString;
          Produto.CodigoInterno := Query.FieldByName('CODIGO_INTERNO').AsString;
          Produto.Nome := Query.FieldByName('NOME_PRODUTO').AsString;
          Produto.Descricao := Query.FieldByName('DESCRICAO').AsString;
          Produto.DescricaoPDV := Query.FieldByName('DESCRICAO_PDV').AsString;
          Produto.ValorVenda := Query.FieldByName('VALOR_VENDA').AsFloat;
          Produto.QtdeEstoque := Query.FieldByName('QTD_ESTOQUE').AsFloat;
          Produto.QtdeEstoqueAnterior := Query.FieldByName('QTD_ESTOQUE_ANTERIOR').AsFloat;
          Produto.EstoqueMinimo := Query.FieldByName('ESTOQUE_MIN').AsFloat;
          Produto.EstoqueMaximo := Query.FieldByName('ESTOQUE_MAX').AsFloat;
          Produto.IAT := Query.FieldByName('IAT').AsString;
          Produto.IPPT := Query.FieldByName('IPPT').AsString;
          Produto.NCM := Query.FieldByName('NCM').AsString;
          Produto.TipoItemSped := Query.FieldByName('TIPO_ITEM_SPED').AsString;
          Produto.DataEstoque := Query.FieldByName('DATA_ESTOQUE').AsString;
          Produto.AliquotaIpi := Query.FieldByName('TAXA_IPI').AsFloat;
          Produto.AliquotaIssqn := Query.FieldByName('TAXA_ISSQN').AsFloat;
          Produto.AliquotaPis := Query.FieldByName('TAXA_PIS').AsFloat;
          Produto.AliquotaCofins := Query.FieldByName('TAXA_COFINS').AsFloat;
          Produto.AliquotaIcms := Query.FieldByName('TAXA_ICMS').AsFloat;
          Produto.Cst := Query.FieldByName('CST').AsString;
          Produto.Csosn := Query.FieldByName('CSOSN').AsString;
          Produto.TotalizadorParcial := Query.FieldByName('TOTALIZADOR_PARCIAL').AsString;
          Produto.ECFICMS := Query.FieldByName('ECF_ICMS_ST').AsString;
          Produto.CodigoBalanca:= Query.FieldByName('CODIGO_BALANCA').AsInteger;
          Produto.PafProdutoSt := Query.FieldByName('PAF_P_ST').AsString;
          Produto.HashTripa := Query.FieldByName('HASH_TRIPA').AsString;
          Produto.HashIncremento := Query.FieldByName('HASH_INCREMENTO').AsInteger;
          Produto.UnidadeProduto := Query.FieldByName('NOME_UNIDADE').AsString;
          Produto.PodeFracionarUnidade := Query.FieldByName('PODE_FRACIONAR').AsString;
          ListaProduto.Add(Produto);
          Query.next;
        end;
        result := ListaProduto;
      end
      else
        result := nil;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;

class function TProdutoController.ConsultaProdutoSPED(pDataInicial, pDataFinal: String; pPerfilApresentacao : Integer): TObjectList<TProdutoVO>;
var
  ListaProduto: TObjectList<TProdutoVO>;
  Produto: TProdutoVO;
  TotalRegistros, Perfil: Integer;
  DataInicio, DataFim : String ;
begin
  try
    try

     DataInicio := QuotedStr(FormatDateTime('yyyy-mm-dd', StrToDate(pDataInicial)));
     DataFim := QuotedStr(FormatDateTime('yyyy-mm-dd', StrToDate(pDataFinal)));
     Perfil := pPerfilApresentacao;

        ConsultaSQL :=
            ' select count(*) as total '+
            ' from  PRODUTO P, UNIDADE_PRODUTO U, ECF_VENDA_CABECALHO V, ECF_VENDA_DETALHE D'+
            ' where V.DATA_VENDA between '+DataInicio+' and '+DataFim+
            ' and (P.ID_UNIDADE_PRODUTO = U.ID)'+
            ' and (V.ID=D.ID_ECF_VENDA_CABECALHO)'+
            ' and (D.ID_ECF_PRODUTO=P.ID) group by D.ID_ECF_PRODUTO';

        Query := TSQLQuery.Create(nil);
        Query.SQLConnection := FDataModule.Conexao;
        Query.sql.Text := ConsultaSQL;
        Query.Open;
        TotalRegistros := Query.FieldByName('TOTAL').AsInteger;

    if TotalRegistros > 0 then
    begin
      ListaProduto := TObjectList<TProdutoVO>.Create;
      case Perfil of
       0 : begin
       // Perfil A
        ClausulaWhere :=
                      ' where v.DATA_VENDA between '+DataInicio+' and '+DataFim+
                      ' and D.CANCELADO <> ' + QuotedStr('S') +
                      ' and (P.ID_UNIDADE_PRODUTO = U.ID)'+
                      ' and (v.id=d.id_ecf_venda_cabecalho)'+
                      ' and (d.id_ecf_produto=p.id)';
       end;
       1 : begin
       // Perfil B
        ClausulaWhere :=
                      ' where v.DATA_VENDA between '+DataInicio+' and '+DataFim+
                      ' and (P.ID_UNIDADE_PRODUTO = U.ID)'+
                      ' and (v.id=d.id_ecf_venda_cabecalho)'+
                      ' and (d.id_ecf_produto=p.id)';
       end;
       2 : begin
       // Perfil C
        ClausulaWhere :=
                      ' where v.DATA_VENDA between '+DataInicio+' and '+DataFim+
                      ' and (P.ID_UNIDADE_PRODUTO = U.ID)'+
                      ' and (v.id=d.id_ecf_venda_cabecalho)'+
                      ' and (d.id_ecf_produto=p.id)';
       end;
      end;

        ConsultaSQL :=
                      'select distinct ' +
                      ' P.ID, ' +
                      ' P.ID_UNIDADE_PRODUTO, ' +
                      ' P.GTIN, ' +
                      ' P.CODIGO_INTERNO, ' +
                      ' P.NOME AS NOME_PRODUTO, ' +
                      ' P.DESCRICAO, ' +
                      ' P.DESCRICAO_PDV, ' +
                      ' P.VALOR_VENDA, ' +
                      ' P.QTD_ESTOQUE, ' +
                      ' P.QTD_ESTOQUE_ANTERIOR, ' +
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
                      ' P.HASH_TRIPA, ' +
                      ' U.NOME AS NOME_UNIDADE, ' +
                      ' U.PODE_FRACIONAR ' +
                      'from ' +
                      ' PRODUTO P, UNIDADE_PRODUTO U, ECF_VENDA_CABECALHO V, ECF_VENDA_DETALHE D'+
                      ClausulaWhere;

      Query.sql.Text := ConsultaSQL;
      Query.Open;
      Query.First;

      while not Query.Eof do
      begin
        Produto := TProdutoVO.Create;
        Produto.Id := Query.FieldByName('ID').AsInteger;
        Produto.IdUnidade := Query.FieldByName('ID_UNIDADE_PRODUTO').AsInteger;
        Produto.GTIN := Query.FieldByName('GTIN').AsString;
        Produto.CodigoInterno := Query.FieldByName('CODIGO_INTERNO').AsString;
        Produto.Nome := Query.FieldByName('NOME_PRODUTO').AsString;
        Produto.Descricao := Query.FieldByName('DESCRICAO').AsString;
        Produto.DescricaoPDV := Query.FieldByName('DESCRICAO_PDV').AsString;
        Produto.ValorVenda := Query.FieldByName('VALOR_VENDA').AsFloat;
        Produto.QtdeEstoque := Query.FieldByName('QTD_ESTOQUE').AsFloat;
        Produto.QtdeEstoqueAnterior := Query.FieldByName('QTD_ESTOQUE_ANTERIOR').AsFloat;
        Produto.EstoqueMinimo := Query.FieldByName('ESTOQUE_MIN').AsFloat;
        Produto.EstoqueMaximo := Query.FieldByName('ESTOQUE_MAX').AsFloat;
        Produto.IAT := Query.FieldByName('IAT').AsString;
        Produto.IPPT := Query.FieldByName('IPPT').AsString;
        Produto.NCM := Query.FieldByName('NCM').AsString;
        Produto.TipoItemSped := Query.FieldByName('TIPO_ITEM_SPED').AsString;
        Produto.DataEstoque := Query.FieldByName('DATA_ESTOQUE').AsString;
        Produto.AliquotaIpi := Query.FieldByName('TAXA_IPI').AsFloat;
        Produto.AliquotaIssqn := Query.FieldByName('TAXA_ISSQN').AsFloat;
        Produto.AliquotaPis := Query.FieldByName('TAXA_PIS').AsFloat;
        Produto.AliquotaCofins := Query.FieldByName('TAXA_COFINS').AsFloat;
        Produto.AliquotaIcms := Query.FieldByName('TAXA_ICMS').AsFloat;
        Produto.Cst := Query.FieldByName('CST').AsString;
        Produto.Csosn := Query.FieldByName('CSOSN').AsString;
        Produto.TotalizadorParcial := Query.FieldByName('TOTALIZADOR_PARCIAL').AsString;
        Produto.ECFICMS := Query.FieldByName('ECF_ICMS_ST').AsString;
        Produto.CodigoBalanca:= Query.FieldByName('CODIGO_BALANCA').AsInteger;
        Produto.PafProdutoSt := Query.FieldByName('PAF_P_ST').AsString;
        Produto.HashTripa := Query.FieldByName('HASH_TRIPA').AsString;
        Produto.UnidadeProduto := Query.FieldByName('NOME_UNIDADE').AsString;
        Produto.PodeFracionarUnidade := Query.FieldByName('PODE_FRACIONAR').AsString;
        ListaProduto.Add(Produto);
        Query.next;
      end;
      result := ListaProduto;
     end
     else
       result := nil;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;

class function TProdutoController.AtualizaEstoque: Boolean;
var
  ConsultaSQL, Tupla, Tripa: String;
  Data : TDateTime;
  Query: TSQLQuery;
  i: Integer;
begin
  Data := TextoParaData(TConfiguracaoController.ConsultaDataAtualizacaoEstoque);
  DecimalSeparator := '.';
  try
    try
      try
        ConsultaSQL := 'Select Count(*) as TOTAL from PRODUTO WHERE DATA_ESTOQUE >= :pData';
        Query := TSQLQuery.Create(nil);
        Query.SQLConnection := FDataModule.ConexaoBalcao;
        Query.sql.Text := ConsultaSQL;
        Query.ParamByName('pData').AsDateTime := Data;
        Query.Open;

        i := Query.FieldByName('TOTAL').AsInteger;
      finally
        Query.free;
      end;

      if i > 0  then
      begin
        FCargaPDV.JvProgressBar1.Max:= i;

        ConsultaSQL := 'select * from PRODUTO where (DATA_ESTOQUE >= :pData)';
        try
          Query := TSQLQuery.Create(nil);
          Query.SQLConnection := FDataModule.ConexaoBalcao;
          Query.sql.Text := ConsultaSQL;
          Query.ParamByName('pData').AsDateTime := Data;
          Query.Open;

          i := 0;
          if not Query.IsEmpty then
          begin
            while not Query.Eof do
            begin
              inc(i);

              Tripa :=
                trim(Query.FieldByName('GTIN').AsString)+                             //   TProdutoVO(ListaProduto.Items[i]).GTIN +
                trim(Query.FieldByName('DESCRICAO').AsString)+                        //   TProdutoVO(ListaProduto.Items[i]).Descricao +
                trim(Query.FieldByName('DESCRICAO_PDV').AsString)+                    //   TProdutoVO(ListaProduto.Items[i]).DescricaoPDV +
                FormataFloat('Q',Query.FieldByName('QTD_ESTOQUE_ANTERIOR').AsFloat)+  //   FormataFloat('Q',TProdutoVO(ListaProduto.Items[i]).QtdeEstoque) +
                Query.FieldByName('DATA_ESTOQUE').AsString+                           //   TProdutoVO(ListaProduto.Items[i]).DataEstoque +
                trim(Query.FieldByName('CST').AsString)+                              //   TProdutoVO(ListaProduto.Items[i]).Cst +
                FormataFloat('V',Query.FieldByName('TAXA_ICMS').AsFloat)+             //   FormataFloat('V',TProdutoVO(ListaProduto.Items[i]).AliquotaICMS) +
                FormataFloat('V',Query.FieldByName('VALOR_VENDA').AsFloat)+ '0';      //   FormataFloat('V',TProdutoVO(ListaProduto.Items[i]).ValorVenda) + '0';

              Tupla := VerificaNULL(Query.FieldByName('ID').AsString,0) + '|'+                // ID                    INTEGER NOT NULL,
              VerificaNULL(Query.FieldByName('ID_UNIDADE_PRODUTO').AsString,0) + '|' +        // ID_UNIDADE_PRODUTO    INTEGER NOT NULL,
              VerificaNULL(Query.FieldByName('GTIN').AsString,2) + '|' +                      // GTIN                  VARCHAR(14),
              VerificaNULL(Query.FieldByName('CODIGO_INTERNO').AsString,2) + '|' +            // CODIGO_INTERNO        VARCHAR(20),
              VerificaNULL(Query.FieldByName('NOME').AsString,2) + '|' +                      // NOME                  VARCHAR(100),
              VerificaNULL(Query.FieldByName('DESCRICAO').AsString,2) + '|' +                 // DESCRICAO             VARCHAR(250),
              VerificaNULL(Query.FieldByName('DESCRICAO_PDV').AsString,2) + '|' +             // DESCRICAO_PDV         VARCHAR(30),
              VerificaNULL(Query.FieldByName('VALOR_VENDA').AsString,0) + '|' +               // VALOR_VENDA           DECIMAL(18,6),
              VerificaNULL(Query.FieldByName('QTD_ESTOQUE').AsString,0) + '|' +               // QTD_ESTOQUE           DECIMAL(18,6),
              VerificaNULL(Query.FieldByName('QTD_ESTOQUE_ANTERIOR').AsString,0) + '|' +      // QTD_ESTOQUE_ANTERIOR  DECIMAL(18,6),
              VerificaNULL(Query.FieldByName('ESTOQUE_MIN').AsString,0) + '|' +               // ESTOQUE_MIN           DECIMAL(18,6),
              VerificaNULL(Query.FieldByName('ESTOQUE_MAX').AsString,0) + '|' +               // ESTOQUE_MAX           DECIMAL(18,6),
              VerificaNULL(Query.FieldByName('IAT').AsString,2) + '|' +                       // IAT                   CHAR(1),
              VerificaNULL(Query.FieldByName('IPPT').AsString,2) + '|' +                      // IPPT                  CHAR(1),
              VerificaNULL(Query.FieldByName('NCM').AsString,2) + '|' +                       // NCM                   VARCHAR(8),
              VerificaNULL(Query.FieldByName('TIPO_ITEM_SPED').AsString,2) + '|' +            // TIPO_ITEM_SPED        CHAR(2),
              DataParaTexto(Query.FieldByName('DATA_ESTOQUE').AsDateTime) + '|' +             // DATA_ESTOQUE          DATE,
              VerificaNULL(Query.FieldByName('TAXA_IPI').AsString,0) + '|' +                  // TAXA_IPI              DECIMAL(18,6),
              VerificaNULL(Query.FieldByName('TAXA_ISSQN').AsString,0) + '|' +                // TAXA_ISSQN            DECIMAL(18,6),
              VerificaNULL(Query.FieldByName('TAXA_PIS').AsString,0) + '|' +                  // TAXA_PIS              DECIMAL(18,6),
              VerificaNULL(Query.FieldByName('TAXA_COFINS').AsString,0) + '|' +               // TAXA_COFINS           DECIMAL(18,6),
              VerificaNULL(Query.FieldByName('TAXA_ICMS').AsString,0) + '|' +                 // TAXA_ICMS             DECIMAL(18,6),
              VerificaNULL(Query.FieldByName('CST').AsString,2) + '|' +                       // CST                   CHAR(3),
              VerificaNULL(Query.FieldByName('CSOSN').AsString,2) + '|' +                     // CSOSN                 CHAR(4),
              VerificaNULL(Query.FieldByName('TOTALIZADOR_PARCIAL').AsString,2) + '|' +       // TOTALIZADOR_PARCIAL   VARCHAR(10),
              VerificaNULL(Query.FieldByName('ECF_ICMS_ST').AsString,2) + '|' +               // ECF_ICMS_ST           VARCHAR(4),
              VerificaNULL(Query.FieldByName('CODIGO_BALANCA').AsString,0) + '|' +            // CODIGO_BALANCA        INTEGER,
              VerificaNULL(Query.FieldByName('PAF_P_ST').AsString,2) + '|' +                  // PAF_P_ST              CHAR(1)
              VerificaNULL((MD5String(Tripa)),2)+'|'+                                         // ok
              '-1|';                                                                          // ok

              TProdutoController.GravaCargaProduto(Tupla);

              FCargaPDV.JvProgressBar1.Position:= i;
              Query.Next;
            end;

          end;
           Result := True;

           TConfiguracaoController.GravaDataAtulaizacaoEstoque(DataParaTexto(FDataModule.ACBrECF.DataHora));
        finally
          Query.Free;
        end;
      end;
    except
      Result := False;
    end;
  finally
    DecimalSeparator := ',';
  end;

end;

class function TProdutoController.GravaCargaProduto(vTupla: String): Boolean;
var
  Produto: TProdutoVO;
  Indice: string;
begin
  DecimalSeparator:= '.';
  Produto := TProdutoVO.Create;
  Query := TSQLQuery.Create(nil);
  try
    try

      Produto.Id :=                  StrToInt(DevolveConteudoDelimitado('|',vTupla));        //    ID                    INTEGER NOT NULL,
      Produto.IdUnidade :=           StrToInt(DevolveConteudoDelimitado('|',vTupla));        //    ID_UNIDADE_PRODUTO    INTEGER NOT NULL,
      Produto.GTIN :=                DevolveConteudoDelimitado('|',vTupla);                  //    GTIN                  VARCHAR(14),
      Produto.CodigoInterno :=       DevolveConteudoDelimitado('|',vTupla);                  //    CODIGO_INTERNO        VARCHAR(20),
      Produto.Nome :=                DevolveConteudoDelimitado('|',vTupla);                  //    NOME                  VARCHAR(100),
      Produto.Descricao :=           DevolveConteudoDelimitado('|',vTupla);                  //    DESCRICAO             VARCHAR(250),
      Produto.DescricaoPDV :=        DevolveConteudoDelimitado('|',vTupla);                  //    DESCRICAO_PDV         VARCHAR(30),
      Produto.ValorVenda :=          StrToFloatDef(DevolveConteudoDelimitado('|',vTupla),0); //    VALOR_VENDA           DECIMAL(18,6),
      Produto.QtdeEstoque :=         StrToFloatDef(DevolveConteudoDelimitado('|',vTupla),0); //    QTD_ESTOQUE           DECIMAL(18,6),
      Produto.QtdeEstoqueAnterior := StrToFloatDef(DevolveConteudoDelimitado('|',vTupla),0); //    QTD_ESTOQUE_ANTERIOR  DECIMAL(18,6),
      Produto.EstoqueMinimo :=       StrToFloatDef(DevolveConteudoDelimitado('|',vTupla),0); //    ESTOQUE_MIN           DECIMAL(18,6),
      Produto.EstoqueMaximo :=       StrToFloatDef(DevolveConteudoDelimitado('|',vTupla),0); //    ESTOQUE_MAX           DECIMAL(18,6),
      Produto.IAT :=                 DevolveConteudoDelimitado('|',vTupla);                  //    IAT                   CHAR(1),
      Produto.IPPT :=                DevolveConteudoDelimitado('|',vTupla);                  //    IPPT                  CHAR(1),
      Produto.NCM :=                 DevolveConteudoDelimitado('|',vTupla);                  //    NCM                   VARCHAR(8),
      Produto.TipoItemSped :=        DevolveConteudoDelimitado('|',vTupla);                  //    TIPO_ITEM_SPED        CHAR(2),
      Produto.DataEstoque :=         DevolveConteudoDelimitado('|',vTupla);                  //    DATA_ESTOQUE          DATE,
      Produto.AliquotaIPI :=         StrToFloatDef(DevolveConteudoDelimitado('|',vTupla),0); //    TAXA_IPI              DECIMAL(18,6),
      Produto.AliquotaISSQN :=       StrToFloatDef(DevolveConteudoDelimitado('|',vTupla),0); //    TAXA_ISSQN            DECIMAL(18,6),
      Produto.AliquotaPIS :=         StrToFloatDef(DevolveConteudoDelimitado('|',vTupla),0); //    TAXA_PIS              DECIMAL(18,6),
      Produto.AliquotaCOFINS :=      StrToFloatDef(DevolveConteudoDelimitado('|',vTupla),0); //    TAXA_COFINS           DECIMAL(18,6),
      Produto.AliquotaICMS :=        StrToFloatDef(DevolveConteudoDelimitado('|',vTupla),0); //    TAXA_ICMS             DECIMAL(18,6),
      Produto.Cst :=                 DevolveConteudoDelimitado('|',vTupla);                  //    CST                   CHAR(3),
      Produto.Csosn :=               DevolveConteudoDelimitado('|',vTupla);                  //    CSOSN                 CHAR(4),
      Produto.TotalizadorParcial :=  DevolveConteudoDelimitado('|',vTupla);                  //    TOTALIZADOR_PARCIAL   VARCHAR(10),
      Produto.ECFICMS :=             DevolveConteudoDelimitado('|',vTupla);                  //    ECF_ICMS_ST           VARCHAR(4),
      Produto.CodigoBalanca :=       StrToIntDef(DevolveConteudoDelimitado('|',vTupla),0);   //    CODIGO_BALANCA        INTEGER,
      Produto.PafProdutoST :=        DevolveConteudoDelimitado('|',vTupla);                  //    PAF_P_ST              CHAR(1),
      Produto.HashTripa :=           DevolveConteudoDelimitado('|',vTupla);                  //    HASH_TRIPA            VARCHAR(32),
      Produto.HashIncremento :=      StrToIntDef(DevolveConteudoDelimitado('|',vTupla),0);   //    HASH_INCREMENTO       INTEGER

      Indice:= TAliquotasController.ConsultaAliquota(Produto.ECFICMS,Produto.PafProdutoST);
      if indice <> '' then
         Produto.TotalizadorParcial := indice
      else
      begin
         Result := false;
         exit;
      end;

      if Produto.ValorVenda <= 0 then
      begin
         Result := false;
         exit;
      end;



      if FDataModule.BancoPAF = 'FIREBIRD' then
      begin
        ConsultaSQL :=
        'UPDATE OR INSERT INTO PRODUTO ('+
        'ID, '+
        'ID_UNIDADE_PRODUTO, '+
        'GTIN, '+
        'CODIGO_INTERNO, '+
        'NOME, '+
        'DESCRICAO, '+
        'DESCRICAO_PDV, '+
        'VALOR_VENDA, '+
        'QTD_ESTOQUE, '+
        'QTD_ESTOQUE_ANTERIOR, '+
        'ESTOQUE_MIN, '+
        'ESTOQUE_MAX, '+
        'IAT, '+
        'IPPT, '+
        'NCM, '+
        'TIPO_ITEM_SPED, '+
        'DATA_ESTOQUE, '+
        'TAXA_IPI, '+
        'TAXA_ISSQN, '+
        'TAXA_PIS, '+
        'TAXA_COFINS, '+
        'TAXA_ICMS, '+
        'CST, '+
        'CSOSN, '+
        'TOTALIZADOR_PARCIAL, '+
        'ECF_ICMS_ST, '+
        'CODIGO_BALANCA, '+
        'PAF_P_ST, '+
        'HASH_TRIPA, '+
        'HASH_INCREMENTO)'+

        ' values ('+

        IntToStr(Produto.Id)+','+                     //    ID                    INTEGER NOT NULL,
        IntToStr(Produto.IdUnidade)+','+              //    ID_UNIDADE_PRODUTO    INTEGER NOT NULL,
        QuotedStr(Produto.GTIN)+','+                  //    GTIN                  VARCHAR(14),
        QuotedStr(Produto.CodigoInterno)+','+         //    CODIGO_INTERNO        VARCHAR(20),
        QuotedStr(Produto.Nome)+','+                  //    NOME                  VARCHAR(100),
        QuotedStr(Produto.Descricao)+','+             //    DESCRICAO             VARCHAR(250),
        QuotedStr(Produto.DescricaoPDV)+','+          //    DESCRICAO_PDV         VARCHAR(30),
        FloatToStr(Produto.ValorVenda)+','+           //    VALOR_VENDA           DECIMAL(18,6),
        FloatToStr(Produto.QtdeEstoque)+','+          //    QTD_ESTOQUE           DECIMAL(18,6),
        FloatToStr(Produto.QtdeEstoqueAnterior)+','+  //    QTD_ESTOQUE_ANTERIOR  DECIMAL(18,6),
        FloatToStr(Produto.EstoqueMinimo)+','+        //    ESTOQUE_MIN           DECIMAL(18,6),
        FloatToStr(Produto.EstoqueMaximo)+','+        //    ESTOQUE_MAX           DECIMAL(18,6),
        QuotedStr(Produto.IAT)+','+                   //    IAT                   CHAR(1),
        QuotedStr(Produto.IPPT)+','+                  //    IPPT                  CHAR(1),
        QuotedStr(Produto.NCM)+','+                   //    NCM                   VARCHAR(8),
        QuotedStr(Produto.TipoItemSped)+','+          //    TIPO_ITEM_SPED        CHAR(2),
        QuotedStr(Produto.DataEstoque)+','+           //    DATA_ESTOQUE          DATE,
        FloatToStr(Produto.AliquotaIPI)+','+          //    TAXA_IPI              DECIMAL(18,6),
        FloatToStr(Produto.AliquotaISSQN)+','+        //    TAXA_ISSQN            DECIMAL(18,6),
        FloatToStr(Produto.AliquotaPIS)+','+          //    TAXA_PIS              DECIMAL(18,6),
        FloatToStr(Produto.AliquotaCOFINS)+','+       //    TAXA_COFINS           DECIMAL(18,6),
        FloatToStr(Produto.AliquotaICMS)+','+         //    TAXA_ICMS             DECIMAL(18,6),
        QuotedStr(Produto.Cst)+','+                   //    CST                   CHAR(3),
        QuotedStr(Produto.Csosn)+','+                 //    CSOSN                 CHAR(4),
        QuotedStr(Produto.TotalizadorParcial)+','+    //    TOTALIZADOR_PARCIAL   VARCHAR(10),
        QuotedStr(Produto.ECFICMS)+','+               //    ECF_ICMS_ST           VARCHAR(4),
        IntToStr(Produto.CodigoBalanca)+','+          //    CODIGO_BALANCA        INTEGER,
        QuotedStr(Produto.PafProdutoST)+','+          //    PAF_P_ST              CHAR(1),
        QuotedStr(Produto.HashTripa)+','+             //    HASH_TRIPA            VARCHAR(32),
        '-1)';                                        //    HASH_INCREMENTO       INTEGER
      end
      else if FDataModule.BancoPAF = 'MYSQL' then
      begin

        if not ConsultaIdProduto(Produto.Id) then
          ConsultaSQL :=
          'INSERT INTO PRODUTO ('+
          'ID, '+
          'ID_UNIDADE_PRODUTO, '+
          'GTIN, '+
          'CODIGO_INTERNO, '+
          'NOME, '+
          'DESCRICAO, '+
          'DESCRICAO_PDV, '+
          'VALOR_VENDA, '+
          'QTD_ESTOQUE, '+
          'QTD_ESTOQUE_ANTERIOR, '+
          'ESTOQUE_MIN, '+
          'ESTOQUE_MAX, '+
          'IAT, '+
          'IPPT, '+
          'NCM, '+
          'TIPO_ITEM_SPED, '+
          'DATA_ESTOQUE, '+
          'TAXA_IPI, '+
          'TAXA_ISSQN, '+
          'TAXA_PIS, '+
          'TAXA_COFINS, '+
          'TAXA_ICMS, '+
          'CST, '+
          'CSOSN, '+
          'TOTALIZADOR_PARCIAL, '+
          'ECF_ICMS_ST, '+
          'CODIGO_BALANCA, '+
          'PAF_P_ST, '+
          'HASH_TRIPA, '+
          'HASH_INCREMENTO)'+

          ' values ('+

          IntToStr(Produto.Id)+','+                     //    ID                    INTEGER NOT NULL,
          IntToStr(Produto.IdUnidade)+','+              //    ID_UNIDADE_PRODUTO    INTEGER NOT NULL,
          QuotedStr(Produto.GTIN)+','+                  //    GTIN                  VARCHAR(14),
          QuotedStr(Produto.CodigoInterno)+','+         //    CODIGO_INTERNO        VARCHAR(20),
          QuotedStr(Produto.Nome)+','+                  //    NOME                  VARCHAR(100),
          QuotedStr(Produto.Descricao)+','+             //    DESCRICAO             VARCHAR(250),
          QuotedStr(Produto.DescricaoPDV)+','+          //    DESCRICAO_PDV         VARCHAR(30),
          FloatToStr(Produto.ValorVenda)+','+           //    VALOR_VENDA           DECIMAL(18,6),
          FloatToStr(Produto.QtdeEstoque)+','+          //    QTD_ESTOQUE           DECIMAL(18,6),
          FloatToStr(Produto.QtdeEstoqueAnterior)+','+  //    QTD_ESTOQUE_ANTERIOR  DECIMAL(18,6),
          FloatToStr(Produto.EstoqueMinimo)+','+        //    ESTOQUE_MIN           DECIMAL(18,6),
          FloatToStr(Produto.EstoqueMaximo)+','+        //    ESTOQUE_MAX           DECIMAL(18,6),
          QuotedStr(Produto.IAT)+','+                   //    IAT                   CHAR(1),
          QuotedStr(Produto.IPPT)+','+                  //    IPPT                  CHAR(1),
          QuotedStr(Produto.NCM)+','+                   //    NCM                   VARCHAR(8),
          QuotedStr(Produto.TipoItemSped)+','+          //    TIPO_ITEM_SPED        CHAR(2),
          QuotedStr(Produto.DataEstoque)+','+           //    DATA_ESTOQUE          DATE,
          FloatToStr(Produto.AliquotaIPI)+','+          //    TAXA_IPI              DECIMAL(18,6),
          FloatToStr(Produto.AliquotaISSQN)+','+        //    TAXA_ISSQN            DECIMAL(18,6),
          FloatToStr(Produto.AliquotaPIS)+','+          //    TAXA_PIS              DECIMAL(18,6),
          FloatToStr(Produto.AliquotaCOFINS)+','+       //    TAXA_COFINS           DECIMAL(18,6),
          FloatToStr(Produto.AliquotaICMS)+','+         //    TAXA_ICMS             DECIMAL(18,6),
          QuotedStr(Produto.Cst)+','+                   //    CST                   CHAR(3),
          QuotedStr(Produto.Csosn)+','+                 //    CSOSN                 CHAR(4),
          QuotedStr(Produto.TotalizadorParcial)+','+    //    TOTALIZADOR_PARCIAL   VARCHAR(10),
          QuotedStr(Produto.ECFICMS)+','+               //    ECF_ICMS_ST           VARCHAR(4),
          IntToStr(Produto.CodigoBalanca)+','+          //    CODIGO_BALANCA        INTEGER,
          QuotedStr(Produto.PafProdutoST)+','+          //    PAF_P_ST              CHAR(1),
          QuotedStr(Produto.HashTripa)+','+             //    HASH_TRIPA            VARCHAR(32),
          '-1)'                                         //    HASH_INCREMENTO       INTEGER

        else
          ConsultaSQL :=
          ' update  PRODUTO set '+

          'ID_UNIDADE_PRODUTO ='+    IntToStr(Produto.IdUnidade)+','+              //    ID_UNIDADE_PRODUTO
          'GTIN ='+                  QuotedStr(Produto.GTIN)+','+                  //    GTIN
          'CODIGO_INTERNO ='+        QuotedStr(Produto.CodigoInterno)+','+         //    CODIGO_INTERNO
          'NOME ='+                  QuotedStr(Produto.Nome)+','+                  //    NOME
          'DESCRICAO ='+             QuotedStr(Produto.Descricao)+','+             //    DESCRICAO
          'DESCRICAO_PDV ='+         QuotedStr(Produto.DescricaoPDV)+','+          //    DESCRICAO_PDV
          'VALOR_VENDA ='+           FloatToStr(Produto.ValorVenda)+','+           //    VALOR_VENDA
          'QTD_ESTOQUE ='+           FloatToStr(Produto.QtdeEstoque)+','+          //    QTD_ESTOQUE
          'QTD_ESTOQUE_ANTERIOR ='+  FloatToStr(Produto.QtdeEstoqueAnterior)+','+  //    QTD_ESTOQUE_ANTERIOR
          'ESTOQUE_MIN ='+           FloatToStr(Produto.EstoqueMinimo)+','+        //    ESTOQUE_MIN
          'ESTOQUE_MAX ='+           FloatToStr(Produto.EstoqueMaximo)+','+        //    ESTOQUE_MAX
          'IAT ='+                   QuotedStr(Produto.IAT)+','+                   //    IAT
          'IPPT ='+                  QuotedStr(Produto.IPPT)+','+                  //    IPPT
          'NCM ='+                   QuotedStr(Produto.NCM)+','+                   //    NCM
          'TIPO_ITEM_SPED ='+        QuotedStr(Produto.TipoItemSped)+','+          //    TIPO_ITEM_SPED
          'DATA_ESTOQUE ='+          QuotedStr(Produto.DataEstoque)+','+           //    DATA_ESTOQUE
          'TAXA_IPI ='+              FloatToStr(Produto.AliquotaIPI)+','+          //    TAXA_IPI
          'TAXA_ISSQN ='+            FloatToStr(Produto.AliquotaISSQN)+','+        //    TAXA_ISSQN
          'TAXA_PIS ='+              FloatToStr(Produto.AliquotaPIS)+','+          //    TAXA_PIS
          'TAXA_COFINS ='+           FloatToStr(Produto.AliquotaCOFINS)+','+       //    TAXA_COFINS
          'TAXA_ICMS ='+             FloatToStr(Produto.AliquotaICMS)+','+         //    TAXA_ICMS
          'CST ='+                   QuotedStr(Produto.Cst)+','+                   //    CST
          'CSOSN ='+                 QuotedStr(Produto.Csosn)+','+                 //    CSOSN
          'TOTALIZADOR_PARCIAL ='+   QuotedStr(Produto.TotalizadorParcial)+','+    //    TOTALIZADOR_PARCIAL
          'ECF_ICMS_ST ='+           QuotedStr(Produto.ECFICMS)+','+               //    ECF_ICMS_ST
          'CODIGO_BALANCA ='+        IntToStr(Produto.CodigoBalanca)+','+          //    CODIGO_BALANCA
          'PAF_P_ST ='+              QuotedStr(Produto.PafProdutoST)+','+          //    PAF_P_ST
          'HASH_TRIPA ='+            QuotedStr(Produto.HashTripa)+','+             //    HASH_TRIPA
          'HASH_INCREMENTO =-1'+                                                   //    HASH_INCREMENTO
          ' where ID ='+IntToStr(Produto.Id);
      end;

      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.ExecSQL();

      Result:= true;
    except
       Result:= false;
    end;
  finally
    DecimalSeparator:= ',';
    Query.Free;
    Produto.Free;

  end;
end;

end.