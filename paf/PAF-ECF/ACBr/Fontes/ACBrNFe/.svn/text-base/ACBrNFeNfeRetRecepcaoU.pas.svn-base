// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : WSDL\NfeRetRecepcao.wsdl
// Encoding : UTF-8
// Version  : 1.0
// (01/10/2008 17:20:34 - 1.33.2.5)
// ************************************************************************ //
{$I ACBr.inc}

unit ACBrNFeNfeRetRecepcaoU;

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
  // Namespace : http://www.portalfiscal.inf.br/nfe/wsdl/NfeRetRecepcao
  // soapAction: http://www.portalfiscal.inf.br/nfe/wsdl/NfeRetRecepcao/nfeRetRecepcao
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // binding   : NfeRetRecepcaoSoapBinding
  // service   : NfeRetRecepcao
  // port      : NfeRetRecepcao
  // URL       : https://homolog.sefaz.go.gov.br/nfe/services/NfeRetRecepcao
  // ************************************************************************ //
  NfeRetRecepcao = interface(IInvokable)
  ['{CAC09D6C-1876-346C-4D8D-C931361F4438}']
    function  nfeRetRecepcao(const nfeCabecMsg: WideString; const nfeDadosMsg: WideString): WideString; stdcall;
  end;

function GetNfeRetRecepcao(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): NfeRetRecepcao;


implementation

function GetNfeRetRecepcao(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): NfeRetRecepcao;
const
  defWSDL = 'D:\Temporario\NotaFiscalEletronica\Projeto NFeNet\WSDL\NfeRetRecepcao.wsdl';
  defURL  = 'https://homolog.sefaz.go.gov.br/nfe/services/NfeRetRecepcao';
  defSvc  = 'NfeRetRecepcao';
  defPrt  = 'NfeRetRecepcao';
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
    Result := (RIO as NfeRetRecepcao);
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
  InvRegistry.RegisterInterface(TypeInfo(NfeRetRecepcao), 'http://www.portalfiscal.inf.br/nfe/wsdl/NfeRetRecepcao', 'UTF-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(NfeRetRecepcao), 'http://www.portalfiscal.inf.br/nfe/wsdl/NfeRetRecepcao/nfeRetRecepcao');
  InvRegistry.RegisterInvokeOptions(TypeInfo(NfeRetRecepcao), ioDocument);

end.