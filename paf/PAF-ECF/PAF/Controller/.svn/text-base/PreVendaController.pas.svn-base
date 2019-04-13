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
  Classes, SQLExpr, SysUtils, PreVendaDetalheVO, PreVendaCabecalhoVO, Generics.Collections,
  DB, Biblioteca, EmpresaVO, EmpresaController;

type
  TPreVendaController = class
  protected
  public
    class Function CarregaPreVenda(Id: Integer): TObjectList<TPreVendaDetalheVO>;
    class Procedure FechaPreVenda(Id: Integer; CCF: Integer);
    class Procedure MesclaPreVenda(ListaPreVendaCabecalho: TObjectList<TPreVendaCabecalhoVO>; ListaPreVendaDetalhe: TObjectList<TPreVendaDetalheVO>);
    class Procedure CancelaPreVendasPendentes(DataMovimento: TDateTime); overload;
    class Procedure CancelaPreVendasPendentes(ListaPreVendaCabecalho: TObjectList<TPreVendaCabecalhoVO>; ListaPreVendaDetalhe: TObjectList<TPreVendaDetalheVO>); overload;
    class procedure CancelaPreVendasPendentes(Id: Integer); overload;
  end;

implementation

uses UDataModule, UCaixa, ProdutoController, UECF, ClienteVO, VendaCabecalhoVO,
VendaDetalheVO, Constantes, VendaController, ProdutoVO, MovimentoController;

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
    'select count(*) as TOTAL from PRE_VENDA_CABECALHO where ' +
    'SITUACAO <> ' + QuotedStr('E') + ' and SITUACAO <> ' + QuotedStr('M') + ' and ID=' + IntToStr(Id);

  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.ConexaoBalcao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      TotalRegistros := Query.FieldByName('TOTAL').AsInteger;

      //caso exista a pre-venda, procede com a importação da mesma
      if TotalRegistros > 0 then
      begin
        //verifica se existem itens para a pre-venda
        ConsultaSQL :=
          'select count(*) as TOTAL from PRE_VENDA_DETALHE where ID_PRE_VENDA_CABECALHO='+IntToStr(Id);
        Query.sql.Text := ConsultaSQL;
        Query.Open;
        TotalRegistros := Query.FieldByName('TOTAL').AsInteger;

        //caso existam itens no detalhe
        if TotalRegistros > 0 then
        begin
          ConsultaSQL :=
            'select * from PRE_VENDA_CABECALHO where ID='+IntToStr(Id);
          Query.sql.Text := ConsultaSQL;
          Query.Open;

          if not Assigned(UCaixa.Cliente) then
            UCaixa.Cliente := TClienteVO.Create;

          UCaixa.Cliente.Id := Query.FieldByName('ID_PESSOA').AsInteger;
          UCaixa.Cliente.Nome := Query.FieldByName('NOME_DESTINATARIO').AsString;
          UCaixa.Cliente.CPFOuCNPJ := Query.FieldByName('CPF_CNPJ_DESTINATARIO').AsString;
          UCaixa.Desconto := Query.FieldByName('DESCONTO').AsFloat;
          UCaixa.Acrescimo := Query.FieldByName('ACRESCIMO').AsFloat;

          ListaVenda := TObjectList<TPreVendaDetalheVO>.Create(True);

          ConsultaSQL :=
            'select * from PRE_VENDA_DETALHE where ID_PRE_VENDA_CABECALHO='+IntToStr(Id);
          Query.sql.Text := ConsultaSQL;
          Query.Open;
          Query.First;
          while not Query.Eof do
          begin
            PreVendaDetalhe := TPreVendaDetalheVO.Create;
            PreVendaDetalhe.Id := Query.FieldByName('ID').AsInteger;
            PreVendaDetalhe.IdPreVenda := Id;
            PreVendaDetalhe.IdProduto := Query.FieldByName('ID_PRODUTO').AsInteger;
            PreVendaDetalhe.Item := Query.FieldByName('ITEM').AsInteger;
            PreVendaDetalhe.Quantidade := Query.FieldByName('QUANTIDADE').AsInteger;
            PreVendaDetalhe.ValorUnitario := Query.FieldByName('VALOR_UNITARIO').AsFloat;
            PreVendaDetalhe.ValorTotal := Query.FieldByName('VALOR_TOTAL').AsFloat;
            PreVendaDetalhe.Cancelado := Query.FieldByName('CANCELADO').AsString;
            PreVendaDetalhe.GtinProduto := Query.FieldByName('GTIN_PRODUTO').AsString;
            PreVendaDetalhe.NomeProduto := Query.FieldByName('NOME_PRODUTO').AsString;
            PreVendaDetalhe.UnidadeProduto := Query.FieldByName('UNIDADE_PRODUTO').AsString;
            PreVendaDetalhe.ECFICMS := Query.FieldByName('ECF_ICMS_ST').AsString;
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
    'update PRE_VENDA_CABECALHO set ' +
    'SITUACAO=:pSituacao, '+
    'CCF=:pCCF '+
    ' where ID = :pId';

  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.ConexaoBalcao;
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

