{ *******************************************************************************
  Title: T2Ti ERP
  Description: Funções e procedimentos do Sintegra;

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
  ******************************************************************************* }

unit USintegra;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Dbtables, Inifiles, Generics.Collections, ACBrSintegra, SWSystem, Biblioteca;

  procedure GerarRegistro10;
  procedure GerarRegistro11;
  procedure GerarRegistro60M;
  procedure GerarRegistro60D;
  procedure GerarRegistro60R;
  procedure GerarRegistro61;
  procedure GerarRegistro61R;
  procedure GerarArquivoSintegra(pDataIni:String; pDataFim:String; pCodigoConvenio:Integer; pNaturezaInformacao: Integer; pFinalidadeArquivo:Integer);

implementation

uses
UDataModule, UCaixa, EmpresaController, EmpresaVO, Sintegra60MVO, SintegraController,
Sintegra60AVO, Sintegra60DVO, EAD_Class, ProdutoVO, ProdutoController, Sintegra60RVO,
NF2CabecalhoVO, NF2Controller, Sintegra61RVO;

var
  Empresa : TEmpresaVO;
  SerieImpressora, DataInicial, DataFinal: String;
  CodigoConvenio, NaturezaInformacao, FinalidadeArquivo:Integer;

{
Registro mestre do estabelecimento, destinado à identificação do estabelecimento
informante
}
procedure GerarRegistro10;
begin
  Empresa := TEmpresaController.PegaEmpresa(UCaixa.Configuracao.IdEmpresa);
  with FDataModule.ACBrSintegra do
  begin
    Registro10.CNPJ := Empresa.CNPJ;
    Registro10.Inscricao := Empresa.InscricaoEstadual;
    Registro10.RazaoSocial := Empresa.RazaoSocial;
    Registro10.Cidade := Empresa.Cidade;
    Registro10.Estado := Empresa.UF;
    Registro10.Telefone := Empresa.Fone1;
    Registro10.DataInicial := StrToDate('01' + Copy(DataInicial,3,8));
    Registro10.DataFinal := StrToDate(UltimoDiaMes(StrToDate(DataFinal)) + Copy(DataFinal,3,8));
    Registro10.CodigoConvenio := IntToStr(CodigoConvenio);
    Registro10.NaturezaInformacoes := IntToStr(NaturezaInformacao);
    Registro10.FinalidadeArquivo := IntToStr(FinalidadeArquivo);
  end;
end;

{
Dados complementares do informante
}
procedure GerarRegistro11;
begin
  with FDataModule.ACBrSintegra do
  begin
    Registro11.Endereco := Empresa.Endereco;
    Registro11.Numero := Empresa.Numero;
    Registro11.Bairro := Empresa.Bairro;
    Registro11.Cep := Empresa.CEP;
    Registro11.Responsavel := Empresa.Contato;
    Registro11.Telefone := Empresa.Fone1;
  end;
end;

{
Registro destinado a informar as operações e prestações realizadas com os documentos
fiscais emitidos por equipamento emissor de cupom fiscal os quais são: Cupom Fiscal,
Cupom Fiscal - PDV, Bilhete de Passagem Rodoviário, modelo 13, Bilhete de Passagem
Aquaviário, modelo 14, Bilhete de Passagem e Nota de Bagagem, modelo 15, Bilhete
de Passagem Ferroviário, modelo 16, e Nota Fiscal de Venda a Consumidor, modelo 2;

60M-MESTRE    <------
60A-ANALITICO   <------
60D-DIARIO
60I-ITEM
}
procedure GerarRegistro60M;
var
  Registro60M: TRegistro60M;
  Registro60A: TRegistro60A;
  Lista60M: TObjectList<TSintegra60MVO>;
  Lista60A: TObjectList<TSintegra60AVO>;
  i,j:integer;
