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

@author Albert Eije (T2Ti.COM) | José Rodrigues | Gilson Lima
@version 1.0
*******************************************************************************}
unit UDataModule;

interface

uses
SysUtils, Forms, ACBrBase, ACBrECF, DBXMySql, FMTBcd,
DBClient, DB, SqlExpr, Classes, WideStrings, StdCtrls, Controls,
Windows, ACBrPAF,
ACBrSpedFiscal, ACBrSintegra, Dialogs,
Inifiles, SWSystem, DBXFirebird, DBXMsSQL, ACBrECFClass;

type
  TFDataModule = class(TDataModule)
    Conexao: TSQLConnection;
    ACBrECF: TACBrECF;
    ACBrPAF: TACBrPAF;
    ACBrSintegra: TACBrSintegra;
    ACBrSPEDFiscal: TACBrSPEDFiscal;
    ConexaoBalcao: TSQLConnection;
    CDSNF: TClientDataSet;
    DSNF: TDataSource;
    procedure ACBrECFMsgPoucoPapel(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
    procedure CDSNFBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
    RemoteAppPath, BancoPAF: String;
    EmpresaID, QuantidadeECF: Integer;
    function ConectaBalcao():Boolean;
  end;

var
  FDataModule: TFDataModule;

implementation

uses UConfigConexao, USplash, Biblioteca, UNotaFiscal;

{$R *.dfm}

procedure TFDataModule.ACBrECFMsgPoucoPapel(Sender: TObject);
begin
//
end;

procedure TFDataModule.CDSNFBeforePost(DataSet: TDataSet);
begin
  FNotaFiscal.GridItens.Columns[3].ReadOnly := False;
  CDSNF.FieldByName('VALOR_TOTAL').AsFloat := CDSNF.FieldByName('VALOR_UNITARIO').AsFloat * CDSNF.FieldByName('QUANTIDADE').AsFloat;
  FNotaFiscal.GridItens.Columns[3].ReadOnly := True;
  FNotaFiscal.Soma;
end;

function TFDataModule.ConectaBalcao: Boolean;
var
  Parametros: TStrings;
  BancoBalcao, Arquivo: String;
  ini: TIniFile;
begin
  Parametros := TStringList.Create;
  ConexaoBalcao.Connected := False;

  try
    ini := TIniFile.Create(ExtractFilePath(Application.ExeName)+'Conexao.ini');
    BancoBalcao := UpperCase(ini.ReadString('SGBD','BDBalcao',''));
  finally
    FreeAndNil(ini);
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
  FreeAndNil(Parametros);
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
  Arquivo : String;
  Parametros: TStrings;
begin
  FSplash.lbMensagem.Caption := 'Conectando a Base de Dados...';
  FSplash.lbMensagem.Refresh;

  Conexao.Connected := False;

  try
    ini := TIniFile.Create(ExtractFilePath(Application.ExeName)+'Conexao.ini');
    BancoPAF := UpperCase(ini.ReadString('SGBD','BD',''));
    RemoteAppPath := UpperCase(ini.ReadString('IMPORTA','REMOTEAPP',''));
    EmpresaID := StrToIntDef(ini.ReadString('ECFS','EMPRESA',''),1);
    QuantidadeECF := StrToIntDef(ini.ReadString('ECFS','QUANTIDADE',''),1);
  finally
     FreeAndNil(ini);
  end;

  if BancoPAF = 'MYSQL' then
  begin
    Arquivo := gsAppPath + 'MySQL_DBExpress_conn.txt';
    Conexao.DriverName     := 'MySQL';
    Conexao.ConnectionName := 'MySQLConnection';
    Conexao.GetDriverFunc  := 'getSQLDriverMYSQL';
    Conexao.LibraryName    := 'dbxmys.dll';
    Conexao.VendorLib      := 'libmysql.dll';
  end
  else if BancoPAF = 'FIREBIRD' then
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

  FreeAndNil(Parametros);

  try
    FSplash.Repaint;
    Conexao.Connected := True;
    FSplash.lbMensagem.Caption := 'Conectando a Base de Dados local...';
    FSplash.lbMensagem.Refresh;
    FSplash.imgBanco.Visible := True;
    //SetTaskBar(false); //descomente se quiser que a barra do windows desapareça

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
    FSplash.lbMensagem.Caption := 'Falha ao tentar conectar a Base de Dados';
    FSplash.lbMensagem.Refresh;

    Application.CreateForm(TFConfigConexao, FConfigConexao);
    if FConfigConexao.ShowModal <> mrOK then
    begin
      SetTaskBar(true);
      ACBrECF.Desativar;
      Application.ProcessMessages;
      Application.Terminate;
    end  else
    begin
      SetTaskBar(false);
      FSplash.imgBanco.visible := true;
    end;
  end;
end;

end.
