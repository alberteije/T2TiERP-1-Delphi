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
  Dialogs, Grids, DBGrids, JvExDBGrids, JvDBGrid, StdCtrls, JvExStdCtrls,
  JvButton, JvCtrls, Buttons, JvExButtons, JvBitBtn, pngimage, ExtCtrls, Mask,
  JvEdit, JvValidateEdit, Generics.Collections, JvExControls, JvEnterTab,
  ACBrPAF, ACBrPAF_D, ACBrPAF_E, ACBrPAF_P, ACBrPAF_R, ACBrPAF_T, ACBrPAFRegistros,
  Math, SWSystem, Biblioteca;

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
    procedure confirma;
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

Uses
UCaixa, UDataModule,DAVVO,DAVController,UPAF,ImpressoraController,ImpressoraVO,
R06VO, RegistroRController, EAD_Class;
{$R *.dfm}


procedure TFDavEmitidos.botaoConfirmaClick(Sender: TObject);
begin
  confirma;
end;

procedure TFDavEmitidos.confirma;
var
  ListaDAV: TObjectList<TDAVVO>;
  Impressora: TImpressoraVO;
  Numero, DataEmissao, Titulo, Valor, CCF, Mensagem, Tripa:String;
  D2: TRegistroD2;
  i:integer;
  R06: TR06VO;
