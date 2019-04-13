{*******************************************************************************
Title: T2Ti ERP
Description: Classe de controle da venda.

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
unit VendaController;

interface

uses
  Classes, SQLExpr, SysUtils, VendaCabecalhoVO, VendaDetalheVO, Generics.Collections,
  DB, PreVendaController, DAVController, Biblioteca, Constantes;

type
  TVendaController = class
  protected
  public
    class Function IniciaVenda(pVendaCabecalho: TVendaCabecalhoVO): TVendaCabecalhoVO;
    class Function InserirItem(pVendaDetalhe: TVendaDetalheVO): TVendaDetalheVO;
    class Procedure EncerraVenda(pVendaCabecalho: TVendaCabecalhoVO);
    class Function VendaAberta: TObjectList<TVendaDetalheVO>; overload;
    class Function VendaAberta(p:String): Boolean; overload;
    class Function VendaComProblemas: TObjectList<TVendaDetalheVO>;
    class Procedure CancelaVenda(pVendaCabecalho: TVendaCabecalhoVO; pListaVendaDetalhe: TObjectList<TVendaDetalheVO>);
    class Procedure CancelaItem(pVendaDetalhe: TVendaDetalheVO);
    class function CupomJaFoiCancelado: Boolean;
    class function CancelaVendaAnterior: Boolean;
    class function CalculaImpostos(pVendaCabecalho: TVendaCabecalhoVO): TVendaCabecalhoVO;
    class procedure AtualizaItens(pListaVendaDetalhe: TObjectList<TVendaDetalheVO>);

  end;

implementation

uses UDataModule, UEcf;

var
  ConsultaSQL: String;
  Query: TSQLQuery;

class function TVendaController.IniciaVenda(pVendaCabecalho: TVendaCabecalhoVO) : TVendaCabecalhoVO;
begin
  ConsultaSQL :=
    'insert into ECF_VENDA_CABECALHO (' +
    'STATUS_VENDA,' +
    'ID_ECF_MOVIMENTO,' +
    'CFOP,' +
    'COO,' +
    'CCF,' +
    'ID_CLIENTE,' +
    'NOME_CLIENTE,' +
    'CPF_CNPJ_CLIENTE,' +
    'DATA_VENDA,' +
    'HORA_VENDA) values (' +
    ':pStatus,' +
    ':pMovimento,' +
    ':pCFOP,' +
    ':pCOO,' +
    ':pCCF,' +
    ':pIdCliente,' +
    ':pNomeCliente,' +
    ':pCPFouCNPJCliente,' +
    ':pDataVenda,' +
    ':pHoraVenda)';

  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.ParamByName('pStatus').AsString := pVendaCabecalho.StatusVenda;
      Query.ParamByName('pMovimento').AsInteger := pVendaCabecalho.IdMovimento;
      Query.ParamByName('pCFOP').AsInteger := pVendaCabecalho.CFOP;
      Query.ParamByName('pCOO').AsInteger := pVendaCabecalho.COO;
      Query.ParamByName('pCCF').AsInteger := pVendaCabecalho.CCF;

      if pVendaCabecalho.IdCliente <> 0 then
        Query.ParamByName('pIdCliente').AsInteger := pVendaCabecalho.IdCliente
      else
      begin
        Query.ParamByName('pIdCliente').DataType := ftInteger;
        Query.ParamByName('pIdCliente').Clear;
      end;

      Query.ParamByName('pNomeCliente').AsString := pVendaCabecalho.NomeCliente;
      Query.ParamByName('pCPFouCNPJCliente').AsString := pVendaCabecalho.CPFouCNPJCliente;
      Query.ParamByName('pDataVenda').AsString := pVendaCabecalho.DataVenda;
      Query.ParamByName('pHoraVenda').AsString := pVendaCabecalho.HoraVenda;
      Query.ExecSQL();

      ConsultaSQL := 'select max(ID) as ID from ECF_VENDA_CABECALHO';
      Query.sql.Text := ConsultaSQL;
      Query.Open();

      pVendaCabecalho.Id := Query.FieldByName('ID').AsInteger;
      result := pVendaCabecalho;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;

class Function TVendaController.InserirItem(pVendaDetalhe: TVendaDetalheVO): TVendaDetalheVO;
var
  Tripa, Hash: String;
begin
  ConsultaSQL :=
    'insert into ECF_VENDA_DETALHE (' +
    'CFOP,' +
    'ID_ECF_PRODUTO,' +
    'ID_ECF_VENDA_CABECALHO,' +
    'ITEM,' +
    'QUANTIDADE,' +
    'VALOR_UNITARIO,' +
    'VALOR_TOTAL,' +
    'TOTALIZADOR_PARCIAL,' +
    'CST,' +
    'HASH_TRIPA,' +
    'CANCELADO,' +
    'TAXA_ICMS,' +
    'MOVIMENTA_ESTOQUE) values (' +

    ':pCFOP,' +
    ':pIdProduto,' +
    ':pIdVendaCabecalho,' +
    ':pItem,' +
    ':pQuantidade,' +
    ':pValorUnitario,' +
    ':pValorTotal,' +
    ':pTotalizadorParcial,' +
    ':pCST,' +
    ':pHash,' +
    ':pCancelado,' +
    ':pTaxaICMS,' +
    ':pMovimentaEstoque)';


  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;

      //calcula e grava o hash
      Tripa := pVendaDetalhe.GTIN +
               FormataFloat('Q',pVendaDetalhe.Quantidade) +
               FormataFloat('V',pVendaDetalhe.ValorUnitario) +
               FormataFloat('V',pVendaDetalhe.TotalItem) +
               pVendaDetalhe.TotalizadorParcial + 'N';
      Hash := MD5String(Tripa);

      Query.ParamByName('pHash').AsString := Hash;
      Query.ParamByName('pCFOP').AsInteger := pVendaDetalhe.CFOP;
      Query.ParamByName('pIdProduto').AsInteger := pVendaDetalhe.IdProduto;
      Query.ParamByName('pIdVendaCabecalho').AsInteger := pVendaDetalhe.IdVendaCabecalho;
      Query.ParamByName('pItem').AsInteger := pVendaDetalhe.Item;
      Query.ParamByName('pQuantidade').AsFloat := pVendaDetalhe.Quantidade;
      Query.ParamByName('pValorUnitario').AsFloat := pVendaDetalhe.ValorUnitario;
      Query.ParamByName('pValorTotal').AsFloat := pVendaDetalhe.ValorTotal;
      Query.ParamByName('pTotalizadorParcial').AsString := pVendaDetalhe.TotalizadorParcial;
      Query.ParamByName('pCST').AsString := pVendaDetalhe.CST;
      Query.ParamByName('pMovimentaEstoque').AsString := pVendaDetalhe.MovimentaEstoque;
      Query.ParamByName('pCancelado').AsString := 'N';

      if (pVendaDetalhe.ECFICMS <> 'II') and (pVendaDetalhe.ECFICMS <> 'NN') then
        Query.ParamByName('pTaxaICMS').AsFloat := pVendaDetalhe.TaxaICMS
      else
        Query.ParamByName('pTaxaICMS').AsFloat := 0;

      Query.ExecSQL();

      ConsultaSQL := 'select max(ID) as ID from ECF_VENDA_DETALHE';
      Query.sql.Text := ConsultaSQL;
      Query.Open();

      pVendadetalhe.Id := Query.FieldByName('ID').AsInteger;
      result := pVendaDetalhe;
    except
    end;
  finally
    Query.Free;
  end;
end;

class procedure TVendaController.EncerraVenda(pVendaCabecalho: TVendaCabecalhoVO);
var
  Tripa, Hash: String;
begin
  pVendaCabecalho := CalculaImpostos(pVendaCabecalho);

  ConsultaSQL :=
    'update ECF_VENDA_CABECALHO set ' +
    'VALOR_VENDA=:pValorVenda, '+
    'TOTAL_PRODUTOS=:pValorVenda, '+
    'TOTAL_DOCUMENTO=:pValorVenda, '+
    'BASE_ICMS=:pBaseICMS, '+
    'ICMS_OUTRAS=:pOutrasICMS, '+
    'ICMS=:pICMS, '+
    'VALOR_FINAL=:pValorFinal, '+
    'VALOR_RECEBIDO=:pValorRecebido, '+
    'TAXA_DESCONTO=:pTaxaDesconto, '+
    'DESCONTO=:pDesconto, '+
    'TAXA_ACRESCIMO=:pTaxaAcrescimo, '+
    'ACRESCIMO=:pAcrescimo, '+
    'TROCO=:pTroco, '+
    'ID_ECF_DAV=:pDav, '+
    'ID_ECF_PRE_VENDA_CABECALHO=:pPreVenda, '+
    'STATUS_VENDA=:pStatus, '+
    'ID_ECF_FUNCIONARIO=:pVendedor, '+
    'CUPOM_CANCELADO=:pCupomFoiCancelado, '+
    'HASH_TRIPA=:pHash '+
    ' where ID = :pId';

  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.ParamByName('pId').AsInteger := pVendaCabecalho.Id;
      Query.ParamByName('pValorVenda').AsFloat := pVendaCabecalho.ValorVenda;
      Query.ParamByName('pValorFinal').AsFloat := pVendaCabecalho.ValorFinal;
      Query.ParamByName('pValorRecebido').AsFloat := pVendaCabecalho.ValorRecebido;
      Query.ParamByName('pTaxaDesconto').AsFloat := pVendaCabecalho.TaxaDesconto;
      Query.ParamByName('pDesconto').AsFloat := pVendaCabecalho.Desconto;
      Query.ParamByName('pTaxaAcrescimo').AsFloat := pVendaCabecalho.TaxaAcrescimo;
      Query.ParamByName('pAcrescimo').AsFloat := pVendaCabecalho.Acrescimo;
      Query.ParamByName('pTroco').AsFloat := pVendaCabecalho.Troco;
      Query.ParamByName('pStatus').AsString := pVendaCabecalho.StatusVenda;
      Query.ParamByName('pCupomFoiCancelado').AsString := pVendaCabecalho.CupomFoiCancelado;

      Query.ParamByName('pBaseICMS').AsFloat := pVendaCabecalho.BaseICMS;
      Query.ParamByName('pOutrasICMS').AsFloat := pVendaCabecalho.ICMSOutras;
      Query.ParamByName('pICMS').AsFloat := pVendaCabecalho.ICMS;

      //calcula e grava o hash
      Tripa := IntToStr(pVendaCabecalho.Id) +
               IntToStr(pVendaCabecalho.CCF) +
               IntToStr(pVendaCabecalho.COO) +
               FormataFloat('V',pVendaCabecalho.ValorFinal) + pVendaCabecalho.StatusVenda;
      Hash := MD5String(Tripa);

      Query.ParamByName('pHash').AsString := Hash;

      //Vendedor
      if pVendaCabecalho.IdVendedor <> 0 then
        Query.ParamByName('pVendedor').AsInteger := pVendaCabecalho.IdVendedor
      else
      begin
        Query.ParamByName('pVendedor').DataType := ftInteger;
        Query.ParamByName('pVendedor').Clear;
      end;
      //PreVenda
      if pVendaCabecalho.IdPreVenda <> 0 then
      begin
        Query.ParamByName('pPreVenda').AsInteger := pVendaCabecalho.IdPreVenda;
        TPreVendaController.FechaPreVenda(pVendaCabecalho.IdPreVenda, pVendaCabecalho.CCF);
      end
      else
      begin
        Query.ParamByName('pPreVenda').DataType := ftInteger;
        Query.ParamByName('pPreVenda').Clear;
      end;
      //DAV
      if pVendaCabecalho.IdDAV <> 0 then
      begin
        Query.ParamByName('pDav').AsInteger := pVendaCabecalho.IdDAV;
        TDAVController.FechaDAV(pVendaCabecalho.IdDAV, pVendaCabecalho.CCF, pVendaCabecalho.COO);
      end
      else
      begin
        Query.ParamByName('pDav').DataType := ftInteger;
        Query.ParamByName('pDav').Clear;
      end;
      Query.ExecSQL();
    except
    end;
  finally
    Query.Free;
  end;
end;

class function TVendaController.CalculaImpostos(pVendaCabecalho: TVendaCabecalhoVO): TVendaCabecalhoVO;
var
  ListaVendaDetalhe: TObjectList<TVendaDetalheVO>;
  VendaDetalhe: TVendaDetalheVO;
  i: integer;
  BaseICMSCabecalho, OutrasICMSCabecalho, ICMSCabecalho: Extended;
  DescontoRateio, AcrescimoRateio, ResiduoDesconto, ResiduoAcrescimo: Extended;
begin
  BaseICMSCabecalho := 0;
  OutrasICMSCabecalho := 0;
  ICMSCabecalho := 0;
  //
  DescontoRateio := 0;
  AcrescimoRateio := 0;
  ResiduoDesconto := 0;
  ResiduoAcrescimo := 0;

  try
    try
      //seleciona os registros de detalhes da venda pertencentes a venda atual
      ConsultaSQL :=
        'select VD.*, P.GTIN ' +
        'from ECF_VENDA_DETALHE VD, PRODUTO P ' +
        'where VD.ID_ECF_PRODUTO = P.ID ' +
        ' and ID_ECF_VENDA_CABECALHO=' + IntToStr(pVendaCabecalho.Id);

      ListaVendaDetalhe := TObjectList<TVendaDetalheVO>.Create;

      //popula a lista de detalhes da venda com os registros retornados
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      Query.First;
      while not Query.Eof do
      begin
        VendaDetalhe := TVendaDetalheVO.Create;
        VendaDetalhe.Id := Query.FieldByName('ID').AsInteger;
        VendaDetalhe.CFOP := Query.FieldByName('CFOP').AsInteger;
        VendaDetalhe.GTIN := Query.FieldByName('GTIN').AsString;
        VendaDetalhe.IdProduto := Query.FieldByName('ID_ECF_PRODUTO').AsInteger;
        VendaDetalhe.Quantidade := Query.FieldByName('QUANTIDADE').AsInteger;
        VendaDetalhe.ValorUnitario := Query.FieldByName('VALOR_UNITARIO').AsFloat;
        VendaDetalhe.ValorTotal := Query.FieldByName('VALOR_TOTAL').AsFloat;
        VendaDetalhe.TotalizadorParcial := Query.FieldByName('TOTALIZADOR_PARCIAL').AsString;
        VendaDetalhe.TaxaICMS := Query.FieldByName('TAXA_ICMS').AsFloat;
        ListaVendaDetalhe.Add(VendaDetalhe);
        Query.next;
      end;

      //laco para fazer os devidos calculos de impostos e rateio de desconto/acrescimo
      for i := 0 to ListaVendaDetalhe.Count-1 do
      begin
        VendaDetalhe := ListaVendaDetalhe.Items[i];

        VendaDetalhe.DescontoRateio := 0;
        VendaDetalhe.AcrescimoRateio := 0;
        if pVendaCabecalho.Desconto > 0 then
        begin
          VendaDetalhe.DescontoRateio := TruncaValor(VendaDetalhe.ValorTotal * pVendaCabecalho.Desconto / pVendaCabecalho.ValorVenda, Constantes.TConstantes.DECIMAIS_VALOR);
          DescontoRateio := DescontoRateio + VendaDetalhe.DescontoRateio;
        end
        else if pVendaCabecalho.Acrescimo > 0 then
        begin
          VendaDetalhe.AcrescimoRateio := TruncaValor(VendaDetalhe.ValorTotal * pVendaCabecalho.Acrescimo / pVendaCabecalho.ValorVenda, Constantes.TConstantes.DECIMAIS_VALOR);
          AcrescimoRateio := AcrescimoRateio + VendaDetalhe.AcrescimoRateio;
        end;

        VendaDetalhe.TotalItem := TruncaValor(VendaDetalhe.ValorTotal - VendaDetalhe.DescontoRateio + VendaDetalhe.AcrescimoRateio, Constantes.TConstantes.DECIMAIS_VALOR);
        VendaDetalhe.BaseICMS := TruncaValor(VendaDetalhe.ValorTotal - VendaDetalhe.DescontoRateio + VendaDetalhe.AcrescimoRateio, Constantes.TConstantes.DECIMAIS_VALOR);
        VendaDetalhe.ICMS := TruncaValor(VendaDetalhe.BaseICMS * VendaDetalhe.TaxaICMS / 100, Constantes.TConstantes.DECIMAIS_VALOR);

        if (VendaDetalhe.TotalizadorParcial = 'N1') or (VendaDetalhe.TotalizadorParcial = 'F1') then
          OutrasICMSCabecalho := OutrasICMSCabecalho + VendaDetalhe.ValorTotal
        else
          BaseICMSCabecalho := BaseICMSCabecalho + VendaDetalhe.ValorTotal;
        ICMSCabecalho := ICMSCabecalho + VendaDetalhe.ICMS;
      end;

      //armazena as informacoes de impostos de cabecalho para retornar para o metodo que fecha a venda
      pVendaCabecalho.BaseICMS := BaseICMSCabecalho;
      pVendaCabecalho.ICMSOutras := OutrasICMSCabecalho;
      pVendaCabecalho.ICMS := ICMSCabecalho;

      //armazena os possiveis residuos para gravar no item do grupo de aliquota que tem o maior valor na venda
      ResiduoDesconto := pVendaCabecalho.Desconto - DescontoRateio;
      ResiduoAcrescimo := pVendaCabecalho.Acrescimo - AcrescimoRateio;

      //se houver residuo no desconto/acrescimo, deve-se armazenar o mesmo
      if (ResiduoDesconto > 0) or (ResiduoAcrescimo > 0) then
      begin
        //essa consulta vai trazer apenas um registro contendo o totalizador parcial
        //cujo valor é o maior nessa venda
        ConsultaSQL :=
          'select TOTALIZADOR_PARCIAL,sum(VALOR_TOTAL) as TOTAL ' +
          ' from ECF_VENDA_DETALHE where ID_ECF_VENDA_CABECALHO=' + IntToStr(pVendaCabecalho.Id) +
          ' group by TOTALIZADOR_PARCIAL ' +
          ' order by TOTAL desc ' +
          ' limit 1';

        Query := TSQLQuery.Create(nil);
        Query.SQLConnection := FDataModule.Conexao;
        Query.sql.Text := ConsultaSQL;
        Query.Open;

        //neste laco vamos encontrar um item que pertenca ao grupo acima e lancar o residuo nele
        for i := 0 to ListaVendaDetalhe.Count-1 do
        begin
          VendaDetalhe := ListaVendaDetalhe.Items[i];
          if VendaDetalhe.TotalizadorParcial = Query.FieldByName('TOTALIZADOR_PARCIAL').AsString then
          begin
            VendaDetalhe.DescontoRateio := VendaDetalhe.DescontoRateio + ResiduoDesconto;
            VendaDetalhe.AcrescimoRateio := VendaDetalhe.AcrescimoRateio + ResiduoAcrescimo;
            Break;
          end;
        end;
      end;

      AtualizaItens(ListaVendaDetalhe);

      result := pVendaCabecalho;
    except
    end;
  finally
    Query.Free;
  end;
end;

class procedure TVendaController.AtualizaItens(pListaVendaDetalhe: TObjectList<TVendaDetalheVO>);
var
  Tripa, Hash: String;
  i: integer;
  VendaDetalhe: TVendaDetalheVO;
  Query : TSQLQuery;
begin
  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;

      for i := 0 to pListaVendaDetalhe.Count - 1 do
      begin
        VendaDetalhe := pListaVendaDetalhe.Items[i];
        Query.sql.Text :=
          'update ECF_VENDA_DETALHE set ' +
          'TOTAL_ITEM = :pTotalItem,' +
          'BASE_ICMS = :pBaseIcms,' +
          'ICMS = :pIcms,' +
          'DESCONTO_RATEIO = :pDescontoRateio,' +
          'ACRESCIMO_RATEIO = :pAcrescimoRateio,' +
          'HASH_TRIPA=:pHash '+
          ' where ID = :pId';

        //calcula e grava o hash
        Tripa := VendaDetalhe.GTIN +
                 FormataFloat('Q',VendaDetalhe.Quantidade) +
                 FormataFloat('V',VendaDetalhe.ValorUnitario) +
                 FormataFloat('V',VendaDetalhe.TotalItem) +
                 VendaDetalhe.TotalizadorParcial + 'N';
        Hash := MD5String(Tripa);

        Query.ParamByName('pHash').AsString := Hash;
        Query.ParamByName('pId').AsInteger := VendaDetalhe.Id;
        Query.ParamByName('pTotalItem').AsFloat := VendaDetalhe.TotalItem;
        Query.ParamByName('pBaseIcms').AsFloat := VendaDetalhe.BaseICMS;
        Query.ParamByName('pIcms').AsFloat := VendaDetalhe.ICMS;
        Query.ParamByName('pDescontoRateio').AsFloat := VendaDetalhe.DescontoRateio;
        Query.ParamByName('pAcrescimoRateio').AsFloat := VendaDetalhe.AcrescimoRateio;

        Query.ExecSQL();
      end;
    except
    end;
  finally
    Query.Free;
  end;
end;

class function TVendaController.VendaAberta: TObjectList<TVendaDetalheVO>;
var
  ListaVenda: TObjectList<TVendaDetalheVO>;
  VendaDetalhe: TVendaDetalheVO;
  TotalRegistros: Integer;
begin
  //verifica se existe alguma venda aberta
  ConsultaSQL :=
    'select count(*) as TOTAL from ECF_VENDA_CABECALHO where STATUS_VENDA = ' + QuotedStr('A');

  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      TotalRegistros := Query.FieldByName('TOTAL').AsInteger;

      //se existe algum registro com venda aberta inicia a recuperação da venda
      if TotalRegistros > 0 then
      begin
        //verifica se existem itens para a venda aberta
        ConsultaSQL :=
          'select ' +
          'C.ID as CID, D.ID as DID, C.STATUS_VENDA, D.ID_ECF_PRODUTO, '+
          'D.QUANTIDADE, D.VALOR_UNITARIO, C.CPF_CNPJ_CLIENTE, '+
          'D.VALOR_TOTAL, D.CFOP, P.GTIN, P.ID ' +
          'from ' +
          'ECF_VENDA_CABECALHO C LEFT JOIN ECF_VENDA_DETALHE D ON C.ID=D.ID_ECF_VENDA_CABECALHO, '+
          'PRODUTO P ' +
          'where ' +
          'C.STATUS_VENDA = ' + QuotedStr('A') + ' and D.CANCELADO = ' + QuotedStr('N') + ' and D.ID_ECF_PRODUTO=P.ID';

        ListaVenda := TObjectList<TVendaDetalheVO>.Create;

        Query.sql.Text := ConsultaSQL;
        Query.Open;
        Query.First;
        while not Query.Eof do
        begin
          VendaDetalhe := TVendaDetalheVO.Create;
          VendaDetalhe.Id := Query.FieldByName('DID').AsInteger;
          VendaDetalhe.IdVendaCabecalho := Query.FieldByName('CID').AsInteger;
          VendaDetalhe.CFOP := Query.FieldByName('CFOP').AsInteger;
          VendaDetalhe.IdProduto := Query.FieldByName('ID_ECF_PRODUTO').AsInteger;
          VendaDetalhe.Quantidade := Query.FieldByName('QUANTIDADE').AsInteger;
          VendaDetalhe.ValorUnitario := Query.FieldByName('VALOR_UNITARIO').AsFloat;
          VendaDetalhe.ValorTotal := Query.FieldByName('VALOR_TOTAL').AsFloat;
          VendaDetalhe.GTIN := Query.FieldByName('GTIN').AsString;
          VendaDetalhe.IdentificacaoCliente := Query.FieldByName('CPF_CNPJ_CLIENTE').AsString;
          ListaVenda.Add(VendaDetalhe);
          Query.next;
        end;

        //caso existam itens, continua com a recuperação da venda
        if ListaVenda.Count > 0 then
        begin
          result := ListaVenda;
        end
        //caso tenha sido aberto um cupom, mas não tenha sido inserido nenhum item
        //altera o status da venda para cancelado e chama o método para cancelamento do cupom
        else
        begin
          ConsultaSQL :=
            'update ECF_VENDA_CABECALHO set STATUS_VENDA='+QuotedStr('C') +
            ' where STATUS_VENDA = ' + QuotedStr('A');

          try
            try
              Query.sql.Text := ConsultaSQL;
              Query.ExecSQL();
              UEcf.CancelaCupom;
              result := nil;
            except
            end;
          finally
          end;
        end;
      end
      //caso não existe uma venda aberta, retorna um ponteiro nulo
      else
        result := nil;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;

class function TVendaController.VendaAberta(p:String): Boolean;
var
  TotalRegistros: Integer;
begin
  //verifica se existe alguma venda aberta
  ConsultaSQL :=
    'select count(*) as TOTAL from ECF_VENDA_CABECALHO where STATUS_VENDA = ' + QuotedStr('A');

  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      TotalRegistros := Query.FieldByName('TOTAL').AsInteger;

      if TotalRegistros > 0 then
        result := true
      else
        result := false;
    except
      result := false;
    end;
  finally
    Query.Free;
  end;
end;

class function TVendaController.VendaComProblemas: TObjectList<TVendaDetalheVO>;
var
  ListaVenda: TObjectList<TVendaDetalheVO>;
  VendaDetalhe: TVendaDetalheVO;
  TotalRegistros: Integer;
begin
  //verifica se existe alguma venda com problemas
  ConsultaSQL :=
    'select count(*) as TOTAL from ECF_VENDA_CABECALHO where STATUS_VENDA = ' + QuotedStr('P');

  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      TotalRegistros := Query.FieldByName('TOTAL').AsInteger;

      if TotalRegistros > 0 then
      begin
        //carrega os itens da venda problematica numa lista
        ConsultaSQL :=
          'select ' +
          'C.ID as CID, D.ID as DID, C.STATUS_VENDA, D.ID_ECF_PRODUTO, '+
          'D.QUANTIDADE, D.VALOR_UNITARIO, C.CPF_CNPJ_CLIENTE, '+
          'D.VALOR_TOTAL, D.CFOP, P.GTIN, P.ID ' +
          'from ' +
          'ECF_VENDA_CABECALHO C LEFT JOIN ECF_VENDA_DETALHE D ON C.ID=D.ID_ECF_VENDA_CABECALHO, '+
          'PRODUTO P ' +
          'where ' +
          'C.STATUS_VENDA = ' + QuotedStr('P') + ' and D.ID_ECF_PRODUTO=P.ID';

        ListaVenda := TObjectList<TVendaDetalheVO>.Create;

        Query.sql.Text := ConsultaSQL;
        Query.Open;
        Query.First;
        while not Query.Eof do
        begin
          VendaDetalhe := TVendaDetalheVO.Create;
          VendaDetalhe.Id := Query.FieldByName('DID').AsInteger;
          VendaDetalhe.IdVendaCabecalho := Query.FieldByName('CID').AsInteger;
          VendaDetalhe.CFOP := Query.FieldByName('CFOP').AsInteger;
          VendaDetalhe.IdProduto := Query.FieldByName('ID_ECF_PRODUTO').AsInteger;
          VendaDetalhe.Quantidade := Query.FieldByName('QUANTIDADE').AsInteger;
          VendaDetalhe.ValorUnitario := Query.FieldByName('VALOR_UNITARIO').AsFloat;
          VendaDetalhe.ValorTotal := Query.FieldByName('VALOR_TOTAL').AsFloat;
          VendaDetalhe.GTIN := Query.FieldByName('GTIN').AsString;
          VendaDetalhe.IdentificacaoCliente := Query.FieldByName('CPF_CNPJ_CLIENTE').AsString;
          ListaVenda.Add(VendaDetalhe);
          Query.next;
        end;

        //cancela o cupom fiscal da venda anterior
        CancelaVendaAnterior;

        //retorna a lista populada para ser carregada como uma nova venda
        result := ListaVenda;
      end
      //caso não existe uma venda com problemas, retorna um ponteiro nulo
      else
        result := nil;
    except
      result := nil;
    end;
  finally
  end;
end;

class procedure TVendaController.CancelaVenda(pVendaCabecalho: TVendaCabecalhoVO; pListaVendaDetalhe: TObjectList<TVendaDetalheVO>);
var
  Tripa, Hash: String;
  i: integer;
  VendaDetalhe: TVendaDetalheVO;
begin
  ConsultaSQL :=
    'update ECF_VENDA_CABECALHO set ' +
    'STATUS_VENDA=:pStatus, '+
    'VALOR_VENDA=:pValorVenda, '+
    'VALOR_FINAL=:pValorFinal, '+
    'HASH_TRIPA=:pHash, '+
    'CUPOM_CANCELADO=:pCupomFoiCancelado, '+
    'VALOR_CANCELADO=:pValorCancelado '+
    ' where ID = :pId';

    //zera o valor final
    pVendaCabecalho.ValorFinal := 0;

  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;

      //calcula e grava o hash
      Tripa := IntToStr(pVendaCabecalho.Id) +
               IntToStr(pVendaCabecalho.CCF) +
               IntToStr(pVendaCabecalho.COO) +
               FormataFloat('V',pVendaCabecalho.ValorFinal) + 'C';
      Hash := MD5String(Tripa);

      Query.ParamByName('pHash').AsString := Hash;

      Query.ParamByName('pId').AsInteger := pVendaCabecalho.Id;
      Query.ParamByName('pValorCancelado').AsFloat := pVendaCabecalho.ValorVenda;
      Query.ParamByName('pValorVenda').AsFloat := pVendaCabecalho.ValorVenda;
      Query.ParamByName('pStatus').AsString := 'C';
      Query.ParamByName('pCupomFoiCancelado').AsString := 'S';
      Query.ParamByName('pValorFinal').AsFloat := pVendaCabecalho.ValorFinal;

      Query.ExecSQL();

      //cancela os itens da venda
      for i := 0 to pListaVendaDetalhe.Count - 1 do
      begin
        VendaDetalhe := pListaVendaDetalhe.Items[i];
        Query.sql.Text :=
          'update ECF_VENDA_DETALHE set ' +
          'CANCELADO=' + QuotedStr('S') + ',' +
          'TOTALIZADOR_PARCIAL=' + QuotedStr('Can-T') + ',' +
          'HASH_TRIPA=:pHash '+
          ' where ID = :pId';

        //calcula e grava o hash
        Tripa := VendaDetalhe.GTIN +
                 FormataFloat('Q',VendaDetalhe.Quantidade) +
                 FormataFloat('V',VendaDetalhe.ValorUnitario) +
                 FormataFloat('V',VendaDetalhe.TotalItem) +
                 VendaDetalhe.TotalizadorParcial + 'S';
        Hash := MD5String(Tripa);

        Query.ParamByName('pHash').AsString := Hash;
        Query.ParamByName('pId').AsInteger := VendaDetalhe.Id;

        Query.ExecSQL();
      end;

      //estorna os pagamentos realizados
      Query.sql.Text :=
        'update ECF_TOTAL_TIPO_PGTO set ' +
        'ESTORNO=' + QuotedStr('S') +
        ' where ID_ECF_VENDA_CABECALHO = ' +  IntToStr(pVendaCabecalho.Id);
      Query.ExecSQL();
    except
    end;
  finally
    Query.Free;
  end;
end;

class procedure TVendaController.CancelaItem(pVendaDetalhe: TVendaDetalheVO);
var
  Tripa, Hash: String;
begin
  ConsultaSQL :=
    'update ECF_VENDA_DETALHE set ' +
    'CANCELADO=' + QuotedStr('S') + ',' +
    'TOTALIZADOR_PARCIAL=' + QuotedStr('Can-T') + ',' +
    'HASH_TRIPA=:pHash '+
    ' where ID = :pId';

  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;

      //calcula e grava o hash
      Tripa := pVendaDetalhe.GTIN +
               FormataFloat('Q',pVendaDetalhe.Quantidade) +
               FormataFloat('V',pVendaDetalhe.ValorUnitario) +
               FormataFloat('V',pVendaDetalhe.TotalItem) +
               pVendaDetalhe.TotalizadorParcial + 'S';
      Hash := MD5String(Tripa);

      Query.ParamByName('pHash').AsString := Hash;
      Query.ParamByName('pId').AsInteger := pVendaDetalhe.Id;
      Query.ExecSQL();
    except
    end;
  finally
    Query.Free;
  end;
end;

class function TVendaController.CancelaVendaAnterior: Boolean;
var
  Tripa, Hash: String;
  i: integer;
  VendaCabecalho: TVendaCabecalhoVO;
  QueryVendaDetalhe: TSQLQuery;
begin
  //primeiro pegamos o último ID e verificamos se o status da venda é "F" ou "P"
  ConsultaSQL := 'select ' +
                'ID, CCF, COO, VALOR_FINAL, STATUS_VENDA '+
                'from ECF_VENDA_CABECALHO ' +
                'where ID = (select MAX(ID) from ECF_VENDA_CABECALHO)';

  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.open();

      if (Query.FieldByName('STATUS_VENDA').AsString = 'F') or (Query.FieldByName('STATUS_VENDA').AsString = 'P') then
      begin

        if CupomJaFoiCancelado = False then
          UEcf.CancelaCupom;

        VendaCabecalho := TVendaCabecalhoVO.Create;
        VendaCabecalho.Id := Query.FieldByName('ID').AsInteger;
        VendaCabecalho.CCF := Query.FieldByName('CCF').AsInteger;
        VendaCabecalho.COO := Query.FieldByName('COO').AsInteger;
        VendaCabecalho.ValorFinal := Query.FieldByName('VALOR_FINAL').AsFloat;
        VendaCabecalho.StatusVenda := 'C';

        ConsultaSQL :=
          'update ECF_VENDA_CABECALHO set ' +
          'STATUS_VENDA=:pStatus, '+
          'CUPOM_CANCELADO=:pCupomFoiCancelado, '+
          'HASH_TRIPA=:pHash '+
          ' where ID = :pId';

        Query.sql.Text := ConsultaSQL;

        //calcula e grava o hash
        Tripa := IntToStr(VendaCabecalho.Id) +
                 IntToStr(VendaCabecalho.CCF) +
                 IntToStr(VendaCabecalho.COO) +
                 FormataFloat('V',VendaCabecalho.ValorFinal) +
                 VendaCabecalho.StatusVenda;
        Hash := MD5String(Tripa);

        Query.ParamByName('pHash').AsString := Hash;
        Query.ParamByName('pId').AsInteger := VendaCabecalho.Id;
        Query.ParamByName('pStatus').AsString := VendaCabecalho.StatusVenda;
        Query.ParamByName('pCupomFoiCancelado').AsString := 'S';

        Query.ExecSQL();

        //popula os itens da venda
        ConsultaSQL := 'select ' +
          'P.GTIN, VD.ID, VD.QUANTIDADE, VD.VALOR_UNITARIO, VD.TOTAL_ITEM, VD.TOTALIZADOR_PARCIAL '+
          'from ECF_VENDA_DETALHE VD, PRODUTO P ' +
          'where P.ID = VD.ID_ECF_PRODUTO ' +
          'and VD.ID_ECF_VENDA_CABECALHO = ' + IntToStr(VendaCabecalho.Id);

        QueryVendaDetalhe := TSQLQuery.Create(nil);
        QueryVendaDetalhe.SQLConnection := FDataModule.Conexao;
        QueryVendaDetalhe.sql.Text := ConsultaSQL;

        QueryVendaDetalhe.open();
        QueryVendaDetalhe.First;

        //cancela os itens da venda
        while not QueryVendaDetalhe.Eof do
        begin
          Query.sql.Text :=
            'update ECF_VENDA_DETALHE set ' +
            'CANCELADO=' + QuotedStr('S') + ',' +
            'TOTALIZADOR_PARCIAL=' + QuotedStr('Can-T') + ',' +
            'HASH_TRIPA=:pHash '+
            ' where ID = :pId';

          //calcula e grava o hash
          Tripa := QueryVendaDetalhe.FieldByName('GTIN').AsString +
                   QueryVendaDetalhe.FieldByName('QUANTIDADE').AsString +
                   QueryVendaDetalhe.FieldByName('VALOR_UNITARIO').AsString +
                   QueryVendaDetalhe.FieldByName('TOTAL_ITEM').AsString +
                   QueryVendaDetalhe.FieldByName('TOTALIZADOR_PARCIAL').AsString + 'S';
          Hash := MD5String(Tripa);

          Query.ParamByName('pHash').AsString := Hash;
          Query.ParamByName('pId').AsInteger := QueryVendaDetalhe.FieldByName('ID').AsInteger;

          Query.ExecSQL();
          QueryVendaDetalhe.Next;
        end;

        //estorna os pagamentos realizados
        Query.sql.Text :=
          'update ECF_TOTAL_TIPO_PGTO set ' +
          'ESTORNO=' + QuotedStr('S') +
          ' where ID_ECF_VENDA_CABECALHO = ' +  IntToStr(VendaCabecalho.Id);
        Query.ExecSQL();

        Result := True;
      end
      else
        Result := False;
    except
      Result := False;
    end;
  finally
     Query.Free;
  end;
end;

class function TVendaController.CupomJaFoiCancelado: Boolean;
var
  QueryLocal: TSQLQuery;
begin
  //verifica se o cupom referente a ultima venda já foi cancelado
  ConsultaSQL := 'select CUPOM_CANCELADO '+
                'from ECF_VENDA_CABECALHO ' +
                'where ID = (select MAX(ID) from ECF_VENDA_CABECALHO)';
  try
    try
      QueryLocal := TSQLQuery.Create(nil);
      QueryLocal.SQLConnection := FDataModule.Conexao;
      QueryLocal.sql.Text := ConsultaSQL;
      QueryLocal.open();

      if QueryLocal.FieldByName('CUPOM_CANCELADO').AsString = 'S' then
        Result := True
      else
        Result := False;

    except
      Result := False;
    end;
  finally
    QueryLocal.Free;
  end;
end;

end.
