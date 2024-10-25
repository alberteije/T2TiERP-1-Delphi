{ *******************************************************************************
  Title: T2Ti ERP
  Description: Ferramentas diversas da Software House

  The MIT License

  Copyright: Copyright (C) 2010 T2Ti.COM

  Permission is hereby granted, free of charge, to any person
  obtaining a copy of this software and associated documentation
  files (the "Software"), to deal in the Software without
  restriction, including without limitation the rightto use,
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
  ******************************************************************************* }
unit UTools;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ActnMan, ActnCtrls, PlatformDefaultStyleActnCtrls,
  ActnList, ImgList, StdCtrls, Buttons, FileCtrl, JvDriveCtrls, JvExStdCtrls,
  JvListBox, JvCombobox, Grids, ShellApi, ExtCtrls, IniFiles, Biblioteca,
  JvBaseDlg, JvBrowseFolder, JvComponentBase, JvZlibMultiple, DBClient,
  LabeledCtrls, DB, WideStrings, DBXMySql, SqlExpr, FMTBcd, Provider,
  JclStringLists, DBGrids, DBXFirebird;

type
  TFT2TiTools = class(TForm)
    PageControl1: TPageControl;
    TabSheetRES: TTabSheet;
    ActionManager1: TActionManager;
    ActionToolBar1: TActionToolBar;
    ImageListBotaoNormal: TImageList;
    ImageListBotaoDesabilitado: TImageList;
    ActionLocalizarFormularios: TAction;
    GroupBox1: TGroupBox;
    ListBoxFormularioLocalizado: TListBox;
    GroupBox2: TGroupBox;
    ListBoxFormularioIncluido: TListBox;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    JvDriveCombo: TJvDriveCombo;
    JvDirectoryListBox: TJvDirectoryListBox;
    ActionGerarArquivoRES: TAction;
    ActionSair: TAction;
    ActionGerarConexaoIni: TAction;
    TabSheetConexaoIni: TTabSheet;
    GroupBox3: TGroupBox;
    EditServidor: TLabeledEdit;
    EditPorta: TLabeledEdit;
    GroupBox4: TGroupBox;
    EditLogin: TLabeledEdit;
    EditSenha: TLabeledEdit;
    ActionToolBar2: TActionToolBar;
    ActionRecarregaArquivoIni: TAction;
    ActionToolBar3: TActionToolBar;
    EditLoginCriptografado: TLabeledEdit;
    EditSenhaCriptografada: TLabeledEdit;
    TabSheetPacoteAtualizacao: TTabSheet;
    JvDriveComboCompacta: TJvDriveCombo;
    JvDirectoryListBoxCompacta: TJvDirectoryListBox;
    Label1: TLabel;
    ActionToolBar4: TActionToolBar;
    JvFileListBoxCompacta: TJvFileListBox;
    EditNomeArquivoCompactado: TLabeledEdit;
    ActionCompactarArquivo: TAction;
    JvZlibMultiple: TJvZlibMultiple;
    TabSheetDadosPadroes: TTabSheet;
    ActionToolBar5: TActionToolBar;
    PanelDadosPadroes: TPanel;
    ActionGerarResPadraoEmpresa: TAction;
    TabSheetAtualizaBanco: TTabSheet;
    Panel1: TPanel;
    ActionToolBar6: TActionToolBar;
    EditArquivoScript: TLabeledEdit;
    ActionSelecionarArquivoScript: TAction;
    OpenDialog1: TOpenDialog;
    MemoScriptGerado: TLabeledMemo;
    ActionGerarScriptAlteracao: TAction;
    CDSScript: TClientDataSet;
    CDSBanco: TClientDataSet;
    SQLConnection: TSQLConnection;
    SQLQuery: TSQLQuery;
    DataSetProvider: TDataSetProvider;
    ActionGerarArquivoAtualizaBD: TAction;
    function CarregarTabelaScript(pArquivoCarregado: TStringList): TStringList;
    function PossuiAtributo(Attr, Val: Integer): Boolean;
    procedure ExibirConteudoPasta(Pasta: String);
    procedure ActionLocalizarFormulariosExecute(Sender: TObject);
    function PegarAnotacaoFormulario(Arquivo: String): String;
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure ActionGerarArquivoRESExecute(Sender: TObject);
    procedure ActionSairExecute(Sender: TObject);
    procedure CarregaArquivoConexaoIni;
    procedure FormCreate(Sender: TObject);
    procedure ActionGerarConexaoIniExecute(Sender: TObject);
    procedure ActionRecarregaArquivoIniExecute(Sender: TObject);
    procedure ActionCompactarArquivoExecute(Sender: TObject);
    procedure ActionGerarResPadraoEmpresaExecute(Sender: TObject);
    procedure ActionSelecionarArquivoScriptExecute(Sender: TObject);
    procedure ActionGerarScriptAlteracaoExecute(Sender: TObject);
    procedure ActionGerarArquivoAtualizaBDExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FT2TiTools: TFT2TiTools;
  Contador: Integer;

