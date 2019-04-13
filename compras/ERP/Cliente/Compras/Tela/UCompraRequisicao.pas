{ *******************************************************************************
  Title: T2Ti ERP
  Description: Janela de Requisição de Compra

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
  t2ti.com@gmail.com

  @author Albert Eije
  @version 1.0
  ******************************************************************************* }
unit UCompraRequisicao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UTelaCadastro, Menus, StdCtrls, ExtCtrls, Buttons, Grids, DBGrids,
  JvExDBGrids, JvDBGrid, JvDBUltimGrid, ComCtrls, LabeledCtrls, Atributos, Constantes,
  Mask, JvExMask, JvToolEdit, JvBaseEdits, DB, DBClient, Generics.Collections,
  WideStrings, DBXMySql, FMTBcd, Provider, SqlExpr, StrUtils;

type
  [TFormDescription(TConstantes.MODULO_COMPRAS, 'Requisição')]

  TFCompraRequisicao = class(TFTelaCadastro)
    GroupBoxCompraRequisicaoDetalhe: TGroupBox;
    GridCompraRequisicaoDetalhe: TJvDBUltimGrid;
    CDSCompraRequisicaoDetalhe: TClientDataSet;
    DSCompraRequisicaoDetalhe: TDataSource;
    BevelEdits: TBevel;
    EditIdCompraTipoRequisicao: TLabeledCalcEdit;
    EditIdColaborador: TLabeledCalcEdit;
    EditColaborador: TLabeledEdit;
    EditCompraTipoRequisicao: TLabeledEdit;
    EditDataRequisicao: TLabeledDateEdit;
    CDSCompraRequisicaoDetalheID: TIntegerField;
    CDSCompraRequisicaoDetalheID_PRODUTO: TIntegerField;
    CDSCompraRequisicaoDetalheProdutoNome: TStringField;
    CDSCompraRequisicaoDetalheID_COMPRA_REQUISICAO: TIntegerField;
    CDSCompraRequisicaoDetalheQUANTIDADE: TFMTBCDField;
    CDSCompraRequisicaoDetalheQUANTIDADE_COTADA: TFMTBCDField;
    CDSCompraRequisicaoDetalhePERSISTE: TStringField;
    PopupMenuCompraRequisicaoDetalhe: TPopupMenu;
    Excluir1: TMenuItem;
    CDSCompraRequisicaoDetalheITEM_COTADO: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure EditIdColaboradorExit(Sender: TObject);
    procedure EditIdCompraTipoRequisicaoExit(Sender: TObject);
    procedure GridCompraRequisicaoDetalheUserSort(Sender: TJvDBUltimGrid; var FieldsToSort: TSortFields; SortString: string; var SortOK: Boolean);
    procedure CDSCompraRequisicaoDetalheAfterEdit(DataSet: TDataSet);
    procedure GridCompraRequisicaoDetalheKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditIdCompraTipoRequisicaoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditIdColaboradorKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditIdColaboradorKeyPress(Sender: TObject; var Key: Char);
    procedure EditIdCompraTipoRequisicaoKeyPress(Sender: TObject; var Key: Char);
    procedure Excluir1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure GridParaEdits; override;
    procedure LimparCampos; override;

    // Controles CRUD
    function DoInserir: Boolean; override;
    function DoEditar: Boolean; override;
    function DoExcluir: Boolean; override;
    function DoSalvar: Boolean; override;
  end;

var
  FCompraRequisicao: TFCompraRequisicao;

implementation

uses CompraRequisicaoController, CompraRequisicaoVO, CompraTipoRequisicaoController,
  CompraTipoRequisicaoVO, CompraRequisicaoDetalheVO, ULookup, ColaboradorVO,
  ColaboradorController, ProdutoVO, ProdutoController, CompraRequisicaoDetalheController;
{$R *.dfm}

{$REGION 'Infra'}
procedure TFCompraRequisicao.FormCreate(Sender: TObject);
begin
  ClasseObjetoGridVO := TCompraRequisicaoVO;
  ObjetoController := TCompraRequisicaoController.Create;

  inherited;
end;

procedure TFCompraRequisicao.LimparCampos;
begin
  inherited;
  CDSCompraRequisicaoDetalhe.EmptyDataSet;
end;
{$ENDREGION}

{$REGION 'Controles CRUD'}
function TFCompraRequisicao.DoInserir: Boolean;
begin
  Result := inherited DoInserir;

  if Result then
  begin
    EditDataRequisicao.SetFocus;
  end;
end;

function TFCompraRequisicao.DoEditar: Boolean;
begin
  Result := inherited DoEditar;

  if Result then
  begin
    EditDataRequisicao.SetFocus;
  end;
end;

