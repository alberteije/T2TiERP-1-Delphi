{ *******************************************************************************
  Title: T2Ti ERP
  Description: Janela para armazenar os documentos do GED

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
  ******************************************************************************* }
unit UGedDocumento;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UTelaCadastro, Menus, StdCtrls, ExtCtrls, Buttons, Grids, DBGrids,
  JvExDBGrids, JvDBGrid, JvDBUltimGrid, ComCtrls, Constantes, Tipos,
  DelphiTwain, pngimage, OleCtnrs, Mask, JvExMask, JvToolEdit, SWSystem,
  DBXJSON, CAPICOM_TLB, IdHashMessageDigest, UDataModule, DBCtrls, DB, DBClient,
  GedTipoDocumentoController, GedTipoDocumentoVO, Biblioteca, jpeg, Atributos,
  LabeledCtrls, LabeledDBCtrls, JvBaseEdits, ActnList, ActnMan, ToolWin,
  ActnCtrls, WideStrings, PlatformDefaultStyleActnCtrls, StrUtils, Generics.Collections,
  Enter;

type
  [TFormDescription(TConstantes.MODULO_GED, 'Documento')]

  TFGedDocumento = class(TFTelaCadastro)
    Twain: TDelphiTwain;
    PopupMenu: TPopupMenu;
    miTamanhoOriginal: TMenuItem;
    miReduzirparacaber: TMenuItem;
    PanelEditDocumento: TPanel;
    BevelEdits: TBevel;
    EditNome: TLabeledEdit;
    EditDescricao: TLabeledEdit;
    EditPalavraChave: TLabeledEdit;
    CheckPodeExcluir: TCheckBox;
    CheckPodeAlterar: TCheckBox;
    CheckAssinado: TCheckBox;
    ScrollBoxImage: TScrollBox;
    ImagemDocumento: TImage;
    Ole: TOleContainer;
    EditArquivoSelecionado: TLabeledEdit;
    EditDataVigencia: TLabeledDateEdit;
    EditIdGedTipoDocumento: TLabeledCalcEdit;
    EditGedTipoDocumento: TLabeledEdit;
    ActionManager1: TActionManager;
    ActionVisualizarArquivo: TAction;
    ActionAbrirArquivo: TAction;
    ActionDigitalizar: TAction;
    ActionToolBar1: TActionToolBar;
    PageControlItens: TPageControl;
    tsItens: TTabSheet;
    PanelItens: TPanel;
    GridDetalhe: TJvDBUltimGrid;
    DSVersaoDocumento: TDataSource;
    CDSVersaoDocumento: TClientDataSet;
    CDSVersaoDocumentoID: TIntegerField;
    CDSVersaoDocumentoID_COLABORADOR: TIntegerField;
    CDSVersaoDocumentoID_GED_DOCUMENTO: TIntegerField;
    CDSVersaoDocumentoVERSAO: TIntegerField;
    CDSVersaoDocumentoDATA_HORA: TSQLTimeStampField;
    CDSVersaoDocumentoHASH_ARQUIVO: TStringField;
    CDSVersaoDocumentoCAMINHO: TStringField;
    CDSVersaoDocumentoACAO: TStringField;
    MREnter: TMREnter;
    procedure FormCreate(Sender: TObject);
    procedure TwainTwainAcquire(Sender: TObject; const Index: Integer; Image: TBitmap; var Cancel: Boolean);
    procedure miTamanhoOriginalClick(Sender: TObject);
    procedure miReduzirparacaberClick(Sender: TObject);
    procedure EditIdGedTipoDocumentoExit(Sender: TObject);
    procedure EditIdGedTipoDocumentoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ActionVisualizarArquivoExecute(Sender: TObject);
    procedure ActionAbrirArquivoExecute(Sender: TObject);
    procedure ActionDigitalizarExecute(Sender: TObject);
    procedure GridDetalheDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    TipoArquivo, BytesArquivo, BytesAssinatura: String;
    TamanhoArquivo: Integer;
    ArquivoStream, AssinaturaStream: TStringStream;
    ArrayArquivos: TJSONArray;
    Certificado: ICertificate2;

    procedure GridParaEdits; override;
    procedure LimparCampos; override;

    // Controles CRUD
    function DoInserir: Boolean; override;
    function DoEditar: Boolean; override;
    function DoExcluir: Boolean; override;
    function DoSalvar: Boolean; override;
    function DoCancelar: Boolean; override;

    procedure OnStatusTela; override;

    procedure CarregaArquivo(pArquivo: String);
    procedure CarregaImagemPadrao;
    procedure CarregaImagemArquivo(pCaminhoArquivo: string);

    procedure SelecionarCertificado;
    procedure AssinarArquivo;
  public
    { Public declarations }
  end;

