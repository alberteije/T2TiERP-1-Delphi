{*******************************************************************************
Title: T2Ti ERP
Description: Unit de controle da tabela NCM

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
unit NcmController;

interface

uses
  Classes, Dialogs, SysUtils, DBClient, DB, Windows, Forms, NcmVO, DBXCommon,
  Rtti, Atributos;

type
  TNCMController = class
  private
  protected
  public
    class Procedure Consulta(pFiltro: String; pPagina: Integer; pLookup: Boolean);
    class Procedure Insere(pNcm: TNcmVO);
    class Procedure Altera(pNcm: TNcmVO; pFiltro: String; pPagina: Integer);
    class Procedure Exclui(pId: Integer);
  end;

implementation

uses UDataModule, T2TiORM, TypInfo, Biblioteca;

var
  Ncm: TNcmVO;

class procedure TNcmController.Consulta(pFiltro: String; pPagina: Integer; pLookup: Boolean);
var
  ResultSet : TDBXReader;
  Contexto: TRttiContext;
  Tipo: TRttiType;
  Propriedade: TRttiProperty;
  Atributo: TCustomAttribute;
  I: Integer;

begin
  try
    try
      pFiltro := StringReplace(pFiltro,'*','%',[rfReplaceAll]);
      ResultSet := TT2TiORM.Consultar(TNcmVO.Create, pFiltro, pPagina);

      if pLookup then
      begin
        Contexto := TRttiContext.Create;
        Tipo := Contexto.GetType(TNcmVO);

        FDataModule.CDSLookup.DisableControls;
        FDataModule.CDSLookup.EmptyDataSet;
        while ResultSet.Next do
        begin
          FDataModule.CDSLookup.Append;
          FDataModule.CDSLookup.FieldByName('ID').AsInteger  := ResultSet.Value['ID'].AsInt32;
          for Propriedade in Tipo.GetProperties do
          begin
            for Atributo in Propriedade.GetAttributes do
            begin
              if Atributo is TColumn then
              begin
                if (Atributo as TColumn).LocalDispay in [ldLookup,ldGridLookup] then
                begin
                   if Propriedade.PropertyType.TypeKind in [tkString, tkUstring]  then
                     FDataModule.CDSLookup.FieldByName((Atributo as TColumn).Name).AsString :=
                         ResultSet.Value[(Atributo as TColumn).Name].Asstring
                   else
                   if Propriedade.PropertyType.TypeKind in [tkFloat]then
                      FDataModule.CDSLookup.FieldByName((Atributo as TColumn).Name).AsString :=
                         FormatFloat('##0.00',ResultSet.Value[(Atributo as TColumn).Name].AsDouble)
                   else
                     FDataModule.CDSLookup.FieldByName((Atributo as TColumn).Name).AsString :=
                        ResultSet.Value[(Atributo as TColumn).Name].AsString;
                end;
              end;
            end;
          end;
          FDataModule.CDSLookup.Post;
        end;
        FDataModule.CDSLookup.Open;
        FDataModule.CDSLookup.EnableControls;
      end
      else
      begin
        FDataModule.CDSNcm.DisableControls;
        FDataModule.CDSNcm.EmptyDataSet;
        while ResultSet.Next do
        begin

          FDataModule.CDSNcm.Append;
          for I := 0 to FDataModule.CDSNcm.FieldCount -1 do
          begin
            if  ResultSet.Value[FDataModule.CDSNcm.FieldDefList[i].Name].ValueType.DataType = 2 then
            begin
              if ResultSet.Value[FDataModule.CDSNcm.FieldDefList[i].Name].GetDate > 0 then
                FDataModule.CDSNcm.Fields[i].AsString := DataParaTexto(ResultSet.Value[FDataModule.CDSNcm.FieldDefList[i].Name].AsDateTime);
            end
            else
            if  ResultSet.Value[FDataModule.CDSNcm.FieldDefList[i].Name].ValueType.DataType = 8 then
            begin
              if not ResultSet.Value[FDataModule.CDSNcm.FieldDefList[i].Name].IsNull  then
              begin
                FDataModule.CDSNcm.Fields[i].AsFloat :=  ResultSet.Value[FDataModule.CDSNcm.FieldDefList[i].Name].AsDouble;
              end;
            end
            else
            if ResultSet.Value[FDataModule.CDSNcm.FieldDefList[i].Name].AsString <> '' then
              FDataModule.CDSNcm.Fields[i].AsString := ResultSet.Value[FDataModule.CDSNcm.FieldDefList[i].Name].AsString;
          end;
          FDataModule.CDSNcm.Post;

        end;
        FDataModule.CDSNcm.EnableControls;
      end;

    except
      on e: exception do
        ShowMessage(e.Message);
    end;
  finally
    ResultSet.Free;
  end;
end;

class Procedure TNcmController.Insere(pNcm: TNcmVO);
var
  UltimoID:Integer;
begin
  try
    try
      UltimoID := TT2TiORM.Inserir(pNcm);
      pNcm.Id := UltimoID;
    except
      Application.MessageBox('Ocorreu um erro. Inclusão não realizada.', 'Erro do sistema', MB_OK + MB_ICONERROR);
    end;
  finally
  end;
end;

class Procedure TNcmController.Altera(pNcm: TNcmVO; pFiltro: String; pPagina: Integer);
begin
  try
    try
      TT2TiORM.Alterar(pNcm);
    except
      Application.MessageBox('Ocorreu um erro. Alteração não realizada.', 'Erro do sistema', MB_OK + MB_ICONERROR);
    end;
  finally
  end;
end;

class Procedure TNcmController.Exclui(pId: Integer);
begin
  try
    try
      Ncm := TNcmVO.Create;
      Ncm.Id := pId;
      TT2TiORM.Excluir(Ncm);
    except
      Application.MessageBox('Ocorreu um erro na exclusão do cliente.', 'Erro do sistema', MB_OK + MB_ICONERROR);
    end;
  finally
  end;
end;

end.
