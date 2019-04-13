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
  VendaDetalheVO, TotalTipoPagamentoVO, Biblioteca,
  ACBrDevice;

  procedure AbreCupom(CPFouCNPJ, Nome, Endereco : String);
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
  function ImpressoraOK(Msg : Integer = 1): Boolean;

const
  Estados : array[TACBrECFEstado] of string =
    ('Não Inicializada', 'Desconhecido', 'Livre', 'Venda',
    'Pagamento', 'Relatório', 'Bloqueada', 'Requer Z', 'Requer X', 'Nao Fiscal');

implementation

uses UDataModule, UCaixa, PreVendaController, UPAF, ImpressoraVO,
  ImpressoraController, RegistroRController, MovimentoVO, MovimentoController, UEncerraMovimento,
  UIniciaMovimento;

procedure Suprimento(Valor: Extended; Descricao: String);
begin
  try
    FDataModule.ACBrECF.Suprimento(Valor, 'SUPRIMENTO', Descricao, 'DINHEIRO');
  except
    Application.MessageBox('Falha ao Registrar o Suprimento de Caixa! Verifique a impressora e tente novamente!', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
    Abort;
  end;
end;

procedure Sangria(Valor: Extended; Descricao: String);
begin
  try
    FDataModule.ACBrECF.Sangria(Valor, 'SANGRIA', Descricao, 'DINHEIRO');
  except
    Application.MessageBox('Falha ao Registrar a Sangria de Caixa! Verifique a impressora e tente novamente!', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
    Abort;
  end;
end;

procedure CancelaCupom;
begin
  try
    FDataModule.ACBrECF.CancelaCupom;
  except
    Application.MessageBox('Falha ao Cancelar Cupom! Verifique a impressora e tente novamente!', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
    Abort;
  end;
  UPAF.AtualizaGT;
end;

procedure ReducaoZ;
var
  Impressora : TImpressoraVO;
  Estado, DataMovimento:String;
  Movimento: TMovimentoVO;
  ADate : TDateTime ;
begin
  if ImpressoraOK then
  begin
    ADate := FDataModule.ACBrECF.DataMovimento;
    Estado := UECF.Estados[FDataModule.ACBrECF.Estado];
    if Estado <> 'Requer Z' then
    begin
      try
        Movimento := TMovimentoController.VerificaMovimento;
        if Movimento.Id <> 0 then
        begin
          try
            Impressora := TImpressoraController.PegaImpressora(Movimento.IdImpressora);
            Application.CreateForm(TFEncerraMovimento, FEncerraMovimento);
            UEncerramovimento.AbreMovimento := False;
            if FEncerraMovimento.ShowModal <> MROk then
            begin
              Application.MessageBox('É Necessário Encerrar o Movimento Para Emitir a Redução Z!', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
              Exit;
            end
            else
            begin
              TPreVendaController.CancelaPreVendasPendentes(ADate);
            end; //if FEncerraMovimento.ShowModal <> MROk then
          finally
            FreeAndNil(FEncerraMovimento);
          end;
          UCaixa.StatusCaixa := 3;
        end; //if Movimento.Id <> 0 then
      finally
        if Assigned(Movimento) then
          FreeAndNil(Movimento);
      end;
    end;//if Estado <> 'Requer Z' then

    FCaixa.labelMensagens.Caption := 'Redução Z - Aguarde!';

    FDataModule.ACBrECF.Desativar;
    FDataModule.ACBrECF.Ativar;

    UPAF.GravaR02R03;

    FDataModule.ACBrECF.ReducaoZ;

    Estado := UECF.Estados[FDataModule.ACBrECF.Estado];

    if Estado <> 'Bloqueada' then
    begin
      try
        TPreVendaController.CancelaPreVendasPendentes(ADate);
        Movimento := TMovimentoController.VerificaMovimento;
        if Movimento.Id <> 0 then
        begin
          Impressora := TImpressoraController.PegaImpressora(Movimento.IdImpressora);
          Movimento.DataFechamento := FormatDateTime('yyyy-mm-dd', FDataModule.ACBrECF.DataHora);
          Movimento.HoraFechamento := FormatDateTime('hh:nn:ss', FDataModule.ACBrECF.DataHora);
          Movimento.Status := 'F';
          TMovimentoController.EncerraMovimento(Movimento);
          try
            Application.CreateForm(TFEncerraMovimento, FEncerraMovimento);
            UEncerraMovimento.Movimento := TMovimentoController.VerificaMovimento(Movimento.Id);
            FEncerraMovimento.ImprimeFechamento;
          finally
            FreeAndNil(FEncerraMovimento);
          end;
          Application.CreateForm(TFIniciaMovimento, FIniciaMovimento);
          FIniciaMovimento.ShowModal;
        end;//if Movimento.Id <> 0 then
      finally
        if Assigned(Movimento) then
          FreeAndNil(Movimento);
      end;
    end;//if Estado <> 'Bloqueada' then

    try
      DataMovimento := FormatDateTime('dd/mm/yyyy',ADate);
      UPAF.GeraMovimentoECF(DataMovimento, DataMovimento, DataMovimento, Impressora);
    finally
      if Assigned(Impressora) then
        FreeAndNil(Impressora);
    end;

    if not FDataModule.ACBrECF.MFD then
      PrimeiraReducaoDoMes;

    FCaixa.labelMensagens.Caption := 'Movimento do ECF Encerrado.';
  end;
end;

procedure LeituraX;
begin
  try
    FDataModule.ACBrECF.LeituraX;
  except
    Application.MessageBox('Falha ao Realizar a Leitura X! Verifique a impressora e tente novamente!', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
    Abort;
  end;
end;

procedure AbreCupom(CPFouCNPJ, Nome, Endereco : String);
begin
  try
    FDataModule.ACBrECF.AbreCupom(CPFouCNPJ, Nome, Endereco);
  except
    Application.MessageBox('Falha ao Abrir o Cupom! Verifique a impressora e tente novamente!', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
    Abort;
  end;
end;

procedure VendeItem(VendaDetalhe: TVendaDetalheVO);
begin
  try
    FDataModule.ACBrECF.VendeItem(VendaDetalhe.GTIN, VendaDetalhe.DescricaoPDV, VendaDetalhe.ECFICMS, VendaDetalhe.Quantidade, VendaDetalhe.ValorUnitario);
  except
    Application.MessageBox('Falha ao Registrar Item!', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
    Abort;
  end;
end;

procedure EfetuaFormaPagamento(TotalTipoPagamento: TTotalTipoPagamentoVo);
begin
  try
    FDataModule.ACBrECF.EfetuaPagamento(TotalTipoPagamento.CodigoPagamento,TotalTipoPagamento.Valor);
  except
    Application.MessageBox('Falha ao Efetuar Pagamento!', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);  //Adicionar
    Abort;
  end;
end;

procedure SubTotalizaCupom(AscDesc: Extended);
begin
  try
    FDataModule.ACBrECF.SubtotalizaCupom(AscDesc);
  except
    Application.MessageBox('Falha ao Sub Totalizar o Cupom!', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);  //Adicionar
    Abort;
  end;
end;

procedure FechaCupom(Observacao: String);
begin
  try
    FDataModule.ACBrECF.FechaCupom(Observacao);
  except
    Application.MessageBox('Falha ao Fechar o Cupom!', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);  //Adicionar
    Abort;
  end;
  UPAF.AtualizaGT;
end;

procedure CancelaItem(Item: Integer);
begin
  try
    FDataModule.ACBrECF.CancelaItemVendido(Item);
  except
    Application.MessageBox('Falha no Cancelamento do Ítem!', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);  //Adicionar
    Abort;
  end;
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

function ImpressoraOK(Msg: Integer = 1): Boolean;  // por padrão Msg vai ser 1 não modificando o funcionamento atual da função.
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
    if Msg = 1 then
      Mensagem := 'Estado da Impressora: ' + Estado + '.'
    else if Msg = 2 then  // caso a chamada seja feita passando o parâmetro Msg com o valor 2 exibe uma mensagem diferente.
      Mensagem := 'Não é possível iniciar o movimento pois o estado da impressora é: ' + Estado + '.';
    Application.MessageBox(PWideChar(Mensagem), 'Erro do Sistema', MB_OK + MB_ICONERROR);
    result := false;
  end;
end;

end.
