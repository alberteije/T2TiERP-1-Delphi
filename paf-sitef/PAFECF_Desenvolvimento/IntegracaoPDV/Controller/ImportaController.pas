{*******************************************************************************
Title: T2Ti ERP
Description: Unit de controle da tabela CONTAS_PARCELAS

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

@author Albert Eije (T2Ti.COM)    | Jose Rodrigues de Oliveira Junior
@version 1.0
*******************************************************************************}
unit ImportaController;

interface
uses
  Classes, Dialogs, SysUtils, DBClient, DB, Windows, Forms,SQLExpr,
   Generics.Collections, Biblioteca, DBXCommon;
type
  TImportaController = class
  private

  protected
  public
    class function ImportaDadosDoPDV(pathlocal:string):boolean;
    class function ConsultaIntegracaoPDV(Identifica:string):boolean;
    class procedure GravaIntegracaoPDV(Identifica:string);
    class function BaixaEstoque(IdProduto:integer;Qtde:Extended):boolean;
    class procedure ProdutoComposto(IdProduto:integer;Qtde:Extended);
    class procedure GravaEcfVendaCabecalho;
    class procedure GravaEcfVendaDetalhe;
    class procedure GravaEcfTotalTipoPagamento;
    class procedure CancelaEcfVendaCabecalho;
    class procedure GravaContasPagarReceber;
    class procedure GravaContasParcelas;
    class procedure CancelaEcfVendaDetalhe;
    class procedure CancelaEcfTotalTipoPagamento;
    class procedure GravaEcfResolucao;
    class function ConsultaEcfResolucao(vCaixa, vEmpresa, vIDCaixa: String):integer;
    class procedure GravaEcfPosicaoComponentes;
    class function ConsultaEcfPosicaoComponentes(vCaixa, vEmpresa, vIDCaixa: String):integer;
    class procedure GravaEcfConfiguracao;
    class function ConsultaEcfConfiguracao(vCaixa, vEmpresa, vIDCaixa: String):integer;
    class function ConsultaCabecalhoNF2(vCaixa, vEmpresa, vIDCaixa: String):integer;
    class function ConsultaDetalheNF2(Identifica:string):integer;
    class procedure DeletaNotaFiscalCabecalhoDetalhe(vCaixa, vEmpresa, vIDCaixa, vIdCAB: String);
    class procedure ConsultaDataAtualizacao(Data:TDate);
    class procedure GravaDataAtualizacao(Data:TDate);
    class procedure GravaNotaFiscalCabecalho;
    class procedure GravaNotaFiscalDetalhe;
    class procedure CancelaNotaFiscalCabecalhoDetalhe;
  end;


implementation

uses UDataModule, LogImportacaoController;

var
   Tupla, LogErro :string;


{ TImportaController }

class function TImportaController.ImportaDadosDoPDV(pathlocal: string): boolean;
var
  ImportaPDV: TextFile;
  CabecalhoID,  DetalheID: integer;
  Compara, identificaVCB, identificaNFCB, identificaCPR, identifica, identificador : string;

begin
  try
    Application.ProcessMessages;
    AssignFile(ImportaPDV,pathlocal);
    Reset(ImportaPDV);

    While not Eof(ImportaPDV) do
    begin
      Read(ImportaPDV, Tupla);
      if Trim(Tupla) <> '' then
      begin
        LogErro := copy(Tupla,1,250);
        Compara := DevolveConteudoDelimitado('|',Tupla);
        identificador := DevolveConteudoDelimitado('|',Tupla);
        Application.ProcessMessages;
        if not ConsultaIntegracaoPDV(Compara+identificador) then
        begin
          GravaIntegracaoPDV(Compara+identificador);
          Application.ProcessMessages;
        end
        else
          Compara:= 'NULL';
      end
      else
        Compara:= 'NULL';

      if Compara = 'NULL'then
      begin
         Application.ProcessMessages;
      end else
      // ECF_VENDA_CABECALHO
      if Compara = 'VCB'then
      begin
        GravaEcfVendaCabecalho;
      end else
      // ECF_VENDA_DETALHE
      if Compara = 'VDT'then
      begin
         GravaEcfVendaDetalhe;
      end else
      // ECF_TOTAL_TIPO_PGTO
      if Compara = 'TTP'then
      begin
        GravaEcfTotalTipoPagamento;
      end else
      // ECF_VENDA_CABECALHO
      if Compara = 'CANCELAVCB'then
      begin
        CancelaEcfVendaCabecalho;
      end else
      // ECF_VENDA_DETALHE
      if Compara = 'CANCELAVDT'then
      begin
        CancelaEcfVendaDetalhe;
      end else
      // ECF_TOTAL_TIPO_PGTO
      if Compara = 'CANCELATTP'then
      begin
        CancelaEcfTotalTipoPagamento;
      end else
      // NOTA_FISCAL_CABECALHO  NOTA_FISCAL_DETALHE
      if Compara = 'CANCELANF2CAB' then
      begin
        CancelaNotaFiscalCabecalhoDetalhe;
      end else
      // NOTA_FISCAL_CABECALHO
      if Compara = 'INSERENF2CAB'then
      begin
        GravaNotaFiscalCabecalho;
      end else
      //NOTA_FISCAL_DETALHE
      if Compara = 'INSERENF2DET'then
      begin
        GravaNotaFiscalDetalhe;
      end else
      //CONTAS_PAGAR_RECEBER
      if Compara = 'CPR'then
      begin
        GravaContasPagarReceber;
      end else
      //CONTAS_PARCELAS
      if Compara = 'PAR'then
      begin
        GravaContasParcelas;
      end else
      // ECF_RESOLUCAO
      if Compara = 'RESOLUCAO'then
      begin
        GravaEcfResolucao;
      end else
      // ECF_POSICAO_COMPONENTES
      if Compara = 'COMPONENTES'then
      begin
        GravaEcfPosicaoComponentes;
      end else
      //ECF_CONFIGURACAO
      if Compara = 'CONFIGURACAO'then
      begin
        GravaEcfConfiguracao;
      end;


      Readln(ImportaPDV);
    end;
  finally
    CloseFile(ImportaPDV);
    Result:=true;
  end;
end;




class function TImportaController.BaixaEstoque(IdProduto: integer; Qtde: Extended): boolean;
begin
  try
    FDataModule.StoredProcedure.Name := 'ALTERA_QTDE_PRODUTO';
    // FDataModule.StoredProcedure.SQLConnection:= FDataModule.Conexao;

    FDataModule.StoredProcedure.ParamByName('PID').AsInteger:=IdProduto;
    FDataModule.StoredProcedure.ParamByName('PQTDE').AsFloat:=Qtde;
    FDataModule.StoredProcedure.ParamByName('PDATA').AsDate:=now;

    FDataModule.StoredProcedure.ExecProc;
    result := True;
  except
    Result:= False;
    TLogImportacaoController.GravaLogImportacao(LogErro);
  end;

end;



class procedure TImportaController.GravaNotaFiscalDetalhe;
var
   ConsultaSQL , MovimentaEstoque : String;
   Query: TSQLQuery;
   ProdutoID :integer;
   ProdutoQtde:Extended;
begin
  DevolveConteudoDelimitado('|',Tupla);
  DevolveConteudoDelimitado('|',Tupla);
  DevolveConteudoDelimitado('|',Tupla);
  DevolveConteudoDelimitado('|',Tupla);
  ProdutoID := StrToIntDef(DevolveConteudoDelimitado('|',Tupla),0);
  ProdutoQtde := StrToFloatDef(DevolveConteudoDelimitado('|',Tupla),0);
  MovimentaEstoque := DevolveConteudoDelimitado('|',Tupla);

  ConsultaSQL:= ' insert into NOTA_FISCAL_DETALHE ('+
                // 'ID, '+
                'NOME_CAIXA, '+
                'ID_GERADO_CAIXA, '+
                'ID_EMPRESA, '+
                'ID_NF_CABECALHO, '+
                'ID_PRODUTO, '+
                'CFOP, '+
                'ITEM, '+
                'QUANTIDADE, '+
                'VALOR_UNITARIO, '+
                'VALOR_TOTAL, '+
                'BASE_ICMS, '+
                'TAXA_ICMS, '+
                'ICMS, '+
                'ICMS_OUTRAS, '+
                'ICMS_ISENTO, '+
                'TAXA_DESCONTO, '+
                'DESCONTO, '+
                'TAXA_ISSQN, '+
                'ISSQN, '+
                'TAXA_PIS, '+
                'PIS, '+
                'TAXA_COFINS, '+
                'COFINS, '+
                'TAXA_ACRESCIMO, '+
                'ACRESCIMO, '+
                'TAXA_IPI, '+
                'IPI, '+
                'CANCELADO, '+
                'CST, '+
                'MOVIMENTA_ESTOQUE, '+
                'ECF_ICMS_ST, '+
                'DATA_SINCRONIZACAO, '+
                'HORA_SINCRONIZACAO)'+
           'values (' +
                        DevolveConteudoDelimitado('|',Tupla)+' ,'+    //    NOME_CAIXA,
                        DevolveConteudoDelimitado('|',Tupla)+' ,'+    //    ID_GERADO_CAIXA,
                        DevolveConteudoDelimitado('|',Tupla)+' ,'+    //    ID_EMPRESA,
                        DevolveConteudoDelimitado('|',Tupla)+' ,'+    //    ID_NF_CABECALHO,
                        DevolveConteudoDelimitado('|',Tupla)+' ,'+    //    ID_PRODUTO,
                        DevolveConteudoDelimitado('|',Tupla)+' ,'+    //    CFOP,
                        DevolveConteudoDelimitado('|',Tupla)+' ,'+    //    ITEM,
                        DevolveConteudoDelimitado('|',Tupla)+' ,'+    //    QUANTIDADE,
                        DevolveConteudoDelimitado('|',Tupla)+' ,'+    //    VALOR_UNITARIO,
                        DevolveConteudoDelimitado('|',Tupla)+' ,'+    //    VALOR_TOTAL,
                        DevolveConteudoDelimitado('|',Tupla)+' ,'+    //    BASE_ICMS,
                        DevolveConteudoDelimitado('|',Tupla)+' ,'+    //    TAXA_ICMS,
                        DevolveConteudoDelimitado('|',Tupla)+' ,'+    //    ICMS,
                        DevolveConteudoDelimitado('|',Tupla)+' ,'+    //    ICMS_OUTRAS,
                        DevolveConteudoDelimitado('|',Tupla)+' ,'+    //    ICMS_ISENTO,
                        DevolveConteudoDelimitado('|',Tupla)+' ,'+    //    TAXA_DESCONTO,
                        DevolveConteudoDelimitado('|',Tupla)+' ,'+    //    DESCONTO,
                        DevolveConteudoDelimitado('|',Tupla)+' ,'+    //    TAXA_ISSQN,
                        DevolveConteudoDelimitado('|',Tupla)+' ,'+    //    ISSQN,
                        DevolveConteudoDelimitado('|',Tupla)+' ,'+    //    TAXA_PIS,
                        DevolveConteudoDelimitado('|',Tupla)+' ,'+    //    PIS,
                        DevolveConteudoDelimitado('|',Tupla)+' ,'+    //    TAXA_COFINS,
                        DevolveConteudoDelimitado('|',Tupla)+' ,'+    //    COFINS,
                        DevolveConteudoDelimitado('|',Tupla)+' ,'+    //    TAXA_ACRESCIMO,
                        DevolveConteudoDelimitado('|',Tupla)+' ,'+    //    ACRESCIMO,
                        DevolveConteudoDelimitado('|',Tupla)+' ,'+    //    TAXA_IPI,
                        DevolveConteudoDelimitado('|',Tupla)+' ,'+    //    IPI,
                        DevolveConteudoDelimitado('|',Tupla)+' ,'+    //    CANCELADO,
                        DevolveConteudoDelimitado('|',Tupla)+' ,'+    //    CST,
                        DevolveConteudoDelimitado('|',Tupla)+' ,'+    //    MOVIMENTA_ESTOQUE,
                        DevolveConteudoDelimitado('|',Tupla)+' ,'+    //    ECF_ICMS_ST
                        QuotedStr(DataParaTexto(Now))+' ,'+           //    DATA_SINCRONIZACAO,
                        QuotedStr(TimeToStr(Now))+')';                //    HORA_SINCRONIZACAO)


  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.ConexaoBalcao;
      Query.sql.Text := ConsultaSQL;

      Query.ExecSQL();

      ///***********************************baixa estoque****************

    except
      TLogImportacaoController.GravaLogImportacao(LogErro);
    end;
  finally
    Query.Free;
  end;

  ProdutoComposto(ProdutoID,((-1)*ProdutoQtde));
  if MovimentaEstoque= 'S' then
    BaixaEstoque(ProdutoID,((-1)*ProdutoQtde));

