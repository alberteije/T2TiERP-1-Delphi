{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: VO relacionado à tabela [NFE_CONFIGURACAO]
                                                                                
The MIT License                                                                 
                                                                                
Copyright: Copyright (C) 2010 T2Ti.COM                                          
                                                                                
Permission is hereby granted, free of charge, to any person                     
obtaining a copy of this software and associated documentation                  
files (the "Software"), to deal in the Software without                         
restriction, including without limitation the rights to use,                    
copy, modify, merge, publish, distribute, sublicense, and/or sell               
copies of the Software, and to permit persons to whom the                       
Software is furnished to do so, subject to the following                        
conditions:                                                                     
                                                                                
The above copyright notice and this permission notice shall be                  
included in all copies or substantial portions of the Software.                 
                                                                                
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,                 
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES                 
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND                        
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT                     
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,                    
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING                    
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR                   
OTHER DEALINGS IN THE SOFTWARE.                                                 
                                                                                
       The author may be contacted at:                                          
           t2ti.com@gmail.com</p>                                               
                                                                                
@author Albert Eije (T2Ti.COM)                                                  
@version 1.0                                                                    
*******************************************************************************}
unit NfeConfiguracaoVO;

interface

type

  TNfeConfiguracaoVO = class
  private
    FID: Integer;
    FCERTIFICADO_DIGITAL: String;
    FCAMINHO_CERTIFICADO: String;
    FSENHA_CERTIFICADO: String;
    FFORMATO_IMPRESSAO_DANFE: String;
    FLOGOMARCA: String;
    FCAMINHO_SALVAR_XML: String;
    FSALVA_XML: String;
    FFONTE_ATT: Integer;
    FFONTE_OUTROS_CAMPOS: Integer;
    FFONTE_RAZAO_SOCIAL: Integer;
    FIMPRIMIR_DETALHE_ESPECIFICO: String;
    FUF_WEBSERVICE: String;
    FAMBIENTE: String;
    FNOME_HOST: String;
    FPORTA: Integer;
    FUSUARIO: String;
    FSENHA: String;
    FASSUNTO: String;
    FAUTENTICA_SSL: String;
    FPROXY_HOST: String;
    FPROXY_PORTA: String;
    FPROXY_USER: String;
    FPROXY_SENHA: String;
    FIMPRIMIR_USUARIO_RODAPE: String;
    FTEXTO_EMAIL: String;

  public
    property Id: Integer  read FID write FID;
    property CertificaDigital: String  read FCERTIFICADO_DIGITAL write FCERTIFICADO_DIGITAL;
    property CaminhoCertificado: String  read FCAMINHO_CERTIFICADO write FCAMINHO_CERTIFICADO;
    property SenhaCertificado: String  read FSENHA_CERTIFICADO write FSENHA_CERTIFICADO;
    property FormaImpressaoDanfe: String  read FFORMATO_IMPRESSAO_DANFE write FFORMATO_IMPRESSAO_DANFE;
    property Logomarca: String  read FLOGOMARCA write FLOGOMARCA;
    property CaminhoSalvarXml: String  read FCAMINHO_SALVAR_XML write FCAMINHO_SALVAR_XML;
    property SalvaXml: String  read FSALVA_XML write FSALVA_XML;
    property FonteAtt: Integer  read FFONTE_ATT write FFONTE_ATT;
    property FonteOutrosCampos: Integer  read FFONTE_OUTROS_CAMPOS write FFONTE_OUTROS_CAMPOS;
    property FonteRazaoSocial: Integer  read FFONTE_RAZAO_SOCIAL write FFONTE_RAZAO_SOCIAL;
    property ImprimirDetalheEspecifico: String  read FIMPRIMIR_DETALHE_ESPECIFICO write FIMPRIMIR_DETALHE_ESPECIFICO;
    property UfWebservice: String  read FUF_WEBSERVICE write FUF_WEBSERVICE;
    property Ambiente: String  read FAMBIENTE write FAMBIENTE;
    property NomeHost: String  read FNOME_HOST write FNOME_HOST;
    property Porta: Integer  read FPORTA write FPORTA;
    property Usuario: String  read FUSUARIO write FUSUARIO;
    property Senha: String  read FSENHA write FSENHA;
    property Assunto: String  read FASSUNTO write FASSUNTO;
    property AutenticaSsl: String  read FAUTENTICA_SSL write FAUTENTICA_SSL;
    property ProxyHost: String  read FPROXY_HOST write FPROXY_HOST;
    property ProxyPorta: string  read FPROXY_PORTA write FPROXY_PORTA;
    property ProxyUser: String  read FPROXY_USER write FPROXY_USER;
    property ProxySenha: String  read FPROXY_SENHA write FPROXY_SENHA;
    property ImprimirUsuarioRodape: String  read FIMPRIMIR_USUARIO_RODAPE write FIMPRIMIR_USUARIO_RODAPE;
    property TextoEmail: String  read FTEXTO_EMAIL write FTEXTO_EMAIL;

  end;

implementation



end.
