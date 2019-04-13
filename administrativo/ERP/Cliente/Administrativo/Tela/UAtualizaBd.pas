{ *******************************************************************************
  Title: T2Ti ERP
  Description: Janela para atualização do banco de dados

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

  @author Albert Eije (alberteije@gmail.com)
  @version 1.0
  ******************************************************************************* }
unit UAtualizaBd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, Grids, DBGrids, StdCtrls, ExtCtrls, ActnList,
  RibbonSilverStyleActnCtrls, ActnMan, ToolWin, ActnCtrls, LabeledCtrls, ComCtrls,
  rpgraphicex, JvComponentBase, ShellApi;

type
  TFAtualizaBd = class(TForm)
    PanelCabecalho: TPanel;
    Bevel1: TBevel;
    Image1: TImage;
    Label2: TLabel;
    ActionToolBarPrincipal: TActionToolBar;
    ActionManagerLocal: TActionManager;
    ActionCancelar: TAction;
    ActionAtualizar: TAction;
    PageControlItens: TPageControl;
    tsDados: TTabSheet;
    PanelDados: TPanel;
    ActionSair: TAction;
    EditArquivoSelecionado: TLabeledEdit;
    procedure ActionCancelarExecute(Sender: TObject);
    procedure ActionSairExecute(Sender: TObject);
    procedure ActionAtualizarExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FAtualizaBd: TFAtualizaBd;

implementation

uses
  UMenu, UDataModule;
{$R *.dfm}

procedure TFAtualizaBd.ActionCancelarExecute(Sender: TObject);
begin
  Close;
end;

procedure TFAtualizaBd.ActionSairExecute(Sender: TObject);
begin
  Close;
end;

procedure TFAtualizaBd.ActionAtualizarExecute(Sender: TObject);
var
  Parametros, theProgram, itsParameters: String;
  rslt:cardinal;
begin
  if FDataModule.OpenDialog.Execute then
  begin
    EditArquivoSelecionado.Text := FDataModule.OpenDialog.FileName;
    try
      CopyFile(PChar(EditArquivoSelecionado.Text), PChar('C:\Documents and Settings\Eije\Desktop\T2Ti ERP\Fontes\ERP\Servidor\Arquivos\Atualizacao\atualiza.sql'), False);
    except
      on E: Exception do
        Application.MessageBox(PChar('Ocorreu um erro na atualização. Informe a mensagem à Software House.' + #13 + #13 + E.Message), 'Erro do sistema', MB_OK + MB_ICONERROR);
    end;

    {TODO -oT2Ti -cAdministrativo : Transfira essa lógica para o Servidor}
    WinExec('C:\Documents and Settings\Eije\Desktop\T2Ti ERP Delphi\Fontes\ERP\Cliente\Administrativo\AtualizaBdFb.bat', SW_HIDE);
    Application.MessageBox(PChar('Banco de Dados Atualizado com Sucesso!'), 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
  end;
end;

end.