end;

class procedure TImportaController.GravaContasParcelas;
var
   ConsultaSQL ,IdCPR : String;
   Query : TSQLQuery;

begin
  try
    try
      IdCPR := '';
      ConsultaSQL := ' select ID from CONTAS_PAGAR_RECEBER where (NUMERO_DOCUMENTO =:pNum)';
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.ConexaoBalcao;
      Query.sql.Text := ConsultaSQL;
      Query.ParamByName('pNum').AsString := DevolveConteudoDelimitado('|',Tupla);
      Query.Open;
      IdCPR := Query.FieldByName('ID').AsString;
    finally
      Query.Free;
    end;

    if IdCPR <> '' then
    begin
      ConsultaSQL :=
      ' insert into CONTAS_PARCELAS ('+
          //   'ID, '+
          //   'ID_CHEQUE_EMITIDO, '+
          //   'ID_CONTA_CAIXA, '+
          //   'ID_MEIOS_PAGAMENTO, '+
          'ID_CONTAS_PAGAR_RECEBER, '+
          'DATA_EMISSAO, '+
          'DATA_VENCIMENTO, '+
          //   'DATA_PAGAMENTO, '+
          'NUMERO_PARCELA, '+
          'VALOR, '+
          'TAXA_JUROS, '+
          'TAXA_MULTA, '+
          'TAXA_DESCONTO, '+
          'VALOR_JUROS, '+
          'VALOR_MULTA, '+
          'VALOR_DESCONTO, '+
          'TOTAL_PARCELA, '+
          'HISTORICO, '+
          'SITUACAO)'+

      'values ('+IdCPR+' ,'+                                    //   ID_CHEQUE_EMITIDO
                DevolveConteudoDelimitado('|',Tupla)+' ,'+      //   ID_CONTA_CAIXA
                DevolveConteudoDelimitado('|',Tupla)+' ,'+      //   ID_MEIOS_PAGAMENTO
                DevolveConteudoDelimitado('|',Tupla)+' ,'+      //   ID_CONTAS_PAGAR_RECEBER
                DevolveConteudoDelimitado('|',Tupla)+' ,'+      //   DATA_EMISSAO
                DevolveConteudoDelimitado('|',Tupla)+' ,'+      //   DATA_VENCIMENTO
                DevolveConteudoDelimitado('|',Tupla)+' ,'+      //   DATA_PAGAMENTO
                DevolveConteudoDelimitado('|',Tupla)+' ,'+      //   NUMERO_PARCELA
                DevolveConteudoDelimitado('|',Tupla)+' ,'+      //   VALOR
                DevolveConteudoDelimitado('|',Tupla)+' ,'+      //   TAXA_JUROS
                DevolveConteudoDelimitado('|',Tupla)+' ,'+      //   TAXA_MULTA
                DevolveConteudoDelimitado('|',Tupla)+' ,'+      //   TAXA_DESCONTO
                DevolveConteudoDelimitado('|',Tupla)+' ,'+      //   VALOR_JUROS
                DevolveConteudoDelimitado('|',Tupla)+' ,'+      //   VALOR_MULTA
                DevolveConteudoDelimitado('|',Tupla)+' ,'+      //   VALOR_DESCONTO
                DevolveConteudoDelimitado('|',Tupla)+' ,'+      //   TOTAL_PARCELA
                DevolveConteudoDelimitado('|',Tupla)+' ,'+      //   HISTORICO
                DevolveConteudoDelimitado('|',Tupla)+')';      //   SITUACAO                                                                                     SITUACAO

      try
        Query := TSQLQuery.Create(nil);
        Query.SQLConnection := FDataModule.ConexaoBalcao;
        Query.sql.Text := ConsultaSQL;

        Query.ExecSQL();

      except
        TLogImportacaoController.GravaLogImportacao(LogErro);
      end;
    end;
  finally
    Query.Free;
  end;

end;

class procedure TImportaController.ConsultaDataAtualizacao(Data: TDate);
var
   ConsultaSQL : String;
   Query: TSQLQuery;
   vHora : TTime;
begin
  vHora := StrToTime('02:00:00');
  ConsultaSQL := 'Select DATA_MOVIMENTO from Empresa';
  try

    Query := TSQLQuery.Create(nil);
    Query.SQLConnection := FDataModule.ConexaoBalcao;
    Query.sql.Text := ConsultaSQL;
    Query.Open;

    if DataParaTexto(Query.FieldByName('DATA_MOVIMENTO').AsDateTime) <> DataParaTexto(Data) then
    begin
      if now > vhora then
      begin
        GravaDataAtualizacao(Data);
      end;
    end;

  finally
    Query.Free;
  end;


end;

class procedure TImportaController.GravaDataAtualizacao(Data: TDate);
var
   ConsultaSQL : String;
   Query: TSQLQuery;
begin
  ConsultaSQL := ' update PRODUTO  set '+
                 'QTD_ESTOQUE_ANTERIOR = QTD_ESTOQUE ';


  try

    Query := TSQLQuery.Create(nil);
    Query.SQLConnection := FDataModule.ConexaoBalcao;
    Query.sql.Text := ConsultaSQL;
    Query.ExecSQL();

  finally
    Query.Free;
  end;


  ConsultaSQL := '  update EMPRESA set DATA_MOVIMENTO = :pData';
  try

    Query := TSQLQuery.Create(nil);
    Query.SQLConnection := FDataModule.ConexaoBalcao;
    Query.sql.Text := ConsultaSQL;
    Query.ParamByName('pData').AsDate := Data;
    Query.ExecSQL();

  finally
    Query.Free;
  end;



end;



class procedure TImportaController.CancelaNotaFiscalCabecalhoDetalhe;
var
   ConsultaSQL, Caixa, Empresa, IDCaixa, NumeroNota: String;
   Query: TSQLQuery;
   ProdutoID, IdNF2: integer;
   ProdutoQtde: Extended;
begin

  Caixa := trim(DevolveConteudoDelimitado('|',Tupla));
  IDCaixa := trim(DevolveConteudoDelimitado('|',Tupla));
  Empresa := trim(DevolveConteudoDelimitado('|',Tupla));
  NumeroNota := trim(DevolveConteudoDelimitado('|',Tupla));

  IdNF2 := ConsultaCabecalhoNF2(Caixa, Empresa, NumeroNota);

  ConsultaSQL := 'select MOVIMENTA_ESTOQUE,'+
                         'ID_PRODUTO, '+
                         'QUANTIDADE '+
                 ' from NOTA_FISCAL_DETALHE where ('+
                         ' ID_NF_CABECALHO ='+IntToStr(IdNF2)+
                         ' ID_EMPRESA ='+QuotedStr(Empresa)+
                         ' NOME_CAIXA ='+QuotedStr(Caixa);
  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.ConexaoBalcao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      if not Query.IsEmpty then
      begin
        Query.First;
        while not query.Eof do
        begin
          if query.FieldByName('MOVIMENTA_ESTOQUE').AsString = 'S' then
          begin
            ProdutoID := query.FieldByName('ID_PRODUTO').AsInteger;
            ProdutoQtde := query.FieldByName('QUANTIDADE').AsFloat;
            ProdutoComposto(ProdutoID,ProdutoQtde);
            BaixaEstoque(ProdutoID,ProdutoQtde);
          end;
          query.Next;
        end;
      end;
    except
      TLogImportacaoController.GravaLogImportacao(LogErro);
    end;
  finally
    Query.Free;
  end;
  DeletaNotaFiscalCabecalhoDetalhe(Caixa, Empresa, IDCaixa, IntToStr(IdNF2));

end;

class procedure TImportaController.CancelaEcfTotalTipoPagamento;
var
   ConsultaSQL, Caixa: String;
   Query: TSQLQuery;
   Empresa, VCBid, TTPid  :integer;
begin
  try
    Empresa := StrToInt(DevolveConteudoDelimitado('|',Tupla));
    Caixa := DevolveConteudoDelimitado('|',Tupla);
    TTPid := StrToInt(DevolveConteudoDelimitado('|',Tupla));
    VCBid := StrToInt(DevolveConteudoDelimitado('|',Tupla));

    ConsultaSQL:=
    'update ECF_TOTAL_TIPO_PGTO set '+


        'NOME_CAIXA = '              +  DevolveConteudoDelimitado('|',Tupla)+ ', '+
        'ID_GERADO_CAIXA = '         +  DevolveConteudoDelimitado('|',Tupla)+ ', '+
        'ID_EMPRESA = '              +  DevolveConteudoDelimitado('|',Tupla)+ ', '+
        'ID_ECF_VENDA_CABECALHO = '  +  DevolveConteudoDelimitado('|',Tupla)+ ', '+
        'ID_ECF_TIPO_PAGAMENTO = '   +  DevolveConteudoDelimitado('|',Tupla)+ ', '+
        'SERIE_ECF = '               +  DevolveConteudoDelimitado('|',Tupla)+ ', '+
        'COO = '                     +  DevolveConteudoDelimitado('|',Tupla)+ ', '+
        'CCF = '                     +  DevolveConteudoDelimitado('|',Tupla)+ ', '+
        'GNF = '                     +  DevolveConteudoDelimitado('|',Tupla)+ ', '+
        'VALOR = '                   +  DevolveConteudoDelimitado('|',Tupla)+ ', '+
        'NSU = '                     +  DevolveConteudoDelimitado('|',Tupla)+ ', '+
        'ESTORNO = '                 +  DevolveConteudoDelimitado('|',Tupla)+ ', '+
        'REDE = '                    +  DevolveConteudoDelimitado('|',Tupla)+ ', '+
        'CARTAO_DC = '               +  DevolveConteudoDelimitado('|',Tupla)+ ', '+
        'HASH_TRIPA = '              +  DevolveConteudoDelimitado('|',Tupla)+ ', '+
        'HASH_INCREMENTO = '         +  DevolveConteudoDelimitado('|',Tupla)+ ', '+
        'DATA_SINCRONIZACAO = '      +  QuotedStr(DataParaTexto(Now))+' ,'+
        'HORA_SINCRONIZACAO = '      +  QuotedStr(TimeToStr(Now))+

    ' Where ' +
                ' (ID_EMPRESA =  ' + IntToStr(Empresa)+ ') and '+
                ' (NOME_CAIXA = ' + QuotedStr(Caixa)+ ') and '+
                ' (ID_GERADO_CAIXA = ' + IntToStr(TTPid)+ ') and '+
                ' (ID_ECF_VENDA_CABECALHO = ' + IntToStr(VCBid)+ ')';



    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.ConexaoBalcao;
      Query.sql.Text := ConsultaSQL;

      Query.ExecSQL();

    except
      TLogImportacaoController.GravaLogImportacao(LogErro);
    end;
  finally
    Query.Free;
  end;


