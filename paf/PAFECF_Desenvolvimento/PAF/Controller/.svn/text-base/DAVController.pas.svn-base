{*******************************************************************************
Title: T2Ti ERP
Description: Classe de controle do DAV.

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
unit DAVController;

interface

uses
  Classes, SQLExpr, SysUtils, DAVDetalheVO, Generics.Collections, DB, Biblioteca,
  dialogs, DavCabecalhoVO;

type
  TDAVController = class
  protected
  public
    class function CarregaDAV(Id: Integer): TObjectList<TDAVDetalheVO>;
    class procedure FechaDAV(Id: Integer; CCF: Integer; COO: Integer);
    class procedure MesclaDAV(ListaDAVCabecalho:TObjectList<TDavCabecalhoVO>; ListaDAVDetalhe:TObjectList<TDAVDetalheVO>; ValorNovoDav: Extended);
    class function ListaDAVPeriodo(DataInicio:String; DataFim:String): TObjectList<TDavCabecalhoVO>;
    class function ConsultaDAVId(Id: Integer): TDavCabecalhoVO;
    class function ListaDavDetalhe(Id: Integer): TObjectList<TDavDetalheVO>;
  end;

implementation

uses UDataModule, UCaixa, ClienteVO, Constantes;

var
  ConsultaSQL: String;
  Query: TSQLQuery;

class function TDAVController.CarregaDAV(Id: Integer): TObjectList<TDAVDetalheVO>;
var
  ListaDAV: TObjectList<TDAVDetalheVO>;
  DAVDetalhe: TDAVDetalheVO;
  TotalRegistros: Integer;
begin
  //verifica se existe o DAV solicitado
  ConsultaSQL :=
    'select count(*) as TOTAL from DAV_CABECALHO ' +
    'where SITUACAO <> ' + QuotedStr('E') + ' and SITUACAO <> ' + QuotedStr('M') + ' and ID=' + IntToStr(Id);

  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.ConexaoBalcao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      TotalRegistros := Query.FieldByName('TOTAL').AsInteger;

      // caso exista o DAV, procede com a importação do mesmo
      if TotalRegistros > 0 then
      begin
        //verifica se existem itens para o DAV
        ConsultaSQL :=
          'select count(*) as TOTAL from DAV_DETALHE where ID_DAV_CABECALHO='+IntToStr(Id);
        Query.sql.Text := ConsultaSQL;
        Query.Open;
        TotalRegistros := Query.FieldByName('TOTAL').AsInteger;

        //caso existam itens no detalhe
        if TotalRegistros > 0 then
        begin
          // carrega cliente do DAV
          UCaixa.Cliente := TClienteVO.Create;
          ConsultaSQL :=
            'select * from DAV_CABECALHO where ID='+IntToStr(Id);
          Query.sql.Text := ConsultaSQL;
          Query.Open;
          UCaixa.Cliente.Id := Query.FieldByName('ID_PESSOA').AsInteger;
          UCaixa.Cliente.Nome := Query.FieldByName('NOME_DESTINATARIO').AsString;
          UCaixa.Cliente.CPFOuCNPJ := Query.FieldByName('CPF_CNPJ_DESTINATARIO').AsString;

          // carrega desconto ou acrescimo
          UCaixa.Desconto := Query.FieldByName('DESCONTO').AsFloat;
          UCaixa.Acrescimo := Query.FieldByName('ACRESCIMO').AsFloat;

          ListaDAV := TObjectList<TDAVDetalheVO>.Create;

          ConsultaSQL :=
            'select * from DAV_DETALHE where ID_DAV_CABECALHO='+IntToStr(Id);
          Query.sql.Text := ConsultaSQL;
          Query.Open;
          Query.First;
          while not Query.Eof do
          begin
            DAVDetalhe := TDAVDetalheVO.Create;
            DAVDetalhe.Id := Query.FieldByName('ID').AsInteger;
            DAVDetalhe.IdDavCabecalho := Id;
            DAVDetalhe.IdProduto := Query.FieldByName('ID_PRODUTO').AsInteger;
            DAVDetalhe.Item := Query.FieldByName('ITEM').AsInteger;
            DAVDetalhe.Quantidade := Query.FieldByName('QUANTIDADE').AsInteger;
            DAVDetalhe.ValorUnitario := Query.FieldByName('VALOR_UNITARIO').AsFloat;
            DAVDetalhe.ValorTotal := Query.FieldByName('VALOR_TOTAL').AsFloat;
            DAVDetalhe.Cancelado := Query.FieldByName('CANCELADO').AsString;
            DAVDetalhe.MesclaProduto := Query.FieldByName('MESCLA_PRODUTO').AsString;
            DAVDetalhe.GtinProduto := Query.FieldByName('GTIN_PRODUTO').AsString;
            DAVDetalhe.NomeProduto := Query.FieldByName('NOME_PRODUTO').AsString;
            DAVDetalhe.UnidadeProduto := Query.FieldByName('UNIDADE_PRODUTO').AsString;
            DAVDetalhe.TotalizadorParcial := Query.FieldByName('TOTALIZADOR_PARCIAL').AsString;
            ListaDAV.Add(DAVDetalhe);
            Query.next;
          end;
          result := ListaDAV;
        end
        else
          result := nil;
      end
      // caso não exista o DAV, retorna um ponteiro nulo
      else
        result := nil;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;

class procedure TDAVController.FechaDAV(Id: Integer; CCF: Integer; COO: Integer);
var
  DAVCabecalho: TDavCabecalhoVO;
  Tripa , Hash: String;
  ListaDAV: TObjectList<TDAVDetalheVO>;
  i: Integer;
begin
  try
    try
      //calcula e grava o hash do detalhe
      ListaDAV := CarregaDAV(Id);
      for i := 0 to ListaDAV.Count - 1 do
      begin
        ConsultaSQL :=
          'update DAV_DETALHE set ' +
          'HASH_TRIPA = :pHashTripa, ' +
          'HASH_INCREMENTO = :pHashIncremento ' +
          ' where ID = :pId';

        Tripa :=  IntToStr(TDavDetalheVO(ListaDAV.Items[i]).Id) +
                  IntToStr(TDavDetalheVO(ListaDAV.Items[i]).IdDavCabecalho) +
                  IntToStr(TDavDetalheVO(ListaDAV.Items[i]).IdProduto) +
                  TDavDetalheVO(ListaDAV.Items[i]).NumeroDav +
                  TDavDetalheVO(ListaDAV.Items[i]).DataEmissao +
                  IntToStr(TDavDetalheVO(ListaDAV.Items[i]).Item) +
                  FormataFloat('V',TDavDetalheVO(ListaDAV.Items[i]).Quantidade) +
                  FormataFloat('V',TDavDetalheVO(ListaDAV.Items[i]).ValorUnitario) +
                  FormataFloat('V',TDavDetalheVO(ListaDAV.Items[i]).ValorTotal) +
                  TDavDetalheVO(ListaDAV.Items[i]).Cancelado +
                  TDavDetalheVO(ListaDAV.Items[i]).MesclaProduto +
                  TDavDetalheVO(ListaDAV.Items[i]).GtinProduto +
                  TDavDetalheVO(ListaDAV.Items[i]).NomeProduto +
                  TDavDetalheVO(ListaDAV.Items[i]).TotalizadorParcial +
                  TDavDetalheVO(ListaDAV.Items[i]).UnidadeProduto + '0';
        Hash := MD5String(Tripa);

        Query := TSQLQuery.Create(nil);
        Query.SQLConnection := FDataModule.ConexaoBalcao;
        Query.sql.Text := ConsultaSQL;
        Query.ParamByName('pHashIncremento').AsInteger := -1;
        Query.ParamByName('pHashTripa').AsString := Hash;
        Query.ParamByName('pId').AsInteger := TDavDetalheVO(ListaDAV.Items[i]).Id;
        Query.ExecSQL();
      end;

      ConsultaSQL :=
        'update DAV_CABECALHO set ' +
        'SITUACAO=:pSituacao, '+
        'CCF=:pCCF, '+
        'NUMERO_ECF=:pNUMERO_ECF, '+
        'COO=:pCOO '+
        ' where ID = :pId';

      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.ConexaoBalcao;
      Query.sql.Text := ConsultaSQL;
      Query.ParamByName('pId').AsInteger := Id;
      Query.ParamByName('pCCF').AsInteger := CCF;
      Query.ParamByName('pCOO').AsInteger := COO;
      Query.ParamByName('pSituacao').AsString := 'E';
      Query.ParamByName('pNUMERO_ECF').AsString := FDataModule.ACBrECF.NumECF;
      Query.ExecSQL();
      Query.Free;

      //calcula e grava o hash do cabeçalho
      DAVCabecalho := ConsultaDAVId(Id);
      Tripa :=  IntToStr(DAVCabecalho.Id) +
                IntToStr(DAVCabecalho.IdPessoa) +
                IntToStr(DAVCabecalho.CCF) +
                IntToStr(DAVCabecalho.COO) +
                DAVCabecalho.NomeDestinatario +
                DAVCabecalho.CpfCnpjDestinatario +
                DAVCabecalho.DataEmissao +
                DAVCabecalho.HoraEmissao +
                DAVCabecalho.Situacao +
                FormataFloat('V',DAVCabecalho.TaxaAcrescimo) +
                FormataFloat('V',DAVCabecalho.Acrescimo) +
                FormataFloat('V',DAVCabecalho.TaxaDesconto) +
                FormataFloat('V',DAVCabecalho.Desconto) +
                FormataFloat('V',DAVCabecalho.SubTotal) +
                FormataFloat('V',DAVCabecalho.Valor) +
                DAVCabecalho.NumeroDav +
                FDataModule.ACBrECF.NumECF +
                '0';

      Hash := MD5String(Tripa);

      ConsultaSQL :=
        'update DAV_CABECALHO set ' +
        'HASH_TRIPA = :pHashTripa, ' +
        'HASH_INCREMENTO = :pHashIncremento ' +
        ' where ID = :pId';

      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.ConexaoBalcao;
      Query.sql.Text := ConsultaSQL;
      Query.ParamByName('pHashTripa').AsString := Hash;
      Query.ParamByName('pHashIncremento').AsInteger := -1;
      Query.ParamByName('pId').AsInteger := Id;
      Query.ExecSQL();
      Query.Free;

    except
    end;
  finally
  end;
end;

class procedure TDAVController.MesclaDAV(ListaDAVCabecalho:TObjectList<TDavCabecalhoVO>; ListaDAVDetalhe:TObjectList<TDAVDetalheVO>; ValorNovoDav: Extended);
var
  i, Item: Integer;
  NovoDAVCabecalho: TDavCabecalhoVO;
  Tripa, Hash: String;
  NumeroUltimoDav, NumeroNovoDav: String;
begin
  //inicia e configura o novo DAV
  NovoDAVCabecalho := TDavCabecalhoVO.Create;
  NovoDAVCabecalho.IdPessoa := TDavCabecalhoVO(ListaDAVCabecalho.Items[0]).IdPessoa;
  NovoDAVCabecalho.NomeDestinatario := TDavCabecalhoVO(ListaDAVCabecalho.Items[0]).NomeDestinatario;
  NovoDAVCabecalho.CpfCnpjDestinatario := TDavCabecalhoVO(ListaDAVCabecalho.Items[0]).CpfCnpjDestinatario;
  NovoDAVCabecalho.DataEmissao := FormatDateTime('yyyy-mm-dd', now);
  NovoDAVCabecalho.HoraEmissao := FormatDateTime('hh:nn:ss', now);
  NovoDAVCabecalho.Situacao := 'P';

  //atualiza a tabela de cabecalho
  for i := 0 to ListaDAVCabecalho.Count - 1 do
  begin
    //altera a situacao do DAV selecionado para M de mesclado
    ConsultaSQL :=
      'update DAV_CABECALHO set ' +
      'SITUACAO=:pSituacao, '+
      'HASH_TRIPA = :pHashTripa, ' +
      'HASH_INCREMENTO = :pHashIncremento ' +
      ' where ID = :pId';

    try
      try
        try
          //calcula e grava o hash
          Tripa :=  IntToStr(TDavCabecalhoVO(ListaDAVCabecalho.Items[i]).Id) +
                    IntToStr(TDavCabecalhoVO(ListaDAVCabecalho.Items[i]).IdPessoa) +
                    IntToStr(TDavCabecalhoVO(ListaDAVCabecalho.Items[i]).CCF) +
                    IntToStr(TDavCabecalhoVO(ListaDAVCabecalho.Items[i]).COO) +
                    TDavCabecalhoVO(ListaDAVCabecalho.Items[i]).NomeDestinatario +
                    TDavCabecalhoVO(ListaDAVCabecalho.Items[i]).CpfCnpjDestinatario +
                    TDavCabecalhoVO(ListaDAVCabecalho.Items[i]).DataEmissao +
                    TDavCabecalhoVO(ListaDAVCabecalho.Items[i]).HoraEmissao +
                    'M' + //Situação
                    FormataFloat('V',TDavCabecalhoVO(ListaDAVCabecalho.Items[i]).TaxaAcrescimo) +
                    FormataFloat('V',TDavCabecalhoVO(ListaDAVCabecalho.Items[i]).Acrescimo) +
                    FormataFloat('V',TDavCabecalhoVO(ListaDAVCabecalho.Items[i]).TaxaDesconto) +
                    FormataFloat('V',TDavCabecalhoVO(ListaDAVCabecalho.Items[i]).Desconto) +
                    FormataFloat('V',TDavCabecalhoVO(ListaDAVCabecalho.Items[i]).SubTotal) +
                    FormataFloat('V',TDavCabecalhoVO(ListaDAVCabecalho.Items[i]).Valor) +
                    TDavCabecalhoVO(ListaDAVCabecalho.Items[i]).NumeroDav +
                    FDataModule.ACBrECF.NumECF +
                    '0';

          Hash := MD5String(Tripa);

          Query := TSQLQuery.Create(nil);
          Query.SQLConnection := FDataModule.ConexaoBalcao;
          Query.sql.Text := ConsultaSQL;
          Query.ParamByName('pHashTripa').AsString := Hash;
          Query.ParamByName('pHashIncremento').AsInteger := -1;
          Query.ParamByName('pSituacao').AsString := 'M';
          Query.ParamByName('pId').AsInteger := TDavCabecalhoVO(ListaDAVCabecalho.Items[i]).Id;
          Query.ExecSQL();

        except
        end;
      finally
      end;
    finally
      Query.Free;
    end;
  end;

  //cria um novo dav
  ConsultaSQL :=
    'insert into DAV_CABECALHO (' +
    'NUMERO_DAV,' +
    'ID_EMPRESA,' +
    'NOME_DESTINATARIO,' +
    'CPF_CNPJ_DESTINATARIO,' +
    'DATA_EMISSAO,' +
    'HORA_EMISSAO,' +
    'SUBTOTAL,' +
    'VALOR,' +
    'SITUACAO, ID_PESSOA) values (' +
    ':pNumeroDav,' +
    ':pIdEmpresa,' +
    ':pDestinatario,' +
    ':pCPFCNPJ,' +
    ':pDataEmissao,' +
    ':pHoraEmissao,' +
    ':pSubTotal,' +
    ':pValor,' +
    ':pSituacao, :pIdPessoa)';
  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.ConexaoBalcao;
      Query.sql.Text := 'select NUMERO_DAV from DAV_CABECALHO where id = (select max(id) from dav_cabecalho)';
      Query.Open();
      NumeroUltimoDav := Query.FieldByName('NUMERO_DAV').AsString;
      Query.Free;

      if (NumeroUltimoDav = '') or (NumeroUltimoDav = '9999999999') then
        NumeroNovoDav := '0000000001'
      else
      begin
        NumeroNovoDav := FloatToStr(StrToFloat(NumeroUltimoDav) + 1);
        NumeroNovoDav := StringOfChar('0',10-Length(NumeroNovoDav)) + NumeroNovoDav;
      end;

      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.ConexaoBalcao;
      Query.sql.Text := ConsultaSQL;
      Query.ParamByName('pNumeroDav').AsString := NumeroNovoDav;
      Query.ParamByName('pIdEmpresa').AsInteger := Constantes.TConstantes.EMPRESA_BALCAO;
      Query.ParamByName('pDestinatario').AsString := NovoDAVCabecalho.NomeDestinatario;
      Query.ParamByName('pCPFCNPJ').AsString := NovoDAVCabecalho.CpfCnpjDestinatario;
      Query.ParamByName('pDataEmissao').AsString := NovoDAVCabecalho.DataEmissao;
      Query.ParamByName('pHoraEmissao').AsString := NovoDAVCabecalho.HoraEmissao;
      Query.ParamByName('pSituacao').AsString := NovoDAVCabecalho.Situacao;
      Query.ParamByName('pSubTotal').AsFloat := ValorNovoDav;
      Query.ParamByName('pValor').AsFloat := ValorNovoDav;

      if NovoDAVCabecalho.IdPessoa > 0 then
        Query.ParamByName('pIdPessoa').AsInteger := NovoDAVCabecalho.IdPessoa
      else
      begin
        Query.ParamByName('pIdPessoa').DataType := ftInteger;
        Query.ParamByName('pIdPessoa').Clear;
      end;
      Query.ExecSQL();

      ConsultaSQL := 'select max(ID) as ID from DAV_CABECALHO';
      Query.sql.Text := ConsultaSQL;
      Query.Open();

      NovoDAVCabecalho.Id := Query.FieldByName('ID').AsInteger;
    except
    end;
  finally
    Query.Free;
  end;

  try
    try
      Item := 1;
      for i := 0 to ListaDAVDetalhe.Count - 1 do
      begin
        //atualizar o hash dos detalhes mesclados
        ConsultaSQL :=
          'update DAV_DETALHE set ' +
          'HASH_TRIPA = :pHashTripa, ' +
          'HASH_INCREMENTO = :pHashIncremento ' +
          ' where ID = :pId';

        Tripa :=  IntToStr(TDavDetalheVO(ListaDavDetalhe.Items[i]).Id) +
                  IntToStr(TDavDetalheVO(ListaDavDetalhe.Items[i]).IdDavCabecalho) +
                  IntToStr(TDavDetalheVO(ListaDavDetalhe.Items[i]).IdProduto) +
                  TDavDetalheVO(ListaDavDetalhe.Items[i]).NumeroDav +
                  TDavDetalheVO(ListaDavDetalhe.Items[i]).DataEmissao +
                  IntToStr(TDavDetalheVO(ListaDavDetalhe.Items[i]).Item) +
                  FormataFloat('V',TDavDetalheVO(ListaDavDetalhe.Items[i]).Quantidade) +
                  FormataFloat('V',TDavDetalheVO(ListaDavDetalhe.Items[i]).ValorUnitario) +
                  FormataFloat('V',TDavDetalheVO(ListaDavDetalhe.Items[i]).ValorTotal) +
                  TDavDetalheVO(ListaDavDetalhe.Items[i]).Cancelado +
                  TDavDetalheVO(ListaDavDetalhe.Items[i]).MesclaProduto +
                  TDavDetalheVO(ListaDavDetalhe.Items[i]).GtinProduto +
                  TDavDetalheVO(ListaDavDetalhe.Items[i]).NomeProduto +
                  TDavDetalheVO(ListaDavDetalhe.Items[i]).TotalizadorParcial +
                  TDavDetalheVO(ListaDavDetalhe.Items[i]).UnidadeProduto + '0';
        Hash := MD5String(Tripa);

        Query := TSQLQuery.Create(nil);
        Query.SQLConnection := FDataModule.ConexaoBalcao;
        Query.sql.Text := ConsultaSQL;
        Query.ParamByName('pHashIncremento').AsInteger := -1;
        Query.ParamByName('pHashTripa').AsString := Hash;
        Query.ParamByName('pId').AsInteger := TDavDetalheVO(ListaDavDetalhe.Items[i]).Id;
        Query.ExecSQL();
        Query.Free;

        //insere os novos detalhes
        ConsultaSQL :=
          'insert into DAV_DETALHE (' +
          'ID_PRODUTO,' +
          'ID_DAV_CABECALHO,' +
          'NUMERO_DAV,' +
          'DATA_EMISSAO,' +
          'ITEM,' +
          'QUANTIDADE,' +
          'VALOR_UNITARIO,' +
          'VALOR_TOTAL,' +
          'CANCELADO,' +
          'MESCLA_PRODUTO,' +
          'GTIN_PRODUTO,' +
          'NOME_PRODUTO,' +
          'TOTALIZADOR_PARCIAL,' +
          'HASH_TRIPA,' +
          'HASH_INCREMENTO,' +
          'UNIDADE_PRODUTO) values (' +
          ':pIdProduto,' +
          ':pIdDavCabecalho,' +
          ':pNumeroDav,' +
          ':pDataEmissao,' +
          ':pItem,' +
          ':pQuantidade,' +
          ':pValorUnitario,' +
          ':pValorTotal,' +
          ':pCancelado,' +
          ':pMesclaProduto,' +
          ':pGtinProduto,' +
          ':pNomeProduto,' +
          ':pTOTALIZADOR_PARCIAL,' +
          ':pHashTripa,' +
          ':pHashIncremento,' +
          ':pUnidadeProduto)';

        Tripa :=  IntToStr(TDavDetalheVO(ListaDavDetalhe.Items[i]).Id) +
                  IntToStr(TDavDetalheVO(ListaDavDetalhe.Items[i]).IdDavCabecalho) +
                  IntToStr(TDavDetalheVO(ListaDavDetalhe.Items[i]).IdProduto) +
                  TDavDetalheVO(ListaDavDetalhe.Items[i]).NumeroDav +
                  TDavDetalheVO(ListaDavDetalhe.Items[i]).DataEmissao +
                  IntToStr(Item) +
                  FormataFloat('V',TDavDetalheVO(ListaDavDetalhe.Items[i]).Quantidade) +
                  FormataFloat('V',TDavDetalheVO(ListaDavDetalhe.Items[i]).ValorUnitario) +
                  FormataFloat('V',TDavDetalheVO(ListaDavDetalhe.Items[i]).ValorTotal) +
                  TDavDetalheVO(ListaDavDetalhe.Items[i]).Cancelado +
                  TDavDetalheVO(ListaDavDetalhe.Items[i]).MesclaProduto +
                  TDavDetalheVO(ListaDavDetalhe.Items[i]).GtinProduto +
                  TDavDetalheVO(ListaDavDetalhe.Items[i]).NomeProduto +
                  TDavDetalheVO(ListaDavDetalhe.Items[i]).TotalizadorParcial +
                  TDavDetalheVO(ListaDavDetalhe.Items[i]).UnidadeProduto + '0';
        Hash := MD5String(Tripa);

        Query := TSQLQuery.Create(nil);
        Query.SQLConnection := FDataModule.ConexaoBalcao;
        Query.sql.Text := ConsultaSQL;
        Query.ParamByName('pIdProduto').AsInteger := TDAVDetalheVO(ListaDAVDetalhe.Items[i]).IdProduto;
        Query.ParamByName('pIdDavCabecalho').AsInteger := NovoDAVCabecalho.Id;
        Query.ParamByName('pNumeroDav').AsString := NumeroNovoDav;
        Query.ParamByName('pDataEmissao').AsString := FormatDateTime('yyyy-mm-dd', Date);
        Query.ParamByName('pItem').AsInteger := Item;
        Query.ParamByName('pQuantidade').AsFloat := TDAVDetalheVO(ListaDAVDetalhe.Items[i]).Quantidade;
        Query.ParamByName('pValorUnitario').AsFloat := TDAVDetalheVO(ListaDAVDetalhe.Items[i]).ValorUnitario;
        Query.ParamByName('pValorTotal').AsFloat := TDAVDetalheVO(ListaDAVDetalhe.Items[i]).ValorTotal;
        Query.ParamByName('pCancelado').AsString := TDAVDetalheVO(ListaDAVDetalhe.Items[i]).Cancelado;
        Query.ParamByName('pMesclaProduto').AsString := TDAVDetalheVO(ListaDAVDetalhe.Items[i]).MesclaProduto;
        Query.ParamByName('pGtinProduto').AsString := TDAVDetalheVO(ListaDAVDetalhe.Items[i]).GtinProduto;
        Query.ParamByName('pNomeProduto').AsString := TDAVDetalheVO(ListaDAVDetalhe.Items[i]).NomeProduto;
        Query.ParamByName('pUnidadeProduto').AsString := TDAVDetalheVO(ListaDAVDetalhe.Items[i]).UnidadeProduto;
        Query.ParamByName('pTOTALIZADOR_PARCIAL').AsString := TDAVDetalheVO(ListaDAVDetalhe.Items[i]).TotalizadorParcial;
        Query.ParamByName('pHashIncremento').AsInteger := 0;
        Query.ParamByName('pHashTripa').AsString := Hash;
        Query.ExecSQL();
        Inc(Item);
      end;
    except
    end;
  finally
    Query.Free;
  end;
  FCaixa.FechaMenuOperacoes;
  FCaixa.CarregaDAV(IntToStr(NovoDAVCabecalho.Id));
end;

class function TDAVController.ListaDAVPeriodo(DataInicio:String; DataFim:String): TObjectList<TDavCabecalhoVO>;
var
  ListaDAV: TObjectList<TDavCabecalhoVO>;
  DAVCabecalho: TDavCabecalhoVO;
  TotalRegistros: Integer;
begin
  ConsultaSQL :=
    'select count(*) AS TOTAL from DAV_CABECALHO where SITUACAO =' + QuotedStr('E') + ' and (DATA_EMISSAO between :pDataInicio and :pDataFim)';
  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.ConexaoBalcao;
      Query.sql.Text := ConsultaSQL;
      Query.ParamByName('pDataInicio').AsDateTime := StrToDate(DataInicio);
      Query.ParamByName('pDataFim').AsDateTime := StrToDate(DataFim);
      Query.Open;

      TotalRegistros := Query.FieldByName('TOTAL').AsInteger;
      if TotalRegistros > 0 then
      begin
        ListaDAV := TObjectList<TDavCabecalhoVO>.Create;
        ConsultaSQL :=
       'select * from DAV_CABECALHO where SITUACAO =' + QuotedStr('E') + ' and (DATA_EMISSAO between :pDataInicio and :pDataFim)';
        Query.sql.Text := ConsultaSQL;
        Query.ParamByName('pDataInicio').AsDateTime := StrToDate(DataInicio);
        Query.ParamByName('pDataFim').AsDateTime := StrToDate(DataFim);
        Query.Open;
        Query.First;
        while not Query.Eof do
        begin
          DAVCabecalho := TDavCabecalhoVO.Create;
          DAVCabecalho.Id := Query.FieldByName('ID').AsInteger;
          DAVCabecalho.IdPessoa := Query.FieldByName('ID_PESSOA').AsInteger;
          DAVCabecalho.CCF := Query.FieldByName('CCF').AsInteger;
          DAVCabecalho.COO := Query.FieldByName('COO').AsInteger;
          DAVCabecalho.NumeroDav := Query.FieldByName('NUMERO_DAV').AsString;
          DAVCabecalho.NumeroEcf := Query.FieldByName('NUMERO_ECF').AsString;
          DAVCabecalho.NomeDestinatario := Query.FieldByName('NOME_DESTINATARIO').AsString;
          DAVCabecalho.CpfCnpjDestinatario := Query.FieldByName('CPF_CNPJ_DESTINATARIO').AsString;
          DAVCabecalho.DataEmissao := Query.FieldByName('DATA_EMISSAO').AsString;
          DAVCabecalho.HoraEmissao := Query.FieldByName('HORA_EMISSAO').AsString;
          DAVCabecalho.Situacao := Query.FieldByName('SITUACAO').AsString;
          DAVCabecalho.TaxaAcrescimo := Query.FieldByName('TAXA_ACRESCIMO').AsFloat;
          DAVCabecalho.Acrescimo := Query.FieldByName('ACRESCIMO').AsFloat;
          DAVCabecalho.TaxaDesconto := Query.FieldByName('TAXA_DESCONTO').AsFloat;
          DAVCabecalho.Desconto := Query.FieldByName('DESCONTO').AsFloat;
          DAVCabecalho.SubTotal := Query.FieldByName('SUBTOTAL').AsFloat;
          DAVCabecalho.Valor := Query.FieldByName('VALOR').AsFloat;
          DAVCabecalho.HashTripa := Query.FieldByName('HASH_TRIPA').AsString;
          DAVCabecalho.HashIncremento := Query.FieldByName('HASH_INCREMENTO').AsInteger;
          ListaDAV.Add(DAVCabecalho);
          Query.next;
        end;
        result := ListaDAV;
      end
      // caso não exista a relacao, retorna um ponteiro nulo
      else
        result := nil;
    finally
      Query.Free;
    end;
  except
    result := nil;
  end;
end;

class function TDAVController.ConsultaDAVId(Id:Integer): TDavCabecalhoVO;
var
  DAVCabecalho: TDavCabecalhoVO;
begin
  ConsultaSQL :=
    'select * from DAV_CABECALHO where ID = ' + IntToStr(Id);

  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.ConexaoBalcao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      Query.First;

      DAVCabecalho := TDavCabecalhoVO.Create;

      DAVCabecalho.Id := Query.FieldByName('ID').AsInteger;
      DAVCabecalho.IdPessoa := Query.FieldByName('ID_PESSOA').AsInteger;
      DAVCabecalho.CCF := Query.FieldByName('CCF').AsInteger;
      DAVCabecalho.COO := Query.FieldByName('COO').AsInteger;
      DAVCabecalho.NumeroDav := Query.FieldByName('NUMERO_DAV').AsString;
      DAVCabecalho.NumeroEcf := Query.FieldByName('NUMERO_ECF').AsString;
      DAVCabecalho.NomeDestinatario := Query.FieldByName('NOME_DESTINATARIO').AsString;
      DAVCabecalho.CpfCnpjDestinatario := Query.FieldByName('CPF_CNPJ_DESTINATARIO').AsString;
      DAVCabecalho.DataEmissao := Query.FieldByName('DATA_EMISSAO').AsString;
      DAVCabecalho.HoraEmissao := Query.FieldByName('HORA_EMISSAO').AsString;
      DAVCabecalho.Situacao := Query.FieldByName('SITUACAO').AsString;
      DAVCabecalho.TaxaAcrescimo := Query.FieldByName('TAXA_ACRESCIMO').AsFloat;
      DAVCabecalho.Acrescimo := Query.FieldByName('ACRESCIMO').AsFloat;
      DAVCabecalho.TaxaDesconto := Query.FieldByName('TAXA_DESCONTO').AsFloat;
      DAVCabecalho.Desconto := Query.FieldByName('DESCONTO').AsFloat;
      DAVCabecalho.SubTotal := Query.FieldByName('SUBTOTAL').AsFloat;
      DAVCabecalho.Valor := Query.FieldByName('VALOR').AsFloat;
      DAVCabecalho.HashTripa := Query.FieldByName('HASH_TRIPA').AsString;
      DAVCabecalho.HashIncremento := Query.FieldByName('HASH_INCREMENTO').AsInteger;

      result := DAVCabecalho;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;

end;

class function TDAVController.ListaDavDetalhe(Id: Integer): TObjectList<TDavDetalheVO>;
var
  ListaDavDetalhe: TObjectList<TDavDetalheVO>;
  DavDetalhe: TDavDetalheVO;
  TotalRegistros: Integer;
begin
  //verifica se existem itens para o ID passado
  ConsultaSQL :=
    'select count(*) AS TOTAL from DAV_DETALHE where ID_DAV_CABECALHO = ' + IntToStr(Id);
  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.ConexaoBalcao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      TotalRegistros := Query.FieldByName('TOTAL').AsInteger;

      if TotalRegistros > 0 then
      begin
        ListaDavDetalhe := TObjectList<TDavDetalheVO>.Create;
        ConsultaSQL :=
          'select * ' +
          ' from DAV_DETALHE '+
          ' where ID_DAV_CABECALHO = ' + IntToStr(Id);
        Query.sql.Text := ConsultaSQL;
        Query.Open;
        Query.First;
        while not Query.Eof do
        begin
          DavDetalhe := TDavDetalheVO.Create;
          DavDetalhe.Id := Query.FieldByName('ID').AsInteger;
          DavDetalhe.IdDavCabecalho := Query.FieldByName('ID_DAV_CABECALHO').AsInteger;
          DavDetalhe.IdProduto := Query.FieldByName('ID_PRODUTO').AsInteger;
          DavDetalhe.GtinProduto := Query.FieldByName('GTIN_PRODUTO').AsString;
          DavDetalhe.NomeProduto := Query.FieldByName('NOME_PRODUTO').AsString;
          DavDetalhe.UnidadeProduto := Query.FieldByName('UNIDADE_PRODUTO').AsString;
          DavDetalhe.IdProduto := Query.FieldByName('ID_PRODUTO').AsInteger;
          DavDetalhe.IdProduto := Query.FieldByName('ID_PRODUTO').AsInteger;
          DavDetalhe.Item := Query.FieldByName('ITEM').AsInteger;
          DavDetalhe.Quantidade := Query.FieldByName('QUANTIDADE').AsFloat;
          DavDetalhe.ValorUnitario := Query.FieldByName('VALOR_UNITARIO').AsFloat;
          DavDetalhe.ValorTotal := Query.FieldByName('VALOR_TOTAL').AsFloat;
          DavDetalhe.Cancelado := Query.FieldByName('CANCELADO').AsString;
          DavDetalhe.MesclaProduto := Query.FieldByName('MESCLA_PRODUTO').AsString;
          DavDetalhe.TotalizadorParcial := Query.FieldByName('TOTALIZADOR_PARCIAL').AsString;
          DavDetalhe.HashTripa := Query.FieldByName('HASH_TRIPA').AsString;
          DavDetalhe.HashIncremento := Query.FieldByName('HASH_INCREMENTO').AsInteger;
          ListaDavDetalhe.Add(DavDetalhe);
          Query.next;
        end;
        result := ListaDavDetalhe;
      end
      //caso não exista a relacao, retorna um ponteiro nulo
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
