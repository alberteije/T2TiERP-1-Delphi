{*******************************************************************************
Title: T2Ti ERP
Description: Classe de controle da pre-venda.

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
    class Function CarregaPreVenda(Id: Integer): TObjectList<TPreVendaDetalheVO>;
    class Procedure FechaPreVenda(Id: Integer; CCF: Integer);
    class Procedure MesclaPreVenda(ListaPreVendaCabecalho:TObjectList<TPreVendaVO>;ListaPreVendaDetalhe:TObjectList<TPreVendaDetalheVO>);
    class Procedure CancelaPreVendasPendentes; overload;
    class Procedure CancelaPreVendasPendentes(ListaPreVendaCabecalho:TObjectList<TPreVendaVO>;ListaPreVendaDetalhe:TObjectList<TPreVendaDetalheVO>); overload;
  end;

implementation

uses UDataModule, UCaixa, ProdutoController, UECF;

var
  ConsultaSQL: String;
  Query: TSQLQuery;

class function TPreVendaController.CarregaPreVenda(Id: Integer): TObjectList<TPreVendaDetalheVO>;
var
  ListaVenda: TObjectList<TPreVendaDetalheVO>;
  PreVendaDetalhe: TPreVendaDetalheVO;
  TotalRegistros: Integer;
begin
  //verifica se existe a pre-venda solicitada
  ConsultaSQL :=
    'select count(*) as TOTAL from ECF_PRE_VENDA_CABECALHO where ' +
    'SITUACAO <> ' + QuotedStr('E') + ' and SITUACAO <> ' + QuotedStr('M') + ' and ID=' + IntToStr(Id);

  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      TotalRegistros := Query.FieldByName('TOTAL').AsInteger;

      //caso exista a pre-venda, procede com a importação da mesma
      if TotalRegistros > 0 then
      begin
        //verifica se existem itens para a pre-venda
        ConsultaSQL :=
          'select count(*) as TOTAL from ECF_PRE_VENDA_DETALHE where ID_ECF_PRE_VENDA_CABECALHO='+IntToStr(Id);
        Query.sql.Text := ConsultaSQL;
        Query.Open;
        TotalRegistros := Query.FieldByName('TOTAL').AsInteger;

        //caso existam itens no detalhe
        if TotalRegistros > 0 then
        begin
          ListaVenda := TObjectList<TPreVendaDetalheVO>.Create;

          ConsultaSQL :=
            'select * from ECF_PRE_VENDA_DETALHE where ID_ECF_PRE_VENDA_CABECALHO='+IntToStr(Id);
          Query.sql.Text := ConsultaSQL;
          Query.Open;
          Query.First;
          while not Query.Eof do
          begin
            PreVendaDetalhe := TPreVendaDetalheVO.Create;
            PreVendaDetalhe.Id := Query.FieldByName('ID').AsInteger;
            PreVendaDetalhe.IdPreVenda := Id;
            PreVendaDetalhe.IdProduto := Query.FieldByName('ID_PRODUTO').AsInteger;
            PreVendaDetalhe.Quantidade := Query.FieldByName('QUANTIDADE').AsInteger;
            PreVendaDetalhe.ValorUnitario := Query.FieldByName('VALOR_UNITARIO').AsFloat;
            PreVendaDetalhe.ValorTotal := Query.FieldByName('VALOR_TOTAL').AsFloat;
            ListaVenda.Add(PreVendaDetalhe);
            Query.next;
          end;
          result := ListaVenda;
        end
        else
          result := nil;
      end
      //caso não exista a pre-venda, retorna um ponteiro nulo
      else
        result := nil;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;

class procedure TPreVendaController.FechaPreVenda(Id: Integer; CCF: Integer);
begin
  ConsultaSQL :=
    'update ECF_PRE_VENDA_CABECALHO set ' +
    'SITUACAO=:pSituacao, '+
    'CCF=:pCCF '+
    ' where ID = :pId';

  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.ParamByName('pId').AsInteger := Id;
      Query.ParamByName('pCCF').AsInteger := CCF;
      Query.ParamByName('pSituacao').AsString := 'E';
      Query.ExecSQL();
    except
    end;
  finally
    Query.Free;
  end;
end;

class procedure TPreVendaController.MesclaPreVenda(ListaPreVendaCabecalho:TObjectList<TPreVendaVO>;ListaPreVendaDetalhe:TObjectList<TPreVendaDetalheVO>);
var
  i:integer;
  NovaPreVenda: TPreVendaVO;
begin
  //inicia e configura a nova Pre-Venda
  NovaPreVenda := TPreVendaVO.Create;
  NovaPreVenda.DataEmissao := FormatDateTime('yyyy-mm-dd', now);
  NovaPreVenda.HoraEmissao := FormatDateTime('hh:nn:ss', now);
  NovaPreVenda.Situacao := 'P';

  //atualiza a tabela de cabecalho
  for i := 0 to ListaPreVendaCabecalho.Count - 1 do
  begin
    //altera a situacao da PV selecionada para M de mesclada
    ConsultaSQL :=
      'update ECF_PRE_VENDA_CABECALHO set ' +
      'SITUACAO=:pSituacao '+
      ' where ID = :pId';

      try
        try
          Query := TSQLQuery.Create(nil);
          Query.SQLConnection := FDataModule.Conexao;
          Query.sql.Text := ConsultaSQL;
          Query.ParamByName('pId').AsInteger := TPreVendaVO(ListaPreVendaCabecalho.Items[i]).Id;
          Query.ParamByName('pSituacao').AsString := 'M';
          Query.ExecSQL();
        except
        end;
      finally
        Query.Free;
      end;
  end;

  //cria uma nova PV
  ConsultaSQL :=
    'insert into ECF_PRE_VENDA_CABECALHO (' +
    'DATA_PV,' +
    'HORA_PV,' +
    'SITUACAO) values (' +
    ':pDataEmissao,' +
    ':pHoraEmissao,' +
    ':psituacao)';
  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.ParamByName('pDataEmissao').AsString := NovaPreVenda.DataEmissao;
      Query.ParamByName('pHoraEmissao').AsString := NovaPreVenda.HoraEmissao;
      Query.ParamByName('psituacao').AsString := NovaPreVenda.Situacao;
      Query.ExecSQL();

      ConsultaSQL := 'select max(ID) as ID from ECF_PRE_VENDA_CABECALHO';
      Query.sql.Text := ConsultaSQL;
      Query.Open();

      NovaPreVenda.Id := Query.FieldByName('ID').AsInteger;
    except
    end;
  finally
    Query.Free;
  end;

  //atualiza a tabela de detalhes
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
        Query.ParamByName('pIdPreVenda').AsInteger := NovaPreVenda.Id;
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

  CancelaPreVendasPendentes(ListaPreVendaCabecalho, ListaPreVendaDetalhe);

  FCaixa.FechaMenuOperacoes;
  FCaixa.CarregaPreVenda(IntToStr(NovaPreVenda.Id));
end;

class Procedure TPreVendaController.CancelaPreVendasPendentes;
var
  ListaPreVendaCabecalho:TObjectList<TPreVendaVO>;
  ListaPreVendaDetalhe:TObjectList<TPreVendaDetalheVO>;
  TotalRegistros:Integer;
  QDetalhe: TSQLQuery;
  PreVendaCabecalho: TPreVendaVO;
  PreVendaDetalhe: TPreVendaDetalheVO;
begin
  //verifica se existem PV pendentes
  ConsultaSQL :=
    'select count(*) as TOTAL from ECF_PRE_VENDA_CABECALHO where ' +
    'SITUACAO = ' + QuotedStr('P') + ' and (DATA_PV < ' + QuotedStr(FormatDateTime('yyyy-mm-dd', FDataModule.ACBrECF.DataHora) + ')');

  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      TotalRegistros := Query.FieldByName('TOTAL').AsInteger;

      //caso existam PV pendentes procede com o processo de cancelamento de pre-vendas
      if TotalRegistros > 0 then
      begin
        ListaPreVendaCabecalho := TObjectList<TPreVendaVO>.Create;
        ListaPreVendaDetalhe := TObjectList<TPreVendaDetalheVO>.Create;
        //
        ConsultaSQL := 'select * from ECF_PRE_VENDA_CABECALHO where ' +
        'SITUACAO = ' + QuotedStr('P') + ' and (DATA_PV < ' + QuotedStr(FormatDateTime('yyyy-mm-dd', FDataModule.ACBrECF.DataHora) + ')');
        Query.sql.Text := ConsultaSQL;
        Query.Open;
        Query.First;
        while not Query.Eof do
        begin
          PreVendaCabecalho := TPreVendaVO.Create;
          PreVendaCabecalho.Id := Query.FieldByName('ID').AsInteger;
          PreVendaCabecalho.Valor := Query.FieldByName('VALOR').AsFloat;
          ListaPreVendaCabecalho.Add(PreVendaCabecalho);

          QDetalhe := TSQLQuery.Create(nil);
          QDetalhe.SQLConnection := FDataModule.Conexao;
          QDetalhe.sql.Text := 'SELECT * FROM ECF_PRE_VENDA_DETALHE WHERE ID_ECF_PRE_VENDA_CABECALHO='+IntToStr(PreVendaCabecalho.Id);
          QDetalhe.Open;

          QDetalhe.First;
          while not QDetalhe.Eof do
          begin
            PreVendaDetalhe := TPreVendaDetalheVO.Create;
            PreVendaDetalhe.ProdutoVO := TProdutoController.ConsultaId(QDetalhe.FieldByName('ID_PRODUTO').AsInteger);
            PreVendaDetalhe.IdPreVenda := QDetalhe.FieldByName('ID_ECF_PRE_VENDA_CABECALHO').AsInteger;
            PreVendaDetalhe.IdProduto := QDetalhe.FieldByName('ID_PRODUTO').AsInteger;
            PreVendaDetalhe.Quantidade := QDetalhe.FieldByName('QUANTIDADE').AsFloat;
            PreVendaDetalhe.ValorUnitario := QDetalhe.FieldByName('VALOR_UNITARIO').AsFloat;
            PreVendaDetalhe.ValorTotal := QDetalhe.FieldByName('VALOR_TOTAL').AsFloat;
            ListaPreVendaDetalhe.Add(PreVendaDetalhe);
            QDetalhe.Next;
          end;

          Query.Next;
        end;

        //atualiza no banco de dados
        ConsultaSQL :=
          'update ECF_PRE_VENDA_CABECALHO set ' +
          'SITUACAO = '+ QuotedStr('C') +
          ' where SITUACAO = ' + QuotedStr('P') + ' and (DATA_PV < ' + QuotedStr(FormatDateTime('yyyy-mm-dd', FDataModule.ACBrECF.DataHora) + ')');
        Query.sql.Text := ConsultaSQL;
        Query.ExecSQL();

        CancelaPreVendasPendentes(ListaPreVendaCabecalho,ListaPreVendaDetalhe);
      end;
    except
    end;
  finally
    Query.Free;
  end;
end;

class procedure TPreVendaController.CancelaPreVendasPendentes(
  ListaPreVendaCabecalho: TObjectList<TPreVendaVO>;
  ListaPreVendaDetalhe: TObjectList<TPreVendaDetalheVO>);
var
  Mensagem:String;
  i,j:integer;
  id:String;
begin
  for i := 0 to ListaPreVendaCabecalho.Count - 1 do
  begin
    id := IntToStr(TPreVendaVO(ListaPreVendaCabecalho.Items[i]).Id);
    Mensagem := 'PV' + StringOfChar('0',10-Length(id)) + id;
    FDataModule.ACBrECF.AbreCupom;
    for j := 0 to ListaPreVendaDetalhe.Count - 1 do
    begin
      if TPreVendaDetalheVO(ListaPreVendaDetalhe.Items[j]).IdPreVenda = TPreVendaVO(ListaPreVendaCabecalho.Items[i]).Id then
        FDataModule.ACBrECF.VendeItem(TPreVendaDetalheVO(ListaPreVendaDetalhe.Items[j]).ProdutoVO.GTIN, TPreVendaDetalheVO(ListaPreVendaDetalhe.Items[j]).ProdutoVO.DescricaoPDV, TPreVendaDetalheVO(ListaPreVendaDetalhe.Items[j]).ProdutoVO.ECFICMS, TPreVendaDetalheVO(ListaPreVendaDetalhe.Items[j]).Quantidade, TPreVendaDetalheVO(ListaPreVendaDetalhe.Items[j]).ValorUnitario);
    end;
    FDataModule.ACBrECF.EfetuaPagamento(FDataModule.ACBrECF.FormasPagamento[0].Indice,TPreVendaVO(ListaPreVendaCabecalho.Items[i]).Valor);
    UECF.FechaCupom(Mensagem);
    UECF.CancelaCupom;
  end;
end;

end.
