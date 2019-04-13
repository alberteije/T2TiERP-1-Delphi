{*******************************************************************************
Title: T2Ti ERP
Description: Gera relatório de DAVs emitidos.

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
unit UDAVEmitidos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JvExDBGrids, StdCtrls, JvExStdCtrls,
  JvButton, JvCtrls, Buttons, JvExButtons, JvBitBtn, pngimage, ExtCtrls, Mask,
  JvEdit, JvValidateEdit, Generics.Collections, JvEnterTab,
  ACBrPAF, ACBrPAF_D,
  SWSystem, Biblioteca, JvComponentBase;

type
  TFDavEmitidos = class(TForm)
    Image1: TImage;
    RadioGroup1: TRadioGroup;
    panPeriodo: TPanel;
    mkeDataIni: TMaskEdit;
    Label1: TLabel;
    mkeDataFim: TMaskEdit;
    Label2: TLabel;
    botaoConfirma: TJvBitBtn;
    botaoCancela: TJvImgBtn;
    JvEnterAsTab1: TJvEnterAsTab;
    procedure Confirma;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure botaoConfirmaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FDavEmitidos: TFDavEmitidos;

const
  NOME_ARQUIVO = 'PAF_D.txt';

implementation

uses
  UCaixa, UDataModule, DavCabecalhoVO, DAVController, UPAF, ImpressoraController,
  ImpressoraVO, R06VO, EAD_Class, DAVDetalheVO;

  {$R *.dfm}


procedure TFDavEmitidos.botaoConfirmaClick(Sender: TObject);
begin
  Confirma;
end;

procedure TFDavEmitidos.Confirma;
var
  ListaDAV: TObjectList<TDAVCabecalhoVO>;
  ListaDavDetalhe: TObjectList<TDAVDetalheVO>;
  Impressora: TImpressoraVO;
  Numero, DataEmissao, Titulo, Valor, CCF, Mensagem, Tripa: String;
  D2: TRegistroD2;
  i,j: Integer;
  R06: TR06VO;
begin
  //relatorio gerencial
  if radiogroup1.ItemIndex = 0 then
  begin
    if UCaixa.StatusCaixa <> 3 then
    begin
      if Application.MessageBox('Deseja imprimir o relatório DAV EMITIDOS?', 'Pergunta do Sistema', Mb_YesNo + Mb_IconQuestion) = IdYes then
      begin
        ListaDAV := TDAVController.ListaDAVPeriodo(mkeDataIni.Text,mkeDataFim.Text);
        if Assigned(ListaDAV) then
        begin
          FDataModule.ACBrECF.AbreRelatorioGerencial(UCaixa.Configuracao.DavEmitidos);
          FDataModule.ACBrECF.LinhaRelatorioGerencial(StringOfChar('=',48));
          FDataModule.ACBrECF.LinhaRelatorioGerencial('DAV EMITIDOS');
          FDataModule.ACBrECF.LinhaRelatorioGerencial('PERIODO: ' + mkeDataIni.Text + ' A ' + mkeDataFim.Text);
          FDataModule.ACBrECF.LinhaRelatorioGerencial(StringOfChar('=',48));
          FDataModule.ACBrECF.LinhaRelatorioGerencial('NUMERO     EMISSAO    TITULO               VALOR');
          FDataModule.ACBrECF.LinhaRelatorioGerencial(StringOfChar('=',48));
          for i := 0 to ListaDAV.Count - 1 do
          begin
            Numero := TDavCabecalhoVO(ListaDAV.Items[i]).NumeroDav + ' ';
            DataEmissao := TDavCabecalhoVO(ListaDAV.Items[i]).DataEmissao + ' ';
            Titulo := 'ORCAMENTO ';
            Valor := FloatToStrF(TDavCabecalhoVO(ListaDAV.Items[i]).Valor,ffNumber,13,2);
            CCF := IntToStr(TDavCabecalhoVO(ListaDAV.Items[i]).CCF);
            CCF := StringOfChar('0',3-Length(CCF)) + CCF;
            Valor := StringOfChar(' ', 13 - Length(Valor)) + Valor;
            FDataModule.ACBrECF.LinhaRelatorioGerencial(Numero + DataEmissao + Titulo +'   '+ Valor);
          end;
          FDataModule.ACBrECF.LinhaRelatorioGerencial(StringOfChar('=',48));
          FDataModule.ACBrECF.FechaRelatorio;
          UPAF.GravaR06('RG');
        end
        else
          Application.MessageBox('Não existem DAV para o período informado.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
      end;
    end//if UCaixa.StatusCaixa <> 3 then
    else
      Application.MessageBox('Terminal em Estado Somente Consulta.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
  end;//if radiogroup1.ItemIndex = 0 then

  //geração de arquivo
  if radiogroup1.ItemIndex = 1 then
  begin
    if Application.MessageBox('Deseja gerar o arquivo de DAV EMITIDOS?', 'Pergunta do Sistema', Mb_YesNo + Mb_IconQuestion) = IdYes then
    begin
      ListaDAV := TDAVController.ListaDAVPeriodo(mkeDataIni.Text,mkeDataFim.Text);
      if Assigned(ListaDAV) then
      begin
        // registro D1
        UPAF.PreencherHeader(FDataModule.ACBrPAF.PAF_D.RegistroD1);
        // registro D2
        FDataModule.ACBrPAF.PAF_D.RegistroD2.Clear;
        //dados da impressora
        Impressora := TImpressoraController.PegaImpressora(UCaixa.Configuracao.IdImpressora);
        for i := 0 to ListaDAV.Count - 1 do
        begin
          Tripa :=  IntToStr(TDavCabecalhoVO(ListaDAV.Items[i]).Id) +
                    IntToStr(TDavCabecalhoVO(ListaDAV.Items[i]).IdPessoa) +
                    IntToStr(TDavCabecalhoVO(ListaDAV.Items[i]).CCF) +
                    IntToStr(TDavCabecalhoVO(ListaDAV.Items[i]).COO) +
                    TDavCabecalhoVO(ListaDAV.Items[i]).NomeDestinatario +
                    TDavCabecalhoVO(ListaDAV.Items[i]).CpfCnpjDestinatario +
                    TDavCabecalhoVO(ListaDAV.Items[i]).DataEmissao +
                    TDavCabecalhoVO(ListaDAV.Items[i]).HoraEmissao +
                    TDavCabecalhoVO(ListaDAV.Items[i]).Situacao +
                    FormataFloat('V',TDavCabecalhoVO(ListaDAV.Items[i]).TaxaAcrescimo) +
                    FormataFloat('V',TDavCabecalhoVO(ListaDAV.Items[i]).Acrescimo) +
                    FormataFloat('V',TDavCabecalhoVO(ListaDAV.Items[i]).TaxaDesconto) +
                    FormataFloat('V',TDavCabecalhoVO(ListaDAV.Items[i]).Desconto) +
                    FormataFloat('V',TDavCabecalhoVO(ListaDAV.Items[i]).SubTotal) +
                    FormataFloat('V',TDavCabecalhoVO(ListaDAV.Items[i]).Valor) +
                    TDavCabecalhoVO(ListaDAV.Items[i]).NumeroDav +
                    TDavCabecalhoVO(ListaDAV.Items[i]).NumeroEcf +
                    IntToStr(TDavCabecalhoVO(ListaDAV.Items[i]).HashIncremento);

          with FDataModule.ACBrPAF.PAF_D.RegistroD2.New do
          begin
            NUM_FAB      := Impressora.Serie;
            MF_ADICIONAL := Impressora.MFD;
            TIPO_ECF     := Impressora.Tipo;
            MARCA_ECF    := Impressora.Marca;
            if MD5String(Tripa) <> TDavCabecalhoVO(ListaDAV.Items[i]).HashTripa then
              MODELO_ECF   := StringOfChar('?',20)
            else
              MODELO_ECF   := Impressora.Modelo;
            COO          := IntToStr(TDavCabecalhoVO(ListaDAV.Items[i]).COO);
            NUMERO_ECF   := TDavCabecalhoVO(ListaDAV.Items[i]).NumeroEcf;
            NOME_CLIENTE := TDavCabecalhoVO(ListaDAV.Items[i]).NomeDestinatario;
            CPF_CNPJ     := TDavCabecalhoVO(ListaDAV.Items[i]).CpfCnpjDestinatario;
            NUM_DAV      := TDavCabecalhoVO(ListaDAV.Items[i]).NumeroDav;
            DT_DAV       := StrToDate(TDavCabecalhoVO(ListaDAV.Items[i]).DataEmissao);
            TIT_DAV      := 'ORCAMENTO';
            VLT_DAV      := TDavCabecalhoVO(ListaDAV.Items[i]).Valor;

            //registro D3
            ListaDavDetalhe := TDAVController.ListaDavDetalhe(TDavCabecalhoVO(ListaDAV.Items[i]).Id);
            if Assigned(ListaDavDetalhe) then
            begin
              for j := 0 to ListaDavDetalhe.Count - 1 do
              begin
                Tripa :=  IntToStr(TDavDetalheVO(ListaDavDetalhe.Items[j]).Id) +
                          IntToStr(TDavDetalheVO(ListaDavDetalhe.Items[j]).IdDavCabecalho) +
                          IntToStr(TDavDetalheVO(ListaDavDetalhe.Items[j]).IdProduto) +
                          TDavDetalheVO(ListaDavDetalhe.Items[j]).NumeroDav +
                          TDavDetalheVO(ListaDavDetalhe.Items[j]).DataEmissao +
                          IntToStr(TDavDetalheVO(ListaDavDetalhe.Items[j]).Item) +
                          FormataFloat('V',TDavDetalheVO(ListaDavDetalhe.Items[j]).Quantidade) +
                          FormataFloat('V',TDavDetalheVO(ListaDavDetalhe.Items[j]).ValorUnitario) +
                          FormataFloat('V',TDavDetalheVO(ListaDavDetalhe.Items[j]).ValorTotal) +
                          TDavDetalheVO(ListaDavDetalhe.Items[j]).Cancelado +
                          TDavDetalheVO(ListaDavDetalhe.Items[j]).MesclaProduto +
                          TDavDetalheVO(ListaDavDetalhe.Items[j]).GtinProduto +
                          TDavDetalheVO(ListaDavDetalhe.Items[j]).NomeProduto +
                          TDavDetalheVO(ListaDavDetalhe.Items[j]).TotalizadorParcial +
                          TDavDetalheVO(ListaDavDetalhe.Items[j]).UnidadeProduto +
                          IntToStr(TDavDetalheVO(ListaDavDetalhe.Items[j]).HashIncremento);

                with RegistroD3.New do
                begin
                  DT_INCLUSAO := StrToDate(TDavCabecalhoVO(ListaDAV.Items[i]).DataEmissao);
                  NUM_ITEM    := TDavDetalheVO(ListaDavDetalhe.Items[j]).Item;
                  COD_ITEM    := TDavDetalheVO(ListaDavDetalhe.Items[j]).GtinProduto;

                  if MD5String(Tripa) <> TDavDetalheVO(ListaDavDetalhe.Items[j]).HashTripa then
                    DESC_ITEM   := StringOfChar('?',100)
                  else
                    DESC_ITEM   := (TDavDetalheVO(ListaDavDetalhe.Items[j]).NomeProduto);

                  QTDE_ITEM   := TDavDetalheVO(ListaDavDetalhe.Items[j]).Quantidade;
                  UNI_ITEM    := TDavDetalheVO(ListaDavDetalhe.Items[j]).UnidadeProduto;
                  VL_UNIT     := TDavDetalheVO(ListaDavDetalhe.Items[j]).ValorUnitario;
                  VL_DESCTO   := 0;
                  VL_ACRES    := 0;
                  COD_TCTP    := TDavDetalheVO(ListaDavDetalhe.Items[j]).TotalizadorParcial;
                  IND_CANC    := TDavDetalheVO(ListaDavDetalhe.Items[j]).Cancelado;
                  VL_TOTAL    := TDavDetalheVO(ListaDavDetalhe.Items[j]).ValorTotal;
                end;//with RegistroD3.New do
              end;//for j := 0 to ListaDavDetalhe.Count - 1 do
            end;//if Assigned(ListaDAV) then
          end;//with FDataModule.ACBrPAF.PAF_D.RegistroD2.New do
        end;//for i := 0 to ListaDAV.Count - 1 do

        FDataModule.ACBrPAF.SaveFileTXT_D(NOME_ARQUIVO);
        TEAD_Class.SingEAD(NOME_ARQUIVO);

        Mensagem := 'Arquivo armazenado em: ' + gsAppPath + NOME_ARQUIVO;
        Application.MessageBox(PWideChar(mensagem), 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
      end
      else
        Application.MessageBox('Não existem DAV para o período informado.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
    end;
  end;
end;

procedure TFDavEmitidos.FormActivate(Sender: TObject);
begin
  Color := StringToColor(UCaixa.Configuracao.CorJanelasInternas);
  mkeDataIni.Text := DateToStr(Now);
  mkeDataFim.Text := DateToStr(Now);
  mkeDataIni.SetFocus;
end;

procedure TFDavEmitidos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFDavEmitidos.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key = 123 then
    Confirma;
end;

end.
