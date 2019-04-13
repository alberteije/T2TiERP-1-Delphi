{*******************************************************************************
Title: T2Ti ERP
Description: Leitura da memória fiscal simplificada.

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
unit ULMFS;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, JvExDBGrids, JvDBGrid, StdCtrls, JvExStdCtrls,
  JvButton, JvCtrls, Buttons, JvExButtons, JvBitBtn, pngimage, ExtCtrls, JvEdit,
  JvValidateEdit, Mask, SWSystem, JvExControls, JvEnterTab;

type
  TFLmfs = class(TForm)
    Image1: TImage;
    RadioGroup1: TRadioGroup;
    RadioGroup2: TRadioGroup;
    panPeriodo: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    mkeDataIni: TMaskEdit;
    mkeDataFim: TMaskEdit;
    panCRZ: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    editInicio: TJvValidateEdit;
    editFim: TJvValidateEdit;
    botaoConfirma: TJvBitBtn;
    botaoCancela: TJvImgBtn;
    JvEnterAsTab1: TJvEnterAsTab;
    procedure confirma;
    procedure RadioGroup2Click(Sender: TObject);
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
  FLmfs: TFLmfs;
const
  NOME_ARQUIVO = 'LMFC_Simplificada.txt';

implementation

Uses
UCaixa, UDataModule, EAD_Class;

{$R *.dfm}

procedure TFLmfs.botaoConfirmaClick(Sender: TObject);
begin
  confirma;
end;

procedure TFLmfs.FormActivate(Sender: TObject);
begin
  Color := StringToColor(UCaixa.Configuracao.CorJanelasInternas);
  mkeDataIni.Text := DateToStr(Now);
  mkeDataFim.Text := DateToStr(Now);
  mkeDataIni.SetFocus;
end;

procedure TFLmfs.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFLmfs.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = 123 then
    confirma;
end;

procedure TFLmfs.RadioGroup2Click(Sender: TObject);
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

procedure TFLmfs.confirma;
var
  Linhas : TStringList;
  Mensagem : String;
begin
  //impressao do documento no ECF
  if radiogroup1.ItemIndex = 0 then
  begin
    if Application.MessageBox('Deseja imprimir a LMFS - Leitura Memória Fiscal Simplificada?', 'Pergunta do Sistema', Mb_YesNo + Mb_IconQuestion) = IdYes then
    begin
      //por data
      if radiogroup2.ItemIndex = 0 then
        FDataModule.ACBrECF.LeituraMemoriaFiscal(StrToDateTime(mkeDataIni.Text),StrToDateTime(mkeDataFim.Text),True)
      //por reducao
      else if radiogroup2.ItemIndex = 1 then
        FDataModule.ACBrECF.LeituraMemoriaFiscal(StrToInt(editInicio.Text),StrToInt(editFim.Text),True);
    end;
  end;

  //Gravação de arquivo eletrônico no formato de espelho
  if radiogroup1.ItemIndex = 1 then
  begin
    if Application.MessageBox('Deseja gerar o arquivo da LMFS - Leitura Memória Fiscal Simplificada?', 'Pergunta do Sistema', Mb_YesNo + Mb_IconQuestion) = IdYes then
    begin
      Linhas := TStringList.Create ;
      //por data
      if radiogroup2.ItemIndex = 0 then
      begin
        FDataModule.ACBrECF.LeituraMemoriaFiscalSerial(StrToDateTime(mkeDataIni.Text),StrToDateTime(mkeDataFim.Text), Linhas, True);
        Linhas.SaveToFile(NOME_ARQUIVO);
        TEAD_Class.SingEAD(NOME_ARQUIVO);
        Linhas.Free;
      end
      //por reducao
      else if radiogroup2.ItemIndex = 1 then
      begin
        FDataModule.ACBrECF.LeituraMemoriaFiscalSerial(StrToInt(editInicio.Text),StrToInt(editFim.Text),Linhas,True);
        Linhas.SaveToFile(NOME_ARQUIVO);
        TEAD_Class.SingEAD(NOME_ARQUIVO);
        Linhas.Free;
      end;
    end;
    mensagem := 'Arquivo armazenado em: ' + gsAppPath + NOME_ARQUIVO;
    Application.MessageBox(PWideChar(mensagem), 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
  end;
end;

end.
