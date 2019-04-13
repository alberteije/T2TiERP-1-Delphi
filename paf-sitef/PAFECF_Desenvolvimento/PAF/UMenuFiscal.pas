{*******************************************************************************
Title: T2Ti ERP
Description: Detecta um movimento aberto e solicita autenticação.

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

@author Albert Eije (T2Ti.COM) / Gilson Santos Lima - gilson.ti@gmail.com
@version 1.0
*******************************************************************************}

unit UMenuFiscal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, JvgListBox, JvExControls, JvLabel, pngimage, ExtCtrls,
  JvExStdCtrls, JvButton, JvCtrls, Buttons, JvExButtons, JvBitBtn, jpeg;

type
  TFMenuFiscal = class(TForm)
    panelMenuFiscal: TPanel;
    imagePanelMenuFiscal: TImage;
    labelMenuFiscal: TJvLabel;
    listaMenuFiscal: TJvgListBox;
    Image1: TImage;
    GroupBox2: TGroupBox;
    botaoConfirma: TJvBitBtn;
    botaoCancela: TJvImgBtn;
    btnLX: TButton;
    btnLMFC: TButton;
    btnLMFS: TButton;
    btnEspelhoMFD: TButton;
    btnArqMFD: TButton;
    btnTabProd: TButton;
    btnEstoque: TButton;
    btnMovimentoEcf: TButton;
    btnMeiosPagto: TButton;
    btnDavEmitidos: TButton;
    btnIdentificacaoPafEcf: TButton;
    btnVendasPeriodo: TButton;
    btnIndiceTecnico: TButton;
    btnParametrosConfig: TButton;
    Panel1: TPanel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnLXClick(Sender: TObject);
    procedure btnLMFCClick(Sender: TObject);
    procedure btnLMFSClick(Sender: TObject);
    procedure btnEspelhoMFDClick(Sender: TObject);
    procedure btnArqMFDClick(Sender: TObject);
    procedure btnTabProdClick(Sender: TObject);
    procedure btnEstoqueClick(Sender: TObject);
    procedure btnMovimentoEcfClick(Sender: TObject);
    procedure btnMeiosPagtoClick(Sender: TObject);
    procedure btnDavEmitidosClick(Sender: TObject);
    procedure btnIdentificacaoPafEcfClick(Sender: TObject);
    procedure btnVendasPeriodoClick(Sender: TObject);
    procedure btnIndiceTecnicoClick(Sender: TObject);
    procedure btnParametrosConfigClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMenuFiscal: TFMenuFiscal;

implementation

uses UCaixa, UECF, ULMFC, ULMFS, UEspelhoMFD, UArquivoMFD, UEstoque,
  UMovimentoECF, UMeiosPagamento, UDAVEmitidos, UVendasPeriodo, UFichaTecnica,
  UDataModule, UPAF;

{$R *.dfm}


{
A Lista abaixo com a relacao do que deve ou nao estar bloqueado
quando o ECF estiver em estado de somente consulta foi fornecida pela UFG.

~> “LX” - Bloqueada
~> “LMFC" - Bloqueada
~> “LMFS" - Bloqueada
~> “Espelho MFD” - Bloqueada
~> “Arq. MFD” - Bloqueada
~> “Tab. Prod.” - Desbloqueada
~> “Estoque” - Desbloqueada
~> "Movimento por ECF" - Desbloqueada
~> “Meios de Pagto.” - Bloqueada
~> “Identificação do PAF-ECF” - Bloqueada
~> “Vendas do Período” - Desbloqueada
~> “Tab. Índice Técnico Produção." - Desbloqueada
~> Sangria - Bloqueado
~> Suprimento - Bloqueado
~> Nota fiscal manual - Desbloqueado
~> Davs Emitidos(Arquivo) - Desbloqueado
~> Davs Emitidos(Impressora) - Bloqueado
 }

