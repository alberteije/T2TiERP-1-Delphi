{*******************************************************************************
Title: T2Ti ERP
Description: Unit de controle da view FECHAMENTO_CAIXA_BANCO 

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
unit FechamentoCaixaBancoController;

interface

uses
  Classes, Dialogs, SysUtils, DBClient, DB, Windows, Forms, FechamentoCaixaBancoVO,
  DBXCommon;

type
  TFechamentoCaixaBancoController = class
  private
  protected
  public
    class Procedure RealizaFechamento(pFechamentoCaixaBanco: TFechamentoCaixaBancoVO);
  end;

implementation

uses UDataModule, T2TiORM;

var
  FechamentoCaixaBanco: TFechamentoCaixaBancoVO;

class procedure TFechamentoCaixaBancoController.RealizaFechamento(pFechamentoCaixaBanco: TFechamentoCaixaBancoVO);
var
  ResultSet: TDBXReader;
  Filtro: String;
  UltimoID: Integer;
begin
  try
    try
      //verifica se já existe movimento cadastrado para conta/mes/ano informado
      Filtro := 'ID_CONTA_CAIXA='+IntToStr(pFechamentoCaixaBanco.IdContaCaixa) + ' and MES='+QuotedStr(pFechamentoCaixaBanco.Mes) + ' and ANO='+QuotedStr(pFechamentoCaixaBanco.Ano);
      ResultSet := TT2TiORM.Consultar(TFechamentoCaixaBancoVO.Create, Filtro, 0);

      if ResultSet.Next then
      begin
        pFechamentoCaixaBanco.Id := resultSet.Value['ID'].AsInt32;
        TT2TiORM.Alterar(pFechamentoCaixaBanco);
      end
      else
      begin
        DecimalSeparator := '.';
        UltimoID := TT2TiORM.Inserir(pFechamentoCaixaBanco);
        DecimalSeparator := ',';
      end;

    except
    end;
  finally
    ResultSet.Free;
  end;
end;

end.
