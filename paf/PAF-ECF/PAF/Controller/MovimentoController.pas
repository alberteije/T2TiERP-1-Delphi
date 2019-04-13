{*******************************************************************************
Title: T2Ti ERP
Description: Classe de controle do movimento.

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
unit MovimentoController;

interface

uses
  Classes, SQLExpr, SysUtils, MovimentoVO, SuprimentoVO, SangriaVO,Forms;

type
  TMovimentoController = class
  protected
  public
    class function IniciaMovimento(pMovimento: TMovimentoVO): TMovimentoVO;
    class procedure EncerraMovimento(pMovimento: TMovimentoVO);
    class procedure SaidaTemporaria(pMovimento: TMovimentoVO);
    class procedure RetornoOperador(pMovimento: TMovimentoVO);
    class function VerificaMovimento: TMovimentoVO; overload;
    class function VerificaMovimento(Id: Integer): TMovimentoVO; overload;
    class function VerificaMovimento(Id: Integer; StatusMovimento: String): TMovimentoVO; overload;
    class function Suprimento(pSuprimento: TSuprimentoVO): Boolean;
    class function Sangria(pSangria: TSangriaVO): Boolean;
    class function PrimeiroMovimento(Data: TDateTime): Boolean;
    class procedure IntegracaoSangria(ID, IdMovimento: integer; DataSangria:string;Valor:Extended);
    class procedure IntegracaoSuprimento(ID, IdMovimento: Integer; DataSuprimento: String; Valor: Extended);
    class procedure IntegracaoMovimento(ID: Integer; Movimento: TMovimentoVO);
  end;

implementation

uses UDataModule, UCaixa, Biblioteca;

var
  ConsultaSQL: String;
  Query: TSQLQuery;

class function TMovimentoController.IniciaMovimento(pMovimento: TMovimentoVO): TMovimentoVO;
begin
  ConsultaSQL :=
    'insert into ECF_MOVIMENTO ('+
    'ID_ECF_EMPRESA,'+
    'ID_ECF_TURNO,'+
    'ID_ECF_IMPRESSORA,'+
    'ID_ECF_OPERADOR,'+
    'ID_ECF_CAIXA,'+
    'ID_GERENTE_SUPERVISOR,'+
    'DATA_ABERTURA,'+
    'HORA_ABERTURA,'+
    'TOTAL_SUPRIMENTO,'+
    'STATUS_MOVIMENTO,'+
    'SINCRONIZADO) values ('+
    ':pEmpresa,'+
    ':pTurno,'+
    ':pImpressora,'+
    ':pOperador,'+
    ':pCaixa,'+
    ':pGerenteSupervisor,'+
    ':pDataAbertura,'+
    ':pHoraAbertura,'+
    ':pTotalSuprimento,'+
    ':pStatus,'+
    ':pSincronizado)';

  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.ParamByName('pTurno').AsInteger := pMovimento.IdTurno;
      Query.ParamByName('pImpressora').AsInteger := pMovimento.IdImpressora;
      Query.ParamByName('pOperador').AsInteger := pMovimento.IdOperador;
      Query.ParamByName('pCaixa').AsInteger := pMovimento.IdCaixa;
      Query.ParamByName('pEmpresa').AsInteger := pMovimento.IdEmpresa;
      Query.ParamByName('pGerenteSupervisor').AsInteger := pMovimento.IdGerenteSupervisor;
      Query.ParamByName('pDataAbertura').AsString := pMovimento.DataAbertura;
      Query.ParamByName('pHoraAbertura').AsString := pMovimento.HoraAbertura;
      Query.ParamByName('pTotalSuprimento').AsFloat := pMovimento.TotalSuprimento;
      Query.ParamByName('pStatus').AsString := pMovimento.Status;
      Query.ParamByName('pSincronizado').AsString := pMovimento.Sincronizado;
      Query.ExecSQL();

      Query.Close;
      Query.SQL.Clear;
      ConsultaSQL := 'select max(ID) as ID from ECF_MOVIMENTO';
      Query.sql.Text := ConsultaSQL;
      Query.Open();

      IntegracaoMovimento(Query.FieldByName('ID').AsInteger, pMovimento);

      result := VerificaMovimento;
    except
      result := nil;
    end;
  finally
  end;
end;

class procedure TMovimentoController.EncerraMovimento(pMovimento: TMovimentoVO);
begin
  ConsultaSQL :=
    'update ECF_MOVIMENTO set ' +
    'DATA_FECHAMENTO = :pDataFechamento,' +
    'HORA_FECHAMENTO = :pHoraFechamento,' +
    'TOTAL_SUPRIMENTO = :pTotalSuprimento,' +
    'TOTAL_SANGRIA = :pTotalSangria,' +
    'TOTAL_NAO_FISCAL = :pTotalNaoFiscal,' +
    'TOTAL_VENDA = :pTotalVenda,' +
    'TOTAL_DESCONTO = :pTotalDesconto,' +
    'TOTAL_ACRESCIMO = :pTotalAcrescimo,' +
    'TOTAL_FINAL = :pTotalFinal,' +
    'TOTAL_RECEBIDO = :pTotalRecebido,' +
    'TOTAL_TROCO = :pTotalTroco,' +
    'TOTAL_CANCELADO = :pTotalCancelado,' +
    'STATUS_MOVIMENTO = :Status ' +
    ' where ID = :pId';

  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;

      //total de suprimentos
      Query.sql.Text := 'select sum(VALOR) as TOTAL from ECF_SUPRIMENTO where ID_ECF_MOVIMENTO='+IntToStr(pMovimento.Id);
      Query.Open;
      pMovimento.TotalSuprimento := Query.FieldByName('TOTAL').AsFloat;

      //total de sangrias
      Query.sql.Text := 'select sum(VALOR) as TOTAL from ECF_SANGRIA where ID_ECF_MOVIMENTO='+IntToStr(pMovimento.Id);
      Query.Open();
      pMovimento.TotalSangria := Query.FieldByName('TOTAL').AsFloat;

      //total de recebimentos nao fiscais
      Query.sql.Text := 'select sum(VALOR) as TOTAL from ECF_RECEBIMENTO_NAO_FISCAL where ID_ECF_MOVIMENTO='+IntToStr(pMovimento.Id);
      Query.Open();
      pMovimento.TotalNaoFiscal := Query.FieldByName('TOTAL').AsFloat;

      //totais das vendas
      Query.sql.Text :=
                        'select sum(VALOR_VENDA) as VALOR_VENDA, sum(DESCONTO) as DESCONTO, ' +
                        ' sum(ACRESCIMO) as ACRESCIMO, sum(VALOR_FINAL) as VALOR_FINAL, ' +
                        ' sum(VALOR_RECEBIDO) as VALOR_RECEBIDO, sum(TROCO) as TROCO, ' +
                        ' sum(VALOR_CANCELADO) as  VALOR_CANCELADO ' +
                        'from ECF_VENDA_CABECALHO ' +
                        'where ID_ECF_MOVIMENTO='+IntToStr(pMovimento.Id);
      Query.Open();
      pMovimento.TotalVenda := Query.FieldByName('VALOR_VENDA').AsFloat;
      pMovimento.TotalDesconto := Query.FieldByName('DESCONTO').AsFloat;
      pMovimento.TotalAcrescimo := Query.FieldByName('ACRESCIMO').AsFloat;
      pMovimento.TotalFinal := Query.FieldByName('VALOR_FINAL').AsFloat + pMovimento.TotalSuprimento - pMovimento.TotalSangria;
      pMovimento.TotalRecebido := Query.FieldByName('VALOR_RECEBIDO').AsFloat;
      pMovimento.TotalTroco := Query.FieldByName('TROCO').AsFloat;
      pMovimento.TotalCancelado := Query.FieldByName('VALOR_CANCELADO').AsFloat;

      Query.sql.Text := ConsultaSQL;
      Query.ParamByName('pId').AsInteger := pMovimento.Id;
      Query.ParamByName('pDataFechamento').AsString := pMovimento.DataFechamento;
      Query.ParamByName('pHoraFechamento').AsString := pMovimento.HoraFechamento;
      Query.ParamByName('pTotalSuprimento').AsFloat := pMovimento.TotalSuprimento;
      Query.ParamByName('pTotalSangria').AsFloat := pMovimento.TotalSangria;
      Query.ParamByName('pTotalNaoFiscal').AsFloat := pMovimento.TotalNaoFiscal;
      Query.ParamByName('pTotalVenda').AsFloat := pMovimento.TotalVenda;
      Query.ParamByName('pTotalDesconto').AsFloat := pMovimento.TotalDesconto;
      Query.ParamByName('pTotalAcrescimo').AsFloat := pMovimento.TotalAcrescimo;
      Query.ParamByName('pTotalFinal').AsFloat := pMovimento.TotalFinal;
      Query.ParamByName('pTotalRecebido').AsFloat := pMovimento.TotalRecebido;
      Query.ParamByName('pTotalTroco').AsFloat := pMovimento.TotalTroco;
      Query.ParamByName('pTotalCancelado').AsFloat := pMovimento.TotalCancelado;
      Query.ParamByName('Status').AsString := pMovimento.Status;
      Query.ExecSQL();

      IntegracaoMovimento(pMovimento.Id, pMovimento);
    except
    end;
  finally
    Application.ProcessMessages;
    Query.Free;
  end;
end;

class procedure TMovimentoController.SaidaTemporaria(pMovimento: TMovimentoVO);
begin
  ConsultaSQL :=
    'update ECF_MOVIMENTO set STATUS_MOVIMENTO=' + QuotedStr('T') +
    ' where ID = :pId';

  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.ParamByName('pId').AsInteger := pMovimento.Id;
      Query.ExecSQL();
    except
    end;
  finally
    Query.Free;
  end;
end;

class procedure TMovimentoController.RetornoOperador(pMovimento: TMovimentoVO);
begin
  ConsultaSQL :=
    'update ECF_MOVIMENTO set STATUS_MOVIMENTO=' + QuotedStr('A') +
    ' where ID = :pId';
  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.ParamByName('pId').AsInteger := pMovimento.Id;
      Query.ExecSQL();
    except
    end;
  finally
    Query.Free;
  end;
end;

class function TMovimentoController.VerificaMovimento: TMovimentoVO;
var
  Movimento: TMovimentoVO;
begin
  ConsultaSQL :=  'select ' +
                  ' M.ID as MID, ' +
                  ' M.ID_GERENTE_SUPERVISOR, ' +
                  ' M.DATA_ABERTURA, ' +
                  ' M.HORA_ABERTURA, ' +
                  ' M.DATA_FECHAMENTO, ' +
                  ' M.HORA_FECHAMENTO, ' +
                  ' M.TOTAL_SUPRIMENTO, ' +
                  ' M.TOTAL_SANGRIA, ' +
                  ' M.TOTAL_NAO_FISCAL, ' +
                  ' M.TOTAL_VENDA, ' +
                  ' M.TOTAL_DESCONTO, ' +
                  ' M.TOTAL_ACRESCIMO, ' +
                  ' M.TOTAL_FINAL, ' +
                  ' M.TOTAL_RECEBIDO, ' +
                  ' M.TOTAL_TROCO, ' +
                  ' M.TOTAL_CANCELADO, ' +
                  ' M.STATUS_MOVIMENTO, ' +
                  ' T.ID as TID, ' +
                  ' T.DESCRICAO, ' +
                  ' C.ID as CID, ' +
                  ' C.NOME, ' +
                  ' O.ID as OID, ' +
                  ' O.LOGIN, ' +
                  ' I.ID as IID, ' +
                  ' I.IDENTIFICACAO ' +
                  'from ' +
                  ' ECF_MOVIMENTO M, ECF_TURNO T, ECF_CAIXA C, ECF_OPERADOR O, ECF_IMPRESSORA I ' +
                  'where ' +
                  ' M.ID_ECF_TURNO = T.ID AND ' +
                  ' M.ID_ECF_IMPRESSORA = I.ID AND ' +
                  ' M.ID_ECF_OPERADOR = O.ID AND ' +
                  ' M.ID_ECF_CAIXA = C.ID AND' +
                  ' (STATUS_MOVIMENTO=' + QuotedStr('A') + ' or STATUS_MOVIMENTO=' + QuotedStr('T') + ')';
  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;

      Movimento := TMovimentoVO.Create;
      Movimento.Id := Query.FieldByName('MID').AsInteger;
      Movimento.IdGerenteSupervisor := Query.FieldByName('ID_GERENTE_SUPERVISOR').AsInteger;
      Movimento.DataAbertura := Query.FieldByName('DATA_ABERTURA').AsString;
      Movimento.HoraAbertura := Query.FieldByName('HORA_ABERTURA').AsString;
      Movimento.DataFechamento := Query.FieldByName('DATA_FECHAMENTO').AsString;
      Movimento.HoraFechamento := Query.FieldByName('HORA_FECHAMENTO').AsString;
      Movimento.TotalSuprimento := Query.FieldByName('TOTAL_SUPRIMENTO').AsFloat;
      Movimento.TotalSangria := Query.FieldByName('TOTAL_SANGRIA').AsFloat;
      Movimento.TotalNaoFiscal := Query.FieldByName('TOTAL_NAO_FISCAL').AsFloat;
      Movimento.TotalVenda := Query.FieldByName('TOTAL_VENDA').AsFloat;
      Movimento.TotalDesconto := Query.FieldByName('TOTAL_DESCONTO').AsFloat;
      Movimento.TotalAcrescimo := Query.FieldByName('TOTAL_ACRESCIMO').AsFloat;
      Movimento.TotalFinal := Query.FieldByName('TOTAL_FINAL').AsFloat;
      Movimento.TotalRecebido := Query.FieldByName('TOTAL_RECEBIDO').AsFloat;
      Movimento.TotalTroco := Query.FieldByName('TOTAL_TROCO').AsFloat;
      Movimento.TotalCancelado := Query.FieldByName('TOTAL_CANCELADO').AsFloat;
      Movimento.Status := Query.FieldByName('STATUS_MOVIMENTO').AsString;
      Movimento.IdTurno := Query.FieldByName('TID').AsInteger;
      Movimento.DescricaoTurno := Query.FieldByName('DESCRICAO').AsString;
      Movimento.IdCaixa := Query.FieldByName('CID').AsInteger;
      Movimento.NomeCaixa := Query.FieldByName('NOME').AsString;
      Movimento.IdOperador := Query.FieldByName('OID').AsInteger;
      Movimento.LoginOperador := Query.FieldByName('LOGIN').AsString;
      Movimento.IdImpressora := Query.FieldByName('IID').AsInteger;
      Movimento.IdentificacaoImpressora := Query.FieldByName('IDENTIFICACAO').AsString;

      result := Movimento;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;


class function TMovimentoController.VerificaMovimento(Id: Integer): TMovimentoVO;
var
  Movimento: TMovimentoVO;
begin
  ConsultaSQL :=  'select ' +
                  ' M.ID as MID, ' +
                  ' M.ID_GERENTE_SUPERVISOR, ' +
                  ' M.DATA_ABERTURA, ' +
                  ' M.HORA_ABERTURA, ' +
                  ' M.DATA_FECHAMENTO, ' +
                  ' M.HORA_FECHAMENTO, ' +
                  ' M.TOTAL_SUPRIMENTO, ' +
                  ' M.TOTAL_SANGRIA, ' +
                  ' M.TOTAL_NAO_FISCAL, ' +
                  ' M.TOTAL_VENDA, ' +
                  ' M.TOTAL_DESCONTO, ' +
                  ' M.TOTAL_ACRESCIMO, ' +
                  ' M.TOTAL_FINAL, ' +
                  ' M.TOTAL_RECEBIDO, ' +
                  ' M.TOTAL_TROCO, ' +
                  ' M.TOTAL_CANCELADO, ' +
                  ' M.STATUS_MOVIMENTO, ' +
                  ' T.ID as TID, ' +
                  ' T.DESCRICAO, ' +
                  ' C.ID as CID, ' +
                  ' C.NOME, ' +
                  ' O.ID as OID, ' +
                  ' O.LOGIN, ' +
                  ' I.ID as IID, ' +
                  ' I.IDENTIFICACAO ' +
                  'from ' +
                  ' ECF_MOVIMENTO M, ECF_TURNO T, ECF_CAIXA C, ECF_OPERADOR O, ECF_IMPRESSORA I ' +
                  'where ' +
                  ' M.ID = '+IntToStr(Id)+' AND ' +
                  ' M.ID_ECF_TURNO = T.ID AND ' +
                  ' M.ID_ECF_IMPRESSORA = I.ID AND ' +
                  ' M.ID_ECF_OPERADOR = O.ID AND ' +
                  ' M.ID_ECF_CAIXA = C.ID AND' +
                  ' (STATUS_MOVIMENTO=' + QuotedStr('F') + ')';

  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;

      Movimento := TMovimentoVO.Create;
      Movimento.Id := Query.FieldByName('MID').AsInteger;
      Movimento.IdGerenteSupervisor := Query.FieldByName('ID_GERENTE_SUPERVISOR').AsInteger;
      Movimento.DataAbertura := Query.FieldByName('DATA_ABERTURA').AsString;
      Movimento.HoraAbertura := Query.FieldByName('HORA_ABERTURA').AsString;
      Movimento.DataFechamento := Query.FieldByName('DATA_FECHAMENTO').AsString;
      Movimento.HoraFechamento := Query.FieldByName('HORA_FECHAMENTO').AsString;
      Movimento.TotalSuprimento := Query.FieldByName('TOTAL_SUPRIMENTO').AsFloat;
      Movimento.TotalSangria := Query.FieldByName('TOTAL_SANGRIA').AsFloat;
      Movimento.TotalNaoFiscal := Query.FieldByName('TOTAL_NAO_FISCAL').AsFloat;
      Movimento.TotalVenda := Query.FieldByName('TOTAL_VENDA').AsFloat;
      Movimento.TotalDesconto := Query.FieldByName('TOTAL_DESCONTO').AsFloat;
      Movimento.TotalAcrescimo := Query.FieldByName('TOTAL_ACRESCIMO').AsFloat;
      Movimento.TotalFinal := Query.FieldByName('TOTAL_FINAL').AsFloat;
      Movimento.TotalRecebido := Query.FieldByName('TOTAL_RECEBIDO').AsFloat;
      Movimento.TotalTroco := Query.FieldByName('TOTAL_TROCO').AsFloat;
      Movimento.TotalCancelado := Query.FieldByName('TOTAL_CANCELADO').AsFloat;
      Movimento.Status := Query.FieldByName('STATUS_MOVIMENTO').AsString;
      Movimento.IdTurno := Query.FieldByName('TID').AsInteger;
      Movimento.DescricaoTurno := Query.FieldByName('DESCRICAO').AsString;
      Movimento.IdCaixa := Query.FieldByName('CID').AsInteger;
      Movimento.NomeCaixa := Query.FieldByName('NOME').AsString;
      Movimento.IdOperador := Query.FieldByName('OID').AsInteger;
      Movimento.LoginOperador := Query.FieldByName('LOGIN').AsString;
      Movimento.IdImpressora := Query.FieldByName('IID').AsInteger;
      Movimento.IdentificacaoImpressora := Query.FieldByName('IDENTIFICACAO').AsString;

      result := Movimento;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;

class function TMovimentoController.VerificaMovimento(Id: Integer; StatusMovimento: String): TMovimentoVO;
var
  Movimento: TMovimentoVO;
begin
  ConsultaSQL :=  'select ' +
                  ' M.ID as MID, ' +
                  ' M.ID_GERENTE_SUPERVISOR, ' +
                  ' M.DATA_ABERTURA, ' +
                  ' M.HORA_ABERTURA, ' +
                  ' M.DATA_FECHAMENTO, ' +
                  ' M.HORA_FECHAMENTO, ' +
                  ' M.TOTAL_SUPRIMENTO, ' +
                  ' M.TOTAL_SANGRIA, ' +
                  ' M.TOTAL_NAO_FISCAL, ' +
                  ' M.TOTAL_VENDA, ' +
                  ' M.TOTAL_DESCONTO, ' +
                  ' M.TOTAL_ACRESCIMO, ' +
                  ' M.TOTAL_FINAL, ' +
                  ' M.TOTAL_RECEBIDO, ' +
                  ' M.TOTAL_TROCO, ' +
                  ' M.TOTAL_CANCELADO, ' +
                  ' M.STATUS_MOVIMENTO, ' +
                  ' T.ID as TID, ' +
                  ' T.DESCRICAO, ' +
                  ' C.ID as CID, ' +
                  ' C.NOME, ' +
                  ' O.ID as OID, ' +
                  ' O.LOGIN, ' +
                  ' I.ID as IID, ' +
                  ' I.IDENTIFICACAO ' +
                  'from ' +
                  ' ECF_MOVIMENTO M, ECF_TURNO T, ECF_CAIXA C, ECF_OPERADOR O, ECF_IMPRESSORA I ' +
                  'where ' +
                  ' M.ID = '+IntToStr(Id)+' AND ' +
                  ' M.ID_ECF_TURNO = T.ID AND ' +
                  ' M.ID_ECF_IMPRESSORA = I.ID AND ' +
                  ' M.ID_ECF_OPERADOR = O.ID AND ' +
                  ' M.ID_ECF_CAIXA = C.ID AND' +
                  ' (STATUS_MOVIMENTO=' + QuotedStr(StatusMovimento) + ')';

  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;

      Movimento := TMovimentoVO.Create;
      Movimento.Id := Query.FieldByName('MID').AsInteger;
      Movimento.IdGerenteSupervisor := Query.FieldByName('ID_GERENTE_SUPERVISOR').AsInteger;
      Movimento.DataAbertura := Query.FieldByName('DATA_ABERTURA').AsString;
      Movimento.HoraAbertura := Query.FieldByName('HORA_ABERTURA').AsString;
      Movimento.DataFechamento := Query.FieldByName('DATA_FECHAMENTO').AsString;
      Movimento.HoraFechamento := Query.FieldByName('HORA_FECHAMENTO').AsString;
      Movimento.TotalSuprimento := Query.FieldByName('TOTAL_SUPRIMENTO').AsFloat;
      Movimento.TotalSangria := Query.FieldByName('TOTAL_SANGRIA').AsFloat;
      Movimento.TotalNaoFiscal := Query.FieldByName('TOTAL_NAO_FISCAL').AsFloat;
      Movimento.TotalVenda := Query.FieldByName('TOTAL_VENDA').AsFloat;
      Movimento.TotalDesconto := Query.FieldByName('TOTAL_DESCONTO').AsFloat;
      Movimento.TotalAcrescimo := Query.FieldByName('TOTAL_ACRESCIMO').AsFloat;
      Movimento.TotalFinal := Query.FieldByName('TOTAL_FINAL').AsFloat;
      Movimento.TotalRecebido := Query.FieldByName('TOTAL_RECEBIDO').AsFloat;
      Movimento.TotalTroco := Query.FieldByName('TOTAL_TROCO').AsFloat;
      Movimento.TotalCancelado := Query.FieldByName('TOTAL_CANCELADO').AsFloat;
      Movimento.Status := Query.FieldByName('STATUS_MOVIMENTO').AsString;
      Movimento.IdTurno := Query.FieldByName('TID').AsInteger;
      Movimento.DescricaoTurno := Query.FieldByName('DESCRICAO').AsString;
      Movimento.IdCaixa := Query.FieldByName('CID').AsInteger;
      Movimento.NomeCaixa := Query.FieldByName('NOME').AsString;
      Movimento.IdOperador := Query.FieldByName('OID').AsInteger;
      Movimento.LoginOperador := Query.FieldByName('LOGIN').AsString;
      Movimento.IdImpressora := Query.FieldByName('IID').AsInteger;
      Movimento.IdentificacaoImpressora := Query.FieldByName('IDENTIFICACAO').AsString;

      result := Movimento;
    except
        result := nil;
    end;
  finally
    Query.Free;
  end;
end;

class function TMovimentoController.Suprimento(pSuprimento: TSuprimentoVO): Boolean;
begin
  ConsultaSQL :=
  'insert into ECF_SUPRIMENTO (ID_ECF_MOVIMENTO,DATA_SUPRIMENTO,VALOR)' +
  ' values (:pIdMovimento,:pDataSuprimento,:pValor)';

  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.ParamByName('pIdMovimento').AsInteger := pSuprimento.IdMovimento;
      Query.ParamByName('pDataSuprimento').AsString := pSuprimento.DataSuprimento;
      Query.ParamByName('pValor').AsFloat := pSuprimento.Valor;
      Query.ExecSQL();

      Query.Close;
      Query.SQL.Clear;
      ConsultaSQL := 'select max(ID) as ID from ECF_SUPRIMENTO';
      Query.sql.Text := ConsultaSQL;
      Query.Open();

      IntegracaoSuprimento(Query.FieldByName('ID').AsInteger, pSuprimento.IdMovimento, pSuprimento.DataSuprimento, pSuprimento.Valor);

      result := true;
    except
      result := false;
    end;
  finally
    Query.Free;
  end;
end;

class function TMovimentoController.Sangria(pSangria: TSangriaVO): Boolean;
begin
  ConsultaSQL :=
  'insert into ECF_SANGRIA (ID_ECF_MOVIMENTO,DATA_SANGRIA,VALOR)' +
  ' values (:pIdMovimento,:pDataSangria,:pValor)';

  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.ParamByName('pIdMovimento').AsInteger := pSangria.IdMovimento;
      Query.ParamByName('pDataSangria').AsString := pSangria.DataSangria;
      Query.ParamByName('pValor').AsFloat := pSangria.Valor;
      Query.ExecSQL();

      ConsultaSQL := 'select max(ID) as ID from ECF_SANGRIA';
      Query.sql.Text := ConsultaSQL;
      Query.Open();

      IntegracaoSangria(Query.FieldByName('ID').AsInteger, pSangria.IdMovimento,pSangria.DataSangria,pSangria.Valor);

      result := true;
    except
      result := false;
    end;
  finally
    Query.Free;
  end;
end;

class function TMovimentoController.PrimeiroMovimento(Data: TDateTime): Boolean;
begin
  ConsultaSQL :=
  'select Count(ID) as Total ' +
  ' from ECF_MOVIMENTO where DATA_ABERTURA = :pDataAbertura';

  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.ParamByName('pDataAbertura').AsDateTime := Data;
      Query.Open;

      if Query.FieldByName('Total').AsInteger = 0 then
         result := True
      else
         result := False;
    except
      result := false;
    end;
  finally
    Query.Free;
  end;
end;

class procedure TMovimentoController.IntegracaoSangria(ID, IdMovimento: Integer; DataSangria: String; Valor: Extended);
var
  PathSangria, Identificacao, Caixa: string;
  atSangria: TextFile;
begin
  Caixa := Configuracao.NomeCaixa;
  Identificacao:='E'+IntToStr(Configuracao.IdEmpresa)+'X'+DevolveInteiro(caixa)+'S'+IntToStr(ID)+'M'+IntToStr(IdMovimento)+'D'+DevolveInteiro(DateTimeToStr(now));
  PathSangria := ExtractFilePath(Application.ExeName)+'Script\Sangria.txt';
  AssignFile(atSangria,PathSangria);
  Application.ProcessMessages;

  if FileExists(PathSangria) then
    Append(atSangria)
  else
    Rewrite(atSangria);

  Write(
    atSangria,'SANGRIA|'+
    Identificacao+
    Caixa+'|'+
    IntToStr(ID)+'|'+
    IntToStr(IdMovimento)+'|'+
    DataSangria+'|'+
    FloatToStr(Valor)+'|'
  );
  Writeln(atSangria);
  Application.ProcessMessages;
  CloseFile(atSangria);
end;

class procedure TMovimentoController.IntegracaoSuprimento(ID,IdMovimento: Integer; DataSuprimento: String; Valor: Extended);
var
  PathSuprimento, Identificacao, Caixa: string;
  atSuprimento: TextFile;
begin
  caixa := Configuracao.NomeCaixa;
  Identificacao:='E'+IntToStr(Configuracao.IdEmpresa)+'X'+DevolveInteiro(caixa)+'S'+IntToStr(ID)+'M'+IntToStr(IdMovimento)+'D'+DevolveInteiro(DateTimeToStr(now));

  PathSuprimento := ExtractFilePath(Application.ExeName)+'Script\Suprimento.txt';
  AssignFile(atSuprimento,PathSuprimento);
  Application.ProcessMessages;

  if FileExists(PathSuprimento) then
    Append(atSuprimento)
  else
    Rewrite(atSuprimento);

  Write(
    atSuprimento,'SUPRIMENTO|'+
    Identificacao+'|'+
    Caixa+'|'+
    IntToStr(ID)+'|'+
    IntToStr(IdMovimento)+'|'+
    DataSuprimento+'|'+
    FloatToStr(Valor)+'|'
  );
  Writeln(atSuprimento);
  Application.ProcessMessages;
  CloseFile(atSuprimento);
end;

class procedure TMovimentoController.IntegracaoMovimento(ID: Integer; Movimento: TMovimentoVO);
var
  PathMovimento,  Identificacao, caixa : string;
  atMovimento : TextFile;
begin
  caixa := Configuracao.NomeCaixa;
  Identificacao:='E'+IntToStr(Configuracao.IdEmpresa)+'X'+DevolveInteiro(caixa)+'S'+IntToStr(ID)+'D'+DevolveInteiro(DateTimeToStr(now));

  PathMovimento := ExtractFilePath(Application.ExeName)+'Script\Movimento.txt';
  AssignFile(atMovimento,PathMovimento);
  Application.ProcessMessages;

  if FileExists(PathMovimento) then
    Append(atMovimento)
  else
    Rewrite(atMovimento);

  Write(
    atMovimento,'MOVIMENTO|'+
    Identificacao+'|'+
    caixa+'|'+
    IntToStr(ID)+'|'+
    IntToStr(Movimento.IdImpressora)+'|'+
    IntToStr(Movimento.IdTurno)+'|'+
    IntToStr(Movimento.IdImpressora)+'|'+
    IntToStr(Movimento.IdOperador)+'|'+
    IntToStr(Movimento.IdCaixa)+'|'+
    IntToStr(Movimento.IdGerenteSupervisor)+'|'+
    Movimento.DataAbertura+'|'+
    Movimento.HoraAbertura+'|'+
    Movimento.DataFechamento+'|'+
    Movimento.HoraFechamento+'|'+
    FloatToStr(Movimento.TotalSuprimento)+'|'+
    FloatToStr(Movimento.TotalSangria)+'|'+
    FloatToStr(Movimento.TotalNaoFiscal)+'|'+
    FloatToStr(Movimento.TotalVenda)+'|'+
    FloatToStr(Movimento.TotalDesconto)+'|'+
    FloatToStr(Movimento.TotalAcrescimo)+'|'+
    FloatToStr(Movimento.TotalFinal)+'|'+
    FloatToStr(Movimento.TotalRecebido)+'|'+
    FloatToStr(Movimento.TotalTroco)+'|'+
    FloatToStr(Movimento.TotalCancelado)+'|'+
    Movimento.Status+'|'+
    Movimento.Sincronizado+'|'
  );
  Writeln(atMovimento);
  Application.ProcessMessages;
  CloseFile(atMovimento);
end;

end.
