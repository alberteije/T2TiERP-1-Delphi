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
  DB, PreVendaController, DAVController, Biblioteca, Constantes, Dialogs;

type
  TVendaController = class
  protected
  public
    class function IniciaVenda(pVendaCabecalho: TVendaCabecalhoVO): TVendaCabecalhoVO;
    class function InserirItem(pVendaDetalhe: TVendaDetalheVO): TVendaDetalheVO;
    class Procedure EncerraVenda(pVendaCabecalho: TVendaCabecalhoVO);
    class function VendaAberta: TObjectList<TVendaDetalheVO>; overload;
    class function VendaAberta(p: String): Boolean; overload;
    class function VendaComProblemas: TObjectList<TVendaDetalheVO>;
    class Procedure CancelaVenda(pVendaCabecalho: TVendaCabecalhoVO; pListaVendaDetalhe: TObjectList<TVendaDetalheVO>);
    class Procedure CancelaItem(pVendaDetalhe: TVendaDetalheVO);
    class function CupomJaFoiCancelado: Boolean;
    class function CancelaVendaAnterior: Boolean;
    class function CalculaImpostos(pVendaCabecalho: TVendaCabecalhoVO): TVendaCabecalhoVO;
    class procedure AtualizaItens(pListaVendaDetalhe: TObjectList<TVendaDetalheVO>);
    class function RetornaCabecalhoDaUltimaVenda:TVendaCabecalhoVO;
    class function RetornaDetalheDaUltimaVenda(IdCabecalho:integer): TObjectList<TVendaDetalheVO>;
    class procedure AlteraClienteNaVenda(IdVenda, IdCliente: Integer; CpfCnpj, NomeCliente: String);
  end;

implementation

uses UDataModule, UEcf, ImpressoraVO, ImpressoraController, UCaixa;

var
  ConsultaSQL: String;
  Query: TSQLQuery;
  Impressora: TImpressoraVO;

class function TVendaController.IniciaVenda(pVendaCabecalho: TVendaCabecalhoVO) : TVendaCabecalhoVO;
begin
  ConsultaSQL :=
    'insert into ECF_VENDA_CABECALHO (' +
    ' STATUS_VENDA,' +
    ' ID_ECF_MOVIMENTO,' +
    ' ID_ECF_PRE_VENDA_CABECALHO,' +
    ' SERIE_ECF,' +
    ' CFOP,' +
    ' COO,' +
    ' CCF,' +
    ' ID_CLIENTE,' +
    ' NOME_CLIENTE,' +
    ' CPF_CNPJ_CLIENTE,' +
    ' DATA_VENDA,' +
    ' HORA_VENDA) values (' +
    ' :pStatus,' +
    ' :pMovimento,' +
    ' :pIdPreVenda,' +
    ' :pSerieEcf,' +
    ' :pCFOP,' +
    ' :pCOO,' +
    ' :pCCF,' +
    ' :pIdCliente,' +
    ' :pNomeCliente,' +
    ' :pCPFouCNPJCliente,' +
    ' :pDataVenda,' +
    ' :pHoraVenda)';

  try
    try
      Impressora := TImpressoraController.PegaImpressora(UCaixa.Configuracao.IdImpressora);

      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.ParamByName('pStatus').AsString := pVendaCabecalho.StatusVenda;
      Query.ParamByName('pMovimento').AsInteger := pVendaCabecalho.IdMovimento;
      Query.ParamByName('pSerieEcf').AsString := Impressora.Serie;
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

      if pVendaCabecalho.IdPreVenda <> 0 then
        Query.ParamByName('pIdPreVenda').AsInteger := pVendaCabecalho.IdPreVenda
      else
      begin
        Query.ParamByName('pIdPreVenda').DataType := ftInteger;
        Query.ParamByName('pIdPreVenda').Clear;
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

class function TVendaController.InserirItem(pVendaDetalhe: TVendaDetalheVO): TVendaDetalheVO;
var
  Tripa, Hash: String;
  Ccf, Coo: Integer;
