// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : WSDL\NfeConsulta.wsdl
// Encoding : UTF-8
// Version  : 1.0
// (01/10/2008 17:54:58 - 1.33.2.5)
// ************************************************************************ //
{$I ACBr.inc}

unit ACBrNFeNfeConsultaU;

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
  // Namespace : http://www.portalfiscal.inf.br/nfe/wsdl/NfeConsulta
  // soapAction: nfeConsultaNF
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // binding   : NfeConsultaSoapBinding
  // service   : NfeConsulta
  // port      : NfeConsulta
  // URL       : https://homolog.sefaz.go.gov.br/nfe/services/NfeConsulta
  // ************************************************************************ //
  NfeConsulta = interface(IInvokable)
  ['{DAD09AD5-2724-7A97-7F9C-D0B9FA82EAB5}']
    function  nfeConsultaNF(const nfeCabecMsg: WideString; const nfeDadosMsg: WideString): WideString; stdcall;
  end;

function GetNfeConsulta(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): NfeConsulta;


implementation

function GetNfeConsulta(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): NfeConsulta;
const
  defWSDL = 'D:\Temporario\NotaFiscalEletronica\Projeto NFeNet\WSDL\NfeConsulta.wsdl';
  defURL  = 'https://homolog.sefaz.go.gov.br/nfe/services/NfeConsulta';
  defSvc  = 'NfeConsulta';
  defPrt  = 'NfeConsulta';
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
    Result := (RIO as NfeConsulta);
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
  InvRegistry.RegisterInterface(TypeInfo(NfeConsulta), 'http://www.portalfiscal.inf.br/nfe/wsdl/NfeConsulta', 'UTF-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(NfeConsulta), 'http://www.portalfiscal.inf.br/nfe/wsdl/NfeConsulta/nfeConsultaNF');
  InvRegistry.RegisterInvokeOptions(TypeInfo(NfeConsulta), ioDocument);

end.