{*******************************************************************************
Title: T2Ti ERP
Description: Módulo de dados.

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
@version 1.0
*******************************************************************************}
unit UDataModule;

interface

uses
  SysUtils, Classes, DB, DBClient, Provider, WideStrings, FMTBcd, SqlExpr,
  DBXMySql, DBXMsSQL, Forms, StdCtrls, Controls,Windows,  Dialogs,
  Inifiles, SWSystem, DBXFirebird, ACBrNFe, ACBrNFeDANFEClass, ACBrNFeDANFERave;

type
  TFDataModule = class(TDataModule)
    Conexao: TSQLConnection;
    CDSPV: TClientDataSet;
    DSPV: TDataSource;
    ACBrNFe: TACBrNFe;
    CDSNF: TClientDataSet;
    DSNF: TDataSource;
    ACBrNFeDANFERave: TACBrNFeDANFERave;
    CDSDAV: TClientDataSet;
    DSDAV: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
    procedure CopiaCargaParaPDVs;
  private
    function ConectaBalcao: Boolean;
    { Private declarations }
  public
    RemoteAppPath: String;
    EmpresaID, QuantidadeECF: Integer;
    { Public declarations }
  end;

var
  FDataModule: TFDataModule;

implementation

uses UDAV, UPreVenda, UConfigConexao, UMenu, UNFe, Biblioteca;

{$R *.dfm}

procedure TFDataModule.DataModuleCreate(Sender: TObject);
begin
  if ConectaBalcao then
  begin
    ConfiguraAmbiente;
    Application.CreateForm(TFMenu, FMenu);
    FMenu.ShowModal;
    Application.Run;
  end else
  begin
    Application.CreateForm(TFConfigConexao, FConfigConexao);
    if FConfigConexao.ShowModal <> mrOK then
      Application.Terminate
    else
    begin

      if ConectaBalcao then
      begin
        FreeAndNil(FConfigConexao);
        Application.CreateForm(TFMenu, FMenu);
        FMenu.ShowModal;
        Application.Run;
      end
      else
        Application.Terminate;
    end;
  end;
end;

procedure TFDataModule.CopiaCargaParaPDVs;
var
   LocalAppPath :string;
   i : integer;
begin
  LocalAppPath :=  ExtractFilePath(Application.ExeName)+'Script\Carga.txt';

  if not (DirectoryExists(RemoteAppPath)) then
  begin
    ShowMessage(' Configure corretamente o diretorio de exportação no Conexao.ini');
  end;

  for i := 1 to QuantidadeECF do
  begin
    ForceDirectories(RemoteAppPath+'Caixa'+IntToStr(i));
    if CopyFile(PChar(LocalAppPath), PChar(RemoteAppPath+'Caixa'+IntToStr(i)+'\Carga.txt'),false) then
       Application.ProcessMessages;
  end;

end;

function TFDataModule.ConectaBalcao: Boolean;
var
  Parametros : TStrings;
  BancoBalcao, Arquivo: string;
  ini: TIniFile;
begin
  Parametros := TStringList.Create;
  Conexao.Connected := False;

  try
    if FileExists(gsAppPath+'Conexao.ini') then
    begin
      ini := TIniFile.Create(ExtractFilePath(Application.ExeName)+'Conexao.ini');
      BancoBalcao := UpperCase(ini.ReadString('SGBD','BDBalcao',''));  // Conexao com Base de Dados do Balcao
      RemoteAppPath := UpperCase(ini.ReadString('IMPORTA','REMOTEAPP',''));
      EmpresaID := StrToIntDef(ini.ReadString('ECFS','EMPRESA',''),1);
      QuantidadeECF := StrToIntDef(ini.ReadString('ECFS','QUANTIDADE',''),1);
    end
    else
      Application.MessageBox('Arquivo de inicialização não encontrado: Conexao.ini', 'Erro', MB_OK + MB_ICONERROR);
  finally
    ini.Free;
  end;

  if BancoBalcao = 'MYSQL' then
  begin
    if FileExists(gsAppPath+'MySQL_Balcao_conn.txt') then
    begin
      Arquivo := gsAppPath + 'MySQL_Balcao_conn.txt';
      Conexao.DriverName     := 'MySQL';
      Conexao.ConnectionName := 'MySQLConnection';
      Conexao.GetDriverFunc  := 'getSQLDriverMYSQL';
      Conexao.LibraryName    := 'dbxmys.dll';
      Conexao.VendorLib      := 'libmysql.dll';
    end
    else
      Application.MessageBox('Arquivo de configuração do banco não encontrado: MySQL_Balcao_conn.txt', 'Erro', MB_OK + MB_ICONERROR);
  end
  else if BancoBalcao = 'FIREBIRD' then
  begin
    if FileExists(gsAppPath+'Firebird_Balcao_conn.txt') then
    begin
      Arquivo := gsAppPath + 'Firebird_Balcao_conn.txt';
      Conexao.DriverName     := 'Firebird';
      Conexao.ConnectionName := 'FBConnection';
      Conexao.GetDriverFunc  := 'getSQLDriverINTERBASE';
      Conexao.LibraryName    := 'dbxfb.dll';
      Conexao.VendorLib      := 'fbclient.dll';
    end
    else
      Application.MessageBox('Arquivo de configuração do banco não encontrado: Firebird_Balcao_conn.txt', 'Erro', MB_OK + MB_ICONERROR);
  end;

  Parametros.LoadFromFile(Arquivo);
  Conexao.Params := Parametros;

  try
    Conexao.Connected := True;
    Result := True;
  except
    Result := False;
  end;
end;

end.
