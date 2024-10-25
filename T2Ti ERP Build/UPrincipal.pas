unit UPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Mask, JvExMask, JvToolEdit, ToolWin, ActnMan,
  ActnCtrls, PlatformDefaultStyleActnCtrls, ActnList, ImgList, ComCtrls, Rtti,
  Ribbon, JvExControls, JvImageSquare, Buttons, Generics.Collections;

type
  TFPrincipal = class(TForm)
    PanelCima: TPanel;
    PanelBaixo: TPanel;
    Label6: TLabel;
    EditCaminhoProjeto: TJvDirectoryEdit;
    ActionManager1: TActionManager;
    ActionToolBar1: TActionToolBar;
    ActionSair: TAction;
    ImagensCadastrosD: TImageList;
    ImagensCadastros: TImageList;
    GroupBoxGrupos: TGroupBox;
    ActionAddGrupo: TAction;
    PageControl1: TPageControl;
    TabSheetAba: TTabSheet;
    TabSheetGrupo: TTabSheet;
    EditAbaCaption: TLabeledEdit;
    EditGrupoNome: TLabeledEdit;
    EditGrupoCaption: TLabeledEdit;
    ActionToolBar2: TActionToolBar;
    ActionAddAba: TAction;
    ActionToolBar3: TActionToolBar;
    ActionAlteraCaptionAba: TAction;
    TabSheetAction: TTabSheet;
    ActionToolBar4: TActionToolBar;
    ActionAddAction: TAction;
    ImagemSelecionada: TJvImageSquare;
    BotaoImagemProxima: TButton;
    BotaoImagemAnterior: TButton;
    EditActionCaption: TLabeledEdit;
    ActionBotaoGrande: TAction;
    ActionBotaoPequeno: TAction;
    ListBoxGrupo: TListBox;
    GroupBoxActions: TGroupBox;
    TreeViewActions: TTreeView;
    OpenDialog1: TOpenDialog;
    ActionVincularJanela: TAction;
    EditJanelaVinculada: TEdit;
    ActionBuild: TAction;
    EditNomeProjeto: TLabeledEdit;
    EditActionNome: TLabeledEdit;
    function EncontrarNode(const pNome: string): TTreeNode;
    procedure ConstruirArvore;
    procedure CarregarMenu;
    procedure CarregarActionManagerPadrao;
    procedure ProcessarUsesVinculadas(pArquivo: String);
    procedure CriarArquivoDpr;
    procedure CriarArquivoMenu;
    procedure FormCreate(Sender: TObject);
    procedure ActionSairExecute(Sender: TObject);
    procedure ActionAddGrupoExecute(Sender: TObject);
    procedure ActionAlteraCaptionAbaExecute(Sender: TObject);
    procedure ActionAddAbaExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ActionAddActionExecute(Sender: TObject);
    procedure BotaoImagemAnteriorClick(Sender: TObject);
    procedure BotaoImagemProximaClick(Sender: TObject);
    procedure ActionBotaoGrandeExecute(Sender: TObject);
    procedure ActionBotaoPequenoExecute(Sender: TObject);
    procedure ActionVincularJanelaExecute(Sender: TObject);
    procedure TreeViewActionsChange(Sender: TObject; Node: TTreeNode);
    procedure ActionBuildExecute(Sender: TObject);
    procedure Split(const Delimiter: Char; Input: string; const Strings: TStrings);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FPrincipal: TFPrincipal;
  PaginasAdicionadas, GruposAdicionados: Integer;
  ListaVinculos: TObjectDictionary<String, String>;
  ListaControllersVinculados: TStringList;
  ListaVOsVinculados: TStringList;

implementation

uses UMenu;

{$R *.dfm}


{$Region 'Infra'}
function TFPrincipal.EncontrarNode(const pNome: string): TTreeNode;
var
  i: Integer;