begin
  Lista60M := TSintegraController.Tabela60M(DataInicial,DataFinal);
  SerieImpressora := TSintegra60MVO(Lista60M.Items[0]).SerieImpressora;
  if Assigned(Lista60M) then
  begin
    for i := 0 to Lista60M.Count - 1 do
    begin
      Registro60M := TRegistro60M.Create;
      Registro60M.Emissao := StrToDateTime(TSintegra60MVO(Lista60M.Items[i]).DataEmissao);
      Registro60M.NumSerie := TSintegra60MVO(Lista60M.Items[i]).SerieImpressora;
      Registro60M.NumOrdem := TSintegra60MVO(Lista60M.Items[i]).NumeroEquipamento;
      Registro60M.ModeloDoc := TSintegra60MVO(Lista60M.Items[i]).ModeloDocumentoFiscal;
      Registro60M.CooInicial := TSintegra60MVO(Lista60M.Items[i]).COOInicial;
      Registro60M.CooFinal := TSintegra60MVO(Lista60M.Items[i]).COOFinal;
      Registro60M.CRZ := TSintegra60MVO(Lista60M.Items[i]).CRZ;
      Registro60M.CRO := TSintegra60MVO(Lista60M.Items[i]).CRO;
      Registro60M.VendaBruta := TSintegra60MVO(Lista60M.Items[i]).VendaBruta;
      Registro60M.ValorGT := TSintegra60MVO(Lista60M.Items[i]).GrandeTotal;
      FDataModule.ACBrSintegra.Registros60M.Add(Registro60M);
      Lista60A := TSintegraController.Tabela60A(TSintegra60MVO(Lista60M.Items[i]).Id);
      if Assigned(Lista60A) then
      begin
        for j := 0 to Lista60A.Count - 1 do
        begin
          Registro60A := TRegistro60A.Create;
          Registro60A.Emissao := Registro60M.Emissao;
          Registro60A.NumSerie := TSintegra60MVO(Lista60M.Items[i]).SerieImpressora;
          Registro60A.StAliquota := TSintegra60AVO(Lista60A.Items[j]).SituacaoTributaria;
          Registro60A.Valor := TSintegra60AVO(Lista60A.Items[j]).Valor;
          FDataModule.ACBrSintegra.Registros60A.Add(Registro60A);
        end;
      end;
    end;
  end;
end;

{
Registro destinado a informar as operações e prestações realizadas com os documentos
fiscais emitidos por equipamento emissor de cupom fiscal os quais são: Cupom Fiscal,
Cupom Fiscal - PDV, Bilhete de Passagem Rodoviário, modelo 13, Bilhete de Passagem
Aquaviário, modelo 14, Bilhete de Passagem e Nota de Bagagem, modelo 15, Bilhete
de Passagem Ferroviário, modelo 16, e Nota Fiscal de Venda a Consumidor, modelo 2;

60M-MESTRE
60A-ANALITICO
60D-DIARIO    <------
60I-ITEM
}
procedure GerarRegistro60D;
var
  Registro60D: TRegistro60D;
  Registro75: TRegistro75;
  Lista60D: TObjectList<TSintegra60DVO>;
  i:integer;
  Produto: TProdutoVO;
begin
  Lista60D := TSintegraController.Tabela60D(DataInicial,DataFinal);
  for i := 0 to Lista60D.Count - 1 do
  begin
    Registro60D := TRegistro60D.Create;
    Registro60D.Emissao := StrToDateTime(TSintegra60DVO(Lista60D.Items[i]).DataEmissao);
    Registro60D.NumSerie := TSintegra60DVO(Lista60D.Items[i]).SerieECF;
    Registro60D.Codigo := TSintegra60DVO(Lista60D.Items[i]).GTIN;
    Registro60D.Quantidade := TSintegra60DVO(Lista60D.Items[i]).SomaQuantidade;
    Registro60D.Valor := TSintegra60DVO(Lista60D.Items[i]).SomaValor;
    Registro60D.BaseDeCalculo := TSintegra60DVO(Lista60D.Items[i]).SomaBaseICMS;
    Registro60D.StAliquota := TSintegra60DVO(Lista60D.Items[i]).SituacaoTributaria;
    Registro60D.ValorIcms := TSintegra60DVO(Lista60D.Items[i]).SomaValorICMS;
    FDataModule.ACBrSintegra.Registros60D.Add(Registro60D);

    Produto := TProdutoController.Consulta(Registro60D.Codigo);

    Registro75 := TRegistro75.Create;
    Registro75.DataInicial := FDataModule.ACBrSintegra.Registro10.DataInicial;
    Registro75.DataFinal := FDataModule.ACBrSintegra.Registro10.DataFinal;
    Registro75.Codigo := Registro60D.Codigo;
    Registro75.NCM := Produto.NCM;
    Registro75.Descricao := Produto.DescricaoPDV;
    Registro75.Unidade := Produto.UnidadeProduto;
    Registro75.AliquotaIPI := 0;
    Registro75.AliquotaICMS := 0;
    Registro75.Reducao := 0;
    Registro75.BaseST := 0;
    FDataModule.ACBrSintegra.Registros75.Add(Registro75);
  end;