end;

class procedure TImportaController.CancelaEcfVendaCabecalho;
var
   ConsultaSQL, Caixa: String;
   Query: TSQLQuery;
   Empresa, VCBid,VCBcoo: integer;
begin
  try
    Empresa := StrToInt(DevolveConteudoDelimitado('|',Tupla));
    Caixa := DevolveConteudoDelimitado('|',Tupla);
    VCBid := StrToInt(DevolveConteudoDelimitado('|',Tupla));
    VCBcoo := StrToInt(DevolveConteudoDelimitado('|',Tupla));

    ConsultaSQL:=
      'update ECF_VENDA_CABECALHO set '+

      'NOME_CAIXA = '                    + DevolveConteudoDelimitado('|',Tupla)+ ', '+
      'ID_GERADO_CAIXA = '               + DevolveConteudoDelimitado('|',Tupla)+ ', '+
      'ID_EMPRESA = '                    + DevolveConteudoDelimitado('|',Tupla)+ ', '+
      'ID_CLIENTE = '                    + DevolveConteudoDelimitado('|',Tupla)+ ', '+
      'ID_ECF_FUNCIONARIO = '            + DevolveConteudoDelimitado('|',Tupla)+ ', '+
      'ID_ECF_MOVIMENTO = '              + DevolveConteudoDelimitado('|',Tupla)+ ', '+
      'ID_ECF_DAV = '                    + DevolveConteudoDelimitado('|',Tupla)+ ', '+
      'ID_ECF_PRE_VENDA_CABECALHO = '    + DevolveConteudoDelimitado('|',Tupla)+ ', '+
      'SERIE_ECF = '                     + DevolveConteudoDelimitado('|',Tupla)+ ', '+
      'CFOP = '                          + DevolveConteudoDelimitado('|',Tupla)+ ', '+
      'COO = '                           + DevolveConteudoDelimitado('|',Tupla)+ ', '+
      'CCF = '                           + DevolveConteudoDelimitado('|',Tupla)+ ', '+
      'DATA_VENDA = '                    + DevolveConteudoDelimitado('|',Tupla)+ ', '+
      'HORA_VENDA = '                    + DevolveConteudoDelimitado('|',Tupla)+ ', '+
      'VALOR_VENDA = '                   + DevolveConteudoDelimitado('|',Tupla)+ ', '+
      'TAXA_DESCONTO = '                 + DevolveConteudoDelimitado('|',Tupla)+ ', '+
      'DESCONTO = '                      + DevolveConteudoDelimitado('|',Tupla)+ ', '+
      'TAXA_ACRESCIMO = '                + DevolveConteudoDelimitado('|',Tupla)+ ', '+
      'ACRESCIMO = '                     + DevolveConteudoDelimitado('|',Tupla)+ ', '+
      'VALOR_FINAL = '                   + DevolveConteudoDelimitado('|',Tupla)+ ', '+
      'VALOR_RECEBIDO = '                + DevolveConteudoDelimitado('|',Tupla)+ ', '+
      'TROCO = '                         + DevolveConteudoDelimitado('|',Tupla)+ ', '+
      'VALOR_CANCELADO = '               + DevolveConteudoDelimitado('|',Tupla)+ ', '+
      'TOTAL_PRODUTOS = '                + DevolveConteudoDelimitado('|',Tupla)+ ', '+
      'TOTAL_DOCUMENTO = '               + DevolveConteudoDelimitado('|',Tupla)+ ', '+
      'BASE_ICMS = '                     + DevolveConteudoDelimitado('|',Tupla)+ ', '+
      'ICMS = '                          + DevolveConteudoDelimitado('|',Tupla)+ ', '+
      'ICMS_OUTRAS = '                   + DevolveConteudoDelimitado('|',Tupla)+ ', '+
      'ISSQN = '                         + DevolveConteudoDelimitado('|',Tupla)+ ', '+
      'PIS = '                           + DevolveConteudoDelimitado('|',Tupla)+ ', '+
      'COFINS = '                        + DevolveConteudoDelimitado('|',Tupla)+ ', '+
      'ACRESCIMO_ITENS = '               + DevolveConteudoDelimitado('|',Tupla)+ ', '+
      'DESCONTO_ITENS = '                + DevolveConteudoDelimitado('|',Tupla)+ ', '+
      'STATUS_VENDA = '                  + DevolveConteudoDelimitado('|',Tupla)+ ', '+
      'NOME_CLIENTE = '                  + DevolveConteudoDelimitado('|',Tupla)+ ', '+
      'CPF_CNPJ_CLIENTE = '              + DevolveConteudoDelimitado('|',Tupla)+ ', '+
      'CUPOM_CANCELADO = '               + DevolveConteudoDelimitado('|',Tupla)+ ', '+
      'HASH_TRIPA = '                    + DevolveConteudoDelimitado('|',Tupla)+ ', '+
      'HASH_INCREMENTO = '               + DevolveConteudoDelimitado('|',Tupla)+ ', '+
      'DATA_SINCRONIZACAO = '            + QuotedStr(DataParaTexto(Now))+' ,'+
      'HORA_SINCRONIZACAO = '            + QuotedStr(TimeToStr(Now))+

      ' Where ' +
                  ' (ID_EMPRESA =  ' + IntToStr(Empresa)+ ') and '+
                  ' (NOME_CAIXA = ' + QuotedStr(Caixa)+ ') and '+
                  ' (ID_GERADO_CAIXA = ' + IntToStr(VCBid)+ ') and '+
                  ' (COO = ' + IntToStr(VCBcoo)+ ')';

    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.ConexaoBalcao;
      Query.sql.Text := ConsultaSQL;


      Query.ExecSQL();

    except
      TLogImportacaoController.GravaLogImportacao(LogErro);
    end;
  finally
    Query.Free;
  end;

end;

class procedure TImportaController.CancelaEcfVendaDetalhe;
var
   ConsultaSQL, Cancelado, MovimentaEstoque, Caixa : String;
   Query: TSQLQuery;
   ProdutoID, Empresa, VCBid, VDTid : integer;
   ProdutoQtde : Extended;

begin
  try
    Empresa := StrToInt(DevolveConteudoDelimitado('|',Tupla));
    Caixa := DevolveConteudoDelimitado('|',Tupla);
    VDTid := StrToInt(DevolveConteudoDelimitado('|',Tupla));
    VCBid := StrToInt(DevolveConteudoDelimitado('|',Tupla));


    ProdutoID :=  StrToInt(DevolveConteudoDelimitado('|',Tupla));
    ProdutoQtde := StrToFloat(DevolveConteudoDelimitado('|',Tupla));
    MovimentaEstoque := DevolveConteudoDelimitado('|',Tupla);


    ConsultaSQL:=
    'update ECF_VENDA_DETALHE set '+

    'NOME_CAIXA              = ' + DevolveConteudoDelimitado('|',Tupla)+ ', '+
    'ID_GERADO_CAIXA         = ' + DevolveConteudoDelimitado('|',Tupla)+ ', '+
    'ID_EMPRESA              = ' + DevolveConteudoDelimitado('|',Tupla)+ ', '+
    'ID_ECF_PRODUTO          = ' + DevolveConteudoDelimitado('|',Tupla)+ ', '+
    'ID_ECF_VENDA_CABECALHO  = ' + DevolveConteudoDelimitado('|',Tupla)+ ', '+
    'SERIE_ECF = '               + DevolveConteudoDelimitado('|',Tupla)+ ', '+
    'GTIN = '                    + DevolveConteudoDelimitado('|',Tupla)+ ', '+
    'CCF = '                     + DevolveConteudoDelimitado('|',Tupla)+ ', '+
    'COO = '                     + DevolveConteudoDelimitado('|',Tupla)+ ', '+
    'CFOP = '                    + DevolveConteudoDelimitado('|',Tupla)+ ', '+
    'ITEM = '                    + DevolveConteudoDelimitado('|',Tupla)+ ', '+
    'QUANTIDADE  = '             + DevolveConteudoDelimitado('|',Tupla)+ ', '+
    'VALOR_UNITARIO = '          + DevolveConteudoDelimitado('|',Tupla)+ ', '+
    'VALOR_TOTAL = '             + DevolveConteudoDelimitado('|',Tupla)+ ', '+
    'TOTAL_ITEM = '              + DevolveConteudoDelimitado('|',Tupla)+ ', '+
    'BASE_ICMS = '               + DevolveConteudoDelimitado('|',Tupla)+ ', '+
    'TAXA_ICMS = '               + DevolveConteudoDelimitado('|',Tupla)+ ', '+
    'ICMS = '                    + DevolveConteudoDelimitado('|',Tupla)+ ', '+
    'TAXA_DESCONTO = '           + DevolveConteudoDelimitado('|',Tupla)+ ', '+
    'DESCONTO = '                + DevolveConteudoDelimitado('|',Tupla)+ ', '+
    'TAXA_ISSQN = '              + DevolveConteudoDelimitado('|',Tupla)+ ', '+
    'ISSQN = '                   + DevolveConteudoDelimitado('|',Tupla)+ ', '+
    'TAXA_PIS = '                + DevolveConteudoDelimitado('|',Tupla)+ ', '+
    'PIS = '                     + DevolveConteudoDelimitado('|',Tupla)+ ', '+
    'TAXA_COFINS = '             + DevolveConteudoDelimitado('|',Tupla)+ ', '+
    'COFINS = '                  + DevolveConteudoDelimitado('|',Tupla)+ ', '+
    'TAXA_ACRESCIMO = '          + DevolveConteudoDelimitado('|',Tupla)+ ', '+
    'ACRESCIMO = '               + DevolveConteudoDelimitado('|',Tupla)+ ', '+
    'ACRESCIMO_RATEIO = '        + DevolveConteudoDelimitado('|',Tupla)+ ', '+
    'DESCONTO_RATEIO = '         + DevolveConteudoDelimitado('|',Tupla)+ ', '+
    'TOTALIZADOR_PARCIAL = '     + DevolveConteudoDelimitado('|',Tupla)+ ', '+
    'CST = '                     + DevolveConteudoDelimitado('|',Tupla)+ ', '+
    'CANCELADO = '               + DevolveConteudoDelimitado('|',Tupla)+ ', '+
    'MOVIMENTA_ESTOQUE = '       + DevolveConteudoDelimitado('|',Tupla)+ ', '+
    'ECF_ICMS_ST = '             + DevolveConteudoDelimitado('|',Tupla)+ ', '+
    'HASH_TRIPA = '              + DevolveConteudoDelimitado('|',Tupla)+ ', '+
    'HASH_INCREMENTO = '         + DevolveConteudoDelimitado('|',Tupla)+ ', '+
    'DATA_SINCRONIZACAO = '      + QuotedStr(DataParaTexto(Now))+' ,'+
    'HORA_SINCRONIZACAO = '      + QuotedStr(TimeToStr(Now))+

    ' Where ' +
                ' (ID_EMPRESA =  ' + IntToStr(Empresa)+ ') and '+
                ' (NOME_CAIXA = ' + QuotedStr(Caixa)+ ') and '+
                ' (ID_GERADO_CAIXA = ' + IntToStr(VDTid)+ ') and '+
                ' (ID_ECF_VENDA_CABECALHO = ' + IntToStr(VCBid)+ ')';



    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.ConexaoBalcao;
      Query.sql.Text := ConsultaSQL;

      Query.ExecSQL();

      ///***********************************baixa estoque****************
      ProdutoComposto(ProdutoID,ProdutoQtde);
      if MovimentaEstoque= 'S' then
        BaixaEstoque(ProdutoID,ProdutoQtde);


    except
      TLogImportacaoController.GravaLogImportacao(LogErro);
    end;
  finally
    Query.Free;
  end;

