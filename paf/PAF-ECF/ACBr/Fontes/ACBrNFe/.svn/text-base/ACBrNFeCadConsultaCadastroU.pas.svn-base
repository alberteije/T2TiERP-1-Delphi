// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : WSDL\CadConsultaCadastro.wsdl
// Encoding : UTF-8
// Version  : 1.0
// (14/07/2009 17:39:24 - 1.33.2.5)
// ************************************************************************ //

unit ACBrNFeCadConsultaCadastroU;

interface

uses InvokeRegistry, SOAPHTTPClient, Types, XSBuiltIns;

type

  // ************************************************************************ //
  // The following types, referred to in the WSDL document are not being represented
  // in this file. They are either aliases[@] of other types represented or were referred
  // to but never[!] declared in the document. The types from the latter category
  // typically map to predefined/known XML or Borland types; however, they could also 
  // indicate incorrect WSDL documents that failed to declare or import a schema type.
  // ************************************************************************ //
  // !:string          - "http://www.w3.org/2001/XMLSchema"



  // ************************************************************************ //
  // Namespace : http://www.portalfiscal.inf.br/nfe/wsdl/CadConsultaCadastro
  // soapAction: consultaCadastro
  // transport : http://schemas.xmlsoap.org/soap/http
  // binding   : NfeConsultaCadastroSoapBinding
  // service   : CadConsultaCadastro
  // port      : NfeConsultaCadastro
  // URL       : https://homolog.sefaz.go.gov.br/nfe/services/CadConsultaCadastro
  // ************************************************************************ //
  CadConsultaCadastro = interface(IInvokable)
  ['{A0BFD545-3AAF-928E-204C-75344540E5DD}']
    function  consultaCadastro(const nfeCabecMsg: WideString; const nfeDadosMsg: WideString): WideString; stdcall;
  end;

function GetCadConsultaCadastro(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): CadConsultaCadastro;


implementation

function GetCadConsultaCadastro(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): CadConsultaCadastro;
const
  defWSDL = 'CadConsultaCadastro.wsdl';
  defURL  = 'https://homolog.sefaz.go.gov.br/nfe/services/CadConsultaCadastro';
  defSvc  = 'CadConsultaCadastro';
  defPrt  = 'NfeConsultaCadastro';
var
  RIO: THTTPRIO;
begin
  Result := nil;
  if (Addr = '') then
  begin
    if UseWSDL then
      Addr := defWSDL
    else
      Addr := defURL;
  end;
  if HTTPRIO = nil then
    RIO := THTTPRIO.Create(nil)
  else
    RIO := HTTPRIO;
  try
    Result := (RIO as CadConsultaCadastro);
    if UseWSDL then
    begin
      RIO.WSDLLocation := Addr;
      RIO.Service := defSvc;
      RIO.Port := defPrt;
    end else
      RIO.URL := Addr;
  finally
    if (Result = nil) and (HTTPRIO = nil) then
      RIO.Free;
  end;
end;


initialization
  InvRegistry.RegisterInterface(TypeInfo(CadConsultaCadastro), 'http://www.portalfiscal.inf.br/nfe/wsdl/CadConsultaCadastro', 'UTF-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(CadConsultaCadastro), 'http://www.portalfiscal.inf.br/nfe/wsdl/CadConsultaCadastro/consultaCadastro');
  InvRegistry.RegisterInvokeOptions(TypeInfo(CadConsultaCadastro), ioDocument);

end.