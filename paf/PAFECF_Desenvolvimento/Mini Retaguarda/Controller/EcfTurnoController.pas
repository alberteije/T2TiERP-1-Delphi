{*******************************************************************************
Title: T2Ti ERP
Description: Controller do lado Cliente relacionado à tabela [EcfTurno]

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

@author  ()
@version 1.0
*******************************************************************************}
unit EcfTurnoController;

interface

uses
 Classes, Dialogs, SysUtils, DBClient, DB, Windows, Forms, EcfTurnoVO, DBXCommon;

type
  TEcfTurnoController = class
  private
  protected
  public
    class Procedure Consulta(pFiltro: String; pPagina: Integer; pLookup: Boolean);
    class procedure Insere(pEcfTurno: TEcfTurnoVO);
    class procedure Altera(pEcfTurno: TEcfTurnoVO; pFiltro: String; pPagina: Integer);
    class procedure Exclui(pId: Integer);
  end;

implementation

uses UDataModule, T2TiORM, Biblioteca;

var
  EcfTurno: TEcfTurnoVO;

class procedure TEcfTurnoController.Consulta(pFiltro: String; pPagina: Integer; pLookup: Boolean);
var
  ResultSet: TDBXReader;
  ConsultaSQL: String;
  i: integer;
begin
  try
    try
      pFiltro := StringReplace(pFiltro,'*','%',[rfReplaceAll]);
      ResultSet := TT2TiORM.Consultar(TEcfTurnoVO.Create, pFiltro, pPagina);

      if pLookup then
      begin
        FDataModule.CDSLookup.DisableControls;
        FDataModule.CDSLookup.EmptyDataSet;
        while ResultSet.Next do
        begin
          FDataModule.CDSLookup.Append;
          FDataModule.CDSLookup.FieldByName('ID').AsInteger := ResultSet.Value['ID'].AsInt32;
          FDataModule.CDSLookup.FieldByName('DESCRICAO').AsString := ResultSet.Value['DESCRICAO'].AsString;
          FDataModule.CDSLookup.FieldByName('HORA_INICIO').AsString := ResultSet.Value['HORA_INICIO'].AsString;
          FDataModule.CDSLookup.FieldByName('HORA_FIM').AsString := ResultSet.Value['HORA_FIM'].AsString;
          FDataModule.CDSLookup.Post;
        end;
        FDataModule.CDSLookup.Open;
        FDataModule.CDSLookup.EnableControls;
      end
      else
      begin
        FDataModule.CDSTurno.DisableControls;
        FDataModule.CDSTurno.EmptyDataSet;
        while ResultSet.Next do
        begin
          FDataModule.CDSTurno.Append;
          for I := 0 to FDataModule.CDSTurno.FieldCount -1 do
          begin
            if  ResultSet.Value[FDataModule.CDSTurno.FieldDefList[i].Name].ValueType.DataType = 2 then
            begin
             if ResultSet.Value[FDataModule.CDSTurno.FieldDefList[i].Name].GetDate > 0 then
                FDataModule.CDSTurno.Fields[i].AsString := DataParaTexto(ResultSet.Value[FDataModule.CDSTurno.FieldDefList[i].Name].AsDateTime);
            end
            else
            if  ResultSet.Value[FDataModule.CDSTurno.FieldDefList[i].Name].ValueType.DataType = 8 then
            begin
              if not ResultSet.Value[FDataModule.CDSTurno.FieldDefList[i].Name].IsNull  then
              begin
                FDataModule.CDSTurno.Fields[i].AsFloat :=  ResultSet.Value[FDataModule.CDSTurno.FieldDefList[i].Name].AsDouble;
              end
              else FDataModule.CDSTurno.Fields[i].AsFloat := 0;
            end
            else
            if ResultSet.Value[FDataModule.CDSTurno.FieldDefList[i].Name].AsString <> '' then
              FDataModule.CDSTurno.Fields[i].AsString := ResultSet.Value[FDataModule.CDSTurno.FieldDefList[i].Name].AsString;
          end;
          FDataModule.CDSTurno.Post;
          {
          FDataModule.CDSTurno.Append;
          FDataModule.CDSTurno.FieldByName('ID').AsInteger := ResultSet.Value['ID'].AsInt32;
          FDataModule.CDSTurno.FieldByName('DESCRICAO').AsString := ResultSet.Value['DESCRICAO'].AsString;
          FDataModule.CDSTurno.FieldByName('HORA_INICIO').AsString := ResultSet.Value['HORA_INICIO'].AsString;
          FDataModule.CDSTurno.FieldByName('HORA_FIM').AsString := ResultSet.Value['HORA_FIM'].AsString;
          FDataModule.CDSTurno.Post;
          }
        end;
        //FDataModule.CDSTurno.Open;
        FDataModule.CDSTurno.EnableControls;
      end;
    except
    end;
  finally
    ResultSet.Free;
  end;
end;

class Procedure TEcfTurnoController.Insere(pEcfTurno: TEcfTurnoVO);
var
  UltimoID:Integer;
begin
  try
    try
      UltimoID := TT2TiORM.Inserir(pEcfTurno);
      Consulta('ID='+IntToStr(UltimoID),0,False);
    except
      Application.MessageBox('Ocorreu um erro. Inclusão não realizada.', 'Erro do sistema', MB_OK + MB_ICONERROR);
    end;
  finally
  end;
end;

class Procedure TEcfTurnoController.Altera(pEcfTurno: TEcfTurnoVO; pFiltro: String; pPagina: Integer);
begin
  try
    try
      TT2TiORM.Alterar(pEcfTurno);
      Consulta(pFiltro, pPagina,False);
    except
      Application.MessageBox('Ocorreu um erro. Alteração não realizada.', 'Erro do sistema', MB_OK + MB_ICONERROR);
    end;
  finally
  end;
end;

class Procedure TEcfTurnoController.Exclui(pId: Integer);
begin
  try
    try
      EcfTurno := TEcfTurnoVO.Create;
      EcfTurno.Id := pId;
      TT2TiORM.Excluir(EcfTurno);
    except
      Application.MessageBox('Ocorreu um erro na exclusão do cliente.', 'Erro do sistema', MB_OK + MB_ICONERROR);
    end;
  finally
  end;
end;

end.