class procedure TPreVendaController.MesclaPreVenda(ListaPreVendaCabecalho: TObjectList<TPreVendaCabecalhoVO>; ListaPreVendaDetalhe: TObjectList<TPreVendaDetalheVO>);
var
  i: Integer;
  NovaPreVenda: TPreVendaCabecalhoVO;
  TotalNovaPreVenda: Extended;
begin
  //inicia e configura a nova Pre-Venda
  NovaPreVenda := TPreVendaCabecalhoVO.Create;
  NovaPreVenda.IdPessoa := TPreVendaCabecalhoVO(ListaPreVendaCabecalho.Items[0]).IdPessoa;
  NovaPreVenda.NomeDestinatario := TPreVendaCabecalhoVO(ListaPreVendaCabecalho.Items[0]).NomeDestinatario;
  NovaPreVenda.CpfCnpjDestinatario := TPreVendaCabecalhoVO(ListaPreVendaCabecalho.Items[0]).CpfCnpjDestinatario;
  NovaPreVenda.DataEmissao := FormatDateTime('yyyy-mm-dd', now);
  NovaPreVenda.HoraEmissao := FormatDateTime('hh:nn:ss', now);
  NovaPreVenda.Situacao := 'P';
  TotalNovaPreVenda := 0;

  //atualiza a tabela de cabecalho
  for i := 0 to ListaPreVendaCabecalho.Count - 1 do
  begin
    //altera a situacao da PV selecionada para M de mesclada
    ConsultaSQL :=
      'update PRE_VENDA_CABECALHO set ' +
      'SITUACAO=:pSituacao '+
      ' where ID = :pId';

      TotalNovaPreVenda := TruncaValor(TotalNovaPreVenda, Constantes.TConstantes.DECIMAIS_VALOR) +
                           TruncaValor(TPreVendaCabecalhoVO(ListaPreVendaCabecalho.Items[i]).SubTotal, Constantes.TConstantes.DECIMAIS_VALOR);
      try
        try
          Query := TSQLQuery.Create(nil);
          Query.SQLConnection := FDataModule.ConexaoBalcao;
          Query.sql.Text := ConsultaSQL;
          Query.ParamByName('pId').AsInteger := TPreVendaCabecalhoVO(ListaPreVendaCabecalho.Items[i]).Id;
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
    'insert into PRE_VENDA_CABECALHO (' +
    'NOME_DESTINATARIO,' +
    'CPF_CNPJ_DESTINATARIO,' +
    'SUBTOTAL,' +
    'DATA_PV,' +
    'HORA_PV,' +
    'SITUACAO, ID_PESSOA) values (' +
    ':pDestinatario,' +
    ':pCPFCNPJ,' +
    ':pSubTotal,' +
    ':pDataEmissao,' +
    ':pHoraEmissao,' +
    ':psituacao, :pIdPessoa)';
  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.ConexaoBalcao;
      Query.sql.Text := ConsultaSQL;

      Query.ParamByName('pDestinatario').AsString := NovaPreVenda.NomeDestinatario;
      Query.ParamByName('pCPFCNPJ').AsString := NovaPreVenda.CpfCnpjDestinatario;
      Query.ParamByName('pDataEmissao').AsString := NovaPreVenda.DataEmissao;
      Query.ParamByName('pHoraEmissao').AsString := NovaPreVenda.HoraEmissao;
      Query.ParamByName('pSituacao').AsString := NovaPreVenda.Situacao;
      Query.ParamByName('pSubTotal').AsFloat := TotalNovaPreVenda;

      //ID Pessoa
      if NovaPreVenda.IdPessoa > 0 then
        Query.ParamByName('pIdPessoa').AsInteger := NovaPreVenda.IdPessoa
      else
      begin
        Query.ParamByName('pIdPessoa').DataType := ftInteger;
        Query.ParamByName('pIdPessoa').Clear;
      end;

      Query.ExecSQL();

      ConsultaSQL := 'select max(ID) as ID from PRE_VENDA_CABECALHO';
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
    'insert into PRE_VENDA_DETALHE (' +
    'ID_PRODUTO,' +
    'ID_PRE_VENDA_CABECALHO,' +
    'ITEM,' +
    'QUANTIDADE,' +
    'CANCELADO,' +
    'GTIN_PRODUTO,' +
    'NOME_PRODUTO,' +
    'UNIDADE_PRODUTO,' +
    'ECF_ICMS_ST,' +
    'VALOR_UNITARIO,' +
    'VALOR_TOTAL) '+
    ' values (' +
    ':pID_PRODUTO,' +
    ':pID_PRE_VENDA_CABECALHO,' +
    ':pITEM,' +
    ':pQUANTIDADE,' +
    ':pCANCELADO,' +
    ':pGTIN_PRODUTO,' +
    ':pNOME_PRODUTO,' +
    ':pUNIDADE_PRODUTO,' +
    ':pECF_ICMS_ST,' +
    ':pVALOR_UNITARIO,' +
    ':pVALOR_TOTAL)';
  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.ConexaoBalcao;
      Query.sql.Text := ConsultaSQL;
      for i := 0 to ListaPreVendaDetalhe.Count - 1 do
      begin
        Query.ParamByName('pID_PRODUTO').AsInteger := TPreVendaDetalheVO(ListaPreVendaDetalhe.Items[i]).IdProduto;
        Query.ParamByName('pID_PRE_VENDA_CABECALHO').AsInteger := NovaPreVenda.Id;
        Query.ParamByName('pITEM').AsInteger := TPreVendaDetalheVO(ListaPreVendaDetalhe.Items[i]).Item;
        Query.ParamByName('pQUANTIDADE').AsFloat := TPreVendaDetalheVO(ListaPreVendaDetalhe.Items[i]).Quantidade;
        Query.ParamByName('pCANCELADO').AsString := TPreVendaDetalheVO(ListaPreVendaDetalhe.Items[i]).Cancelado;
        Query.ParamByName('pGTIN_PRODUTO').AsString := TPreVendaDetalheVO(ListaPreVendaDetalhe.Items[i]).GtinProduto;
        Query.ParamByName('pNOME_PRODUTO').AsString := TPreVendaDetalheVO(ListaPreVendaDetalhe.Items[i]).NomeProduto;
        Query.ParamByName('pUNIDADE_PRODUTO').AsString := TPreVendaDetalheVO(ListaPreVendaDetalhe.Items[i]).UnidadeProduto;
        Query.ParamByName('pECF_ICMS_ST').AsString := TPreVendaDetalheVO(ListaPreVendaDetalhe.Items[i]).ECFICMS;
        Query.ParamByName('pVALOR_UNITARIO').AsFloat := TPreVendaDetalheVO(ListaPreVendaDetalhe.Items[i]).ValorUnitario;
        Query.ParamByName('pVALOR_TOTAL').AsFloat := TPreVendaDetalheVO(ListaPreVendaDetalhe.Items[i]).ValorTotal;
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