end;

class procedure TImportaController.GravaContasPagarReceber;
var
   ConsultaSQL : String;
   Query: TSQLQuery;
begin
  try
    ConsultaSQL:=
    ' insert into CONTAS_PAGAR_RECEBER ('+
                    //  'ID, '+
                    'ID_PLANO_CONTAS, '+
                    'ID_PESSOA, '+
                    'ID_TIPO_DOCUMENTO, '+
                    'TIPO, '+
                    'NUMERO_DOCUMENTO, '+
                    'VALOR, '+
                    'DATA_LANCAMENTO, '+
                    'PRIMEIRO_VENCIMENTO, '+
                    'NATUREZA_LANCAMENTO, '+
                    'QUANTIDADE_PARCELA)'+

    'values ('+ DevolveConteudoDelimitado('|',Tupla)+' ,'+      //  'ID_PLANO_CONTAS, '+
                DevolveConteudoDelimitado('|',Tupla)+' ,'+      //  'ID_PESSOA, '+
                DevolveConteudoDelimitado('|',Tupla)+' ,'+      //  'ID_TIPO_DOCUMENTO, '+
                DevolveConteudoDelimitado('|',Tupla)+' ,'+      //  'TIPO, '+
                DevolveConteudoDelimitado('|',Tupla)+' ,'+      //  'NUMERO_DOCUMENTO, '+
                DevolveConteudoDelimitado('|',Tupla)+' ,'+      //  'VALOR, '+
                DevolveConteudoDelimitado('|',Tupla)+' ,'+      //  'DATA_LANCAMENTO, '+
                DevolveConteudoDelimitado('|',Tupla)+' ,'+      //  'PRIMEIRO_VENCIMENTO, '+
                DevolveConteudoDelimitado('|',Tupla)+' ,'+      //  'NATUREZA_LANCAMENTO, '+
                DevolveConteudoDelimitado('|',Tupla)+')';       //  'QUANTIDADE_PARCELA)'+



    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.ConexaoBalcao;
      Query.sql.Text := ConsultaSQL;

      Query.ExecSQL();

    except
      TLogImportacaoController.GravaLogImportacao(LogErro);
    end;
  finally
    Query.Free;
  end;

end;

class procedure TImportaController.GravaNotaFiscalCabecalho;
var
   ConsultaSQL: String;
   Query: TSQLQuery;

begin

  DevolveConteudoDelimitado('|',Tupla);
  DevolveConteudoDelimitado('|',Tupla);
  DevolveConteudoDelimitado('|',Tupla);
  DevolveConteudoDelimitado('|',Tupla);


  ConsultaSQL := ' insert into NOTA_FISCAL_CABECALHO ('+
   // 'ID, '+
    'NOME_CAIXA, '+
    'ID_GERADO_CAIXA, '+
    'ID_EMPRESA, '+
    'ID_ECF_FUNCIONARIO, '+
    'ID_CLIENTE, '+
    'CFOP, '+
    'NUMERO, '+
    'DATA_EMISSAO, '+
    'HORA_EMISSAO, '+
    'SERIE, '+
    'SUBSERIE, '+
    'TOTAL_PRODUTOS, '+
    'TOTAL_NF, '+
    'BASE_ICMS, '+
    'ICMS, '+
    'ICMS_OUTRAS, '+
    'ISSQN, '+
    'PIS, '+
    'COFINS, '+
    'IPI, '+
    'TAXA_ACRESCIMO, '+
    'ACRESCIMO, '+
    'ACRESCIMO_ITENS, '+
    'TAXA_DESCONTO, '+
    'DESCONTO, '+
    'DESCONTO_ITENS, '+
    'CANCELADA, '+
    'TIPO_NOTA, '+
    'DATA_SINCRONIZACAO, '+
    'HORA_SINCRONIZACAO)'+
  'values ('+ DevolveConteudoDelimitado('|',Tupla)+' ,'+      //   NOME_CAIXA,
              DevolveConteudoDelimitado('|',Tupla)+' ,'+      //   ID_GERADO_CAIXA,
              DevolveConteudoDelimitado('|',Tupla)+' ,'+      //   ID_EMPRESA,
              DevolveConteudoDelimitado('|',Tupla)+' ,'+      //   ID_ECF_FUNCIONARIO,
              DevolveConteudoDelimitado('|',Tupla)+' ,'+      //   ID_CLIENTE,
              DevolveConteudoDelimitado('|',Tupla)+' ,'+      //   CFOP,
              DevolveConteudoDelimitado('|',Tupla)+' ,'+      //   NUMERO,
              DevolveConteudoDelimitado('|',Tupla)+' ,'+      //   DATA_EMISSAO,
              DevolveConteudoDelimitado('|',Tupla)+' ,'+      //   HORA_EMISSAO,
              DevolveConteudoDelimitado('|',Tupla)+' ,'+      //   SERIE,
              DevolveConteudoDelimitado('|',Tupla)+' ,'+      //   SUBSERIE,
              DevolveConteudoDelimitado('|',Tupla)+' ,'+      //   TOTAL_PRODUTOS,
              DevolveConteudoDelimitado('|',Tupla)+' ,'+      //   TOTAL_NF,
              DevolveConteudoDelimitado('|',Tupla)+' ,'+      //   BASE_ICMS,
              DevolveConteudoDelimitado('|',Tupla)+' ,'+      //   ICMS,
              DevolveConteudoDelimitado('|',Tupla)+' ,'+      //   ICMS_OUTRAS,
              DevolveConteudoDelimitado('|',Tupla)+' ,'+      //   ISSQN,
              DevolveConteudoDelimitado('|',Tupla)+' ,'+      //   PIS,
              DevolveConteudoDelimitado('|',Tupla)+' ,'+      //   COFINS,
              DevolveConteudoDelimitado('|',Tupla)+' ,'+      //   IPI,
              DevolveConteudoDelimitado('|',Tupla)+' ,'+      //   TAXA_ACRESCIMO,
              DevolveConteudoDelimitado('|',Tupla)+' ,'+      //   ACRESCIMO,
              DevolveConteudoDelimitado('|',Tupla)+' ,'+      //   ACRESCIMO_ITENS,
              DevolveConteudoDelimitado('|',Tupla)+' ,'+      //   TAXA_DESCONTO,
              DevolveConteudoDelimitado('|',Tupla)+' ,'+      //   DESCONTO,
              DevolveConteudoDelimitado('|',Tupla)+' ,'+      //   DESCONTO_ITENS,
              DevolveConteudoDelimitado('|',Tupla)+' ,'+      //   CANCELADA,
              DevolveConteudoDelimitado('|',Tupla)+' ,'+      //   TIPO_NOTA,
              QuotedStr(DataParaTexto(Now))+' ,'+             //   DATA_SINCRONIZACAO'
              QuotedStr(TimeToStr(Now))+')';                      //   HORA_SINCRONIZACAO


  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.ConexaoBalcao;
      Query.sql.Text := ConsultaSQL;

      Query.ExecSQL();

    except
      TLogImportacaoController.GravaLogImportacao(LogErro);
    end;
  finally
    Query.Free;
  end;

end;



class procedure TImportaController.GravaEcfConfiguracao;
var
  ConsultaSQL, Caixa, Empresa, IDCaixa: String;
  Query: TSQLQuery;
  Chave: integer;

