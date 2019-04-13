{*******************************************************************************
Title: T2Ti ERP
Description: Classe de controle do Parcelamento.

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

@author Albert Eije (T2Ti.COM) / Gilson Santos Lima
@version 1.0
*******************************************************************************}
unit ParcelaController;

interface

uses
  Forms, Classes, SQLExpr, SysUtils, ContasPagarReceberVO, ContasParcelasVO, Generics.Collections, UPaf;

type
  TParcelaController = class
  private
  protected
  public
    class function InserirCabecalho(pParcelaCabecalho: TContasPagarReceberVO): TContasPagarReceberVO;
    class procedure InserirDetalhe(pListaParcelaDetalhe: TObjectList<TContasParcelasVO>);
    class function RetornaCabecalhoDaParcela(var IdVenda: Integer): TContasPagarReceberVO;
    class function RetornaDetalheDaParcela(IdContas: Integer): TObjectList<TContasParcelasVO>;
    class procedure ImprimeParcelas(Nome, CPF, COO: String; ValorTotal: Extended; pListaParcelaDetalhe: TObjectList<TContasParcelasVO>);
  end;

implementation

uses UDataModule, Biblioteca, UCaixa;

var
  ConsultaSQL: String;
  Query: TSQLQuery;

class function TParcelaController.InserirCabecalho(pParcelaCabecalho: TContasPagarReceberVO): TContasPagarReceberVO;
begin
  ConsultaSQL :=
      'insert into CONTAS_PAGAR_RECEBER ('+
        'ID_ECF_VENDA_CABECALHO, '+
        'ID_PLANO_CONTAS, '+
        'ID_TIPO_DOCUMENTO, '+
        'ID_PESSOA, '+
        'TIPO, '+
        'NUMERO_DOCUMENTO, '+
        'VALOR, '+
        'DATA_LANCAMENTO, '+
        'PRIMEIRO_VENCIMENTO, '+
        'NATUREZA_LANCAMENTO, '+
        'QUANTIDADE_PARCELA) '+
      'values ('+
        ':pID_ECF_VENDA_CABECALHO, '+
        ':pID_PLANO_CONTAS, '+
        ':pID_TIPO_DOCUMENTO, '+
        ':pID_PESSOA, '+
        ':pTIPO, '+
        ':pNUMERO_DOCUMENTO, '+
        ':pVALOR, '+
        ':pDATA_LANCAMENTO, '+
        ':pPRIMEIRO_VENCIMENTO, '+
        ':pNATUREZA_LANCAMENTO, '+
        ':pQUANTIDADE_PARCELA) ';

  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;

      Query.ParamByName('pID_ECF_VENDA_CABECALHO').AsInteger := pParcelaCabecalho.IdEcfVendaCabecalho;
      Query.ParamByName('pID_PLANO_CONTAS').AsInteger := pParcelaCabecalho.IdPlanoContas;
      Query.ParamByName('pID_TIPO_DOCUMENTO').AsInteger := pParcelaCabecalho.IdTipoDocumento;
      Query.ParamByName('pID_PESSOA').AsInteger := pParcelaCabecalho.IdPessoa;
      Query.ParamByName('pTIPO').AsString := pParcelaCabecalho.Tipo;
      Query.ParamByName('pNUMERO_DOCUMENTO').AsString := pParcelaCabecalho.NumeroDocumento;
      Query.ParamByName('pVALOR').AsFloat := pParcelaCabecalho.Valor;
      Query.ParamByName('pDATA_LANCAMENTO').AsString := pParcelaCabecalho.DataLancamento;
      Query.ParamByName('pPRIMEIRO_VENCIMENTO').AsString := pParcelaCabecalho.PrimeiroVencimento;
      Query.ParamByName('pNATUREZA_LANCAMENTO').AsString := pParcelaCabecalho.NaturezaLancamento;
      Query.ParamByName('pQUANTIDADE_PARCELA').AsInteger := pParcelaCabecalho.QuantidadeParcela;
      Query.ExecSQL();

      ConsultaSQL := 'select max(ID) as ID from CONTAS_PAGAR_RECEBER';
      Query.sql.Text := ConsultaSQL;
      Query.Open();

      pParcelaCabecalho.Id := Query.FieldByName('ID').AsInteger;
      result := pParcelaCabecalho;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;

