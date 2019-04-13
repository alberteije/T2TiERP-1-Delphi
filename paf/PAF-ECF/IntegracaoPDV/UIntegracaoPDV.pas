unit UIntegracaoPDV;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Generics.Collections, StdCtrls, Buttons, FileCtrl,Registry,
  JvComponentBase, JvTrayIcon, UDataModule, ComCtrls, JvExComCtrls,
  JvProgressBar;

type
  TFIntegracaoPDV = class(TForm)
    TimeIntegracao: TTimer;
    ListTXT: TFileListBox;
    JvTrayIcon1: TJvTrayIcon;
    timeConexao: TTimer;
    pBanco: TProgressBar;
    pLabel: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure TimeIntegracaoTimer(Sender: TObject);
    function ImportaPDV:boolean;
    procedure timeConexaoTimer(Sender: TObject);
  private
    Contador:integer;

    procedure GravaRegistro(Raiz: HKEY; Chave, Valor, Endereco: string);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FIntegracaoPDV: TFIntegracaoPDV;

implementation

uses Biblioteca,   ImportaController, LogImportacaoController;


{$R *.dfm}

procedure TFIntegracaoPDV.FormCreate(Sender: TObject);
 var
   reg: TRegistry;
begin
   reg := TRegistry.Create;
  reg.RootKey := HKEY_LOCAL_MACHINE;
  reg.OpenKey('Software\Microsoft\Windows\CurrentVersion\Run',False);
  // vamos verificar a existência de uma chave a partir da chave raiz
 // if not reg.ValueExists('IniciarPrograma') then
 //   begin
      try
        GravaRegistro(HKEY_LOCAL_MACHINE, 'Software\Microsoft\Windows\CurrentVersion\Run',
          'IniciarPrograma', ExtractFilePath(Application.ExeName) + 'Integracao.exe');
      except
        MessageDlg('Erro ao gravar registro!', mtInformation, [mbOk], 0);
      end;
 //   end;

  reg.Free;

  Contador:=0;
  pLabel.Caption:='';

end;

procedure TFIntegracaoPDV.GravaRegistro(Raiz: HKEY; Chave, Valor, Endereco: string);
  var
   Registro: TRegistry;
begin
  Registro := TRegistry.Create(KEY_WRITE); // Chama o construtor do objeto
  Registro.RootKey := Raiz; //Define a chave raiz
  Registro.OpenKey(Chave, True); //Cria a chave
  Registro.WriteString(Valor, '"' + Endereco + '"'); //Grava o endereço da sua aplicação no Registro
  Registro.CloseKey; // Fecha a chave e o objeto
  Registro.Free;
end;

function TFIntegracaoPDV.ImportaPDV:boolean;
var
  RemoteApp, LocalApp : string;
  i:integer;
  iContaTXT: Integer;
  DataTXT: TDate;
begin
  try

    TimeIntegracao.Enabled:=False;
    TImportaController.ConsultaDataAtualizacao(now);
    try
      Result:=false;
      ListTXT.Mask      := '*.txt';
      ListTXT.Directory := FDataModule.RemoteAppPath;
      ListTXT.Update;
      ForceDirectories(ExtractFilePath(Application.ExeName)+'Script');
      LocalApp:=  ExtractFilePath(Application.ExeName)+'Script\vendas.txt';
      for i := 1 to (StrToInt(FDataModule.QtdeECF)) do
      begin
        for iContaTXT := 0 to ListTXT.Count -1 do
        begin
          RemoteApp :=  FDataModule.RemoteAppPath+RemoteApp+ListTXT.Items[iContaTXT];
          if not FileExists(FDataModule.RemoteAppPath+'Semaforo') then
          begin
            if FileExists(RemoteApp) then
            begin
              if CopyFile(PChar(RemoteApp), PChar(LocalApp), False) then
              begin
                if TImportaController.ImportaDadosDoPDV(LocalApp) then
                begin
                  // DataTXT := StrToDate(StringReplace(Copy(ListTXT.Items[iContaTXT],6,10),'-','/',[rfReplaceAll]));
                  //if DataTXT < date then
                  DeleteFile(Pchar(RemoteApp));
                end;
              end;
            end;
          end;
          RemoteApp := '';
        end;
      end;
    except
      TLogImportacaoController.GravaLogImportacao(LocalApp);
    end;
  finally
    Result:= True;
  end;
end;


procedure TFIntegracaoPDV.timeConexaoTimer(Sender: TObject);
var
Hwnd : THandle;
begin
  Hwnd := FindWindow(nil, 'PAF-ECF');
// se o Handle e' 0 significa que nao encontrou
    if pBanco.Position >= 30 then
       pBanco.Position := 1;

    pBanco.Position := pBanco.Position + 1;

    self.pLabel.Caption:= 'Conectando ao Banco...';

  if Hwnd <> 0 then
     begin
        self.timeConexao.Enabled := false;
        if FDataModule.ConectaBalcao then
           begin
              self.pLabel.Caption := 'Banco Conectado!!!';
              pBanco.Position := 1;
              self.TimeIntegracao.Enabled := True;
              pLabel.Caption := 'Localizando Vendas...';
           end;
     end;


end;

procedure TFIntegracaoPDV.TimeIntegracaoTimer(Sender: TObject);
begin
  if ImportaPDV then
  begin
     if pBanco.Position >= 30 then
        pBanco.Position := 1;

     pBanco.Position := pBanco.Position + 1;
     TimeIntegracao.Enabled:=true;
  end;

end;

end.
