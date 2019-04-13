{*******************************************************************************
Title: T2Ti ERP
Description: Classe de controle das configurações.

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
unit ConfiguracaoController;

interface

uses
  Classes, SQLExpr, SysUtils, Generics.Collections, PosicaoComponentesVO, ConfiguracaoVO, ResolucaoVO;

type
  TConfiguracaoController = class
  protected
  public
    class Function VerificaPosicaoTamanho: TObjectList<TPosicaoComponentesVO>;
    class Function PegaConfiguracao: TConfiguracaoVO;
    class procedure GravaUltimaExclusao(ultimaexclusao:Integer);
  end;

implementation

uses UDataModule, Biblioteca;

var
  ConsultaSQL: String;
  Query: TSQLQuery;

class Function TConfiguracaoController.VerificaPosicaoTamanho: TObjectList<TPosicaoComponentesVO>;
var
  PosicaoComponentes: TPosicaoComponentesVO;
  ListaPosicoes : TObjectList<TPosicaoComponentesVO>;
begin
  ConsultaSQL := 'select P.ID, P.NOME, P.ALTURA, P.LARGURA, P.TOPO, P.ESQUERDA, '+
                 'P.TAMANHO_FONTE, P.TEXTO, C.ID_ECF_RESOLUCAO '+
                 'from ECF_POSICAO_COMPONENTES P, ECF_CONFIGURACAO C ' +
                 'where P.ID_ECF_RESOLUCAO=C.ID_ECF_RESOLUCAO';

  ListaPosicoes := TObjectList<TPosicaoComponentesVO>.Create(True);

  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      Query.First;

      while not Query.Eof  do
      begin
        PosicaoComponentes := TPosicaoComponentesVO.Create;
        PosicaoComponentes.Id := Query.FieldByName('ID').AsInteger;
        PosicaoComponentes.NomeComponente := Query.FieldByName('NOME').AsString;
        PosicaoComponentes.Altura := Query.FieldByName('ALTURA').AsInteger;
        PosicaoComponentes.Largura := Query.FieldByName('LARGURA').AsInteger;
        PosicaoComponentes.Topo := Query.FieldByName('TOPO').AsInteger;
        PosicaoComponentes.Esquerda := Query.FieldByName('ESQUERDA').AsInteger;
        PosicaoComponentes.TamanhoFonte := Query.FieldByName('TAMANHO_FONTE').AsInteger;
        PosicaoComponentes.TextoComponente := Query.FieldByName('TEXTO').AsString;
        listaPosicoes.Add(PosicaoComponentes);
        Query.next;
      end;
      result := ListaPosicoes;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;


class procedure TConfiguracaoController.GravaUltimaExclusao(ultimaexclusao:Integer);
begin
  ConsultaSQL :=  'update ECF_CONFIGURACAO set ULTIMA_EXCLUSAO = :pULTIMA_EXCLUSAO ';

  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;

      Query.ParamByName('pULTIMA_EXCLUSAO').AsInteger := ultimaexclusao;
      Query.ExecSQL();
    except
       //
    end;
  finally
    Query.Free;
  end;





end;

class Function TConfiguracaoController.PegaConfiguracao: TConfiguracaoVO;
var
  Configuracao: TConfiguracaoVO;
begin

  ConsultaSQL :='select ' +
                'C.ID_ECF_RESOLUCAO, C.LAUDO, R.RESOLUCAO_TELA, R.LARGURA, R.ALTURA, R.IMAGEM_TELA, ' + //Gilson adicionado campo Laudo
                'R.IMAGEM_MENU, R.IMAGEM_SUBMENU,'+
                'R.HOTTRACK_COLOR, R.ITEM_STYLE_FONT_NAME, R.ITEM_STYLE_FONT_STYLE,'+
                'R.ITEM_STYLE_FONT_COLOR, R.ITEM_SEL_STYLE_COLOR, R.LABEL_TOTAL_GERAL_FONT_COLOR, ' +
                'R.EDITS_COLOR, R.EDITS_FONT_COLOR, R.EDITS_DISABLED_COLOR, R.EDITS_FONT_NAME, R.EDITS_FONT_STYLE, '+
                'C.ID_ECF_IMPRESSORA, C.ID_ECF_CAIXA, ' +
                'C.ID_ECF_EMPRESA, C.MENSAGEM_CUPOM, C.PORTA_ECF, C.BITS_POR_SEGUNDO, ' +
                'C.IP_SERVIDOR, C.IP_SITEF, C.MARKETING_ATIVO, C.QTDE_MAXIMA_CARTOES, '+
                'C.TIPO_TEF, C.TITULO_TELA_CAIXA, C.SINCRONIZADO, C.COR_JANELAS_INTERNAS, '+
                'C.DESCRICAO_SUPRIMENTO, C.DESCRICAO_SANGRIA, C.INDICE_GERENCIAL, '+
                '(select cfop from cfop where cfop.id=c.cfop_ecf) AS CFOP_ECF, (select cfop from cfop where cfop.id=c.cfop_nf2) AS CFOP_NF2, '+
                'C.TIMEOUT_ECF, C.INTERVALO_ECF, I.MODELO_ACBR, '+
                'C.CAMINHO_IMAGENS_PRODUTOS, C.CAMINHO_IMAGENS_MARKETING, C.CAMINHO_IMAGENS_LAYOUT, '+
                'C.DECIMAIS_QUANTIDADE, C.DECIMAIS_VALOR, C.PESQUISA_PARTE, C.CONFIGURACAO_BALANCA, '+
                'C.PARAMETROS_DIVERSOS, C.ULTIMA_EXCLUSAO, C.DATA_ATUALIZACAO_ESTOQUE '+
                'from ECF_RESOLUCAO R, ECF_CONFIGURACAO C, ECF_IMPRESSORA I ' +
                'where C.ID_ECF_RESOLUCAO=R.ID and C.ID_ECF_IMPRESSORA=I.ID';


      {'select ' +
        'C.ID_ECF_RESOLUCAO, C.LAUDO, R.RESOLUCAO_TELA, R.LARGURA, R.ALTURA, R.IMAGEM_TELA, ' +  //Gilson adicionado campo Laudo
        'R.IMAGEM_MENU, R.IMAGEM_SUBMENU,'+
        'R.HOTTRACK_COLOR, R.ITEM_STYLE_FONT_NAME, R.ITEM_STYLE_FONT_STYLE,'+
        'R.ITEM_STYLE_FONT_COLOR, R.ITEM_SEL_STYLE_COLOR, R.LABEL_TOTAL_GERAL_FONT_COLOR, ' +
        'R.EDITS_COLOR, R.EDITS_FONT_COLOR, R.EDITS_DISABLED_COLOR, R.EDITS_FONT_NAME, R.EDITS_FONT_STYLE, '+
		'C.ID_ECF_IMPRESSORA, C.ID_ECF_CAIXA, ' +
        'C.ID_ECF_EMPRESA, C.MENSAGEM_CUPOM, C.PORTA_ECF, C.PORTA_PINPAD, C.BITS_POR_SEGUNDO, ' +
        'C.PORTA_BALANCA, C.IP_SERVIDOR, C.IP_SITEF, C.MARKETING_ATIVO, C.QTDE_MAXIMA_CARTOES, '+
        'C.TIPO_TEF, C.TITULO_TELA_CAIXA, C.SINCRONIZADO, C.COR_JANELAS_INTERNAS, '+
        'C.DESCRICAO_SUPRIMENTO, C.DESCRICAO_SANGRIA, C.INDICE_GERENCIAL_DAV, '+
        'C.CFOP_ECF, C.CFOP_NF2, C.TIMEOUT_ECF, C.INTERVALO_ECF, I.MODELO_ACBR, '+
        'C.CAMINHO_IMAGENS_PRODUTOS, C.CAMINHO_IMAGENS_MARKETING, C.CAMINHO_IMAGENS_LAYOUT, '+
        'C.DECIMAIS_QUANTIDADE, C.DECIMAIS_VALOR, C.PESQUISA_PARTE, C.CONFIGURACAO_BALANCA, '+
        'C.PARAMETROS_DIVERSOS, C.ULTIMA_EXCLUSAO '+
      'from ECF_RESOLUCAO R, ECF_CONFIGURACAO C, ECF_IMPRESSORA I ' +
      'where C.ID_ECF_RESOLUCAO=R.ID and C.ID_ECF_IMPRESSORA=I.ID';  }





  Configuracao := TConfiguracaoVO.Create;
  Configuracao.ResolucaoVO := TResolucaoVO.Create;

  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;

      Configuracao.MensagemCupom := Query.FieldByName('MENSAGEM_CUPOM').AsString;
      Configuracao.IdEmpresa := Query.FieldByName('ID_ECF_EMPRESA').AsInteger;
      Configuracao.IdCaixa := Query.FieldByName('ID_ECF_CAIXA').AsInteger;
      Configuracao.IdImpressora := Query.FieldByName('ID_ECF_IMPRESSORA').AsInteger;
      Configuracao.PortaECF := Query.FieldByName('PORTA_ECF').AsString;
      //Configuracao.PortaBalanca := Query.FieldByName('PORTA_BALANCA').AsString;
      //Configuracao.PortaPinPad := Query.FieldByName('PORTA_PINPAD').AsString;
      Configuracao.IpServidor := Query.FieldByName('IP_SERVIDOR').AsString;
      Configuracao.IpSitef := Query.FieldByName('IP_SITEF').AsString;
      Configuracao.TipoTEF := Query.FieldByName('TIPO_TEF').AsString;
      Configuracao.TituloTelaCaixa := Query.FieldByName('TITULO_TELA_CAIXA').AsString;
      Configuracao.CaminhoImagensProdutos := Query.FieldByName('CAMINHO_IMAGENS_PRODUTOS').AsString;
      Configuracao.CaminhoImagensMarketing := Query.FieldByName('CAMINHO_IMAGENS_MARKETING').AsString;
      Configuracao.CaminhoImagensLayout := Query.FieldByName('CAMINHO_IMAGENS_LAYOUT').AsString;
      Configuracao.MarketingAtivo := Query.FieldByName('MARKETING_ATIVO').AsString;
      Configuracao.CorJanelasInternas := Query.FieldByName('COR_JANELAS_INTERNAS').AsString;
      Configuracao.CFOPECF := Query.FieldByName('CFOP_ECF').AsInteger;
      Configuracao.CFOPNF2 := Query.FieldByName('CFOP_NF2').AsInteger;
      Configuracao.TimeOutECF := Query.FieldByName('TIMEOUT_ECF').AsInteger;
      Configuracao.IntervaloECF := Query.FieldByName('INTERVALO_ECF').AsInteger;
      Configuracao.ModeloImpressora := Query.FieldByName('MODELO_ACBR').AsString;
      Configuracao.DescricaoSuprimento := Query.FieldByName('DESCRICAO_SUPRIMENTO').AsString;
      Configuracao.DescricaoSangria := Query.FieldByName('DESCRICAO_SANGRIA').AsString;
      Configuracao.IndiceGerencial := Query.FieldByName('INDICE_GERENCIAL').AsString;
      Configuracao.DecimaisQuantidade := Query.FieldByName('DECIMAIS_QUANTIDADE').AsInteger;
      Configuracao.DecimaisValor := Query.FieldByName('DECIMAIS_VALOR').AsInteger;
      Configuracao.BitsPorSegundo := Query.FieldByName('BITS_POR_SEGUNDO').AsInteger;
      Configuracao.QuantidadeMaximaCartoes := Query.FieldByName('QTDE_MAXIMA_CARTOES').AsInteger;
      Configuracao.PesquisaParte := Query.FieldByName('PESQUISA_PARTE').AsString;
      Configuracao.Laudo  := Query.FieldByName('LAUDO').AsString;  //Gilson Adicionado Campo Laudo
      Configuracao.ConfiguracaoBalanca := trim(Query.FieldByName('CONFIGURACAO_BALANCA').AsString);
      Configuracao.ParametrosDiversos := trim(Query.FieldByName('PARAMETROS_DIVERSOS').AsString);
      Configuracao.UltimaExclusao := Query.FieldByName('ULTIMA_EXCLUSAO').AsInteger;
      Configuracao.DataAtualizacaoEstoque :=  DataParaTexto(Query.FieldByName('DATA_ATUALIZACAO_ESTOQUE').AsDateTime);

      Configuracao.ResolucaoVO.ImagemTela := Query.FieldByName('IMAGEM_TELA').AsString;
      Configuracao.ResolucaoVO.ImagemMenu := Query.FieldByName('IMAGEM_MENU').AsString;
      Configuracao.ResolucaoVO.ImagemSubMenu := Query.FieldByName('IMAGEM_SUBMENU').AsString;
      Configuracao.ResolucaoVO.ResolucaoTela := Query.FieldByName('RESOLUCAO_TELA').AsString;
      Configuracao.ResolucaoVO.Largura := Query.FieldByName('LARGURA').AsInteger;
      Configuracao.ResolucaoVO.Altura := Query.FieldByName('ALTURA').AsInteger;
      Configuracao.ResolucaoVO.HotTrackColor := Query.FieldByName('HOTTRACK_COLOR').AsString;
      Configuracao.ResolucaoVO.ItemStyleFontName := Query.FieldByName('ITEM_STYLE_FONT_NAME').AsString;
      Configuracao.ResolucaoVO.ItemStyleFontColor := Query.FieldByName('ITEM_STYLE_FONT_COLOR').AsString;
      Configuracao.ResolucaoVO.ItemSelStyleColor := Query.FieldByName('ITEM_SEL_STYLE_COLOR').AsString;
      Configuracao.ResolucaoVO.LabelTotalGeralFontColor := Query.FieldByName('LABEL_TOTAL_GERAL_FONT_COLOR').AsString;
      Configuracao.ResolucaoVO.ItemStyleFontStyle := Query.FieldByName('ITEM_STYLE_FONT_STYLE').AsString;

      //*************
      Configuracao.ResolucaoVO.EditColor := Query.FieldByName('EDITS_COLOR').AsString;
      Configuracao.ResolucaoVO.EditFontColor := Query.FieldByName('EDITS_FONT_COLOR').AsString;
      Configuracao.ResolucaoVO.EditDisabledColor := Query.FieldByName('EDITS_DISABLED_COLOR').AsString;
      Configuracao.ResolucaoVO.EditFontName := Query.FieldByName('EDITS_FONT_NAME').AsString;
      Configuracao.ResolucaoVO.EditFontStyle := Query.FieldByName('EDITS_FONT_STYLE').AsString;


      result := Configuracao;
    except
      raise Exception.Create('Ocorreu um erro ao tentar ler as configurações');
    end;
  finally
    Query.Free;
  end;
end;

end.