class procedure TParcelaController.InserirDetalhe(pListaParcelaDetalhe: TObjectList<TContasParcelasVO>);
var
  i: Integer;
  ParcelaDetalhe: TContasParcelasVO;
begin
  ConsultaSQL :='insert into CONTAS_PARCELAS ('+
                  'ID_CONTAS_PAGAR_RECEBER, '+
                  'ID_MEIOS_PAGAMENTO, '+
                  'ID_CHEQUE_EMITIDO, '+
                  'ID_CONTA_CAIXA, '+
                  'DATA_EMISSAO, '+
                  'DATA_VENCIMENTO, '+
                  'NUMERO_PARCELA, '+
                  'VALOR, '+
                  'TAXA_JUROS, '+
                  'TAXA_MULTA, '+
                  'TAXA_DESCONTO, '+
                  'VALOR_JUROS, '+
                  'VALOR_MULTA, '+
                  'VALOR_DESCONTO, '+
                  'TOTAL_PARCELA, '+
                  'HISTORICO, '+
                  'SITUACAO) '+
                'values ('+
                  ':pID_CONTAS_PAGAR_RECEBER, '+
                  ':pID_MEIOS_PAGAMENTO, '+
                  ':pID_CHEQUE_EMITIDO, '+
                  ':pID_CONTA_CAIXA, '+
                  ':pDATA_EMISSAO, '+
                  ':pDATA_VENCIMENTO, '+
                  ':pNUMERO_PARCELA, '+
                  ':pVALOR, '+
                  ':pTAXA_JUROS, '+
                  ':pTAXA_MULTA, '+
                  ':pTAXA_DESCONTO, '+
                  ':pVALOR_JUROS, '+
                  ':pVALOR_MULTA, '+
                  ':pVALOR_DESCONTO, '+
                  ':pTOTAL_PARCELA, '+
                  ':pHISTORICO, '+
                  ':pSITUACAO) ';
  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;

      for i := 0 to pListaParcelaDetalhe.Count-1 do
      begin
        ParcelaDetalhe := pListaParcelaDetalhe.Items[i];
        Query.sql.Text := ConsultaSQL;

        Query.ParamByName('pID_CONTAS_PAGAR_RECEBER').AsInteger := ParcelaDetalhe.IdContasPagarReceber;
        Query.ParamByName('pID_MEIOS_PAGAMENTO').AsInteger := ParcelaDetalhe.IdMeiosPagamento;
        Query.ParamByName('pID_CHEQUE_EMITIDO').AsInteger := ParcelaDetalhe.IdChequeEmitido;
        Query.ParamByName('pID_CONTA_CAIXA').AsInteger := ParcelaDetalhe.IdContaCaixa;
        Query.ParamByName('pDATA_EMISSAO').AsString := ParcelaDetalhe.DataEmissao;
        Query.ParamByName('pDATA_VENCIMENTO').AsString := ParcelaDetalhe.DataVencimento;
        Query.ParamByName('pNUMERO_PARCELA').AsInteger := ParcelaDetalhe.NumeroParcela;
        Query.ParamByName('pVALOR').AsFloat := ParcelaDetalhe.Valor;
        Query.ParamByName('pTAXA_JUROS').AsFloat := ParcelaDetalhe.TaxaJuros;
        Query.ParamByName('pTAXA_MULTA').AsFloat := ParcelaDetalhe.TaxaMulta;
        Query.ParamByName('pTAXA_DESCONTO').AsFloat := ParcelaDetalhe.TaxaDesconto;
        Query.ParamByName('pVALOR_JUROS').AsFloat := ParcelaDetalhe.ValorJuros;
        Query.ParamByName('pVALOR_MULTA').AsFloat := ParcelaDetalhe.ValorMulta;
        Query.ParamByName('pVALOR_DESCONTO').AsFloat := ParcelaDetalhe.ValorDesconto;
        Query.ParamByName('pTOTAL_PARCELA').AsFloat := ParcelaDetalhe.TotalParcela;
        Query.ParamByName('pHISTORICO').AsString := ParcelaDetalhe.Historico;
        Query.ParamByName('pSITUACAO').AsString := ParcelaDetalhe.Situacao;
        Query.ExecSQL();
      end;
    except
    end;
  finally
    Query.Free;
  end;
