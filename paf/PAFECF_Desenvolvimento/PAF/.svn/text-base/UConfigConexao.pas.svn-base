{*******************************************************************************
Title: T2Ti ERP
Description: Configuração de acesso aos Bancos de Dados.

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

@author Albert Eije (T2Ti.COM) | Gilson Santos Lima
@version 1.0
*******************************************************************************}

unit UConfigConexao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, JvExStdCtrls, JvButton, JvCtrls, JvExButtons,
  JvBitBtn, pngimage, ExtCtrls, Mask, JvComponentBase, JvEnterTab,
  JvExMask, JvToolEdit,  SWSystem, IniFiles, jpeg, ComCtrls;

type
  TFConfigConexao = class(TForm)
    Image1: TImage;
    botaoConfirma: TJvBitBtn;
    botaoCancela: TJvImgBtn;
    JvEnterAsTab1: TJvEnterAsTab;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    GroupBox1: TGroupBox;
    botaoTestaLocal: TSpeedButton;
    Label2: TLabel;
    imgFirebird: TImage;
    Label3: TLabel;
    Label1: TLabel;
    imgMySQL: TImage;
    rdgTpConexaoLocal: TRadioGroup;
    edtServidorLocal: TEdit;
    edtCaminhoLocal: TJvFilenameEdit;
    cbxBanco: TComboBox;
    GroupBox2: TGroupBox;
    botaoTestarBalcao: TSpeedButton;
    Label4: TLabel;
    imgFireBirdBalcao: TImage;
    Label5: TLabel;
    Label6: TLabel;
    imgMySQLBalcao: TImage;
    rdgTpConexaoBalcao: TRadioGroup;
    edtServidorBalcao: TEdit;
    edtCaminhoBalcao: TJvFilenameEdit;
    cbxBancoBalcao: TComboBox;
    procedure rdgTpConexaoLocalClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure botaoTestaLocalClick(Sender: TObject);
    procedure botaoConfirmaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure botaoCancelaClick(Sender: TObject);
    procedure botaoTestarBalcaoClick(Sender: TObject);
    procedure rdgTpConexaoBalcaoClick(Sender: TObject);
    procedure cbxBancoBalcaoSelect(Sender: TObject);
    procedure cbxBancoSelect(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FConfigConexao: TFConfigConexao;
  Banco: string;
  BancoBalcao: string;

implementation

uses UDataModule;

{$R *.dfm}

procedure TFConfigConexao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  FConfigConexao := Nil;
end;

procedure TFConfigConexao.FormCreate(Sender: TObject);
var
  Arquivo, sAux,
  BaseDados, Caminho, Servidor,
  BaseDadosBalcao, CaminhoBalcao, ServidorBalcao: String;
  i: Integer;
  Parametros: TStrings;
  ini: TIniFile;
begin
  PageControl1.TabIndex := 0;
  try
    ini := TIniFile.Create(ExtractFilePath(Application.ExeName)+'Conexao.ini');
    Banco := UpperCase(ini.ReadString('SGBD','BD',''));
    BancoBalcao := UpperCase(ini.ReadString('SGBD','BDBalcao',''));
  finally
    ini.Free;
  end;

  if Banco = 'FIREBIRD' then
  begin
    Arquivo := gsAppPath + 'Firebird_DBExpress_conn.txt';
    imgFirebird.Visible := True;
    imgFirebird.BringToFront;
  end
  else if Banco = 'MYSQL' then
  begin
    Arquivo := gsAppPath + 'MySQL_DBExpress_conn.txt';
    imgMysql.Visible := True;
    imgMySQL.BringToFront;
  end;

  Parametros := TStringList.Create;

  try
    Parametros.LoadFromFile(Arquivo);
    for i := 0 to Pred(Parametros.Count) do
    begin
      sAux := Parametros[i];
      if Banco = 'FIREBIRD' then
      begin
        if Pos('Database=',sAux) = 1 then
          BaseDados := sAux;
      end
      else if Banco = 'MYSQL' then
      begin
        if Pos('HostName=',sAux) = 1  then
          Servidor := sAux;
        if Pos('Database=',sAux) = 1  then
          BaseDados := sAux;
      end;//if Banco = 'FIREBIRD' then
    end;//for i := 0 to Pred(Parametros.Count) do

    if BancoBalcao = 'FIREBIRD' then
    begin
      Arquivo := gsAppPath + 'Firebird_Balcao_conn.txt';
      imgFireBirdBalcao.Visible := True;
      imgFireBirdBalcao.BringToFront;
    end
    else if BancoBalcao = 'MYSQL' then
    begin
      Arquivo := gsAppPath + 'MySQL_Balcao_conn.txt';
      imgMySQLBalcao.Visible := True;
      imgMySQLBalcao.BringToFront;
    end;

    //carrega Arquivo para conexao ao Balcão
    sAux := '';
    Parametros.LoadFromFile(Arquivo);
    for i := 0 to Pred(Parametros.Count) do
    begin
      sAux := Parametros[i];
      if BancoBalcao = 'FIREBIRD' then
      begin
        if Pos('Database=',sAux) = 1  then
          BaseDadosBalcao := sAux;
      end
      else if BancoBalcao = 'MYSQL' then
      begin
        if Pos('HostName=',sAux) = 1  then
          ServidorBalcao := sAux;
        if Pos('Database=',sAux) = 1  then
          BaseDadosBalcao := sAux;
      end;//if BancoBalcao = 'FIREBIRD' then
    end;//for i := 0 to Pred(Parametros.Count) do
  finally
    FreeAndNil(Parametros);
  end;

  /// Configura edits para Conexao Local
  if Banco = 'FIREBIRD' then
  begin
    i := 0;
    sAux := BaseDados;
    while Pos( ':', sAux) <> 0 do
    begin
      delete(sAux,pos(':', sAux),1);
      Inc(i);
    end;

    if i > 1 then
    begin
      Servidor := copy(BaseDados, pos('=', BaseDados) + 1, pos(':', BaseDados) - pos('=', BaseDados)-1);
      Caminho  := copy(BaseDados, pos(':', BaseDados) + 1, length(trim(BaseDados)));
    end
    else
    begin
      Servidor := 'localhost';
      Caminho  := copy(BaseDados, pos('=', BaseDados) + 1, length(trim(BaseDados)));
    end;
  end;

  if Banco = 'MYSQL' then
  begin
    Delete(Servidor,1,pos('=',Servidor));
    delete(BaseDados,1,pos('=',BaseDados));
    Caminho := BaseDados;
  end;

  for i := 0 to cbxBanco.Items.Count - 1 do
  begin
    if cbxBanco.Items[i] = Banco then
    begin
      cbxBanco.ItemIndex := i;
      break;
    end;
  end;

  edtServidorLocal.Text := Servidor;
  edtCaminhoLocal.Text  := Caminho;

  //Configura edits para Conexao Balcao
  if BancoBalcao = 'FIREBIRD' then
  begin
    i := 0;
    sAux := BaseDadosBalcao;
    while Pos( ':', sAux) <> 0 do
    begin
      delete(sAux,pos(':', sAux),1);
      Inc(i);
    end;

    if i > 1 then
    begin
      ServidorBalcao := copy(BaseDadosBalcao, pos('=', BaseDadosBalcao) + 1, pos(':', BaseDadosBalcao) - pos('=', BaseDadosBalcao)-1);
      CaminhoBalcao  := copy(BaseDadosBalcao, pos(':', BaseDadosBalcao) + 1, length(trim(BaseDadosBalcao)));
    end
    else
    begin
      ServidorBalcao := 'localhost';
      CaminhoBalcao  := copy(BaseDadosBalcao, pos('=', BaseDadosBalcao) + 1, length(trim(BaseDadosBalcao)));
    end;
  end;

  if BancoBalcao = 'MYSQL' then
  begin
    Delete(ServidorBalcao,1,pos('=',ServidorBalcao));
    Delete(BaseDadosBalcao,1,pos('=',BaseDadosBalcao));
    CaminhoBalcao := BaseDadosBalcao;
  end;

  for i := 0 to cbxBancoBalcao.Items.Count - 1 do
  begin
    if cbxBancoBalcao.Items[i] = BancoBalcao then
    begin
      cbxBancoBalcao.ItemIndex := i;
      break;
    end;
  end;

  edtServidorBalcao.Text := ServidorBalcao;
  edtCaminhoBalcao.Text  := CaminhoBalcao;
end;

procedure TFConfigConexao.rdgTpConexaoBalcaoClick(Sender: TObject);
begin
  if rdgTpConexaoBalcao.ItemIndex = 0 then
  begin
    edtServidorBalcao.Enabled := False;
    edtServidorBalcao.Text := 'localhost';
  end
  else
  begin
    edtServidorBalcao.Enabled := True;
  end;
end;

procedure TFConfigConexao.rdgTpConexaoLocalClick(Sender: TObject);
begin
  if rdgTpConexaoLocal.ItemIndex = 0 then
  begin
    edtServidorLocal.Enabled := False;
    edtServidorLocal.Text := 'localhost';
  end
  else
  begin
    edtServidorLocal.Enabled := True;
  end;
end;

procedure TFConfigConexao.botaoCancelaClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TFConfigConexao.botaoConfirmaClick(Sender: TObject);
var
  i: Integer;
  Arquivo, sAux: String;
  Parametros: TStrings;
  ini: TIniFile;
begin
  if trim(edtServidorLocal.Text) = '' then
  begin
    Application.MessageBox('Informe o Nome ou IP do Servidor!', 'Informação do Sistema', MB_OK + MB_ICONWARNING);
    edtServidorLocal.SetFocus;
    exit;
  end;

  if trim(edtCaminhoLocal.Text) = '' then
  begin
    Application.MessageBox('Informe o caminho do banco de dados!', 'Informação do Sistema', MB_OK + MB_ICONWARNING);
    edtCaminhoLocal.SetFocus;
    exit;
  end;

  if cbxBanco.Text = 'MYSQL' then
    Arquivo := gsAppPath + 'MySQL_DBExpress_conn.txt'
  else
  if cbxBanco.Text = 'FIREBIRD' then
    Arquivo := gsAppPath + 'Firebird_DBExpress_conn.txt';


  try
    Parametros := TStringList.Create;
    Parametros.LoadFromFile(Arquivo);

    for i := 0 to Pred(Parametros.Count) do
    begin
      sAux := Parametros[i];
      if cbxBanco.Text = 'FIREBIRD' then
      begin
        if Pos('Database=',sAux) = 1  then
          Parametros[i] := 'Database='+edtServidorLocal.Text+':'+edtCaminhoLocal.Text;
      end
      else if cbxBanco.Text = 'MYSQL' then  // Considenrando que usaremos sempre o usuario e senha "root" e "root"
      begin
        if Pos('HostName=',sAux) = 1  then
          Parametros[i] := 'HostName='+edtServidorLocal.Text;
        if Pos('Database=',sAux) = 1  then
          Parametros[i] := 'Database='+edtCaminhoLocal.Text;
      end;
    end;//for i := 0 to Pred(Parametros.Count) do

    Parametros.SaveToFile(Arquivo);

    if cbxBancoBalcao.Text = 'MYSQL' then
      Arquivo := gsAppPath + 'MySQL_Balcao_conn.txt'
    else
    if cbxBancoBalcao.Text = 'FIREBIRD' then
      Arquivo := gsAppPath + 'Firebird_Balcao_conn.txt';

    Parametros.LoadFromFile(Arquivo);

    for i := 0 to Pred(Parametros.Count) do
    begin
      sAux := Parametros[i];
      if cbxBancoBalcao.Text = 'FIREBIRD' then
      begin
        if Pos('Database=',sAux) = 1  then
          Parametros[i] := 'Database='+edtServidorBalcao.Text+':'+edtCaminhoBalcao.Text;
      end
      else if cbxBancoBalcao.Text = 'MYSQL' then  // Considenrando que usaremos sempre o usuario e senha "root" e "root"
      begin
        if Pos('HostName=',sAux) = 1  then
          Parametros[i] := 'HostName='+edtServidorBalcao.Text;
        if Pos('Database=',sAux) = 1  then
          Parametros[i] := 'Database='+edtCaminhoBalcao.Text;
      end;
    end;//for i := 0 to Pred(Parametros.Count) do

    Parametros.SaveToFile(Arquivo);

    ini := TIniFile.Create(gsAppPath+'Conexao.ini');
    ini.WriteString('SGBD','BD',cbxBanco.Text);
    ini.WriteString('SGBD','BDBalcao',cbxBancoBalcao.Text);

  finally
    FreeAndNil(Parametros);
    FreeAndNil(ini);
  end;

  ModalResult := mrok;
end;

procedure TFConfigConexao.botaoTestaLocalClick(Sender: TObject);
var
  i: Integer;
  sAux, Arquivo: String;
  Parametros: TStrings;
begin

  FDataModule.Conexao.Connected := False;

  if cbxBanco.Text = 'MYSQL' then
  begin
    Arquivo := gsAppPath + 'MySQL_DBExpress_conn.txt';
    FDataModule.Conexao.DriverName     := 'MySQL';
    FDataModule.Conexao.ConnectionName := 'MySQLConnection';
    FDataModule.Conexao.GetDriverFunc  := 'getSQLDriverMYSQL';
    FDataModule.Conexao.LibraryName    := 'dbxmys.dll';
    FDataModule.Conexao.VendorLib      := 'libmysql.dll';
  end
  else if cbxBanco.Text = 'FIREBIRD' then
  begin
    Arquivo := gsAppPath + 'Firebird_DBExpress_conn.txt';
    FDataModule.Conexao.DriverName     := 'Firebird';
    FDataModule.Conexao.ConnectionName := 'FBConnection';
    FDataModule.Conexao.GetDriverFunc  := 'getSQLDriverINTERBASE';
    FDataModule.Conexao.LibraryName    := 'dbxfb.dll';
    FDataModule.Conexao.VendorLib      := 'fbclient.dll';
  end;

  try
    Parametros := TStringList.Create;
    Parametros.LoadFromFile(Arquivo);

    for i := 0 to Pred(Parametros.Count) do
    begin
      sAux := Parametros[i];
      if cbxBanco.Text = 'FIREBIRD' then
      begin
        if Pos('Database=',sAux) = 1  then
          Parametros[i] := 'Database='+edtServidorLocal.Text+':'+edtCaminhoLocal.Text;
      end
      else if cbxBanco.Text = 'MYSQL' then
      begin
        if Pos('HostName=',sAux) = 1  then
          Parametros[i] := 'HostName='+edtServidorLocal.Text;
        if Pos('Database=',sAux) = 1  then
          Parametros[i] := 'Database='+edtCaminhoLocal.Text;
      end;
    end;//for i := 0 to Pred(Parametros.Count) do

    FDataModule.Conexao.Params := Parametros;
  finally
    FreeAndNil(Parametros);
  end;

  try
    FDataModule.Conexao.Connected := True;
    botaoConfirma.Enabled := True;
  except
    raise exception.Create('Falha na Conexão!');
    botaoConfirma.Enabled := False;
  end;

  Application.MessageBox('Conexão realizada com sucesso!', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
end;

procedure TFConfigConexao.botaoTestarBalcaoClick(Sender: TObject);
var
  i: Integer;
  sAux, Arquivo: String;
  Parametros: TStrings;
begin
  FDataModule.ConexaoBalcao.Connected := False;

  if cbxBancoBalcao.Text = 'MYSQL' then
  begin
    Arquivo := gsAppPath + 'MySQL_Balcao_conn.txt';
    FDataModule.ConexaoBalcao.DriverName     := 'MySQL';
    FDataModule.ConexaoBalcao.ConnectionName := 'MySQLConnection';
    FDataModule.ConexaoBalcao.GetDriverFunc  := 'getSQLDriverMYSQL';
    FDataModule.ConexaoBalcao.LibraryName    := 'dbxmys.dll';
    FDataModule.ConexaoBalcao.VendorLib      := 'libmysql.dll';
  end
  else if cbxBancoBalcao.Text = 'FIREBIRD' then
  begin
    Arquivo := gsAppPath + 'Firebird_Balcao_conn.txt';
    FDataModule.ConexaoBalcao.DriverName     := 'Firebird';
    FDataModule.ConexaoBalcao.ConnectionName := 'FBConnection';
    FDataModule.ConexaoBalcao.GetDriverFunc  := 'getSQLDriverINTERBASE';
    FDataModule.ConexaoBalcao.LibraryName    := 'dbxfb.dll';
    FDataModule.ConexaoBalcao.VendorLib      := 'fbclient.dll';
  end;

  try
    Parametros := TStringList.Create;
    Parametros.LoadFromFile(Arquivo);

    for i := 0 to Pred(Parametros.Count) do
    begin
      sAux := Parametros[i];
      if cbxBancoBalcao.Text = 'FIREBIRD' then
      begin
        if Pos('Database=',sAux) <> 0  then
          Parametros[i] := 'Database='+edtServidorBalcao.Text+':'+edtCaminhoBalcao.Text;
      end
      else if cbxBancoBalcao.Text = 'MYSQL' then
      begin
        if Pos('HostName=',sAux) <> 0  then
          Parametros[i] := 'HostName='+edtServidorBalcao.Text;
        if Pos('Database=',sAux) <> 0  then
          Parametros[i] := 'Database='+edtCaminhoBalcao.Text;
      end;
    end;//for i := 0 to Pred(Parametros.Count) do

    FDataModule.ConexaoBalcao.Params := Parametros;
  finally
    FreeAndNil(Parametros);
  end;

  try
    FDataModule.ConexaoBalcao.Connected := True;
    botaoConfirma.Enabled := True;
  except
    raise exception.Create('Falha na Conexão!');
    botaoConfirma.Enabled := False;
  end;

  Application.MessageBox('Conexão realizada com sucesso!', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
end;

procedure TFConfigConexao.cbxBancoBalcaoSelect(Sender: TObject);
begin
  if cbxBancoBalcao.Text = 'MYSQL' then
  begin
    imgMySQLBalcao.Visible := True;
    imgMySQLBalcao.BringToFront;
  end
  else if cbxBancoBalcao.Text = 'FIREBIRD' then
  begin
    imgFireBirdBalcao.Visible := True;
    imgFireBirdBalcao.BringToFront;
  end;
end;

procedure TFConfigConexao.cbxBancoSelect(Sender: TObject);
begin
  if cbxBanco.Text = 'MYSQL' then
  begin
    imgMySQL.Visible := True;
    imgMySQL.BringToFront;
  end
  else if cbxBanco.Text = 'FIREBIRD' then
  begin
    imgFirebird.Visible := True;
    imgFirebird.BringToFront;
  end;
end;

end.