begin
  ConsultaSQL :=
    'insert into ECF_VENDA_DETALHE (' +
    ' CFOP,' +
    ' ID_ECF_PRODUTO,' +
    ' ID_ECF_VENDA_CABECALHO,' +
    ' SERIE_ECF,' +
    ' GTIN,' +
    ' CCF,' +
    ' COO,' +
    ' ITEM,' +
    ' QUANTIDADE,' +
    ' VALOR_UNITARIO,' +
    ' VALOR_TOTAL,' +
    ' TOTAL_ITEM,' +
    ' TOTALIZADOR_PARCIAL,' +
    ' ECF_ICMS_ST,' +
    ' CST,' +
    ' HASH_TRIPA,' +
    ' CANCELADO,' +
    ' TAXA_ICMS,' +
    ' TAXA_ISSQN,' +
    ' MOVIMENTA_ESTOQUE) values (' +
    ' :pCFOP,' +
    ' :pIdProduto,' +
    ' :pIdVendaCabecalho,' +
    ' :pSerieEcf,' +
    ' :pGtin,' +
    ' :pCcf,' +
    ' :pCoo,' +
    ' :pItem,' +
    ' :pQuantidade,' +
    ' :pValorUnitario,' +
    ' :pValorTotal,' +
    ' :pTotalItem,' +
    ' :pTotalizadorParcial,' +
    ' :pECFIcmsST,' +
    ' :pCST,' +
    ' :pHash,' +
    ' :pCancelado,' +
    ' :pTaxaICMS,' +
    ' :pTaxaISSQN,' +
    ' :pMovimentaEstoque)';

  try
    try
      Ccf := StrToIntDef(FDataModule.ACBrECF.NumCCF,0);
      Coo := StrToInt(FDataModule.ACBrECF.NumCOO);

      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;

      Impressora := TImpressoraController.PegaImpressora(UCaixa.Configuracao.IdImpressora);
      //calcula e grava o hash
      Tripa :=
               Impressora.Serie +
               IntToStr(Coo) +
               IntToStr(Ccf) +
               pVendaDetalhe.GTIN +
               FormataFloat('Q',pVendaDetalhe.Quantidade) +
               FormataFloat('V',pVendaDetalhe.ValorUnitario) +
               FormataFloat('V',pVendaDetalhe.TotalItem) +
               pVendaDetalhe.TotalizadorParcial +
               'N' +
               '0';
      Hash := MD5String(Tripa);

      Query.ParamByName('pHash').AsString := Hash;
      Query.ParamByName('pCFOP').AsInteger := pVendaDetalhe.CFOP;
      Query.ParamByName('pIdProduto').AsInteger := pVendaDetalhe.IdProduto;
      Query.ParamByName('pIdVendaCabecalho').AsInteger := pVendaDetalhe.IdVendaCabecalho;
      Query.ParamByName('pSerieEcf').AsString := Impressora.Serie;
      Query.ParamByName('pGtin').AsString := pVendaDetalhe.GTIN;
      Query.ParamByName('pCcf').AsInteger := Ccf;
      Query.ParamByName('pCoo').AsInteger := Coo;
      Query.ParamByName('pItem').AsInteger := pVendaDetalhe.Item;
      Query.ParamByName('pQuantidade').AsFloat := pVendaDetalhe.Quantidade;
      Query.ParamByName('pValorUnitario').AsFloat := pVendaDetalhe.ValorUnitario;
      Query.ParamByName('pValorTotal').AsFloat := pVendaDetalhe.ValorTotal;
      Query.ParamByName('pTotalItem').AsFloat := pVendaDetalhe.ValorTotal;
      Query.ParamByName('pTotalizadorParcial').AsString := pVendaDetalhe.TotalizadorParcial;

      if pVendaDetalhe.ECFICMS = 'NN' then
        Query.ParamByName('pECFIcmsST').AsString := 'N'
      else if pVendaDetalhe.ECFICMS = 'FF' then
        Query.ParamByName('pECFIcmsST').AsString := 'F'
      else if pVendaDetalhe.ECFICMS = 'II' then
        Query.ParamByName('pECFIcmsST').AsString := 'I'
      else
      begin
        if copy(pVendaDetalhe.TotalizadorParcial,3,1) = 'S' then
           Query.ParamByName('pECFIcmsST').AsString := copy(pVendaDetalhe.TotalizadorParcial,4,4)
        else
        if copy(pVendaDetalhe.TotalizadorParcial,3,1) = 'T' then
           Query.ParamByName('pECFIcmsST').AsString := copy(pVendaDetalhe.TotalizadorParcial,4,4)
        else
        if pVendaDetalhe.TotalizadorParcial = 'Can-T' then
           Query.ParamByName('pECFIcmsST').AsString := 'CANC'
        else
           begin
              Query.ParamByName('pECFIcmsST').AsString := '1700';
           end;
      end;
      //ALTERADO POR SAIXEM******
      Query.ParamByName('pTaxaISSQN').AsFloat := pVendaDetalhe.TaxaISSQN;
      //FIM***********************
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
    //alterado saixem
    'ISSQN=:pISSQN, '+
    //fim************
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
    'HASH_INCREMENTO=:pHashIncremento, '+
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
      //alterado saixem
      Query.ParamByName('pISSQN').AsFloat := pVendaCabecalho.ISSQN;
      //fim*************
      Impressora := TImpressoraController.PegaImpressora(UCaixa.Configuracao.IdImpressora);
      //calcula e grava o hash
      Tripa := IntToStr(pVendaCabecalho.Id) +
               IntToStr(pVendaCabecalho.CCF) +
               IntToStr(pVendaCabecalho.COO) +
               FormataFloat('V',pVendaCabecalho.ValorFinal) +
               Impressora.Serie +
               pVendaCabecalho.StatusVenda +
               pVendaCabecalho.CupomFoiCancelado +
               '0';
      Hash := MD5String(Tripa);

      Query.ParamByName('pHash').AsString := Hash;
      Query.ParamByName('pHashIncremento').AsInteger := -1;

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
  i: Integer;
  BaseICMSCabecalho, OutrasICMSCabecalho, ICMSCabecalho, ISSCabecalho: Extended;
  DescontoRateio, AcrescimoRateio, ResiduoDesconto, ResiduoAcrescimo: Extended;
