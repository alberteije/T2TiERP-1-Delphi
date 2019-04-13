{*******************************************************************************
Title: T2Ti ERP
Description: Datamodule.

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
SysUtils, ACBrTEFDClass, Forms, ACBrDevice, ACBrBase, ACBrECF, DBXMySql, FMTBcd,
Provider, DBClient, DB, SqlExpr, Classes, WideStrings, StdCtrls, Controls,
Windows, ACBrUtil, dateutils, strutils, ACBrPAF, ACBrPAF_D, ACBrPAF_E, ACBrPAF_P,
ACBrPAF_R, ACBrPAF_T, ACBrPAFRegistros, ACBrSpedFiscal, ACBrSintegra, Dialogs,
Inifiles, SWSystem, DBXFirebird,DBXMsSQL, ACBrFala, ACBrECFClass;

type
  TFDataModule = class(TDataModule)
    Conexao: TSQLConnection;
    ConexaoBalcao: TSQLConnection;
    StoredProcedure: TSQLStoredProc;
    ACBrECF: TACBrECF;
    procedure ACBrECFMsgPoucoPapel(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    RemoteAppPath, BancoBalcao :string;
    function ConectaBalcao(): Boolean;
  end;

var
  FDataModule: TFDataModule;

implementation

uses UConfigConexao, Biblioteca, USplash;

{$R *.dfm}

procedure TFDataModule.ACBrECFMsgPoucoPapel(Sender: TObject);
begin
//
end;

function TFDataModule.ConectaBalcao: Boolean;
var
  Parametros : TStrings;
  Arquivo: string;
  ini: TIniFile;
begin
  /// Configura conexao com balcao
  Parametros := TStringList.Create;

  ConexaoBalcao.Connected := False;

  try
    ini := TIniFile.Create(ExtractFilePath(Application.ExeName)+'Conexao.ini');
    BancoBalcao := UpperCase(ini.ReadString('SGBD','BDBalcao',''));  // Conexao com Base de Dados do Balcao
  finally
    ini.Free;
  end;

  if BancoBalcao = 'MYSQL' then
  begin
    Arquivo := gsAppPath + 'MySQL_Balcao_conn.txt';
    ConexaoBalcao.DriverName     := 'MySQL';
    ConexaoBalcao.ConnectionName := 'MySQLConnection';
    ConexaoBalcao.GetDriverFunc  := 'getSQLDriverMYSQL';
    ConexaoBalcao.LibraryName    := 'dbxmys.dll';
    ConexaoBalcao.VendorLib      := 'libmysql.dll';
  end
  else if BancoBalcao = 'FIREBIRD' then
  begin
    Arquivo := gsAppPath + 'Firebird_Balcao_conn.txt';
    ConexaoBalcao.DriverName     := 'Firebird';
    ConexaoBalcao.ConnectionName := 'FBConnection';
    ConexaoBalcao.GetDriverFunc  := 'getSQLDriverINTERBASE';
    ConexaoBalcao.LibraryName    := 'dbxfb.dll';
    ConexaoBalcao.VendorLib      := 'fbclient.dll';
  end;

  Parametros.LoadFromFile(Arquivo);
  ConexaoBalcao.Params := Parametros;

  try
    ConexaoBalcao.Connected := True;
    Result := True;
  except
    Result := False;
  end;


end;

procedure TFDataModule.DataModuleCreate(Sender: TObject);
var
	ini: TIniFile;
  Banco, Arquivo: String;
  NSerie_Certificado: string;
  Parametros: TStrings;
begin

  FSplash.lbMensagem.caption := 'Conectando a Base de Dados...';
  FSplash.lbMensagem.Refresh;

  Conexao.Connected := False;

  try
    // o .exe deve ser colocado junto com o pafecf.exe
    ini := TIniFile.Create(ExtractFilePath(Application.ExeName)+'Conexao.ini');
    Banco := UpperCase(ini.ReadString('SGBD','BD',''));
    RemoteAppPath:= UpperCase(ini.ReadString('IMPORTA','REMOTEAPP',''));
  finally
    ini.Free;
  end;

  if Banco = 'MYSQL' then
  begin
    Arquivo := gsAppPath + 'MySQL_DBExpress_conn.txt';
    Conexao.DriverName     := 'MySQL';
    Conexao.ConnectionName := 'MySQLConnection';
    Conexao.GetDriverFunc  := 'getSQLDriverMYSQL';
    Conexao.LibraryName    := 'dbxmys.dll';
    Conexao.VendorLib      := 'libmysql.dll';
  end
  else if Banco = 'FIREBIRD' then
  begin
    Arquivo := gsAppPath + 'Firebird_DBExpress_conn.txt';
    Conexao.DriverName     := 'Firebird';
    Conexao.ConnectionName := 'FBConnection';
    Conexao.GetDriverFunc  := 'getSQLDriverINTERBASE';
    Conexao.LibraryName    := 'dbxfb.dll';
    Conexao.VendorLib      := 'fbclient.dll';
  end;

  Parametros := TStringList.Create;
  Parametros.LoadFromFile(Arquivo);
  Conexao.Params := Parametros;


  try
    FSplash.Repaint;
    Conexao.Connected := True;
    FSplash.lbMensagem.Caption := 'Conectando a Base de Dados local...';
    FSplash.lbMensagem.Refresh;
    FSplash.imgBanco.Visible := True;
  //  SetTaskBar(false); // codigo relocado, necessario comentar o mesmo codigo no FormCreate do FCaixa

    try
      if ConectaBalcao then
      begin
        ConexaoBalcao.Connected := true;
        FSplash.lbMensagem.Caption := 'Conectando ao Balcão...';
        FSplash.lbMensagem.Refresh;
        FSplash.imgBanco.Visible := True;
      end;
    except
      FSplash.lbMensagem.Caption := 'Falha ao conectar ao Balcão';
      FSplash.lbMensagem.Refresh;
      FSplash.imgBanco.Visible := True;
    end;

  except
    Application.MessageBox('Falha ao tentar conectar a Base de Dados.', 'Informação do Sistema', Mb_OK + MB_ICONERROR);
    FSplash.lbMensagem.Caption := 'Falha ao tentar conectar a Base de Dados';
    FSplash.lbMensagem.Refresh;

    Application.CreateForm(TFConfigConexao, FConfigConexao);
    if FConfigConexao.ShowModal <> mrOK then
    begin
      //SetTaskBar(true);
      ACBrECF.Desativar;
      Application.ProcessMessages;
      Application.Terminate;
    end  else
    begin
      //SetTaskBar(false);
      FSplash.imgBanco.visible := true;
    end;
  end;
end;

end.