begin
  Result := nil;
  with TreeViewActions.Items do
  begin
    for i := 0 to Pred(Count) do
      if Item[i].Text = pNome then
      begin
        Result := Item[i];
        Break;
      end;
  end;
end;

procedure TFPrincipal.ConstruirArvore;
var
  i: Integer;
  Node: TTreeNode;
  Acao: TAction;
begin
  TreeViewActions.Items.Clear;
  for i := 0 to Pred(FMenu.ActionManager.ActionCount) do
  begin
    Acao := TAction(FMenu.ActionManager.Actions[i]);
    with TreeViewActions.Items do
    begin
      Node := EncontrarNode(Acao.Category);
      if Node = nil then
        Node := Add(GetFirstNode, Acao.Category);
      AddChild(Node, Acao.Caption);
    end;
  end;
end;

procedure TFPrincipal.FormCreate(Sender: TObject);
begin
  ListaVinculos := TObjectDictionary<String, String>.Create;
  ListaControllersVinculados := TStringList.Create;
  ListaVOsVinculados := TStringList.Create;
  GruposAdicionados := 0;
  PaginasAdicionadas := 0;
  Self.WindowState := wsMaximized;
end;

procedure TFPrincipal.FormShow(Sender: TObject);
begin
  CarregarActionManagerPadrao;
  CarregarMenu;
end;

procedure TFPrincipal.CarregarActionManagerPadrao;
var
  memStr, memStr2: TMemoryStream;
begin
  memStr := TMemoryStream.Create;
  try
    memStr2 := TMemoryStream.Create;
    try
      memStr.LoadFromFile('ActionManager.padrao');
      memStr.Position := 0;
      ObjectTextToBinary(memStr, memStr2);
      memStr2.Position := 0;
      FMenu.ActionManager.LoadFromStream(memStr2);
    finally
      memStr2.Free;
    end;
  finally
    memStr.Free;
  end;
  self.Repaint;
end;

procedure TFPrincipal.CarregarMenu;
begin
  with FMenu do
  begin
    Parent := PanelBaixo;
    Align := alClient;
    BorderStyle := bsNone;
  end;
  FMenu.Show;
end;
{$EndRegion}

{$Region 'Actions'}

{$Region 'Actions - Aba'}
procedure TFPrincipal.ActionAddAbaExecute(Sender: TObject);
begin
  FMenu.AdicionarAba(EditAbaCaption.Text, PaginasAdicionadas);
  Inc(PaginasAdicionadas);
end;

procedure TFPrincipal.ActionAlteraCaptionAbaExecute(Sender: TObject);
begin
  (FMenu.Ribbon.ActivePage as TRibbonPage).Caption := EditAbaCaption.Text;
end;
{$EndRegion}

{$Region 'Actions - Grupo'}
procedure TFPrincipal.ActionAddGrupoExecute(Sender: TObject);
begin
  FMenu.AdicionarGrupo(EditGrupoCaption.Text, EditGrupoNome.Text, GruposAdicionados);
  Inc(GruposAdicionados);
  ListBoxGrupo.Items.Add(EditGrupoNome.Text);
end;
{$EndRegion}

{$Region 'Actions - Action'}
procedure TFPrincipal.ActionAddActionExecute(Sender: TObject);
var
  Acao: TAction;
begin
  Acao := TAction.Create(Self);
  Acao.Name := 'Action' + EditActionNome.Text;
  Acao.Caption := EditActionCaption.Text;
  Acao.Category := ListBoxGrupo.Items[ListBoxGrupo.ItemIndex];
  Acao.ImageIndex := ImagemSelecionada.ImageIndex;
  Acao.OnExecute := FMenu.ActionSairExecute;
  Acao.ActionList := FMenu.ActionManager;

  with FMenu.ActionManager.ActionBars[ListBoxGrupo.ItemIndex].Items.Add do
  begin
    Action := acao;
  end;

  ConstruirArvore;
end;

