unit NfeCabecalhoController;

interface

uses
  Classes, Dialogs, SysUtils, DBClient, DB, Windows, Forms, DBXCommon, NFeCabecalhoVO,
  Generics.Collections, SqlExpr, NFeDetalheVO;

type
  TNfeCabecalhoController = class
  protected
  public
    class Procedure Consulta(pFiltro: String; pPagina: Integer; pLookup: Boolean);
    class function  Insere(pNFe: TNfeCabecalhoVO; pListaItem: TObjectList<TNfeDetalheVO>): integer;
    class procedure Altera(pNFeCabecalho: TNfeCabecalhoVO; pListaItem: TObjectList<TNfeDetalheVO>; pFiltro: String; pPagina: Integer);
    class procedure Exclui(pId: Integer); static;
    class procedure AtuaizaSituacaoNota(ID: Integer; Situacao: integer);
    class procedure AtuaizaChaveAcesso(ID: Integer; Chave: string);


    class function getNfeSPED(pDataInicial, pDataFinal: String): TObjectList<TNfeCabecalhoVO>;
  end;

implementation

uses UDataModule, T2TiORM, ConexaoBD;

var
  NFeCabecalho: TNFeCabecalhoVO;
  ConsultaSQL: string;
  Query: TSQLQuery;

class procedure TNfeCabecalhoController.AtuaizaSituacaoNota(ID,
  Situacao: integer);
var
  Qr: TSQLQuery;
begin
  // 0 - Edição| 1 - Salva| 2 - Validada|  3 - Assinada| 4 - Enviada| 5 - Autrizada| 6 - Cancelada
  Qr := TSQLQuery.Create(nil);
  try
    Qr.SQLConnection := TDBExpress.Conexao;
    Qr.CommandText :=  'update nfe_cabecalho set Situacao_nota = '+IntToStr(Situacao)+ ' where ID = '+IntToStr(ID);
    Qr.ExecSQL(True);
  finally
    FreeAndNil(Qr);
  end;

end;

class procedure TNfeCabecalhoController.AtuaizaChaveAcesso(ID: Integer;
  Chave: string);
var
  Qr: TSQLQuery;
begin
  Qr := TSQLQuery.Create(nil);
  try
    Qr.SQLConnection := TDBExpress.Conexao;
    Qr.CommandText :=  'update NFE_CABECALHO set CHAVE_ACESSO = '+QuotedStr(Chave)+ ' where ID = '+IntToStr(ID);
    Qr.ExecSQL(True);
  finally
    FreeAndNil(Qr);
  end;

end;


class procedure TNFeCabecalhoController.Consulta(pFiltro: String; pPagina: Integer; pLookup: Boolean);
var
  ResultSet : TDBXReader;
  i: Integer;
  typ: Integer;
