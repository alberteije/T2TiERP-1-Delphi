{*******************************************************************************
Title: T2Ti ERP
Description: Permite a emissão dos relatórios do Sintegra e SPED Fiscal

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
unit UVendasPeriodo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JvExDBGrids, StdCtrls, JvExStdCtrls,
  JvButton, JvCtrls, Buttons, JvExButtons, JvBitBtn, pngimage, ExtCtrls, Mask,
  JvEdit, JvValidateEdit, JvEnterTab, ComCtrls, JvComponentBase, DateUtils;

type
  TFVendasPeriodo = class(TForm)
    Image1: TImage;
    RadioGroup2: TRadioGroup;
    botaoConfirma: TJvBitBtn;
    botaoCancela: TJvImgBtn;
    panPeriodo: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    mkeDataIni: TMaskEdit;
    mkeDataFim: TMaskEdit;
    JvEnterAsTab1: TJvEnterAsTab;
    PageControl1: TPageControl;
    PaginaSintegra: TTabSheet;
    PaginaSped: TTabSheet;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    ComboBoxConvenio: TComboBox;
    ComboBoxNaturezaInformacoes: TComboBox;
    ComboBoxFinalidadeArquivo: TComboBox;
    Label6: TLabel;
    ComboBoxVersaoLeiauteSped: TComboBox;
    Label7: TLabel;
    ComboBoxFinalidadeArquivoSped: TComboBox;
    Label8: TLabel;
    ComboBoxPerfilSped: TComboBox;
    procedure Confirma;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure botaoConfirmaClick(Sender: TObject);
    procedure RadioGroup2Click(Sender: TObject);
    procedure mkeDataIniExit(Sender: TObject);
    procedure mkeDataFimExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FVendasPeriodo: TFVendasPeriodo;

implementation

uses UCaixa, USintegra, USpedFiscal;

{$R *.dfm}

procedure TFVendasPeriodo.botaoConfirmaClick(Sender: TObject);
begin
  Confirma;
end;

procedure TFVendasPeriodo.Confirma;
var
  CodigoConvenio, NaturezaInformacao, FinalidadeArquivo, Versao, Perfil: Integer;
begin
  if RadioGroup2.ItemIndex = 0 then
  begin
    if Application.MessageBox('Deseja gerar o arquivo do SINTEGRA (Convenio 57/95)?', 'Pergunta do Sistema', Mb_YesNo + Mb_IconQuestion) = IdYes then
    begin
      {
      1 - Convênio 57/95 Versão 31/99 Alt. 30/02
      2 - Convênio 57/95 Versão 69/02 Alt. 142/02
      3 - Convênio 57/95 Alt. 76/03
      }
      CodigoConvenio := StrToInt(Copy(ComboBoxConvenio.Text,1,1));
      {
      1 - Interestaduais - Somente operações sujeitas ao regime de Substituição Tributária
      2 - Interestaduais - Operações com ou sem Substituição Tributária
      3 - Totalidade das operações do informante
      }
      NaturezaInformacao := StrToInt(Copy(ComboBoxNaturezaInformacoes.Text,1,1));
      {
      1 - Normal
      2 - Retificação total de arquivo: substituição total de informações prestadas pelo contribuinte referentes a este período
      3 - Retificação aditiva de arquivo: acréscimo de informação não incluída em arquivos já apresentados
      5 - Desfazimento: arquivo de informação referente a operações/prestações não efetivadas .
          Neste caso, o arquivo deverá conter, além dos registros tipo 10 e tipo 90, apenas os registros referentes as operações/prestações não efetivadas
      }
      FinalidadeArquivo := StrToInt(Copy(ComboBoxFinalidadeArquivo.Text,1,1));
      USintegra.GerarArquivoSintegra(mkeDataIni.Text,mkeDataFim.Text, CodigoConvenio, NaturezaInformacao, FinalidadeArquivo);
    end;
  end;
  if RadioGroup2.ItemIndex = 1 then
  begin
    if Application.MessageBox('Deseja gerar o arquivo do SPED FISCAL (Ato COTEPE/ICMS 09/08)?', 'Pergunta do Sistema', Mb_YesNo + Mb_IconQuestion) = IdYes then
    begin
      Versao := ComboBoxVersaoLeiauteSped.ItemIndex;
      FinalidadeArquivo := ComboBoxVersaoLeiauteSped.ItemIndex;
      Perfil := ComboBoxPerfilSped.ItemIndex;
//      VersaoLeiaute := ComboBoxVersaoLeiauteSped.ItemIndex;  // JM Sistemas
//      FinalidadeArquivo := ComboBoxFinalidadeArquivoSped.ItemIndex; // JM Sistemas
//      PerfilApresentacao := ComboBoxPerfilSped.ItemIndex; // JM Sistemas
      USpedFiscal.GerarArquivoSpedFiscal(mkeDataIni.Text,mkeDataFim.Text, Versao, FinalidadeArquivo, Perfil);
    end;
  end;
end;

procedure TFVendasPeriodo.FormActivate(Sender: TObject);
begin
  Color := StringToColor(UCaixa.Configuracao.CorJanelasInternas);
  mkeDataIni.Text := DateToStr(StartOfTheMonth(Now));
  mkeDataFim.Text := DateToStr(EndOfTheMonth(Now));
  mkeDataIni.SetFocus;
end;

procedure TFVendasPeriodo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFVendasPeriodo.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key = 123 then
    Confirma;
end;

procedure TFVendasPeriodo.mkeDataFimExit(Sender: TObject);
begin
  if  StrToDate(mkeDataIni.Text) > StrToDate(mkeDataFim.Text)  then
      begin
        Application.MessageBox('Data inicial não pode ser maior que data final!', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
        mkeDataFim.setFocus;
      end;
end;

procedure TFVendasPeriodo.mkeDataIniExit(Sender: TObject);
begin
  mkeDataFim.Text := DateToStr(EndOfTheMonth(strtodate(mkeDataIni.Text)));
end;

procedure TFVendasPeriodo.RadioGroup2Click(Sender: TObject);
begin
  if RadioGroup2.ItemIndex = 0 then
  begin;
    PageControl1.TabIndex := 0;
  end
  else
  begin
    PageControl1.TabIndex := 1;
  end;
end;

end.
