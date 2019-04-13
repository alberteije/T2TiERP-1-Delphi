{*******************************************************************************
Title: T2Ti ERP
Description: Espelho da memória da fita detalhe.

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
unit UEspelhoMFD;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, JvExDBGrids, JvDBGrid, StdCtrls, JvExStdCtrls,
  JvButton, JvCtrls, Buttons, JvExButtons, JvBitBtn, pngimage, ExtCtrls, Mask,
  JvEdit, JvValidateEdit, SWSystem, JvExControls, JvEnterTab;

type
  TFEspelhoMfd = class(TForm)
    Image1: TImage;
    RadioGroup2: TRadioGroup;
    panPeriodo: TPanel;
    mkeDataIni: TMaskEdit;
    Label1: TLabel;
    mkeDataFim: TMaskEdit;
    Label2: TLabel;
    panCOO: TPanel;
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
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure botaoConfirmaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FEspelhoMfd: TFEspelhoMfd;
const
  NOME_ARQUIVO = 'EspelhoMDF.txt';

implementation

Uses
UCaixa, UDataModule, EAD_Class;

{$R *.dfm}

procedure TFEspelhoMfd.FormActivate(Sender: TObject);
begin
  Color := StringToColor(UCaixa.Configuracao.CorJanelasInternas);
  mkeDataIni.Text := DateToStr(Now);
  mkeDataFim.Text := DateToStr(Now);
  mkeDataIni.SetFocus;
end;

procedure TFEspelhoMfd.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFEspelhoMfd.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = 123 then
    confirma;
end;

procedure TFEspelhoMfd.RadioGroup2Click(Sender: TObject);
begin
  if RadioGroup2.ItemIndex = 0 then
  begin;
    panCOO.Enabled := False;
    panCOO.BevelOuter := bvLowered;
    panPeriodo.Enabled := True;
    panPeriodo.BevelOuter := bvRaised;
  end
  else
  begin
    panCOO.Enabled := True;
    panCOO.BevelOuter := bvRaised;
    panPeriodo.Enabled := False;
    panPeriodo.BevelOuter := bvLowered;
  end;
end;

procedure TFEspelhoMfd.botaoConfirmaClick(Sender: TObject);
begin
  confirma;
end;

procedure TFEspelhoMfd.confirma;
var
  Linhas : TStringList;
  mensagem : String;
begin
  if Application.MessageBox('Deseja gerar o espelho da MFD - Memória Fita Detalhe?', 'Pergunta do Sistema', Mb_YesNo + Mb_IconQuestion) = IdYes then
  begin
    //por data
    if radiogroup2.ItemIndex = 0 then
      FDataModule.ACBrECF.EspelhoMFD_DLL(StrToDateTime(mkeDataIni.Text),StrToDateTime(mkeDataFim.Text),NOME_ARQUIVO)
    //por reducao
    else if radiogroup2.ItemIndex = 1 then
      FDataModule.ACBrECF.EspelhoMFD_DLL(StrToInt(editInicio.Text),StrToInt(editFim.Text),NOME_ARQUIVO);

    TEAD_Class.SingEAD(NOME_ARQUIVO);

    mensagem := 'Arquivo armazenado em: ' + gsAppPath + NOME_ARQUIVO;
    Application.MessageBox(PWideChar(mensagem), 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
  end;
end;

end.
