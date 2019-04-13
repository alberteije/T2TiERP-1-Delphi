{*******************************************************************************
Title: T2Ti ERP
Description: Classe de controle da empresa.

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
unit NfeConfiguracaoController;

interface

uses
  Classes, SQLExpr, SysUtils, NfeConfiguracaoVO;

type
  TNfeConfiguracaoController = class
  protected
  public
    class Function PegaConfiguracao: TNfeConfiguracaoVO;
  end;

implementation

uses UDataModule;

var
  ConsultaSQL: String;
  Query: TSQLQuery;

class Function TNfeConfiguracaoController.PegaConfiguracao: TNfeConfiguracaoVO;
var
  NfeConfig: TNfeConfiguracaoVO;
begin
  ConsultaSQL := 'select * from NFE_CONFIGURACAO';

  NfeConfig := TNfeConfiguracaoVO.Create;

  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;

      NfeConfig.Id := Query.FieldByName('ID').AsInteger;
      NfeConfig.CertificaDigital := Query.FieldByName('CERTIFICADO_DIGITAL').AsString;
      NfeConfig.CaminhoCertificado := Query.FieldByName('CAMINHO_CERTIFICADO').AsString;
      NfeConfig.SenhaCertificado := Query.FieldByName('SENHA_CERTIFICADO').AsString;
      NfeConfig.FormaImpressaoDanfe := Query.FieldByName('FORMATO_IMPRESSAO_DANFE').AsString;
      NfeConfig.Logomarca := Query.FieldByName('LOGOMARCA').AsString;
      NfeConfig.CaminhoSalvarXml := Query.FieldByName('CAMINHO_SALVAR_XML').AsString;
      NfeConfig.SalvaXml := Query.FieldByName('SALVA_XML').AsString;
      NfeConfig.FonteAtt := Query.FieldByName('FONTE_ATT').AsInteger;
      NfeConfig.FonteOutrosCampos := Query.FieldByName('FONTE_OUTROS_CAMPOS').AsInteger;
      NfeConfig.FonteRazaoSocial := Query.FieldByName('FONTE_RAZAO_SOCIAL').AsInteger;
      NfeConfig.ImprimirDetalheEspecifico := Query.FieldByName('IMPRIMIR_DETALHE_ESPECIFICO').AsString;
      NfeConfig.UfWebservice := Query.FieldByName('UF_WEBSERVICE').AsString;
      NfeConfig.Ambiente := Query.FieldByName('AMBIENTE').AsString;
      NfeConfig.NomeHost := Query.FieldByName('NOME_HOST').AsString;
      NfeConfig.Porta := Query.FieldByName('PORTA').AsInteger;
      NfeConfig.Usuario := Query.FieldByName('USUARIO').AsString;
      NfeConfig.Senha := Query.FieldByName('SENHA').AsString;
      NfeConfig.Assunto := Query.FieldByName('ASSUNTO').AsString;
      NfeConfig.AutenticaSsl := Query.FieldByName('AUTENTICA_SSL').AsString;
      NfeConfig.ProxyHost := Query.FieldByName('PROXY_HOST').AsString;
      NfeConfig.ProxyPorta := Query.FieldByName('PROXY_PORTA').AsString;
      NfeConfig.ProxyUser := Query.FieldByName('PROXY_USER').AsString;
      NfeConfig.ProxySenha := Query.FieldByName('PROXY_SENHA').AsString;
      NfeConfig.ImprimirUsuarioRodape := Query.FieldByName('IMPRIMIR_USUARIO_RODAPE').AsString;
      NfeConfig.TextoEmail := Query.FieldByName('TEXTO_EMAIL').AsString;

      result := NfeConfig;
    except
      result := nil;
    end;
  finally

    Query.Free;
  end;
end;





end.