function TFCompraRequisicao.DoExcluir: Boolean;
begin
  if inherited DoExcluir then
  begin
    try
      Result := TCompraRequisicaoController(ObjetoController).Exclui(IdRegistroSelecionado);
    except
      Result := False;
    end;
  end
  else
  begin
    Result := False;
  end;

  if Result then
    TCompraRequisicaoController(ObjetoController).Consulta(Filtro, Pagina);
end;

function TFCompraRequisicao.DoSalvar: Boolean;
var
  CompraRequisicaoDetalhe: TCompraRequisicaoDetalheVO;
begin

  Result := inherited DoSalvar;

  if Result then
  begin
    try
      if not Assigned(ObjetoVO) then
        ObjetoVO := TCompraRequisicaoVO.Create;

      TCompraRequisicaoVO(ObjetoVO).IdCompraTipoRequisicao := EditIdCompraTipoRequisicao.AsInteger;
      TCompraRequisicaoVO(ObjetoVO).CompraTipoRequisicaoNome := EditCompraTipoRequisicao.Text;
      TCompraRequisicaoVO(ObjetoVO).IdColaborador := EditIdColaborador.AsInteger;
      TCompraRequisicaoVO(ObjetoVO).ColaboradorPessoaNome := EditColaborador.Text;
      TCompraRequisicaoVO(ObjetoVO).DataRequisicao := EditDataRequisicao.Date;

      if StatusTela = stEditando then
        TCompraRequisicaoVO(ObjetoVO).Id := IdRegistroSelecionado;

      // Itens da requisição
      TCompraRequisicaoVO(ObjetoVO).ListaCompraRequisicaoDetalheVO := TObjectList<TCompraRequisicaoDetalheVO>.Create;
      CDSCompraRequisicaoDetalhe.DisableControls;
      CDSCompraRequisicaoDetalhe.First;
      while not CDSCompraRequisicaoDetalhe.Eof do
      begin
        if (CDSCompraRequisicaoDetalhePERSISTE.AsString = 'S') or (CDSCompraRequisicaoDetalheID.AsInteger = 0) then
        begin
          CompraRequisicaoDetalhe := TCompraRequisicaoDetalheVO.Create;
          CompraRequisicaoDetalhe.Id := CDSCompraRequisicaoDetalheID.AsInteger;
          CompraRequisicaoDetalhe.IdCompraRequisicao := TCompraRequisicaoVO(ObjetoVO).Id;
          CompraRequisicaoDetalhe.IdProduto := CDSCompraRequisicaoDetalheID_PRODUTO.AsInteger;
          CompraRequisicaoDetalhe.ProdutoNome := CDSCompraRequisicaoDetalheProdutoNome.AsString;
          CompraRequisicaoDetalhe.Quantidade := CDSCompraRequisicaoDetalheQUANTIDADE.AsExtended;
          CompraRequisicaoDetalhe.QuantidadeCotada := CDSCompraRequisicaoDetalheQUANTIDADE_COTADA.AsExtended;
          CompraRequisicaoDetalhe.ItemCotado := CDSCompraRequisicaoDetalheITEM_COTADO.AsString;
          TCompraRequisicaoVO(ObjetoVO).ListaCompraRequisicaoDetalheVO.Add(CompraRequisicaoDetalhe);
        end;
        CDSCompraRequisicaoDetalhe.Next;
      end;
      CDSCompraRequisicaoDetalhe.First;
      CDSCompraRequisicaoDetalhe.EnableControls;

      // ObjetoVO - libera objetos vinculados (TAssociation) - não tem necessidade de subir
      TCompraRequisicaoVO(ObjetoVO).CompraTipoRequisicaoVO := Nil;
      TCompraRequisicaoVO(ObjetoVO).ColaboradorVO := Nil;

      // ObjetoOldVO - libera objetos vinculados (TAssociation) - não tem necessidade de subir
      if Assigned(ObjetoOldVO) then
      begin
        TCompraRequisicaoVO(ObjetoOldVO).CompraTipoRequisicaoVO := Nil;
        TCompraRequisicaoVO(ObjetoOldVO).ColaboradorVO := Nil;
      end;

      if StatusTela = stInserindo then
        Result := TCompraRequisicaoController(ObjetoController).Insere(TCompraRequisicaoVO(ObjetoVO))
      else if StatusTela = stEditando then
        if TCompraRequisicaoVO(ObjetoVO).ToJSONString <> TCompraRequisicaoVO(ObjetoOldVO).ToJSONString then
        begin
          TCompraRequisicaoVO(ObjetoVO).Id := IdRegistroSelecionado;
          Result := TCompraRequisicaoController(ObjetoController).Altera(TCompraRequisicaoVO(ObjetoVO), TCompraRequisicaoVO(ObjetoOldVO));
        end
        else
          Application.MessageBox('Nenhum dado foi alterado.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
    except
      Result := False;
    end;
  end;
end;
{$ENDREGION}

{$REGION 'Campos Transientes'}
procedure TFCompraRequisicao.EditIdCompraTipoRequisicaoExit(Sender: TObject);
var
  Filtro: String;
begin
  if EditIdCompraTipoRequisicao.Value <> 0 then
  begin
    try
      Filtro := 'ID = ' + EditIdCompraTipoRequisicao.Text;
      EditIdCompraTipoRequisicao.Clear;
      EditCompraTipoRequisicao.Clear;
      if not PopulaCamposTransientes(Filtro, TCompraTipoRequisicaoVO, TCompraTipoRequisicaoController) then
        PopulaCamposTransientesLookup(TCompraTipoRequisicaoVO, TCompraTipoRequisicaoController);
      if CDSTransiente.RecordCount > 0 then
      begin
        EditIdCompraTipoRequisicao.Text := CDSTransiente.FieldByName('ID').AsString;
        EditCompraTipoRequisicao.Text := CDSTransiente.FieldByName('NOME').AsString;
      end
      else
      begin
        Exit;
        EditIdCompraTipoRequisicao.SetFocus;
      end;
    finally
      CDSTransiente.Close;
    end;
  end
  else
  begin
    EditCompraTipoRequisicao.Clear;
  end;
end;

procedure TFCompraRequisicao.EditIdCompraTipoRequisicaoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditIdCompraTipoRequisicao.Value := -1;
    EditIdColaborador.SetFocus;
  end;
end;

procedure TFCompraRequisicao.EditIdCompraTipoRequisicaoKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    EditIdColaborador.SetFocus;
  end;
end;

procedure TFCompraRequisicao.EditIdColaboradorExit(Sender: TObject);
var
  Filtro: String;
begin
  if EditIdColaborador.Value <> 0 then
  begin
    try
      Filtro := 'ID = ' + EditIdColaborador.Text;
      EditIdColaborador.Clear;
      EditColaborador.Clear;
      if not PopulaCamposTransientes(Filtro, TColaboradorVO, TColaboradorController) then
        PopulaCamposTransientesLookup(TColaboradorVO, TColaboradorController);
      if CDSTransiente.RecordCount > 0 then
      begin
        EditIdColaborador.Text := CDSTransiente.FieldByName('ID').AsString;
        EditColaborador.Text := CDSTransiente.FieldByName('PESSOA.NOME').AsString;
      end
      else
      begin
        Exit;
        EditIdColaborador.SetFocus;
      end;
    finally
      CDSTransiente.Close;
    end;
  end
  else
  begin
    EditColaborador.Clear;
  end;
end;

procedure TFCompraRequisicao.EditIdColaboradorKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditIdColaborador.Value := -1;
    GridCompraRequisicaoDetalhe.SetFocus;
    GridCompraRequisicaoDetalhe.SelectedIndex := 1;
  end;
end;

procedure TFCompraRequisicao.EditIdColaboradorKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    GridCompraRequisicaoDetalhe.SetFocus;
    GridCompraRequisicaoDetalhe.SelectedIndex := 1;
  end;
end;
{$ENDREGION}

{$REGION 'Controle de Grid'}
procedure TFCompraRequisicao.GridCompraRequisicaoDetalheKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  Filtro: String;
begin
  if Key = VK_F1 then
  begin
    try
      PopulaCamposTransientesLookup(TProdutoVO, TProdutoController);
      if CDSTransiente.RecordCount > 0 then
      begin
        CDSCompraRequisicaoDetalhe.Append;
        CDSCompraRequisicaoDetalheID_PRODUTO.AsInteger := CDSTransiente.FieldByName('ID').AsInteger;
        CDSCompraRequisicaoDetalheProdutoNome.AsString := CDSTransiente.FieldByName('NOME').AsString;
      end;
    finally
      CDSTransiente.Close;
    end;
  end;
  If Key = VK_RETURN then
    EditDataRequisicao.SetFocus;
end;

procedure TFCompraRequisicao.GridCompraRequisicaoDetalheUserSort(Sender: TJvDBUltimGrid; var FieldsToSort: TSortFields; SortString: string; var SortOK: Boolean);
var
  IxDName: string;
  i: integer;
  Fields, DescFields: string;
begin
  try
    Fields := '';
    DescFields := '';
    for i := 0 to Length(FieldsToSort) - 1 do
    begin
      Fields := Fields + FieldsToSort[i].Name + ';';
      if not FieldsToSort[i].Order then
        DescFields := DescFields + FieldsToSort[i].Name + ';';
    end;
    Fields := Copy(Fields, 1, Length(Fields) - 1);
    DescFields := Copy(DescFields, 1, Length(DescFields) - 1);

    IxDName := IntToStr(Length(FieldsToSort)) + '_' + FormatDateTime('hhmmssz', Now);
    CDSCompraRequisicaoDetalhe.AddIndex(IxDName, Fields, [], DescFields);
    CDSCompraRequisicaoDetalhe.IndexDefs.Update;
    CDSCompraRequisicaoDetalhe.IndexName := IxDName;
    SortOK := True;
  except
    SortOK := False;
  end;
end;

procedure TFCompraRequisicao.GridParaEdits;
var
  CompraRequisicaoDetalheEnumerator: TEnumerator<TCompraRequisicaoDetalheVO>;
begin
  inherited;

  if not CDSGrid.IsEmpty then
  begin
    ObjetoVO := ObjetoController.VO<TCompraRequisicaoVO>(IdRegistroSelecionado);
    if StatusTela = stEditando then
      ObjetoOldVO := ObjetoController.VO<TCompraRequisicaoVO>(IdRegistroSelecionado);
  end;

  if Assigned(ObjetoVO) then
  begin
    EditIdCompraTipoRequisicao.AsInteger := TCompraRequisicaoVO(ObjetoVO).IdCompraTipoRequisicao;
    EditCompraTipoRequisicao.Text := TCompraRequisicaoVO(ObjetoVO).CompraTipoRequisicaoVO.Nome;
    EditIdColaborador.AsInteger := TCompraRequisicaoVO(ObjetoVO).IdColaborador;
    EditColaborador.Text := TCompraRequisicaoVO(ObjetoVO).ColaboradorVO.PessoaVO.Nome;
    EditDataRequisicao.Date := TCompraRequisicaoVO(ObjetoVO).DataRequisicao;

    // Itens da Requisição
    CompraRequisicaoDetalheEnumerator := TCompraRequisicaoVO(ObjetoVO).ListaCompraRequisicaoDetalheVO.GetEnumerator;
    try
      with CompraRequisicaoDetalheEnumerator do
      begin
        while MoveNext do
        begin
          CDSCompraRequisicaoDetalhe.Append;

          CDSCompraRequisicaoDetalheID.AsInteger := Current.Id;
          CDSCompraRequisicaoDetalheID_PRODUTO.AsInteger := Current.IdProduto;
          CDSCompraRequisicaoDetalheProdutoNome.AsString := Current.ProdutoVO.Nome;
          CDSCompraRequisicaoDetalheQUANTIDADE.AsExtended := Current.Quantidade;
          CDSCompraRequisicaoDetalheQUANTIDADE_COTADA.AsExtended := Current.QuantidadeCotada;
          CDSCompraRequisicaoDetalheITEM_COTADO.AsString := Current.ItemCotado;
          CDSCompraRequisicaoDetalheID_COMPRA_REQUISICAO.AsInteger := Current.IdCompraRequisicao;
          CDSCompraRequisicaoDetalhePERSISTE.AsString := 'N';

          CDSCompraRequisicaoDetalhe.Post;
        end;
      end;
    finally
      CompraRequisicaoDetalheEnumerator.Free;
    end;
    TCompraRequisicaoVO(ObjetoVO).ListaCompraRequisicaoDetalheVO := Nil;
    if Assigned(TCompraRequisicaoVO(ObjetoOldVO)) then
      TCompraRequisicaoVO(ObjetoOldVO).ListaCompraRequisicaoDetalheVO := Nil;
  end;

end;

procedure TFCompraRequisicao.CDSCompraRequisicaoDetalheAfterEdit(DataSet: TDataSet);
begin
  if CDSCompraRequisicaoDetalheITEM_COTADO.AsString = 'S' then
  begin
    Application.MessageBox('Não é possível alterar esse item. Item já foi cotado.', 'Informação do sistema', MB_OK + MB_ICONINFORMATION);
    CDSCompraRequisicaoDetalhe.Cancel;
  end
  else
    CDSCompraRequisicaoDetalhePERSISTE.AsString := 'S';
end;

procedure TFCompraRequisicao.Excluir1Click(Sender: TObject);
begin
  if CDSCompraRequisicaoDetalhe.IsEmpty then
    Application.MessageBox('Não existe registro selecionado.', 'Erro', MB_OK + MB_ICONERROR)
  else
  begin
    if Application.MessageBox('Deseja realmente excluir o registro selecionado?', 'Pergunta do sistema', MB_YESNO + MB_ICONQUESTION) = IDYES then
    begin
      if StatusTela = stInserindo then
        CDSCompraRequisicaoDetalhe.Delete
      else if StatusTela = stEditando then
      begin
        if TCompraRequisicaoDetalheController.Exclui(CDSCompraRequisicaoDetalheID.AsInteger) then
          CDSCompraRequisicaoDetalhe.Delete;
      end;
    end;
  end;
end;
{$ENDREGION}

end.
