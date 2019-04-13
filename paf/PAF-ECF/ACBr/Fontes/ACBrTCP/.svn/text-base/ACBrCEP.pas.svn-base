{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2004 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
{                                                                              }
{  Você pode obter a última versão desse arquivo na pagina do  Projeto ACBr    }
{ Componentes localizado em      http://www.sourceforge.net/projects/acbr      }
{                                                                              }
{ Esse arquivo usa a classe  SynaSer   Copyright (c)2001-2003, Lukas Gebauer   }
{  Project : Ararat Synapse     (Found at URL: http://www.ararat.cz/synapse/)  }
{                                                                              }
{  Esta biblioteca é software livre; você pode redistribuí-la e/ou modificá-la }
{ sob os termos da Licença Pública Geral Menor do GNU conforme publicada pela  }
{ Free Software Foundation; tanto a versão 2.1 da Licença, ou (a seu critério) }
{ qualquer versão posterior.                                                   }
{                                                                              }
{  Esta biblioteca é distribuída na expectativa de que seja útil, porém, SEM   }
{ NENHUMA GARANTIA; nem mesmo a garantia implícita de COMERCIABILIDADE OU      }
{ ADEQUAÇÃO A UMA FINALIDADE ESPECÍFICA. Consulte a Licença Pública Geral Menor}
{ do GNU para mais detalhes. (Arquivo LICENÇA.TXT ou LICENSE.TXT)              }
{                                                                              }
{  Você deve ter recebido uma cópia da Licença Pública Geral Menor do GNU junto}
{ com esta biblioteca; se não, escreva para a Free Software Foundation, Inc.,  }
{ no endereço 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.          }
{ Você também pode obter uma copia da licença em:                              }
{ http://www.opensource.org/licenses/lgpl-license.php                          }
{                                                                              }
{ Daniel Simões de Almeida  -  daniel@djsystem.com.br  -  www.djsystem.com.br  }
{              Praça Anita Costa, 34 - Tatuí - SP - 18270-410                  }
{                                                                              }
{******************************************************************************}

{******************************************************************************
|* Historico
|*
|* 12/08/2010: Primeira Versao
|*    Daniel Simoes de Almeida e André Moraes
******************************************************************************}

unit ACBrCEP ;

{$I ACBr.inc}

interface

uses
  Classes, SysUtils, contnrs,
  ACBrSocket ;

type

  TACBrCEPWebService = ( wsNenhum, wsBuscarCep, wsCepLivre, wsRepublicaVirtual ) ;

  { TACBrCEPEndereco }

  TACBrCEPEndereco = class
    private
      fBairro : String ;
      fCEP : String ;
      fCodigoIBGE : String ;
      fComplemento : String ;
      fLogradouro : String ;
      fMunicipio : String ;
      fTipo_Logradouro : String ;
      fUF : String ;

      function GetIBGE_UF : String ;
    public
      constructor Create ;

      property CEP             : String read fCEP             write fCEP ;
      property Tipo_Logradouro : String read fTipo_Logradouro write fTipo_Logradouro ;
      property Logradouro      : String read fLogradouro      write fLogradouro ;
      property Complemento     : String read fComplemento     write fComplemento ;
      property Bairro          : String read fBairro          write fBairro ;
      property Municipio       : String read fMunicipio       write fMunicipio ;
      property UF              : String read fUF              write fUF ;
      property IBGE_Municipio  : String read fCodigoIBGE      write fCodigoIBGE ;
      property IBGE_UF         : String read GetIBGE_UF ;

      function LerTagXML(Texto, NomeCampo: string): String;
  end ;

  { Lista de Objetos do tipo TACBrCEPEndereco }

  { TACBrCEPEnderecos }

  TACBrCEPEnderecos = class(TObjectList)
    protected
      procedure SetObject (Index: Integer; Item: TACBrCEPEndereco);
      function GetObject (Index: Integer): TACBrCEPEndereco;
      procedure Insert (Index: Integer; Obj: TACBrCEPEndereco);
    public
      function Add (Obj: TACBrCEPEndereco): Integer;
      property Objects [Index: Integer]: TACBrCEPEndereco
        read GetObject write SetObject; default;
    end;

  TACBrCEPWSClass = class ;

  { TACBrCEP }

  TACBrCEP = class( TACBrHTTP )
    private
      fWebService : TACBrCEPWebService ;
      fACBrCEPWS  : TACBrCEPWSClass ;

      fEnderecos : TACBrCEPEnderecos ;
      fOnBuscaEfetuada : TNotifyEvent ;
      function GetURL : String ;
      procedure SetWebService(const AValue : TACBrCEPWebService) ;
    public
      constructor Create(AOwner: TComponent); override;
      Destructor Destroy ; override ;

      property Enderecos : TACBrCEPEnderecos  read fEnderecos ;

      function BuscarPorCEP( ACEP : String ) : Integer ;
      function BuscarPorLogradouro( ACidade, ATipo_Logradouro, ALogradouro, AUF,
         ABairro : String ) : Integer ;

    published
      property WebService : TACBrCEPWebService read fWebService
        write SetWebService default wsNenhum ;
      property URL : String read GetURL ;

      property OnBuscaEfetuada : TNotifyEvent read fOnBuscaEfetuada
         write fOnBuscaEfetuada ;
  end ;

  { TACBrCEPWSClass }

  TACBrCEPWSClass = class
    private
      fOwner : TACBrCEP ;
      fpURL : String ;

      procedure ErrorAbstract ;

    public
      constructor Create( AOwner : TACBrCEP ) ; virtual ;

      Procedure BuscarPorCEP( ACEP : String ) ; virtual ;
      Procedure BuscarPorLogradouro( AMunicipio, ATipo_Logradouro, ALogradouro,
         AUF, ABairro : String ) ; virtual ;

      property URL : String read fpURL ;
  end ;

  { TACBrWSBuscarCEP }

  TACBrWSBuscarCEP = class(TACBrCEPWSClass)
    private
      procedure ProcessaResposta ;
    public
      constructor Create( AOwner : TACBrCEP ) ; override ;

      Procedure BuscarPorCEP( ACEP : String ) ; override ;
      Procedure BuscarPorLogradouro( AMunicipio, ATipo_Logradouro, ALogradouro,
         AUF, ABairro : String ) ; override ;
  end ;

  { TACBrWSCEPLivre }

  TACBrWSCEPLivre = class(TACBrCEPWSClass)
    private
      procedure ProcessaResposta ;
    public
      constructor Create( AOwner : TACBrCEP ) ; override ;

      Procedure BuscarPorCEP( ACEP : String ) ; override ;
      Procedure BuscarPorLogradouro( AMunicipio, ATipo_Logradouro, ALogradouro,
         AUF, ABairro : String ) ; override ;
  end ;

  { TACBrWSRepublicaVirtual }

  TACBrWSRepublicaVirtual = class(TACBrCEPWSClass)
    private
      procedure ProcessaResposta ;
    public
      constructor Create( AOwner : TACBrCEP ) ; override ;

      Procedure BuscarPorCEP( ACEP : String ) ; override ;
      Procedure BuscarPorLogradouro( AMunicipio, ATipo_Logradouro, ALogradouro,
         AUF, ABairro : String ) ; override ;
  end ;

implementation

uses ACBrUtil ;

{ TACBrCEPEndereco }

constructor TACBrCEPEndereco.Create ;
begin
  inherited ;

  fCEP             := '' ;
  fTipo_Logradouro := '' ;
  fLogradouro      := '' ;
  fBairro          := '' ;
  fCodigoIBGE      := '' ;
  fMunicipio       := '' ;
  fUF              := '' ;
end ;

function TACBrCEPEndereco.GetIBGE_UF : String ;
begin
  Result := copy(IBGE_Municipio,1,2) ;
end;

function TACBrCEPEndereco.LerTagXML(Texto, NomeCampo: string): string;
var
  ConteudoTag: string;
  inicio, fim: integer;
begin
  NomeCampo := '<'+UpperCase(Trim(NomeCampo))+'>';
  inicio := pos(NomeCampo, UpperCase(Texto));
  if inicio = 0 then
    ConteudoTag := ''
  else
  begin
    inicio := inicio + Length(NomeCampo);
    Texto := copy(Texto,inicio,length(Texto));
    inicio := 0;
    fim := pos('</',Texto)-1;
    ConteudoTag := trim(copy(Texto, inicio, fim));
  end;
  try
     result := ConteudoTag;
  except
     raise Exception.Create('Conteúdo inválido. '+ConteudoTag);
  end;
end;

{ TACBrCEPEnderecos }

procedure TACBrCEPEnderecos.SetObject(Index : Integer ; Item : TACBrCEPEndereco) ;
begin
  inherited SetItem (Index, Item) ;
end ;

function TACBrCEPEnderecos.GetObject(Index : Integer) : TACBrCEPEndereco ;
begin
  Result := inherited GetItem(Index) as TACBrCEPEndereco ;
end ;

procedure TACBrCEPEnderecos.Insert(Index : Integer ; Obj : TACBrCEPEndereco) ;
begin
  inherited Insert(Index, Obj);
end ;

function TACBrCEPEnderecos.Add(Obj : TACBrCEPEndereco) : Integer ;
begin
  Result := inherited Add(Obj) ;
end ;

{ TACBrCEP }

constructor TACBrCEP.Create(AOwner : TComponent) ;
begin
  inherited Create(AOwner) ;

  fOnBuscaEfetuada := nil ;

  fEnderecos  := TACBrCEPEnderecos.create( True );
  fACBrCEPWS  := TACBrCEPWSClass.Create( Self );
  fWebService := wsNenhum ;
end ;

destructor TACBrCEP.Destroy ;
begin
  fEnderecos.Free;
  fACBrCEPWS.Free;

  inherited Destroy ;
end ;

procedure TACBrCEP.SetWebService(const AValue : TACBrCEPWebService) ;
begin
  if fWebService = AValue then exit ;

  fACBrCEPWS.Free;

  case AValue of
    wsBuscarCep : fACBrCEPWS := TACBrWSBuscarCEP.Create( Self );
    wsCepLivre  : fACBrCEPWS := TACBrWSCEPLivre.Create( Self );
    wsRepublicaVirtual : fACBrCEPWS := TACBrWSRepublicaVirtual.Create(Self);
  else
     fACBrCEPWS := TACBrCEPWSClass.Create( Self ) ;
  end ;

  fWebService := AValue;
end;

function TACBrCEP.GetURL : String ;
begin
  Result := fACBrCEPWS.URL ;
end;

function TACBrCEP.BuscarPorCEP(ACEP : String) : Integer ;
begin
  fEnderecos.Clear;

  ACEP := Trim( OnlyNumber( ACEP ) ) ;
  if ACEP = '' then
     raise Exception.Create('CEP deve ser informado');

  fACBrCEPWS.BuscarPorCEP(ACEP);

  Result := fEnderecos.Count;
end ;

function TACBrCEP.BuscarPorLogradouro(ACidade, ATipo_Logradouro, ALogradouro,
  AUF, ABairro : String ) : Integer ;
begin
  fEnderecos.Clear;
  fACBrCEPWS.BuscarPorLogradouro( ACidade, ATipo_Logradouro, ALogradouro, AUF,
                                  ABairro );

  Result := fEnderecos.Count;
end ;

{ TACBrCEPWSClass }

procedure TACBrCEPWSClass.ErrorAbstract ;
begin
  raise Exception.Create( 'Nenhum WebService selecionado' )
end ;

constructor TACBrCEPWSClass.Create( AOwner : TACBrCEP) ;
begin
  inherited Create ;

  fOwner := AOwner;
  fpURL  := '';
end ;

Procedure TACBrCEPWSClass.BuscarPorCEP(ACEP : String) ;
begin
  ErrorAbstract ;
end ;

Procedure TACBrCEPWSClass.BuscarPorLogradouro(AMunicipio, ATipo_Logradouro,
   ALogradouro, AUF, ABairro : String ) ;
begin
  ErrorAbstract ;
end ;

{ TACBrWSBuscarCEP - http://www.buscarcep.com.br }

constructor TACBrWSBuscarCEP.Create(AOwner : TACBrCEP) ;
begin
  inherited Create(AOwner) ;

  fpURL := 'http://www.buscarcep.com.br/' ;
end ;

Procedure TACBrWSBuscarCEP.BuscarPorCEP( ACEP : String ) ;
begin
  fOwner.HTTPGet( fpURL + '?cep='+ACEP+'&formato=string' ) ;
  ProcessaResposta ;
end ;

Procedure  TACBrWSBuscarCEP.BuscarPorLogradouro(AMunicipio,  ATipo_Logradouro,
  ALogradouro, AUF, ABairro : String) ;
Var
   Params : String ;
begin
  AMunicipio       := fOwner.AjustaParam( AMunicipio ) ;
  ATipo_Logradouro := fOwner.AjustaParam( ATipo_Logradouro );
  ALogradouro      := fOwner.AjustaParam( ALogradouro ) ;
  AUF              := fOwner.AjustaParam( AUF );

  if (AMunicipio = '') or (ALogradouro = '') or (AUF = '') then
     raise Exception.Create('UF, Cidade e Logradouro devem ser informados');

  Params := '?logradouro=' + ALogradouro+
            '&cidade='     + AMunicipio+
            '&uf='         + AUF;

  if ATipo_Logradouro <> '' then
    Params := Params + '&tipo_logradouro=' + ATipo_Logradouro ;

  if ABairro <> '' then
    Params := Params + '&bairro=' + ABairro ;

  Params := Params + '&formato=string' ;

  fOwner.HTTPGet( fpURL + Params ) ;
  ProcessaResposta ;
end ;

Procedure TACBrWSBuscarCEP.ProcessaResposta ;
Var
   SL1, SL2 : TStringList ;
   Buffer : String ;
   PosIni, I : Integer ;
   Endereco : TACBrCEPEndereco ;
begin
  fOwner.fEnderecos.Clear;

  SL1 := TStringList.Create;
  SL2 := TStringList.Create;
  try
    SL1.Text := StringReplace( fOwner.RespHTTP.Text, '&cep=', sLineBreak+'&cep=',
                               [rfReplaceAll] );

    For I := 0 to SL1.Count-1 do
    begin
       Buffer := SL1[I] ;
       PosIni := pos('&cep=',Buffer) ;

       if PosIni > 0 then
       begin

         Buffer := copy( Buffer, PosIni, Length(Buffer) ) ;

         SL2.Clear;
         SL2.Text := StringReplace( Buffer, '&', sLineBreak, [rfReplaceAll] );

         if (SL2.Values['resultado'] = '1') then
         begin
            Endereco := TACBrCEPEndereco.Create;

            Endereco.CEP             := SL2.Values['cep'] ;
            Endereco.Tipo_Logradouro := SL2.Values['tipo_logradouro'] ;
            Endereco.Logradouro      := SL2.Values['logradouro'] ;
            Endereco.Complemento     := SL2.Values['complemento'] ;
            Endereco.Bairro          := SL2.Values['bairro'] ;
            Endereco.Municipio       := SL2.Values['cidade'] ;
            Endereco.UF              := SL2.Values['uf'] ;
            Endereco.IBGE_Municipio  := SL2.Values['ibge_municipio_verificador'] ;

            fOwner.Enderecos.Add( Endereco );
         end ;
       end ;
    end ;
  finally
    SL1.free ;
    SL2.free ;
  end ;

  if Assigned( fOwner.OnBuscaEfetuada ) then
     fOwner.OnBuscaEfetuada( Self );
end ;


{ TACBrWSCEPLivre - http://ceplivre.pc2consultoria.com }

constructor TACBrWSCEPLivre.Create(AOwner : TACBrCEP) ;
begin
  inherited Create(AOwner) ;
  fpURL := 'http://ceplivre.pc2consultoria.com/' ;
end ;

Procedure TACBrWSCEPLivre.BuscarPorCEP(ACEP : String) ;
begin
  // CEPLivre exige CEP formatado //
  ACEP := Copy(ACEP,1,5)+'-'+Copy(ACEP,6,3);

  fOwner.HTTPGet( fpURL + 'index.php?module=cep&cep='+ACEP+'&formato=csv' ) ;
  ProcessaResposta ;
end ;

Procedure TACBrWSCEPLivre.BuscarPorLogradouro(AMunicipio, ATipo_Logradouro,
  ALogradouro, AUF, ABairro : String) ;
Var
   Params : String ;
begin
  AMunicipio       := fOwner.AjustaParam( AMunicipio ) ;
  ATipo_Logradouro := fOwner.AjustaParam( ATipo_Logradouro );
  ALogradouro      := fOwner.AjustaParam( ALogradouro ) ;
  AUF              := fOwner.AjustaParam( AUF );

  if (AMunicipio = '') or (ALogradouro = '') then
     raise Exception.Create('Cidade e Logradouro devem ser informados');

//  &logradouro=paulista&cidade=sao%20paulo&formato=csv
  Params := 'index.php?module=cep' +
            '&logradouro=' + ALogradouro+
            '&cidade='     + AMunicipio+
            '&sigla='      + AUF;

  if ATipo_Logradouro <> '' then
    Params := Params + '&tipo_logradouro=' + ATipo_Logradouro ;

  if ABairro <> '' then
    Params := Params + '&bairro=' + ABairro ;

  Params := Params + '&formato=csv' ;

  fOwner.HTTPGet( fpURL + Params ) ;
  ProcessaResposta ;
end ;

Procedure TACBrWSCEPLivre.ProcessaResposta ;
Var
   SL1, SL2 : TStringList ;
   Buffer : String ;
   I : Integer ;
   Endereco : TACBrCEPEndereco ;
begin
  fOwner.fEnderecos.Clear;

  SL1 := TStringList.Create;
  SL2 := TStringList.Create;
  try
    SL1.Text := fOwner.RespHTTP.Text ;

    For I := 0 to SL1.Count-1 do
    begin
      Buffer := SL1[I] ;

      SL2.Clear;
      SL2.Text := StringReplace( Buffer, ',', sLineBreak, [rfReplaceAll] );

      if (SL2.Count >= 9) and (Length( OnlyNumber(SL2[8]) ) = 8) then
      begin
        Endereco := TACBrCEPEndereco.Create;

        Endereco.CEP             := SL2[8] ;
        Endereco.Tipo_Logradouro := SL2[0] ;
        Endereco.Logradouro      := SL2[2] ;
        Endereco.Bairro          := SL2[3] ;
        Endereco.Municipio       := SL2[4] ;
        Endereco.UF              := SL2[5] ;
        if SL2.Count >= 10 then
          Endereco.IBGE_Municipio:= SL2[9] ;

        fOwner.Enderecos.Add( Endereco );
      end ;
    end ;
  finally
    SL1.free ;
    SL2.free ;
  end ;

  if Assigned( fOwner.OnBuscaEfetuada ) then
     fOwner.OnBuscaEfetuada( Self );
end ;

{ TACBrWSRepublicaVirtual }
constructor TACBrWSRepublicaVirtual.Create(AOwner: TACBrCEP);
begin
  inherited Create(AOwner);
  fpURL := 'http://cep.republicavirtual.com.br/' ;
end;

procedure TACBrWSRepublicaVirtual.BuscarPorCEP(ACEP: String);
begin
  ACEP := OnlyNumber(ACEP);

  fOwner.HTTPGet( fpURL + 'web_cep.php?cep='+ACEP+'&formato=xml' ) ;
  ProcessaResposta ;
end;

procedure TACBrWSRepublicaVirtual.BuscarPorLogradouro(AMunicipio,
  ATipo_Logradouro, ALogradouro, AUF, ABairro: String);
begin
  raise Exception.Create(ACBrStr('Busca por Logradouro não disponível no site Republica Virtual.'));
end;

procedure TACBrWSRepublicaVirtual.ProcessaResposta;
Var
   Buffer : String ;
   PosIni : Integer ;
   Endereco : TACBrCEPEndereco ;
begin
  fOwner.fEnderecos.Clear;

  try
     Buffer := fOwner.RespHTTP.Text;
     PosIni := pos('<resultado>1',Buffer) ;

     if PosIni > 0 then
       begin
         Endereco := TACBrCEPEndereco.Create;

         Endereco.CEP             := Endereco.LerTagXML(Buffer,'cep') ;
         Endereco.Tipo_Logradouro := Endereco.LerTagXML(Buffer,'tipo_logradouro') ;
         Endereco.Logradouro      := Endereco.LerTagXML(Buffer,'logradouro') ;
         Endereco.Complemento     := Endereco.LerTagXML(Buffer,'complemento') ;
         Endereco.Bairro          := Endereco.LerTagXML(Buffer,'bairro') ;
         Endereco.Municipio       := Endereco.LerTagXML(Buffer,'cidade') ;
         Endereco.UF              := Endereco.LerTagXML(Buffer,'uf') ;
         Endereco.IBGE_Municipio  := '';

         fOwner.Enderecos.Add( Endereco );
        end ;
  finally
     Buffer:= '';
  end ;

  if Assigned( fOwner.OnBuscaEfetuada ) then
     fOwner.OnBuscaEfetuada( Self );
end ;


end.
