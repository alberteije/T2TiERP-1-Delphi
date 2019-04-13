unit SessaoUsuario;

interface

uses Classes, DSHTTP, Biblioteca, UsuarioVO, Forms, Windows;

type
  TSessaoUsuario = class
  private
    FIdSessao: string;
    FUsuario: TUsuarioVO;

    class var FInstance: TSessaoUsuario;
  public
    constructor Create;
    destructor Destroy;
    class function Instance: TSessaoUsuario;
    function AutenticaUsuario(pLogin, pSenha: string): Boolean;
    property IdSessao: string read FIdSessao;
    property Usuario: TUsuarioVO read FUsuario;
  end;

implementation

uses UsuarioController;

{ TSessaoUsuario }

constructor TSessaoUsuario.Create;
begin
  inherited Create;
end;

destructor TSessaoUsuario.Destroy;
begin


  inherited;
end;

class function TSessaoUsuario.Instance: TSessaoUsuario;
begin
  if not Assigned(FInstance) then
    FInstance := TSessaoUsuario.Create;

  Result := FInstance;
end;

function TSessaoUsuario.AutenticaUsuario(pLogin, pSenha: string): Boolean;
begin
  try
    FUsuario := TUsuarioController.Usuario(pLogin,pSenha);
    Result := Assigned(FUsuario);
  except
    Application.MessageBox('Erro ao Autenticar Usuário!','Erro de Login',
      MB_OK+MB_ICONERROR);
    raise;
  end;
end;

end.