begin
  BaseICMSCabecalho := 0;
  OutrasICMSCabecalho := 0;
  ICMSCabecalho := 0;
  //alterado saixem
  ISSCabecalho := 0;
  //fim************
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
        ' and CANCELADO = ' + QuotedStr('N') +
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
        //ALTERADO SAIXEM****
        VendaDetalhe.TaxaISSQN := Query.FieldByName('TAXA_ISSQN').AsFloat;
        //FIM********************
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
        //alterado saixem*************
        VendaDetalhe.ISSQN := TruncaValor(VendaDetalhe.BaseICMS * VendaDetalhe.TaxaISSQN / 100, Constantes.TConstantes.DECIMAIS_VALOR);
        //fim*************************
        if (VendaDetalhe.TotalizadorParcial = 'N1') or (VendaDetalhe.TotalizadorParcial = 'F1') then
          OutrasICMSCabecalho := OutrasICMSCabecalho + VendaDetalhe.ValorTotal
        else
          BaseICMSCabecalho := BaseICMSCabecalho + VendaDetalhe.ValorTotal;
        ICMSCabecalho := ICMSCabecalho + VendaDetalhe.ICMS;
        //alterado saixem
        ISSCabecalho := ISSCabecalho + VendaDetalhe.ISSQN;
        //fim**************
      end;

      //armazena as informacoes de impostos de cabecalho para retornar para o metodo que fecha a venda
      pVendaCabecalho.BaseICMS := BaseICMSCabecalho;
      pVendaCabecalho.ICMSOutras := OutrasICMSCabecalho;
      pVendaCabecalho.ICMS := ICMSCabecalho;
      //ALTERADO SAIXEM
      pVendaCabecalho.ISSQN := ISSCabecalho;
      //FIM*************
      //armazena os possiveis residuos para gravar no item do grupo de aliquota que tem o maior valor na venda
      ResiduoDesconto := pVendaCabecalho.Desconto - DescontoRateio;
      ResiduoAcrescimo := pVendaCabecalho.Acrescimo - AcrescimoRateio;

      //se houver residuo no desconto/acrescimo, deve-se armazenar o mesmo
      if (ResiduoDesconto > 0) or (ResiduoAcrescimo > 0) then
      begin
        //essa consulta vai trazer apenas um registro contendo o totalizador parcial
        //cujo valor é o maior nessa venda

        Query := TSQLQuery.Create(nil);
        Query.SQLConnection := FDataModule.Conexao;

        if FDataModule.Conexao.DriverName = 'Firebird' then
        begin
          ConsultaSQL := 'select FIRST 1 SKIP 0 TOTALIZADOR_PARCIAL,sum(VALOR_TOTAL) as TOTAL ' +
          ' from ECF_VENDA_DETALHE where ID_ECF_VENDA_CABECALHO=' + IntToStr(pVendaCabecalho.Id) +
          ' group by TOTALIZADOR_PARCIAL ' +
          ' order by TOTAL desc ' ;
        end else
        if FDataModule.Conexao.DriverName = 'MySQL' then
        begin
          ConsultaSQL := 'select TOTALIZADOR_PARCIAL,sum(VALOR_TOTAL) as TOTAL ' +
          ' from ECF_VENDA_DETALHE where ID_ECF_VENDA_CABECALHO=' + IntToStr(pVendaCabecalho.Id) +
          ' group by TOTALIZADOR_PARCIAL ' +
          ' order by TOTAL desc ' +
          ' limit 1';
        end;

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
    if Assigned(ListaVendaDetalhe) then
       FreeAndNil(ListaVendaDetalhe);
    Query.Free;
  end;
end;

class procedure TVendaController.AtualizaItens(pListaVendaDetalhe: TObjectList<TVendaDetalheVO>);
var
  Tripa, Hash: String;
  i: integer;
  VendaDetalhe: TVendaDetalheVO;
  Query : TSQLQuery;
  Ccf, Coo: Integer;
