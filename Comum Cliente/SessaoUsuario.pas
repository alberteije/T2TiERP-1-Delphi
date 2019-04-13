unit SessaoUsuario;

interface

uses Classes, DSHTTP, Biblioteca, UsuarioVO, Forms, Windows, IniFiles, SysUtils,
  Generics.Collections, FuncaoVO, EmpresaSessaoVO;

type
  TServidorImpressao = class
  private
    FServidor: String;
    FPorta: Integer;
    FUsuario: String;
    FSenha: String;
    FAlias: String;
  public
    constructor Create;
    destructor Destroy; override;

    property Servidor: String read FServidor;
    property Porta: Integer read FPorta;
    property Usuario: String read FUsuario;
    property Senha: String read FSenha;
    property Alias: String read FAlias;
  end;

  TSessaoUsuario = class
  private
    FHttp: TDSHTTP;
    FUrl: String;
    FIdSessao: String;
    FUsuario: TUsuarioVO;
    FEmpresa: TEmpresaSessaoVO;
    FIdEmpresa: Integer;
    ListaPermissoes: TObjectList<TFuncaoVO>;
    FServidorImpressao: TServidorImpressao;

    class var FInstance: TSessaoUsuario;
  public
    constructor Create;
    destructor Destroy; override;

    class function Instance: TSessaoUsuario;

    function AutenticaUsuario(pLogin, pSenha: String): Boolean;
    function AutenticaUsuarioAdm(pLogin, pSenha: String): Boolean;

    //Permissões
    procedure AtualizaPermissoes;
    function TemAcesso(pFormulario, pNome: String): Boolean;
    function Autenticado: Boolean;

    property HTTP: TDSHTTP read FHttp;
    property URL: String read FUrl;
    property IdSessao: String read FIdSessao;
    property Usuario: TUsuarioVO read FUsuario;
    property Empresa: TEmpresaSessaoVO read FEmpresa write FEmpresa;
    property IdEmpresa: Integer read FIdEmpresa write FIdEmpresa;
    property ServidorImpressao: TServidorImpressao read FServidorImpressao;
  end;

implementation

uses UsuarioController, FuncaoController, EmpresaController;
{ TSessaoUsuario }

constructor TSessaoUsuario.Create;
var
  Ini: TIniFile;
  Servidor: String;
  Porta: Integer;
begin
  inherited Create;

  FServidorImpressao := TServidorImpressao.Create;

  FHttp := TDSHTTP.Create;

  Ini := TIniFile.Create(CaminhoApp + 'Conexao.ini');
  try
    with Ini do
    begin
      if not SectionExists('ServidorApp') then
      begin
        WriteString('ServidorApp','Servidor','localhost');
        WriteInteger('ServidorApp','Porta',8080);
      end;

      Servidor := ReadString('ServidorApp','Servidor','localhost');
      Porta := ReadInteger('ServidorApp','Porta',8080);
    end;
  finally
    Ini.Free;
  end;

  FUrl := 'http://'+Servidor+':'+IntToStr(Porta)+'/datasnap/restT2Ti/';

  ListaPermissoes := TObjectList<TFuncaoVO>.Create;
end;

destructor TSessaoUsuario.Destroy;
begin
  FHttp.Free;

  if Assigned(FUsuario) then
    FUsuario.Free;

  if Assigned(FEmpresa) then
    FEmpresa.Free;

  if Assigned(ListaPermissoes) then
    ListaPermissoes.Free;

  inherited;
end;

class function TSessaoUsuario.Instance: TSessaoUsuario;
begin
  if not Assigned(FInstance) then
    FInstance := TSessaoUsuario.Create;

  Result := FInstance;
end;

procedure TSessaoUsuario.AtualizaPermissoes;
begin
  ListaPermissoes.Free;

  //se o usuário tem acesso completo, não precisa carregar as funções
  if Usuario.PapelVO.AcessoCompleto <> 'S' then
    ListaPermissoes := TFuncaoController.FuncoesUsuario
  else
    ListaPermissoes := TObjectList<TFuncaoVO>.Create;
end;

