// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : WSDL\NfeCancelamento.wsdl
// Encoding : UTF-8
// Version  : 1.0
// (01/10/2008 18:05:20 - 1.33.2.5)
// ************************************************************************ //
{$I ACBr.inc}

unit ACBrNFeNfeCancelamentoU;

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
  // Namespace : http://www.portalfiscal.inf.br/nfe/wsdl/NfeCancelamento
  // soapAction: nfeCancelamentoNF
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // binding   : NfeCancelamentoSoapBinding
  // service   : NfeCancelamento
  // port      : NfeCancelamento
  // URL       : https://homolog.sefaz.go.gov.br/nfe/services/NfeCancelamento
  // ************************************************************************ //
  NfeCancelamento = interface(IInvokable)
  ['{837CBD81-0790-1549-76BA-2231C932A9C8}']
    function  nfeCancelamentoNF(const nfeCabecMsg: WideString; const nfeDadosMsg: WideString): WideString; stdcall;
  end;

function GetNfeCancelamento(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): NfeCancelamento;


implementation

function GetNfeCancelamento(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): NfeCancelamento;
const
  defWSDL = 'D:\Temporario\NotaFiscalEletronica\Projeto NFeNet\WSDL\NfeCancelamento.wsdl';
  defURL  = 'https://homolog.sefaz.go.gov.br/nfe/services/NfeCancelamento';
  defSvc  = 'NfeCancelamento';
  defPrt  = 'NfeCancelamento';
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
    Result := (RIO as NfeCancelamento);
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
  InvRegistry.RegisterInterface(TypeInfo(NfeCancelamento), 'http://www.portalfiscal.inf.br/nfe/wsdl/NfeCancelamento', 'UTF-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(NfeCancelamento), 'http://www.portalfiscal.inf.br/nfe/wsdl/NfeCancelamento/nfeCancelamentoNF');
  InvRegistry.RegisterInvokeOptions(TypeInfo(NfeCancelamento), ioDocument);

end.