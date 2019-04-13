{*******************************************************************************
Title: T2Ti ERP
Description: Gerar Arquivo Eletrônico de Estoque.

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
unit UEstoque;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JvExDBGrids, StdCtrls, JvExStdCtrls,
  JvButton, JvCtrls, Buttons, JvExButtons, JvBitBtn, pngimage, ExtCtrls, JvEdit,
  JvValidateEdit, JvEnterTab, JvComponentBase;

type
  TFEstoque = class(TForm)
    Image1: TImage;
    RadioGroup1: TRadioGroup;
    botaoConfirma: TJvBitBtn;
    botaoCancela: TJvImgBtn;
    JvEnterAsTab1: TJvEnterAsTab;
    PanelParcial: TPanel;
    RadioGroup2: TRadioGroup;
    panNome: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    panCodigo: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    editInicio: TJvValidateEdit;
    editFim: TJvValidateEdit;
    editNomeInicial: TEdit;
    editNomeFinal: TEdit;
    procedure confirma;
    procedure RadioGroup2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure botaoConfirmaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure RadioGroup1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FEstoque: TFEstoque;

implementation

uses
  UCaixa, UPAF;

{$R *.dfm}

procedure TFEstoque.botaoConfirmaClick(Sender: TObject);
begin
  Confirma;
end;

procedure TFEstoque.FormActivate(Sender: TObject);
begin
  Color := StringToColor(UCaixa.Configuracao.CorJanelasInternas);
end;

procedure TFEstoque.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFEstoque.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key = 123 then
    Confirma;
end;

procedure TFEstoque.FormShow(Sender: TObject);
begin
  RadioGroup1.SetFocus;
end;

procedure TFEstoque.RadioGroup1Click(Sender: TObject);
begin
  if RadioGroup1.ItemIndex = 0 then
    PanelParcial.Visible := False
  else
    PanelParcial.Visible := True;
end;

procedure TFEstoque.RadioGroup2Click(Sender: TObject);
begin
  if RadioGroup2.ItemIndex = 0 then
  begin;
    panCodigo.Enabled := True;
    panCodigo.BevelOuter := bvRaised;
    panNome.Enabled := False;
    panNome.BevelOuter := bvLowered;
  end
  else
  begin
    panCodigo.Enabled := False;
    panCodigo.BevelOuter := bvLowered;
    panNome.Enabled := True;
    panNome.BevelOuter := bvRaised;
  end;
end;

procedure TFEstoque.Confirma;
begin
  //Estoque Total
  if radiogroup1.ItemIndex = 0 then
  begin
    if Application.MessageBox('Deseja gerar o arquivo do Estoque?', 'Pergunta do Sistema', Mb_YesNo + Mb_IconQuestion) = IdYes then
      UPAF.GeraArquivoEstoque;
  end;

  //Estoque Parcial
  if radiogroup1.ItemIndex = 1 then
  begin
    if Application.MessageBox('Deseja gerar o arquivo do Estoque?', 'Pergunta do Sistema', Mb_YesNo + Mb_IconQuestion) = IdYes then
    //por codigo
    if radiogroup2.ItemIndex = 0 then
      UPAF.GeraArquivoEstoque(StrToInt(editInicio.Text), StrToInt(editFim.Text));
    //por nome
    if radiogroup2.ItemIndex = 1 then
      UPAF.GeraArquivoEstoque(editNomeInicial.Text,editNomeFinal.Text);
  end;
end;

end.