implementation

uses UDadosPadroes;

{$R *.dfm}

{$REGION 'Infra'}
procedure TFT2TiTools.ActionSairExecute(Sender: TObject);
begin
  Close;
end;

procedure TFT2TiTools.FormCreate(Sender: TObject);
begin
  CarregaArquivoConexaoIni;
  //
  FDadosPadroes := TFDadosPadroes.Create(PanelDadosPadroes);
  with FDadosPadroes do
  begin
    Align := alClient;
    BorderStyle := bsNone;
    Parent := PanelDadosPadroes;
  end;
  FDadosPadroes.Show;
end;
{$ENDREGION}

{$REGION 'Arquivo RES'}
procedure TFT2TiTools.ActionLocalizarFormulariosExecute(Sender: TObject);
begin
  ExibirConteudoPasta(JvDirectoryListBox.Directory);
end;

procedure TFT2TiTools.ExibirConteudoPasta(Pasta: String);
var
  ResultadoBusca: TSearchRec;
  Ret: Integer;
  TempNome, Formulario: String;
begin
  Ret := FindFirst(Pasta + '\*.*', faAnyFile, ResultadoBusca);
  try
    while Ret = 0 do
    begin
      if PossuiAtributo(ResultadoBusca.Attr, faDirectory) then
      begin
        if (ResultadoBusca.Name <> '.') And (ResultadoBusca.Name <> '..') then
        begin
          TempNome := Pasta + '\' + ResultadoBusca.Name;
          ExibirConteudoPasta(TempNome);
        end;
      end
      else
      begin
        if AnsiPos(ExtractFileExt(ResultadoBusca.Name), '.pas') > 0 then
        begin
          if (AnsiPos('Controller', ResultadoBusca.Name) = 0) and (AnsiPos('UMenu', ResultadoBusca.Name) = 0) and (AnsiPos('UBase', ResultadoBusca.Name) = 0) and (AnsiPos('UDataModule', ResultadoBusca.Name) = 0) and (AnsiPos('UFiltro', ResultadoBusca.Name) = 0) and
            (AnsiPos('ULogin', ResultadoBusca.Name) = 0) and (AnsiPos('ULookup', ResultadoBusca.Name) = 0) and (AnsiPos('UPapel', ResultadoBusca.Name) = 0) and (AnsiPos('UTela', ResultadoBusca.Name) = 0) and (AnsiPos('UTelaCadastro', ResultadoBusca.Name) = 0) and
            (AnsiPos('UUsuario', ResultadoBusca.Name) = 0) and (AnsiPos('VO', ResultadoBusca.Name) = 0) then
          begin
            Formulario := Trim(PegarAnotacaoFormulario(Pasta + '\' + ResultadoBusca.Name));
            if Formulario <> '' then
            begin
              if ListBoxFormularioLocalizado.Items.IndexOf(Formulario) = -1 then
                ListBoxFormularioLocalizado.Items.Add(Formulario);
            end;
          end;
        end;
      end;
      //
      Ret := FindNext(ResultadoBusca);
    end;
  finally
    begin
      FindClose(ResultadoBusca);
    end;
  end;
end;

function TFT2TiTools.PossuiAtributo(Attr, Val: Integer): Boolean;
begin
  Result := Attr and Val = Val;
end;

function TFT2TiTools.PegarAnotacaoFormulario(Arquivo: String): String;
var
  f: TextFile;
  Linha: String;
  Achou: Boolean;
begin
  Achou := False;
  AssignFile(f, Arquivo);
  Reset(f);
  While not Eof(f) do
  begin
    Readln(f, Linha);
    if AnsiPos('[TFormDescription', Linha) > 0 then
    begin
      Result := Trim(Linha);
      Achou := True;
    end;
    if AnsiPos('class(', Linha) > 0 then
    begin
      if Achou then
        Result := Result + '[' + Trim(Linha) + ']'
      else
        Break;
    end;
  end;
  CloseFile(f);
end;

procedure TFT2TiTools.SpeedButton1Click(Sender: TObject);
begin
  ListBoxFormularioIncluido.Items := ListBoxFormularioLocalizado.Items;
end;

procedure TFT2TiTools.SpeedButton2Click(Sender: TObject);
begin
  ListBoxFormularioIncluido.Items.Add(ListBoxFormularioLocalizado.Items[ListBoxFormularioLocalizado.ItemIndex]);
end;

procedure TFT2TiTools.SpeedButton3Click(Sender: TObject);
begin
  ListBoxFormularioIncluido.Clear;
end;

procedure TFT2TiTools.SpeedButton4Click(Sender: TObject);
begin
  ListBoxFormularioIncluido.DeleteSelected;
end;

procedure TFT2TiTools.ActionGerarArquivoRESExecute(Sender: TObject);
var
  ConteudoRC: TStringList;
  Parametros: String;
begin
  // grava arquivo TXT com os dados dos formul�rios
  ListBoxFormularioIncluido.Items.SaveToFile(ExtractFilePath(Application.ExeName) + 'T2TiERP_Forms.txt');

  // grava arquivo .RC para gerar o .RES
  ConteudoRC := TStringList.Create;
  ConteudoRC.Add('T2TiERP_Forms TXTFILE "T2TiERP_Forms.txt"');
  ConteudoRC.SaveToFile(ExtractFilePath(Application.ExeName) + 'T2TiERP_Forms.RC');

  // cria o arquivo .RES
  Parametros := '/k brcc32 "' + ExtractFilePath(Application.ExeName) + 'T2TiERP_Forms.RC"';
  ShellExecute(Handle, 'open', 'cmd', PChar(Parametros), '', SW_HIDE);
end;
{$ENDREGION}

{$REGION 'Arquivo ConexaoIni'}
procedure TFT2TiTools.CarregaArquivoConexaoIni;
var
  ConexaoIni: TIniFile;
begin
  try
    try
      ConexaoIni := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'Conexao.ini');

      with ConexaoIni do
      begin
        if not SectionExists('ServidorApp') then
        begin
          WriteString('ServidorApp', 'Servidor', 'localhost');
          WriteInteger('ServidorApp', 'Porta', 8080);
        end;
        if not SectionExists('Adm') then
        begin
          WriteString('Adm', 'Login', '');
          WriteString('Adm', 'Senha', '');
        end;

        EditServidor.Text := ReadString('ServidorApp', 'Servidor', '');
        EditPorta.Text := ReadString('ServidorApp', 'Porta', '');

        EditLogin.Text := Codifica('D',trim(ReadString('Adm', 'Login', '')));
        EditSenha.Text := Codifica('D',trim(ReadString('Adm', 'Senha', '')));
        EditLoginCriptografado.Text := ReadString('Adm', 'Login', '');
        EditSenhaCriptografada.Text := ReadString('Adm', 'Senha', '');
      end;
    except
      Application.MessageBox('Problemas ao carregar o arquivo Conexao.ini.', 'Informa��o do Sistema', MB_OK + MB_ICONERROR);
    end;
  finally
    ConexaoIni.Free;
  end;
end;

procedure TFT2TiTools.ActionGerarConexaoIniExecute(Sender: TObject);
var
  ConexaoIni: TIniFile;
begin
  try
    try
      ConexaoIni := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'Conexao.ini');

      with ConexaoIni do
      begin
        WriteString('ServidorApp', 'Servidor', 'localhost');
        WriteInteger('ServidorApp', 'Porta', 8080);
        WriteString('Adm', 'Login', Codifica('C', EditLogin.Text));
        WriteString('Adm', 'Senha', Codifica('C', EditSenha.Text));
      end;
    except
      Application.MessageBox('Problemas ao carregar o arquivo Conexao.ini.', 'Informa��o do Sistema', MB_OK + MB_ICONERROR);
    end;
  finally
    ConexaoIni.Free;
  end;
