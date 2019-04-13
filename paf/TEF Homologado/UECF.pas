{*******************************************************************************
Title: T2Ti ERP
Description: Procedimentos e funções da impressora fiscal.

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
unit UECF;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Dbtables, Inifiles, VendaDetalheVO, TotalTipoPagamentoVO, Biblioteca,
  ACBrDevice;

  procedure AbreCupom(CPFouCNPJ: String; Nome: String);
  procedure VendeItem(VendaDetalhe: TVendaDetalheVO);
  procedure CancelaItem(Item: Integer);
  procedure EfetuaFormaPagamento(TotalTipoPagamento: TTotalTipoPagamentoVo);
  procedure SubTotalizaCupom(AscDesc: Extended);
  procedure FechaCupom(Observacao: String);
  procedure CancelaCupom;
  procedure ReducaoZ;
  procedure LeituraX;
  procedure Suprimento(Valor: Extended; Descricao: String);
  procedure Sangria(Valor: Extended; Descricao: String);
  procedure PrimeiraReducaoDoMes;
  function ImpressoraOK: Boolean;

const
  Estados : array[TACBrECFEstado] of string =
    ('Não Inicializada', 'Desconhecido', 'Livre', 'Venda',
    'Pagamento', 'Relatório', 'Bloqueada', 'Requer Z', 'Requer X', 'Nao Fiscal');

implementation

uses UDataModule, UCaixa, PreVendaController, UPAF, ImpressoraVO,
  ImpressoraController, RegistroRController;

Procedure Suprimento(Valor: Extended; Descricao: String);
begin
  FDataModule.ACBrECF.Suprimento(Valor, 'SUPRIMENTO', Descricao, 'DINHEIRO');
end;

Procedure Sangria(Valor: Extended; Descricao: String);
begin
  FDataModule.ACBrECF.Sangria(Valor, 'SANGRIA', Descricao, 'DINHEIRO');
end;

Procedure CancelaCupom;
begin
  FDataModule.ACBrECF.CancelaCupom;
  UPAF.AtualizaGT;
end;

Procedure ReducaoZ;
var
  DiasZ: Integer;
  Impressora : TImpressoraVO;
  DataMovimento:String;
begin
  if ImpressoraOK then
  begin
    FCaixa.labelMensagens.Caption := 'Redução Z - Aguarde!';
    DiasZ := Trunc(FDataModule.ACBrECF.DataHora - FDataModule.ACBrECF.DataMovimento);
    //se for só um dia de diferença, emite e cancela os cupons antes da Z
    if DiasZ <= 1 then
      TPreVendaController.CancelaPreVendasPendentes;
    UPAF.GravaR02R03;
    UPAF.Grava60M60A;
    UPAF.GeraArquivoEstoque;
    FDataModule.ACBrECF.ReducaoZ;
    //se for mais de um dia de diferença, emite e cancela os cupons depois da Z
    if DiasZ > 1 then
    begin
      FDataModule.ACBrECF.LeituraX;
      TPreVendaController.CancelaPreVendasPendentes;
    end;
    Impressora := TImpressoraController.PegaImpressora(UCaixa.Movimento.IdImpressora);
    DataMovimento := FormatDateTime('dd/mm/yyyy',FDataModule.ACBrECF.DataMovimento);
    UPAF.GeraMovimentoECF(DataMovimento, DataMovimento, Impressora);

    //se for a primeira redução do mês e o ECF for antigo, imprime a leitura da memoria fiscal
    if not FDataModule.ACBrECF.MFD then
      PrimeiraReducaoDoMes;

    FCaixa.labelMensagens.Caption := 'Movimento do ECF Encerrado.';
  end;
end;

procedure LeituraX;
begin
  FDataModule.ACBrECF.LeituraX;
end;

procedure AbreCupom(CPFouCNPJ: String; Nome: String);
begin
  FDataModule.ACBrECF.AbreCupom(CPFouCNPJ, Nome);
end;

procedure VendeItem(VendaDetalhe: TVendaDetalheVO);
begin
  FDataModule.ACBrECF.VendeItem(VendaDetalhe.GTIN, VendaDetalhe.DescricaoPDV, VendaDetalhe.ECFICMS, VendaDetalhe.Quantidade, VendaDetalhe.ValorUnitario);
end;

procedure EfetuaFormaPagamento(TotalTipoPagamento: TTotalTipoPagamentoVo);
begin
  FDataModule.ACBrECF.EfetuaPagamento(TotalTipoPagamento.CodigoPagamento,TotalTipoPagamento.Valor);
end;

procedure SubTotalizaCupom(AscDesc: Extended);
begin
  FDataModule.ACBrECF.SubtotalizaCupom(AscDesc);
end;

procedure FechaCupom(Observacao: String);
begin
  FDataModule.ACBrECF.FechaCupom(Observacao);
  UPAF.AtualizaGT;
end;

procedure CancelaItem(Item: Integer);
begin
  FDataModule.ACBrECF.CancelaItemVendido(Item);
end;

procedure PrimeiraReducaoDoMes;
var
  TotalRegistrosR02: Integer;
  DataInicio, DataFim: String;
begin
  DataInicio := '01' + Copy(DateToStr(FDataModule.ACBrECF.DataHora),3,8);
  DataFim := UltimoDiaMes(FDataModule.ACBrECF.DataHora) + Copy(DateToStr(FDataModule.ACBrECF.DataHora),3,8);
  TotalRegistrosR02 := TRegistroRController.TotalR02(DataInicio,DataFim);
  if TotalRegistrosR02 = 1 then
    FDataModule.ACBrECF.LeituraMemoriaFiscal(StrToDateTime(DataInicio),StrToDateTime(DataFim),True)
end;

function ImpressoraOK: Boolean;
var
  Mensagem, Estado: String;
begin
  result := true;
  Estado := UECF.Estados[FDataModule.ACBrECF.Estado];
  if
  (Estado = 'Não Inicializada') or
  (Estado = 'Desconhecido') or
  (Estado = 'Bloqueada')
  then
  begin
    Mensagem := 'Estado da Impressora: ' + Estado + '.';
    Application.MessageBox(PWideChar(Mensagem), 'Erro do Sistema', MB_OK + MB_ICONERROR);
    result := false;
  end;
{  if FDataModule.ACBrECF.PoucoPapel then
  begin
    Application.MessageBox('Erro. Impressora com pouco ou sem papel.', 'Erro do Sistema', MB_OK + MB_ICONERROR);
    result := false;
  end;}
end;

end.
