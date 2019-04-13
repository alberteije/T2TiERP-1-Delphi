{ *******************************************************************************
  Title: T2Ti ERP
  Description: Janela Cadastro de Papel do Usuário - Controle de Acessos

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

  t2ti.com@gmail.com | fabio_thz@yahoo.com.br
  @author Albert Eije (T2Ti.COM) | Fábio Thomaz
  @version 1.0
  ******************************************************************************* }

unit UPapel;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UTelaCadastro, Menus, StdCtrls, ExtCtrls, Buttons, Grids, DBGrids,
  JvExDBGrids, JvDBGrid, JvDBUltimGrid, ComCtrls, PapelController, PapelVO,
  NotificationService, Constantes, Rtti, Atributos, UDataModule,
  Generics.Collections, PapelFuncaoVO, PapelFuncaoController, TypInfo, FuncaoVO,
  FuncaoController, LabeledCtrls, AdministrativoFormularioVO;

type
  [TFormDescription(TConstantes.MODULO_SEGURANCA, 'Papel - Controle de Acessos')]

  TFPapel = class(TFTelaCadastro)
    EditNome: TLabeledEdit;
    MemoDescricao: TMemo;
    BevelEdits: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    TreeView: TTreeView;
    ComboBoxAcessoCompleto: TLabeledComboBox;
    procedure FormCreate(Sender: TObject);
    procedure TreeViewDblClick(Sender: TObject);
  private
    { Private declarations }
    ListaItensTreeView: TObjectDictionary<TTreeNode, TPapelFuncaoVO>;

    procedure ExtraiFormularioDoRES;
    procedure AtualizaFuncoesSistema;
    procedure MontaTreeViewFuncao(pIdPapel: Integer);
  public
    { Public declarations }
    procedure GridParaEdits; override;

    // Controles CRUD
    function DoInserir: Boolean; override;
    function DoEditar: Boolean; override;
    function DoExcluir: Boolean; override;
    function DoSalvar: Boolean; override;
    function DoCancelar: Boolean; override;
  end;

var
  FPapel: TFPapel;
  ListaFormulario: TObjectList<TAdministrativoFormularioVO>;

implementation

uses
  StrUtils;

const
  IDX_MARCADO = 1;
  IDX_DESMARCADO = 2;
{$R *.dfm}

{$REGION 'Infra'}
procedure TFPapel.ExtraiFormularioDoRES;
var
  Res: TResourceStream;
  StringListFormulario: TStringList;
  i, PosIni, PosFim: Integer;
  FormularioVO: TAdministrativoFormularioVO;
  FuncaoVO: TFuncaoVO;
  ElementoLista: String;
