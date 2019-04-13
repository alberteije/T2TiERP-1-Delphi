// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : D:\Temporario\NotaFiscalEletronica\Projeto NFeNet\WSDL\NfeInutilizacao.wsdl
// Encoding : UTF-8
// Version  : 1.0
// (17/12/2008 09:28:55 - 1.33.2.5)
// ************************************************************************ //
{$I ACBr.inc}

unit ACBrNFeNfeInutilizacaoU;

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
  // Namespace : http://www.portalfiscal.inf.br/nfe/wsdl/NfeInutilizacao
  // soapAction: nfeInutilizacaoNF
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // binding   : NfeInutilizacaoSoapBinding
  // service   : NfeInutilizacao
  // port      : NfeInutilizacao
  // URL       : https://homolog.sefaz.go.gov.br/nfe/services/NfeInutilizacao
  // ************************************************************************ //
  NfeInutilizacao = interface(IInvokable)
  ['{697FF5BB-8746-5D3B-3BBD-57457885DC4E}']
    function  nfeInutilizacaoNF(const nfeCabecMsg: WideString; const nfeDadosMsg: WideString): WideString; stdcall;
  end;

function GetNfeInutilizacao(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): NfeInutilizacao;


implementation

function GetNfeInutilizacao(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): NfeInutilizacao;
const
  defWSDL = 'D:\Temporario\NotaFiscalEletronica\Projeto NFeNet\WSDL\NfeInutilizacao.wsdl';
  defURL  = 'https://homolog.sefaz.go.gov.br/nfe/services/NfeInutilizacao';
  defSvc  = 'NfeInutilizacao';
  defPrt  = 'NfeInutilizacao';
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
    Result := (RIO as NfeInutilizacao);
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
  InvRegistry.RegisterInterface(TypeInfo(NfeInutilizacao), 'http://www.portalfiscal.inf.br/nfe/wsdl/NfeInutilizacao', 'UTF-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(NfeInutilizacao), 'http://www.portalfiscal.inf.br/nfe/wsdl/NfeInutilizacao/nfeInutilizacaoNF');
  InvRegistry.RegisterInvokeOptions(TypeInfo(NfeInutilizacao), ioDocument);

end.