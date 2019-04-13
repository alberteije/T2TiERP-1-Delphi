{*******************************************************************************
Title: T2Ti ERP
Description: Classe de controle do Registro R.

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

{*******************************************************************************
Observações importantes

Registro tipo R01 - Identificação do ECF, do Usuário, do PAF-ECF e da Empresa Desenvolvedora e Dados do Arquivo;
Registro tipo R02 - Relação de Reduções Z;
Registro tipo R03 - Detalhe da Redução Z;
Registro tipo R04 - Cupom Fiscal, Nota Fiscal de Venda a Consumidor ou Bilhete de Passagem;
Registro tipo R05 - Detalhe do Cupom Fiscal, da Nota Fiscal de Venda a Consumidor ou do Bilhete de Passagem;
Registro tipo R06 - Demais documentos emitidos pelo ECF;
Registro tipo R07 - Detalhe do Cupom Fiscal e do Documento Não Fiscal - Meio de Pagamento;
Registro EAD - Assinatura digital.

Numa venda com cartão teremos:
-Um R04 referente ao Cupom Fiscal (já gravamos no venda_cabecalho)
-Um R05 para cada item vendido  (já gravamos no venda_detalhe)
-Um R06 para o Comprovante de Crédito ou Débito (o CCD se encaixa como "outros documentos emitidos");
-Um R07 referente à forma de pagamento utilizada no Cupom Fiscal, no caso, Cartão.
*******************************************************************************}

unit RegistroRController;

interface

uses
  Classes, SQLExpr, SysUtils, R01VO, R02VO, R03VO, R04VO, R05VO, R06VO, R07VO,
  Generics.Collections, Biblioteca, Constantes,Forms;

type
  TRegistroRController = class
  protected
  public
    class function GravaR02(R02: TR02VO): TR02VO;
    class procedure GravaR03(ListaR03: TObjectList<TR03VO>);
    class procedure GravaR06(R06: TR06VO);
    class procedure GravaR07(R07: TR07VO);
    class function TabelaR02(DataInicio: String; DataFim: String; IdImpressora: Integer): TObjectList<TR02VO>;
    class function TabelaR02Id(Id: Integer): TObjectList<TR02VO>;
    class function TabelaR03(Id: Integer): TObjectList<TR03VO>;
    class function TabelaR04(DataInicio: String; DataFim: String; IdImpressora: Integer): TObjectList<TR04VO>; overload;
    class function TabelaR04(DataInicio: String; DataFim: String): TObjectList<TR04VO>; overload;
    class function TabelaR05(Id: Integer; QuemChamou: String): TObjectList<TR05VO>;
    class function TabelaR06(DataInicio: String; DataFim: String; IdImpressora: Integer): TObjectList<TR06VO>;
    class function TabelaR07IdR06(Id: Integer): TObjectList<TR07VO>;
    class function TabelaR07IdR04(Id: Integer): TObjectList<TR07VO>;
    class function RegistroR01: TR01VO;
    class function TotalR02(DataInicio: String; DataFim: String): Integer;
    class procedure IntegracaoR02(Id: Integer);
    class procedure IntegracaoR03(ListaR03: TObjectList<TR03VO>);
    class procedure IntegracaoR06(Id: Integer; R06: TR06VO; HashTripa: String);
    class procedure IntegracaoR07(R07: TR07VO);
  end;

implementation

uses UDataModule, UCaixa, ImpressoraVO, ImpressoraController;

var
  ConsultaSQL: String;
  Query: TSQLQuery;


class function TRegistroRController.GravaR02(R02: TR02VO): TR02VO;
var
  Tripa, Hash: String;
  Impressora: TImpressoraVO;
begin
  ConsultaSQL :=
    'insert into R02 (' +
    'ID_OPERADOR,' +
    'ID_IMPRESSORA,' +
    'ID_ECF_CAIXA,' +
    'SERIE_ECF,' +
    'CRZ,' +
    'COO,' +
    'CRO,' +
    'DATA_MOVIMENTO,' +
    'DATA_EMISSAO,' +
    'HORA_EMISSAO,' +
    'VENDA_BRUTA,' +
    'GRANDE_TOTAL) values (' +
    ':pIdOperador,' +
    ':pIdImpressora,' +
    ':pIdCaixa,' +
    ':pSerieEcf,' +
    ':pCRZ,' +
    ':pCOO,' +
    ':pCRO,' +
    ':pDataMovimento,' +
    ':pDataEmissao,' +
    ':pHoraEmissao,' +
    ':pVendaBruta,' +
    ':pGrandeTotal)';

  try
    try
      Impressora := TImpressoraController.PegaImpressora(UCaixa.Configuracao.IdImpressora);

      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.ParamByName('pIdOperador').AsInteger := R02.IdOperador;
      Query.ParamByName('pIdImpressora').AsInteger := R02.IdImpressora;
      Query.ParamByName('pIdCaixa').AsInteger := R02.IdCaixa;
      Query.ParamByName('pSerieEcf').AsString := Impressora.Serie;
      Query.ParamByName('pCRZ').AsInteger := R02.CRZ;
      Query.ParamByName('pCOO').AsInteger := R02.COO;
      Query.ParamByName('pCRO').AsInteger := R02.CRO;
      Query.ParamByName('pDataMovimento').AsString := R02.DataMovimento;
      Query.ParamByName('pDataEmissao').AsString := R02.DataEmissao;
      Query.ParamByName('pHoraEmissao').AsString := R02.HoraEmissao;
      Query.ParamByName('pVendaBruta').AsFloat := R02.VendaBruta;
      Query.ParamByName('pGrandeTotal').AsFloat := R02.GrandeTotal;
      Query.ExecSQL();

      ConsultaSQL := 'select max(ID) as ID from R02';
      Query.sql.Text := ConsultaSQL;
      Query.Open();

      R02.Id := Query.FieldByName('ID').AsInteger;

      Query.Free();

      //calcula e grava o hash
      Tripa :=  IntToStr(R02.Id) +
                IntToStr(R02.IdOperador) +
                IntToStr(R02.IdImpressora) +
                IntToStr(R02.IdCaixa) +
                IntToStr(R02.CRZ) +
                IntToStr(R02.COO) +
                IntToStr(R02.CRO) +
                R02.DataMovimento +
                R02.DataEmissao +
                R02.HoraEmissao +
                FormataFloat('V',R02.VendaBruta) +
                FormataFloat('V',R02.GrandeTotal) +
                Impressora.Serie +
                '0';

      Hash := MD5String(Tripa);

      ConsultaSQL :=
        'update R02 set ' +
        'HASH_TRIPA=:pHash, ' +
        'HASH_INCREMENTO = :pHashIncremento ' +
        ' where ID = :pId';

      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.ParamByName('pHash').AsString := Hash;
      Query.ParamByName('pHashIncremento').AsInteger := -1;
      Query.ParamByName('pId').AsInteger := R02.Id;
      Query.ExecSQL();

      result := R02;
    except
    end;
  finally
    Query.Free;
  end;
end;

class procedure TRegistroRController.GravaR03(ListaR03: TObjectList<TR03VO>);
var
  i: Integer;
  Tripa, Hash: String;
  Impressora: TImpressoraVO;
begin
  for i := 0 to ListaR03.Count - 1 do
  begin
    ConsultaSQL :=
    'insert into R03 (' +
    'ID_R02,' +
    'CRZ,' +
    'SERIE_ECF,' +
    'TOTALIZADOR_PARCIAL,' +
    'VALOR_ACUMULADO, HASH_TRIPA) values (' +
    ':pIdR02,' +
    ':pCRZ,' +
    ':pSerieEcf,' +
    ':pTotalizadorParcial,' +
    ':pValorAcumulado,'+
    ':pHash)';
    try
      try
        Impressora := TImpressoraController.PegaImpressora(UCaixa.Configuracao.IdImpressora);
        //calcula e grava o hash
        Tripa := TR03VO(ListaR03.Items[i]).TotalizadorParcial +
                 FormataFloat('V',TR03VO(ListaR03.Items[i]).ValorAcumulado) +
                 IntToStr(TR03VO(ListaR03.Items[i]).CRZ) +
                 Impressora.Serie +
                 '0';
        Hash := MD5String(Tripa);

        Query := TSQLQuery.Create(nil);
        Query.SQLConnection := FDataModule.Conexao;
        Query.sql.Text := ConsultaSQL;
        Query.ParamByName('pIdR02').AsInteger := TR03VO(ListaR03.Items[i]).IdR02;
        Query.ParamByName('pCRZ').AsInteger := TR03VO(ListaR03.Items[i]).CRZ;
        Query.ParamByName('pSerieEcf').AsString := Impressora.Serie;
        Query.ParamByName('pTotalizadorParcial').AsString := TR03VO(ListaR03.Items[i]).TotalizadorParcial;
        Query.ParamByName('pValorAcumulado').AsFloat := TR03VO(ListaR03.Items[i]).ValorAcumulado;
        Query.ParamByName('pHash').AsString := Hash;
        Query.ExecSQL();
      except
      end;
    finally
      Query.Free;
    end;
  end;
end;

class procedure TRegistroRController.GravaR06(R06: TR06VO);
var
  Tripa, Hash: String;
  Impressora: TImpressoraVO;
begin
  ConsultaSQL :=
  'insert into R06 (' +
  'ID_OPERADOR,' +
  'ID_IMPRESSORA,' +
  'ID_ECF_CAIXA,' +
  'SERIE_ECF,' +
  'COO,' +
  'GNF,' +
  'GRG,' +
  'CDC,' +
  'DENOMINACAO,' +
  'DATA_EMISSAO,' +
  'HORA_EMISSAO,' +
  'HASH_TRIPA) values (' +
  ':pIdOperador,' +
  ':pIdImpressora,' +
  ':pIdCaixa,' +
  ':pSerieEcf,' +
  ':pCOO,' +
  ':pGNF,' +
  ':pGRG,' +
  ':pCDC,' +
  ':pDenominacao,' +
  ':pDataEmissao,' +
  ':pHoraEmissao,' +
  ':pHash)';

  try
    try
      Impressora := TImpressoraController.PegaImpressora(UCaixa.Configuracao.IdImpressora);
      //calcula e grava o hash
      Tripa := IntToStr(R06.COO) +
               IntToStr(R06.GNF) +
               IntToStr(R06.GRG) +
               IntToStr(R06.CDC) +
               R06.Denominacao +
               R06.DataEmissao +
               R06.HoraEmissao +
               Impressora.Serie +
               '0';

      Hash := MD5String(Tripa);

      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.ParamByName('pIdOperador').AsInteger := R06.IdOperador;
      Query.ParamByName('pIdImpressora').AsInteger := R06.IdImpressora;
      Query.ParamByName('pIdCaixa').AsInteger := R06.IdCaixa;
      Query.ParamByName('pCOO').AsInteger := R06.COO;
      Query.ParamByName('pGNF').AsInteger := R06.GNF;
      Query.ParamByName('pGRG').AsInteger := R06.GRG;
      Query.ParamByName('pCDC').AsInteger := R06.CDC;
      Query.ParamByName('pDenominacao').AsString := R06.Denominacao;
      Query.ParamByName('pDataEmissao').AsString := R06.DataEmissao;
      Query.ParamByName('pHoraEmissao').AsString := R06.HoraEmissao;
      Query.ParamByName('pSerieEcf').AsString := Impressora.Serie;
      Query.ParamByName('pHash').AsString := Hash;
      Query.ExecSQL();

      ConsultaSQL := 'select max(ID) as ID from R06';
      Query.sql.Text := ConsultaSQL;
      Query.Open();

      IntegracaoR06(query.FieldByName('ID').AsInteger, R06,Hash);
    except
    end;
  finally
    Query.Free;
  end;
end;

class procedure TRegistroRController.GravaR07(R07: TR07VO);
begin
  ConsultaSQL :=
  'insert into R07 (' +
  'MEIO_PAGAMENTO,' +
  'VALOR_PAGAMENTO,' +
  'ESTORNO,' +
  'VALOR_ESTORNO) values (' +
  ':pMeioPagamento,' +
  ':pValorPagamento,' +
  ':pIndicadorEstorno,' +
  ':pValorEstorno)';

  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.ParamByName('pMeioPagamento').AsString := R07.MeioPagamento;
      Query.ParamByName('pValorPagamento').AsFloat := R07.ValorPagamento;
      Query.ParamByName('pIndicadorEstorno').AsString := R07.IndicadorEstorno;
      Query.ParamByName('pValorEstorno').AsFloat := R07.ValorEstorno;
      Query.ExecSQL();
    except
    end;
  finally
    Query.Free;
  end;
end;

class function TRegistroRController.TabelaR02(DataInicio: String; DataFim: String; IdImpressora: Integer): TObjectList<TR02VO>;
var
  ListaR02: TObjectList<TR02VO>;
  R02: TR02VO;
  TotalRegistros: Integer;
begin
  DataInicio := FormatDateTime('yyyy-mm-dd', StrToDate(DataInicio));
  DataFim := FormatDateTime('yyyy-mm-dd', StrToDate(DataFim));

  ConsultaSQL := 'select count(*) as TOTAL from R02 where ' +
    'ID_IMPRESSORA=' + IntToStr(idImpressora) +
    ' and  DATA_MOVIMENTO between ' +
    QuotedStr(DataInicio) + ' and ' + QuotedStr(DataFim);
  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      TotalRegistros := Query.FieldByName('TOTAL').AsInteger;
      if TotalRegistros > 0 then
      begin
        ListaR02 := TObjectList<TR02VO>.Create;
        ConsultaSQL := 'select * from R02 where ' +
        'ID_IMPRESSORA=' + IntToStr(idImpressora) +
        ' and (DATA_MOVIMENTO between ' +
        QuotedStr(DataInicio) + ' and ' + QuotedStr(DataFim) + ')';
        Query.sql.Text := ConsultaSQL;
        Query.Open;
        Query.First;
        while not Query.Eof do
        begin
          R02 := TR02VO.Create;
          R02.Id := Query.FieldByName('ID').AsInteger;
          R02.IdOperador := Query.FieldByName('ID_OPERADOR').AsInteger;
          R02.IdImpressora := Query.FieldByName('ID_IMPRESSORA').AsInteger;
          R02.IdCaixa := Query.FieldByName('ID_ECF_CAIXA').AsInteger;
          R02.SerieEcf := Query.FieldByName('SERIE_ECF').AsString;
          R02.CRZ := Query.FieldByName('CRZ').AsInteger;
          R02.COO := Query.FieldByName('COO').AsInteger;
          R02.CRO := Query.FieldByName('CRO').AsInteger;
          R02.DataMovimento := Query.FieldByName('DATA_MOVIMENTO').AsString;
          R02.DataEmissao := Query.FieldByName('DATA_EMISSAO').AsString;
          R02.HoraEmissao := Query.FieldByName('HORA_EMISSAO').AsString;
          R02.VendaBruta := Query.FieldByName('VENDA_BRUTA').AsFloat;
          R02.GrandeTotal := Query.FieldByName('GRANDE_TOTAL').AsFloat;
          R02.HashTripa := Query.FieldByName('HASH_TRIPA').AsString;
          R02.HashIncremento := Query.FieldByName('HASH_INCREMENTO').AsInteger;
          ListaR02.Add(R02);
          Query.next;
        end;
        result := ListaR02;
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

class function TRegistroRController.TabelaR02Id(Id: Integer): TObjectList<TR02VO>;
var
  ListaR02: TObjectList<TR02VO>;
  R02: TR02VO;
  TotalRegistros: Integer;
begin
  ConsultaSQL := 'select count(*) as TOTAL from R02 where ID_IMPRESSORA=' + IntToStr(Id);
  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      TotalRegistros := Query.FieldByName('TOTAL').AsInteger;
      if TotalRegistros > 0 then
      begin
        ListaR02 := TObjectList<TR02VO>.Create;

        ConsultaSQL := 'select * from R02 where ID_IMPRESSORA=' + IntToStr(Id);
        Query.sql.Text := ConsultaSQL;
        Query.Open;
        Query.First;
        while not Query.Eof do
        begin
          R02 := TR02VO.Create;
          R02.Id := Query.FieldByName('ID').AsInteger;
          R02.IdOperador := Query.FieldByName('ID_OPERADOR').AsInteger;
          R02.IdImpressora := Query.FieldByName('ID_IMPRESSORA').AsInteger;
          R02.IdCaixa := Query.FieldByName('ID_ECF_CAIXA').AsInteger;
          R02.CRZ := Query.FieldByName('CRZ').AsInteger;
          R02.COO := Query.FieldByName('COO').AsInteger;
          R02.CRO := Query.FieldByName('CRO').AsInteger;
          R02.DataMovimento := Query.FieldByName('DATA_MOVIMENTO').AsString;
          R02.DataEmissao := Query.FieldByName('DATA_EMISSAO').AsString;
          R02.HoraEmissao := Query.FieldByName('HORA_EMISSAO').AsString;
          R02.VendaBruta := Query.FieldByName('VENDA_BRUTA').AsFloat;
          R02.GrandeTotal := Query.FieldByName('GRANDE_TOTAL').AsFloat;
          R02.HashTripa := Query.FieldByName('HASH_TRIPA').AsString;
          R02.HashIncremento := Query.FieldByName('HASH_INCREMENTO').AsInteger;
          ListaR02.Add(R02);
          Query.next;
        end;
        result := ListaR02;
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

class function TRegistroRController.TabelaR03(Id: Integer): TObjectList<TR03VO>;
var
  ListaR03: TObjectList<TR03VO>;
  R03: TR03VO;
  TotalRegistros: Integer;
begin
  ConsultaSQL := 'select count(*) AS TOTAL from R03 where ID_R02='+IntToStr(Id);
  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      TotalRegistros := Query.FieldByName('TOTAL').AsInteger;

      if TotalRegistros > 0 then
      begin
        ListaR03 := TObjectList<TR03VO>.Create;

        ConsultaSQL := 'select * from R03 where ID_R02='+IntToStr(Id);

        Query.sql.Text := ConsultaSQL;
        Query.Open;
        Query.First;
        while not Query.Eof do
        begin
          R03 := TR03VO.Create;
          R03.Id := Query.FieldByName('ID').AsInteger;
          R03.IdR02 := Query.FieldByName('ID_R02').AsInteger;
          R03.SerieEcf := Query.FieldByName('SERIE_ECF').AsString;
          R03.TotalizadorParcial := Query.FieldByName('TOTALIZADOR_PARCIAL').AsString;
          R03.ValorAcumulado := Query.FieldByName('VALOR_ACUMULADO').AsFloat;
          R03.CRZ := Query.FieldByName('CRZ').AsInteger;
          R03.HashTripa := Query.FieldByName('HASH_TRIPA').AsString;
          R03.HashIncremento := Query.FieldByName('HASH_INCREMENTO').AsInteger;
          ListaR03.Add(R03);
          Query.next;
        end;
        result := ListaR03;
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

class function TRegistroRController.TabelaR04(DataInicio:String; DataFim:String; idImpressora: Integer): TObjectList<TR04VO>;
var
  ListaR04: TObjectList<TR04VO>;
  R04: TR04VO;
  TotalRegistros: Integer;
begin
  DataInicio := FormatDateTime('yyyy-mm-dd', StrToDate(DataInicio));
  DataFim := FormatDateTime('yyyy-mm-dd', StrToDate(DataFim));

  ConsultaSQL :=
    'select count(*) as TOTAL ' +
    'from VIEW_R04 '+
    'where ID_ECF_IMPRESSORA=' + IntToStr(idImpressora) +
    ' and (DATA_VENDA between ' +
    QuotedStr(DataInicio) + ' and ' + QuotedStr(DataFim) + ')';
  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      TotalRegistros := Query.FieldByName('TOTAL').AsInteger;

      if TotalRegistros > 0 then
      begin
        ListaR04 := TObjectList<TR04VO>.Create;

        ConsultaSQL :=
          'select * from VIEW_R04 ' +
          'where ID_ECF_IMPRESSORA=' + IntToStr(idImpressora) +
          ' and (DATA_VENDA between ' +
          QuotedStr(DataInicio) + ' and ' + QuotedStr(DataFim) + ')';

        Query.sql.Text := ConsultaSQL;
        Query.Open;
        Query.First;
        while not Query.Eof do
        begin
          R04 := TR04VO.Create;
          R04.Id := Query.FieldByName('VCID').AsInteger;
          R04.IdOperador := Query.FieldByName('ID_ECF_OPERADOR').AsInteger;
          R04.SerieEcf := Query.FieldByName('SERIE_ECF').AsString;
          R04.CCF := Query.FieldByName('CCF').AsInteger;
          R04.COO := Query.FieldByName('COO').AsInteger;
          R04.DataEmissao := Query.FieldByName('DATA_VENDA').AsString;
          R04.SubTotal := Query.FieldByName('VALOR_VENDA').AsFloat;
          R04.Desconto := Query.FieldByName('DESCONTO').AsFloat;
          R04.IndicadorDesconto := 'V';
          R04.Acrescimo := Query.FieldByName('ACRESCIMO').AsFloat;
          R04.IndicadorAcrescimo := 'V';
          R04.ValorLiquido := Query.FieldByName('VALOR_FINAL').AsFloat;
          R04.PIS := Query.FieldByName('PIS').AsFloat;
          R04.COFINS := Query.FieldByName('COFINS').AsFloat;
          R04.Cancelado := Query.FieldByName('CUPOM_CANCELADO').AsString;
          R04.CancelamentoAcrescimo := 0;
          R04.OrdemDescontoAcrescimo := 'D';
          R04.Cliente := Query.FieldByName('NOME_CLIENTE').AsString;
          R04.CPFCNPJ := Query.FieldByName('CPF_CNPJ_CLIENTE').AsString;
          R04.HashTripa := Query.FieldByName('HASH_TRIPA').AsString;
          R04.HashIncremento := Query.FieldByName('HASH_INCREMENTO').AsInteger;
          R04.StatusVenda := Query.FieldByName('STATUS_VENDA').AsString;
          ListaR04.Add(R04);
          Query.next;
        end;
        result := ListaR04;
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

class function TRegistroRController.TabelaR04(DataInicio:String; DataFim:String): TObjectList<TR04VO>;
var
  ListaR04: TObjectList<TR04VO>;
  R04: TR04VO;
  TotalRegistros: Integer;
begin
  DataInicio := FormatDateTime('yyyy-mm-dd', StrToDate(DataInicio));
  DataFim := FormatDateTime('yyyy-mm-dd', StrToDate(DataFim));

  ConsultaSQL :=
    'select count(*) as TOTAL ' +
    'from VIEW_R04 '+
    ' where DATA_HORA_VENDA between ' +
    QuotedStr(DataInicio) + ' and ' + QuotedStr(DataFim);
  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      TotalRegistros := Query.FieldByName('TOTAL').AsInteger;

      if TotalRegistros > 0 then
      begin
        ListaR04 := TObjectList<TR04VO>.Create;

        ConsultaSQL :=
          'select * from VIEW_R04 ' +
          ' where DATA_HORA_VENDA between ' +
          QuotedStr(DataInicio) + ' and ' + QuotedStr(DataFim);

        Query.sql.Text := ConsultaSQL;
        Query.Open;
        Query.First;
        while not Query.Eof do
        begin
          R04 := TR04VO.Create;
          R04.Id := Query.FieldByName('VCID').AsInteger;
          R04.IdOperador := Query.FieldByName('ID_ECF_OPERADOR').AsInteger;
          R04.SerieEcf := Query.FieldByName('SERIE_ECF').AsString;
          R04.CCF := Query.FieldByName('CCF').AsInteger;
          R04.COO := Query.FieldByName('COO').AsInteger;
          R04.DataEmissao := Query.FieldByName('DATA_HORA_VENDA').AsString;
          R04.SubTotal := Query.FieldByName('VALOR_VENDA').AsFloat;
          R04.Desconto := Query.FieldByName('DESCONTO').AsFloat;
          R04.IndicadorDesconto := 'V';
          R04.Acrescimo := Query.FieldByName('ACRESCIMO').AsFloat;
          R04.IndicadorAcrescimo := 'V';
          R04.ValorLiquido := Query.FieldByName('VALOR_FINAL').AsFloat;
          R04.PIS := Query.FieldByName('PIS').AsFloat;
          R04.COFINS := Query.FieldByName('COFINS').AsFloat;
          R04.Cancelado := Query.FieldByName('CUPOM_CANCELADO').AsString;
          R04.CancelamentoAcrescimo := 0;
          R04.OrdemDescontoAcrescimo := 'D';
          R04.Cliente := Query.FieldByName('NOME_CLIENTE').AsString;
          R04.CPFCNPJ := Query.FieldByName('CPF_CNPJ_CLIENTE').AsString;
          R04.HashTripa := Query.FieldByName('HASH_TRIPA').AsString;
          R04.HashIncremento := Query.FieldByName('HASH_INCREMENTO').AsInteger;
          R04.StatusVenda := Query.FieldByName('STATUS_VENDA').AsString;
          ListaR04.Add(R04);
          Query.next;
        end;
        result := ListaR04;
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

class function TRegistroRController.TabelaR05(Id: Integer; QuemChamou: String): TObjectList<TR05VO>;
var
  ListaR05: TObjectList<TR05VO>;
  R05: TR05VO;
  TotalRegistros : Integer;
begin
  ConsultaSQL :=
    'select count(*) as TOTAL '+
    'from VIEW_R05 ' +
    'where VCID=' +IntToStr(Id);

  try
    try
      Query := TSQLQuery.Create(nil);
      Query.ParamCheck := True;
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      TotalRegistros := Query.FieldByName('TOTAL').AsInteger;

      if TotalRegistros > 0 then
      begin
        ListaR05 := TObjectList<TR05VO>.Create;

        if QuemChamou = 'Sped' then
        begin
          ConsultaSQL :=
            'select * from VIEW_R05 ' +
            'where cancelado <> ' + QuotedStr('S') + ' and VCID=' +IntToStr(Id);
        end
        else if QuemChamou = 'Paf' then
        begin
          ConsultaSQL :=
            'select * from VIEW_R05 ' +
            'where VCID=' +IntToStr(Id);
        end;

        Query.sql.Text := ConsultaSQL;
        Query.Open;
        Query.First;
        while not Query.Eof do
        begin
          R05 := TR05VO.Create;

          R05.Id := Query.FieldByName('VID').AsInteger;
          R05.Item := Query.FieldByName('ITEM').AsInteger;
          R05.SerieEcf := Query.FieldByName('SERIE_ECF').AsString;
          R05.IdProduto := Query.FieldByName('ID_ECF_PRODUTO').AsInteger;
          R05.GTIN := Query.FieldByName('GTIN').AsString;
          R05.Ccf := Query.FieldByName('CCF').AsInteger;
          R05.Coo := Query.FieldByName('COO').AsInteger;
          R05.DescricaoPDV := Query.FieldByName('DESCRICAO_PDV').AsString;
          R05.Quantidade := TruncaValor(Query.FieldByName('QUANTIDADE').AsFloat,Constantes.TConstantes.DECIMAIS_QUANTIDADE);
          R05.IdUnidade := Query.FieldByName('ID_UNIDADE').AsInteger;
          R05.SiglaUnidade := Query.FieldByName('SIGLA_UNIDADE').AsString;
          R05.ValorUnitario := TruncaValor(Query.FieldByName('VALOR_UNITARIO').AsFloat,Constantes.TConstantes.DECIMAIS_VALOR);
          R05.Desconto := TruncaValor(Query.FieldByName('DESCONTO').AsFloat,Constantes.TConstantes.DECIMAIS_VALOR);
          R05.Acrescimo := TruncaValor(Query.FieldByName('ACRESCIMO').AsFloat,Constantes.TConstantes.DECIMAIS_VALOR);
          R05.TotalItem := TruncaValor(Query.FieldByName('TOTAL_ITEM').AsFloat,Constantes.TConstantes.DECIMAIS_VALOR);
          R05.TotalizadorParcial := Query.FieldByName('TOTALIZADOR_PARCIAL').AsString;
          R05.IndicadorCancelamento := Query.FieldByName('CANCELADO').AsString;
          if R05.IndicadorCancelamento = 'S' then
            R05.QuantidadeCancelada := TruncaValor(Query.FieldByName('QUANTIDADE').AsFloat,Constantes.TConstantes.DECIMAIS_QUANTIDADE)
          else
            R05.QuantidadeCancelada := 0;
          if R05.IndicadorCancelamento = 'S' then
            R05.ValorCancelado := Query.FieldByName('TOTAL_ITEM').AsFloat
          else
            R05.ValorCancelado := 0;
          R05.CancelamentoAcrescimo := 0;
          R05.IAT := Query.FieldByName('IAT').AsString;
          R05.IPPT := Query.FieldByName('IPPT').AsString;
          R05.CasasDecimaisQuantidade := 3;
          R05.CasasDecimaisValor := 2;
          R05.CST := Query.FieldByName('CST').AsString;
          R05.CFOP := Query.FieldByName('CFOP').AsInteger;
          R05.AliquotaICMS := Query.FieldByName('TAXA_ICMS').AsFloat;
          R05.PIS := Query.FieldByName('PIS').AsFloat;
          R05.COFINS := Query.FieldByName('COFINS').AsFloat;
          R05.HashTripa := Query.FieldByName('HASH_TRIPA').AsString;
          R05.HashIncremento := Query.FieldByName('HASH_INCREMENTO').AsInteger;

          ListaR05.Add(R05);
          Query.next;
        end;
        result := ListaR05;
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

class function TRegistroRController.TabelaR06(DataInicio:String; DataFim:String; idImpressora: Integer): TObjectList<TR06VO>;
var
  ListaR06: TObjectList<TR06VO>;
  R06: TR06VO;
  TotalRegistros: Integer;
begin
  DataInicio := FormatDateTime('yyyy-mm-dd', StrToDate(DataInicio));
  DataFim := FormatDateTime('yyyy-mm-dd', StrToDate(DataFim));

  ConsultaSQL := 'select count(*) as TOTAL from R06 where ' +
  'ID_IMPRESSORA=' + IntToStr(idImpressora) +
  ' and (DATA_EMISSAO between ' +
    QuotedStr(DataInicio) + ' and ' + QuotedStr(DataFim) + ')';

  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      TotalRegistros := Query.FieldByName('TOTAL').AsInteger;
      if TotalRegistros > 0 then
      begin
        ListaR06 := TObjectList<TR06VO>.Create;

        ConsultaSQL := 'select * from R06 where ' +
        'ID_IMPRESSORA=' + IntToStr(idImpressora) +
        ' and (DATA_EMISSAO between ' +
          QuotedStr(DataInicio) + ' and ' + QuotedStr(DataFim) + ')';
        Query.sql.Text := ConsultaSQL;
        Query.Open;
        Query.First;
        while not Query.Eof do
        begin
          R06 := TR06VO.Create;
          R06.Id := Query.FieldByName('ID').AsInteger;
          R06.IdOperador := Query.FieldByName('ID_OPERADOR').AsInteger;
          R06.IdImpressora := Query.FieldByName('ID_IMPRESSORA').AsInteger;
          R06.IdCaixa := Query.FieldByName('ID_ECF_CAIXA').AsInteger;
          R06.COO := Query.FieldByName('COO').AsInteger;
          R06.GNF := Query.FieldByName('GNF').AsInteger;
          R06.GRG := Query.FieldByName('GRG').AsInteger;
          R06.CDC := Query.FieldByName('CDC').AsInteger;
          R06.Denominacao := Query.FieldByName('DENOMINACAO').AsString;
          R06.DataEmissao := DataParaTexto(StrToDate(Query.FieldByName('DATA_EMISSAO').AsString));
          R06.HoraEmissao := Query.FieldByName('HORA_EMISSAO').AsString;
          R06.SerieEcf := Query.FieldByName('SERIE_ECF').AsString;
          R06.HashTripa := Query.FieldByName('HASH_TRIPA').AsString;
          R06.HashIncremento := Query.FieldByName('HASH_INCREMENTO').AsInteger;
          ListaR06.Add(R06);
          Query.next;
        end;
        result := ListaR06;
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

class function TRegistroRController.TabelaR07IdR06(Id: Integer): TObjectList<TR07VO>;
var
  ListaR07: TObjectList<TR07VO>;
  R07: TR07VO;
  TotalRegistros: Integer;
begin
  ConsultaSQL := 'select count(*) as TOTAL from R07 where ID_R06='+IntToStr(Id);
  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      TotalRegistros := Query.FieldByName('TOTAL').AsInteger;

      if TotalRegistros > 0 then
      begin
        ListaR07 := TObjectList<TR07VO>.Create;

        ConsultaSQL := 'select * from R07 where ID_R06='+IntToStr(Id);
        Query.sql.Text := ConsultaSQL;
        Query.Open;
        Query.First;
        while not Query.Eof do
        begin
          R07 := TR07VO.Create;
          R07.IdR06 := Id;
          R07.CCF := Query.FieldByName('CCF').AsInteger;
          R07.MeioPagamento := Query.FieldByName('MEIO_PAGAMENTO').AsString;
          R07.ValorPagamento := Query.FieldByName('VALOR_PAGAMENTO').AsFloat;
          R07.IndicadorEstorno := Query.FieldByName('ESTORNO').AsString;
          R07.ValorEstorno := Query.FieldByName('VALOR_ESTORNO').AsFloat;
          ListaR07.Add(R07);
          Query.next;
        end;
        result := ListaR07;
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

class function TRegistroRController.TabelaR07IdR04(Id: Integer): TObjectList<TR07VO>;
var
  ListaR07: TObjectList<TR07VO>;
  R07: TR07VO;
  TotalRegistros: Integer;
begin
  ConsultaSQL :=
    'select count(*) as TOTAL '+
    'from '+
    'ECF_VENDA_CABECALHO VC, ECF_TIPO_PAGAMENTO TP, ECF_TOTAL_TIPO_PGTO TTP '+
    'where '+
    'TTP.ID_ECF_VENDA_CABECALHO = VC.ID '+
    'and TTP.ID_ECF_TIPO_PAGAMENTO = TP.ID '+
    'and VC.ID = ' + IntToStr(Id);

  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      TotalRegistros := Query.FieldByName('TOTAL').AsInteger;

      if TotalRegistros > 0 then
      begin
        ListaR07 := TObjectList<TR07VO>.Create;

        ConsultaSQL :=
          'select '+
          'VC.ID AS VCID, TTP.HASH_TRIPA, TTP.HASH_INCREMENTO, TTP.CCF, TTP.COO, TTP.GNF, '+
          'TTP.SERIE_ECF, TP.DESCRICAO, TTP.VALOR, TTP.ESTORNO '+
          'from '+
          'ECF_VENDA_CABECALHO VC, ECF_TIPO_PAGAMENTO TP, ECF_TOTAL_TIPO_PGTO TTP '+
          'where '+
          'TTP.ID_ECF_VENDA_CABECALHO = VC.ID '+
          'and TTP.ID_ECF_TIPO_PAGAMENTO = TP.ID '+
          'and VC.ID = ' + IntToStr(Id);

        Query.sql.Text := ConsultaSQL;
        Query.Open;
        Query.First;
        while not Query.Eof do
        begin
          R07 := TR07VO.Create;
          R07.Coo := Query.FieldByName('COO').AsInteger;
          R07.Ccf := Query.FieldByName('CCF').AsInteger;
          R07.Gnf := Query.FieldByName('GNF').AsInteger;
          R07.SerieEcf := Query.FieldByName('SERIE_ECF').AsString;
          R07.HashTripa := Query.FieldByName('HASH_TRIPA').AsString;
          R07.HashIncremento := Query.FieldByName('HASH_INCREMENTO').AsInteger;
          R07.MeioPagamento := Query.FieldByName('DESCRICAO').AsString;
          R07.ValorPagamento := Query.FieldByName('VALOR').AsFloat;
          R07.IndicadorEstorno := Query.FieldByName('ESTORNO').AsString;
          R07.ValorEstorno := 0;
          ListaR07.Add(R07);
          Query.next;
        end;
        result := ListaR07;
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

class function TRegistroRController.RegistroR01: TR01VO;
var
  R01: TR01VO;
begin
  try
    try
      ConsultaSQL := 'select * from R01';
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      Query.First;

      R01 := TR01VO.Create;
      R01.Id := Query.FieldByName('ID').AsInteger;
      R01.SerieEcf := Query.FieldByName('SERIE_ECF').AsString;
      R01.CnpjEmpresa := Query.FieldByName('CNPJ_EMPRESA').AsString;
      R01.CnpjSh := Query.FieldByName('CNPJ_SH').AsString;
      R01.InscricaoEstadualSh := Query.FieldByName('INSCRICAO_ESTADUAL_SH').AsString;
      R01.InscricaoMunicipalSh := Query.FieldByName('INSCRICAO_MUNICIPAL_SH').AsString;
      R01.DenominacaoSh := Query.FieldByName('DENOMINACAO_SH').AsString;
      R01.NomePafEcf := Query.FieldByName('NOME_PAF_ECF').AsString;
      R01.VersaoPafEcf := Query.FieldByName('VERSAO_PAF_ECF').AsString;
      R01.Md5PafEcf := Query.FieldByName('MD5_PAF_ECF').AsString;
      R01.DataInicial := Query.FieldByName('DATA_INICIAL').AsString;
      R01.DataFinal := Query.FieldByName('DATA_FINAL').AsString;
      R01.VersaoEr := Query.FieldByName('VERSAO_ER').AsString;
      R01.NumeroLaudoPaf := Query.FieldByName('NUMERO_LAUDO_PAF').AsString;
      R01.RazaoSocialSh := Query.FieldByName('RAZAO_SOCIAL_SH').AsString;
      R01.EnderecoSh := Query.FieldByName('ENDERECO_SH').AsString;
      R01.NumeroSh := Query.FieldByName('NUMERO_SH').AsString;
      R01.ComplementoSh := Query.FieldByName('COMPLEMENTO_SH').AsString;
      R01.BairroSh := Query.FieldByName('BAIRRO_SH').AsString;
      R01.CidadeSh := Query.FieldByName('CIDADE_SH').AsString;
      R01.CepSh := Query.FieldByName('CEP_SH').AsString;
      R01.UfSh := Query.FieldByName('UF_SH').AsString;
      R01.TelefoneSh := Query.FieldByName('TELEFONE_SH').AsString;
      R01.ContatoSh := Query.FieldByName('CONTATO_SH').AsString;
      R01.PrincipalExecutavel := Query.FieldByName('PRINCIPAL_EXECUTAVEL').AsString;
      R01.HashTripa := Query.FieldByName('HASH_TRIPA').AsString;
      R01.HashIncremento := Query.FieldByName('HASH_INCREMENTO').AsInteger;

      result := R01;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;

class function TRegistroRController.TotalR02(DataInicio:String; DataFim:String): Integer;
var
  TotalRegistros: Integer;
begin
  DataInicio := FormatDateTime('yyyy-mm-dd', StrToDate(DataInicio));
  DataFim := FormatDateTime('yyyy-mm-dd', StrToDate(DataFim));

  ConsultaSQL :=
    'select count(*) as total from r02 ' +
    'where data_movimento between ' +
    QuotedStr(DataInicio) + ' and ' + QuotedStr(DataFim) + ')';
  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      TotalRegistros := Query.FieldByName('TOTAL').AsInteger;

      result := TotalRegistros;
    except
      result := 0;
    end;
  finally
    Query.Free;
  end;
end;

class procedure TRegistroRController.IntegracaoR02(Id: Integer);
var
  PathR0, Identificacao, Caixa: string;
  atR0: TextFile;
begin

  ConsultaSQL := 'Select * from R02 where ID ='+IntToStr(Id);
  try
    try
      Query.sql.Text := ConsultaSQL;
      Query.Open();
      if not Query.IsEmpty then
      begin
        Caixa := Configuracao.NomeCaixa;
        Identificacao:='E'+IntToStr(Configuracao.IdEmpresa)+'X'+DevolveInteiro(caixa)+'R02'+IntToStr(Id)+'D'+DevolveInteiro(DateTimeToStr(now));

        PathR0 := ExtractFilePath(Application.ExeName)+'Script\R0.txt';
        AssignFile(atR0,PathR0);
        Application.ProcessMessages;

        if FileExists(PathR0) then
          Append(atR0)
        else
          Rewrite(atR0);

        Write(
          atR0,'R02|'+
          Identificacao+'|'+
          caixa+'|'+
          trim(Query.FieldByName('ID').AsString)+'|'+
          trim(Query.FieldByName('ID_OPERADOR').AsString)+'|'+
          trim(Query.FieldByName('ID_IMPRESSORA').AsString)+'|'+
          trim(Query.FieldByName('ID_ECF_CAIXA').AsString)+'|'+
          trim(Query.FieldByName('CRZ').AsString)+'|'+
          trim(Query.FieldByName('COO').AsString)+'|'+
          trim(Query.FieldByName('CRO').AsString)+'|'+
          trim(Query.FieldByName('DATA_MOVIMENTO').AsString)+'|'+
          trim(Query.FieldByName('DATA_EMISSAO').AsString)+'|'+
          trim(Query.FieldByName('HORA_EMISSAO').AsString)+'|'+
          trim(Query.FieldByName('VENDA_BRUTA').AsString)+'|'+
          trim(Query.FieldByName('GRANDE_TOTAL').AsString)+'|'+
          trim(Query.FieldByName('SINCRONIZADO').AsString)+'|'+
          trim(Query.FieldByName('HASH_TRIPA').AsString)
        );
        Writeln(atR0);
        CloseFile(atR0);
        Application.ProcessMessages;
        FCaixa.ExportaParaRetaguarda('R0.txt',3);
      end;
    except
    end;
  finally
     query.Free;
  end;
end;


class procedure TRegistroRController.IntegracaoR03(ListaR03: TObjectList<TR03VO>);
begin
//
end;

class procedure TRegistroRController.IntegracaoR06(Id: Integer;R06: TR06VO;HashTripa:string);
var
  PathR0, Identificacao, Caixa: string;
  atR0: TextFile;
begin
  try
    Caixa := Configuracao.NomeCaixa;
    Identificacao:='E'+IntToStr(Configuracao.IdEmpresa)+'X'+DevolveInteiro(caixa)+'R02'+IntToStr(Id)+'D'+DevolveInteiro(DateTimeToStr(now));

    PathR0 := ExtractFilePath(Application.ExeName)+'Script\R0.txt';
    AssignFile(atR0,PathR0);
    Application.ProcessMessages;

    if FileExists(PathR0) then
      Append(atR0)
    else
      Rewrite(atR0);

    Write(
      atR0,'R02|'+
      Identificacao+'|'+
      caixa+'|'+
      IntToStr(R06.Id)+'|'+
      IntToStr(R06.IdCaixa)+'|'+
      IntToStr(R06.IdOperador)+'|'+
      IntToStr(R06.IdImpressora)+'|'+
      IntToStr(R06.COO)+'|'+
      IntToStr(R06.GNF)+'|'+
      IntToStr(R06.GRG)+'|'+
      IntToStr(R06.CDC)+'|'+
      R06.Denominacao+'|'+
      R06.DataEmissao+'|'+
      R06.HoraEmissao+'|'+
      R06.Sincronizado+'|'+
      HashTripa+'|'
    );
    Writeln(atR0);
    Application.ProcessMessages;
  finally
    CloseFile(atR0);
    FCaixa.ExportaParaRetaguarda('R0.txt',3);
  end;
end;

class procedure TRegistroRController.IntegracaoR07(R07: TR07VO);
begin
 // não esta em uso nesta versão
end;

end.