begin
  try
    Caixa := trim(DevolveConteudoDelimitado('|',Tupla));
    Empresa := trim(DevolveConteudoDelimitado('|',Tupla));
    IDCaixa := trim(DevolveConteudoDelimitado('|',Tupla));

    Chave := ConsultaEcfConfiguracao(Caixa, Empresa, IDCaixa);

    if Chave = 0 then
    begin
      ConsultaSQL:= ' insert into ECF_CONFIGURACAO ('+
                      //  'ID, '+
                      'NOME_CAIXA, '+
                      'ID_GERADO_CAIXA, '+
                      'ID_EMPRESA, '+
                      'ID_ECF_IMPRESSORA, '+
                      'ID_ECF_RESOLUCAO, '+
                      'ID_ECF_CAIXA, '+
                      'ID_ECF_EMPRESA, '+
                      'MENSAGEM_CUPOM, '+
                      'PORTA_ECF, '+
                      'IP_SERVIDOR, '+
                      'IP_SITEF, '+
                      'TIPO_TEF, '+
                      'TITULO_TELA_CAIXA, '+
                      'CAMINHO_IMAGENS_PRODUTOS, '+
                      'CAMINHO_IMAGENS_MARKETING, '+
                      'CAMINHO_IMAGENS_LAYOUT, '+
                      'COR_JANELAS_INTERNAS, '+
                      'MARKETING_ATIVO, '+
                      'CFOP_ECF, '+
                      'CFOP_NF2, '+
                      'TIMEOUT_ECF, '+
                      'INTERVALO_ECF, '+
                      'DESCRICAO_SUPRIMENTO, '+
                      'DESCRICAO_SANGRIA, '+
                      'TEF_TIPO_GP, '+
                      'TEF_TEMPO_ESPERA, '+
                      'TEF_ESPERA_STS, '+
                      'TEF_NUMERO_VIAS, '+
                      'DECIMAIS_QUANTIDADE, '+
                      'DECIMAIS_VALOR, '+
                      'BITS_POR_SEGUNDO, '+
                      'QTDE_MAXIMA_CARTOES, '+
                      'PESQUISA_PARTE, '+
                      'CONFIGURACAO_BALANCA, '+
                      'PARAMETROS_DIVERSOS, '+
                      'ULTIMA_EXCLUSAO, '+
                      'LAUDO, '+
                      'INDICE_GERENCIAL '+
                      'DATA_ATUALIZACAO_ESTOQUE '+
                      'DATA_SINCRONIZACAO, '+
                      'HORA_SINCRONIZACAO)' +


      ' values ( '+DevolveConteudoDelimitado('|',Tupla)+' ,'+  //   'NOME_CAIXA, '+
                   DevolveConteudoDelimitado('|',Tupla)+' ,'+  //   'ID_GERADO_CAIXA, '+
                   DevolveConteudoDelimitado('|',Tupla)+' ,'+  //   'ID_EMPRESA, '+
                   DevolveConteudoDelimitado('|',Tupla)+' ,'+  //   'ID_ECF_IMPRESSORA, '+
                   DevolveConteudoDelimitado('|',Tupla)+' ,'+  //   'ID_ECF_RESOLUCAO, '+
                   DevolveConteudoDelimitado('|',Tupla)+' ,'+  //   'ID_ECF_CAIXA, '+
                   DevolveConteudoDelimitado('|',Tupla)+' ,'+  //   'ID_ECF_EMPRESA, '+
                   DevolveConteudoDelimitado('|',Tupla)+' ,'+  //   'MENSAGEM_CUPOM, '+
                   DevolveConteudoDelimitado('|',Tupla)+' ,'+  //   'PORTA_ECF, '+
                   DevolveConteudoDelimitado('|',Tupla)+' ,'+  //   'IP_SERVIDOR, '+
                   DevolveConteudoDelimitado('|',Tupla)+' ,'+  //   'IP_SITEF, '+
                   DevolveConteudoDelimitado('|',Tupla)+' ,'+  //   'TIPO_TEF, '+
                   DevolveConteudoDelimitado('|',Tupla)+' ,'+  //   'TITULO_TELA_CAIXA, '+
                   DevolveConteudoDelimitado('|',Tupla)+' ,'+  //   'CAMINHO_IMAGENS_PRODUTOS, '+
                   DevolveConteudoDelimitado('|',Tupla)+' ,'+  //   'CAMINHO_IMAGENS_MARKETING, '+
                   DevolveConteudoDelimitado('|',Tupla)+' ,'+  //   'CAMINHO_IMAGENS_LAYOUT, '+
                   DevolveConteudoDelimitado('|',Tupla)+' ,'+  //   'COR_JANELAS_INTERNAS, '+
                   DevolveConteudoDelimitado('|',Tupla)+' ,'+  //   'MARKETING_ATIVO, '+
                   DevolveConteudoDelimitado('|',Tupla)+' ,'+  //   'CFOP_ECF, '+
                   DevolveConteudoDelimitado('|',Tupla)+' ,'+  //   'CFOP_NF2, '+
                   DevolveConteudoDelimitado('|',Tupla)+' ,'+  //   'TIMEOUT_ECF, '+
                   DevolveConteudoDelimitado('|',Tupla)+' ,'+  //   'INTERVALO_ECF, '+
                   DevolveConteudoDelimitado('|',Tupla)+' ,'+  //   'DESCRICAO_SUPRIMENTO, '+
                   DevolveConteudoDelimitado('|',Tupla)+' ,'+  //   'DESCRICAO_SANGRIA, '+
                   DevolveConteudoDelimitado('|',Tupla)+' ,'+  //   'TEF_TIPO_GP, '+
                   DevolveConteudoDelimitado('|',Tupla)+' ,'+  //   'TEF_TEMPO_ESPERA, '+
                   DevolveConteudoDelimitado('|',Tupla)+' ,'+  //   'TEF_ESPERA_STS, '+
                   DevolveConteudoDelimitado('|',Tupla)+' ,'+  //   'TEF_NUMERO_VIAS, '+
                   DevolveConteudoDelimitado('|',Tupla)+' ,'+  //   'DECIMAIS_QUANTIDADE, '+
                   DevolveConteudoDelimitado('|',Tupla)+' ,'+  //   'DECIMAIS_VALOR, '+
                   DevolveConteudoDelimitado('|',Tupla)+' ,'+  //   'BITS_POR_SEGUNDO, '+
                   DevolveConteudoDelimitado('|',Tupla)+' ,'+  //   'QTDE_MAXIMA_CARTOES, '+
                   DevolveConteudoDelimitado('|',Tupla)+' ,'+  //   'PESQUISA_PARTE, '+
                   DevolveConteudoDelimitado('|',Tupla)+' ,'+  //   'CONFIGURACAO_BALANCA, '+
                   DevolveConteudoDelimitado('|',Tupla)+' ,'+  //   'PARAMETROS_DIVERSOS, '+
                   DevolveConteudoDelimitado('|',Tupla)+' ,'+  //   'ULTIMA_EXCLUSAO, '+
                   DevolveConteudoDelimitado('|',Tupla)+' ,'+  //   'LAUDO, '+
                   DevolveConteudoDelimitado('|',Tupla)+' ,'+  //   'INDICE_GERENCIAL '+
                   DevolveConteudoDelimitado('|',Tupla)+' ,'+  //   'DATA_ATUALIZACAO_ESTOQUE '+
                   QuotedStr(DataParaTexto(Now))+' ,'+         //   'DATA_SINCRONIZACAO, '+
                   QuotedStr(TimeToStr(Now))+') ';             //   'HORA_SINCRONIZACAO)' +




    end else
    begin
      ConsultaSQL:= ' update ECF_CONFIGURACAO  set '+
      'NOME_CAIXA, '+                DevolveConteudoDelimitado('|',Tupla)+' ,'+
      'ID_GERADO_CAIXA, '+           DevolveConteudoDelimitado('|',Tupla)+' ,'+
      'ID_EMPRESA, '+                DevolveConteudoDelimitado('|',Tupla)+' ,'+
      'ID_ECF_IMPRESSORA, '+         DevolveConteudoDelimitado('|',Tupla)+' ,'+
      'ID_ECF_RESOLUCAO, '+          DevolveConteudoDelimitado('|',Tupla)+' ,'+
      'ID_ECF_CAIXA, '+              DevolveConteudoDelimitado('|',Tupla)+' ,'+
      'ID_ECF_EMPRESA, '+            DevolveConteudoDelimitado('|',Tupla)+' ,'+
      'MENSAGEM_CUPOM, '+            DevolveConteudoDelimitado('|',Tupla)+' ,'+
      'PORTA_ECF, '+                 DevolveConteudoDelimitado('|',Tupla)+' ,'+
      'IP_SERVIDOR, '+               DevolveConteudoDelimitado('|',Tupla)+' ,'+
      'IP_SITEF, '+                  DevolveConteudoDelimitado('|',Tupla)+' ,'+
      'TIPO_TEF, '+                  DevolveConteudoDelimitado('|',Tupla)+' ,'+
      'TITULO_TELA_CAIXA, '+         DevolveConteudoDelimitado('|',Tupla)+' ,'+
      'CAMINHO_IMAGENS_PRODUTOS, '+  DevolveConteudoDelimitado('|',Tupla)+' ,'+
      'CAMINHO_IMAGENS_MARKETING, '+ DevolveConteudoDelimitado('|',Tupla)+' ,'+
      'CAMINHO_IMAGENS_LAYOUT, '+    DevolveConteudoDelimitado('|',Tupla)+' ,'+
      'COR_JANELAS_INTERNAS, '+      DevolveConteudoDelimitado('|',Tupla)+' ,'+
      'MARKETING_ATIVO, '+           DevolveConteudoDelimitado('|',Tupla)+' ,'+
      'CFOP_ECF, '+                  DevolveConteudoDelimitado('|',Tupla)+' ,'+
      'CFOP_NF2, '+                  DevolveConteudoDelimitado('|',Tupla)+' ,'+
      'TIMEOUT_ECF, '+               DevolveConteudoDelimitado('|',Tupla)+' ,'+
      'INTERVALO_ECF, '+             DevolveConteudoDelimitado('|',Tupla)+' ,'+
      'DESCRICAO_SUPRIMENTO, '+      DevolveConteudoDelimitado('|',Tupla)+' ,'+
      'DESCRICAO_SANGRIA, '+         DevolveConteudoDelimitado('|',Tupla)+' ,'+
      'TEF_TIPO_GP, '+               DevolveConteudoDelimitado('|',Tupla)+' ,'+
      'TEF_TEMPO_ESPERA, '+          DevolveConteudoDelimitado('|',Tupla)+' ,'+
      'TEF_ESPERA_STS, '+            DevolveConteudoDelimitado('|',Tupla)+' ,'+
      'TEF_NUMERO_VIAS, '+           DevolveConteudoDelimitado('|',Tupla)+' ,'+
      'DECIMAIS_QUANTIDADE, '+       DevolveConteudoDelimitado('|',Tupla)+' ,'+
      'DECIMAIS_VALOR, '+            DevolveConteudoDelimitado('|',Tupla)+' ,'+
      'BITS_POR_SEGUNDO, '+          DevolveConteudoDelimitado('|',Tupla)+' ,'+
      'QTDE_MAXIMA_CARTOES, '+       DevolveConteudoDelimitado('|',Tupla)+' ,'+
      'PESQUISA_PARTE, '+            DevolveConteudoDelimitado('|',Tupla)+' ,'+
      'CONFIGURACAO_BALANCA, '+      DevolveConteudoDelimitado('|',Tupla)+' ,'+
      'PARAMETROS_DIVERSOS, '+       DevolveConteudoDelimitado('|',Tupla)+' ,'+
      'ULTIMA_EXCLUSAO, '+           DevolveConteudoDelimitado('|',Tupla)+' ,'+
      'LAUDO, '+                     DevolveConteudoDelimitado('|',Tupla)+' ,'+
      'INDICE_GERENCIAL '+           DevolveConteudoDelimitado('|',Tupla)+' ,'+
      'DATA_ATUALIZACAO_ESTOQUE '+   DevolveConteudoDelimitado('|',Tupla)+' ,'+
      'DATA_SINCRONIZACAO, '+        QuotedStr(DataParaTexto(Now))+' ,'+
      'HORA_SINCRONIZACAO)' +        QuotedStr(TimeToStr(Now))+
      ' where (ID =  ' +             IntToStr(Chave)+')';

    end;


    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.ConexaoBalcao;
      Query.sql.Text := ConsultaSQL;

      Query.ExecSQL();

    except
       TLogImportacaoController.GravaLogImportacao(LogErro);
    end;

  finally
    Query.Free;
  end;

end;



class procedure TImportaController.GravaEcfPosicaoComponentes;
var
  ConsultaSQL, Caixa, Empresa, IDCaixa: String;
  Query: TSQLQuery;
  Chave: integer;

