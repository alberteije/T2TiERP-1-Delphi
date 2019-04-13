{$I ACBr.inc}

unit EmulaBal1;

interface

uses
  synaser, ACBrUtil, 
  SysUtils,
 {$IFDEF Delphi6_UP} Types, {$ELSE} Windows,{$ENDIF}
  Classes, Forms, StdCtrls, Controls, ExtCtrls, ComCtrls ;

type
  TfrEmulador = class(TForm)
    tmVariaPeso: TTimer;
    tmEnviar: TTimer;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label4: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    lEnviado: TLabel;
    Label5: TLabel;
    edBarra: TLabel;
    Label6: TLabel;
    cbxPorta: TComboBox;
    btEnviar: TButton;
    cbModelo: TComboBox;
    cbAutoEnvio: TCheckBox;
    btPesar: TButton;
    cbVariaPeso: TCheckBox;
    btSobrepeso: TButton;
    btInstavel: TButton;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btEnviarClick(Sender: TObject);
    procedure cbxPortaChange(Sender: TObject);
    procedure EnviarToledo;
    procedure btPesarClick(Sender: TObject);
    procedure cbVariaPesoClick(Sender: TObject);
    procedure tmVariaPesoTimer(Sender: TObject);
    procedure tmEnviarTimer(Sender: TObject);
    procedure cbAutoEnvioClick(Sender: TObject);
    procedure EnviarFILIZOLA;
    procedure btSobrepesoClick(Sender: TObject);
    procedure btInstavelClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure conectar;
  private
    { Private declarations }
    fSerial : TBlockSerial ;
    Function Converte( cmd : String) : String;
  public
    { Public declarations }
  end;

var
  frEmulador: TfrEmulador;

implementation

{$R *.dfm}

function TfrEmulador.Converte(cmd: String): String;
var A : Integer ;
begin
  Result := '' ;
  For A := 1 to length( cmd ) do
  begin
    if not (cmd[A] in ['A'..'Z','a'..'z','0'..'9',
                      ' ','.',',','/','?','<','>',';',':',']','[','{','}',
                      '\','|','=','+','-','_',')','(','*','&','^','%','$',
                      '#','@','!','~',']' ]) then
      Result := Result + '#' + IntToStr(ord( cmd[A] )) + ' '
    else
      Result := Result + cmd[A] + ' ';
  end ;
end;

procedure TfrEmulador.FormCreate(Sender: TObject);
begin
  fSerial := TBlockSerial.Create ;
  fSerial.RaiseExcept := true ;
end;

procedure TfrEmulador.btEnviarClick(Sender: TObject);
begin
  conectar;
  fSerial.DeadlockTimeout := 1000 ;
  fSerial.Purge ;                   { Limpa a Porta }

  if cbModelo.Text = 'FILIZOLA' then
  EnviarFILIZOLA else
  if cbModelo.Text = 'TOLEDO' then
  EnviarToledo;
  exit;


  lEnviado.Caption := Converte( edBarra.caption ) ;

end;

procedure TfrEmulador.cbxPortaChange(Sender: TObject);
begin
  if Assigned( fSerial ) then
     if fSerial.InstanceActive then
        fSerial.CloseSocket ;
end;

procedure TfrEmulador.EnviarToledo;
var
  peso : Real;
  PesoS:string;
begin
  peso := strtofloat(edBarra.Caption);
  PesoS:= (#2 + IntToStrZero(Trunc(Peso*1000),5) + #3);
  fSerial.SendString(PesoS);
  lEnviado.Caption := Converte( PesoS ) ;
end;

procedure TfrEmulador.EnviarFILIZOLA;
var
  peso : Real;
  PesoS:string;
begin
  peso := strtofloat(edBarra.Caption);
  PesoS:= IntToStrZero(Trunc(Peso*1000),5);
  fSerial.SendString(PesoS);
  lEnviado.Caption := Converte( PesoS ) ;
end;

procedure TfrEmulador.btPesarClick(Sender: TObject);
var
  peso:Real;
begin
  Randomize;
  peso := random(5000)/1000;
  edBarra.Caption := floattostr(peso);
end;

procedure TfrEmulador.cbVariaPesoClick(Sender: TObject);
begin
  if cbVariaPeso.Checked then
    tmVariapeso.Enabled := true
  else
    tmVariapeso.Enabled := false
end;

procedure TfrEmulador.tmVariaPesoTimer(Sender: TObject);
begin
  btPesar.click;
end;

procedure TfrEmulador.tmEnviarTimer(Sender: TObject);
begin
  btEnviar.Click;
end;

procedure TfrEmulador.cbAutoEnvioClick(Sender: TObject);
begin
  if cbAutoEnvio.Checked then
    tmEnviar.Enabled := true
  else
    tmEnviar.Enabled := false;
end;

procedure TfrEmulador.btSobrepesoClick(Sender: TObject);
var
  PesoS:string;
begin
  Conectar;
  PesoS:= (#2 + 'SSSSS' + #3);
  fSerial.SendString(PesoS);
  lEnviado.Caption := Converte( PesoS ) ;
end;

procedure TfrEmulador.btInstavelClick(Sender: TObject);
var
  PesoS:string;
begin
  conectar;
  PesoS:= (#2 + 'IIIII' + #3);
  fSerial.SendString(PesoS);
  lEnviado.Caption := Converte( PesoS ) ;
end;

procedure TfrEmulador.Button1Click(Sender: TObject);
var
  PesoS:string;
begin
  conectar;
  PesoS:= (#2 + 'NNNNN' + #3);
  fSerial.SendString(PesoS);
  lEnviado.Caption := Converte( PesoS ) ;
end;

procedure TfrEmulador.conectar;
begin
  if not fSerial.InstanceActive then
  begin
    fSerial.Connect( cbxPorta.Text );
    if cbModelo.Text = 'FILIZOLA' then
      fSerial.Config(9600,8,'N',0,false,false) else
    if cbModelo.Text = 'TOLEDO' then
      fSerial.Config(4800,8,'O',2,false,false)
  end;
end;

end.

