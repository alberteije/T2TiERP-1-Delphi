unit NFeConfiguracaoController;

interface

uses
  Classes, Dialogs, SysUtils, DBClient, DB, Windows, Forms, DBXCommon,
  Generics.Collections, SqlExpr, NFeConfiguracaoVO;

type
  TNfeConfiguracaoController = class
  protected
  public
    class Procedure Consulta(pFiltro: String; pPagina: Integer; pLookup: Boolean);
    class procedure ConfiguraACBrNFe(TpEmissao: integer);
    //class function  Insere(pNFe: TNfeCabecalhoVO; pListaItem: TObjectList<TNfeDetalheVO>): integer;
    //class procedure Altera(pNFeCabecalho: TNfeCabecalhoVO; pListaItem: TObjectList<TNfeDetalheVO>; pFiltro: String; pPagina: Integer);
    //class procedure Exclui(pId: Integer); static;

  end;

implementation

uses UDataModule, T2TiORM, pcnConversao;

var
  NFeConfiguracao: TNFeConfiguracaoVO;
  ConsultaSQL: string;
  Query: TSQLQuery;


class procedure TNfeConfiguracaoController.ConfiguraACBrNFe(TpEmissao: integer);
var
 OK: Boolean;
begin
  Consulta('',0,False);
  if FDataModule.CDSNFeConfiguracao.RecordCount > 0 then
  begin
     FDataModule.ACBrNFe.Configuracoes.Certificados.NumeroSerie := FDataModule.CDSNFeConfiguracao.FieldByName('CERTIFICADO_DIGITAL').AsString;
     FDataModule.ACBrNFe.Configuracoes.Geral.FormaEmissao := StrToTpEmis(OK, IntToStr(TpEmissao+1));
     FDataModule.ACBrNFe.Configuracoes.Geral.Salvar := (FDataModule.CDSNFeConfiguracao.FieldByName('SALVA_XML').AsString = 'S');
     FDataModule.ACBrNFe.Configuracoes.Geral.PathSalvar := FDataModule.CDSNFeConfiguracao.FieldByName('CAMINHO_SALVAR_XML').AsString;
     FDataModule.ACBrNFe.Configuracoes.WebServices.UF := FDataModule.CDSNFeConfiguracao.FieldByName('UF_WEBSERVICE').AsString;
     FDataModule.ACBrNFe.Configuracoes.WebServices.Ambiente := StrToTpAmb(OK, FDataModule.CDSNFeConfiguracao.FieldByName('AMBIENTE').AsString);
     FDataModule.ACBrNFe.Configuracoes.WebServices.Visualizar :=  True;
     FDataModule.ACBrNFe.Configuracoes.WebServices.ProxyHost := FDataModule.CDSNFeConfiguracao.FieldByName('PROXY_HOST').AsString;;
     FDataModule.ACBrNFe.Configuracoes.WebServices.ProxyPort := FDataModule.CDSNFeConfiguracao.FieldByName('PROXY_PORTA').AsString;
     FDataModule.ACBrNFe.Configuracoes.WebServices.ProxyUser := FDataModule.CDSNFeConfiguracao.FieldByName('PROXY_USER').AsString;
     FDataModule.ACBrNFe.Configuracoes.WebServices.ProxyPass := FDataModule.CDSNFeConfiguracao.FieldByName('PROXY_SENHA').AsString;

     if FDataModule.ACBrNFe.DANFE <> nil then
     begin
       FDataModule.ACBrNFeDANFERave.RavFile := GetCurrentDir+'\Report\NotaFiscalEletronica.rav';
       FDataModule.ACBrNFe.DANFE.TipoDANFE := StrToTpImp(ok, FDataModule.CDSNFeConfiguracao.FieldByName('FORMATO_IMPRESSAO_DANFE').AsString);
       FDataModule.ACBrNFe.DANFE.Logo := FDataModule.CDSNFeConfiguracao.FieldByName('LOGOMARCA').AsString;
     end;
  end;

end;

class procedure TNFeConfiguracaoController.Consulta(pFiltro: String; pPagina: Integer; pLookup: Boolean);
var
  ResultSet : TDBXReader;
  i: Integer;
  typ: Integer;
