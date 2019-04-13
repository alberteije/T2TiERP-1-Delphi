{*******************************************************************************
Title: T2Ti ERP
Description: Janela de Lookup (consulta e importação) padrão para toda a aplicação

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
unit ULookup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, JvExDBGrids, JvDBGrid, JvDBUltimGrid, StdCtrls,
  ExtCtrls, Buttons, Rtti, DB, DBClient, TypInfo;

type
  TFLookup = class(TForm)
    PanelFiltroRapido: TPanel;
    Label1: TLabel;
    EditCriterioRapido: TLabeledEdit;
    ComboBoxCampos: TComboBox;
    Grid: TJvDBUltimGrid;
    BotaoPesquisa: TSpeedButton;
    BotaoImporta: TSpeedButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure BotaoPesquisaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditCriterioRapidoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure GridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure BotaoImportaClick(Sender: TObject);
    procedure ComboBoxCamposKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FLookup: TFLookup;
  ObjetoVO: TObject;
  ObjetoController: TObject;
  CampoRetorno1, CampoRetorno2: String;

implementation

uses UDataModule, Atributos;

{$R *.dfm}

procedure TFLookup.EditCriterioRapidoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key = VK_RETURN then
    Grid.SetFocus;
end;

procedure TFLookup.FormActivate(Sender: TObject);
var
  Contexto: TRttiContext;
  Tipo: TRttiType;
  Propriedade: TRttiProperty;
  Atributo: TCustomAttribute;
  i: Integer;
begin
  try
    Contexto := TRttiContext.Create;
    Tipo := Contexto.GetType(ObjetoVO.ClassType);

    //configura ClientDataset
    FDataModule.CDSLookup.Close;
    FDataModule.CDSLookup.FieldDefs.Clear;

    //preenche os nomes dos campos do CDS
    FDataModule.CDSLookup.FieldDefs.add('ID', ftInteger);
    for Propriedade in Tipo.GetProperties do
    begin
      for Atributo in Propriedade.GetAttributes do
      begin
        if Atributo is TColumn then
        begin
          if (Atributo as TColumn).LocalDispay in [ldGrid,ldGridLookup] then
          begin
            if Propriedade.PropertyType.TypeKind in [tkString, tkUString] then
              FDataModule.CDSLookup.FieldDefs.add((Atributo as TColumn).Name, ftString, 50)
            else if Propriedade.PropertyType.TypeKind in [tkFloat] then
              FDataModule.CDSLookup.FieldDefs.add((Atributo as TColumn).Name, ftFloat)
            else if Propriedade.PropertyType.TypeKind in [tkInt64, tkInteger] then
              FDataModule.CDSLookup.FieldDefs.add((Atributo as TColumn).Name, ftInteger)
          end;
        end;
      end;
    end;
    FDataModule.CDSLookup.CreateDataSet;

    //Configura a Grid
    i := 1;
    Grid.Columns[0].Title.Caption := 'ID';
    for Propriedade in Tipo.GetProperties do
    begin
      for Atributo in Propriedade.GetAttributes do
      begin
        if Atributo is TColumn then
        begin
          if (Atributo as TColumn).Lookup then
          begin
            Grid.Columns[i].Title.Caption := (Atributo as TColumn).Caption;
            inc(i);
          end;
        end;
      end;
    end;

    FDataModule.CDSLookup.GetFieldNames(ComboBoxCampos.Items);
    ComboBoxCampos.ItemIndex := 0;

    ComboBoxCampos.SetFocus;
  finally
    Contexto.Free;
  end;
end;

procedure TFLookup.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  try
    CampoRetorno1 := FDataModule.CDSLookup.FieldByName(CampoRetorno1).AsString;
    CampoRetorno2 := FDataModule.CDSLookup.FieldByName(CampoRetorno2).AsString;
  finally
  end;
  Action := caFree;
end;

procedure TFLookup.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key = VK_F9 then
    BotaoPesquisa.Click;

  if key = VK_F12 then
    BotaoImporta.Click;

  if key = VK_ESCAPE then
    Close;
end;

procedure TFLookup.GridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key = VK_RETURN then
    EditCriterioRapido.SetFocus;
end;

procedure TFLookup.BotaoImportaClick(Sender: TObject);
begin
  ModalResult := mrOK;
end;

procedure TFLookup.BotaoPesquisaClick(Sender: TObject);
var
  Contexto: TRttiContext;
  Tipo: TRttiType;
  Filtro: String;
  Pagina: Integer;
begin
 try
    Contexto := TRttiContext.Create;
    Tipo := Contexto.GetType(ObjetoController.ClassType);

    if Trim(EditCriterioRapido.Text) = '' then
    begin
      EditCriterioRapido.clear;
      EditCriterioRapido.Text := '*';
      Pagina := 0;
      Filtro := ComboBoxCampos.Items.Strings[ComboBoxCampos.ItemIndex] + ' LIKE "*' + EditCriterioRapido.Text + '*"';
      Tipo.GetMethod('Consulta').Invoke(ObjetoController.ClassType, [trim(Filtro), Pagina, True]);
      FDataModule.CDSLookup.First;
    end
    else
    begin
      Pagina := 0;
      Filtro := ComboBoxCampos.Items.Strings[ComboBoxCampos.ItemIndex] + ' LIKE "*' + EditCriterioRapido.Text + '*"';
      Tipo.GetMethod('Consulta').Invoke(ObjetoController.ClassType, [trim(Filtro), Pagina, True]);
      FDataModule.CDSLookup.First;
    end;

  finally
    Contexto.Free;
  end;
end;

procedure TFLookup.ComboBoxCamposKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key = VK_RETURN then
    EditCriterioRapido.SetFocus;
end;

end.