end;

class function TParcelaController.RetornaCabecalhoDaParcela(var IdVenda: Integer): TContasPagarReceberVO;
var
  ParcelaCabecalho: TContasPagarReceberVO;
begin

  ConsultaSQL := 'SELECT * FROM CONTAS_PAGAR_RECEBER WHERE ID_ECF_VENDA_CABECALHO = '+ IntToStr(IdVenda);

  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.open;

      if Query.IsEmpty then
      begin
       IdVenda:=0;
       Result := nil;
      end
      else
      begin
        ParcelaCabecalho := TContasPagarReceberVO.Create;

        ParcelaCabecalho.id := Query.FieldByName('ID').AsInteger;
        ParcelaCabecalho.IdEcfVendaCabecalho := Query.FieldByName('ID_ECF_VENDA_CABECALHO').AsInteger;
        ParcelaCabecalho.IdPlanoContas := Query.FieldByName('ID_PLANO_CONTAS').AsInteger;
        ParcelaCabecalho.IdTipoDocumento := Query.FieldByName('ID_TIPO_DOCUMENTO').AsInteger;
        ParcelaCabecalho.IdPessoa:= Query.FieldByName('ID_PESSOA').AsInteger;
        ParcelaCabecalho.Tipo := Query.FieldByName('TIPO').AsString;
        ParcelaCabecalho.NumeroDocumento := Query.FieldByName('NUMERO_DOCUMENTO').AsString;
        ParcelaCabecalho.Valor := Query.FieldByName('VALOR').AsFloat;
        ParcelaCabecalho.DataLancamento :=  DataParaTexto(Query.FieldByName('DATA_LANCAMENTO').AsDateTime);
        ParcelaCabecalho.PrimeiroVencimento := DataParaTexto(Query.FieldByName('PRIMEIRO_VENCIMENTO').AsDateTime);
        ParcelaCabecalho.NaturezaLancamento := Query.FieldByName('NATUREZA_LANCAMENTO').AsString;
        ParcelaCabecalho.QuantidadeParcela := Query.FieldByName('QUANTIDADE_PARCELA').AsInteger;

        Result := ParcelaCabecalho;
      end;
    except
      IdVenda:=0;
      Result := nil;
    end;
  finally
     Query.Free;
  end;
end;

class function TParcelaController.RetornaDetalheDaParcela(IdContas: Integer): TObjectList<TContasParcelasVO>;
var
  ListaParcela: TObjectList<TContasParcelasVO>;
  ParcelaDetalhe: TContasParcelasVO;
  temp:string;
