{*******************************************************************************
Title: T2Ti ERP
Description: Unit de controle da tabela CONTAS_PAGAR_RECEBER

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
unit LancamentoReceberController;

interface

uses
  Classes, Dialogs, SysUtils, DBClient, DB, Windows, Forms, ContasPagarReceberVO,
  Generics.Collections, DBXCommon, ContasParcelasVO;

type
  TLancamentoReceberController = class
  private
  protected
  public
    class Procedure Consulta(pFiltro: String; pPagina: Integer; pLookup: Boolean);
    class Procedure Insere(pLancamentoReceber: TContasPagarReceberVO; pListaParcelas: TObjectList<TContasParcelasVO>);
    class Procedure Altera(pLancamentoReceber: TContasPagarReceberVO; pListaParcelas: TObjectList<TContasParcelasVO>; pFiltro: String; pPagina: Integer);
    class Procedure Exclui(pId: Integer);
  end;

implementation

uses UDataModule, T2TiORM;

var
  LancamentoReceber: TContasPagarReceberVO;

class procedure TLancamentoReceberController.Consulta(pFiltro: String; pPagina: Integer; pLookup: Boolean);
var
  ResultSet: TDBXReader;
  ConsultaSQL: String;
begin
  try
    try
      pFiltro := StringReplace(pFiltro,'*','%',[rfReplaceAll]);
      pFiltro := 'C.' + pFiltro + ' and NATUREZA_LANCAMENTO = ' + QuotedStr('E');

      ConsultaSQL :=
        'select '+
        '  C.ID, C.ID_PLANO_CONTAS, C.ID_PESSOA, C.ID_TIPO_DOCUMENTO, C.TIPO, C.NUMERO_DOCUMENTO, '+
        '  C.VALOR, C.DATA_LANCAMENTO, C.PRIMEIRO_VENCIMENTO, C.NATUREZA_LANCAMENTO, C.QUANTIDADE_PARCELA, '+
        '  PL.DESCRICAO as DESCRICAO_PLANO_CONTA, PE.NOME as NOME_PESSOA, TD.NOME as NOME_TIPO_DOCUMENTO '+
        'from '+
        '  CONTAS_PAGAR_RECEBER C, PLANO_CONTAS PL, PESSOA PE, TIPO_DOCUMENTO TD '+
        'where '+
        '  C.ID_PLANO_CONTAS = PL.ID and '+
        '  C.ID_PESSOA =PE.ID and '+
        '  C.ID_TIPO_DOCUMENTO = TD.ID';

      resultSet := TT2TiORM.Consultar(ConsultaSQL, pFiltro, pPagina);

      if pLookup then
      begin
        FDataModule.CDSLookup.DisableControls;
        FDataModule.CDSLookup.EmptyDataSet;
        while ResultSet.Next do
        begin
          FDataModule.CDSLookup.Append;
          FDataModule.CDSLookup.FieldByName('ID').AsInteger := ResultSet.Value['ID'].AsInt32;
          FDataModule.CDSLookup.FieldByName('DESCRICAO_PLANO_CONTA').AsString := ResultSet.Value['DESCRICAO_PLANO_CONTA'].AsString;
          FDataModule.CDSLookup.FieldByName('NOME_TIPO_DOCUMENTO').AsString := ResultSet.Value['NOME_TIPO_DOCUMENTO'].AsString;
          FDataModule.CDSLookup.FieldByName('NOME_PESSOA').AsString := ResultSet.Value['NOME_PESSOA'].AsString;
          FDataModule.CDSLookup.FieldByName('NUMERO_DOCUMENTO').AsString := ResultSet.Value['NUMERO_DOCUMENTO'].AsString;
          FDataModule.CDSLookup.FieldByName('QUANTIDADE_PARCELA').AsInteger := ResultSet.Value['QUANTIDADE_PARCELA'].AsInt32;
          FDataModule.CDSLookup.FieldByName('VALOR').AsFloat := ResultSet.Value['VALOR'].AsDouble;
          FDataModule.CDSLookup.FieldByName('DATA_LANCAMENTO').AsString := ResultSet.Value['DATA_LANCAMENTO'].AsString;
          FDataModule.CDSLookup.FieldByName('PRIMEIRO_VENCIMENTO').AsString := ResultSet.Value['PRIMEIRO_VENCIMENTO'].AsString;
          FDataModule.CDSLookup.FieldByName('TIPO').AsString := ResultSet.Value['TIPO'].AsString;
          FDataModule.CDSLookup.FieldByName('NATUREZA_LANCAMENTO').AsInteger := ResultSet.Value['NATUREZA_LANCAMENTO'].AsInt32;
          FDataModule.CDSLookup.FieldByName('ID_PLANO_CONTAS').AsInteger := ResultSet.Value['ID_PLANO_CONTAS'].AsInt32;
          FDataModule.CDSLookup.FieldByName('ID_TIPO_DOCUMENTO').AsInteger := ResultSet.Value['ID_TIPO_DOCUMENTO'].AsInt32;
          FDataModule.CDSLookup.FieldByName('ID_PESSOA').AsInteger := ResultSet.Value['ID_PESSOA'].AsInt32;
          FDataModule.CDSLookup.Post;
        end;
        FDataModule.CDSLookup.Open;
        FDataModule.CDSLookup.EnableControls;
      end
      else
      begin
        FDataModule.CDSLancamentoReceber.DisableControls;
        FDataModule.CDSLancamentoReceber.EmptyDataSet;
        while ResultSet.Next do
        begin
          FDataModule.CDSLancamentoReceber.Append;
          FDataModule.CDSLancamentoReceber.FieldByName('ID').AsInteger := ResultSet.Value['ID'].AsInt32;
          FDataModule.CDSLancamentoReceber.FieldByName('DESCRICAO_PLANO_CONTA').AsString := ResultSet.Value['DESCRICAO_PLANO_CONTA'].AsString;
          FDataModule.CDSLancamentoReceber.FieldByName('NOME_TIPO_DOCUMENTO').AsString := ResultSet.Value['NOME_TIPO_DOCUMENTO'].AsString;
          FDataModule.CDSLancamentoReceber.FieldByName('NOME_PESSOA').AsString := ResultSet.Value['NOME_PESSOA'].AsString;
          FDataModule.CDSLancamentoReceber.FieldByName('NUMERO_DOCUMENTO').AsString := ResultSet.Value['NUMERO_DOCUMENTO'].AsString;
          FDataModule.CDSLancamentoReceber.FieldByName('QUANTIDADE_PARCELA').AsInteger := ResultSet.Value['QUANTIDADE_PARCELA'].AsInt32;
          FDataModule.CDSLancamentoReceber.FieldByName('VALOR').AsFloat := ResultSet.Value['VALOR'].AsDouble;
          FDataModule.CDSLancamentoReceber.FieldByName('DATA_LANCAMENTO').AsString := ResultSet.Value['DATA_LANCAMENTO'].AsString;
          FDataModule.CDSLancamentoReceber.FieldByName('PRIMEIRO_VENCIMENTO').AsString := ResultSet.Value['PRIMEIRO_VENCIMENTO'].AsString;
          FDataModule.CDSLancamentoReceber.FieldByName('TIPO').AsString := ResultSet.Value['TIPO'].AsString;
          FDataModule.CDSLancamentoReceber.FieldByName('NATUREZA_LANCAMENTO').AsInteger := ResultSet.Value['NATUREZA_LANCAMENTO'].AsInt32;
          FDataModule.CDSLancamentoReceber.FieldByName('ID_PLANO_CONTAS').AsInteger := ResultSet.Value['ID_PLANO_CONTAS'].AsInt32;
          FDataModule.CDSLancamentoReceber.FieldByName('ID_TIPO_DOCUMENTO').AsInteger := ResultSet.Value['ID_TIPO_DOCUMENTO'].AsInt32;
          FDataModule.CDSLancamentoReceber.FieldByName('ID_PESSOA').AsInteger := ResultSet.Value['ID_PESSOA'].AsInt32;
          FDataModule.CDSLancamentoReceber.Post;
        end;
        FDataModule.CDSLancamentoReceber.Open;
        FDataModule.CDSLancamentoReceber.EnableControls;
      end;
    except
    end;
  finally
    ResultSet.Free;
  end;
end;

class Procedure TLancamentoReceberController.Insere(pLancamentoReceber: TContasPagarReceberVO; pListaParcelas: TObjectList<TContasParcelasVO>);
var
  I, UltimoID: Integer;
  Parcela: TContasParcelasVO;
begin
  try
    try
      DecimalSeparator := '.';
      UltimoID := TT2TiORM.Inserir(pLancamentoReceber);

      for I := 0 to pListaParcelas.Count - 1 do
      begin
        Parcela := pListaParcelas.Items[i];
        Parcela.IdContasPagarReceber := UltimoID;
        TT2TiORM.Inserir(Parcela);
      end;
      DecimalSeparator := ',';

      Consulta('ID='+IntToStr(UltimoID),0,False);
    except
      Application.MessageBox('Ocorreu um erro. Inclusão não realizada.', 'Erro do sistema', MB_OK + MB_ICONERROR);
    end;
  finally
  end;
end;

class Procedure TLancamentoReceberController.Altera(pLancamentoReceber: TContasPagarReceberVO; pListaParcelas: TObjectList<TContasParcelasVO>; pFiltro: String; pPagina: Integer);
var
  I: Integer;
  Parcela: TContasParcelasVO;
begin
  try
    try
      DecimalSeparator := '.';
      TT2TiORM.Alterar(pLancamentoReceber);

      for I := 0 to pListaParcelas.Count - 1 do
      begin
        Parcela := pListaParcelas.Items[i];
        TT2TiORM.Alterar(Parcela);
      end;
      DecimalSeparator := ',';

      Consulta(pFiltro, pPagina,False);
    except
      Application.MessageBox('Ocorreu um erro. Alteração não realizada.', 'Erro do sistema', MB_OK + MB_ICONERROR);
    end;
  finally
  end;
end;

class Procedure TLancamentoReceberController.Exclui(pId: Integer);
begin
  try
    try
      LancamentoReceber := TContasPagarReceberVO.Create;
      LancamentoReceber.Id := pId;
      TT2TiORM.Excluir(LancamentoReceber);
    except
      Application.MessageBox('Ocorreu um erro na exclusão do cliente.', 'Erro do sistema', MB_OK + MB_ICONERROR);
    end;
  finally
  end;
end;

end.
