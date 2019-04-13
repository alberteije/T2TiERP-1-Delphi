unit UDataModule;

interface

uses
  SysUtils, Classes, WideStrings, DBXFirebird, Inifiles, DBXMySql, DB, SqlExpr, Forms,
  FMTBcd, Windows;

type
  TFDataModule = class(TDataModule)
    StoredProcedure: TSQLStoredProc;
    ConexaoBalcao: TSQLConnection;
  //  procedure DataModuleCreate(Sender: TObject);
  private

  public
    RemoteAppPath, gsAppPath, QtdeECF, Empresa : String;
    function ConectaBalcao():Boolean;
  end;

var
  FDataModule: TFDataModule;

implementation

uses Atributos, UIntegracaoPDV;



{$R *.dfm}

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
    RemoteAppPath :=  UpperCase(ini.ReadString('IMPORTA','REMOTEAPP',''));
    QtdeECF := UpperCase(ini.ReadString('ECFS','QUANTIDADE','1'));
    Empresa := UpperCase(ini.ReadString('ECFS','EMPRESA','1'));
    gsAppPath := ExtractFilePath(Application.ExeName);

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

{
procedure TFDataModule.DataModuleCreate(Sender: TObject);
var
Hwnd : THandle;
begin

Hwnd := FindWindow(nil, 'PAF-ECF');
// se o Handle e' 0 significa que nao encontrou
if Hwnd <> 0 then
   begin
      FIntegracaoPDV.timeConexao.Enabled := false;
      ConectaBalcao;
      FIntegracaoPDV.TimeIntegracao.Enabled := True;
   end;

    inc(FIntegracaoPDV.conexaoContador);
    FIntegracaoPDV.lConexao.Caption:=IntToStr(FIntegracaoPDV.conexaoContador);


end;
 }
end.
