unit NfeDetalheController;

interface

uses
  Classes, SQLExpr, SysUtils, NfeDetalheVO, Generics.Collections, DBXCommon;

type
  TNfeDetalheController = class
  protected
  public
    class procedure Consulta(pFiltro: String; pPagina: Integer; pLookup: Boolean);

    class Function getNfeDetalheSPED(id : string): TObjectList<TNfeDetalheVO>;


  end;

implementation

uses UDataModule, T2TiORM;

var
  ConsultaSQL, ClausulaWhere : String;
  Query: TSQLQuery;

{ TNfeDetalheController }

class function TNfeDetalheController.getNfeDetalheSPED(
  id: string): TObjectList<TNfeDetalheVO>;
var
  ListaNfe: TObjectList<TNfeDetalheVO>;
  Nfe: TNfeDetalheVO;
  TotalRegistros: Integer;
  DataInicio, DataFim : String ;
begin
  try
    try
        ConsultaSQL :=
                        ' select count(*) as total '+
                        ' from nfe_detalhe '+
                        ' where ID_NFE_CABECALHO='+ID;

        Query := TSQLQuery.Create(nil);
        Query.SQLConnection := FDataModule.Conexao;
        Query.sql.Text := ConsultaSQL;
        Query.Open;
        TotalRegistros := Query.FieldByName('TOTAL').AsInteger;

     if TotalRegistros > 0 then
      if true then
        begin
            ListaNfe := TObjectList<TNfeDetalheVO>.Create;
            {ConsultaSQL :=  ' select ID, CST_A, CFOP, ALIQUOTA_ICMS, VALOR_TOTAL, BASE_CALCULO_ICMS, VALOR_ICMS, BASE_CALCULO_ICMS_ST, ALIQUOTA_ICMS_ST,  VALOR_IPI '+
                            ' from nfe_detalhe '+
                            ' where ID_NFE_CABECALHO='+ID;}
            ConsultaSQL :=  ' select ID, CFOP, ALIQUOTA_ICMS, VALOR_TOTAL, BASE_CALCULO_ICMS, VALOR_ICMS, BASE_CALCULO_ICMS_ST, ALIQUOTA_ICMS_ST,  VALOR_IPI '+
                            ' from nfe_detalhe '+
                            ' where ID_NFE_CABECALHO='+ID;
            Query.sql.Text := ConsultaSQL;
            Query.Open;
            Query.First;

            while not Query.Eof do
            begin
              Nfe := TNfeDetalheVO.Create;
              Nfe.Id := Query.FieldByName('ID').AsInteger;
              {TODO : verificar qual das classeficacoes deve ser usada}
              //Nfe.CstA := Query.FieldByName('CST_A').AsString;
              Nfe.Cfop := Query.FieldByName('CFOP').AsInteger;
              Nfe.AliquotaIcms := Query.FieldByName('ALIQUOTA_ICMS').AsFloat;
              Nfe.ValorTotal := Query.FieldByName('VALOR_TOTAL').AsFloat;
              Nfe.BaseCalculoIcms := Query.FieldByName('BASE_CALCULO_ICMS').AsFloat;
              Nfe.ValorIcms := Query.FieldByName('VALOR_ICMS').AsFloat;
              Nfe.BaseCalculoIcmsSt := Query.FieldByName('BASE_CALCULO_ICMS_ST').AsFloat;
              Nfe.ValorIcmsSt := Query.FieldByName('ALIQUOTA_ICMS_ST').AsFloat;

              {TODO : verifica necessidade de criar esse campo [VL_RED_BC] )}
              Nfe.ValorIpi := Query.FieldByName('VALOR_IPI').AsFloat;
              ListaNfe.Add(Nfe);
              Query.next;
            end;
            result := ListaNfe;
        end
      else
        result := nil;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;

class procedure TNFeDetalheController.Consulta(pFiltro: String; pPagina: Integer; pLookup: Boolean);
var
  ResultSet : TDBXReader;
  i: Integer;
  typ: Integer;
begin
  try
    try
      pFiltro := StringReplace(pFiltro,'*','%',[rfReplaceAll]);
      ResultSet := TT2TiORM.Consultar(TNfeDetalheVO.Create, pFiltro, pPagina);

      if pLookup then
      begin
        FDataModule.CDSLookup.DisableControls;
        FDataModule.CDSLookup.EmptyDataSet;
        while ResultSet.Next do
        begin
          FDataModule.CDSLookup.Append;
          FDataModule.CDSLookup.FieldByName('ID').AsInteger  := ResultSet.Value['ID'].AsInt32;
          FDataModule.CDSLookup.FieldByName('NUMERO').AsString := ResultSet.Value['NUMERO'].AsString;
          FDataModule.CDSLookup.Post;
        end;
        FDataModule.CDSLookup.Open;
        FDataModule.CDSLookup.EnableControls;
      end
      else
      begin
        FDataModule.CDSNFeItens.DisableControls;
        FDataModule.CDSNFeItens.EmptyDataSet;
        while ResultSet.Next do
        begin

          FDataModule.CDSNFeItens.Append;
          for I := 0 to FDataModule.CDSNFeItens.FieldCount -1 do
          begin
            if  ResultSet.Value[FDataModule.CDSNFeItens.FieldDefList[i].Name].ValueType.DataType = 2 then
            begin
              if ResultSet.Value[FDataModule.CDSNFeItens.FieldDefList[i].Name].GetDate > 0 then
                FDataModule.CDSNFeItens.Fields[i].AsString := FormatDateTime('DD/MM/YYYY', ResultSet.Value[FDataModule.CDSNFeItens.FieldDefList[i].Name].AsDateTime);
            end
            else
            if  ResultSet.Value[FDataModule.CDSNFeItens.FieldDefList[i].Name].ValueType.DataType = 8 then
            begin
               FDataModule.CDSNFeItens.Fields[i].AsString := FormatFloat('##,##0.00', ResultSet.Value[FDataModule.CDSNFeItens.FieldDefList[i].Name].AsDouble);
            end
            else
            if ResultSet.Value[FDataModule.CDSNFeItens.FieldDefList[i].Name].AsString <> '' then
              FDataModule.CDSNFeItens.Fields[i].AsString := ResultSet.Value[FDataModule.CDSNFeItens.FieldDefList[i].Name].AsString;
          end;
          FDataModule.CDSNFeItens.Post;

        end;
        FDataModule.CDSNFeItens.Open;
        FDataModule.CDSNFeItens.EnableControls;
      end;

    except
    end;
  finally
    ResultSet.Free;
  end;
end;

end.