begin
  try
    Caixa := trim(DevolveConteudoDelimitado('|',Tupla));
    Empresa := trim(DevolveConteudoDelimitado('|',Tupla));
    IDCaixa := trim(DevolveConteudoDelimitado('|',Tupla));

    Chave := ConsultaEcfResolucao(Caixa, Empresa, IDCaixa);

    if Chave = 0 then
    begin
      ConsultaSQL:= ' insert into ECF_POSICAO_COMPONENTES ('+
                 //  'ID, '+
                 'NOME_CAIXA, '+
                 'ID_GERADO_CAIXA, '+
                 'ID_EMPRESA, '+
                 'ID_ECF_RESOLUCAO, '+
                 'NOME, '+
                 'ALTURA, '+
                 'LARGURA, '+
                 'TOPO, '+
                 'ESQUERDA, '+
                 'TAMANHO_FONTE, '+
                 'TEXTO, '+
                 'DATA_SINCRONIZACAO, '+
                 'HORA_SINCRONIZACAO)'+

      ' values ( '+DevolveConteudoDelimitado('|',Tupla)+' ,'+  //  NOME_CAIXA,
                   DevolveConteudoDelimitado('|',Tupla)+' ,'+  //  ID_GERADO_CAIXA,
                   DevolveConteudoDelimitado('|',Tupla)+' ,'+  //  ID_EMPRESA,
                   DevolveConteudoDelimitado('|',Tupla)+' ,'+  //  ID_ECF_RESOLUCAO,
                   DevolveConteudoDelimitado('|',Tupla)+' ,'+  //  NOME,
                   DevolveConteudoDelimitado('|',Tupla)+' ,'+  //  ALTURA,
                   DevolveConteudoDelimitado('|',Tupla)+' ,'+  //  LARGURA,
                   DevolveConteudoDelimitado('|',Tupla)+' ,'+  //  TOPO,
                   DevolveConteudoDelimitado('|',Tupla)+' ,'+  //  ESQUERDA,
                   DevolveConteudoDelimitado('|',Tupla)+' ,'+  //  TAMANHO_FONTE,
                   DevolveConteudoDelimitado('|',Tupla)+' ,'+  //  TEXTO,
                   QuotedStr(DataParaTexto(Now))+' ,'+         //  DATA_SINCRONIZACAO,
                   QuotedStr(TimeToStr(Now))+') ';             //  HORA_SINCRONIZACAO)


    end else
    begin
      ConsultaSQL:= ' update ECF_POSICAO_COMPONENTES  set '+
      'NOME_CAIXA = '+         DevolveConteudoDelimitado('|',Tupla)+' ,'+
      'ID_GERADO_CAIXA = '+    DevolveConteudoDelimitado('|',Tupla)+' ,'+
      'ID_EMPRESA = '+         DevolveConteudoDelimitado('|',Tupla)+' ,'+
      'ID_ECF_RESOLUCAO = '+   DevolveConteudoDelimitado('|',Tupla)+' ,'+
      'NOME = '+               DevolveConteudoDelimitado('|',Tupla)+' ,'+
      'ALTURA = '+             DevolveConteudoDelimitado('|',Tupla)+' ,'+
      'LARGURA = '+            DevolveConteudoDelimitado('|',Tupla)+' ,'+
      'TOPO = '+               DevolveConteudoDelimitado('|',Tupla)+' ,'+
      'ESQUERDA = '+           DevolveConteudoDelimitado('|',Tupla)+' ,'+
      'TAMANHO_FONTE = '+      DevolveConteudoDelimitado('|',Tupla)+' ,'+
      'TEXTO = '+              DevolveConteudoDelimitado('|',Tupla)+' ,'+
      'DATA_SINCRONIZACAO = '+ QuotedStr(DataParaTexto(Now))+' ,'+
      'HORA_SINCRONIZACAO = '+ QuotedStr(TimeToStr(Now))+
      ' where (ID =  ' +       IntToStr(Chave)+')';
    end;

    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.ConexaoBalcao;
      Query.sql.Text := ConsultaSQL;

      Query.ExecSQL();

    except
       TLogImportacaoController.GravaLogImportacao(LogErro);
    end;

  finally
    Query.Free;
  end;

end;


class procedure TImportaController.GravaEcfResolucao;
var
  ConsultaSQL, Caixa, Empresa, IDCaixa: String;
  Query: TSQLQuery;
  Chave: integer;

begin
  try
    Caixa := trim(DevolveConteudoDelimitado('|',Tupla));
    Empresa := trim(DevolveConteudoDelimitado('|',Tupla));
    IDCaixa := trim(DevolveConteudoDelimitado('|',Tupla));

    Chave := ConsultaEcfResolucao(Caixa, Empresa, IDCaixa);

    if Chave = 0 then
    begin
      ConsultaSQL:= ' insert into ECF_RESOLUCAO ('+
                      //  'ID, '+
                      'NOME_CAIXA, '+
                      'ID_GERADO_CAIXA, '+
                      'ID_EMPRESA, '+
                      'RESOLUCAO_TELA, '+
                      'LARGURA, '+
                      'ALTURA, '+
                      'IMAGEM_TELA, '+
                      'IMAGEM_MENU, '+
                      'IMAGEM_SUBMENU, '+
                      'HOTTRACK_COLOR, '+
                      'ITEM_STYLE_FONT_NAME, '+
                      'ITEM_STYLE_FONT_COLOR, '+
                      'ITEM_SEL_STYLE_COLOR, '+
                      'LABEL_TOTAL_GERAL_FONT_COLOR, '+
                      'ITEM_STYLE_FONT_STYLE, '+
                      'EDITS_COLOR, '+
                      'EDITS_FONT_COLOR, '+
                      'EDITS_DISABLED_COLOR, '+
                      'EDITS_FONT_NAME, '+
                      'EDITS_FONT_STYLE, '+
                      'DATA_SINCRONIZACAO, '+
                      'HORA_SINCRONIZACAO)' +


      ' values ( '+DevolveConteudoDelimitado('|',Tupla)+' ,'+  //   NOME_CAIXA,
                   DevolveConteudoDelimitado('|',Tupla)+' ,'+  //   ID_GERADO_CAIXA,
                   DevolveConteudoDelimitado('|',Tupla)+' ,'+  //   ID_EMPRESA,
                   DevolveConteudoDelimitado('|',Tupla)+' ,'+  //   RESOLUCAO_TELA,
                   DevolveConteudoDelimitado('|',Tupla)+' ,'+  //   LARGURA,
                   DevolveConteudoDelimitado('|',Tupla)+' ,'+  //   ALTURA,
                   DevolveConteudoDelimitado('|',Tupla)+' ,'+  //   IMAGEM_TELA,
                   DevolveConteudoDelimitado('|',Tupla)+' ,'+  //   IMAGEM_MENU,
                   DevolveConteudoDelimitado('|',Tupla)+' ,'+  //   IMAGEM_SUBMENU,
                   DevolveConteudoDelimitado('|',Tupla)+' ,'+  //   HOTTRACK_COLOR,
                   DevolveConteudoDelimitado('|',Tupla)+' ,'+  //   ITEM_STYLE_FONT_NAME,
                   DevolveConteudoDelimitado('|',Tupla)+' ,'+  //   ITEM_STYLE_FONT_COLOR,
                   DevolveConteudoDelimitado('|',Tupla)+' ,'+  //   ITEM_SEL_STYLE_COLOR,
                   DevolveConteudoDelimitado('|',Tupla)+' ,'+  //   LABEL_TOTAL_GERAL_FONT_COLOR,
                   DevolveConteudoDelimitado('|',Tupla)+' ,'+  //   ITEM_STYLE_FONT_STYLE,
                   DevolveConteudoDelimitado('|',Tupla)+' ,'+  //   EDITS_COLOR,
                   DevolveConteudoDelimitado('|',Tupla)+' ,'+  //   EDITS_FONT_COLOR,
                   DevolveConteudoDelimitado('|',Tupla)+' ,'+  //   EDITS_DISABLED_COLOR,
                   DevolveConteudoDelimitado('|',Tupla)+' ,'+  //   EDITS_FONT_NAME,
                   DevolveConteudoDelimitado('|',Tupla)+' ,'+  //   EDITS_FONT_STYLE,
                   QuotedStr(DataParaTexto(Now))+' ,'+         //   DATA_SINCRONIZACAO,
                   QuotedStr(TimeToStr(Now))+') ';             //   HORA_SINCRONIZACAO)

    end else
    begin
      ConsultaSQL:= ' update ECF_RESOLUCAO  set '+
      'NOME_CAIXA =  ' +                   DevolveConteudoDelimitado('|',Tupla)+' ,'+
      'ID_GERADO_CAIXA =  ' +              DevolveConteudoDelimitado('|',Tupla)+' ,'+
      'ID_EMPRESA =  ' +                   DevolveConteudoDelimitado('|',Tupla)+' ,'+
      'RESOLUCAO_TELA =  ' +               DevolveConteudoDelimitado('|',Tupla)+' ,'+
      'LARGURA =  ' +                      DevolveConteudoDelimitado('|',Tupla)+' ,'+
      'ALTURA =  ' +                       DevolveConteudoDelimitado('|',Tupla)+' ,'+
      'IMAGEM_TELA =  ' +                  DevolveConteudoDelimitado('|',Tupla)+' ,'+
      'IMAGEM_MENU =  ' +                  DevolveConteudoDelimitado('|',Tupla)+' ,'+
      'IMAGEM_SUBMENU =  ' +               DevolveConteudoDelimitado('|',Tupla)+' ,'+
      'HOTTRACK_COLOR =  ' +               DevolveConteudoDelimitado('|',Tupla)+' ,'+
      'ITEM_STYLE_FONT_NAME =  ' +         DevolveConteudoDelimitado('|',Tupla)+' ,'+
      'ITEM_STYLE_FONT_COLOR =  ' +        DevolveConteudoDelimitado('|',Tupla)+' ,'+
      'ITEM_SEL_STYLE_COLOR =  ' +         DevolveConteudoDelimitado('|',Tupla)+' ,'+
      'LABEL_TOTAL_GERAL_FONT_COLOR =  ' + DevolveConteudoDelimitado('|',Tupla)+' ,'+
      'ITEM_STYLE_FONT_STYLE =  ' +        DevolveConteudoDelimitado('|',Tupla)+' ,'+
      'EDITS_COLOR =  ' +                  DevolveConteudoDelimitado('|',Tupla)+' ,'+
      'EDITS_FONT_COLOR =  ' +             DevolveConteudoDelimitado('|',Tupla)+' ,'+
      'EDITS_DISABLED_COLOR =  ' +         DevolveConteudoDelimitado('|',Tupla)+' ,'+
      'EDITS_FONT_NAME =  ' +              DevolveConteudoDelimitado('|',Tupla)+' ,'+
      'EDITS_FONT_STYLE =  ' +             DevolveConteudoDelimitado('|',Tupla)+' ,'+
      'DATA_SINCRONIZACAO =  ' +           QuotedStr(DataParaTexto(Now))+' ,'+
      'HORA_SINCRONIZACAO =  ' +           QuotedStr(TimeToStr(Now))+
      ' where (ID =  ' +IntToStr(Chave)+')';


    end;

    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.ConexaoBalcao;
      Query.sql.Text := ConsultaSQL;

      Query.ExecSQL();

    except
       TLogImportacaoController.GravaLogImportacao(LogErro);
    end;

  finally
    Query.Free;
  end;

end;





class procedure TImportaController.GravaEcfTotalTipoPagamento;
var
  ConsultaSQL: String;
  Query: TSQLQuery;