begin
  try
    try
      pFiltro := StringReplace(pFiltro,'*','%',[rfReplaceAll]);
      ResultSet := TT2TiORM.Consultar(TNfeConfiguracaoVO.Create, pFiltro, pPagina);

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
        FDataModule.CDSNFeConfiguracao.DisableControls;
        FDataModule.CDSNFeConfiguracao.EmptyDataSet;
        while ResultSet.Next do
        begin

          FDataModule.CDSNFeConfiguracao.Append;
          for I := 0 to FDataModule.CDSNFeConfiguracao.FieldCount -1 do
          begin
            if  ResultSet.Value[FDataModule.CDSNFeConfiguracao.FieldDefList[i].Name].ValueType.DataType = 2 then
            begin
              if ResultSet.Value[FDataModule.CDSNFeConfiguracao.FieldDefList[i].Name].GetDate > 0 then
                FDataModule.CDSNFeConfiguracao.Fields[i].AsString := FormatDateTime('DD/MM/YYYY', ResultSet.Value[FDataModule.CDSNFeConfiguracao.FieldDefList[i].Name].AsDateTime);
            end
            else
            if  ResultSet.Value[FDataModule.CDSNFeConfiguracao.FieldDefList[i].Name].ValueType.DataType = 8 then
            begin
               FDataModule.CDSNFeConfiguracao.Fields[i].AsString := FormatFloat('##,##0.00', ResultSet.Value[FDataModule.CDSNFeConfiguracao.FieldDefList[i].Name].AsDouble);
            end
            else
            if ResultSet.Value[FDataModule.CDSNFeConfiguracao.FieldDefList[i].Name].AsString <> '' then
              FDataModule.CDSNFeConfiguracao.Fields[i].AsString := ResultSet.Value[FDataModule.CDSNFeConfiguracao.FieldDefList[i].Name].AsString;
          end;
          FDataModule.CDSNFeConfiguracao.Post;

        end;

        FDataModule.CDSNFeConfiguracao.EnableControls;
      end;

    except
    end;
  finally
    ResultSet.Free;
  end;
end;

{
class function TNFeCabecalhoController.Insere(pNFe: TNFeCabecalhoVO;
  pListaItem: TObjectList<TNFeDetalheVO>): integer;
var
  I, UltimoID: Integer;
  NFeDetalhe: TNFeDetalheVO;
begin
  try
    try
      DecimalSeparator := '.';
      UltimoID := TT2TiORM.Inserir(pNFe);

      for I := 0 to pListaItem.Count - 1 do
      begin
        NFeDetalhe                := pListaItem.Items[i];
        NFeDetalhe.IdNfeCabecalho := UltimoID;
        TT2TiORM.Inserir(NFeDetalhe);
      end;
      DecimalSeparator := ',';

      result := UltimoID;
    except
      Application.MessageBox('Ocorreu um erro. Inclusão não realizada.', 'Erro do sistema', MB_OK + MB_ICONERROR);
    end;
  finally
  end;
end;
}

{
class Procedure TNFeCabecalhoController.Altera(pNFeCabecalho: TNFeCabecalhoVO;
 pListaItem: TObjectList<TNFeDetalheVO>; pFiltro: String; pPagina: Integer);
var
  I: Integer;
  NFeItem: TNFeDetalheVO;
begin
  try
    try
      DecimalSeparator := '.';
      TT2TiORM.Alterar(pNFeCabecalho);

      for I := 0 to pListaItem.Count - 1 do
      begin
        NFeItem := pListaItem.Items[i];
        TT2TiORM.Alterar(NFeItem);
      end;
      DecimalSeparator := ',';

      Consulta(pFiltro, pPagina,False);
    except
      Application.MessageBox('Ocorreu um erro. Alteração não realizada.', 'Erro do sistema', MB_OK + MB_ICONERROR);
    end;
  finally
  end;
end;
}
{
class procedure TNFeCabecalhoController.Exclui(pId: Integer);
begin
  try
    try
      NFeCabecalho  := TNFeCabecalhoVO.Create;
      NFeCabecalho.Id := pId;
      TT2TiORM.Excluir(NFeCabecalho);
    except
      Application.MessageBox('Ocorreu um erro na exclusão da nota.', 'Erro do sistema', MB_OK + MB_ICONERROR);
    end;
  finally
  end;

end;
}

end.
