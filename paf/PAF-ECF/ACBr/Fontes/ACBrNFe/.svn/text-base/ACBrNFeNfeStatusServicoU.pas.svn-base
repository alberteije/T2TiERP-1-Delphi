// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : WSDL\NfeStatusServico.wsdl
// Encoding : UTF-8
// Version  : 1.0
// (30/09/2008 10:49:37 - 1.33.2.5)
// ************************************************************************ //
{$I ACBr.inc}

unit ACBrNFeNfeStatusServicoU;

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
  // Namespace : http://www.portalfiscal.inf.br/nfe/wsdl/NfeStatusServico
  // soapAction: http://www.portalfiscal.inf.br/nfe/wsdl/NfeStatusServico/nfeStatusServicoNF
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // binding   : NfeStatusServicoSoapBinding
  // service   : NfeStatusServico
  // port      : NfeStatusServico
  // URL       : https://homolog.sefaz.go.gov.br/nfe/services/NfeStatusServico
  // ************************************************************************ //
  NfeStatusServico = interface(IInvokable)
  ['{B1BF896E-4169-65D1-3C93-F8A4EA262EA9}']
    function  nfeStatusServicoNF(const nfeCabecMsg: WideString; const nfeDadosMsg: WideString): WideString; stdcall;
  end;

function GetNfeStatusServico(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): NfeStatusServico;


implementation

function GetNfeStatusServico(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): NfeStatusServico;
const
  defWSDL = 'D:\Temporario\NotaFiscalEletronica\Projeto NFeNet\WSDL\NfeStatusServico.wsdl';
  defURL  = 'https://homolog.sefaz.go.gov.br/nfe/services/NfeStatusServico';
  defSvc  = 'NfeStatusServico';
  defPrt  = 'NfeStatusServico';
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
    Result := (RIO as NfeStatusServico);
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
  InvRegistry.RegisterInterface(TypeInfo(NfeStatusServico), 'http://www.portalfiscal.inf.br/nfe/wsdl/NfeStatusServico', 'UTF-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(NfeStatusServico), 'http://www.portalfiscal.inf.br/nfe/wsdl/NfeStatusServico/nfeStatusServicoNF');
  InvRegistry.RegisterInvokeOptions(TypeInfo(NfeStatusServico), ioDocument);

end.