begin
  try
    ConsultaSQL:=
    ' insert into ECF_TOTAL_TIPO_PGTO ('+
          // 'ID, '+
          'NOME_CAIXA, '+
          'ID_GERADO_CAIXA, '+
          'ID_EMPRESA, '+
          'ID_ECF_VENDA_CABECALHO, '+
          'ID_ECF_TIPO_PAGAMENTO, '+
          'SERIE_ECF, '+
          'COO, '+
          'CCF, '+
          'GNF, '+
          'VALOR, '+
          'NSU, '+
          'ESTORNO, '+
          'REDE, '+
          'CARTAO_DC, '+
          'HASH_TRIPA, '+
          'HASH_INCREMENTO, '+
          'DATA_SINCRONIZACAO, '+
          'HORA_SINCRONIZACAO)'+
    'values ('+ DevolveConteudoDelimitado('|',Tupla)+' ,'+  //  'NOME_CAIXA                       'CAIXA 001'|
                DevolveConteudoDelimitado('|',Tupla)+' ,'+  //  'ID_GERADO_CAIXA                  42|
                DevolveConteudoDelimitado('|',Tupla)+' ,'+  //  'ID_EMPRESA                       1|
                DevolveConteudoDelimitado('|',Tupla)+' ,'+  //  'ID_ECF_VENDA_CABECALHO           46|
                DevolveConteudoDelimitado('|',Tupla)+' ,'+  //  'ID_ECF_TIPO_PAGAMENTO            1|
                DevolveConteudoDelimitado('|',Tupla)+' ,'+  //  'SERIE_ECF                        ''|
                DevolveConteudoDelimitado('|',Tupla)+' ,'+  //  'COO                              0|
                DevolveConteudoDelimitado('|',Tupla)+' ,'+  //  'CCF                              0|
                DevolveConteudoDelimitado('|',Tupla)+' ,'+  //  'GNF                              0|
                DevolveConteudoDelimitado('|',Tupla)+' ,'+  //  'VALOR                            20|
                DevolveConteudoDelimitado('|',Tupla)+' ,'+  //  'NSU                              ''|
                DevolveConteudoDelimitado('|',Tupla)+' ,'+  //  'ESTORNO                          'N'|
                DevolveConteudoDelimitado('|',Tupla)+' ,'+  //  'REDE                             ''|
                DevolveConteudoDelimitado('|',Tupla)+' ,'+  //  'CARTAO_DC                        ''|
                DevolveConteudoDelimitado('|',Tupla)+' ,'+  //  'HASH_TRIPA                       ''|
                DevolveConteudoDelimitado('|',Tupla)+' ,'+  //  'HASH_INCREMENTO                  0|
                QuotedStr(DataParaTexto(Now))+' ,'+         //  'DATA_SINCRONIZACAO
                QuotedStr(TimeToStr(Now))+')';              //  'HORA_SINCRONIZACAO


                {

                //

                TTP|
                E1X001V46C3D18102011152731T42P1|
                'CAIXA 001'|
                42|
                1|
                46|
                1|
                ''|
                0|
                0|
                0|
                20|
                ''|
                'N'|
                ''|
                ''|
                ''|
                0|

                }

    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.ConexaoBalcao;
      Query.sql.Text := ConsultaSQL;

      Query.ExecSQL();

    except
       TLogImportacaoController.GravaLogImportacao(LogErro);
    end;

  finally
    Query.Free;
  end;

end;

class procedure TImportaController.GravaEcfVendaCabecalho;
var
   ConsultaSQL: String;
   Query: TSQLQuery;
begin
  try

    ConsultaSQL:=
    ' insert into ECF_VENDA_CABECALHO ('+
        // 'ID, '+
        'NOME_CAIXA, '+
        'ID_GERADO_CAIXA, '+
        'ID_EMPRESA, '+
        'ID_CLIENTE, '+
        'ID_ECF_FUNCIONARIO, '+
        'ID_ECF_MOVIMENTO, '+
        'ID_ECF_DAV, '+
        'ID_ECF_PRE_VENDA_CABECALHO, '+
        'SERIE_ECF, '+
        'CFOP, '+
        'COO, '+
        'CCF, '+
        'DATA_VENDA, '+
        'HORA_VENDA, '+
        'VALOR_VENDA, '+
        'TAXA_DESCONTO, '+
        'DESCONTO, '+
        'TAXA_ACRESCIMO, '+
        'ACRESCIMO, '+
        'VALOR_FINAL, '+
        'VALOR_RECEBIDO, '+
        'TROCO, '+
        'VALOR_CANCELADO, '+
        'TOTAL_PRODUTOS, '+
        'TOTAL_DOCUMENTO, '+
        'BASE_ICMS, '+
        'ICMS, '+
        'ICMS_OUTRAS, '+
        'ISSQN, '+
        'PIS, '+
        'COFINS, '+
        'ACRESCIMO_ITENS, '+
        'DESCONTO_ITENS, '+
        'STATUS_VENDA, '+
        'NOME_CLIENTE, '+
        'CPF_CNPJ_CLIENTE, '+
        'CUPOM_CANCELADO, '+
        'HASH_TRIPA, '+
        'HASH_INCREMENTO, '+
        'DATA_SINCRONIZACAO, '+
        'HORA_SINCRONIZACAO)'+

    'values ('+
                DevolveConteudoDelimitado('|',Tupla)+' ,'+   //  'NOME_CAIXA
                DevolveConteudoDelimitado('|',Tupla)+' ,'+   //  'ID_GERADO_CAIXA
                DevolveConteudoDelimitado('|',Tupla)+' ,'+   //  'ID_EMPRESA
                DevolveConteudoDelimitado('|',Tupla)+' ,'+   //  'ID_CLIENTE
                DevolveConteudoDelimitado('|',Tupla)+' ,'+   //  'ID_ECF_FUNCIONARIO
                DevolveConteudoDelimitado('|',Tupla)+' ,'+   //  'ID_ECF_MOVIMENTO
                DevolveConteudoDelimitado('|',Tupla)+' ,'+   //  'ID_ECF_DAV
                DevolveConteudoDelimitado('|',Tupla)+' ,'+   //  'ID_ECF_PRE_VENDA_CABECALHO
                DevolveConteudoDelimitado('|',Tupla)+' ,'+   //  'SERIE_ECF
                DevolveConteudoDelimitado('|',Tupla)+' ,'+   //  'CFOP
                DevolveConteudoDelimitado('|',Tupla)+' ,'+   //  'COO
                DevolveConteudoDelimitado('|',Tupla)+' ,'+   //  'CCF
                DevolveConteudoDelimitado('|',Tupla)+' ,'+   //  'DATA_VENDA
                DevolveConteudoDelimitado('|',Tupla)+' ,'+   //  'HORA_VENDA
                DevolveConteudoDelimitado('|',Tupla)+' ,'+   //  'VALOR_VENDA
                DevolveConteudoDelimitado('|',Tupla)+' ,'+   //  'TAXA_DESCONTO
                DevolveConteudoDelimitado('|',Tupla)+' ,'+   //  'DESCONTO
                DevolveConteudoDelimitado('|',Tupla)+' ,'+   //  'TAXA_ACRESCIMO
                DevolveConteudoDelimitado('|',Tupla)+' ,'+   //  'ACRESCIMO
                DevolveConteudoDelimitado('|',Tupla)+' ,'+   //  'VALOR_FINAL
                DevolveConteudoDelimitado('|',Tupla)+' ,'+   //  'VALOR_RECEBIDO
                DevolveConteudoDelimitado('|',Tupla)+' ,'+   //  'TROCO
                DevolveConteudoDelimitado('|',Tupla)+' ,'+   //  'VALOR_CANCELADO
                DevolveConteudoDelimitado('|',Tupla)+' ,'+   //  'TOTAL_PRODUTOS
                DevolveConteudoDelimitado('|',Tupla)+' ,'+   //  'TOTAL_DOCUMENTO
                DevolveConteudoDelimitado('|',Tupla)+' ,'+   //  'BASE_ICMS
                DevolveConteudoDelimitado('|',Tupla)+' ,'+   //  'ICMS
                DevolveConteudoDelimitado('|',Tupla)+' ,'+   //  'ICMS_OUTRAS
                DevolveConteudoDelimitado('|',Tupla)+' ,'+   //  'ISSQN
                DevolveConteudoDelimitado('|',Tupla)+' ,'+   //  'PIS
                DevolveConteudoDelimitado('|',Tupla)+' ,'+   //  'COFINS
                DevolveConteudoDelimitado('|',Tupla)+' ,'+   //  'ACRESCIMO_ITENS
                DevolveConteudoDelimitado('|',Tupla)+' ,'+   //  'DESCONTO_ITENS
                DevolveConteudoDelimitado('|',Tupla)+' ,'+   //  'STATUS_VENDA
                DevolveConteudoDelimitado('|',Tupla)+' ,'+   //  'NOME_CLIENTE
                DevolveConteudoDelimitado('|',Tupla)+' ,'+   //  'CPF_CNPJ_CLIENTE
                DevolveConteudoDelimitado('|',Tupla)+' ,'+   //  'CUPOM_CANCELADO
                DevolveConteudoDelimitado('|',Tupla)+' ,'+   //  'HASH_TRIPA
                DevolveConteudoDelimitado('|',Tupla)+' ,'+   //  'HASH_INCREMENTO
                QuotedStr(DataParaTexto(Now))+' ,'+          //  'DATA_SINCRONIZACAO
                QuotedStr(TimeToStr(Now))+')';               //  'HORA_SINCRONIZACAO

    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.ConexaoBalcao;
      Query.sql.Text := ConsultaSQL;

      Query.ExecSQL();

    except
      TLogImportacaoController.GravaLogImportacao(LogErro);
    end;

  finally
    Query.Free;
  end;

end;

class procedure TImportaController.GravaEcfVendaDetalhe;
var
  ConsultaSQL , MovimentaEstoque : String;
  Query: TSQLQuery;
  ProdutoID :integer;
  ProdutoQtde:Extended;
