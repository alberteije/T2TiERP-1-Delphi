{*******************************************************************************
Title: T2Ti ERP
Description: Janela de filtro que será utilizada por toda a aplicação

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
@version 1.1
*******************************************************************************}
unit UFiltro;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, ComCtrls, JvgGroupBox, JvExStdCtrls,
  JvGroupBox, JvExExtCtrls, JvRadioGroup, SWSystem, Menus, DBClient,
  JvExControls, JvEnterTab, ACBrBase, ACBrEnterTab;

type
  TFFiltro = class(TForm)
    BotaoResult: TBitBtn;
    JvgGroupBox1: TJvgGroupBox;
    ListaCampos: TListBox;
    ListaOperadores: TListBox;
    EditExpressao: TLabeledEdit;
    Label1: TLabel;
    Label2: TLabel;
    GrupoEOU: TJvRadioGroup;
    JvgGroupBox2: TJvgGroupBox;
    Label6: TLabel;
    MemoSQL: TMemo;
    ListaCriterios: TListBox;
    JvgGroupBox3: TJvgGroupBox;
    Label3: TLabel;
    ListaSalvos: TListBox;
    Label4: TLabel;
    BotaoAdicionaCriterio: TSpeedButton;
    BotaoRemoveCriterio: TSpeedButton;
    BotaoSalvarFiltro: TSpeedButton;
    BotaoAplicarFiltro: TSpeedButton;
    BotaoLimparCriterios: TSpeedButton;
    BotalESC: TBitBtn;
    PopupMenu: TPopupMenu;
    CarregarFiltro1: TMenuItem;
    ExcluirFiltro1: TMenuItem;
    ACBrEnterTab1: TACBrEnterTab;
    function defineEOU:String;
    function defineOperador:String;
    procedure CarregaFiltros;
    procedure BotaoAplicarFiltroClick(Sender: TObject);
    procedure BotaoAdicionaCriterioClick(Sender: TObject);
    procedure BotaoRemoveCriterioClick(Sender: TObject);
    procedure BotaoLimparCriteriosClick(Sender: TObject);
    procedure BotaoSalvarFiltroClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure CarregarFiltro1Click(Sender: TObject);
    procedure ExcluirFiltro1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);

  private
    { Private declarations }
  public
    { Public declarations }
    QuemChamou: String;
    CDSUtilizado: TClientDataSet;
  end;

var
  FFiltro: TFFiltro;

implementation

uses UDataModule;

{$R *.dfm}

procedure TFFiltro.CarregaFiltros;
var
  F: TSearchRec;
  Ret: Integer;
begin
  ListaSalvos.Clear;
  Ret := FindFirst(gsAppPath + 'Filtros\*.*', faAnyFile, F);
  try
    while Ret = 0 do
    begin
      if Copy(F.Name,1,Length(QuemChamou)+1) = QuemChamou+'L' then
        ListaSalvos.Items.Add(Copy(F.Name,Length(QuemChamou)+2,Length(F.Name)));
      Ret := FindNext(F);
    end;
  finally

    FindClose(F);
  end;
end;