procedure TFPrincipal.BotaoImagemAnteriorClick(Sender: TObject);
begin
  ImagemSelecionada.ImageIndex := ImagemSelecionada.ImageIndex - 1;
end;

procedure TFPrincipal.BotaoImagemProximaClick(Sender: TObject);
begin
  ImagemSelecionada.ImageIndex := ImagemSelecionada.ImageIndex + 1;
end;

procedure TFPrincipal.ActionBotaoGrandeExecute(Sender: TObject);
var
  ActionBar: TCollectionItem;
  ActionItem: TCollectionItem;
begin
  for ActionBar in FMenu.ActionManager.ActionBars do
  begin
    for ActionItem in TActionBarItem(ActionBar).Items do
    begin
      if StringReplace(TActionClientItem(ActionItem).Caption,'&','',[rfReplaceAll])  = TreeViewActions.Selected.Text then
      begin
        TButtonProperties(TActionClientItem(ActionItem).CommandProperties).ButtonSize := bsLarge;
        Break;
      end;
    end;
  end;
end;

procedure TFPrincipal.ActionBotaoPequenoExecute(Sender: TObject);
var
  ActionBar: TCollectionItem;
  ActionItem: TCollectionItem;
begin
  for ActionBar in FMenu.ActionManager.ActionBars do
  begin
    for ActionItem in TActionBarItem(ActionBar).Items do
    begin
      if StringReplace(TActionClientItem(ActionItem).Caption,'&','',[rfReplaceAll])  = TreeViewActions.Selected.Text then
      begin
        TButtonProperties(TActionClientItem(ActionItem).CommandProperties).ButtonSize := bsSmall;
        Break;
      end;
    end;
  end;
end;