begin
  try
    try
      pFiltro := StringReplace(pFiltro,'*','%',[rfReplaceAll]);
      ResultSet := TT2TiORM.Consultar(TNFeCabecalhoVO.Create, pFiltro, pPagina);

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
        FDataModule.CDSNFe.DisableControls;
        FDataModule.CDSNFe.EmptyDataSet;
        while ResultSet.Next do
        begin

          FDataModule.CDSNFe.Append;
          for I := 0 to FDataModule.CDSNFe.FieldCount -1 do
          begin
            if  ResultSet.Value[FDataModule.CDSNFe.FieldDefList[i].Name].ValueType.DataType = 2 then
            begin
              if ResultSet.Value[FDataModule.CDSNFe.FieldDefList[i].Name].GetDate > 0 then
                FDataModule.CDSNFe.Fields[i].AsString := FormatDateTime('DD/MM/YYYY', ResultSet.Value[FDataModule.CDSNFe.FieldDefList[i].Name].AsDateTime);
            end
            else
            if  ResultSet.Value[FDataModule.CDSNFe.FieldDefList[i].Name].ValueType.DataType = 8 then
            begin
               FDataModule.CDSNFe.Fields[i].AsString := FormatFloat('##,##0.00', ResultSet.Value[FDataModule.CDSNFe.FieldDefList[i].Name].AsDouble);
            end
            else
            if ResultSet.Value[FDataModule.CDSNFe.FieldDefList[i].Name].AsString <> '' then
              FDataModule.CDSNFe.Fields[i].AsString := ResultSet.Value[FDataModule.CDSNFe.FieldDefList[i].Name].AsString;
          end;
          FDataModule.CDSNFe.Post;

          {
          FDataModule.CDSNFe.Append;
          FDataModule.CDSNFe.FieldByName('ID').AsInteger                     := ResultSet.Value['ID'].AsInt32;
          FDataModule.CDSNFe.FieldByName('ID_PEDIDO_COMPRA').AsInteger       := ResultSet.Value['ID_PEDIDO_COMPRA'].AsInt32;
          FDataModule.CDSNFe.FieldByName('ID_VENDA_CABECALHO').AsInteger     := ResultSet.Value['ID_VENDA_CABECALHO'].AsInt32;
          FDataModule.CDSNFe.FieldByName('TIPO_OPERACAO').AsInteger          := ResultSet.Value['TIPO_OPERACAO'].AsInt32;
          FDataModule.CDSNFe.FieldByName('TIPO_DOCUMENTO').AsString          := ResultSet.Value['TIPO_DOCUMENTO'].AsString;
          FDataModule.CDSNFe.FieldByName('SERIE').AsString                   := ResultSet.Value['SERIE'].AsString;
          FDataModule.CDSNFe.FieldByName('SUBSERIE').AsString                := ResultSet.Value['SUBSERIE'].AsString;
          FDataModule.CDSNFe.FieldByName('NUMERO').AsString                  := ResultSet.Value['NUMERO'].AsString;
          FDataModule.CDSNFe.FieldByName('DATA_EMISSAO').AsDateTime          := ResultSet.Value['DATA_EMISSAO'].AsDateTime;
          FDataModule.CDSNFe.FieldByName('DATA_ENTRADA_SAIDA').AsDateTime    := ResultSet.Value['DATA_ENTRADA_SAIDA'].AsDateTime;
          FDataModule.CDSNFe.FieldByName('VALOR_TOTAL').AsFloat              := ResultSet.Value['VALOR_TOTAL'].AsDouble;
          FDataModule.CDSNFe.FieldByName('VALOR_FRETE').AsFloat              := ResultSet.Value['VALOR_FRETE'].AsDouble;
          FDataModule.CDSNFe.FieldByName('VALOR_SEGURO').AsFloat             := ResultSet.Value['VALOR_SEGURO'].AsDouble;
          FDataModule.CDSNFe.FieldByName('VALOR_DESCONTO_ACRESCIMO').AsFloat := ResultSet.Value['VALOR_DESCONTO_ACRESCIMO'].AsDouble;
          FDataModule.CDSNFe.FieldByName('VALOR_IPI').AsFloat                := ResultSet.Value['VALOR_IPI'].AsDouble;
          FDataModule.CDSNFe.FieldByName('VALOR_BASE_ST').AsFloat            := ResultSet.Value['VALOR_BASE_ST'].AsDouble;
          FDataModule.CDSNFe.FieldByName('VALOR_ST').AsFloat                 := ResultSet.Value['VALOR_ST'].AsDouble;
          FDataModule.CDSNFe.FieldByName('VALOR_OUTRAS').AsFloat             := ResultSet.Value['VALOR_OUTRAS'].AsDouble;
          FDataModule.CDSNFe.FieldByName('VALOR_ISS').AsFloat                := ResultSet.Value['VALOR_ISS'].AsDouble;
          FDataModule.CDSNFe.FieldByName('VALOR_PRESTACAO_SERVICO').AsFloat  := ResultSet.Value['VALOR_PRESTACAO_SERVICO'].AsDouble;
          FDataModule.CDSNFe.FieldByName('ISS_RETIDO').AsString              := ResultSet.Value['ISS_RETIDO'].AsString;
          FDataModule.CDSNFe.FieldByName('NUMERO_ECF').AsInteger             := ResultSet.Value['NUMERO_ECF'].AsInt32;
          FDataModule.CDSNFe.FieldByName('NUMERO_CUPOM_FISCAL').AsInteger    := ResultSet.Value['NUMERO_CUPOM_FISCAL'].AsInt32;
          FDataModule.CDSNFe.FieldByName('CHAVE_NFE').AsString               := ResultSet.Value['CHAVE_NFE'].AsString;
          FDataModule.CDSNFe.FieldByName('CFOP').AsInteger                   := ResultSet.Value['CFOP'].AsInt32;
          FDataModule.CDSNFe.FieldByName('SITUACAO').AsString                := ResultSet.Value['SITUACAO'].AsString;
          FDataModule.CDSNFe.FieldByName('RECIBONFE').AsString               := ResultSet.Value['RECIBONFE'].AsString;
          FDataModule.CDSNFe.FieldByName('PROTOCONFE').AsString              := ResultSet.Value['PROTOCONFE'].AsString;
          FDataModule.CDSNFe.FieldByName('DATATRANSMISSAO').Value            := ResultSet.Value['DATATRANSMISSAO'].ValueType;
          FDataModule.CDSNFe.FieldByName('RECIBOCANCELAMENTO').AsString      := ResultSet.Value['RECIBOCANCELAMENTO'].AsString;
          FDataModule.CDSNFe.FieldByName('DATACANCELAMENTO').Value           := ResultSet.Value['DATACANCELAMENTO'].ValueType;

          FDataModule.CDSNFe.Post;
          }
        end;
        //FDataModule.CDSNFe.Open;
        FDataModule.CDSNFe.EnableControls;
      end;

    except
    end;
  finally
    ResultSet.Free;
  end;
end;

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

class function TNFeCabecalhoController.getNfeSPED(pDataInicial,
  pDataFinal: String): TObjectList<TNFeCabecalhoVO>;