function TSessaoUsuario.Autenticado: Boolean;
begin
  Result := Assigned(FUsuario);
end;

function TSessaoUsuario.TemAcesso(pFormulario, pNome: String): Boolean;
var
  Enumerator: TEnumerator<TFuncaoVO>;
begin
  Result := False;

  //se o usuário tiver acesso completo já retorna True
  if Usuario.PapelVO.AcessoCompleto = 'S' then
  begin
    Result := True
  end
  else
  begin
    Enumerator := ListaPermissoes.GetEnumerator;
    try
      //with ListaPermissoes.GetEnumerator do
      with Enumerator do
      begin
        while MoveNext do
        begin
          if (Current.Formulario = pFormulario) and (Current.Nome = pNome) then
          begin
            Result := (Current.Habilitado = 'S');
            Break;
          end;
        end;
      end;
    finally
      Enumerator.Free;
    end;
  end;
end;

function TSessaoUsuario.AutenticaUsuario(pLogin, pSenha: String): Boolean;
var
  SenhaCript: String;
begin
  FIdSessao := CriaGuidStr;
  FIdSessao := MD5String(FIdSessao);
  try
    //Senha é criptografada com a senha digitada + login
    SenhaCript := TUsuarioController.CriptografarLoginSenha(pLogin,pSenha);

    FHttp.SetBasicAuthentication(pLogin+'|'+FIdSessao,SenhaCript);

    FUsuario := TUsuarioController.Usuario(pLogin,pSenha);
    FUsuario.Senha := pSenha;

    Result := Assigned(FUsuario);
  except
    Application.MessageBox('Erro ao autenticar usuário.','Erro de Login', MB_OK+MB_ICONERROR);
    raise;
  end;

  if Result then
  begin
    AtualizaPermissoes;
  end;
end;

function TSessaoUsuario.AutenticaUsuarioAdm(pLogin, pSenha: String): Boolean;
var
  ConexaoIni: TIniFile;
  SenhaCript: String;
begin
  Result := False;
  FIdSessao := CriaGuidStr;
  FIdSessao := MD5String(FIdSessao);
  try
    try
      ConexaoIni := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'Conexao.ini');

      with ConexaoIni do
      begin
        if (Codifica('D', trim(ReadString('Adm', 'Login', ''))) = pLogin) and
           (Codifica('D', trim(ReadString('Adm', 'Senha', ''))) = pSenha)  then
        begin
          SenhaCript := TUsuarioController.CriptografarLoginSenha(pLogin,pSenha);
          FHttp.SetBasicAuthentication(pLogin+'|'+FIdSessao,SenhaCript);
          FUsuario := TUsuarioController.Usuario(pLogin, pSenha);
          Result := True;
        end;
      end;
    except
      Application.MessageBox('Problemas na autenticação do Administrador.', 'Informação do Sistema', MB_OK + MB_ICONERROR);
    end;
  finally
    ConexaoIni.Free;
  end;
end;

{ TServidorImpressao }

constructor TServidorImpressao.Create;
var
  Ini: TIniFile;
begin
  inherited Create;

  Ini := TIniFile.Create(CaminhoApp + 'Conexao.ini');
  try
    with Ini do
    begin
      if not SectionExists('ServidorImpressao') then
      begin
        WriteString('ServidorImpressao','Servidor','localhost');
        WriteString('ServidorImpressao','Porta','3060');
        WriteString('ServidorImpressao','Usuario','Admin');
        WriteString('ServidorImpressao','Senha','');
        WriteString('ServidorImpressao','Alias','T2Ti');
      end;

      FServidor := ReadString('ServidorImpressao','Servidor','localhost');
      FPorta := ReadInteger('ServidorImpressao','Porta',3060);
      FUsuario := ReadString('ServidorImpressao','Usuario','Admin');
      FSenha := ReadString('ServidorImpressao','Senha','');
      FAlias := ReadString('ServidorImpressao','Alias','T2Ti');
    end;
  finally
    Ini.Free;
  end;
end;

destructor TServidorImpressao.Destroy;
begin
  inherited;
end;

end.