procedure TFMenuFiscal.btnArqMFDClick(Sender: TObject);
begin
  if FDataModule.ACBrECF.MFD then
     begin
       Application.CreateForm(TFArquivoMfd, FArquivoMfd);
       FArquivoMfd.ShowModal;
     end
  else
   Application.MessageBox('Função não suportada pelo modelo de ECF utilizado', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
end;

procedure TFMenuFiscal.btnDavEmitidosClick(Sender: TObject);
begin
    Application.CreateForm(TFDavEmitidos, FDavEmitidos);
    FDavEmitidos.ShowModal;
end;

procedure TFMenuFiscal.btnEspelhoMFDClick(Sender: TObject);
begin
     // Substituido por Gilson 08/09/2011
 if FDataModule.ACBrECF.MFD then
    begin
      Application.CreateForm(TFEspelhoMfd, FEspelhoMfd);
      FEspelhoMfd.ShowModal;
    end
 else
  Application.MessageBox('Função não suportada pelo modelo de ECF utilizado', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
end;

procedure TFMenuFiscal.btnEstoqueClick(Sender: TObject);
begin
 // Substituido por Gilson
   Application.CreateForm(TFEstoque, FEstoque);
   FEstoque.ShowModal;
end;

procedure TFMenuFiscal.btnIdentificacaoPafEcfClick(Sender: TObject);
begin
    if UCaixa.StatusCaixa <> 3 then
       Begin
        if Application.MessageBox('Deseja imprimir o relatório IDENTIFICAÇÃO DO PAF-ECF?', 'Pergunta do Sistema', Mb_YesNo + Mb_IconQuestion) = IdYes then
          UPAF.IdentificacaoPafEcf;
       End
    else
      Application.MessageBox('Terminal em Estado Somente Consulta.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
end;

procedure TFMenuFiscal.btnIndiceTecnicoClick(Sender: TObject);
begin
    Application.CreateForm(TFFichaTecnica, FFichaTecnica); // autor : Gilson Santos Lima
    FFichaTecnica.ShowModal;
end;

procedure TFMenuFiscal.btnLMFCClick(Sender: TObject);
begin
//      if UCaixa.StatusCaixa <> 3 then
  //       begin
          Application.CreateForm(TFLmfc, FLmfc);
          FLmfc.ShowModal;
    //     end
     // else
       // Application.MessageBox('Terminal em Estado Somente Consulta.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
end;

procedure TFMenuFiscal.btnLMFSClick(Sender: TObject);
begin
  Application.CreateForm(TFLmfs, FLmfs);
  FLmfs.ShowModal;
end;

procedure TFMenuFiscal.btnLXClick(Sender: TObject);
begin
      if UCaixa.StatusCaixa <> 3 then
         begin
           if Application.MessageBox('Confirma a emissão da Leitura X?', 'Emissão de Leitura X', Mb_YesNo + Mb_IconQuestion) = IdYes then
             UECF.LeituraX;
         end
      else
        Application.MessageBox('Terminal em Estado Somente Consulta.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
end;

procedure TFMenuFiscal.btnMeiosPagtoClick(Sender: TObject);
begin
    if UCaixa.StatusCaixa <> 3 then
       begin
        Application.CreateForm(TFMeiosPagamento, FMeiosPagamento);
        FMeiosPagamento.ShowModal;
       end
    else
      Application.MessageBox('Terminal em Estado Somente Consulta.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
end;

procedure TFMenuFiscal.btnMovimentoEcfClick(Sender: TObject);
begin
    Application.CreateForm(TFMovimentoECF, FMovimentoECF);
    FMovimentoECF.ShowModal;
end;

procedure TFMenuFiscal.btnParametrosConfigClick(Sender: TObject);
begin
    if Application.MessageBox('Deseja imprimir o relatório PARÂMETROS DE CONFIGURAÇÃO?', 'Pergunta do Sistema', Mb_YesNo + Mb_IconQuestion) = IdYes then
      UPAF.ParametrodeConfiguracao;
end;

procedure TFMenuFiscal.btnTabProdClick(Sender: TObject);
begin
      if Application.MessageBox('Deseja gerar o arquivo da Tabela de Produtos?', 'Pergunta do Sistema', Mb_YesNo + Mb_IconQuestion) = IdYes then
        UPAF.GeraTabelaProdutos;
end;

procedure TFMenuFiscal.btnVendasPeriodoClick(Sender: TObject);
begin
    Application.CreateForm(TFVendasPeriodo, FVendasPeriodo);
    FVendasPeriodo.ShowModal;
end;

procedure TFMenuFiscal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  FMenuFiscal := Nil;
end;

procedure TFMenuFiscal.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
  begin
    FCaixa.labelMensagens.Caption := MensagemPersistente;
   // UCaixa.MenuAberto := 0;
    FCaixa.editCodigo.SetFocus;
    Close;
  end;

end;

end.
