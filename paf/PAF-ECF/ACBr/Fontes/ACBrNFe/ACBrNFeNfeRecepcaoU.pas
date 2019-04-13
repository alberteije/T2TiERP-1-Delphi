// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : WSDL\NfeRecepcao.wsdl
// Encoding : UTF-8
// Version  : 1.0
// (1/10/2008 14:34:07 - 1.33.2.5)
// ************************************************************************ //
{$I ACBr.inc}

unit ACBrNFeNfeRecepcaoU;

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
  // Namespace : http://www.portalfiscal.inf.br/nfe/wsdl/NfeRecepcao
  // soapAction: http://www.portalfiscal.inf.br/nfe/wsdl/NfeRecepcao/nfeRecepcaoLote
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // binding   : NfeRecepcaoSoapBinding
  // service   : NfeRecepcao
  // port      : NfeRecepcao
  // URL       : https://homolog.sefaz.go.gov.br/nfe/services/NfeRecepcao
  // ************************************************************************ //
  NfeRecepcao = interface(IInvokable)
  ['{5EDAE643-AC7D-9434-5082-01E012E37302}']
    function  nfeRecepcaoLote(const nfeCabecMsg: WideString; const nfeDadosMsg: WideString): WideString; stdcall;
  end;

function GetNfeRecepcao(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): NfeRecepcao;


implementation

function GetNfeRecepcao(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): NfeRecepcao;
const
  defWSDL = 'D:\Temporario\NotaFiscalEletronica\Projeto NFeNet\WSDL\NfeRecepcao.wsdl';
  defURL  = 'https://homolog.sefaz.go.gov.br/nfe/services/NfeRecepcao';
  defSvc  = 'NfeRecepcao';
  defPrt  = 'NfeRecepcao';
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
    Result := (RIO as NfeRecepcao);
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
  InvRegistry.RegisterInterface(TypeInfo(NfeRecepcao), 'http://www.portalfiscal.inf.br/nfe/wsdl/NfeRecepcao', 'UTF-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(NfeRecepcao), 'http://www.portalfiscal.inf.br/nfe/wsdl/NfeRecepcao/nfeRecepcaoLote');
  InvRegistry.RegisterInvokeOptions(TypeInfo(NfeRecepcao), ioDocument);

end.