class procedure TPreVendaController.CancelaPreVendasPendentes(DataMovimento: TDateTime);
var
  ListaPreVendaCabecalho: TObjectList<TPreVendaCabecalhoVO>;
  ListaPreVendaDetalhe: TObjectList<TPreVendaDetalheVO>;
  TotalRegistros: Integer;
  QDetalhe: TSQLQuery;
  PreVendaCabecalho: TPreVendaCabecalhoVO;
  PreVendaDetalhe: TPreVendaDetalheVO;
begin
  //verifica se existem PV pendentes
  ConsultaSQL :=
    'select count(*) as TOTAL from PRE_VENDA_CABECALHO where ' +
    'SITUACAO = ' + QuotedStr('P') + ' and DATA_PV < :Data ';

  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.ConexaoBalcao;
      Query.sql.Text := ConsultaSQL;
      Query.ParamByName('Data').AsDateTime := DataMovimento;
      Query.Open;
      TotalRegistros := Query.FieldByName('TOTAL').AsInteger;

      //caso existam PV pendentes procede com o processo de cancelamento de pre-vendas
      if TotalRegistros > 0 then
      begin
        ListaPreVendaCabecalho := TObjectList<TPreVendaCabecalhoVO>.Create;
        ListaPreVendaDetalhe := TObjectList<TPreVendaDetalheVO>.Create;
        //
        ConsultaSQL := 'select * from PRE_VENDA_CABECALHO where ' +
        'SITUACAO = ' + QuotedStr('P') + ' and DATA_PV < :Data';
        Query.sql.Text := ConsultaSQL;
        Query.ParamByName('Data').AsDateTime := DataMovimento;
        Query.Open;
        Query.First;
        while not Query.Eof do
        begin
          PreVendaCabecalho := TPreVendaCabecalhoVO.Create;
          PreVendaCabecalho.Id := Query.FieldByName('ID').AsInteger;
          PreVendaCabecalho.Valor := Query.FieldByName('VALOR').AsFloat;
          ListaPreVendaCabecalho.Add(PreVendaCabecalho);

          QDetalhe := TSQLQuery.Create(nil);
          QDetalhe.SQLConnection := FDataModule.ConexaoBalcao;
          QDetalhe.sql.Text := 'SELECT * FROM PRE_VENDA_DETALHE WHERE ID_PRE_VENDA_CABECALHO='+IntToStr(PreVendaCabecalho.Id);
          QDetalhe.Open;

          QDetalhe.First;
          while not QDetalhe.Eof do
          begin
            PreVendaDetalhe := TPreVendaDetalheVO.Create;
            PreVendaDetalhe.IdProduto := QDetalhe.FieldByName('ID_PRODUTO').AsInteger;
            PreVendaDetalhe.IdPreVenda := QDetalhe.FieldByName('ID_PRE_VENDA_CABECALHO').AsInteger;
            PreVendaDetalhe.IdProduto := QDetalhe.FieldByName('ID_PRODUTO').AsInteger;
            PreVendaDetalhe.Item := QDetalhe.FieldByName('ITEM').AsInteger;
            PreVendaDetalhe.Quantidade := QDetalhe.FieldByName('QUANTIDADE').AsFloat;
            PreVendaDetalhe.ValorUnitario := QDetalhe.FieldByName('VALOR_UNITARIO').AsFloat;
            PreVendaDetalhe.ValorTotal := QDetalhe.FieldByName('VALOR_TOTAL').AsFloat;
            PreVendaDetalhe.Cancelado := QDetalhe.FieldByName('CANCELADO').AsString;
            PreVendaDetalhe.GtinProduto := QDetalhe.FieldByName('GTIN_PRODUTO').AsString;
            PreVendaDetalhe.NomeProduto := QDetalhe.FieldByName('NOME_PRODUTO').AsString;
            PreVendaDetalhe.UnidadeProduto := QDetalhe.FieldByName('UNIDADE_PRODUTO').AsString;
            PreVendaDetalhe.ECFICMS := QDetalhe.FieldByName('ECF_ICMS_ST').AsString;
            ListaPreVendaDetalhe.Add(PreVendaDetalhe);
            QDetalhe.Next;
          end;

          Query.Next;
        end;

        //atualiza no banco de dados
        ConsultaSQL :=
          'update PRE_VENDA_CABECALHO set ' +
          'SITUACAO = '+ QuotedStr('C') +
          ' where SITUACAO = ' + QuotedStr('P') + ' and DATA_PV < :Data';
        Query.sql.Text := ConsultaSQL;
        Query.ParamByName('Data').AsDateTime := DataMovimento;
        Query.ExecSQL();

        CancelaPreVendasPendentes(ListaPreVendaCabecalho,ListaPreVendaDetalhe);
      end;
    except
    end;
  finally
    Query.Free;
  end;
