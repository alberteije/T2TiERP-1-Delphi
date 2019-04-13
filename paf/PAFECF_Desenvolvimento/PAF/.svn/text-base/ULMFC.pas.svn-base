{*******************************************************************************
Title: T2Ti ERP
Description: Leitura da memória fiscal completa.

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
unit ULMFC;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JvExDBGrids, StdCtrls, JvExStdCtrls,
  JvButton, JvCtrls, Buttons, JvExButtons, JvBitBtn, pngimage, ExtCtrls, Mask,
  JvEdit, JvValidateEdit, SWSystem, JvEnterTab, JvComponentBase;

type
  TFLmfc = class(TForm)
    Image1: TImage;
    RadioGroup1: TRadioGroup;
    RadioGroup2: TRadioGroup;
    panPeriodo: TPanel;
    mkeDataIni: TMaskEdit;
    Label1: TLabel;
    mkeDataFim: TMaskEdit;
    Label2: TLabel;
    panCRZ: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    editInicio: TJvValidateEdit;
    editFim: TJvValidateEdit;
    botaoConfirma: TJvBitBtn;
    botaoCancela: TJvImgBtn;
    JvEnterAsTab1: TJvEnterAsTab;
    procedure Confirma;
    procedure RadioGroup2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure botaoConfirmaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FLmfc: TFLmfc;

const
  NOME_ARQUIVO = 'LMFC_Completa.txt';

implementation

Uses
  UCaixa, UDataModule, EAD_Class;

{$R *.dfm}

procedure TFLmfc.FormActivate(Sender: TObject);
begin
  Color := StringToColor(UCaixa.Configuracao.CorJanelasInternas);
  mkeDataIni.Text := DateToStr(Now);
  mkeDataFim.Text := DateToStr(Now);
  mkeDataIni.SetFocus;
end;

procedure TFLmfc.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFLmfc.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key = 123 then
    Confirma;
end;

procedure TFLmfc.RadioGroup2Click(Sender: TObject);
begin
  if RadioGroup2.ItemIndex = 0 then
  begin;
    panCRZ.Enabled := False;
    panCRZ.BevelOuter := bvLowered;
    panPeriodo.Enabled := True;
    panPeriodo.BevelOuter := bvRaised;
  end
  else
  begin
    panCRZ.Enabled := True;
    panCRZ.BevelOuter := bvRaised;
    panPeriodo.Enabled := False;
    panPeriodo.BevelOuter := bvLowered;
  end;
end;

procedure TFLmfc.botaoConfirmaClick(Sender: TObject);
begin
  Confirma;
end;

procedure TFLmfc.Confirma;
var
  Linhas: TStringList;
  Mensagem: String;
begin
  //impressao do documento no ECF
  if radiogroup1.ItemIndex = 0 then
  begin
    if Application.MessageBox('Deseja imprimir a LMFC - Leitura Memória Fiscal Completa?', 'Pergunta do Sistema', Mb_YesNo + Mb_IconQuestion) = IdYes then
    begin
      //por data
      if radiogroup2.ItemIndex = 0 then
        FDataModule.ACBrECF.LeituraMemoriaFiscal(StrToDateTime(mkeDataIni.Text),StrToDateTime(mkeDataFim.Text))
      //por reducao
      else if radiogroup2.ItemIndex = 1 then
        FDataModule.ACBrECF.LeituraMemoriaFiscal(StrToInt(editInicio.Text),StrToInt(editFim.Text));
    end;
  end;

  //Gravação de arquivo eletrônico no formato de espelho
  if radiogroup1.ItemIndex = 1 then
  begin
    if Application.MessageBox('Deseja gerar o arquivo da LMFC - Formato Espelho?', 'Pergunta do Sistema', Mb_YesNo + Mb_IconQuestion) = IdYes then
    begin
      Linhas := TStringList.Create ;
      //por data
      if radiogroup2.ItemIndex = 0 then
      begin
        FDataModule.ACBrECF.LeituraMemoriaFiscalSerial(StrToDateTime(mkeDataIni.Text),StrToDateTime(mkeDataFim.Text), Linhas);
        Linhas.SaveToFile(NOME_ARQUIVO);
        TEAD_Class.SingEAD(NOME_ARQUIVO);
        Linhas.Free;
      end
      //por reducao
      else if radiogroup2.ItemIndex = 1 then
      begin
        FDataModule.ACBrECF.LeituraMemoriaFiscalSerial(StrToInt(editInicio.Text),StrToInt(editFim.Text),Linhas);
        Linhas.SaveToFile(NOME_ARQUIVO);
        TEAD_Class.SingEAD(NOME_ARQUIVO);
        Linhas.Free;
      end;
    end;
    Mensagem := 'Arquivo armazenado em: ' + gsAppPath + NOME_ARQUIVO;
    Application.MessageBox(PWideChar(mensagem), 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
  end;

  //Gravação de arquivo eletrônico no formato Ato Cotepe 17/04
  if radiogroup1.ItemIndex = 2 then
  begin
    if Application.MessageBox('Deseja gerar o arquivo da LMFC - Formato Ato Cotepe 17/04?', 'Pergunta do Sistema', Mb_YesNo + Mb_IconQuestion) = IdYes then
    begin
      //por data
      if radiogroup2.ItemIndex = 0 then
        FDataModule.ACBrECF.ArquivoMFD_DLL(StrToDateTime(mkeDataIni.Text),StrToDateTime(mkeDataFim.Text),'LMFC_1704.txt')
      //por reducao
      else if radiogroup2.ItemIndex = 1 then
        FDataModule.ACBrECF.ArquivoMFD_DLL(StrToInt(editInicio.Text),StrToInt(editFim.Text),'LMFC_1704.txt');

      TEAD_Class.SingEAD(gsAppPath + 'LMFC_1704.txt');  // modificado gilson

      Mensagem := 'Arquivo armazenado em: ' + gsAppPath + 'LMFC_1704.txt';
      Application.MessageBox(PWideChar(mensagem), 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
    end;
  end;
end;

end.