procedure TFFiltro.CarregarFiltro1Click(Sender: TObject);
begin
  if ListaSalvos.ItemIndex = -1 then
  begin
    Application.MessageBox('Selecione um filtro para carregar.', 'Erro', MB_OK + MB_ICONERROR);
  end
  else
  begin
    MemoSQL.Lines.LoadFromFile(gsAppPath + 'Filtros\' + QuemChamou + 'M' + ListaSalvos.Items.Strings[ListaSalvos.ItemIndex]);
    ListaCriterios.Items.LoadFromFile(gsAppPath + 'Filtros\' + QuemChamou + 'L' + ListaSalvos.Items.Strings[ListaSalvos.ItemIndex]);
  end;
end;

function TFFiltro.defineEOU: String;
begin
  if GrupoEOU.ItemIndex = 0 then
    result := ' AND'
  else
    result := ' OR';
end;

function TFFiltro.defineOperador: String;
begin
  case ListaOperadores.ItemIndex of
    0:begin
        Result := '="'+EditExpressao.Text+'"';
    end;
    1:begin
        Result := '<>"'+EditExpressao.Text+'"';
    end;
    2:begin
        Result := '<"'+EditExpressao.Text+'"';
    end;
    3:begin
        Result := '>"'+EditExpressao.Text+'"';
    end;
    4:begin
        Result := '<="'+EditExpressao.Text+'"';
    end;
    5:begin
        Result := '>="'+EditExpressao.Text+'"';
    end;
    6:begin
        Result := ' IS NULL ';
    end;
    7:begin
        Result := ' IS NOT NULL ';
    end;
    8:begin
        Result := ' LIKE "'+EditExpressao.Text+'*"';
    end;
    9:begin
        Result := ' LIKE "*'+EditExpressao.Text+'"';
    end;
    10:begin
        Result := ' LIKE "*'+EditExpressao.Text+'*"';
    end;
  end;
end;

procedure TFFiltro.ExcluirFiltro1Click(Sender: TObject);
begin
  if ListaSalvos.ItemIndex = -1 then
  begin
    Application.MessageBox('Selecione um filtro para excluir.', 'Erro', MB_OK + MB_ICONERROR);
  end
  else
  begin
    DeleteFile(gsAppPath + 'Filtros\' + QuemChamou + 'M' + ListaSalvos.Items.Strings[ListaSalvos.ItemIndex]);
    DeleteFile(gsAppPath + 'Filtros\' + QuemChamou + 'L' + ListaSalvos.Items.Strings[ListaSalvos.ItemIndex]);
    CarregaFiltros;
    BotaoLimparCriterios.Click;
  end;
end;

procedure TFFiltro.FormActivate(Sender: TObject);
begin
  CDSUtilizado.GetFieldNames(ListaCampos.Items);
  CarregaFiltros;
  ListaCampos.ItemIndex := 0;
  ListaOperadores.ItemIndex := 0;
  ListaSalvos.SetFocus;
end;

procedure TFFiltro.BotaoAdicionaCriterioClick(Sender: TObject);
var
  Criterio: String;
  ConsultaSQL: String;
begin
  if ListaCampos.ItemIndex = -1 then
  begin
    Application.MessageBox('É necessário selecionar um campo.', 'Erro', MB_OK + MB_ICONERROR);
  end
  else
  begin

    Criterio := '';
    ConsultaSQL := '';

    if ListaCriterios.Count > 0 then
    begin
      Criterio := '[' + GrupoEOU.Items.Strings[GrupoEOU.ItemIndex] + ']';
      ConsultaSQL := defineEOU;
    end;

    if (ListaOperadores.ItemIndex = 6) or (ListaOperadores.ItemIndex = 7) then
    begin
      //Critério
      Criterio :=
                Criterio
                + ' ' +
                ListaCampos.Items.Strings[ListaCampos.ItemIndex]
                + ' [' +
                ListaOperadores.Items.Strings[ListaOperadores.ItemIndex]
                + '] ';
      ListaCriterios.Items.Add(Criterio);

      //Consulta SQL
      ConsultaSQL :=
                ConsultaSQL
                + ' ' +
                ListaCampos.Items.Strings[ListaCampos.ItemIndex]
                +
                DefineOperador;
      MemoSQL.Lines.Add(ConsultaSQL);
    end
    else
    begin
      if EditExpressao.Text <> '' then
      begin
        //Critério
        Criterio :=
                  Criterio
                  + ' ' +
                  ListaCampos.Items.Strings[ListaCampos.ItemIndex]
                  + ' [' +
                  ListaOperadores.Items.Strings[ListaOperadores.ItemIndex]
                  + '] ' +
                  '"'+EditExpressao.Text+'"';
        ListaCriterios.Items.Add(Criterio);

        //Consulta SQL
        ConsultaSQL :=
                  ConsultaSQL
                  + ' ' +
                  ListaCampos.Items.Strings[ListaCampos.ItemIndex]
                  + DefineOperador;
        MemoSQL.Lines.Add(ConsultaSQL);
      end
      else
      begin
        Application.MessageBox('Não existe expressão para filtro.', 'Erro', MB_OK + MB_ICONERROR);
        EditExpressao.SetFocus;
      end;
    end;
  end;
end;

procedure TFFiltro.BotaoRemoveCriterioClick(Sender: TObject);
begin
  if ListaCriterios.ItemIndex = -1 then
  begin
    Application.MessageBox('Selecione um critério para remover.', 'Erro', MB_OK + MB_ICONERROR);
  end
  else
  begin
    if (ListaCriterios.ItemIndex = 0) and (ListaCriterios.Items.Count > 1) then
    begin
      if Application.MessageBox('Primeiro critério selecionado. Existem outros critérios. Todos os critérios serão excluídos. Continua?', 'Pergunta do sistema', MB_YesNo + MB_IconQuestion) = IdYes then
      begin
        ListaCriterios.Clear;
        MemoSQL.Clear;
      end;
    end
    else
    begin
      MemoSQL.Lines.Delete(ListaCriterios.ItemIndex);
      ListaCriterios.DeleteSelected;
    end;
  end;
end;

procedure TFFiltro.BotaoSalvarFiltroClick(Sender: TObject);
var
  NomeFiltro: String;
begin
  if ListaCriterios.ItemIndex = -1 then
  begin
    Application.MessageBox('Não existem critérios para salvar um filtro.', 'Erro', MB_OK + MB_ICONERROR);
  end
  else
  begin
    NomeFiltro := InputBox('Nome do filtro', 'Informe o nome do filtro para armazenamento:', '');
    if Trim(NomeFiltro) <> '' then
    begin
      ListaCriterios.Items.SaveToFile(gsAppPath + 'Filtros\' + QuemChamou + 'L' + NomeFiltro);
      MemoSQL.Lines.SaveToFile(gsAppPath + 'Filtros\' + QuemChamou + 'M' + NomeFiltro);
      CarregaFiltros;
    end;
  end;
end;

procedure TFFiltro.BotaoAplicarFiltroClick(Sender: TObject);
begin
  BotaoResult.Click;
end;

procedure TFFiltro.BotaoLimparCriteriosClick(Sender: TObject);
begin
  ListaCriterios.Clear;
  MemoSQL.Clear;
end;

procedure TFFiltro.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  //F2
  if Key = 113 then
    BotaoAdicionaCriterio.Click;
  //F4
  if Key = 115 then
    BotaoRemoveCriterio.Click;
  //F5
  if Key = 116 then
    BotaoAplicarFiltro.Click;
  //F11
  if Key = 122 then
    BotaoLimparCriterios.Click;
  //F12
  if Key = 123 then
    BotaoSalvarFiltro.Click;
end;

end.
