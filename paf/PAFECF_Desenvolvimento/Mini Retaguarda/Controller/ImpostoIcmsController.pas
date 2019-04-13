unit ImpostoIcmsController;

interface

uses
  Classes, Dialogs, SysUtils, DBClient, DB, Windows, Forms, ImpostoIcmsVO,
  DBXCommon, Rtti, Atributos;

type
  TImpostoIcmsController = class(TObject)
  private
    class var FDataSet: TClientDataSet;
  protected
  public
    class Procedure Consulta(pFiltro: String; pPagina: Integer; pLookup: Boolean);
    class Procedure Insere(pImpostoIcms: TImpostoIcmsVO);
    class Procedure Altera(pImpostoIcms: TImpostoIcmsVO; pFiltro: String; pPagina: Integer);
    class Procedure Exclui(pId: Integer);
    class function GetDataSet: TClientDataSet;
    class procedure SetDataSet(pDataSet: TClientDataSet);

  end;

implementation

uses UDataModule, T2TiORM, TypInfo, Biblioteca;

var
  ImpostoIcms: TImpostoIcmsVO;

class procedure TImpostoIcmsController.Consulta(pFiltro: String; pPagina: Integer; pLookup: Boolean);
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
      ResultSet := TT2TiORM.Consultar(TImpostoIcmsVO.Create, pFiltro, pPagina);

      if pLookup then
      begin
        Contexto := TRttiContext.Create;
        Tipo := Contexto.GetType(TImpostoIcmsVO);

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
        FDataModule.CDSImpostoIcms.DisableControls;
        FDataModule.CDSImpostoIcms.EmptyDataSet;
        while ResultSet.Next do
        begin

          FDataModule.CDSImpostoIcms.Append;
          for I := 0 to FDataModule.CDSImpostoIcms.FieldCount -1 do
          begin
            if  ResultSet.Value[FDataModule.CDSImpostoIcms.FieldDefList[i].Name].ValueType.DataType = 2 then
            begin
              if ResultSet.Value[FDataModule.CDSImpostoIcms.FieldDefList[i].Name].GetDate > 0 then
                FDataModule.CDSImpostoIcms.Fields[i].AsString := DataParaTexto(ResultSet.Value[FDataModule.CDSImpostoIcms.FieldDefList[i].Name].AsDateTime);
            end
            else
            if  ResultSet.Value[FDataModule.CDSImpostoIcms.FieldDefList[i].Name].ValueType.DataType = 8 then
            begin
              if not ResultSet.Value[FDataModule.CDSImpostoIcms.FieldDefList[i].Name].IsNull  then
              begin
                FDataModule.CDSImpostoIcms.Fields[i].AsFloat :=  ResultSet.Value[FDataModule.CDSImpostoIcms.FieldDefList[i].Name].AsDouble;
              end;
            end
            else
            if ResultSet.Value[FDataModule.CDSImpostoIcms.FieldDefList[i].Name].AsString <> '' then
              FDataModule.CDSImpostoIcms.Fields[i].AsString := ResultSet.Value[FDataModule.CDSImpostoIcms.FieldDefList[i].Name].AsString;
          end;
          FDataModule.CDSImpostoIcms.Post;

        end;
        FDataModule.CDSImpostoIcms.EnableControls;
      end;

    except
      on e: exception do
        ShowMessage(e.Message);
    end;
  finally
    ResultSet.Free;
  end;
end;

class Procedure TImpostoIcmsController.Insere(pImpostoIcms: TImpostoIcmsVO);
var
  UltimoID:Integer;
begin
  try
    try
      UltimoID := TT2TiORM.Inserir(pImpostoIcms);
      Consulta('ID='+IntToStr(UltimoID),0, False);
    except
      Application.MessageBox('Ocorreu um erro. Inclusão não realizada.', 'Erro do sistema', MB_OK + MB_ICONERROR);
    end;
  finally
  end;
end;

class procedure TImpostoIcmsController.SetDataSet(pDataSet: TClientDataSet);
begin
  FDataSet := pDataSet;
end;

class Procedure TImpostoIcmsController.Altera(pImpostoIcms: TImpostoIcmsVO; pFiltro: String; pPagina: Integer);
begin
  try
    try
      TT2TiORM.Alterar(pImpostoIcms);
      Consulta(pFiltro, pPagina, False);
    except
      Application.MessageBox('Ocorreu um erro. Alteração não realizada.', 'Erro do sistema', MB_OK + MB_ICONERROR);
    end;
  finally
  end;
end;

class Procedure TImpostoIcmsController.Exclui(pId: Integer);
begin
  try
    try
      ImpostoIcms := TImpostoIcmsVO.Create;
      ImpostoIcms.Id := pId;
      TT2TiORM.Excluir(ImpostoIcms);
    except
      Application.MessageBox('Ocorreu um erro na exclusão do Imposto Icms.', 'Erro do sistema', MB_OK + MB_ICONERROR);
    end;
  finally
  end;
end;

class function TImpostoIcmsController.GetDataSet: TClientDataSet;
begin
  Result := FDataSet;
end;

end.