begin
  try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
    try
      Ccf := StrToIntDef(FDataModule.ACBrECF.NumCCF,0);
      Coo := StrToInt(FDataModule.ACBrECF.NumCOO);

      for i := 0 to pListaVendaDetalhe.Count - 1 do
      begin
        VendaDetalhe := pListaVendaDetalhe.Items[i];
        Query.sql.Text :=
          'update ECF_VENDA_DETALHE set ' +
          'BASE_ICMS = :pBaseIcms,' +
          'ICMS = :pIcms,' +
          //alterado saixem
          'ISSQN = :pIss,' +
          //fim************
          'DESCONTO_RATEIO = :pDescontoRateio,' +
          'ACRESCIMO_RATEIO = :pAcrescimoRateio,' +
          'HASH_INCREMENTO = :pHashIncremento '+
          ' where ID = :pId';

        Query.ParamByName('pHashIncremento').AsInteger := -1;
        Query.ParamByName('pId').AsInteger := VendaDetalhe.Id;
        Query.ParamByName('pBaseIcms').AsFloat := VendaDetalhe.BaseICMS;
        Query.ParamByName('pIcms').AsFloat := VendaDetalhe.ICMS;
        //alterado saixem*****
        Query.ParamByName('pIss').AsFloat := VendaDetalhe.ISSQN;
        //fim*****************
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
          ' C.ID as CID, ' +
          ' C.STATUS_VENDA, ' +
          ' C.CPF_CNPJ_CLIENTE, '+
          ' D.ID as DID, ' +
          ' D.ID_ECF_PRODUTO, '+
          ' D.QUANTIDADE, ' +
          ' D.VALOR_UNITARIO, ' +
          ' D.VALOR_TOTAL, ' +
          ' D.CFOP, ' +
          ' P.GTIN, ' +
          ' P.ID ' +
          'from ' +
          ' ECF_VENDA_CABECALHO C LEFT JOIN ECF_VENDA_DETALHE D ON C.ID=D.ID_ECF_VENDA_CABECALHO, PRODUTO P ' +
          'where ' +
          ' C.STATUS_VENDA = ' + QuotedStr('A') + ' and D.CANCELADO = ' + QuotedStr('N') + ' and D.ID_ECF_PRODUTO=P.ID';

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
            'update ECF_VENDA_CABECALHO set HASH_INCREMENTO=-1, STATUS_VENDA='+QuotedStr('C') +
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
          ' C.ID as CID, ' +
          ' C.STATUS_VENDA, ' +
          ' C.CPF_CNPJ_CLIENTE, '+
          ' D.ID as DID, ' +
          ' D.ID_ECF_PRODUTO, '+
          ' D.QUANTIDADE, ' +
          ' D.VALOR_UNITARIO, ' +
          ' D.VALOR_TOTAL, ' +
          ' D.CFOP, ' +
          ' P.GTIN, ' +
          ' P.ID ' +
          'from ' +
          ' ECF_VENDA_CABECALHO C LEFT JOIN ECF_VENDA_DETALHE D ON C.ID=D.ID_ECF_VENDA_CABECALHO, PRODUTO P ' +
          'where ' +
          ' C.STATUS_VENDA = ' + QuotedStr('P') + ' and D.ID_ECF_PRODUTO=P.ID';

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
  Ccf, Coo: Integer;