begin
  Res := TResourceStream.Create(HInstance, 'T2TiERP_Forms', 'TXTFILE');
  try
    ListaFormulario := TObjectList<TAdministrativoFormularioVO>.Create;
    StringListFormulario := TStringList.Create;
    StringListFormulario.LoadFromStream(Res);

    for i := 0 to StringListFormulario.Count - 1 do
    begin
      FormularioVO := TAdministrativoFormularioVO.Create;

      ElementoLista := StringListFormulario[i];

      PosIni := Pos('.', ElementoLista);
      PosFim := Pos(',', ElementoLista);
      FormularioVO.Modulo := Trim(Copy(ElementoLista, PosIni + 1, PosFim - PosIni - 1));
      System.Delete(ElementoLista, 1, PosFim);

      PosIni := Pos(chr(39), ElementoLista);
      PosFim := Pos(')', ElementoLista);
      FormularioVO.Descricao := Trim(Copy(ElementoLista, PosIni + 1, PosFim - PosIni - 2));
      System.Delete(ElementoLista, 1, PosFim);

      PosIni := Pos('[', ElementoLista);
      PosFim := Pos('=', ElementoLista);
      FormularioVO.NomeFormulario := Trim(Copy(ElementoLista, PosIni + 1, PosFim - PosIni - 1));


      FormularioVO.ListaFuncaoVO := TObjectList<TFuncaoVO>.Create;

      //insere a função de acesso ao formulário
      FuncaoVO := TFuncaoVO.Create;
      FuncaoVO.Nome := 'Action' + Copy(FormularioVO.NomeFormulario, 3, Length(FormularioVO.NomeFormulario));
      FuncaoVO.Descricao := 'Acessar Janela';
      FuncaoVO.Formulario := 'TFMenu';
      FormularioVO.ListaFuncaoVO.Add(FuncaoVO);

      //insere as três funções base: inserir, alterar, excluir
      FuncaoVO := TFuncaoVO.Create;
      FuncaoVO.Nome := 'BotaoInserir';
      FuncaoVO.Descricao := 'Pode Inserir?';
      FuncaoVO.Formulario := FormularioVO.NomeFormulario;
      FormularioVO.ListaFuncaoVO.Add(FuncaoVO);

      FuncaoVO := TFuncaoVO.Create;
      FuncaoVO.Nome := 'BotaoAlterar';
      FuncaoVO.Descricao := 'Pode Alterar?';
      FuncaoVO.Formulario := FormularioVO.NomeFormulario;
      FormularioVO.ListaFuncaoVO.Add(FuncaoVO);

      FuncaoVO := TFuncaoVO.Create;
      FuncaoVO.Nome := 'BotaoExcluir';
      FuncaoVO.Descricao := 'Pode Excluir?';
      FuncaoVO.Formulario := FormularioVO.NomeFormulario;
      FormularioVO.ListaFuncaoVO.Add(FuncaoVO);

      ListaFormulario.Add(FormularioVO);
    end;
  finally
    Res.Free;
    StringListFormulario.Free;
  end;
end;

procedure TFPapel.FormCreate(Sender: TObject);
begin
  ClasseObjetoGridVO := TPapelVO;
  ObjetoController := TPapelController.Create;
  inherited;
  ExtraiFormularioDoRES;
  AtualizaFuncoesSistema;
end;

procedure TFPapel.AtualizaFuncoesSistema;
begin
  if ListaFormulario.Count > 0 then
  begin
    TFuncaoController.VerificaAtualizaFuncoes(ListaFormulario);
  end;
end;

procedure TFPapel.MontaTreeViewFuncao(pIdPapel: Integer);
var
  i, j: Integer;

  ListaFormularios: TDictionary<String, TTreeNode>;

  NodeRaiz: TTreeNode;
  NodeForm: TTreeNode;

  ListaPapelFuncao: TList<TPapelFuncaoVO>;
  PapelFuncao: TPapelFuncaoVO;

  function NodeModulo(pNome: String): TTreeNode;
  var
    X: Integer;
  begin
    Result := nil;

    for X := 0 to TreeView.Items.Count - 1 do
    begin
      if TreeView.Items[X].Level = 0 then
      begin
        if TreeView.Items[X].Text = pNome then
        begin
          Result := TreeView.Items[X];
          Break;
        end;
      end;
    end;

    if not Assigned(Result) then
    begin
      Result := TreeView.Items.Add(nil, pNome);
      Result.ImageIndex := 25;
      Result.SelectedIndex := 25;
    end;
  end;

  function NodeFormulario(pFormClassName: String): TTreeNode;
  begin
    if ListaFormularios.ContainsKey(pFormClassName) then
      Result := ListaFormularios.Items[pFormClassName]
    else
      Result := nil;
  end;

  function GetPapelFuncao(pFuncao, pFormulario: String): TPapelFuncaoVO;
  var
    PFEnumerator: TEnumerator<TPapelFuncaoVO>;
  begin
    Result := nil;

    PFEnumerator := ListaPapelFuncao.GetEnumerator;
    try
      with PFEnumerator do
      begin
        while MoveNext do
        begin
          if (Current.Funcao = pFuncao) and (Current.Formulario = pFormulario) then
          begin
            Result := Current;
            Break;
          end;
        end;
      end;
    finally
      PFEnumerator.Free;
    end;
  end;

  function AddItemTreeView(pNode: TTreeNode; pFuncao: TFuncaoVO): TTreeNode;
  begin
    Result := TreeView.Items.AddChild(pNode, pFuncao.Descricao);
    Result.ImageIndex := IDX_DESMARCADO;
    Result.SelectedIndex := IDX_DESMARCADO;

    PapelFuncao := GetPapelFuncao(pFuncao.Nome, pFuncao.Formulario);
    if Assigned(PapelFuncao) then
    begin
      if PapelFuncao.Habilitado = 'S' then
      begin
        Result.ImageIndex := IDX_MARCADO;
        Result.SelectedIndex := IDX_MARCADO;
      end;

      ListaItensTreeView.Add(Result, PapelFuncao);
    end;
  end;