begin

  ConsultaSQL :=
    'select '+
    'ID, '+
    'ID_CONTAS_PAGAR_RECEBER, '+
    'ID_MEIOS_PAGAMENTO, '+
    'ID_CHEQUE_EMITIDO, '+
    'ID_CONTA_CAIXA, '+
    'DATA_EMISSAO, '+
    'DATA_VENCIMENTO, '+
    'NUMERO_PARCELA, '+
    'VALOR, '+
    'TAXA_JUROS, '+
    'TAXA_MULTA, '+
    'TAXA_DESCONTO, '+
    'VALOR_JUROS, '+
    'VALOR_MULTA, '+
    'VALOR_DESCONTO, '+
    'TOTAL_PARCELA, '+
    'HISTORICO, '+
    'SITUACAO '+
    ' from CONTAS_PARCELAS where ID_CONTAS_PAGAR_RECEBER = '+ IntToStr(IdContas);

  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;

      if Query.IsEmpty then
      begin
        Result := nil;
      end
      else
      begin
        ListaParcela := TObjectList<TContasParcelasVO>.Create;
        Query.First;

        while not Query.Eof do
        begin
          ParcelaDetalhe := TContasParcelasVO.Create;

          ParcelaDetalhe.Id := Query.FieldByName('ID').AsInteger;
          ParcelaDetalhe.IdContasPagarReceber := Query.FieldByName('ID_CONTAS_PAGAR_RECEBER').AsInteger;
          ParcelaDetalhe.IdMeiosPagamento := Query.FieldByName('ID_MEIOS_PAGAMENTO').AsInteger;
          ParcelaDetalhe.IdChequeEmitido := Query.FieldByName('ID_CHEQUE_EMITIDO').AsInteger;
          ParcelaDetalhe.IdContaCaixa := Query.FieldByName('ID_CONTA_CAIXA').AsInteger;
          ParcelaDetalhe.DataEmissao := DataParaTexto(Query.FieldByName('DATA_EMISSAO').AsDateTime);
          ParcelaDetalhe.DataVencimento :=DataParaTexto(Query.FieldByName('DATA_VENCIMENTO').AsDateTime);
          ParcelaDetalhe.NumeroParcela := Query.FieldByName('NUMERO_PARCELA').AsInteger;
          ParcelaDetalhe.Valor := Query.FieldByName('VALOR').AsCurrency;
          ParcelaDetalhe.TaxaJuros := Query.FieldByName('TAXA_JUROS').AsCurrency;
          ParcelaDetalhe.TaxaMulta := Query.FieldByName('TAXA_MULTA').AsCurrency;
          ParcelaDetalhe.TaxaDesconto := Query.FieldByName('TAXA_DESCONTO').AsCurrency;
          ParcelaDetalhe.ValorJuros := Query.FieldByName('VALOR_JUROS').AsCurrency;
          ParcelaDetalhe.ValorMulta := Query.FieldByName('VALOR_MULTA').AsCurrency;
          ParcelaDetalhe.ValorDesconto := Query.FieldByName('VALOR_DESCONTO').AsCurrency;
          ParcelaDetalhe.TotalParcela := Query.FieldByName('TOTAL_PARCELA').AsCurrency;
          ParcelaDetalhe.Historico := Query.FieldByName('HISTORICO').AsString;
          ParcelaDetalhe.Situacao := Query.FieldByName('SITUACAO').AsString;

          ListaParcela.Add(ParcelaDetalhe);
          Query.next;
        end;
        result := ListaParcela;
      end;
    except
      IdContas:=0;
      Result := nil;
    end;
  finally
    Query.Free;
  end;
end;


class procedure TParcelaController.ImprimeParcelas(Nome, CPF, COO: String; ValorTotal: Extended; pListaParcelaDetalhe: TObjectList<TContasParcelasVO>);
var
  i, Elementos, Linhas, Adicional: integer;
  ParcelaDetalhe: TContasParcelasVO;
  Valor, Parcela, Vencimento, Tupla, PathContrato : String;
  ContratoParcela: TextFile;
  sContrato : AnsiString;
