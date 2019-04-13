{*******************************************************************************
Title: T2Ti ERP
Description: Identifica um cliente não cadastrado para a venda. Permite chamar
a janela de pesquisa para importar um cliente cadastrado.

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
unit UIdentificaCliente;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JvExDBGrids, StdCtrls, JvExStdCtrls,
  JvButton, JvCtrls, Buttons, JvExButtons, JvBitBtn, pngimage, ExtCtrls, Mask,
  JvEdit, JvValidateEdit, Biblioteca, JvEnterTab, JvComponentBase,
  JvExMask, JvToolEdit, JvBaseEdits;

type
  TFIdentificaCliente = class(TForm)
    Image1: TImage;
    panPeriodo: TPanel;
    editCpfCnpj: TMaskEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    editNome: TEdit;
    editEndereco: TEdit;
    botaoLocaliza: TJvBitBtn;
    botaoConfirma: TJvBitBtn;
    botaoCancela: TJvImgBtn;
    JvEnterAsTab1: TJvEnterAsTab;
    editIDCliente: TJvCalcEdit;
    Label4: TLabel;
    procedure Localiza;
    procedure LocalizaClienteNoBanco;
    procedure Confirma;
    procedure botaoLocalizaClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure editCpfCnpjExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure botaoConfirmaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    function ValidaDados: Boolean;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FIdentificaCliente: TFIdentificaCliente;

implementation

uses UImportaCliente, UCaixa, ClienteController, ClienteVO;

var
  Cliente: TClienteVO;

{$R *.dfm}

procedure TFIdentificaCliente.FormActivate(Sender: TObject);
begin
  Color := StringToColor(UCaixa.Configuracao.CorJanelasInternas);
  Cliente := TClienteVO.Create;
end;

procedure TFIdentificaCliente.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFIdentificaCliente.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key = 122 then
    Localiza;
  if key = 123 then
    Confirma;
end;

procedure TFIdentificaCliente.botaoLocalizaClick(Sender: TObject);
begin
  Localiza;
end;

procedure TFIdentificaCliente.localiza;
begin
  Application.CreateForm(TFImportaCliente, FImportaCliente);
  FImportaCliente.ShowModal;
end;

procedure TFIdentificaCliente.editCpfCnpjExit(Sender: TObject);
begin
  if trim(editCpfCnpj.Text) <> '' then
    LocalizaClienteNoBanco;
end;

procedure TFIdentificaCliente.localizaClienteNoBanco;
begin
  Cliente := TClienteController.ConsultaCPFCNPJ(editCpfCnpj.Text);
  if Cliente.Id <> 0 then
  begin
    editIDCliente.AsInteger:= Cliente.Id;
    editNome.Text := Cliente.Nome;
  end;
end;

function TFIdentificaCliente.ValidaDados: Boolean;
begin
  Result := False;
  if length(editCpfCnpj.Text) = 11 then
    Result := ValidaCPF(editCpfCnpj.Text);

  if length(editCpfCnpj.Text) = 14 then
    Result := ValidaCNPJ(editCpfCnpj.Text);
end;

procedure TFIdentificaCliente.botaoConfirmaClick(Sender: TObject);
begin
  Confirma;
end;

procedure TFIdentificaCliente.confirma;
begin
  if ValidaDados then
  begin
    Cliente.CPFOuCNPJ := trim(editCpfCnpj.Text);
    Cliente.Nome := trim(editNome.Text);
    Cliente.Id := editIDCliente.AsInteger;
    Cliente.Logradouro := trim(editEndereco.Text);  // Adicionar

    UCaixa.Cliente := Cliente;
    Close;
  end
  else
  begin
    Application.MessageBox('CPF ou CNPJ Inválido!', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
    editCpfCnpj.SetFocus;
  end;
end;

end.