begin
  TreeView.Items.Clear;
  ListaItensTreeView := TObjectDictionary<TTreeNode, TPapelFuncaoVO>.Create;
  ListaPapelFuncao := TPapelFuncaoController.ListaPapelFuncao('ID_PAPEL = ' + IntToStr(pIdPapel));
  try
    ListaFormularios := TDictionary<String, TTreeNode>.Create;

    // Armazena Formulários na Lista
    try
      for i := 0 to ListaFormulario.Count - 1 do
      begin
        // Módulo
        NodeRaiz := NodeModulo(ListaFormulario[i].Modulo);

        // Formulário
        NodeForm := TreeView.Items.AddChild(NodeRaiz, ListaFormulario[i].Descricao);
        NodeForm.ImageIndex := 33;
        NodeForm.SelectedIndex := 33;

        ListaFormularios.Add(ListaFormulario[i].Modulo + ListaFormulario[i].NomeFormulario, NodeForm);
      end;
    except
      on E: Exception do
        Application.MessageBox(PChar('Ocorreu um erro na criação da árvore no item: ' + ListaFormulario[i].NomeFormulario + #13 + #13 + 'Mensagem de erro: ' + E.Message), 'Erro do sistema', MB_OK + MB_ICONERROR);
    end;

    // Percorre formulários do sistema e adiciona os itens ao TreeView
    try
      for i := 0 to ListaFormulario.Count - 1 do
      begin
        NodeForm := NodeFormulario(ListaFormulario[i].Modulo + ListaFormulario[i].NomeFormulario);
        for j := 0 to ListaFormulario[i].ListaFuncaoVO.Count - 1 do
        begin
          AddItemTreeView(NodeForm, ListaFormulario[i].ListaFuncaoVO[j]);
        end;
      end;
    except
      on E: Exception do
        Application.MessageBox(PChar('Ocorreu um erro na inclusão dos ítens na árvore.' + #13 + #13 + E.Message), 'Erro do sistema', MB_OK + MB_ICONERROR);
    end;

  finally
    ListaFormularios.Free;
    ListaPapelFuncao.Free;
  end;

  TreeView.CustomSort(nil, 0, True);
end;

procedure TFPapel.TreeViewDblClick(Sender: TObject);
var
  loNode: TTreeNode;
begin
  loNode := TreeView.Selected;
  if loNode <> nil then
  begin
    if loNode.Level = 2 then
    begin
      ListaItensTreeView.Items[loNode].NodeAlterado := True;
      if loNode.ImageIndex = IDX_MARCADO then
      begin
        loNode.ImageIndex := IDX_DESMARCADO;
        loNode.SelectedIndex := IDX_DESMARCADO;
      end
      else
      begin
        loNode.ImageIndex := IDX_MARCADO;
        loNode.SelectedIndex := IDX_MARCADO;
      end;
    end;
  end;
end;
{$ENDREGION}

{$REGION 'Controles CRUD'}
function TFPapel.DoCancelar: Boolean;
var
  i: Integer;
  Node: TTreeNode;
begin
  inherited DoCancelar;

  if Assigned(ListaItensTreeView) then
  begin
    for i := 0 to TreeView.Items.Count - 1 do
    begin
      Node := TreeView.Items.Item[i];
      ListaItensTreeView.Remove(Node)
    end;
    ListaItensTreeView.Free;
  end;
end;

function TFPapel.DoEditar: Boolean;
begin
  Result := inherited DoEditar;

  if Result then
  begin
    EditNome.SetFocus;
  end;
end;

function TFPapel.DoExcluir: Boolean;
begin
  if inherited DoExcluir then
  begin
    try
      TPapelController(ObjetoController).Exclui(IdRegistroSelecionado);
      Result := True;
      TPapelController(ObjetoController).Consulta(Filtro, Pagina);
    except
      Result := False;
    end;
  end
  else
  begin
    Result := False;
  end;
end;

function TFPapel.DoInserir: Boolean;
begin
  Result := inherited DoInserir;

  if Result then
  begin
    EditNome.SetFocus;
  end;
end;

function TFPapel.DoSalvar: Boolean;
var
  i: Integer;
  ListaPapelFuncao: TList<TPapelFuncaoVO>;
  PapelFuncao: TPapelFuncaoVO;
  Node: TTreeNode;
  Enumerator: TEnumerator < TPair < TTreeNode, TPapelFuncaoVO >> ;
begin
  Result := inherited DoSalvar;

  if Result then
  begin
    try
      if not Assigned(ObjetoVO) then
        ObjetoVO := TPapelVO.Create;

      TPapelVO(ObjetoVO).Nome := EditNome.Text;
      TPapelVO(ObjetoVO).Descricao := MemoDescricao.Text;
      TPapelVO(ObjetoVO).AcessoCompleto := IfThen(ComboBoxAcessoCompleto.ItemIndex = 0, 'S', 'N');

      if StatusTela = stInserindo then
        TPapelController(ObjetoController).Insere(TPapelVO(ObjetoVO))
      else if StatusTela = stEditando then
      begin
        TPapelVO(ObjetoVO).ID := IdRegistroSelecionado;
        TPapelController(ObjetoController).Altera(TPapelVO(ObjetoVO), Filtro, Pagina);
      end;

      //só atualiza as funções caso o usuário não tenha acesso completo
      if ComboBoxAcessoCompleto.ItemIndex <> 0 then
      begin
        ListaPapelFuncao := TList<TPapelFuncaoVO>.Create;
        try
          for i := 0 to TreeView.Items.Count - 1 do
          begin
            Node := TreeView.Items.Item[i];
            if Node.Level = 2 then
            begin
              Enumerator := ListaItensTreeView.GetEnumerator;
              try
                with Enumerator do
                begin
                  while MoveNext do
                  begin
                    if (Current.Key = Node) then
                    begin
                      PapelFuncao := Current.Value;
                      if PapelFuncao.NodeAlterado then
                      begin
                        if Assigned(PapelFuncao) then
                        begin
                          if Node.ImageIndex = IDX_MARCADO then
                            PapelFuncao.Habilitado := 'S'
                          else
                            PapelFuncao.Habilitado := 'N';

                          ListaPapelFuncao.Add(PapelFuncao);
                        end;
                      end;
                    end;
                  end;
                end;
              finally
                Enumerator.Free;
              end;
            end;
          end;

          if ListaPapelFuncao.Count > 0 then
          begin
            TPapelFuncaoController.VerificaAtualizaPapelFuncao(ListaPapelFuncao);
          end;
        finally
          ListaPapelFuncao.Free;

          for i := 0 to TreeView.Items.Count - 1 do
          begin
            Node := TreeView.Items.Item[i];
            ListaItensTreeView.Remove(Node)
          end;
          ListaItensTreeView.Free;

          TreeView.Items.Clear;
        end;
      end;

      Result := True;
      GetNotificationService.SendMessage(Self, TConstantes.IF_Papel);
    except
      Result := False;
    end;
  end;
end;
{$ENDREGION}

{$REGION 'Controle de Grid'}
procedure TFPapel.GridParaEdits;
begin
  inherited;

  if not CDSGrid.IsEmpty then
  begin
    ObjetoVO := ObjetoController.VO<TPapelVO>(IdRegistroSelecionado);
  end;

  if Assigned(ObjetoVO) then
  begin
    EditNome.Text := TPapelVO(ObjetoVO).Nome;
    MemoDescricao.Text := TPapelVO(ObjetoVO).Descricao;

    ComboBoxAcessoCompleto.ItemIndex := StrToInt(IfThen(TPapelVO(ObjetoVO).AcessoCompleto = 'S', '0', '1'));

    MontaTreeViewFuncao(TPapelVO(ObjetoVO).ID);
  end;
end;
{$ENDREGION}



end.