var
  ListaNfe: TObjectList<TNFeCabecalhoVO>;
  Nfe: TNFeCabecalhoVO;
  TotalRegistros: Integer;
  DataInicio, DataFim : String ;
begin
  try
    try

     DataInicio := QuotedStr(FormatDateTime('yyyy-mm-dd', StrToDate(pDataInicial)));
     DataFim := QuotedStr(FormatDateTime('yyyy-mm-dd', StrToDate(pDataFinal)));

        ConsultaSQL :=
                            ' select count(*) as total '+
                            ' from NFE_CABECALHO '+
                            ' where DATA_EMISSAO between '+QuotedStr(DataInicio)+' and '+QuotedStr(DataFim);
        Query := TSQLQuery.Create(nil);
        Query.SQLConnection := FDataModule.Conexao;
        Query.sql.Text := ConsultaSQL;
        Query.Open;
        TotalRegistros := Query.FieldByName('TOTAL').AsInteger;

     if TotalRegistros > 0 then
      if true then
        begin
            ListaNfe := TObjectList<TNfeCabecalhoVO>.Create;
            ConsultaSQL :=
                            ' select  ID, NATUREZA_OPERACAO, TIPO_OPERACAO, ID_CLIENTE, CODIGO_MODELO, SITUACAO_NOTA, SERIE, '+
                            ' NUMERO, CHAVE_NFE, DATA_EMISSAO, DATA_ENTRADA_SAIDA, VALOR_TOTAL, INDICADOR_FORMA_PAGAMENTO, VALOR_DESCONTO, '+
                            ' VALOR_TOTAL_PRODUTOS, VALOR_FRETE, VALOR_SEGURO, VALOR_DESPESAS_ACESSORIAS, BASE_CALCULO_ICMS, '+
                            ' VALOR_ICMS, BASE_CALCULO_ICMS_ST, VALOR_ICMS_ST, VALOR_IPI, VALOR_PIS, VALOR_COFINS '+
                            ' from NFE_CABECALHO '+
                            ' where DATA_EMISSAO between '+QuotedStr(DataInicio)+' and '+QuotedStr(DataFim);
            Query.sql.Text := ConsultaSQL;
            Query.Open;
            Query.First;

            while not Query.Eof do
            begin
              Nfe := TNfeCabecalhoVO.Create;
              Nfe.Id := Query.FieldByName('ID').AsInteger;
              Nfe.NaturezaOperacao := Query.FieldByName('NATUREZA_OPERACAO').AsString;
              Nfe.TipoOperacao := Query.FieldByName('TIPO_OPERACAO').AsString;
              Nfe.IdCliente := Query.FieldByName('ID_CLIENTE').AsInteger;
              Nfe.CodigoModelo := Query.FieldByName('CODIGO_MODELO').AsString;
              Nfe.SituacaoNota := Query.FieldByName('SITUACAO_NOTA').AsInteger;
              Nfe.Serie := Query.FieldByName('SERIE').AsString;
              Nfe.Numero := Query.FieldByName('NUMERO').AsString;
              Nfe.ChaveAcesso := Query.FieldByName('CHAVE_ACESSO').AsString;
              Nfe.DataEmissao := Query.FieldByName('DATA_EMISSAO').AsString;
              Nfe.DataEntradaSaida := Query.FieldByName('DATA_ENTRADA_SAIDA').AsString;
              Nfe.ValorTotal := Query.FieldByName('VALOR_TOTAL').AsFloat;
              Nfe.IndicadorFormaPagamento := Query.FieldByName('INDICADOR_FORMA_PAGAMENTO').AsString;
              Nfe.ValorDesconto := Query.FieldByName('VALOR_DESCONTO').AsFloat;
              Nfe.ValorTotalProdutos := Query.FieldByName('VALOR_TOTAL_PRODUTOS').AsFloat;
              Nfe.ValorFrete := Query.FieldByName('VALOR_FRETE').AsFloat;
              Nfe.ValorSeguro := Query.FieldByName('VALOR_SEGURO').AsFloat;
              Nfe.ValorDespesasAcessorias := Query.FieldByName('VALOR_DESPESAS_ACESSORIAS').AsFloat;
              Nfe.BaseCalculoIcms := Query.FieldByName('BASE_CALCULO_ICMS').AsFloat;
              Nfe.ValorIcms := Query.FieldByName('VALOR_ICMS').AsFloat;
              Nfe.BaseCalculoIcmsSt := Query.FieldByName('BASE_CALCULO_ICMS_ST').AsFloat;
              Nfe.ValorIcmsSt := Query.FieldByName('VALOR_ICMS_ST').AsFloat;
              Nfe.ValorIpi := Query.FieldByName('VALOR_IPI').AsFloat;
              Nfe.ValorPis := Query.FieldByName('VALOR_PIS').AsFloat;
              Nfe.ValorCofins := Query.FieldByName('VALOR_COFINS').AsFloat;


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


end.