implementation

uses GedDocumentoController, GedDocumentoVO, GedVersaoDocumentoVO, UMenu;
{$R *.dfm}

{$Region 'Infra'}
procedure TFGedDocumento.FormCreate(Sender: TObject);
begin
  ClasseObjetoGridVO := TGedDocumentoVO;
  ObjetoController := TGedDocumentoController.Create;
  inherited;
  CarregaImagemPadrao;
end;

procedure TFGedDocumento.FormShow(Sender: TObject);
begin
  inherited;
  if not Assigned(FMenu) then
  begin
    ComboBoxCampos.ItemIndex := ComboBoxCampos.Items.IndexOf('NOME');
  end;
end;

procedure TFGedDocumento.LimparCampos;
begin
  inherited;
  CheckPodeExcluir.Checked := False;
  CheckPodeAlterar.Checked := False;
  CheckAssinado.Checked := False;
  CDSVersaoDocumento.EmptyDataSet;
  CarregaImagemPadrao;
end;

procedure TFGedDocumento.OnStatusTela;
begin
  inherited;

  PanelEditDocumento.Enabled := PanelEdits.Enabled;
  PanelEdits.Enabled := True;
end;
{$EndRegion}

{$REGION 'Controles CRUD'}
function TFGedDocumento.DoInserir: Boolean;
begin
  Result := inherited DoInserir;

  if Result then
  begin
    EditIdGedTipoDocumento.SetFocus;
  end;
end;

function TFGedDocumento.DoCancelar: Boolean;
begin
  Result := inherited DoCancelar;

  // se foi chamado por outra aplicação fecha o formulário
  if not Assigned(FMenu) then
  begin
    Close;
  end;
end;

function TFGedDocumento.DoEditar: Boolean;
begin
  // faz o teste se não tiver sido chamado por outra aplicação
  if Assigned(FMenu) then
  begin
    if not CDSGrid.IsEmpty then
    begin
      ObjetoVO := ObjetoController.VO<TGedDocumentoVO>(IdRegistroSelecionado);

      if TGedDocumentoVO(ObjetoVO).PodeAlterar = 'N' then
      begin
        Application.MessageBox('Documento não pode ser alterado.', 'Informação do sistema', MB_OK + MB_ICONINFORMATION);
        Result := False;
        Exit;
      end;
    end;
  end;

  Result := inherited DoEditar;

  if Result then
  begin
    EditIdGedTipoDocumento.SetFocus;
  end;
end;

function TFGedDocumento.DoExcluir: Boolean;
begin
  if not CDSGrid.IsEmpty then
  begin
    ObjetoVO := ObjetoController.VO<TGedDocumentoVO>(IdRegistroSelecionado);

    if TGedDocumentoVO(ObjetoVO).PodeExcluir = 'N' then
    begin
      Application.MessageBox('Documento não pode ser excluído.', 'Informação do sistema', MB_OK + MB_ICONINFORMATION);
      Result := False;
      Exit;
    end;
  end;

  if inherited DoExcluir then
  begin
    try
      Result := TGedDocumentoController(ObjetoController).Exclui(IdRegistroSelecionado);
    except
      Result := False;
    end;
  end
  else
  begin
    Result := False;
  end;

  if Result then
    TGedDocumentoController(ObjetoController).Consulta(Filtro, Pagina);