end;

procedure TFT2TiTools.ActionRecarregaArquivoIniExecute(Sender: TObject);
begin
  CarregaArquivoConexaoIni;
end;
{$ENDREGION}

{$REGION 'Pacote Atualiza��o'}
procedure TFT2TiTools.ActionCompactarArquivoExecute(Sender: TObject);
begin
  try
    JvZlibMultiple.CompressDirectory(JvDirectoryListBoxCompacta.Directory, False, JvDirectoryListBoxCompacta.Directory + '\' + EditNomeArquivoCompactado.Text + '.zip');
    Application.MessageBox('Arquivo compactado com sucesso.', 'Informa��o do Sistema', MB_OK + MB_ICONINFORMATION);
    JvDirectoryListBoxCompacta.FileList.Update;
  except
    Application.MessageBox('Problemas ao compactar o arquivo.', 'Informa��o do Sistema', MB_OK + MB_ICONERROR);
  end;
end;
{$ENDREGION}

{$REGION 'Dados Padr�es por Empresa'}
procedure TFT2TiTools.ActionGerarResPadraoEmpresaExecute(Sender: TObject);
var
  ConteudoRC: TStringList;
  Parametros: String;
  ListaDados: TStringList;
begin
  //Gera o arquivo RES com as instru��es SQL
  ListaDados := TStringList.Create;
  FDadosPadroes.CDSDadosPadroes.DisableControls;
  FDadosPadroes.CDSDadosPadroes.Filtered := False;
  FDadosPadroes.CDSDadosPadroes.First;
  while not FDadosPadroes.CDSDadosPadroes.Eof do
  begin
    ListaDados.Add(
                  FDadosPadroes.CDSDadosPadroesTABELA.AsString + '|' +
                  FDadosPadroes.CDSDadosPadroesCAMPO1.AsString + '|' +
                  FDadosPadroes.CDSDadosPadroesCAMPO2.AsString + '|' +
                  FDadosPadroes.CDSDadosPadroesVALOR1.AsString + '|' +
                  FDadosPadroes.CDSDadosPadroesVALOR2.AsString
                  );
    FDadosPadroes.CDSDadosPadroes.Next;
  end;
  FDadosPadroes.CDSDadosPadroes.First;
  FDadosPadroes.CDSDadosPadroes.EnableControls;

  // grava arquivo TXT com os dados das consultas
  ListaDados.SaveToFile(ExtractFilePath(Application.ExeName) + 'T2TiERP_PadraoEmpresa.txt');
  ListaDados.Free;

  // grava arquivo .RC para gerar o .RES
  ConteudoRC := TStringList.Create;
  ConteudoRC.Add('T2TiERP_PadraoEmpresa TXTFILE "T2TiERP_PadraoEmpresa.txt"');
  ConteudoRC.SaveToFile(ExtractFilePath(Application.ExeName) + 'T2TiERP_PadraoEmpresa.RC');

  // cria o arquivo .RES
  Parametros := '/k brcc32 "' + ExtractFilePath(Application.ExeName) + 'T2TiERP_PadraoEmpresa.RC"';
  ShellExecute(Handle, 'open', 'cmd', PChar(Parametros), '', SW_HIDE);

  Application.MessageBox('Arquivo gerado com sucesso.', 'Informa��o do Sistema', MB_OK + MB_ICONINFORMATION);
end;
{$ENDREGION}

{$REGION 'Atualiza SGBD'}
procedure TFT2TiTools.ActionSelecionarArquivoScriptExecute(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    EditArquivoScript.Text := Opendialog1.FileName;
  end;
end;

procedure TFT2TiTools.ActionGerarScriptAlteracaoExecute(Sender: TObject);
var
  ArquivoCarregado, TabelaCarregada: TStringList;
  LinhaQuebrada: TJclStringList;
  H, I, J: Integer;
  NomeTabela, ConsultaSQL: String;
begin
  try
    MemoScriptGerado.Clear;
    MemoScriptGerado.Lines.Add('SET NAMES NONE;');

    Contador := 0;

    ArquivoCarregado := TStringList.Create;
    LinhaQuebrada := TJclStringList.Create;

    if FileExists(EditArquivoScript.Text) then
    begin
      ArquivoCarregado.LoadFromFile(EditArquivoScript.Text);

      for H := 0 to ArquivoCarregado.Count - 1 do
      begin

        TabelaCarregada := CarregarTabelaScript(ArquivoCarregado);

        CDSScript.EmptyDataSet;
        for I := 0 to TabelaCarregada.Count - 1 do
        begin
          //Pega o nome da tabela na primeira linha
          if Copy(TabelaCarregada[I], 1, 12) = 'CREATE TABLE' then
          begin
            NomeTabela := TabelaCarregada[I];
            NomeTabela := StringReplace(NomeTabela, 'CREATE TABLE', '', [rfReplaceAll]);
            NomeTabela := StringReplace(NomeTabela, '(', '', [rfReplaceAll]);
            NomeTabela := Trim(NomeTabela);
          end
          else
          begin
            //Carrega as demais informa��es da tabela
            CDSScript.Append;
            LinhaQuebrada.Split(Trim(TabelaCarregada[I]), ' ', True);

            //Pega o nome do campo na primeira linha
            CDSScript.FieldByName('FIELD').AsString := LinhaQuebrada[0];

            //Pega o tipo de e o tamanho do campo na segunda linha
            if Pos('(', LinhaQuebrada[1]) > 0 then
            begin
              CDSScript.FieldByName('TYPE').AsString := Copy(LinhaQuebrada[1], 1, Pos('(', LinhaQuebrada[1]) - 1);
              CDSScript.FieldByName('LENGTH').AsString := Copy(LinhaQuebrada[1], Pos('(', LinhaQuebrada[1]) + 1, Length(LinhaQuebrada[1]));
              CDSScript.FieldByName('LENGTH').AsString := StringReplace(CDSScript.FieldByName('LENGTH').AsString, ')', '', [rfReplaceAll]);
            end
            else
            begin
              CDSScript.FieldByName('TYPE').AsString := LinhaQuebrada[1];
            end;

            CDSScript.Post;
          end;
        end;


        if TabelaCarregada.Count > 0 then
        begin

          ConsultaSQL :=
                        'SELECT '+
                        '    r.RDB$FIELD_POSITION AS "Pos", ' +
                        '    r.RDB$FIELD_NAME AS "Field", ' +
                        '    CASE f.RDB$FIELD_TYPE '+
                        '       WHEN 261 THEN ' + QuotedStr('BLOB') +
                        '       WHEN 14 THEN ' + QuotedStr('CHAR') +
                        '       WHEN 40 THEN ' + QuotedStr('CSTRING') +
                        '       WHEN 11 THEN ' + QuotedStr('D_FLOAT') +
                        '       WHEN 27 THEN ' + QuotedStr('DOUBLE')+
                        '       WHEN 10 THEN ' + QuotedStr('FLOAT')+
                        '       WHEN 16 THEN ' + QuotedStr('INT64')+
                        '       WHEN 8 THEN ' + QuotedStr('INTEGER')+
                        '       WHEN 9 THEN ' + QuotedStr('QUAD')+
                        '       WHEN 7 THEN ' + QuotedStr('SMALLINT')+
                        '       WHEN 12 THEN ' + QuotedStr('DATE')+
                        '       WHEN 13 THEN ' + QuotedStr('TIME')+
                        '       WHEN 35 THEN ' + QuotedStr('TIMESTAMP')+
                        '       WHEN 37 THEN ' + QuotedStr('VARCHAR')+
                        '       ELSE ' + QuotedStr('UNKNOWN')+
                        '     END AS "Type", ' +
                        '     f.RDB$FIELD_LENGTH AS "Length", ' +
                        '     f.RDB$FIELD_PRECISION AS "Precision", ' +
                        '     f.RDB$FIELD_SCALE AS "Scale", ' +
                        '     CASE WHEN r.RDB$NULL_FLAG = 1 THEN ' + QuotedStr('NO') +' ELSE ' + QuotedStr('YES') +' END AS "Null"' +
                        '     FROM RDB$RELATION_FIELDS r '+
                        '     LEFT JOIN RDB$FIELDS f ON r.RDB$FIELD_SOURCE = f.RDB$FIELD_NAME '+
                        '     LEFT JOIN RDB$INDEX_SEGMENTS s ON s.RDB$FIELD_NAME=r.RDB$FIELD_NAME '+
                        '     LEFT JOIN RDB$INDICES i ON i.RDB$INDEX_NAME = s.RDB$INDEX_NAME '+
                        '          AND i.RDB$RELATION_NAME=r.RDB$RELATION_NAME '+
                        '     LEFT JOIN RDB$RELATION_CONSTRAINTS rc ON rc.RDB$INDEX_NAME = s.RDB$INDEX_NAME '+
                        '          AND rc.RDB$INDEX_NAME = i.RDB$INDEX_NAME '+
                        '          AND rc.RDB$RELATION_NAME = i.RDB$RELATION_NAME '+
                        '     LEFT JOIN RDB$REF_CONSTRAINTS refc ON rc.RDB$CONSTRAINT_NAME = refc.RDB$CONSTRAINT_NAME '+
                        '     WHERE r.RDB$RELATION_NAME=' + QuotedStr(NomeTabela) +
                        '     GROUP BY '+
                        '        "Pos", '+
                        '        "Field", '+
                        '        "Type", '+
                        '        "Length", '+
                        '        "Precision", '+
                        '        "Scale", '+
                        '        "Null" '+
                        '     ORDER BY "Pos"; ';

          //Consulta dados no Banco
          SQLQuery.Active := False;
          SQLQuery.SQL.Clear;
          SQLQuery.SQL.Add(ConsultaSQL);
          SQLQuery.Active := True;
          CDSBanco.Active := False;
          CDSBanco.Active := True;

          //Realiza as compara��es e cria o Script
          CDSScript.First;
          while not CDSScript.Eof do
          begin
            // Se o campo for ID ignora
            // Se o campo for Integer, vamos ignorar tamb�m. Campos INTEGER tem o mesmo tamanho e n�o sofrem altera��o. Qual o problema?
            // Ignorar campos DECIMAL. Mesmo princ�pio do INTEGER. Algum problema?
            // Ignorar campos TEXT. No firebird s�o VARCHAR com Domain TEXT. Pode-se fazer uma verifica��o. Fica a cargo do participante.
            if (CDSScript.FieldByName('FIELD').AsString = 'ID')
                or (Pos('INTEGER', CDSScript.FieldByName('TYPE').AsString) > 0)
                or (Pos('DECIMAL', CDSScript.FieldByName('TYPE').AsString) > 0)
                or (Pos('TEXT', CDSScript.FieldByName('TYPE').AsString) > 0) then
            begin
              CDSScript.Next;
            end
            else
            begin
              // Localiza o campo no banco de dados e verifica se existe alguma altera��o. Se n�o localizar o campo, cria um novo no BD.
              if not CDSBanco.Locate('Field', CDSScript.FieldByName('FIELD').AsString, [loCaseInsensitive]) then
              begin
                MemoScriptGerado.Lines.Add('ALTER TABLE ' + NomeTabela + ' ADD ' + CDSScript.FieldByName('FIELD').AsString +
                                           ' ' + CDSScript.FieldByName('TYPE').AsString + '(' + CDSScript.FieldByName('LENGTH').AsString + ');');
                CDSScript.Next;
              end
              else
              begin
                if Trim(UpperCase(CDSBanco.FieldByName('LENGTH').AsString)) <> Trim(UpperCase(CDSScript.FieldByName('LENGTH').AsString)) then
                begin
                MemoScriptGerado.Lines.Add('ALTER TABLE ' + NomeTabela + ' ALTER ' + CDSScript.FieldByName('FIELD').AsString +
                                           ' TYPE ' + CDSScript.FieldByName('TYPE').AsString + '(' + CDSScript.FieldByName('LENGTH').AsString + ');');
                  CDSScript.Next;
                end
                else
                begin
                  CDSScript.Next;
                end;
              end;
            end;
          end;

        end;

      end;

    end
    else
    begin
      Application.MessageBox('Selecione o arquivo de Script gerado no DBDesigner.', 'Informa��o do Sistema', MB_OK + MB_ICONINFORMATION);
      EditArquivoScript.SetFocus;
    end;
  finally
  end;
end;

function TFT2TiTools.CarregarTabelaScript(pArquivoCarregado: TStringList): TStringList;
begin
  try
    Result := TStringList.Create;

    if Contador <> 0 then
      Contador := Contador + 3;

    if Contador >= pArquivoCarregado.Count then
      Exit;

    while (Trim(pArquivoCarregado[Contador]) <> ')') do
    begin
      Result.Add(pArquivoCarregado[Contador]);
      Inc(Contador);
    end;

  finally

  end;
end;

procedure TFT2TiTools.ActionGerarArquivoAtualizaBDExecute(Sender: TObject);
begin
  try
    MemoScriptGerado.Lines.SaveToFile(ExtractFilePath(Application.ExeName) + 'atualiza.sql');
    Application.MessageBox('Arquivo gerado com sucesso.', 'Informa��o do Sistema', MB_OK + MB_ICONINFORMATION);
  finally

  end;
end;
{$ENDREGION}

end.


{
C�digo de atualiza��o do banco de dados para o MySQL

procedure TFT2TiTools.ActionGerarScriptAlteracaoExecute(Sender: TObject);
var
  ArquivoCarregado, TabelaCarregada: TStringList;
  LinhaQuebrada: TJclStringList;
  H, I, J: Integer;
  NomeTabela: String;
begin
  try
    MemoScriptGerado.Clear;
    MemoScriptGerado.Lines.Add('use t2tierp;');

    Contador := 0;

    ArquivoCarregado := TStringList.Create;
    LinhaQuebrada := TJclStringList.Create;

    if FileExists(EditArquivoScript.Text) then
    begin
      ArquivoCarregado.LoadFromFile(EditArquivoScript.Text);

      for H := 0 to ArquivoCarregado.Count - 1 do
      begin

        TabelaCarregada := CarregarTabelaScript(ArquivoCarregado);

        CDSScript.EmptyDataSet;
        for I := 0 to TabelaCarregada.Count - 1 do
        begin
          //Pega o nome da tabela na primeira linha
          if Copy(TabelaCarregada[I], 1, 12) = 'CREATE TABLE' then
          begin
            NomeTabela := TabelaCarregada[I];
            NomeTabela := StringReplace(NomeTabela, 'CREATE TABLE', '', [rfReplaceAll]);
            NomeTabela := StringReplace(NomeTabela, '(', '', [rfReplaceAll]);
            NomeTabela := Trim(NomeTabela);
          end
          else
          begin
            //Carrega as demais informa��es da tabela
            CDSScript.Append;
            LinhaQuebrada.Split(Trim(TabelaCarregada[I]), ' ', True);
            for J := 0 to LinhaQuebrada.Count - 2 do
            begin

              //Pega o nome do campo na primeira linha
              if J = 0 then
              begin
                CDSScript.FieldByName('FIELD').AsString := LinhaQuebrada[J];
              end
              else
              begin
                CDSScript.FieldByName('TYPE').AsString := CDSScript.FieldByName('TYPE').AsString + ' ' + LinhaQuebrada[J];
              end;

            end;
            CDSScript.Post;
          end;
        end;


        if TabelaCarregada.Count > 0 then
        begin

          //Consulta dados no Banco
          SQLQuery.Active := False;
          SQLQuery.SQL.Clear;
          SQLQuery.SQL.Add('SHOW COLUMNS from ' + NomeTabela);
          SQLQuery.Active := True;
          CDSBanco.Active := False;
          CDSBanco.Active := True;

          //Realiza as compara��es e cria o Script
          CDSScript.First;
          while not CDSScript.Eof do
          begin
            // Se o campo for ID ignora
            // Se o campo for Integer, vamos ignorar tamb�m. Campos INTEGER tem o mesmo tamanho e n�o sofrem altera��o. Qual o problema?
            if (CDSScript.FieldByName('FIELD').AsString = 'ID') or (Pos('INTEGER', CDSScript.FieldByName('TYPE').AsString) > 0) then
            begin
              CDSScript.Next;
            end
            else
            begin
              // Localiza o campo no banco de dados e verifica se existe alguma altera��o. Se n�o localizar o campo, cria um novo no BD.
              if not CDSBanco.Locate('Field', CDSScript.FieldByName('FIELD').AsString, [loCaseInsensitive]) then
              begin
                MemoScriptGerado.Lines.Add('ALTER TABLE ' + NomeTabela + ' ADD ' + CDSScript.FieldByName('FIELD').AsString + ' ' + CDSScript.FieldByName('TYPE').AsString + ';');
                CDSScript.Next;
              end
              else
              begin
                if Trim(UpperCase(CDSBanco.FieldByName('Type').AsString)) <> Trim(UpperCase(CDSScript.FieldByName('TYPE').AsString)) then
                begin
                  MemoScriptGerado.Lines.Add('ALTER TABLE ' + NomeTabela + ' CHANGE ' + CDSScript.FieldByName('FIELD').AsString +
                                             ' ' + CDSScript.FieldByName('FIELD').AsString + ' ' + CDSScript.FieldByName('TYPE').AsString + ';');
                  CDSScript.Next;
                end
                else
                begin
                  CDSScript.Next;
                end;
              end;
            end;
          end;

        end;

      end;

    end
    else
    begin
      Application.MessageBox('Selecione o arquivo de Script gerado no DBDesigner.', 'Informa��o do Sistema', MB_OK + MB_ICONINFORMATION);
      EditArquivoScript.SetFocus;
    end;
  finally
  end;
end;


}
