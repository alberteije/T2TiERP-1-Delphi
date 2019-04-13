{*******************************************************************************
Title: T2Ti ERP
Description:  VO  relacionado à tabela [NfeConfiguracao]

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

@author  ()
@version 1.0
*******************************************************************************}
unit NfeConfiguracaoVO;

interface

uses
  Atributos;

type
  [TEntity]
  [TTable('NFE_CONFIGURACAO')]
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
    FIMPRIMIR_DETALHE_ESPECIFICO: Integer;
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
    [TId('ID')]
    [TGeneratedValue('AUTO')]
    property Id: Integer  read FID write FID;
    [TColumn('CERTIFICADO_DIGITAL','Certificado Digital',ldGridLookup ,20)]
    property CertificadoDigital: String  read FCERTIFICADO_DIGITAL write FCERTIFICADO_DIGITAL;
    [TColumn('CAMINHO_CERTIFICADO','Caminho Certificado',ldGridLookup ,80)]
    property CaminhoCertificado: String  read FCAMINHO_CERTIFICADO write FCAMINHO_CERTIFICADO;
    [TColumn('SENHA_CERTIFICADO','Senha Certificado',ldGridLookup ,15)]
    property SenhaCertificado: String  read FSENHA_CERTIFICADO write FSENHA_CERTIFICADO;
    [TColumn('FORMATO_IMPRESSAO_DANFE','Formato Impressao Danfe',ldGridLookup ,1)]
    property FormatoImpressaoDanfe: String  read FFORMATO_IMPRESSAO_DANFE write FFORMATO_IMPRESSAO_DANFE;
    [TColumn('LOGOMARCA','Logomarca',ldGridLookup ,80)]
    property Logomarca: String  read FLOGOMARCA write FLOGOMARCA;
    [TColumn('CAMINHO_SALVAR_XML','Caminho Salvar Xml',ldGridLookup ,80)]
    property CaminhoSalvarXml: String  read FCAMINHO_SALVAR_XML write FCAMINHO_SALVAR_XML;
    [TColumn('SALVA_XML','Salva Xml',ldGridLookup ,1)]
    property SalvaXml: String  read FSALVA_XML write FSALVA_XML;
    [TColumn('FONTE_ATT','Fonte Att',ldGridLookup ,8)]
    property FonteAtt: Integer  read FFONTE_ATT write FFONTE_ATT;
    [TColumn('FONTE_OUTROS_CAMPOS','Fonte Outros Campos',ldGridLookup ,8)]
    property FonteOutrosCampos: Integer  read FFONTE_OUTROS_CAMPOS write FFONTE_OUTROS_CAMPOS;
    [TColumn('FONTE_RAZAO_SOCIAL','Fonte Razao Social',ldGridLookup ,8)]
    property FonteRazaoSocial: Integer  read FFONTE_RAZAO_SOCIAL write FFONTE_RAZAO_SOCIAL;
    [TColumn('IMPRIMIR_DETALHE_ESPECIFICO','Imprimir Detalhe Especifico',ldGridLookup ,8)]
    property ImprimirDetalheEspecifico: Integer  read FIMPRIMIR_DETALHE_ESPECIFICO write FIMPRIMIR_DETALHE_ESPECIFICO;
    [TColumn('UF_WEBSERVICE','Uf Webservice',ldGridLookup ,2)]
    property UfWebservice: String  read FUF_WEBSERVICE write FUF_WEBSERVICE;
    [TColumn('AMBIENTE','Ambiente',ldGridLookup ,1)]
    property Ambiente: String  read FAMBIENTE write FAMBIENTE;
    [TColumn('NOME_HOST','Nome Host',ldGridLookup ,30)]
    property NomeHost: String  read FNOME_HOST write FNOME_HOST;
    [TColumn('PORTA','Porta',ldGridLookup ,8)]
    property Porta: Integer  read FPORTA write FPORTA;
    [TColumn('USUARIO','Usuario',ldGridLookup ,60)]
    property Usuario: String  read FUSUARIO write FUSUARIO;
    [TColumn('SENHA','Senha',ldGridLookup ,20)]
    property Senha: String  read FSENHA write FSENHA;
    [TColumn('ASSUNTO','Assunto',ldGridLookup ,80)]
    property Assunto: String  read FASSUNTO write FASSUNTO;
    [TColumn('AUTENTICA_SSL','Autentica Ssl',ldGridLookup ,1)]
    property AutenticaSsl: String  read FAUTENTICA_SSL write FAUTENTICA_SSL;
    [TColumn('PROXY_HOST','Proxy Host',ldGridLookup ,80)]
    property ProxyHost: String  read FPROXY_HOST write FPROXY_HOST;
    [TColumn('PROXY_PORTA','Proxy Porta',ldGridLookup ,6)]
    property ProxyPorta: String  read FPROXY_PORTA write FPROXY_PORTA;
    [TColumn('PROXY_USER','Proxy User',ldGridLookup ,60)]
    property ProxyUser: String  read FPROXY_USER write FPROXY_USER;
    [TColumn('PROXY_SENHA','Proxy Senha',ldGridLookup ,20)]
    property ProxySenha: String  read FPROXY_SENHA write FPROXY_SENHA;
    [TColumn('IMPRIMIR_USUARIO_RODAPE','Imprimir Usuario Rodape',ldGridLookup ,1)]
    property ImprimirUsuarioRodape: String  read FIMPRIMIR_USUARIO_RODAPE write FIMPRIMIR_USUARIO_RODAPE;
    [TColumn('TEXTO_EMAIL','Texto Email',ldGridLookup ,200)]
    property TextoEmail: String  read FTEXTO_EMAIL write FTEXTO_EMAIL;

  end;

implementation



end.