end;

class procedure TPreVendaController.CancelaPreVendasPendentes(ListaPreVendaCabecalho: TObjectList<TPreVendaCabecalhoVO>; ListaPreVendaDetalhe: TObjectList<TPreVendaDetalheVO>);
var
  Mensagem:String;
  Empresa: TEmpresaVO;
  IdMovimento, i, j, ItemCupom: Integer;
  Id: String;
  VendaCabecalho: TVendaCabecalhoVO;
  VendaDetalhe: TVendaDetalheVO;
  ListaVendaDetalhe: TObjectList<TVendaDetalheVO>;
  Produto: TProdutoVO;
begin
  IdMovimento := UCaixa.Movimento.Id;

  for i := 0 to ListaPreVendaCabecalho.Count - 1 do
  begin
    VendaCabecalho := TVendaCabecalhoVO.Create;
    ListaVendaDetalhe := TObjectList<TVendaDetalheVO>.Create;
    ItemCupom := 0;

    VendaCabecalho.IdMovimento := IdMovimento;
    VendaCabecalho.DataVenda := FormatDateTime('yyyy-mm-dd', FDataModule.ACBrECF.DataHora);
    VendaCabecalho.HoraVenda := FormatDateTime('hh:nn:ss', FDataModule.ACBrECF.DataHora);
    VendaCabecalho.StatusVenda := 'C';
    VendaCabecalho.CFOP := Configuracao.CFOPECF;
    VendaCabecalho.COO := StrToInt(FDataModule.ACBrECF.NumCOO);
    VendaCabecalho.CCF := StrToIntDef(FDataModule.ACBrECF.NumCCF,0);
    VendaCabecalho.ValorVenda := TPreVendaCabecalhoVO(ListaPreVendaCabecalho.Items[i]).Valor;
    VendaCabecalho.IdPreVenda := TPreVendaCabecalhoVO(ListaPreVendaCabecalho.Items[i]).Id;
    VendaCabecalho := TVendaController.IniciaVenda(VendaCabecalho);

    id := IntToStr(TPreVendaCabecalhoVO(ListaPreVendaCabecalho.Items[i]).Id);
    Mensagem := UCaixa.MD5 + 'PV' + StringOfChar('0',10-Length(id)) + id + #13 + #10;
    FDataModule.ACBrECF.AbreCupom;
    for j := 0 to ListaPreVendaDetalhe.Count - 1 do
    begin
      if TPreVendaDetalheVO(ListaPreVendaDetalhe.Items[j]).IdPreVenda = TPreVendaCabecalhoVO(ListaPreVendaCabecalho.Items[i]).Id then
      begin
        inc(ItemCupom);
        VendaDetalhe := TVendaDetalheVO.Create;
        Produto := TProdutoController.ConsultaId(TPreVendaDetalheVO(ListaPreVendaDetalhe.Items[j]).IdProduto);
        VendaDetalhe.IdProduto := TPreVendaDetalheVO(ListaPreVendaDetalhe.Items[j]).IdProduto;
        VendaDetalhe.CFOP := Configuracao.CFOPECF;
        VendaDetalhe.IdVendaCabecalho := VendaCabecalho.Id;
        VendaDetalhe.DescricaoPDV := Produto.DescricaoPDV;
        VendaDetalhe.UnidadeProduto := Produto.UnidadeProduto;
        VendaDetalhe.CST := Produto.Cst;
        VendaDetalhe.ECFICMS := Produto.ECFICMS;
        VendaDetalhe.TaxaICMS := Produto.AliquotaICMS;
        VendaDetalhe.TotalizadorParcial := Produto.TotalizadorParcial;
        VendaDetalhe.Quantidade := TPreVendaDetalheVO(ListaPreVendaDetalhe.Items[j]).Quantidade;
        VendaDetalhe.ValorUnitario := TPreVendaDetalheVO(ListaPreVendaDetalhe.Items[j]).ValorUnitario;
        VendaDetalhe.ValorTotal := TPreVendaDetalheVO(ListaPreVendaDetalhe.Items[j]).ValorTotal;
        if trim(Produto.GTIN)= '' then
          VendaDetalhe.GTIN := IntToStr(Produto.Id)
        else
          VendaDetalhe.GTIN := Produto.GTIN;

        VendaDetalhe.Item := ItemCupom;
        if Produto.IPPT = 'T' then
          VendaDetalhe.MovimentaEstoque := 'S'
        else
          VendaDetalhe.MovimentaEstoque := 'N';

        ListaVendaDetalhe.Add(VendaDetalhe);
        TVendaController.InserirItem(VendaDetalhe);

        FDataModule.ACBrECF.VendeItem(TPreVendaDetalheVO(ListaPreVendaDetalhe.Items[j]).GtinProduto, TPreVendaDetalheVO(ListaPreVendaDetalhe.Items[j]).NomeProduto, TPreVendaDetalheVO(ListaPreVendaDetalhe.Items[j]).ECFICMS, TPreVendaDetalheVO(ListaPreVendaDetalhe.Items[j]).Quantidade, TPreVendaDetalheVO(ListaPreVendaDetalhe.Items[j]).ValorUnitario);
      end;
    end;//for j := 0 to ListaPreVendaDetalhe.Count - 1 do

    FDataModule.ACBrECF.SubtotalizaCupom();
    FDataModule.ACBrECF.EfetuaPagamento(FDataModule.ACBrECF.FormasPagamento[0].Indice,TPreVendaCabecalhoVO(ListaPreVendaCabecalho.Items[i]).Valor);

    try
      Empresa := TEmpresaController.PegaEmpresa(UCaixa.Configuracao.IdEmpresa);
      if Empresa.UF = 'MG' then
      begin
         Mensagem := Mensagem +'MINAS LEGAL:'+
                  COPY(DevolveInteiro(Empresa.CNPJ),1,8)+
                  FormatDateTime('ddmmyyyy', FDataModule.ACBrECF.DataHora);
         if UCaixa.VendaCabecalho.ValorFinal >= 1 then
            begin
               Mensagem := Mensagem + DevolveInteiro(Format('%7.0n',[UCaixa.VendaCabecalho.ValorFinal]));
            end;
         Mensagem := Mensagem + #13 + #10;
      end;
    finally
      if Assigned(Empresa) then
        FreeAndNil(Empresa);
    end;

    UECF.FechaCupom(Mensagem + UCaixa.Configuracao.MensagemCupom);
    UECF.CancelaCupom;
    TVendaController.CancelaVenda(VendaCabecalho, ListaVendaDetalhe);
  end;//for i := 0 to ListaPreVendaCabecalho.Count - 1 do

  UCaixa.Movimento := TMovimentoController.VerificaMovimento;