begin
  ConsultaSQL :=
    'update ECF_VENDA_CABECALHO set ' +
    'STATUS_VENDA=:pStatus, '+
    'VALOR_VENDA=:pValorVenda, '+
    'VALOR_FINAL=:pValorFinal, '+
    'HASH_TRIPA=:pHash, '+
    'HASH_INCREMENTO=:pHashIncremento, '+
    'CUPOM_CANCELADO=:pCupomFoiCancelado, '+
    'VALOR_CANCELADO=:pValorCancelado '+
    ' where ID = :pId';

    //zera o valor final
    pVendaCabecalho.ValorFinal := 0;

  try
    try
      Ccf := StrToIntDef(FDataModule.ACBrECF.NumCCF,0);
      Coo := StrToInt(FDataModule.ACBrECF.NumCOO);

      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;

      Impressora := TImpressoraController.PegaImpressora(UCaixa.Configuracao.IdImpressora);
      //calcula e grava o hash
      Tripa := IntToStr(pVendaCabecalho.Id) +
               IntToStr(pVendaCabecalho.CCF) +
               IntToStr(pVendaCabecalho.COO) +
               FormataFloat('V',pVendaCabecalho.ValorFinal) +
               Impressora.Serie +
               'C' +
               'S' +
               '0';

      Hash := MD5String(Tripa);

      Query.ParamByName('pHash').AsString := Hash;
      Query.ParamByName('pHashIncremento').AsInteger := -1;
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
        VendaDetalhe.TotalizadorParcial := 'Can-T';
        VendaDetalhe.Cancelado := 'S';

        Query.sql.Text :=
          'update ECF_VENDA_DETALHE set ' +
          'CANCELADO=:pCancelado, ' +
          'TOTALIZADOR_PARCIAL=:pTotalizadorParcial, '+
          'CCF=:pCCF, '+
          'COO=:pCOO, '+
          'HASH_TRIPA=:pHash, '+
          'HASH_INCREMENTO=:pHashIncremento '+
          ' where ID = :pId';

        Impressora := TImpressoraController.PegaImpressora(UCaixa.Configuracao.IdImpressora);
        //calcula e grava o hash
        Tripa :=
                 Impressora.Serie +
                 IntToStr(Coo) +
                 IntToStr(Ccf) +
                 VendaDetalhe.GTIN +
                 FormataFloat('Q',VendaDetalhe.Quantidade) +
                 FormataFloat('V',VendaDetalhe.ValorUnitario) +
                 FormataFloat('V',VendaDetalhe.TotalItem) +
                 VendaDetalhe.TotalizadorParcial +
                 VendaDetalhe.Cancelado +
                 '0';
        Hash := MD5String(Tripa);

        Query.ParamByName('pCancelado').AsString := VendaDetalhe.Cancelado;
        Query.ParamByName('pTotalizadorParcial').AsString := VendaDetalhe.TotalizadorParcial;
        Query.ParamByName('pCCF').AsInteger := Ccf;
        Query.ParamByName('pCOO').AsInteger := Coo;
        Query.ParamByName('pHash').AsString := Hash;
        Query.ParamByName('pHashIncremento').AsInteger := -1;
        Query.ParamByName('pId').AsInteger := VendaDetalhe.Id;

        Query.ExecSQL();
      end;

      //estorna os pagamentos realizados
      Query.sql.Text :=
        'update ECF_TOTAL_TIPO_PGTO set ' +
        'ESTORNO=' + QuotedStr('S') +
        ', HASH_INCREMENTO=:pHashIncremento' +
        ' where ID_ECF_VENDA_CABECALHO = ' +  IntToStr(pVendaCabecalho.Id);
      Query.ParamByName('pHashIncremento').AsInteger := -1;
      Query.ExecSQL();
    except
    end;
  finally
//    if Assigned(VendaDetalhe) then
//      FreeAndNil(VendaDetalhe);
    Query.Free;
  end;
end;

class procedure TVendaController.CancelaItem(pVendaDetalhe: TVendaDetalheVO);
var
  Tripa, Hash: String;
  Ccf, Coo: Integer;
begin
  pVendaDetalhe.TotalizadorParcial := 'Can-T';
  pVendaDetalhe.Cancelado := 'S';

  ConsultaSQL :=
    'update ECF_VENDA_DETALHE set ' +
    'CANCELADO=:pCancelado, ' +
    'TOTALIZADOR_PARCIAL=:pTotalizadorParcial, ' +
    'CCF=:pCCF, '+
    'COO=:pCOO, '+
    'HASH_TRIPA=:pHash, '+
    'HASH_INCREMENTO=:pHashIncremento '+
    ' where ID = :pId';

  try
    try
      Ccf := StrToIntDef(FDataModule.ACBrECF.NumCCF,0);
      Coo := StrToInt(FDataModule.ACBrECF.NumCOO);

      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;

      Impressora := TImpressoraController.PegaImpressora(UCaixa.Configuracao.IdImpressora);
      //calcula e grava o hash

      Tripa :=
               Impressora.Serie +
               IntToStr(Coo) +
               IntToStr(Ccf) +
               pVendaDetalhe.GTIN +
               FormataFloat('Q',pVendaDetalhe.Quantidade) +
               FormataFloat('V',pVendaDetalhe.ValorUnitario) +
               FormataFloat('V',pVendaDetalhe.TotalItem) +
               pVendaDetalhe.TotalizadorParcial +
               pVendaDetalhe.Cancelado +
               '0';
      Hash := MD5String(Tripa);

      Query.ParamByName('pCancelado').AsString := pVendaDetalhe.Cancelado;
      Query.ParamByName('pTotalizadorParcial').AsString := pVendaDetalhe.TotalizadorParcial;
      Query.ParamByName('pCCF').AsInteger := Ccf;
      Query.ParamByName('pCOO').AsInteger := Coo;
      Query.ParamByName('pHash').AsString := Hash;
      Query.ParamByName('pHashIncremento').AsInteger := -1;
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
  VendaCabecalho: TVendaCabecalhoVO;
  QueryVendaDetalhe: TSQLQuery;
  Ccf, Coo: Integer;