begin
  //relatorio gerencial
  if radiogroup1.ItemIndex = 0 then
  begin
    if Application.MessageBox('Deseja imprimir o relatório DAV EMITIDOS?', 'Pergunta do Sistema', Mb_YesNo + Mb_IconQuestion) = IdYes then
    begin
      ListaDAV := TDAVController.ListaDAVPeriodo(mkeDataIni.Text,mkeDataFim.Text);
      if Assigned(ListaDAV) then
      begin
        FDataModule.ACBrECF.AbreRelatorioGerencial(UCaixa.Configuracao.IndiceGerencialDAV);
        FDataModule.ACBrECF.LinhaRelatorioGerencial(StringOfChar('=',48));
        FDataModule.ACBrECF.LinhaRelatorioGerencial('DAV EMITIDOS');
        FDataModule.ACBrECF.LinhaRelatorioGerencial('PERIODO: ' + mkeDataIni.Text + ' A ' + mkeDataFim.Text);
        FDataModule.ACBrECF.LinhaRelatorioGerencial(StringOfChar('=',48));
        FDataModule.ACBrECF.LinhaRelatorioGerencial('NUMERO     EMISSAO    TITULO    CCF        VALOR');
        FDataModule.ACBrECF.LinhaRelatorioGerencial(StringOfChar('=',48));
        for i := 0 to ListaDAV.Count - 1 do
        begin
          Numero := StringOfChar('0',10-Length(IntToStr(TDAVVO(ListaDAV.Items[i]).Id))) + IntToStr(TDAVVO(ListaDAV.Items[i]).Id) + ' ';
          DataEmissao := TDAVVO(ListaDAV.Items[i]).DataEmissao + ' ';
          //no nosso paf o DAV será orçamento (depois podemos parametrizar isso)
          Titulo := 'ORCAMENTO ';
          Valor := FloatToStrF(TDAVVO(ListaDAV.Items[i]).Valor,ffNumber,13,2);
          CCF := IntToStr(TDAVVO(ListaDAV.Items[i]).CCF);
          CCF := StringOfChar('0',3-Length(CCF)) + CCF;
          Valor := StringOfChar(' ', 13 - Length(Valor)) + Valor;
          FDataModule.ACBrECF.LinhaRelatorioGerencial(Numero + DataEmissao + Titulo + CCF + Valor);
        end;
        FDataModule.ACBrECF.LinhaRelatorioGerencial(StringOfChar('=',48));
        FDataModule.ACBrECF.FechaRelatorio;

        R06 := TR06VO.Create;
        R06.IdCaixa := UCaixa.Movimento.IdCaixa;
        R06.IdOperador := UCaixa.Movimento.IdOperador;
        R06.IdImpressora := UCaixa.Movimento.IdImpressora;
        R06.COO := StrToInt(FDataModule.ACBrECF.NumCOO);
        R06.GNF := StrToInt(FDataModule.ACBrECF.NumGNF);
        R06.GRG := StrToInt(FDataModule.ACBrECF.NumGRG);
        R06.Denominacao := 'RG';
        R06.DataEmissao := FormatDateTime('yyyy-mm-dd', FDataModule.ACBrECF.DataHora);
        R06.HoraEmissao := FormatDateTime('hh:nn:ss', FDataModule.ACBrECF.DataHora);
        TRegistroRController.GravaR06(R06);
      end
      else
        Application.MessageBox('Não existem DAV para o período informado.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
    end;
  end;

  //geração de arquivo
  if radiogroup1.ItemIndex = 1 then
  begin
    if Application.MessageBox('Deseja gerar o arquivo de DAV EMITIDOS?', 'Pergunta do Sistema', Mb_YesNo + Mb_IconQuestion) = IdYes then
    begin
      ListaDAV := TDAVController.ListaDAVPeriodo(mkeDataIni.Text,mkeDataFim.Text);
      if Assigned(ListaDAV) then
      begin
       // registro D1
       UPAF.PreencherHeader(FDataModule.ACBrPAF.PAF_D.RegistroD1); // preencher header do arquivo
       // registro D2
       FDataModule.ACBrPAF.PAF_D.RegistroD2.Clear;
       //dados da impressora
       Impressora := TImpressoraController.PegaImpressora(UCaixa.Configuracao.IdImpressora);
       for i := 0 to ListaDAV.Count - 1 do
       begin
        Tripa :=  IntToStr(TDAVVO(ListaDAV.Items[i]).Id) +
                  IntToStr(TDAVVO(ListaDAV.Items[i]).CCF) +
                  IntToStr(TDAVVO(ListaDAV.Items[i]).COO) +
                  TDAVVO(ListaDAV.Items[i]).DataEmissao +
                  TDAVVO(ListaDAV.Items[i]).HoraEmissao +
                  FormataFloat('V',TDAVVO(ListaDAV.Items[i]).Valor);

         D2              := FDataModule.ACBrPAF.PAF_D.RegistroD2.New;
         D2.NUM_FAB      := Impressora.Serie;
         D2.MF_ADICIONAL := Impressora.MFD;
         D2.TIPO_ECF     := Impressora.Tipo;
         D2.MARCA_ECF    := Impressora.Marca;
         if MD5String(Tripa) <> TDAVVO(ListaDAV.Items[i]).Hash then
           D2.MODELO_ECF   := StringOfChar('?',20)
         else
           D2.MODELO_ECF   := Impressora.Modelo;
         D2.COO          := IntToStr(TDAVVO(ListaDAV.Items[i]).COO);
         D2.NUM_DAV      := StringOfChar('0',10-Length(IntToStr(TDAVVO(ListaDAV.Items[i]).Id))) + IntToStr(TDAVVO(ListaDAV.Items[i]).Id);
         D2.DT_DAV       := StrToDate(TDAVVO(ListaDAV.Items[i]).DataEmissao);
          //no nosso paf o DAV será orçamento (depois podemos parametrizar isso)
         D2.TIT_DAV      := 'ORÇAMENTO';
         D2.VLT_DAV      := TDAVVO(ListaDAV.Items[i]).Valor;
       end;

       //nessa versão os arquivos serão salvos na pasta da aplicação
       FDataModule.ACBrPAF.SaveFileTXT_D(NOME_ARQUIVO);
       TEAD_Class.SingEAD(NOME_ARQUIVO);

       mensagem := 'Arquivo armazenado em: ' + gsAppPath + NOME_ARQUIVO;
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

procedure TFDavEmitidos.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = 123 then
    confirma;
end;

end.