end;

{
Registro destinado a informar as operações e prestações realizadas com os documentos
fiscais emitidos por equipamento emissor de cupom fiscal os quais são: Cupom Fiscal,
Cupom Fiscal - PDV, Bilhete de Passagem Rodoviário, modelo 13, Bilhete de Passagem
Aquaviário, modelo 14, Bilhete de Passagem e Nota de Bagagem, modelo 15, Bilhete
de Passagem Ferroviário, modelo 16, e Nota Fiscal de Venda a Consumidor, modelo 2;

60M-MESTRE
60A-ANALITICO
60D-DIARIO
60I-ITEM
60R-Mensal    <------
}
procedure GerarRegistro60R;
var
  Registro60R: TRegistro60R;
  Registro75: TRegistro75;
  Lista60R: TObjectList<TSintegra60RVO>;
  i:integer;
  Produto: TProdutoVO;
begin
  Lista60R := TSintegraController.Tabela60R(DataInicial,DataFinal);
  for i := 0 to Lista60R.Count - 1 do
  begin
    Registro60R := TRegistro60R.Create;
    Registro60R.MesAno := TSintegra60RVO(Lista60R.Items[i]).MesEmissao + TSintegra60RVO(Lista60R.Items[i]).AnoEmissao;
    Registro60R.Codigo := TSintegra60RVO(Lista60R.Items[i]).GTIN;
    Registro60R.Qtd := TSintegra60RVO(Lista60R.Items[i]).SomaQuantidade;
    Registro60R.Valor := TSintegra60RVO(Lista60R.Items[i]).SomaValor;
    Registro60R.BaseDeCalculo := TSintegra60RVO(Lista60R.Items[i]).SomaBaseICMS;
    Registro60R.Aliquota := TSintegra60RVO(Lista60R.Items[i]).SituacaoTributaria;
    FDataModule.ACBrSintegra.Registros60R.Add(Registro60R);

    Produto := TProdutoController.Consulta(Registro60R.Codigo);

    Registro75 := TRegistro75.Create;
    Registro75.DataInicial := FDataModule.ACBrSintegra.Registro10.DataInicial;
    Registro75.DataFinal := FDataModule.ACBrSintegra.Registro10.DataFinal;
    Registro75.Codigo := Registro60R.Codigo;
    Registro75.NCM := Produto.NCM;
    Registro75.Descricao := Produto.Descricao;
    Registro75.Unidade := Produto.UnidadeProduto;
    Registro75.AliquotaIPI := 0;
    Registro75.AliquotaICMS := 0;
    Registro75.Reducao := 0;
    Registro75.BaseST := 0;
    FDataModule.ACBrSintegra.Registros75.Add(Registro75);
  end;
end;

{
Para os documentos fiscais descritos a seguir, quando não emitidos por equipamento
emissor de cupom fiscal : Bilhete de Passagem Aquaviário (modelo 14), Bilhete de
Passagem e Nota de Bagagem (modelo 15), Bilhete de Passagem Ferroviário (modelo 16),
Bilhete de Passagem Rodoviário (modelo 13) e Nota Fiscal de Venda a Consumidor
(modelo 2), Nota Fiscal de Produtor (modelo 4), para as unidades da Federação
que não o exigirem na forma prevista no item 11.
}
procedure GerarRegistro61;
var
  ListaNF2Cabecalho: TObjectList<TNF2CabecalhoVO>;
  Registro61: TRegistro61;
  i: Integer;
