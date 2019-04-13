{*******************************************************************************
Title: T2Ti ERP
Description: Unit de controle da tabela Nota_Fiscal_Detalhe

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
unit NotaFiscalDetalheController;

interface

uses
  Classes, Dialogs, SysUtils, DBClient, DB, Windows, Forms, DBXCommon,
  NotaFiscalDetalheVO, Generics.Collections, SqlExpr;

type
  TNotaFiscalDetalheController = class
  private
  protected
  public
    class Procedure Consulta(pFiltro: String; pPagina: Integer; pLookup: Boolean);
    //class procedure Insere(pNFeDetalhe: TNotaFiscalDetalheVO); static;
    class procedure Altera(pNFeDetalhe: TNotaFiscalDetalheVO; pFiltro: String; pPagina: Integer); static;
    class procedure Exclui(pId: Integer); static;

    class procedure Insere(pNFeDetalhe: TNotaFiscalDetalheVO; pListaParcelas: TObjectList<TNotaFiscalDetalheVO>);

    class Function getNfeDetalheSPED(id : string): TObjectList<TNotaFiscalDetalheVO>;

  end;

implementation

uses UDataModule, T2TiORM;

var
  NFeDetalhe: TNotaFiscalDetalheVO;
  ConsultaSQL: string;
  Query: TSQLQuery;

class procedure TNotaFiscalDetalheController.Consulta(pFiltro: String; pPagina: Integer; pLookup: Boolean);
var
  ResultSet : TDBXReader;
begin
  try
    try
      ConsultaSQL := 'select * from nota_fical_cabecalho';

      pFiltro := StringReplace(pFiltro,'*','%',[rfReplaceAll]);
      //ResultSet := TT2TiORM.Consultar(TNotaFiscalCabecalhoVO.Create, pFiltro, pPagina);
      ResultSet := TT2TiORM.Consultar(ConsultaSQL,pFiltro,pPagina);

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
          FDataModule.CDSNFeItens.FieldByName('ID').AsInteger                       := ResultSet.Value['ID'].AsInt32;
          FDataModule.CDSNFeItens.FieldByName('ID_NOTA_FISCAL_CABECALHO').AsInteger := ResultSet.Value['ID_NOTA_FISCAL_CABECALHO'].AsInt32;
          FDataModule.CDSNFeItens.FieldByName('ID_PRODUTO').AsInteger               := ResultSet.Value['ID_PRODUTO'].AsInt32;
          FDataModule.CDSNFeItens.FieldByName('CFOP').AsInteger                     := ResultSet.Value['CFOP'].AsInt32;
          FDataModule.CDSNFeItens.FieldByName('CST_A').AsString                     := ResultSet.Value['CST_A'].AsString;
          FDataModule.CDSNFeItens.FieldByName('CST_B').AsString                     := ResultSet.Value['CST_B'].AsString;
          FDataModule.CDSNFeItens.FieldByName('QUANTIDADE').AsFloat                 := ResultSet.Value['QUANTIDADE'].AsDouble;
          FDataModule.CDSNFeItens.FieldByName('VALOR_TOTAL_ITEM').AsFloat           := ResultSet.Value['VALOR_TOTAL_ITEM'].AsDouble;
          FDataModule.CDSNFeItens.FieldByName('VALOR_ICMS').AsFloat                 := ResultSet.Value['VALOR_ICMS'].AsDouble;
          FDataModule.CDSNFeItens.FieldByName('ALIQUOTA_ICMS').AsFloat              := ResultSet.Value['ALIQUOTA_ICMS'].AsDouble;
          FDataModule.CDSNFeItens.FieldByName('VALOR_BC_ICMS').AsFloat              := ResultSet.Value['VALOR_BC_ICMS'].AsDouble;
          FDataModule.CDSNFeItens.FieldByName('VALOR_BC_ICMS_ST').AsFloat           := ResultSet.Value['VALOR_BC_ICMS_ST'].AsDouble;
          FDataModule.CDSNFeItens.FieldByName('VALOR_ICMS_ST').AsFloat              := ResultSet.Value['VALOR_ICMS_ST'].AsDouble;
          FDataModule.CDSNFeItens.FieldByName('MVA_ALIQUOTA').AsFloat               := ResultSet.Value['MVA_ALIQUOTA'].AsDouble;
          FDataModule.CDSNFeItens.FieldByName('VALOR_PAUTA').AsFloat                := ResultSet.Value['VALOR_PAUTA'].AsDouble;
          FDataModule.CDSNFeItens.FieldByName('MVA_AJUSTADA').AsFloat               := ResultSet.Value['MVA_AJUSTADA'].AsDouble;
          FDataModule.CDSNFeItens.FieldByName('ALIQUOTA_IPI').AsFloat               := ResultSet.Value['ALIQUOTA_IPI'].AsDouble;
          FDataModule.CDSNFeItens.FieldByName('VALOR_IPI_ITEM').AsFloat             := ResultSet.Value['VALOR_IPI_ITEM'].AsDouble;
          FDataModule.CDSNFeItens.FieldByName('VALOR_FRETE_ITEM').AsFloat           := ResultSet.Value['VALOR_FRETE_ITEM'].AsDouble;
          FDataModule.CDSNFeItens.FieldByName('VALOR_SEGURO_ITEM').AsFloat          := ResultSet.Value['VALOR_SEGURO_ITEM'].AsDouble;
          FDataModule.CDSNFeItens.FieldByName('VALOR_DESCONTO_ITEM').AsFloat        := ResultSet.Value['VALOR_DESCONTO_ITEM'].AsDouble;
          FDataModule.CDSNFeItens.FieldByName('CST_PIS').AsString                   := ResultSet.Value['CST_PIS'].AsString;
          FDataModule.CDSNFeItens.FieldByName('CST_COFINS').AsString                := ResultSet.Value['CST_COFINS'].AsString;
          FDataModule.CDSNFeItens.FieldByName('CST_IPI').AsString                   := ResultSet.Value['CST_IPI'].AsString;
          FDataModule.CDSNFeItens.FieldByName('BASE_PIS').AsFloat                   := ResultSet.Value['BASE_PIS'].AsDouble;
          FDataModule.CDSNFeItens.FieldByName('BASE_COFINS').AsFloat                := ResultSet.Value['SITUACAO'].AsDouble;
          FDataModule.CDSNFeItens.FieldByName('VALOR_OUTRAS_ITEM').AsFloat          := ResultSet.Value['RECIBONFE'].AsDouble;
          FDataModule.CDSNFeItens.FieldByName('MOVIMENTA_ESTOQUE').AsString         := ResultSet.Value['MOVIMENTA_ESTOQUE'].AsString;

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

{
class procedure TNotaFiscalDetalheController.Insere(pNFeDetalhe: TNotaFiscalDetalheVO);
var
  UltimoID:Integer;
begin
  try
    try
      UltimoID := TT2TiORM.Inserir(pNFeDetalhe);
      pNFeDetalhe.ID := UltimoID;
    except
      Application.MessageBox('Ocorreu um erro. Inclusão não realizada.', 'Erro do sistema', MB_OK + MB_ICONERROR);
    end;
  finally
  end;
end;
}

class procedure TNotaFiscalDetalheController.Altera(
  pNFeDetalhe: TNotaFiscalDetalheVO; pFiltro: String; pPagina: Integer);
begin
  try
    try
      TT2TiORM.Alterar(pNFeDetalhe);
    except
      Application.MessageBox('Ocorreu um erro. Alteração não realizada.', 'Erro do sistema', MB_OK + MB_ICONERROR);
    end;
  finally
  end;
end;


class procedure TNotaFiscalDetalheController.Exclui(pId: Integer);
begin
  try
    try
      NFeDetalhe  := TNotaFiscalDetalheVO.Create;
      NFeDetalhe.Id := pId;
      TT2TiORM.Excluir(NFeDetalhe);
    except
      Application.MessageBox('Ocorreu um erro na exclusão do cliente.', 'Erro do sistema', MB_OK + MB_ICONERROR);
    end;
  finally
  end;

end;

class function TNotaFiscalDetalheController.getNfeDetalheSPED(
  id: string): TObjectList<TNotaFiscalDetalheVO>;
var
  ListaNfe: TObjectList<TNotaFiscalDetalheVO>;
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
            ListaNfe := TObjectList<TNotaFiscalDetalheVO>.Create;
            ConsultaSQL :=
                            ' select ID, CST_A, CFOP, ALIQUOTA_ICMS, VALOR_TOTAL, BASE_CALCULO_ICMS, VALOR_ICMS, BASE_CALCULO_ICMS_ST, ALIQUOTA_ICMS_ST,  VALOR_IPI '+
                            ' from nfe_detalhe '+
                            ' where ID_NFE_CABECALHO='+ID;
            Query.sql.Text := ConsultaSQL;
            Query.Open;
            Query.First;

            while not Query.Eof do
            begin
              NfeDetalhe := TNotaFiscalDetalheVO.Create;
              NFeDetalhe.Id             := Query.FieldByName('ID').AsInteger;
              {TODO : verificar qual das classeficacoes deve ser usada}
              NFeDetalhe.CstA           := Query.FieldByName('CST_A').AsString;
              NFeDetalhe.Cfop           := Query.FieldByName('CFOP').AsInteger;
              NFeDetalhe.AliquotaIcms   := Query.FieldByName('ALIQUOTA_ICMS').AsFloat;
              NFeDetalhe.ValorTotalItem := Query.FieldByName('VALOR_TOTAL').AsFloat;
              NFeDetalhe.ValorBcIcms    := Query.FieldByName('BASE_CALCULO_ICMS').AsFloat;
              NFeDetalhe.ValorIcms      := Query.FieldByName('VALOR_ICMS').AsFloat;
              NFeDetalhe.ValorBcIcmsSt  := Query.FieldByName('BASE_CALCULO_ICMS_ST').AsFloat;
              NFeDetalhe.ValorIcmsSt    := Query.FieldByName('ALIQUOTA_ICMS_ST').AsFloat;

              {TODO : verifica necessidade de criar esse campo [VL_RED_BC] )}
              NFeDetalhe.ValorIpiItem   := Query.FieldByName('VALOR_IPI').AsFloat;
              ListaNfe.Add(NFeDetalhe);
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

class procedure TNotaFiscalDetalheController.Insere(
  pNFeDetalhe: TNotaFiscalDetalheVO;
  pListaParcelas: TObjectList<TNotaFiscalDetalheVO>);
var
  I, UltimoID: Integer;
  NFeDetalhe: TNotaFiscalDetalheVO;
begin
  try
    try
      DecimalSeparator := '.';
      UltimoID := TT2TiORM.Inserir(pNFeDetalhe);

      for I := 0 to pListaParcelas.Count - 1 do
      begin
        NFeDetalhe    := pListaParcelas.Items[i];
        NFeDetalhe.Id := UltimoID;
        TT2TiORM.Inserir(NFeDetalhe);
      end;
      DecimalSeparator := ',';

      Consulta('ID='+IntToStr(UltimoID),0,False);
    except
      Application.MessageBox('Ocorreu um erro. Inclusão não realizada.', 'Erro do sistema', MB_OK + MB_ICONERROR);
    end;
  finally
  end;
end;

end.