begin
  try
    ProdutoID := StrToIntDef(DevolveConteudoDelimitado('|',Tupla),0);
    ProdutoQtde := StrToFloatDef(DevolveConteudoDelimitado('|',Tupla),0);
    MovimentaEstoque := DevolveConteudoDelimitado('|',Tupla);

    ConsultaSQL:=
    'insert into ECF_VENDA_DETALHE ('+
        //  'ID, '+
        'NOME_CAIXA, '+
        'ID_GERADO_CAIXA, '+
        'ID_EMPRESA, '+
        'ID_ECF_PRODUTO, '+
        'ID_ECF_VENDA_CABECALHO, '+
        'SERIE_ECF, '+
        'GTIN, '+
        'CCF, '+
        'COO, '+
        'CFOP, '+
        'ITEM, '+
        'QUANTIDADE, '+
        'VALOR_UNITARIO, '+
        'VALOR_TOTAL, '+
        'TOTAL_ITEM, '+
        'BASE_ICMS, '+
        'TAXA_ICMS, '+
        'ICMS, '+
        'TAXA_DESCONTO, '+
        'DESCONTO, '+
        'TAXA_ISSQN, '+
        'ISSQN, '+
        'TAXA_PIS, '+
        'PIS, '+
        'TAXA_COFINS, '+
        'COFINS, '+
        'TAXA_ACRESCIMO, '+
        'ACRESCIMO, '+
        'ACRESCIMO_RATEIO, '+
        'DESCONTO_RATEIO, '+
        'TOTALIZADOR_PARCIAL, '+
        'CST, '+
        'CANCELADO, '+
        'MOVIMENTA_ESTOQUE, '+
        'ECF_ICMS_ST, '+
        'HASH_TRIPA, '+
        'HASH_INCREMENTO, '+
        'DATA_SINCRONIZACAO, '+
        'HORA_SINCRONIZACAO)'+

    'values ('+ DevolveConteudoDelimitado('|',Tupla)+' ,'+   //  'NOME_CAIXA
                DevolveConteudoDelimitado('|',Tupla)+' ,'+   //  'ID_GERADO_CAIXA
                DevolveConteudoDelimitado('|',Tupla)+' ,'+   //  'ID_EMPRESA
                DevolveConteudoDelimitado('|',Tupla)+' ,'+   //  'ID_ECF_PRODUTO
                DevolveConteudoDelimitado('|',Tupla)+' ,'+   //  'ID_ECF_VENDA_CABECALHO
                DevolveConteudoDelimitado('|',Tupla)+' ,'+   //  'SERIE_ECF
                DevolveConteudoDelimitado('|',Tupla)+' ,'+   //  'GTIN
                DevolveConteudoDelimitado('|',Tupla)+' ,'+   //  'CCF
                DevolveConteudoDelimitado('|',Tupla)+' ,'+   //  'COO
                DevolveConteudoDelimitado('|',Tupla)+' ,'+   //  'CFOP
                DevolveConteudoDelimitado('|',Tupla)+' ,'+   //  'ITEM
                DevolveConteudoDelimitado('|',Tupla)+' ,'+   //  'QUANTIDADE
                DevolveConteudoDelimitado('|',Tupla)+' ,'+   //  'VALOR_UNITARIO
                DevolveConteudoDelimitado('|',Tupla)+' ,'+   //  'VALOR_TOTAL
                DevolveConteudoDelimitado('|',Tupla)+' ,'+   //  'TOTAL_ITEM
                DevolveConteudoDelimitado('|',Tupla)+' ,'+   //  'BASE_ICMS
                DevolveConteudoDelimitado('|',Tupla)+' ,'+   //  'TAXA_ICMS
                DevolveConteudoDelimitado('|',Tupla)+' ,'+   //  'ICMS
                DevolveConteudoDelimitado('|',Tupla)+' ,'+   //  'TAXA_DESCONTO
                DevolveConteudoDelimitado('|',Tupla)+' ,'+   //  'DESCONTO
                DevolveConteudoDelimitado('|',Tupla)+' ,'+   //  'TAXA_ISSQN
                DevolveConteudoDelimitado('|',Tupla)+' ,'+   //  'ISSQN
                DevolveConteudoDelimitado('|',Tupla)+' ,'+   //  'TAXA_PIS
                DevolveConteudoDelimitado('|',Tupla)+' ,'+   //  'PIS
                DevolveConteudoDelimitado('|',Tupla)+' ,'+   //  'TAXA_COFINS
                DevolveConteudoDelimitado('|',Tupla)+' ,'+   //  'COFINS
                DevolveConteudoDelimitado('|',Tupla)+' ,'+   //  'TAXA_ACRESCIMO
                DevolveConteudoDelimitado('|',Tupla)+' ,'+   //  'ACRESCIMO
                DevolveConteudoDelimitado('|',Tupla)+' ,'+   //  'ACRESCIMO_RATEIO
                DevolveConteudoDelimitado('|',Tupla)+' ,'+   //  'DESCONTO_RATEIO
                DevolveConteudoDelimitado('|',Tupla)+' ,'+   //  'TOTALIZADOR_PARCIAL
                DevolveConteudoDelimitado('|',Tupla)+' ,'+   //  'CST
                DevolveConteudoDelimitado('|',Tupla)+' ,'+   //  'CANCELADO
                DevolveConteudoDelimitado('|',Tupla)+' ,'+   //  'MOVIMENTA_ESTOQUE
                DevolveConteudoDelimitado('|',Tupla)+' ,'+   //  'ECF_ICMS_ST
                DevolveConteudoDelimitado('|',Tupla)+' ,'+   //  'HASH_TRIPA
                DevolveConteudoDelimitado('|',Tupla)+' ,'+   //  'HASH_INCREMENTO
                QuotedStr(DataParaTexto(Now))+' ,'+          //  'DATA_SINCRONIZACAO
                QuotedStr(TimeToStr(Now))+')';               //  'HORA_SINCRONIZACAO


    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.ConexaoBalcao;
      Query.sql.Text := ConsultaSQL;

      Query.ExecSQL();

      //*******************baixa estoque****************

      ProdutoComposto(ProdutoID,((-1)*ProdutoQtde));
      if MovimentaEstoque= 'S' then
        BaixaEstoque(ProdutoID,((-1)*ProdutoQtde));



    except
      TLogImportacaoController.GravaLogImportacao(LogErro);
    end;

  finally
    Query.Free;
  end;

end;





class function TImportaController.ConsultaDetalheNF2(Identifica: string): integer;
var
   ConsultaSQL: String;
   Query: TSQLQuery;
begin
   ConsultaSQL := 'select ID from NF2_DETALHE where (IDENTIFICA = :pIdentifica)';
  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.ConexaoBalcao;
      Query.sql.Text := ConsultaSQL;
      Query.ParamByName('pIdentifica').AsString := Identifica;
      Query.Open;
      if not Query.IsEmpty then
        result := query.FieldByName('ID').AsInteger
      else
        result := 0;
    except
      result := 0;
    end;
  finally
    Query.Free;
  end;

end;

class function TImportaController.ConsultaEcfConfiguracao(vCaixa, vEmpresa, vIDCaixa: String): integer;
var
   ConsultaSQL: String;
   Query: TSQLQuery;
begin
  ConsultaSQL := 'select ID from ECF_CONFIGURACAO  where ('+
                 'NOME_CAIXA = '+QuotedStr(vCaixa)+') and ('+
                 'ID_GERADO_CAIXA = '+QuotedStr(vIDCaixa)+') and ('+
                 'ID_EMPRESA = '+QuotedStr(vEmpresa)+')';

  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.ConexaoBalcao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      if not Query.IsEmpty then
        result := query.FieldByName('ID').AsInteger
      else
        result := 0;
    except
      result := 0;
    end;
  finally
    Query.Free;
  end;
end;


class function TImportaController.ConsultaEcfPosicaoComponentes(vCaixa,vEmpresa, vIDCaixa: String): integer;
var
   ConsultaSQL: String;
   Query: TSQLQuery;
begin
  ConsultaSQL := 'select ID from ECF_POSICAO_COMPONENTES where ('+
                 'NOME_CAIXA = '+QuotedStr(vCaixa)+') and ('+
                 'ID_GERADO_CAIXA = '+QuotedStr(vIDCaixa)+') and ('+
                 'ID_EMPRESA = '+QuotedStr(vEmpresa)+')';

  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.ConexaoBalcao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      if not Query.IsEmpty then
        result := query.FieldByName('ID').AsInteger
      else
        result := 0;
    except
      result := 0;
    end;
  finally
    Query.Free;
  end;
end;

class function TImportaController.ConsultaEcfResolucao(vCaixa, vEmpresa, vIDCaixa: String):integer;
var
   ConsultaSQL: String;
   Query: TSQLQuery;
begin
  ConsultaSQL := 'select ID from ECF_RESOLUCAO where ('+
                 'NOME_CAIXA = '+QuotedStr(vCaixa)+') and ('+
                 'ID_GERADO_CAIXA = '+QuotedStr(vIDCaixa)+') and ('+
                 'ID_EMPRESA = '+QuotedStr(vEmpresa)+')';

  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.ConexaoBalcao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      if not Query.IsEmpty then
        result := query.FieldByName('ID').AsInteger
      else
        result := 0;
    except
      result := 0;
    end;
  finally
    Query.Free;
  end;

end;

class function TImportaController.ConsultaIntegracaoPDV(Identifica: string): boolean;
var
   ConsultaSQL: String;
   Query: TSQLQuery;
begin
  ConsultaSQL := 'select ID from INTEGRACAO_PDV where (IDENTIFICA = :pIdentifica)';
  try
    Query := TSQLQuery.Create(nil);
    try
      Query.SQLConnection := FDataModule.ConexaoBalcao;
      Query.sql.Text := ConsultaSQL;
      Query.ParamByName('pIdentifica').AsString := Identifica;
      Query.Open;
      if not Query.IsEmpty then
        result := True
      else
        result := False;
    except
      TLogImportacaoController.GravaLogImportacao(LogErro);
    end;
  finally
    Query.Free;
  end;

end;

class function TImportaController.ConsultaCabecalhoNF2(vCaixa, vEmpresa, vIDCaixa: String):integer;
var
   ConsultaSQL: String;
   Query: TSQLQuery;
begin
  ConsultaSQL := 'select ID_GERADO_CAIXA from NOTA_FISCAL_CABECALHO  where ('+
                 'NOME_CAIXA = '+QuotedStr(vCaixa)+') and ('+
                 'NUMERO = '+QuotedStr(vIDCaixa)+') and ('+
                 'ID_EMPRESA = '+QuotedStr(vEmpresa)+')';

  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.ConexaoBalcao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      if not Query.IsEmpty then
        result := query.FieldByName('ID_GERADO_CAIXA').AsInteger
      else
        result := 0;
    except
      result := 0;
    end;
  finally
    Query.Free;
  end;
end;




class procedure TImportaController.GravaIntegracaoPDV(Identifica: string);
var
   ConsultaSQL: String;
   Query: TSQLQuery;
begin
  ConsultaSQL := 'insert into INTEGRACAO_PDV (IDENTIFICA, DATA_INTEGRACAO, HORA_INTEGRACAO) values (:pIDENTIFICA, :pDATA_INTEGRACAO, :pHORA_INTEGRACAO)';

  try
    Query := TSQLQuery.Create(nil);
    try

      Query.SQLConnection := FDataModule.ConexaoBalcao;
      Query.sql.Text := ConsultaSQL;
      Query.ParamByName('pIDENTIFICA').AsString := Identifica;
      Query.ParamByName('pDATA_INTEGRACAO').AsDate := Now;
      Query.ParamByName('pHORA_INTEGRACAO').AsString := TimeToStr(Now);
      Query.ExecSQL();

    except
      TLogImportacaoController.GravaLogImportacao(LogErro);
    end;
  finally
    Query.Free;
  end;

end;

class procedure TImportaController.DeletaNotaFiscalCabecalhoDetalhe(vCaixa, vEmpresa, vIDCaixa, vIdCAB: String);
var
   ConsultaSQL: String;
   Query: TSQLQuery;
begin
  ConsultaSQL := 'delete from NF2_DETALHE where ('+
                 ' ID_NF_CABECALHO ='+QuotedStr(vIdCAB)+
                 ' ID_EMPRESA ='+QuotedStr(vEmpresa)+
                 ' NOME_CAIXA ='+QuotedStr(vCaixa);
  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.ConexaoBalcao;
      Query.sql.Text := ConsultaSQL;
      Query.ExecSQL();
    except
      //
    end;
  finally
    Query.Free;
  end;

  ConsultaSQL := 'delete from NF2_CABECALHO where ('+
                 ' ID_GERADO_CAIXA ='+QuotedStr(vIdCAB)+
                 ' ID_EMPRESA ='+QuotedStr(vEmpresa)+
                 ' NOME_CAIXA ='+QuotedStr(vCaixa)+')';
  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.ConexaoBalcao;
      Query.sql.Text := ConsultaSQL;
      Query.ExecSQL();
    except
      //
    end;
  finally
    Query.Free;
  end;


end;

class procedure TImportaController.ProdutoComposto(IdProduto: integer; Qtde: Extended);
var
   ConsultaSQL: String;
   Query: TSQLQuery;
begin

  ConsultaSQL := 'select * from FICHA_TECNICA where ID_PRODUTO = '+IntToStr(IdProduto);
  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.ConexaoBalcao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      if not Query.IsEmpty then
      begin
        Query.First;
        while not Query.eof do
        begin
          BaixaEstoque(Query.FieldByName('ID_PRODUTO_FILHO').AsInteger, (Qtde*(Query.FieldByName('QUANTIDADE').AsFloat)));
          Application.ProcessMessages;
          Query.Next;
        end;
      end;

    except
      TLogImportacaoController.GravaLogImportacao(LogErro);
    end;
  finally
    Query.Free;
  end;

end;

end.

