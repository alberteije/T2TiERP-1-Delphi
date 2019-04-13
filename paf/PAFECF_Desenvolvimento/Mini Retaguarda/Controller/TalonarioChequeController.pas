{*******************************************************************************
Title: T2Ti ERP
Description: Unit de controle da tabela TALONARIO_CHEQUE

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
unit TalonarioChequeController;

interface

uses
  Classes, Dialogs, SysUtils, DBClient, DB, Windows, Forms, TalonarioChequeVO,
  Generics.Collections, DBXCommon, ChequeVO;

type
  TTalonarioChequeController = class
  private
  protected
  public
    class Procedure Consulta(pFiltro: String; pPagina: Integer; pLookup: Boolean);
    class Procedure Insere(pTalonarioCheque: TTalonarioChequeVO; pListaCheques: TObjectList<TChequeVO>);
    class Procedure Altera(pTalonarioCheque: TTalonarioChequeVO; pListaCheques: TObjectList<TChequeVO>; pFiltro: String; pPagina: Integer);
    class Procedure Exclui(pId: Integer);
  end;

implementation

uses UDataModule, T2TiORM;

var
  TalonarioCheque: TTalonarioChequeVO;

class procedure TTalonarioChequeController.Consulta(pFiltro: String; pPagina: Integer; pLookup: Boolean);
var
  ResultSet: TDBXReader;
  ConsultaSQL: String;
begin
  try
    try
      pFiltro := StringReplace(pFiltro,'*','%',[rfReplaceAll]);
      pFiltro := 'T.' + pFiltro;

      ConsultaSQL :=
          'select '+
          '  T.ID, T.ID_CONTA_CAIXA, T.TALAO, T.NUMERO, C.NOME as NOME_CONTA_CAIXA '+
          'from '+
          '  TALONARIO_CHEQUE T, CONTA_CAIXA C '+
          'where '+
          '  T.ID_CONTA_CAIXA = C.ID';

      resultSet := TT2TiORM.Consultar(ConsultaSQL, pFiltro, pPagina);

      if pLookup then
      begin
        FDataModule.CDSLookup.DisableControls;
        FDataModule.CDSLookup.EmptyDataSet;
        while ResultSet.Next do
        begin
          FDataModule.CDSLookup.Append;
          FDataModule.CDSLookup.FieldByName('ID').AsInteger := ResultSet.Value['ID'].AsInt32;
          FDataModule.CDSLookup.FieldByName('ID_CONTA_CAIXA').AsInteger := ResultSet.Value['ID_CONTA_CAIXA'].AsInt32;
          FDataModule.CDSLookup.FieldByName('TALAO').AsString := ResultSet.Value['TALAO'].AsString;
          FDataModule.CDSLookup.FieldByName('NUMERO').AsInteger := ResultSet.Value['NUMERO'].AsInt32;
          FDataModule.CDSLookup.FieldByName('NOME_CONTA_CAIXA').AsString := ResultSet.Value['NOME_CONTA_CAIXA'].AsString;
          FDataModule.CDSLookup.Post;
        end;
        FDataModule.CDSLookup.Open;
        FDataModule.CDSLookup.EnableControls;
      end
      else
      begin
        FDataModule.CDSTalonarioCheque.DisableControls;
        FDataModule.CDSTalonarioCheque.EmptyDataSet;
        while ResultSet.Next do
        begin
          FDataModule.CDSTalonarioCheque.Append;
          FDataModule.CDSTalonarioCheque.FieldByName('ID').AsInteger := ResultSet.Value['ID'].AsInt32;
          FDataModule.CDSTalonarioCheque.FieldByName('ID_CONTA_CAIXA').AsInteger := ResultSet.Value['ID_CONTA_CAIXA'].AsInt32;
          FDataModule.CDSTalonarioCheque.FieldByName('TALAO').AsString := ResultSet.Value['TALAO'].AsString;
          FDataModule.CDSTalonarioCheque.FieldByName('NUMERO').AsInteger := ResultSet.Value['NUMERO'].AsInt32;
          FDataModule.CDSTalonarioCheque.FieldByName('NOME_CONTA_CAIXA').AsString := ResultSet.Value['NOME_CONTA_CAIXA'].AsString;
          FDataModule.CDSTalonarioCheque.Post;
        end;
        FDataModule.CDSTalonarioCheque.Open;
        FDataModule.CDSTalonarioCheque.EnableControls;
      end;
    except
    end;
  finally
    ResultSet.Free;
  end;
end;

class Procedure TTalonarioChequeController.Insere(pTalonarioCheque: TTalonarioChequeVO; pListaCheques: TObjectList<TChequeVO>);
var
  I, UltimoID: Integer;
  Cheque: TChequeVO;
begin
  try
    try
      UltimoID := TT2TiORM.Inserir(pTalonarioCheque);

      for I := 0 to pListaCheques.Count - 1 do
      begin
        Cheque := pListaCheques.Items[i];
        Cheque.IdTalonarioCheque := UltimoID;
        TT2TiORM.Inserir(Cheque);
      end;

      Consulta('ID='+IntToStr(UltimoID),0,False);
    except
      Application.MessageBox('Ocorreu um erro. Inclusão não realizada.', 'Erro do sistema', MB_OK + MB_ICONERROR);
    end;
  finally
  end;
end;

class Procedure TTalonarioChequeController.Altera(pTalonarioCheque: TTalonarioChequeVO; pListaCheques: TObjectList<TChequeVO>; pFiltro: String; pPagina: Integer);
var
  I: Integer;
  Cheque: TChequeVO;
begin
  try
    try
      TT2TiORM.Alterar(pTalonarioCheque);

      for I := 0 to pListaCheques.Count - 1 do
      begin
        Cheque := pListaCheques.Items[i];
        TT2TiORM.Alterar(Cheque);
      end;

      Consulta(pFiltro, pPagina,False);
    except
      Application.MessageBox('Ocorreu um erro. Alteração não realizada.', 'Erro do sistema', MB_OK + MB_ICONERROR);
    end;
  finally
  end;
end;

class Procedure TTalonarioChequeController.Exclui(pId: Integer);
begin
  try
    try
      TalonarioCheque := TTalonarioChequeVO.Create;
      TalonarioCheque.Id := pId;
      TT2TiORM.Excluir(TalonarioCheque);
    except
      Application.MessageBox('Ocorreu um erro na exclusão do cliente.', 'Erro do sistema', MB_OK + MB_ICONERROR);
    end;
  finally
  end;
end;

end.