begin
  //primeiro pegamos o último ID e verificamos se o status da venda é "F" ou "P"
  ConsultaSQL := 'select ' +
                'ID, CCF, COO, VALOR_FINAL, STATUS_VENDA '+
                'from ECF_VENDA_CABECALHO ' +
                'where ID = (select MAX(ID) from ECF_VENDA_CABECALHO)';

  try
    try
      Ccf := StrToIntDef(FDataModule.ACBrECF.NumCCF,0);
      Coo := StrToInt(FDataModule.ACBrECF.NumCOO);

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
          'HASH_TRIPA=:pHash, '+
          'HASH_INCREMENTO=:pHashIncremento '+
          ' where ID = :pId';

        Query.sql.Text := ConsultaSQL;

        Impressora := TImpressoraController.PegaImpressora(UCaixa.Configuracao.IdImpressora);
        //calcula e grava o hash
        Tripa := IntToStr(VendaCabecalho.Id) +
                 IntToStr(VendaCabecalho.CCF) +
                 IntToStr(VendaCabecalho.COO) +
                 FormataFloat('V',VendaCabecalho.ValorFinal) +
                 Impressora.Serie +
                 VendaCabecalho.StatusVenda +
                 'S' +
                 '0';
        Hash := MD5String(Tripa);

        Query.ParamByName('pHash').AsString := Hash;
        Query.ParamByName('pHashIncremento').AsInteger := -1;
        Query.ParamByName('pId').AsInteger := VendaCabecalho.Id;
        Query.ParamByName('pStatus').AsString := VendaCabecalho.StatusVenda;
        Query.ParamByName('pCupomFoiCancelado').AsString := 'S';

        Query.ExecSQL();

        //popula os itens da venda
        ConsultaSQL := 'select '+
                       ' P.GTIN, '+
                       ' VD.ID, '+
                       ' VD.CCF, '+
                       ' VD.COO, '+
                       ' VD.QUANTIDADE, '+
                       ' VD.VALOR_UNITARIO, '+
                       ' VD.TOTAL_ITEM, '+
                       ' VD.TOTALIZADOR_PARCIAL '+
                      'from '+
                      ' ECF_VENDA_DETALHE VD, PRODUTO P ' +
                      'where '+
                      ' P.ID = VD.ID_ECF_PRODUTO ' +
                      ' and VD.ID_ECF_VENDA_CABECALHO = ' + IntToStr(VendaCabecalho.Id);

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
            'CANCELADO=:pCancelado, '+
            'TOTALIZADOR_PARCIAL=:pTotalizadorParcial, ' +
            'CCF=:pCCF, '+
            'COO=:pCOO, '+
            'HASH_TRIPA=:pHash, '+
            'HASH_INCREMENTO=:pHashIncremento '+
            ' where ID = :pId';
          //calcula e grava o hash
          Tripa :=
                   Impressora.Serie +
                   IntToStr(Coo) +
                   IntToStr(Ccf) +
                   QueryVendaDetalhe.FieldByName('GTIN').AsString +
                   FormataFloat('Q',QueryVendaDetalhe.FieldByName('QUANTIDADE').AsFloat) +
                   FormataFloat('V',QueryVendaDetalhe.FieldByName('VALOR_UNITARIO').AsFloat) +
                   FormataFloat('V',QueryVendaDetalhe.FieldByName('TOTAL_ITEM').AsFloat) +
                   'Can-T' +
                   'S' +
                   '0';
          Hash := MD5String(Tripa);

          Query.ParamByName('pCancelado').AsString := 'S';
          Query.ParamByName('pTotalizadorParcial').AsString := 'Can-T';
          Query.ParamByName('pCCF').AsInteger := Ccf;
          Query.ParamByName('pCOO').AsInteger := Coo;
          Query.ParamByName('pHash').AsString := Hash;
          Query.ParamByName('pHashIncremento').AsInteger := -1;
          Query.ParamByName('pId').AsInteger := QueryVendaDetalhe.FieldByName('ID').AsInteger;

          Query.ExecSQL();
          QueryVendaDetalhe.Next;
        end;

        //estorna os pagamentos realizados
        Query.sql.Text :=
          'update ECF_TOTAL_TIPO_PGTO set ' +
          'ESTORNO=' + QuotedStr('S') +
          ', HASH_INCREMENTO=:pHashIncremento' +
          ' where ID_ECF_VENDA_CABECALHO = ' +  IntToStr(VendaCabecalho.Id);
        Query.ParamByName('pHashIncremento').AsInteger := -1;
        Query.ExecSQL();

        Result := True;
      end
      else
        Result := False;
    except
      Result := False;
    end;
  finally
    if Assigned(VendaCabecalho) then
     FreeAndNil(VendaCabecalho);
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

class function TVendaController.RetornaCabecalhoDaUltimaVenda: TVendaCabecalhoVO;
var
  VendaCabecalho: TVendaCabecalhoVO;