begin
  ListaNF2Cabecalho := TNF2Controller.TabelaNF2Cabecalho(DataInicial,DataFinal);
  if Assigned(ListaNF2Cabecalho) then
  begin
    for i := 0 to ListaNF2Cabecalho.Count - 1 do
    begin
      Registro61 := TRegistro61.Create;
      Registro61.Emissao := StrToDate(TNF2CabecalhoVO(ListaNF2Cabecalho.Items[i]).DataEmissao);
      Registro61.Modelo := '02';
      Registro61.Serie := TNF2CabecalhoVO(ListaNF2Cabecalho.Items[i]).Serie;
      Registro61.SubSerie := TNF2CabecalhoVO(ListaNF2Cabecalho.Items[i]).SubSerie;
      Registro61.Valor := TNF2CabecalhoVO(ListaNF2Cabecalho.Items[i]).TotalNF;
      Registro61.BaseDeCalculo := TNF2CabecalhoVO(ListaNF2Cabecalho.Items[i]).BaseICMS;
      Registro61.ValorIcms := TNF2CabecalhoVO(ListaNF2Cabecalho.Items[i]).ICMS;
      Registro61.Outras := TNF2CabecalhoVO(ListaNF2Cabecalho.Items[i]).ICMSOutras;
      FDataModule.ACBrSintegra.Registros61.Add(Registro61);
    end;
  end;
end;

{
Registro de mercadoria/produto ou serviço comercializados através de Nota Fiscal
de Produtor ou Nota Fiscal de Venda a Consumidor não emitida por ECF.
}
procedure GerarRegistro61R;
var
  Registro61R: TRegistro61R;
  Registro75: TRegistro75;
  Lista61R: TObjectList<TSintegra61RVO>;
  i: Integer;
  Produto: TProdutoVO;
begin
  Lista61R := TSintegraController.Tabela61R(DataInicial,DataFinal);
  if Assigned(Lista61R) then
  begin
    for i := 0 to Lista61R.Count - 1 do
    begin
      Registro61R := TRegistro61R.Create;
      Registro61R.MesAno := TSintegra60RVO(Lista61R.Items[i]).MesEmissao + TSintegra60RVO(Lista61R.Items[i]).AnoEmissao;
      Registro61R.Codigo := TSintegra60RVO(Lista61R.Items[i]).GTIN;
      Registro61R.Qtd := TSintegra60RVO(Lista61R.Items[i]).SomaQuantidade;
      Registro61R.Valor := TSintegra60RVO(Lista61R.Items[i]).SomaValor;
      Registro61R.BaseDeCalculo := TSintegra60RVO(Lista61R.Items[i]).SomaBaseICMS;
      Registro61R.Aliquota := StrToFloat(TSintegra60RVO(Lista61R.Items[i]).SituacaoTributaria)/100;
      FDataModule.ACBrSintegra.Registros61R.Add(Registro61R);

      Produto := TProdutoController.Consulta(Registro61R.Codigo);

      Registro75 := TRegistro75.Create;
      Registro75.DataInicial := FDataModule.ACBrSintegra.Registro10.DataInicial;
      Registro75.DataFinal := FDataModule.ACBrSintegra.Registro10.DataFinal;
      Registro75.Codigo := Registro61R.Codigo;
      Registro75.NCM := Produto.NCM;
      Registro75.Descricao := Produto.Descricao;
      Registro75.Unidade := Produto.UnidadeProduto;
      Registro75.AliquotaIPI := 0;
      Registro75.AliquotaICMS := 0;
      Registro75.Reducao := 0;
      Registro75.BaseST := 0;
      FDataModule.ACBrSintegra.Registros75.Add(Registro75);
    end;
  end;
end;

procedure GerarArquivoSintegra(pDataIni:String; pDataFim:String; pCodigoConvenio:Integer; pNaturezaInformacao: Integer; pFinalidadeArquivo:Integer);
var
  mensagem : String;
begin
  CodigoConvenio := pCodigoConvenio;
  NaturezaInformacao := pNaturezaInformacao;
  FinalidadeArquivo := pFinalidadeArquivo;
  DataInicial := pDataIni;
  DataFinal := pDataFim;

  FDataModule.ACBrSintegra.FileName := 'sintegra.txt';
  FDataModule.ACBrSintegra.VersaoValidador := TVersaoValidador(1);
  GerarRegistro10;
  GerarRegistro11;
  GerarRegistro60M;
  GerarRegistro60D;
  GerarRegistro60R;
  GerarRegistro61;
  GerarRegistro61R;
  FDataModule.ACBrSintegra.GeraArquivo;

  TEAD_Class.SingEAD('sintegra.txt');

  mensagem := 'Arquivo armazenado em: ' + gsAppPath + 'sintegra.txt';
  Application.MessageBox(PWideChar(mensagem), 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
end;

end.

