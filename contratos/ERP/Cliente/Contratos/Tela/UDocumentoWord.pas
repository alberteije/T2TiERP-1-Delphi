{ *******************************************************************************
  Title: T2Ti ERP
  Description: Janela para edi��o de documentos Word

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
unit UDocumentoWord;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, Grids, DBGrids, StdCtrls, ExtCtrls, ActnList,
  RibbonSilverStyleActnCtrls, ActnMan, ToolWin, ActnCtrls, LabeledCtrls, ComCtrls,
  rpgraphicex, OleCtnrs;

type
  TFDocumentoWord = class(TForm)
    ActionToolBarPrincipal: TActionToolBar;
    ActionManagerLocal: TActionManager;
    ActionSalvarSair: TAction;
    OleContainer: TOleContainer;
    ActionCancelarSair: TAction;
    procedure ActionSalvarSairExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ActionCancelarSairExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Operacao: String; //Inserir / Alterar
    ListaSubstituicoes: TStringList;
  end;

var
  FDocumentoWord: TFDocumentoWord;

implementation

uses
  UMenu, UDataModule;
{$R *.dfm}

procedure TFDocumentoWord.FormActivate(Sender: TObject);
var
  Documento: Variant;
  i: Integer;
  Find, Replace: String;
begin
  if Operacao = 'Inserir' then
  begin
    try
      // cria um novo documento do word
      OleContainer.CreateObject('Word.Document', False);
      // abre o documento no pr�prio componente e n�o numa janela separada
      OleContainer.AllowInPlace := True;
      // requisita uma a��o ao oleContainer
      {
        ovPrimary is principally used by the DoVerb method in order to send a request for the default action, usually to activate the OLE object.
        ovShow is principally used by the DoVerb method in order to show the OLE object.
        ovHide is principally used by the DoVerb method in order to hide the OLE object.
        ovInPlaceActivate is principally used by the DoVerb method in order to activate the OLE object in place.
        ovOpen is principally used by the DoVerb method in order to open the application window that the OLE provider registered.
        ovDiscardUndoState is principally used by the DoVerb method in order to discard the undo state of the OLE object.
        ovUIActivate is principally used by the DoVerb method in order to activate the User Interface.
      }
      OleContainer.DoVerb(ovPrimary);
    except
      on E: Exception do
      begin
        Application.MessageBox(PChar('Ocorreu um erro durante ao criar um novo documento. Informe a mensagem ao Administrador do sistema.' + #13 + #13 + E.Message), 'Erro do sistema', MB_OK + MB_ICONERROR);
        Close;
      end;
    end;
  end
  else if Operacao = 'Alterar' then
  begin
    try
      OleContainer.CreateObjectFromFile(ExtractFilePath(Application.ExeName)+'temp.doc', false);
      OleContainer.DoVerb(ovShow);

      // Faz as devidas substitui��es no template
      Documento := FDocumentoWord.OleContainer.OleObject;
      for i := 0 to ListaSubstituicoes.Count - 1 do
      begin
        Find := Copy(ListaSubstituicoes[i], 1, Pos('|', ListaSubstituicoes[i]) - 1);
        Replace := Copy(ListaSubstituicoes[i], Pos('|', ListaSubstituicoes[i]) + 1, Length(ListaSubstituicoes[i]) -  Pos('|', ListaSubstituicoes[i]));
        while Documento.Content.Find.Execute(FindText := Find) do
          Documento.Content.Find.Execute(FindText := Find, ReplaceWith := Replace);
      end;

    except
      on E: Exception do
      begin
        Application.MessageBox(PChar('Ocorreu um erro ao carregar um documento existente. Informe a mensagem ao Administrador do sistema.' + #13 + #13 + E.Message), 'Erro do sistema', MB_OK + MB_ICONERROR);
        Close;
      end;
    end;
  end;
end;

procedure TFDocumentoWord.ActionCancelarSairExecute(Sender: TObject);
begin
  Close;
end;

procedure TFDocumentoWord.ActionSalvarSairExecute(Sender: TObject);
begin
  try
    OleContainer.SaveAsDocument(ExtractFilePath(Application.ExeName)+'temp.doc');
  except
  end;
  Close;
end;

procedure TFDocumentoWord.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  OleContainer.Close;
  Release;
end;

procedure TFDocumentoWord.FormCreate(Sender: TObject);
begin
  ListaSubstituicoes := TStringList.Create;
end;

procedure TFDocumentoWord.FormDestroy(Sender: TObject);
begin
  ListaSubstituicoes.Free;
end;

end.