procedure TFPrincipal.ActionVincularJanelaExecute(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    ListaVinculos.Add(TreeViewActions.Selected.Text, Opendialog1.FileName);
  end;
end;

procedure TFPrincipal.TreeViewActionsChange(Sender: TObject; Node: TTreeNode);
var
  Enumerator: TEnumerator < TPair < String, String >> ;
begin
  if TreeViewActions.Items.Count > 0 then
  begin
    Enumerator := ListaVinculos.GetEnumerator;
    try
      with Enumerator do
      begin
        while MoveNext do
        begin
          if (Current.Key = TreeViewActions.Selected.Text) then
          begin
            EditJanelaVinculada.Text := Current.Value;
          end;
        end;
      end;
    finally
      Enumerator.Free;
    end;
  end;
end;
{$EndRegion}

{$Region 'Actions - Outras'}
procedure TFPrincipal.ActionSairExecute(Sender: TObject);
begin
  Close;
end;

procedure TFPrincipal.ActionBuildExecute(Sender: TObject);
var
  Enumerator: TEnumerator < TPair < String, String >> ;
  Origem, Destino: String;
begin
  if EditCaminhoProjeto.Text = '' then
  begin
    Application.MessageBox('Informe o caminho do projeto.', 'Informa��o do Sistema', MB_OK + MB_IconInformation);
    EditCaminhoProjeto.SetFocus;
  end
  else
  begin
    // Cria pastas
    if not DirectoryExists(EditCaminhoProjeto.Text)then
      CreateDir(EditCaminhoProjeto.Text);
    if not DirectoryExists(EditCaminhoProjeto.Text + '\Controller')then
      CreateDir(EditCaminhoProjeto.Text + '\Controller');
    if not DirectoryExists(EditCaminhoProjeto.Text + '\Tela')then
      CreateDir(EditCaminhoProjeto.Text + '\Tela');

    // Copiar Janelas
    Enumerator := ListaVinculos.GetEnumerator;
    try
      with Enumerator do
      begin
        while MoveNext do
        begin
          Origem := Current.Value;
          Destino := EditCaminhoProjeto.Text + '\Tela\' + ExtractFileName(Origem);
          CopyFile(PChar(Origem), PChar(Destino), False);
          //
          ProcessarUsesVinculadas(Origem);
          //
          Delete(Origem, Length(Origem) - 3, 4);
          Origem := Origem + '.dfm';
          Destino := EditCaminhoProjeto.Text + '\Tela\' + ExtractFileName(Origem);
          CopyFile(PChar(Origem), PChar(Destino), False);
        end;
      end;
    finally
      Enumerator.Free;
    end;

    // Criar o DPR
    CriarArquivoDpr;

    // Criar o Menu
    CriarArquivoMenu;

    Application.MessageBox('Projeto Gerado com Sucesso!', 'Informa��o do Sistema', MB_OK + MB_IconInformation);
  end;
end;

procedure TFPrincipal.ProcessarUsesVinculadas(pArquivo: String);
var
  Arquivo, Units: TStringList;
  Linha: String;
  i, j: Integer;
  Origem, Destino: String;
begin
  try
    Arquivo := TStringList.Create;
    Units := TStringList.Create;
    //
    Arquivo.LoadFromFile(pArquivo);

    for i := 0 to Arquivo.Count - 1 do
    begin
      if Pos('uses', Arquivo[i]) > 0 then
      begin
        j := i;
        repeat
          Linha := Linha + Arquivo[j];
          inc(j);
        until (Pos(';', Arquivo[j-1]) > 0);
      end;
    end;

    Split(',', Linha, Units);

    for i := 0 to Units.Count - 1 do
    begin
      Linha := StringReplace(Units[i], ';', '', [rfReplaceAll]);
      Linha := Trim(Linha);
      if Pos('Controller', Linha) > 0 then
      begin
        if ListaControllersVinculados.IndexOf(Linha) = -1 then
        begin
          // Adiciona o Controller na lista
          ListaControllersVinculados.Add(Linha);

          // Copia o arquivo para a pasta de controllers
          Origem := ExtractFilePath(pArquivo);
          Delete(Origem, Length(Origem) - 5, 6);
          Origem := Origem + '\Controller\' + Linha + '.pas';
          Destino := EditCaminhoProjeto.Text + '\Controller\' + Linha + '.pas';
          CopyFile(PChar(Origem), PChar(Destino), False);
        end;
      end
      else if Pos('VO', Linha) > 0 then
      begin
        if ListaVOsVinculados.IndexOf(Linha) = -1 then
        begin
          // Adiciona o VO na lista
          ListaVOsVinculados.Add(Linha);
        end;
      end;
    end;

  finally
    Arquivo.Free;
    Units.Free;
  end;
end;

procedure TFPrincipal.CriarArquivoDpr;
var
  ArquivoDpr, UnitsDpr: TStringList;
  Origem, Destino, NomeUnit, NomeForm: String;
  i: Integer;
  //
  Enumerator: TEnumerator < TPair < String, String >> ;
begin
  try
    UnitsDpr := TStringList.Create;
    ArquivoDpr := TStringList.Create;
    ArquivoDpr.LoadFromFile(ExtractFilePath(Application.ExeName) + 'ProjetoTesteT2Ti.dpr');

    for i := 6 to ArquivoDpr.Count - 1 do
    begin
      UnitsDpr.Add( Copy(Trim(ArquivoDpr[i]), 1, Pos('in', Trim(ArquivoDpr[i])) - 2 ) );
    end;


    ArquivoDpr[0] := 'program ' + EditNomeProjeto.Text + ';';

    // Controllers
    for i := 0 to ListaControllersVinculados.Count - 1 do
    begin
      if UnitsDpr.IndexOf(ListaControllersVinculados[i]) = -1 then
      begin
        ArquivoDpr.Add('  ' + ListaControllersVinculados[i] + ' in ' + QuotedStr('Controller\' + ListaControllersVinculados[i] + '.pas')  + ',');
      end;
    end;

    // VOs
    for i := 0 to ListaVOsVinculados.Count - 1 do
    begin
      if UnitsDpr.IndexOf(ListaVOsVinculados[i]) = -1 then
      begin
        ArquivoDpr.Add('  ' + ListaVOsVinculados[i] + ' in ' + QuotedStr('..\..\Comum\VO\' + ListaVOsVinculados[i] + '.pas')  + ',');
      end;
    end;

    // Telas
    Enumerator := ListaVinculos.GetEnumerator;
    try
      with Enumerator do
      begin
        while MoveNext do
        begin
          NomeUnit := ExtractFileName(Current.Value);
          Delete(NomeUnit, Length(NomeUnit) - 3, 4);
          NomeForm := NomeUnit;
          Delete(NomeForm, 1, 1);
          NomeForm := 'F' + NomeForm;
          ArquivoDpr.Add('  ' + NomeUnit + ' in ' + QuotedStr('Tela\' + NomeUnit + '.pas')  + '{' + NomeForm + '},');
        end;
      end;
    finally
      Enumerator.Free;
    end;

    // Final do Arquivo
    ArquivoDpr.Add('  TipoAdmissaoVO in ' + QuotedStr('..\..\Comum\VO\TipoAdmissaoVO.pas') + ';' );
    ArquivoDpr.Add('');
    ArquivoDpr.Add('{$R *.res}');
    ArquivoDpr.Add('');
    ArquivoDpr.Add('begin');
    ArquivoDpr.Add('  Application.Initialize;');
    ArquivoDpr.Add('  Application.MainFormOnTaskbar := True;');
    ArquivoDpr.Add('  Application.CreateForm(TFMenu, FMenu);');
    ArquivoDpr.Add('  Application.CreateForm(TFDataModule, FDataModule);');
    ArquivoDpr.Add('  Application.Run;');
    ArquivoDpr.Add('end.');

    //Copia os arquivos
    Origem := ExtractFilePath(Application.ExeName) + 'Conexao.ini';
    Destino := EditCaminhoProjeto.Text + '\Conexao.ini';
    CopyFile(PChar(Origem), PChar(Destino), False);

    Destino := EditCaminhoProjeto.Text + '\' + EditNomeProjeto.Text + '.dpr';
    ArquivoDpr.SaveToFile(Destino);
  finally
    ArquivoDpr.Free;
    UnitsDpr.Free;
  end;
end;

procedure TFPrincipal.CriarArquivoMenu;
var
  MemStream, StreamTexto: TMemoryStream;
  RibbonStringList, RibbonStringListOK, GrupoStringList: TStringList;
  ActionManagerStringList, ActionManagerStringListOK: TStringList;
  Linha, NomePage, NomeUnit: String;
  //
  ArquivoMenu, ArquivoMenuPas: TStringList;
  i, j, k, w: Integer;
  //
  Enumerator: TEnumerator < TPair < String, String >> ;
begin
  // Gera o Ribbon
  try
    MemStream := TMemoryStream.Create;
    StreamTexto := TMemoryStream.Create;

    MemStream.WriteComponent(FMenu.Ribbon);
    MemStream.Position := 0;
    ObjectBinaryToText(MemStream, StreamTexto);
    StreamTexto.Position := 0;

    // Carrega o Ribbon numa StringList para adicionar os Grupos
    RibbonStringList := TStringList.Create;
    RibbonStringListOK := TStringList.Create;

    RibbonStringList.LoadFromStream(StreamTexto);

    i := 0;
    while i < RibbonStringList.Count do
    begin
      // Retira TRibbonSystemButton gerados pelo Delphi
      while Pos('TRibbonSystemButton', RibbonStringList[i]) > 0 do
      begin
        i := i + 6;
      end;

      Linha := RibbonStringList[i];

      if Pos('FPrincipal.', Linha) > 0 then
      begin
        Linha := StringReplace(Linha, 'FPrincipal.', '', [rfReplaceAll]);
      end;
      if Pos('FMenu.', Linha) > 0 then
      begin
        Linha := StringReplace(Linha, 'FMenu.', '', [rfReplaceAll]);
      end;

      RibbonStringListOK.Add(Linha);

      if Pos('StyleName', Linha) > 0 then
      begin
        RibbonStringListOK.Add('  object RibbonApplicationMenuBar1: TRibbonApplicationMenuBar');
        RibbonStringListOK.Add('    ActionManager = ActionManager');
        RibbonStringListOK.Add('    OptionItems = <>');
        RibbonStringListOK.Add('    RecentItems = <>');
        RibbonStringListOK.Add('  end');
      end;

      // Chegou numa RibbonPage
      if Pos('TRibbonPage', Linha) > 0 then
      begin
        NomePage := Trim(Linha);
        Delete(NomePage, 1, 7);
        Delete(NomePage, Pos(':', NomePage), Length(NomePage));

        // Verifica o nome da p�gina e adiciona os grupos pertencentes a ela
        for j := 0 to FMenu.Ribbon.ControlCount - 1 do
        begin
          if FMenu.Ribbon.Controls[j] is TRibbonPage then
          begin
            if ((FMenu.Ribbon.Controls[j] as TRibbonPage).Name = NomePage) and ( (FMenu.Ribbon.Controls[j] as TRibbonPage).GroupCount > 0 ) then
            begin

              repeat
                RibbonStringListOK.Add(RibbonStringList[i+1]);
                Inc(i);
              until (Pos('end', RibbonStringList[i+1]) > 0);

              // Adiciona os grupos da p�gina
              for k := 0 to (FMenu.Ribbon.Controls[j] as TRibbonPage).GroupCount - 1 do
              begin
                MemStream := TMemoryStream.Create;
                StreamTexto := TMemoryStream.Create;

                MemStream.WriteComponent((FMenu.Ribbon.Controls[j] as TRibbonPage).Groups[k]);
                MemStream.Position := 0;
                ObjectBinaryToText(MemStream, StreamTexto);
                StreamTexto.Position := 0;

                GrupoStringList := TStringList.Create;
                GrupoStringList.LoadFromStream(StreamTexto);

                w := 0;
                while w < GrupoStringList.Count do
                begin
                  // Retira TRibbonSmallButtonControl e TRibbonLargeButtonControl gerados pelo Delphi
                  while (Pos('TRibbonSmallButtonControl', GrupoStringList[w]) > 0) or (Pos('TRibbonLargeButtonControl', GrupoStringList[w]) > 0) do
                  begin
                    w := w + 6;
                  end;

                  RibbonStringListOK.Add('    ' + GrupoStringList[w]);
                  Inc(w);
                end;
              end;
            end;
          end;
        end;
      end;
      Inc(i);
    end;

  finally
    MemStream.Free;
    StreamTexto.Free;
    RibbonStringList.Free;
    GrupoStringList.Free;
  end;


  // Gera o ActionManager
  try
    MemStream := TMemoryStream.Create;
    StreamTexto := TMemoryStream.Create;

    MemStream.WriteComponent(FMenu.ActionManager);
    MemStream.Position := 0;
    ObjectBinaryToText(MemStream, StreamTexto);
    StreamTexto.Position := 0;

    // Carrega o ActionManager numa StringList
    ActionManagerStringList := TStringList.Create;
    ActionManagerStringListOK := TStringList.Create;
    ActionManagerStringList.LoadFromStream(StreamTexto);

    i := 0;
    while i < ActionManagerStringList.Count do
    begin
      Linha := ActionManagerStringList[i];

      if Pos('FPrincipal.', Linha) > 0 then
      begin
        Linha := StringReplace(Linha, 'FPrincipal.', '', [rfReplaceAll]);
      end;

      // Insere o item relacionado ao ApplicationMenuBar
      if Pos('ActionBars = <', Linha) > 0 then
      begin
        ActionManagerStringListOK.Add(Linha);
        ActionManagerStringListOK.Add('      item');
        ActionManagerStringListOK.Add('        Items = <');
        ActionManagerStringListOK.Add('          item');
        ActionManagerStringListOK.Add('            ChangesAllowed = [caModify]');
        ActionManagerStringListOK.Add('            Action = ActionSair');
        ActionManagerStringListOK.Add('            Caption = ' + QuotedStr('&Sair do Sistema'));
        ActionManagerStringListOK.Add('            ImageIndex = 0');
        ActionManagerStringListOK.Add('            KeyTip = ' + QuotedStr('F'));
        ActionManagerStringListOK.Add('          end>');
        ActionManagerStringListOK.Add('        ActionBar = RibbonApplicationMenuBar1');
        ActionManagerStringListOK.Add('        AutoSize = False');
        ActionManagerStringListOK.Add('      end');
        Linha := '';
      end;

      ActionManagerStringListOK.Add(Linha);

      // Chegou no final do ActionManager gerado pelo Delphi. Vamos adicionar as Actions
      if Pos('StyleName', Linha) > 0 then
      begin
        Inc(i);

        for j := 0 to FMenu.ActionManager.ActionBars.Count - 1 do
        begin
          for k := 0 to FMenu.ActionManager.ActionBars[j].Items.Count - 1 do
          begin
            ActionManagerStringListOK.Add('  object ' + FMenu.ActionManager.ActionBars[j].Items[k].Action.Name + ': TAction');
            ActionManagerStringListOK.Add('    Category = ' + QuotedStr(FMenu.ActionManager.ActionBars[j].Items[k].Action.Category));
            ActionManagerStringListOK.Add('    Caption = ' + QuotedStr(FMenu.ActionManager.ActionBars[j].Items[k].Caption));
            ActionManagerStringListOK.Add('    ImageIndex = ' + IntToStr(FMenu.ActionManager.ActionBars[j].Items[k].ImageIndex));
            ActionManagerStringListOK.Add('    OnExecute = ' + FMenu.ActionManager.ActionBars[j].Items[k].Action.Name + 'Execute');
            ActionManagerStringListOK.Add('  end');
          end;
        end;
      end;
      Inc(i);
    end;
    ActionManagerStringListOK.Add('end');

  finally
    MemStream.Free;
    StreamTexto.Free;
  end;

  // Monta o Menu DFM
  try
    MemStream := TMemoryStream.Create;
    StreamTexto := TMemoryStream.Create;
    ArquivoMenu := TStringList.Create;

    ArquivoMenu.LoadFromFile(ExtractFilePath(application.ExeName) + 'UMenu.dfm_head');

    for i := 0 to RibbonStringListOK.Count - 1 do
    begin
      ArquivoMenu.Add(RibbonStringListOk[i])
    end;

    for i := 0 to ActionManagerStringListOK.Count - 1 do
    begin
      Linha := ActionManagerStringListOK[i];
      if Pos('RibbonPage', Linha) > 0 then
      begin
        Delete(Linha, Pos('RibbonPage', Linha), 12);
      end;
      ArquivoMenu.Add(Linha);
    end;

    ArquivoMenu.Add('end');

    ArquivoMenu.SaveToFile(EditCaminhoProjeto.Text + '\Tela\UMenu.dfm');

  finally
    MemStream.Free;
    StreamTexto.Free;
    ArquivoMenu.Free;
    RibbonStringListOK.Free;
    ActionManagerStringList.Free;
  end;


  // Monta o Menu PAS
  try
    MemStream := TMemoryStream.Create;
    StreamTexto := TMemoryStream.Create;
    ArquivoMenu := TStringList.Create;
    ArquivoMenuPas := TStringList.Create;

    ArquivoMenu.LoadFromFile(ExtractFilePath(application.ExeName) + 'UMenu.pas');

    i := 0;
    while i < ArquivoMenu.Count do
    begin
      Linha := ArquivoMenu[i];

      if Pos('Comentar', Linha) > 0 then
      begin
        Linha := '//' + Linha;
      end;
      if Pos('Descomentar', Linha) > 0 then
      begin
        Linha := '';
      end;
      if Pos('Remover', Linha) > 0 then
      begin
        Linha := '';
      end;

      // Adicionar as Units das janelas
      if Pos('SessaoUsuario', Linha) > 0 then
      begin
        Enumerator := ListaVinculos.GetEnumerator;
        try
          with Enumerator do
          begin
            while MoveNext do
            begin
              NomeUnit := ExtractFileName(Current.Value);
              Delete(NomeUnit, Length(NomeUnit) - 3, 4);
              Linha := ', ' + NomeUnit + Linha;
            end;
          end;
        finally
          Enumerator.Free;
        end;
      end;

      // Declarar as Actions
      if Pos('TFMenu = class', Linha) > 0 then
      begin
        Linha := StringReplace(Linha, 'TForm', 'TFBase', [rfReplaceAll]);
        ArquivoMenuPas.Add(Linha);
        //
        for j := 0 to FMenu.ActionManager.ActionBars.Count - 1 do
        begin
          for k := 0 to FMenu.ActionManager.ActionBars[j].Items.Count - 1 do
          begin
            ArquivoMenuPas.Add('    ' + FMenu.ActionManager.ActionBars[j].Items[k].Action.Name + ': TAction;');
          end;
        end;
        Linha := '';
      end;

      // Declarar as Procedures das Actions
      if Pos('procedure AdicionarGrupo', Linha) > 0 then
      begin
        ArquivoMenuPas.Add(Linha);
        //
        for j := 0 to FMenu.ActionManager.ActionBars.Count - 1 do
        begin
          for k := 0 to FMenu.ActionManager.ActionBars[j].Items.Count - 1 do
          begin
            ArquivoMenuPas.Add('    procedure ' + FMenu.ActionManager.ActionBars[j].Items[k].Action.Name + 'Execute(Sender: TObject);');
          end;
        end;
        Linha := '';
      end;

      // Adicionar a Implementa��o das Actions
      if Pos('$Region ' + QuotedStr('Actions'), Linha) > 0 then
      begin
        ArquivoMenuPas.Add(Linha);
        //
        for j := 0 to FMenu.ActionManager.ActionBars.Count - 1 do
        begin
          for k := 0 to FMenu.ActionManager.ActionBars[j].Items.Count - 1 do
          begin
            ArquivoMenuPas.Add('procedure TFMenu.' + FMenu.ActionManager.ActionBars[j].Items[k].Action.Name + 'Execute(Sender: TObject);');
            ArquivoMenuPas.Add('begin');
            NomeUnit := FMenu.ActionManager.ActionBars[j].Items[k].Action.Name;
            NomeUnit := StringReplace(NomeUnit, 'Action', 'TF', [rfReplaceAll]);
            ArquivoMenuPas.Add('  NovaPagina(' +  NomeUnit + ',(Sender as TAction).ImageIndex);');
            ArquivoMenuPas.Add('end;');
          end;
        end;
        Linha := '';
      end;

      ArquivoMenuPas.Add(Linha);
      Inc(i)
    end;

    ArquivoMenuPas.SaveToFile(EditCaminhoProjeto.Text + '\Tela\UMenu.pas');

  finally
    MemStream.Free;
    StreamTexto.Free;
    ArquivoMenu.Free;
    ArquivoMenuPas.Free;
  end;

end;

procedure TFPrincipal.Split(const Delimiter: Char; Input: string; const Strings: TStrings);
begin
  Assert(Assigned(Strings));
  Strings.Clear;
  Strings.Delimiter := Delimiter;
  Strings.DelimitedText := Input;
end;
{$EndRegion}

{$EndRegion}

end.