end;

class Procedure TPreVendaController.CancelaPreVendasPendentes(Id: Integer);
var
  ListaPreVendaCabecalho:TObjectList<TPreVendaCabecalhoVO>;
  ListaPreVendaDetalhe:TObjectList<TPreVendaDetalheVO>;
  QDetalhe: TSQLQuery;
  PreVendaCabecalho: TPreVendaCabecalhoVO;
  PreVendaDetalhe: TPreVendaDetalheVO;
begin
  try
    try
      begin
        ListaPreVendaCabecalho := TObjectList<TPreVendaCabecalhoVO>.Create;
        ListaPreVendaDetalhe := TObjectList<TPreVendaDetalheVO>.Create;
        //
        ConsultaSQL := 'select * from PRE_VENDA_CABECALHO where ID=' +IntToStr(Id);
        Query := TSQLQuery.Create(nil);
        Query.SQLConnection := FDataModule.ConexaoBalcao;
        Query.sql.Text := ConsultaSQL;
        Query.Open;
        begin
          PreVendaCabecalho := TPreVendaCabecalhoVO.Create;
          PreVendaCabecalho.Id := Query.FieldByName('ID').AsInteger;
          PreVendaCabecalho.Valor := Query.FieldByName('VALOR').AsFloat;
          ListaPreVendaCabecalho.Add(PreVendaCabecalho);

          QDetalhe := TSQLQuery.Create(nil);
          QDetalhe.SQLConnection := FDataModule.ConexaoBalcao;
          QDetalhe.sql.Text := 'SELECT * FROM PRE_VENDA_DETALHE WHERE ID_PRE_VENDA_CABECALHO='+IntToStr(PreVendaCabecalho.Id);
          QDetalhe.Open;

          QDetalhe.First;
          while not QDetalhe.Eof do
          begin
            PreVendaDetalhe := TPreVendaDetalheVO.Create;
            PreVendaDetalhe.IdProduto := QDetalhe.FieldByName('ID_PRODUTO').AsInteger;
            PreVendaDetalhe.IdPreVenda := QDetalhe.FieldByName('ID_PRE_VENDA_CABECALHO').AsInteger;
            PreVendaDetalhe.IdProduto := QDetalhe.FieldByName('ID_PRODUTO').AsInteger;
            PreVendaDetalhe.Item := QDetalhe.FieldByName('ITEM').AsInteger;
            PreVendaDetalhe.Quantidade := QDetalhe.FieldByName('QUANTIDADE').AsFloat;
            PreVendaDetalhe.ValorUnitario := QDetalhe.FieldByName('VALOR_UNITARIO').AsFloat;
            PreVendaDetalhe.ValorTotal := QDetalhe.FieldByName('VALOR_TOTAL').AsFloat;
            PreVendaDetalhe.Cancelado := QDetalhe.FieldByName('CANCELADO').AsString;
            PreVendaDetalhe.GtinProduto := QDetalhe.FieldByName('GTIN_PRODUTO').AsString;
            PreVendaDetalhe.NomeProduto := QDetalhe.FieldByName('NOME_PRODUTO').AsString;
            PreVendaDetalhe.UnidadeProduto := QDetalhe.FieldByName('UNIDADE_PRODUTO').AsString;
            PreVendaDetalhe.ECFICMS := QDetalhe.FieldByName('ECF_ICMS_ST').AsString;
            ListaPreVendaDetalhe.Add(PreVendaDetalhe);
            QDetalhe.Next;
          end;

          Query.Next;
        end;

        //atualiza no banco de dados
        ConsultaSQL :=
          'update PRE_VENDA_CABECALHO set ' +
          'SITUACAO = '+ QuotedStr('C') +
          ' where ID=' +IntToStr(PreVendaCabecalho.Id);
        Query.sql.Text := ConsultaSQL;
        Query.ExecSQL();

        FCaixa.FechaMenuOperacoes;
        CancelaPreVendasPendentes(ListaPreVendaCabecalho,ListaPreVendaDetalhe);
      end;
    except
    end;
  finally
    Query.Free;
  end;
end;

end.