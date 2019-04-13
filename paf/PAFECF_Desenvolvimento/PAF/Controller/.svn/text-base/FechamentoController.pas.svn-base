{*******************************************************************************
Title: T2Ti ERP
Description: Classe de controle do Fechamento.

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

@author Albert Eije (T2Ti.COM) | Gilson Santos Lima
@version 1.0
*******************************************************************************}
unit FechamentoController;

interface

uses
  Classes, SQLExpr, SysUtils, FechamentoVO, Forms;

type
  TFechamentoController = class
  protected
  public
    class function GravaFechamento(Fechamento: TFechamentoVO): Boolean;
    class function ExcluiFechamento(Id: Integer): Boolean;
    class procedure IntegracaoFechamento(Id: Integer; Fecha: TFechamentoVO);
    class procedure IntegracaoExcluiFechamento(Id: Integer);

  end;

implementation

uses UDataModule, UCaixa, Biblioteca;

var
  ConsultaSQL : String;
  Query: TSQLQuery;

class function TFechamentoController.GravaFechamento(Fechamento:TFechamentoVO): boolean;
begin

    ConsultaSQL :=  'insert into ecf_fechamento ( '+
                    'ID_ECF_MOVIMENTO,' +
                    'TIPO_PAGAMENTO,' +
                    'VALOR)'+
                    ' values ('+
                    ':pID_ECF_MOVIMENTO,'+
                    ':pTIPO_PAGAMENTO,'+
                    ':pVALOR)';

  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;

      Query.ParamByName('pID_ECF_MOVIMENTO').AsInteger := Fechamento.IdMovimento;
      Query.ParamByName('pTIPO_PAGAMENTO').AsString    := Fechamento.TipoPagamento;
      Query.ParamByName('pVALOR').AsFloat              := Fechamento.Valor;

      Query.ExecSQL();
      try
        Query.Close;
        Query.SQL.Clear;
        ConsultaSQL := 'select max(ID) as ID from ecf_fechamento';
        Query.sql.Text := ConsultaSQL;
        Query.Open();

        IntegracaoFechamento(Query.FieldByName('ID').AsInteger, Fechamento);
      finally
        //
      end;
      result := True;
    except
      result := false;
    end;
  finally
    Query.Free;
  end;
end;

class function TFechamentoController.ExcluiFechamento(Id: Integer): boolean;
begin
  try
    IntegracaoExcluiFechamento(Id);
  finally
    ConsultaSQL := 'delete from ecf_fechamento where id = :pID ';
    try
      try
        Query := TSQLQuery.Create(nil);
        Query.SQLConnection := FDataModule.Conexao;
        Query.sql.Text := ConsultaSQL;
        Query.ParamByName('pID').AsInteger := Id;
        Query.ExecSQL();
        result := True;
      except
        result := false;
      end;
    finally
      Query.Free;
    end;
  end;
end;

class procedure TFechamentoController.IntegracaoFechamento(ID: integer;  Fecha: TFechamentoVO);
var
  PathFechamento,  Identificacao, Caixa: String;
  atFechamento: TextFile;
begin
  try
    Caixa := Configuracao.NomeCaixa;
    Identificacao := 'E'+IntToStr(Configuracao.IdEmpresa)+'X'+DevolveInteiro(caixa)+'S'+IntToStr(ID)+'D'+DataParaTexto(Now)+'H'+TimeToStr(now);
    PathFechamento := ExtractFilePath(Application.ExeName)+'Script\Fechamento.txt';
    AssignFile(atFechamento, PathFechamento);
    Application.ProcessMessages;

    if FileExists(PathFechamento) then
      Append(atFechamento)
    else
      Rewrite(atFechamento);

    Write(
      atFechamento,'FECHAMENTO|'+
      Identificacao+
      caixa+'|'+
      IntToStr(ID)+'|'+
      IntToStr(Fecha.IdMovimento)+'|'+
      Fecha.TipoPagamento+'|'+
      FloatToStr(Fecha.Valor)+'|'
    );
    Writeln(atFechamento);
    CloseFile(atFechamento);
    Application.ProcessMessages;
    FCaixa.ExportaParaRetaguarda('Fechamento.txt',3);
  finally
    //
  end;
end;

class procedure TFechamentoController.IntegracaoExcluiFechamento(ID: integer);
var
  PathFechamento,  Identificacao, Caixa: String;
  atFechamento : TextFile;
begin
  caixa := Configuracao.NomeCaixa;
  Identificacao:='E'+IntToStr(Configuracao.IdEmpresa)+'X'+DevolveInteiro(caixa)+'S'+IntToStr(ID)+'D'+DataParaTexto(Now)+'H'+TimeToStr(now);
  PathFechamento := ExtractFilePath(Application.ExeName)+'Script\Fechamento.txt';
  AssignFile(atFechamento,PathFechamento);
  Application.ProcessMessages;

  ConsultaSQL :=  'select * from ecf_fechamento where ID ='+IntToStr(ID);

  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open();
      if not query.IsEmpty then
      begin
        if FileExists(PathFechamento) then
          Append(atFechamento)
        else
          Rewrite(atFechamento);

        Write(
          atFechamento,'EXCLUIFECHAMENTO|'+
          Identificacao+
          caixa+'|'+
          Query.FieldByName('ID').AsString+'|'+
          Query.FieldByName('ID_ECF_MOVIMENTO').AsString+'|'+
          Query.FieldByName('TIPO_PAGAMENTO').AsString+'|'+
          Query.FieldByName('VALOR').AsString+'|'
        );
        Writeln(atFechamento);
        CloseFile(atFechamento);
        Application.ProcessMessages;
        FCaixa.ExportaParaRetaguarda('Fechamento.txt',3);
      end;
    except
      //
    end;
  finally
     Query.Free;
  end;
end;

end.