begin

  ConsultaSQL := 'SELECT * FROM ECF_VENDA_CABECALHO WHERE ID = (SELECT MAX(ID) FROM ECF_VENDA_CABECALHO)';

  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.open;

      VendaCabecalho := TVendaCabecalhoVO.Create;

      VendaCabecalho.id:= Query.FieldByName('ID').AsInteger;
      VendaCabecalho.IdCliente:= Query.FieldByName('ID_CLIENTE').AsInteger;
      VendaCabecalho.IdVendedor:= Query.FieldByName('ID_ECF_FUNCIONARIO').AsInteger;
      VendaCabecalho.IdMovimento:= Query.FieldByName('ID_ECF_MOVIMENTO').AsInteger;
      VendaCabecalho.IdDAV:= Query.FieldByName('ID_ECF_DAV').AsInteger;
      VendaCabecalho.IdPreVenda:= Query.FieldByName('ID_ECF_PRE_VENDA_CABECALHO').AsInteger;
      VendaCabecalho.CFOP:= Query.FieldByName('CFOP').AsInteger;
      VendaCabecalho.COO:= Query.FieldByName('COO').AsInteger;
      VendaCabecalho.CCF:= Query.FieldByName('CCF').AsInteger;
      VendaCabecalho.DataVenda:= DataParaTexto(Query.FieldByName('DATA_VENDA').AsDateTime);
      VendaCabecalho.HoraVenda:= Query.FieldByName('HORA_VENDA').AsString;
      VendaCabecalho.ValorVenda:= Query.FieldByName('VALOR_VENDA').AsFloat;
      VendaCabecalho.TaxaDesconto:= Query.FieldByName('TAXA_DESCONTO').AsFloat;
      VendaCabecalho.Desconto:= Query.FieldByName('DESCONTO').AsFloat;
      VendaCabecalho.TaxaAcrescimo:= Query.FieldByName('TAXA_ACRESCIMO').AsFloat;
      VendaCabecalho.Acrescimo:= Query.FieldByName('ACRESCIMO').AsFloat;
      VendaCabecalho.ValorFinal:= Query.FieldByName('VALOR_FINAL').AsFloat;
      VendaCabecalho.ValorRecebido:= Query.FieldByName('VALOR_RECEBIDO').AsFloat;
      VendaCabecalho.Troco:= Query.FieldByName('TROCO').AsFloat;
      VendaCabecalho.ValorCancelado:= Query.FieldByName('VALOR_CANCELADO').AsFloat;
      VendaCabecalho.Sincronizado:= Query.FieldByName('SINCRONIZADO').AsString;
      VendaCabecalho.TotalProdutos:= Query.FieldByName('TOTAL_PRODUTOS').AsFloat;
      VendaCabecalho.TotalDocumentos:= Query.FieldByName('TOTAL_DOCUMENTO').AsFloat;
      VendaCabecalho.BaseICMS:= Query.FieldByName('BASE_ICMS').AsFloat;
      VendaCabecalho.ICMS:= Query.FieldByName('ICMS').AsFloat;
      VendaCabecalho.ICMSOutras:= Query.FieldByName('ICMS_OUTRAS').AsFloat;
      VendaCabecalho.ISSQN:= Query.FieldByName('ISSQN').AsFloat;
      VendaCabecalho.PIS:= Query.FieldByName('PIS').AsFloat;
      VendaCabecalho.COFINS:= Query.FieldByName('COFINS').AsFloat;
      VendaCabecalho.AcrescimoItens:= Query.FieldByName('ACRESCIMO_ITENS').AsFloat;
      VendaCabecalho.DescontoItens:= Query.FieldByName('DESCONTO_ITENS').AsFloat;
      VendaCabecalho.StatusVenda:= Query.FieldByName('STATUS_VENDA').AsString;
      VendaCabecalho.NomeCliente:= Query.FieldByName('NOME_CLIENTE').AsString;
      VendaCabecalho.CPFouCNPJCliente:= Query.FieldByName('CPF_CNPJ_CLIENTE').AsString;
      VendaCabecalho.CupomFoiCancelado:= Query.FieldByName('CUPOM_CANCELADO').AsString;
      VendaCabecalho.HashTripa := Query.FieldByName('HASH_TRIPA').AsString;

      Result := VendaCabecalho;
    except
      Result := nil;
    end;
  finally
     Query.Free;
  end;
end;

class function TVendaController.RetornaDetalheDaUltimaVenda(IdCabecalho: integer): TObjectList<TVendaDetalheVO>;
var
  ListaVenda: TObjectList<TVendaDetalheVO>;
  VendaDetalhe: TVendaDetalheVO;