end;

function TFGedDocumento.DoSalvar: Boolean;
var
  I: Integer;
  BytesAssinatura, MD5: String;
begin
  if EditIdGedTipoDocumento.AsInteger <= 0 then
  begin
    Application.MessageBox('Tipo de Documento não Informado!', 'Atenção', MB_OK + MB_ICONINFORMATION);
    EditIdGedTipoDocumento.SetFocus;
    Exit;
  end;

  Result := inherited DoSalvar;

  if Result then
  begin
    try
      try
        if not Assigned(ObjetoVO) then
          ObjetoVO := TGedDocumentoVO.Create;

        TGedDocumentoVO(ObjetoVO).IdEmpresa := Sessao.IdEmpresa;
        TGedDocumentoVO(ObjetoVO).IdGedTipoDocumento := EditIdGedTipoDocumento.AsInteger;
        TGedDocumentoVO(ObjetoVO).GedTipoDocumentoNome := EditGedTipoDocumento.Text;
        TGedDocumentoVO(ObjetoVO).Nome := EditNome.Text;
        TGedDocumentoVO(ObjetoVO).Descricao := EditDescricao.Text;
        TGedDocumentoVO(ObjetoVO).PalavraChave := EditPalavraChave.Text;
        TGedDocumentoVO(ObjetoVO).DataFimVigencia := EditDataVigencia.Date;

        TGedDocumentoVO(ObjetoVO).PodeExcluir := IfThen(CheckPodeExcluir.Checked, 'S', 'N');
        TGedDocumentoVO(ObjetoVO).PodeAlterar := IfThen(CheckPodeAlterar.Checked, 'S', 'N');
        TGedDocumentoVO(ObjetoVO).Assinado := IfThen(CheckAssinado.Checked, 'S', 'N');

        if Assigned(ArquivoStream) then
        begin
          // cria o array do json para armazenar os arquivos
          ArrayArquivos := TJSONArray.Create;

          // vai armazenar os bytes do arquivo de assinatura, caso exista
          BytesAssinatura := '';
          BytesArquivo := '';

          if CheckAssinado.Checked then
          begin
            SelecionarCertificado;
            AssinarArquivo;
            for I := 0 to AssinaturaStream.Size - 1 do
            begin
              BytesAssinatura := BytesAssinatura + IntToStr(AssinaturaStream.Bytes[I]) + ', ';
            end;
            // Tira a ultima virgula
            Delete(BytesAssinatura, Length(BytesAssinatura) - 1, 2);
          end;

          // adiciona a assinatura, que vai preenchida ou vazia (posicao zero do array)
          ArrayArquivos.Add(BytesAssinatura);

          // adiciona o tamanho do arquivo de assinatura (posicao um do array)
          if Assigned(AssinaturaStream) then
            ArrayArquivos.AddElement(TJSONNumber.Create(AssinaturaStream.Size))
          else
            ArrayArquivos.AddElement(TJSONNumber.Create(0));

          // laço pra pegar os bytes do arquivo ou imagem
          for I := 0 to TamanhoArquivo - 1 do
          begin
            BytesArquivo := BytesArquivo + IntToStr(ArquivoStream.Bytes[I]) + ', ';
          end;
          // Tira a ultima virgula
          Delete(BytesArquivo, Length(BytesArquivo) - 1, 2);

          // adiciona o arquivo no array do json (posicao dois do array)
          ArrayArquivos.Add(BytesArquivo);

          // adiciona o tamanho do arquivo no array do json (posicao tres do array)
          ArrayArquivos.AddElement(TJSONNumber.Create(TamanhoArquivo));

          // adiciona o tipo do arquivo no array (posicao quatro do array)
          ArrayArquivos.AddElement(TJSONString.Create(TipoArquivo));

          MD5 := MD5FileGed(ArquivoStream);
          // adiciona o MD5 do arquivo no array (posicao cinco do array)
          ArrayArquivos.AddElement(TJSONString.Create(MD5));
        end;


        // ObjetoVO - libera objetos vinculados (TAssociation) - não tem necessidade de subir
        TGedDocumentoVO(ObjetoVO).GedTipoDocumentoVO := Nil;
        TGedDocumentoVO(ObjetoVO).ListaGedVersaoDocumentoVO := Nil;

        // ObjetoOldVO - libera objetos vinculados (TAssociation) - não tem necessidade de subir
        if Assigned(ObjetoOldVO) then
        begin
          TGedDocumentoVO(ObjetoOldVO).GedTipoDocumentoVO := Nil;
          TGedDocumentoVO(ObjetoOldVO).ListaGedVersaoDocumentoVO := Nil;
        end;

        if StatusTela = stInserindo then
        begin
          if Assigned(ArquivoStream) then
            Result := TGedDocumentoController(ObjetoController).Insere(TGedDocumentoVO(ObjetoVO), ArrayArquivos)
          else
            Result := TGedDocumentoController(ObjetoController).Insere(TGedDocumentoVO(ObjetoVO))
        end
        else if StatusTela = stEditando then
        begin
          if Assigned(ArquivoStream) then
          begin
            Result := TGedDocumentoController(ObjetoController).Altera(TGedDocumentoVO(ObjetoVO), TGedDocumentoVO(ObjetoOldVO), ArrayArquivos);
          end
          else
          begin
            if TGedDocumentoVO(ObjetoVO).ToJSONString <> TGedDocumentoVO(ObjetoOldVO).ToJSONString then
            begin
              TGedDocumentoVO(ObjetoVO).ID := IdRegistroSelecionado;
              Result := TGedDocumentoController(ObjetoController).Altera(TGedDocumentoVO(ObjetoVO), TGedDocumentoVO(ObjetoOldVO));
            end
            else
              Application.MessageBox('Nenhum dado foi alterado.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
          end;
        end;
      finally
      end;

      Result := True;

      ArquivoStream.Free;
      AssinaturaStream.Free;

      // se foi chamado por outra aplicação fecha o formulário
      if not Assigned(FMenu) then
      begin
        Close;
      end;
    except
      on E: Exception do
      begin
        Application.MessageBox(PChar('Ocorreu um erro na ao tentar salvar o documento. Informe a mensagem ao Administrador do sistema.' + #13 + #13 + E.Message), 'Erro do sistema', MB_OK + MB_ICONERROR);
        Result := False;
      end;
    end;
  end;
end;
{$ENDREGION}

{$Region 'Campos Transientes'}
procedure TFGedDocumento.EditIdGedTipoDocumentoExit(Sender: TObject);
var
  Filtro: String;
begin
  if EditIdGedTipoDocumento.Value <> 0 then
  begin
    try
      Filtro := 'ID = ' + EditIdGedTipoDocumento.Text;
      EditIdGedTipoDocumento.Clear;
      EditGedTipoDocumento.Clear;
      if not PopulaCamposTransientes(Filtro, TGedTipoDocumentoVO, TGedTipoDocumentoController) then
        PopulaCamposTransientesLookup(TGedTipoDocumentoVO, TGedTipoDocumentoController);
      if CDSTransiente.RecordCount > 0 then
      begin
        EditIdGedTipoDocumento.Text := CDSTransiente.FieldByName('ID').AsString;
        EditGedTipoDocumento.Text := CDSTransiente.FieldByName('NOME').AsString;
      end
      else
      begin
        Exit;
        EditIdGedTipoDocumento.SetFocus;
      end;
    finally
      CDSTransiente.Close;
    end;
  end
  else
  begin
    EditGedTipoDocumento.Clear;
  end;
end;

procedure TFGedDocumento.EditIdGedTipoDocumentoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditIdGedTipoDocumento.Value := -1;
    EditIdGedTipoDocumento.OnExit(Sender);
    EditNome.SetFocus;
  end;
end;
{$ENDREGION}

{$REGION 'Controle de Grid'}
procedure TFGedDocumento.GridParaEdits;
var
  GedVersaoDocumentoEnumerator: TEnumerator<TGedVersaoDocumentoVO>;
begin
  inherited;

  if not CDSGrid.IsEmpty then
  begin
    ObjetoVO := ObjetoController.VO<TGedDocumentoVO>(IdRegistroSelecionado);
    if StatusTela = stEditando then
      ObjetoOldVO := ObjetoController.VO<TGedDocumentoVO>(IdRegistroSelecionado);
  end;

  if Assigned(ObjetoVO) then
  begin
    EditNome.Text := TGedDocumentoVO(ObjetoVO).Nome;
    EditDescricao.Text := TGedDocumentoVO(ObjetoVO).Descricao;
    EditPalavraChave.Text := TGedDocumentoVO(ObjetoVO).PalavraChave;
    EditIdGedTipoDocumento.AsInteger := TGedDocumentoVO(ObjetoVO).IdGedTipoDocumento;
    EditGedTipoDocumento.Text := TGedDocumentoVO(ObjetoVO).GedTipoDocumentoNome;
    EditDataVigencia.Date := TGedDocumentoVO(ObjetoVO).DataFimVigencia;
    If TGedDocumentoVO(ObjetoVO).PodeExcluir = 'S' then
      CheckPodeExcluir.Checked := True
    else
      CheckPodeExcluir.Checked := False;

    If TGedDocumentoVO(ObjetoVO).PodeAlterar = 'S' then
      CheckPodeAlterar.Checked := True
    else
      CheckPodeAlterar.Checked := False;

    If TGedDocumentoVO(ObjetoVO).Assinado = 'S' then
      CheckAssinado.Checked := True
    else
      CheckAssinado.Checked := False;

    // Versionamento
    GedVersaoDocumentoEnumerator := TGedDocumentoVO(ObjetoVO).ListaGedVersaoDocumentoVO.GetEnumerator;
    try
      with GedVersaoDocumentoEnumerator do
      begin
        while MoveNext do
        begin
          CDSVersaoDocumento.Append;
          CDSVersaoDocumentoID.AsInteger := Current.id;
          CDSVersaoDocumentoID_COLABORADOR.AsInteger := Current.IdColaborador;
          CDSVersaoDocumentoID_GED_DOCUMENTO.AsInteger := Current.IdGedDocumento;
          CDSVersaoDocumentoVERSAO.AsInteger := Current.Versao;
          CDSVersaoDocumentoDATA_HORA.AsDateTime := Current.DataHora;
          CDSVersaoDocumentoHASH_ARQUIVO.AsString := Current.HashArquivo;
          CDSVersaoDocumentoCAMINHO.AsString := Current.Caminho;
          CDSVersaoDocumentoACAO.AsString := Current.Acao;
          CDSVersaoDocumento.Post;
        end;
      end;
    finally
      GedVersaoDocumentoEnumerator.Free;
    end;

    TGedDocumentoVO(ObjetoVO).ListaGedVersaoDocumentoVO := Nil;
    if Assigned(TGedDocumentoVO(ObjetoOldVO)) then
      TGedDocumentoVO(ObjetoOldVO).ListaGedVersaoDocumentoVO := Nil;

    CarregaArquivo(CDSVersaoDocumentoCAMINHO.AsString);
  end;
end;

procedure TFGedDocumento.CarregaArquivo(pArquivo: String);
begin
  EditArquivoSelecionado.Text := TGedDocumentoController.DownloadArquivo(pArquivo, 'GED');
  if Trim(EditArquivoSelecionado.Text) <> '' then
    CarregaImagemArquivo(EditArquivoSelecionado.Text);
end;

procedure TFGedDocumento.GridDetalheDblClick(Sender: TObject);
begin
  CarregaArquivo(CDSVersaoDocumentoCAMINHO.AsString);
end;
{$EndRegion}

{$Region 'Imagem'}
procedure TFGedDocumento.TwainTwainAcquire(Sender: TObject; const Index: Integer; Image: TBitmap; var Cancel: Boolean);
var
  ImagemJPG: TJPEGImage;
begin
  ImagemJPG := TJPEGImage.Create;
  try
    ImagemJPG.CompressionQuality := 65; // Menor tamanho - menor qualidade
    ImagemJPG.Assign(Image);

    ImagemDocumento.Picture.Assign(ImagemJPG);
  finally
    ImagemJPG.Free;
  end;

  Cancel := True; { Only want one image }
  ImagemDocumento.Align := alNone;
  ArquivoStream := TStringStream.Create;
  EditArquivoSelecionado.Text := '';
  ImagemDocumento.Picture.Graphic.SaveToStream(ArquivoStream);
  TipoArquivo := '.jpg';
  TamanhoArquivo := ArquivoStream.Size;
end;

procedure TFGedDocumento.miReduzirparacaberClick(Sender: TObject);
begin
  ImagemDocumento.AutoSize := False;
  ImagemDocumento.Width := 300;
  ImagemDocumento.Height := 300;
  ImagemDocumento.Stretch := True;
  ImagemDocumento.Proportional := True;
end;

procedure TFGedDocumento.miTamanhoOriginalClick(Sender: TObject);
begin
  ImagemDocumento.AutoSize := True;
  ImagemDocumento.Stretch := False;
  ImagemDocumento.Proportional := False;
end;

procedure TFGedDocumento.CarregaImagemPadrao;
begin
  FDataModule.ImagemPadrao.GetBitmap(0, ImagemDocumento.Picture.Bitmap);
  ImagemDocumento.Width := 300;
  ImagemDocumento.Height := 300;
  ImagemDocumento.AutoSize := True;
  ImagemDocumento.Stretch := False;
  ImagemDocumento.Align := alClient;
  ImagemDocumento.Repaint;
end;

procedure TFGedDocumento.CarregaImagemArquivo(pCaminhoArquivo: string);
const
  ExtImagens: array [0 .. 13] of string = ('.gif', '.cur', '.pcx', '.ani', '.gif', '.png', '.jpg', '.jpeg', '.bmp', '.tif', '.tiff', '.ico', '.emf', '.wmf');
var
  Ext: string;
  I: Integer;
begin
  CarregaImagemPadrao;

  if FileExists(pCaminhoArquivo) then
  begin
    Ext := LowerCase(ExtractFileExt(pCaminhoArquivo));
    for I := 0 to Length(ExtImagens) - 1 do
    begin
      if ExtImagens[I] = Ext then
      begin
        try
          ImagemDocumento.Picture.LoadFromFile(pCaminhoArquivo);
          miReduzirparacaberClick(nil);
        except
        end;
      end;
    end;
  end;
end;
{$EndRegion}

{$Region 'Assinatura Digital'}
procedure TFGedDocumento.SelecionarCertificado;
var
  Store: IStore3;
  Certs: ICertificates2;
  Certs2: ICertificates2;
  NumeroSerie: AnsiString;
  DataVencimento: TDateTime;
begin
  {
    Store: fornece os métodos para acessar o Certificate Store.
    O método Open estipula qual parte do Store se quer acessar:
    store pessoal ("My"), as autoridades certificadoras ("CA"), etc. }
  Store := CoStore.Create;

  // My CA Root AddressBook
  Store.Open(CAPICOM_CURRENT_USER_STORE, 'My', CAPICOM_STORE_OPEN_MAXIMUM_ALLOWED);

  Certs := Store.Certificates as ICertificates2;
  Certs2 := Certs.Select('Certificado(s) Digital(is) disponível(is)', 'Selecione o Certificado Digital para uso no aplicativo', False);

  if not(Certs2.Count = 0) then
  begin
    Certificado := IInterface(Certs2.Item[1]) as ICertificate2;
    NumeroSerie := Certificado.SerialNumber;
    DataVencimento := Certificado.ValidToDate;
  end;
end;

procedure TFGedDocumento.AssinarArquivo;
var
  lSigner: TSigner;
  lSignedData: TSignedData;
  qt: Integer;
  Mensagem, Conteudo: WideString;
begin
  { Abre o arquivo original para obter dele o conteúdo a ser assinado }
  Conteudo := ArquivoStream.DataString;

  { Configura o objeto responsável por fazer a assinatura, informando qual é o
    certificado a ser usado e o conteúdo a ser assinado }
  lSigner := TSigner.Create(self);
  lSigner.Certificate := Certificado;
  lSignedData := TSignedData.Create(self);
  lSignedData.Content := Conteudo;

  { Efetivamente assina o conteúdo }
  Mensagem := lSignedData.Sign(lSigner.DefaultInterface, True, CAPICOM_ENCODE_BASE64);

  { Cria um novo arquivo e grava nele o resultado da assinatura }
  AssinaturaStream := TStringStream.Create;
  for qt := 1 to Length(Mensagem) do
    AssinaturaStream.Write(Mensagem[qt], 2);

  lSignedData.Free;
  lSigner.Free;
end;
{$EndRegion}

{$Region 'Actions'}
procedure TFGedDocumento.ActionVisualizarArquivoExecute(Sender: TObject);
begin
  if Assigned(ArquivoStream) then
  begin
    Ole.CreateObjectFromFile(FDataModule.OpenDialog.FileName, False);
    Ole.DoVerb(ovShow);
  end
  else if FileExists(EditArquivoSelecionado.Text) then
  begin
    Ole.CreateObjectFromFile(EditArquivoSelecionado.Text, False);
    Ole.DoVerb(ovShow);
  end
  else
    Application.MessageBox('Não existe arquivo para ser exibido.', 'Erro', MB_OK + MB_ICONERROR);
end;

procedure TFGedDocumento.ActionAbrirArquivoExecute(Sender: TObject);
begin
  if not(StatusTela in [stInserindo, stEditando]) then
    Application.MessageBox('Não é permitido selecionar novo arquivo no modo de consulta.', 'Informação do sistema.', MB_OK + MB_ICONINFORMATION)
  else
  begin
    if FDataModule.OpenDialog.Execute then
    begin
      ArquivoStream := TStringStream.Create;
      ArquivoStream.LoadFromFile(FDataModule.OpenDialog.FileName);
      TamanhoArquivo := FileSize(FDataModule.OpenDialog.FileName);
      TipoArquivo := ExtractFileExt(FDataModule.OpenDialog.FileName);
      CarregaImagemPadrao;
      EditArquivoSelecionado.Text := FDataModule.OpenDialog.FileName;

      if EditNome.Text = '' then
      begin
        EditNome.Text := ExtractFileName(FDataModule.OpenDialog.FileName);
      end;

      CarregaImagemArquivo(FDataModule.OpenDialog.FileName);
    end;
  end;
end;

procedure TFGedDocumento.ActionDigitalizarExecute(Sender: TObject);
var
  SelectedSource: Integer;
begin
  if not(StatusTela in [stInserindo, stEditando]) then
    Application.MessageBox('Não é permitido digitalizar imagem no modo de consulta.', 'Informação do sistema.', MB_OK + MB_ICONINFORMATION)
  else
  begin
    { It is always recommended to load library dynamically, never forcing }
    { final user to have twain installed }
    if Twain.LoadLibrary then
    begin
      { Load source manager }
      Twain.SourceManagerLoaded := True;
      { Allow user to select source }
      SelectedSource := Twain.SelectSource;
      if SelectedSource <> -1 then
      begin
        { Load source, select transference method and enable (display interface) }
        Twain.Source[SelectedSource].Loaded := True;
        Twain.Source[SelectedSource].TransferMode := ttmMemory;
        Twain.Source[SelectedSource].Enabled := True;
      end { if SelectedSource <> -1 }
    end
    else
      Application.MessageBox('Twain não está instalado.', 'Erro', MB_OK + MB_ICONERROR);
  end;
end;
{$EndRegion}

end.
