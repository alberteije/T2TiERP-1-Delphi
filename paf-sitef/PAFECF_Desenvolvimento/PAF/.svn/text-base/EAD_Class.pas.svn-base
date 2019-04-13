unit EAD_Class;

interface

uses Windows, SysUtils;

type
  TEAD_Class = class
  private
    class function  DLLLoad: boolean;
    class procedure DLLUnLoad;

    class function GenkKey(ChavePublica: AnsiString; ChavePrivada: AnsiString): integer;
    class function SetLibType(Tipo: integer): integer; stdcall;
    class function GenerateEAD(NomeArq: AnsiString; ChavePublica: AnsiString; ChavePrivada: AnsiString; EAD:AnsiString; Sign: Integer): integer;
    class function ValidateFile(NomeArq: AnsiString; ChavePublica: AnsiString; ChavePrivada: AnsiString): integer;
  public
    class function SingEAD(FileName: string): boolean;
  end;

var
  fHDLL: THandle;
  EAD_GenkKey     : function (ChavePublica: AnsiString; ChavePrivada: AnsiString): integer; stdcall;
  EAD_SetLibType  : function (Tipo: integer): integer; stdcall;
  EAD_GenerateEAD : function (NomeArq: AnsiString; ChavePublica: AnsiString; ChavePrivada: AnsiString; EAD:AnsiString; Sign: Integer): integer; stdcall;
  EAD_ValidateFile: function (NomeArq: AnsiString; ChavePublica: AnsiString; ChavePrivada: AnsiString): integer; stdcall;

//const KeyPublic  = ''; // Gere no demo deles e coloque aqui.
//const KeyPrivate = ''; // Gere no demo deles e coloque aqui.
const KeyPublic  = 'A5171B504F3875F311DE3DD6333E219200823E0469A94A7B438AF02D67' +
                   '29AFE93C2A0906300B30061B863FC29882F6BB072F483EF0EC82A2AFB3' +
                   '08921314A3E8C7B433AF673E9050AFB55C4004EF9DE57161B1D3DECFBE' +
                   'FAC96382F33BBA7F78E07E2408D47C44FC3178DF0286D6EC31BB7A28CA' +
                   'CD97B7C323F80224196DD8CD';
const KeyPrivate = 'CF219E71DC808F8FE01227F615DAD3C12DA4EC7D7A796C4C01491F8358' +
                   '168CDDFB6296FF113F86EF1525252F6A81017053C185F6022B24F6EB3D' +
                   '3F9FCC3896A7CC0A475CC5CAB471402553BA9DAEA801D41B8852ADC965' +
                   'E9AF61441BD869554A6295C008196475EE0B021E8267E10DF146E48B72' +
                   '333A5660AC7430E9056F376B';

implementation

//function genkkey(ChavePublica: AnsiString; ChavePrivada: AnsiString): integer; stdcall; external 'axialass.dll';
//function setLibType(Tipo: integer): integer; stdcall; external 'axialass.dll';
//function generateEAD(NomeArq: AnsiString; ChavePublica: AnsiString; ChavePrivada: AnsiString; EAD:AnsiString; Sign: Integer): integer; stdcall; external 'axialass.dll';
//function validateFile(NomeArq: AnsiString; ChavePublica: AnsiString; ChavePrivada: AnsiString): integer; stdcall; external 'axialass.dll';

{ TEAD_Class }

class function TEAD_Class.DLLLoad: boolean;
begin
  Result := false;
  try
    fHDLL := LoadLibrary(Pchar('sign_bema.dll'));
    if fHDLL <> 0 then
       Result := true;
  except
    raise Exception.Create('Houve um erro ao carregar a dll "sign_bema.dll" na memória');
  end;
end;

class procedure TEAD_Class.DLLUnLoad;
begin
   if fHDLL <> 0 then
   begin
      @EAD_GenkKey      := nil;
      @EAD_SetLibType   := nil;
      @EAD_GenerateEAD  := nil;
      @EAD_ValidateFile := nil;
      try
        FreeLibrary(fHDLL);
      except
        raise Exception.Create('Houve um erro ao liberar a dll "sign_bema.dll" da memória');
      end;
   end;
end;

class function TEAD_Class.GenerateEAD(NomeArq, ChavePublica, ChavePrivada,
  EAD: AnsiString; Sign: Integer): integer;
begin
   Result := -1;
   @EAD_GenerateEAD := nil;
   if fHDLL <> 0 then
      @EAD_GenerateEAD := GetProcAddress(fHDLL, Pchar('generateEAD'));

   if @EAD_GenerateEAD <> nil then
   begin
      Result := EAD_GenerateEAD(NomeArq, ChavePublica, ChavePrivada, EAD, Sign);
   end;
end;

class function TEAD_Class.GenkKey(ChavePublica,
  ChavePrivada: AnsiString): integer;
begin
   Result := -1;
   @EAD_GenkKey := nil;
   if fHDLL <> 0 then
      @EAD_GenkKey := GetProcAddress(fHDLL, Pchar('genkKey'));

   if @EAD_GenkKey <> nil then
   begin
      Result := EAD_GenkKey(ChavePublica, ChavePrivada);
   end;
end;

class function TEAD_Class.SetLibType(Tipo: integer): integer;
begin
   Result := -1;
   @EAD_SetLibType := nil;
   if fHDLL <> 0 then
      @EAD_SetLibType := GetProcAddress(fHDLL, Pchar('setLibType'));

   if @EAD_SetLibType <> nil then
   begin
      Result := EAD_SetLibType(Tipo);
   end;
end;

class function TEAD_Class.ValidateFile(NomeArq, ChavePublica,
  ChavePrivada: AnsiString): integer;
begin
   Result := -1;
   @EAD_ValidateFile := nil;
   if fHDLL <> 0 then
      @EAD_ValidateFile := GetProcAddress(fHDLL, Pchar('validateFile'));

   if @EAD_ValidateFile <> nil then
   begin
      Result := EAD_ValidateFile(NomeArq, ChavePublica, ChavePrivada);
   end;
end;

class function TEAD_Class.SingEAD(FileName: string): boolean;
var
intRetorno: integer;
strEAD: AnsiString;
begin
   Result := false;
   SetLength(strEAD, 256);
   if DLLLoad then
   begin
      try
        intRetorno := GenerateEAD(FileName, KeyPublic, KeyPrivate, strEAD, 1);
        ///
        if (intRetorno = 0) then
        begin
           raise Exception.Create('Houve um erro ao tentar gerar a assinatura digital no arquivo.' + #13+#10 +
                                  'Arquivo : ' + FileName);
        end;
        Result := true;
      finally
        DLLUnLoad;
      end;
   end;
end;

end.