begin

  ConsultaSQL :=
    'select * from ECF_VENDA_DETALHE where ID_ECF_VENDA_CABECALHO = '+ IntToStr(IdCabecalho);

  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;

      ListaVenda := TObjectList<TVendaDetalheVO>.Create;
      Query.First;

      while not Query.Eof do
      begin
        VendaDetalhe := TVendaDetalheVO.Create;
        VendaDetalhe.Id := Query.FieldByName('ID').AsInteger;
        VendaDetalhe.IdProduto := Query.FieldByName('ID_ECF_PRODUTO').AsInteger;
        VendaDetalhe.IdVendaCabecalho := Query.FieldByName('ID_ECF_VENDA_CABECALHO').AsInteger;
        VendaDetalhe.Gtin := Query.FieldByName('GTIN').AsString;
        VendaDetalhe.CFOP := Query.FieldByName('CFOP').AsInteger;
        VendaDetalhe.Ccf := Query.FieldByName('CCF').AsInteger;
        VendaDetalhe.Coo := Query.FieldByName('COO').AsInteger;
        VendaDetalhe.Item := Query.FieldByName('ITEM').AsInteger;
        VendaDetalhe.Quantidade := Query.FieldByName('QUANTIDADE').AsFloat;
        VendaDetalhe.ValorUnitario := Query.FieldByName('VALOR_UNITARIO').AsFloat;
        VendaDetalhe.ValorTotal := Query.FieldByName('VALOR_TOTAL').AsFloat;
        VendaDetalhe.TotalItem := Query.FieldByName('TOTAL_ITEM').AsFloat;
        VendaDetalhe.BaseICMS := Query.FieldByName('BASE_ICMS').AsFloat;
        VendaDetalhe.TaxaICMS := Query.FieldByName('TAXA_ICMS').AsFloat;
        VendaDetalhe.ICMS := Query.FieldByName('ICMS').AsFloat;
        VendaDetalhe.TaxaDesconto := Query.FieldByName('TAXA_DESCONTO').AsFloat;
        VendaDetalhe.Desconto := Query.FieldByName('DESCONTO').AsFloat;
        VendaDetalhe.TaxaICMS := Query.FieldByName('TAXA_ISSQN').AsFloat;
        VendaDetalhe.ISSQN := Query.FieldByName('ISSQN').AsFloat;
        VendaDetalhe.TaxaPIS := Query.FieldByName('TAXA_PIS').AsFloat;
        VendaDetalhe.PIS := Query.FieldByName('PIS').AsFloat;
        VendaDetalhe.TaxaCOFINS := Query.FieldByName('TAXA_COFINS').AsFloat;
        VendaDetalhe.COFINS := Query.FieldByName('COFINS').AsFloat;
        VendaDetalhe.TaxaAcrescimo := Query.FieldByName('TAXA_ACRESCIMO').AsFloat;
        VendaDetalhe.Acrescimo := Query.FieldByName('ACRESCIMO').AsFloat;
        VendaDetalhe.AcrescimoRateio := Query.FieldByName('ACRESCIMO_RATEIO').AsFloat;
        VendaDetalhe.DescontoRateio := Query.FieldByName('DESCONTO_RATEIO').AsFloat;
        VendaDetalhe.TotalizadorParcial := Query.FieldByName('TOTALIZADOR_PARCIAL').AsString;
        VendaDetalhe.CST := Query.FieldByName('CST').AsString;
        VendaDetalhe.Cancelado := Query.FieldByName('CANCELADO').AsString;
        VendaDetalhe.MovimentaEstoque := Query.FieldByName('MOVIMENTA_ESTOQUE').AsString;
        VendaDetalhe.HashTripa := Query.FieldByName('HASH_TRIPA').AsString;

        ListaVenda.Add(VendaDetalhe);
        Query.next;
      end;
      result := ListaVenda;

    except

    end;
  finally
    Query.Free;
  end;
end;

class procedure TVendaController.AlteraClienteNaVenda(IdVenda, IdCliente: Integer; CpfCnpj, NomeCliente: String);
var
  Tripa, Hash: String;
begin

  ConsultaSQL :=
    'update ECF_VENDA_CABECALHO set ' +
    'ID_CLIENTE=:pIDCliente, '+
    'CPF_CNPJ_CLIENTE=:pcpf_cnpj, '+
    'NOME_CLIENTE=:pNomeCliente, '+
    'HASH_INCREMENTO=:pHashIncremento '+
    ' where ID = :pIDVenda';

  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.ParamByName('pIDVenda').AsInteger := IDVenda;
      Query.ParamByName('pIDCliente').AsInteger := IDCliente;
      Query.ParamByName('pcpf_cnpj').AsString := CpfCnpj;
      Query.ParamByName('pNomeCliente').AsString := NomeCliente;
      Query.ParamByName('pHashIncremento').AsInteger := -1;
      Query.ExecSQL();
    except
    end;
  finally
    Query.Free;
  end;
end;

end.