begin
  PathContrato := ExtractFilePath(Application.ExeName)+'Banco\Contrato.txt';
  AssignFile(ContratoParcela,PathContrato);
  Application.ProcessMessages;

  sContrato:='';
  if FileExists(PathContrato) then
  begin
    try
      Reset(ContratoParcela);
      While not Eof(ContratoParcela) do
      begin
        Read(ContratoParcela, Tupla);
        sContrato:= sContrato+Tupla;
        Readln(ContratoParcela);
      end;
    finally
      CloseFile(ContratoParcela);
      Application.ProcessMessages;
    end;
  end else
  begin
    sContrato:='Pelo presente instrumento particular de Confissão e Assunção de '+
    'Dívida que entre si fazem, de um lado, <NomeCliente>, inscrito no '+
    'CPF sob o nº <CPFCliente>, aqui designada simplesmente DEVEDORA e, de outro'+
    'lado, <QualificaEmpresa>, doravante denominada simplesmente CREDORA, '+
    'pactuam a CONFISSÃO E ASSUNÇÃO DE DÍVIDA, segundo as cláusulas e condições abaixo enumeradas:'+
    '01- A CREDORA ajustou com a DEVEDORA venda de mercadoria de acordo com Cupom Fiscal nº <COO>, '+
    'em data de <DataVenda>, no qual esta assumiu débito no valor de <ValorTotalVenda>; '+
    '02- Reconhecendo seu débito - em sua certeza, liquidez e exigibilidade -, a DEVEDORA se '+
    'compromete a pagar a quantia da seguinte forma:';
  end;

  sContrato := StringReplace(sContrato, '<NomeCliente>', Nome, [rfReplaceAll]);
  sContrato := StringReplace(sContrato, '<CPFCliente>', CPF, [rfReplaceAll]);
  sContrato := StringReplace(sContrato, '<QualificaEmpresa>', Configuracao.TituloTelaCaixa, [rfReplaceAll]);
  sContrato := StringReplace(sContrato, '<COO>', COO, [rfReplaceAll]);
  sContrato := StringReplace(sContrato, '<DataVenda>', FormatDateTime('dd/mm/yyyy',FDataModule.ACBrECF.ECF.DataHora), [rfReplaceAll]);
  sContrato := StringReplace(sContrato, '<ValorTotalVenda>', (Format('%.2m',[valortotal])+'('+mc_ValorExtenso(valortotal)+')'), [rfReplaceAll]);


  // INICIO CABEÇALHO
  FDataModule.ACBrECF.AbreRelatorioGerencial();
  FDataModule.ACBrECF.LinhaRelatorioGerencial(StringOfChar('=',48));
  FDataModule.ACBrECF.LinhaRelatorioGerencial('        TERMO DE COMPROMISSO CONTRATUAL         ');
  FDataModule.ACBrECF.PulaLinhas(1);
  // FIM CABEÇALHO

  // INICIO CONTRATO PARAMETRIZADO
  Elementos := Length(sContrato);  // Quantas letras tem o contrato
  Linhas    := Elementos div 48;   // divide pelo numero de colunas, no caso 48
  Adicional := Elementos mod 48;   // Caso sobre algo da divisao, indica que ha mais uma linha a ser impressa.

  if Adicional > 0 then
    Linhas := Linhas + 1;

  Elementos := 1; // Estou reaproveitando esta variável para fazer outro controle.

  For i := 1 to Linhas do
  begin
    FDataModule.ACBrECF.LinhaRelatorioGerencial(Copy(sContrato,Elementos,48));
    Elementos := Elementos + 48;
  end;

  FDataModule.ACBrECF.PulaLinhas(2);
  // FIM CONTRATO PARAMETRIZADO


  // INICIO PARCELAS
  FDataModule.ACBrECF.LinhaRelatorioGerencial(StringOfChar('_',48));
  FDataModule.ACBrECF.LinhaRelatorioGerencial('            VALOR       PARCELA    VENCIMENTO   ');
  FDataModule.ACBrECF.LinhaRelatorioGerencial(StringOfChar('_',48));

  for i := 0 to pListaParcelaDetalhe.Count-1 do
  begin
    ParcelaDetalhe := pListaParcelaDetalhe.Items[i];

    Valor := FloatToStrF(ParcelaDetalhe.Valor,ffNumber,15,2);
    Valor := StringOfChar(' ', 17 - Length(Valor)) + Valor;
    Parcela := IntToStr(ParcelaDetalhe.NumeroParcela);
    Parcela := StringOfChar(' ', 11 - Length(Parcela)) + Parcela;
    Vencimento := FormatDateTime('dd/mm/yyyy',(TextoParaData(ParcelaDetalhe.DataVencimento)));
    Vencimento := StringOfChar(' ', 17 - Length(Vencimento)) + Vencimento;

    FDataModule.ACBrECF.LinhaRelatorioGerencial(Valor+Parcela+Vencimento);
  end;

  FDataModule.ACBrECF.PulaLinhas(4);
  // FIM PARCELAS


  // INICIO RODAPÉ
  FDataModule.ACBrECF.LinhaRelatorioGerencial('    ________________________________________    ');
  FDataModule.ACBrECF.LinhaRelatorioGerencial(Copy(Nome,1,40));
  FDataModule.ACBrECF.LinhaRelatorioGerencial(CPF);
  FDataModule.ACBrECF.PulaLinhas(2);
  FDataModule.ACBrECF.LinhaRelatorioGerencial(StringOfChar('=',48));
  FDataModule.ACBrECF.FechaRelatorio;
  UPAF.GravaR06('RG');
end;

end.
