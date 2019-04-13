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
  Classes, Forms, SQLExpr, SysUtils, Generics.Collections, PosicaoComponentesVO, ConfiguracaoVO, ResolucaoVO;

type
  TConfiguracaoController = class
  protected
  public
    class function VerificaPosicaoTamanho: TObjectList<TPosicaoComponentesVO>;
    class function PegaConfiguracao: TConfiguracaoVO;
    class procedure GravaUltimaExclusao(UltimaExclusao: Integer);
    class procedure IntegracaoConfiguracao;
    class procedure GravaDataAtulaizacaoEstoque(DataAtualizacao: String);
    class function ConsultaDataAtualizacaoEstoque: String;
    class function ConsultaIdConfiguracao(Id:Integer):boolean;
    class function GravaCargaConfiguracao(vTupla: String): Boolean;
  end;

implementation

uses UDataModule, UCaixa, Biblioteca;

var
  ConsultaSQL: String;
  Query: TSQLQuery;


class procedure TConfiguracaoController.IntegracaoConfiguracao;
var
  PathConfig,  Identificacao, Caixa: string;
  atConfig: TextFile;
begin

  Caixa := Configuracao.NomeCaixa;
  Identificacao := 'E'+IntToStr(Configuracao.IdEmpresa)+'X'+DevolveInteiro(Caixa)+'D'+DevolveInteiro(DateTimeToStr(now));

  PathConfig := ExtractFilePath(Application.ExeName)+'Script\Config.txt';
  AssignFile(atConfig, PathConfig);
  Application.ProcessMessages;

  if FileExists(PathConfig) then
    Append(atConfig)
  else
    Rewrite(atConfig);

  ConsultaSQL := 'select * from ECF_RESOLUCAO';
  try
    DecimalSeparator := '.';
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      Query.First;

      while not Query.Eof  do
      begin
        Write(
          atConfig,'RESOLUCAO|'+
          Identificacao+'RES'+Query.FieldByName('ID').AsString+'|'+
          Caixa+'|'+
          IntToStr(Configuracao.IdEmpresa)+'|'+
          Query.FieldByName('ID').AsString+'|'+                                                                                  //    ID,
          QuotedStr(Caixa)+'|'+                                                                                                  //    NOME_CAIXA,
          QuotedStr(StringReplace((Query.FieldByName('ID').AsString),'|','[#]',[rfReplaceAll]))+'|'+                             //    ID_GERADO_CAIXA,
          QuotedStr(IntToStr(Configuracao.IdEmpresa))+'|'+                                                                       //    ID_EMPRESA,
          QuotedStr(StringReplace((Query.FieldByName('RESOLUCAO_TELA').AsString),'|','[#]',[rfReplaceAll]))+'|'+                 //    RESOLUCAO_TELA,
          QuotedStr(StringReplace((Query.FieldByName('LARGURA').AsString),'|','[#]',[rfReplaceAll]))+'|'+                        //    LARGURA,
          QuotedStr(StringReplace((Query.FieldByName('ALTURA').AsString),'|','[#]',[rfReplaceAll]))+'|'+                         //    ALTURA,
          QuotedStr(StringReplace((Query.FieldByName('IMAGEM_TELA').AsString),'|','[#]',[rfReplaceAll]))+'|'+                    //    IMAGEM_TELA,
          QuotedStr(StringReplace((Query.FieldByName('IMAGEM_MENU').AsString),'|','[#]',[rfReplaceAll]))+'|'+                    //    IMAGEM_MENU,
          QuotedStr(StringReplace((Query.FieldByName('IMAGEM_SUBMENU').AsString),'|','[#]',[rfReplaceAll]))+'|'+                 //    IMAGEM_SUBMENU,
          QuotedStr(StringReplace((Query.FieldByName('HOTTRACK_COLOR').AsString),'|','[#]',[rfReplaceAll]))+'|'+                 //    HOTTRACK_COLOR,
          QuotedStr(StringReplace((Query.FieldByName('ITEM_STYLE_FONT_NAME').AsString),'|','[#]',[rfReplaceAll]))+'|'+           //    ITEM_STYLE_FONT_NAME,
          QuotedStr(StringReplace((Query.FieldByName('ITEM_STYLE_FONT_COLOR').AsString),'|','[#]',[rfReplaceAll]))+'|'+          //    ITEM_STYLE_FONT_COLOR,
          QuotedStr(StringReplace((Query.FieldByName('ITEM_SEL_STYLE_COLOR').AsString),'|','[#]',[rfReplaceAll]))+'|'+           //    ITEM_SEL_STYLE_COLOR,
          QuotedStr(StringReplace((Query.FieldByName('LABEL_TOTAL_GERAL_FONT_COLOR').AsString),'|','[#]',[rfReplaceAll]))+'|'+   //    LABEL_TOTAL_GERAL_FONT_COLOR,
          QuotedStr(StringReplace((Query.FieldByName('ITEM_STYLE_FONT_STYLE').AsString),'|','[#]',[rfReplaceAll]))+'|'+          //    ITEM_STYLE_FONT_STYLE,
          QuotedStr(StringReplace((Query.FieldByName('EDITS_COLOR').AsString),'|','[#]',[rfReplaceAll]))+'|'+                    //    EDITS_COLOR,
          QuotedStr(StringReplace((Query.FieldByName('EDITS_FONT_COLOR').AsString),'|','[#]',[rfReplaceAll]))+'|'+               //    EDITS_FONT_COLOR,
          QuotedStr(StringReplace((Query.FieldByName('EDITS_DISABLED_COLOR').AsString),'|','[#]',[rfReplaceAll]))+'|'+           //    EDITS_DISABLED_COLOR,
          QuotedStr(StringReplace((Query.FieldByName('EDITS_FONT_NAME').AsString),'|','[#]',[rfReplaceAll]))+'|'+                //    EDITS_FONT_NAME,
          QuotedStr(StringReplace((Query.FieldByName('EDITS_FONT_STYLE').AsString),'|','[#]',[rfReplaceAll]))+'|'                //    EDITS_FONT_STYLE,
        );
        Writeln(atConfig);
        Application.ProcessMessages;
        Query.next;
      end;

      ConsultaSQL := 'select * from ECF_POSICAO_COMPONENTES';
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      Query.First;

      while not Query.Eof  do
      begin
        Write(
          atConfig,'COMPONENTES|'+
          Identificacao+'COMP'+Query.FieldByName('ID').AsString+'|'+
          Caixa+'|'+
          IntToStr(Configuracao.IdEmpresa)+'|'+
          Query.FieldByName('ID').AsString+'|'+
          QuotedStr(Caixa)+'|'+                                                                                         //    NOME_CAIXA,
          QuotedStr(StringReplace((Query.FieldByName('ID').AsString),'|','[#]',[rfReplaceAll]))+'|'+                    //    ID_GERADO_CAIXA,
          QuotedStr(IntToStr(Configuracao.IdEmpresa))+'|'+                                                              //    ID_EMPRESA,
          QuotedStr(StringReplace((Query.FieldByName('NOME').AsString),'|','[#]',[rfReplaceAll]))+'|'+                  //    NOME,
          QuotedStr(StringReplace((Query.FieldByName('ALTURA').AsString),'|','[#]',[rfReplaceAll]))+'|'+                //    ALTURA,
          QuotedStr(StringReplace((Query.FieldByName('LARGURA').AsString),'|','[#]',[rfReplaceAll]))+'|'+               //    LARGURA,
          QuotedStr(StringReplace((Query.FieldByName('TOPO').AsString),'|','[#]',[rfReplaceAll]))+'|'+                  //    TOPO,
          QuotedStr(StringReplace((Query.FieldByName('ESQUERDA').AsString),'|','[#]',[rfReplaceAll]))+'|'+              //    ESQUERDA,
          QuotedStr(StringReplace((Query.FieldByName('TAMANHO_FONTE').AsString),'|','[#]',[rfReplaceAll]))+'|'+         //    TAMANHO_FONTE,
          QuotedStr(StringReplace((Query.FieldByName('TEXTO').AsString),'|','[#]',[rfReplaceAll]))+'|'+                 //    TEXTO,
          QuotedStr(StringReplace((Query.FieldByName('ID_ECF_RESOLUCAO').AsString),'|','[#]',[rfReplaceAll]))+'|'       //    ID_ECF_RESOLUCAO,
        );
        Writeln(atConfig);
        Application.ProcessMessages;
        Query.next;
      end;

      ConsultaSQL := 'select * from ECF_IMPRESSORA';
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      Query.First;

      while not Query.Eof  do
      begin
        Write(
          atConfig,'IMPRESSORA|'+
          Identificacao+'IMP'+Query.FieldByName('ID').AsString+'|'+
          Caixa+'|'+
          IntToStr(Configuracao.IdEmpresa)+'|'+
          Query.FieldByName('ID').AsString+'|'+
          QuotedStr(StringReplace((Query.FieldByName('ID').AsString),'|','[#]',[rfReplaceAll]))+'|'+
          QuotedStr(StringReplace((Query.FieldByName('NUMERO').AsString),'|','[#]',[rfReplaceAll]))+'|'+
          QuotedStr(StringReplace((Query.FieldByName('CODIGO').AsString),'|','[#]',[rfReplaceAll]))+'|'+
          QuotedStr(StringReplace((Query.FieldByName('SERIE').AsString),'|','[#]',[rfReplaceAll]))+'|'+
          QuotedStr(StringReplace((Query.FieldByName('IDENTIFICACAO').AsString),'|','[#]',[rfReplaceAll]))+'|'+
          QuotedStr(StringReplace((Query.FieldByName('MC').AsString),'|','[#]',[rfReplaceAll]))+'|'+
          QuotedStr(StringReplace((Query.FieldByName('MD').AsString),'|','[#]',[rfReplaceAll]))+'|'+
          QuotedStr(StringReplace((Query.FieldByName('VR').AsString),'|','[#]',[rfReplaceAll]))+'|'+
          QuotedStr(StringReplace((Query.FieldByName('TIPO').AsString),'|','[#]',[rfReplaceAll]))+'|'+
          QuotedStr(StringReplace((Query.FieldByName('MARCA').AsString),'|','[#]',[rfReplaceAll]))+'|'+
          QuotedStr(StringReplace((Query.FieldByName('MODELO').AsString),'|','[#]',[rfReplaceAll]))+'|'+
          QuotedStr(StringReplace((Query.FieldByName('MODELO_ACBR').AsString),'|','[#]',[rfReplaceAll]))+'|'+
          QuotedStr(StringReplace((Query.FieldByName('MODELO_DOCUMENTO_FISCAL').AsString),'|','[#]',[rfReplaceAll]))+'|'+
          QuotedStr(StringReplace((Query.FieldByName('VERSAO').AsString),'|','[#]',[rfReplaceAll]))+'|'+
          QuotedStr(StringReplace((Query.FieldByName('LE').AsString),'|','[#]',[rfReplaceAll]))+'|'+
          QuotedStr(StringReplace((Query.FieldByName('LEF').AsString),'|','[#]',[rfReplaceAll]))+'|'+
          QuotedStr(StringReplace((Query.FieldByName('MFD').AsString),'|','[#]',[rfReplaceAll]))+'|'+
          QuotedStr(StringReplace((Query.FieldByName('LACRE_NA_MFD').AsString),'|','[#]',[rfReplaceAll]))+'|'+
          QuotedStr(StringReplace((Query.FieldByName('DOCTO').AsString),'|','[#]',[rfReplaceAll]))+'|'
        );
        Writeln(atConfig);
        Application.ProcessMessages;
        Query.next;
      end;

      ConsultaSQL := 'select * from ECF_CONFIGURACAO';
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      Query.First;

      while not Query.Eof  do
      begin
        Write(
          atConfig,'CONFIGURACAO|'+
          Identificacao+'CONF'+Query.FieldByName('ID').AsString+'|'+
          caixa+'|'+
          IntToStr(Configuracao.IdEmpresa)+'|'+
          Query.FieldByName('ID').AsString+'|'+
          QuotedStr(StringReplace((Query.FieldByName('ID').AsString),'|','[#]',[rfReplaceAll]))+'|'+
          QuotedStr(StringReplace((Query.FieldByName('ID_ECF_IMPRESSORA').AsString),'|','[#]',[rfReplaceAll]))+'|'+
          QuotedStr(StringReplace((Query.FieldByName('ID_ECF_RESOLUCAO').AsString),'|','[#]',[rfReplaceAll]))+'|'+
          QuotedStr(StringReplace((Query.FieldByName('ID_ECF_CAIXA').AsString),'|','[#]',[rfReplaceAll]))+'|'+
          QuotedStr(StringReplace((Query.FieldByName('ID_ECF_EMPRESA').AsString),'|','[#]',[rfReplaceAll]))+'|'+
          QuotedStr(StringReplace((Query.FieldByName('MENSAGEM_CUPOM').AsString),'|','[#]',[rfReplaceAll]))+'|'+
          QuotedStr(StringReplace((Query.FieldByName('PORTA_ECF').AsString),'|','[#]',[rfReplaceAll]))+'|'+
          QuotedStr(StringReplace((Query.FieldByName('IP_SERVIDOR').AsString),'|','[#]',[rfReplaceAll]))+'|'+
          QuotedStr(StringReplace((Query.FieldByName('IP_SITEF').AsString),'|','[#]',[rfReplaceAll]))+'|'+
          QuotedStr(StringReplace((Query.FieldByName('TIPO_TEF').AsString),'|','[#]',[rfReplaceAll]))+'|'+
          QuotedStr(StringReplace((Query.FieldByName('TITULO_TELA_CAIXA').AsString),'|','[#]',[rfReplaceAll]))+'|'+
          QuotedStr(StringReplace((Query.FieldByName('CAMINHO_IMAGENS_PRODUTOS').AsString),'|','[#]',[rfReplaceAll]))+'|'+
          QuotedStr(StringReplace((Query.FieldByName('CAMINHO_IMAGENS_MARKETING').AsString),'|','[#]',[rfReplaceAll]))+'|'+
          QuotedStr(StringReplace((Query.FieldByName('CAMINHO_IMAGENS_LAYOUT').AsString),'|','[#]',[rfReplaceAll]))+'|'+
          QuotedStr(StringReplace((Query.FieldByName('COR_JANELAS_INTERNAS').AsString),'|','[#]',[rfReplaceAll]))+'|'+
          QuotedStr(StringReplace((Query.FieldByName('MARKETING_ATIVO').AsString),'|','[#]',[rfReplaceAll]))+'|'+
          QuotedStr(StringReplace((Query.FieldByName('CFOP_ECF').AsString),'|','[#]',[rfReplaceAll]))+'|'+
          QuotedStr(StringReplace((Query.FieldByName('CFOP_NF2').AsString),'|','[#]',[rfReplaceAll]))+'|'+
          QuotedStr(StringReplace((Query.FieldByName('TIMEOUT_ECF').AsString),'|','[#]',[rfReplaceAll]))+'|'+
          QuotedStr(StringReplace((Query.FieldByName('INTERVALO_ECF').AsString),'|','[#]',[rfReplaceAll]))+'|'+
          QuotedStr(StringReplace((Query.FieldByName('DESCRICAO_SUPRIMENTO').AsString),'|','[#]',[rfReplaceAll]))+'|'+
          QuotedStr(StringReplace((Query.FieldByName('DESCRICAO_SANGRIA').AsString),'|','[#]',[rfReplaceAll]))+'|'+
          QuotedStr(StringReplace((Query.FieldByName('TEF_TIPO_GP').AsString),'|','[#]',[rfReplaceAll]))+'|'+
          QuotedStr(StringReplace((Query.FieldByName('TEF_TEMPO_ESPERA').AsString),'|','[#]',[rfReplaceAll]))+'|'+
          QuotedStr(StringReplace((Query.FieldByName('TEF_ESPERA_STS').AsString),'|','[#]',[rfReplaceAll]))+'|'+
          QuotedStr(StringReplace((Query.FieldByName('TEF_NUMERO_VIAS').AsString),'|','[#]',[rfReplaceAll]))+'|'+
          QuotedStr(StringReplace((Query.FieldByName('DECIMAIS_QUANTIDADE').AsString),'|','[#]',[rfReplaceAll]))+'|'+
          QuotedStr(StringReplace((Query.FieldByName('DECIMAIS_VALOR').AsString),'|','[#]',[rfReplaceAll]))+'|'+
          QuotedStr(StringReplace((Query.FieldByName('BITS_POR_SEGUNDO').AsString),'|','[#]',[rfReplaceAll]))+'|'+
          QuotedStr(StringReplace((Query.FieldByName('QTDE_MAXIMA_CARTOES').AsString),'|','[#]',[rfReplaceAll]))+'|'+
          QuotedStr(StringReplace((Query.FieldByName('PESQUISA_PARTE').AsString),'|','[#]',[rfReplaceAll]))+'|'+
          QuotedStr(StringReplace((Query.FieldByName('CONFIGURACAO_BALANCA').AsString),'|','[#]',[rfReplaceAll]))+'|'+
          QuotedStr(StringReplace((Query.FieldByName('PARAMETROS_DIVERSOS').AsString),'|','[#]',[rfReplaceAll]))+'|'+
          QuotedStr(StringReplace((Query.FieldByName('ULTIMA_EXCLUSAO').AsString),'|','[#]',[rfReplaceAll]))+'|'+
          QuotedStr(StringReplace((Query.FieldByName('LAUDO').AsString),'|','[#]',[rfReplaceAll]))+'|'+
          QuotedStr(StringReplace((Query.FieldByName('INDICE_GERENCIAL').AsString),'|','[#]',[rfReplaceAll]))+'|'+
          QuotedStr(StringReplace((Query.FieldByName('DATA_ATUALIZACAO_ESTOQUE').AsString),'|','[#]',[rfReplaceAll]))+'|'+
          QuotedStr(StringReplace((Query.FieldByName('SINCRONIZADO').AsString),'|','[#]',[rfReplaceAll]))+'|'
        );
        Writeln(atConfig);
        Application.ProcessMessages;
        Query.next;
      end;

    except
      //
    end;
  finally
    CloseFile(atConfig);
    DecimalSeparator := ',';
    Application.ProcessMessages;
    FCaixa.ExportaParaRetaguarda('Config.txt',3);
    Query.Free;
  end;
end;

class function TConfiguracaoController.VerificaPosicaoTamanho: TObjectList<TPosicaoComponentesVO>;
var
  PosicaoComponentes: TPosicaoComponentesVO;
  ListaPosicoes : TObjectList<TPosicaoComponentesVO>;
begin
  ConsultaSQL := 'select '+
                 ' P.ID, '+
                 ' P.NOME, '+
                 ' P.ALTURA, '+
                 ' P.LARGURA, '+
                 ' P.TOPO, '+
                 ' P.ESQUERDA, '+
                 ' P.TAMANHO_FONTE, '+
                 ' P.TEXTO, '+
                 ' C.ID_ECF_RESOLUCAO '+
                 ' from '+
                 ' ECF_POSICAO_COMPONENTES P, ECF_CONFIGURACAO C ' +
                 ' where '+
                 ' P.ID_ECF_RESOLUCAO=C.ID_ECF_RESOLUCAO';

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


class procedure TConfiguracaoController.GravaDataAtulaizacaoEstoque(DataAtualizacao: String);
begin
  ConsultaSQL :=  'update ECF_CONFIGURACAO set DATA_ATUALIZACAO_ESTOQUE = :pData';
  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.ParamByName('pData').AsDate := TextoParaData(DataAtualizacao);
      Query.ExecSQL();
    except
    end;
  finally
    Query.Free;
  end;
end;

class procedure TConfiguracaoController.GravaUltimaExclusao(UltimaExclusao: Integer);
begin
  ConsultaSQL :=  'update ECF_CONFIGURACAO set ULTIMA_EXCLUSAO = :pULTIMA_EXCLUSAO';
  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;

      Query.ParamByName('pULTIMA_EXCLUSAO').AsInteger := ultimaexclusao;
      Query.ExecSQL();
    except
    end;
  finally
    Query.Free;
  end;
end;

class function TConfiguracaoController.PegaConfiguracao: TConfiguracaoVO;
var
  Configuracao: TConfiguracaoVO;
  Linha: String;
begin

  ConsultaSQL :='select ' +
                ' C.ID_ECF_IMPRESSORA, '+
                ' C.ID_ECF_RESOLUCAO, '+
                ' C.ID_ECF_CAIXA, ' +
                ' C.ID_ECF_EMPRESA, '+
                ' C.MENSAGEM_CUPOM, '+
                ' C.PORTA_ECF, '+
                ' C.IP_SERVIDOR, '+
                ' C.IP_SITEF, '+
                ' C.TIPO_TEF, '+
                ' C.TITULO_TELA_CAIXA, '+
                ' C.CAMINHO_IMAGENS_PRODUTOS, '+
                ' C.CAMINHO_IMAGENS_MARKETING, '+
                ' C.CAMINHO_IMAGENS_LAYOUT, '+
                ' C.COR_JANELAS_INTERNAS, '+
                ' C.MARKETING_ATIVO, '+
                ' C.CFOP_ECF, '+
                ' C.CFOP_NF2, '+
                ' C.TIMEOUT_ECF, '+
                ' C.INTERVALO_ECF, '+
                ' C.DESCRICAO_SUPRIMENTO, '+
                ' C.DESCRICAO_SANGRIA, '+
                ' C.TEF_TIPO_GP, '+
                ' C.TEF_TEMPO_ESPERA, '+
                ' C.TEF_ESPERA_STS, '+
                ' C.TEF_NUMERO_VIAS, '+
                ' C.DECIMAIS_QUANTIDADE, '+
                ' C.DECIMAIS_VALOR, '+
                ' C.BITS_POR_SEGUNDO, ' +
                ' C.QTDE_MAXIMA_CARTOES, '+
                ' C.PESQUISA_PARTE, '+
                ' C.CONFIGURACAO_BALANCA, '+
                ' C.PARAMETROS_DIVERSOS, '+
                ' C.ULTIMA_EXCLUSAO, '+
                ' C.LAUDO, '+
                ' C.INDICE_GERENCIAL, '+
                ' C.DATA_ATUALIZACAO_ESTOQUE, '+
                ' C.SINCRONIZADO, '+
                ' R.RESOLUCAO_TELA, '+
                ' R.LARGURA, '+
                ' R.ALTURA, '+
                ' R.IMAGEM_TELA, ' +
                ' R.IMAGEM_MENU, '+
                ' R.IMAGEM_SUBMENU, '+
                ' R.HOTTRACK_COLOR, '+
                ' R.ITEM_STYLE_FONT_NAME, '+
                ' R.ITEM_STYLE_FONT_COLOR, '+
                ' R.ITEM_SEL_STYLE_COLOR, '+
                ' R.LABEL_TOTAL_GERAL_FONT_COLOR, ' +
                ' R.ITEM_STYLE_FONT_STYLE,'+
                ' R.EDITS_COLOR, '+
                ' R.EDITS_FONT_COLOR, '+
                ' R.EDITS_DISABLED_COLOR, '+
                ' R.EDITS_FONT_NAME, '+
                ' R.EDITS_FONT_STYLE, '+
                ' (select nome from ECF_CAIXA where ECF_CAIXA.id=c.ID_ECF_CAIXA) AS NOME_CAIXA,'+
                ' I.MODELO_ACBR, '+
                ' I.SERIE '+
                'from '+
                ' ECF_RESOLUCAO R, ECF_CONFIGURACAO C, ECF_IMPRESSORA I ' +
                'where '+
                ' C.ID_ECF_RESOLUCAO=R.ID and C.ID_ECF_IMPRESSORA=I.ID';

  Configuracao := TConfiguracaoVO.Create;
  Configuracao.ResolucaoVO := TResolucaoVO.Create;

  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;

      Configuracao.IdImpressora := Query.FieldByName('ID_ECF_IMPRESSORA').AsInteger;
      Configuracao.IdCaixa := Query.FieldByName('ID_ECF_CAIXA').AsInteger;
      Configuracao.IdEmpresa := FDataModule.EmpresaID; //Query.FieldByName('ID_ECF_EMPRESA').AsInteger;
      Configuracao.MensagemCupom := Query.FieldByName('MENSAGEM_CUPOM').AsString;
      Configuracao.PortaECF := Query.FieldByName('PORTA_ECF').AsString;
      Configuracao.IpServidor := Query.FieldByName('IP_SERVIDOR').AsString;
      Configuracao.IpSitef := Query.FieldByName('IP_SITEF').AsString;
      Configuracao.TipoTEF := Query.FieldByName('TIPO_TEF').AsString;
      Configuracao.TituloTelaCaixa := Query.FieldByName('TITULO_TELA_CAIXA').AsString;
      Configuracao.CaminhoImagensProdutos := Query.FieldByName('CAMINHO_IMAGENS_PRODUTOS').AsString;
      Configuracao.CaminhoImagensMarketing := Query.FieldByName('CAMINHO_IMAGENS_MARKETING').AsString;
      Configuracao.CaminhoImagensLayout := Query.FieldByName('CAMINHO_IMAGENS_LAYOUT').AsString;
      Configuracao.CorJanelasInternas := Query.FieldByName('COR_JANELAS_INTERNAS').AsString;
      Configuracao.MarketingAtivo := Query.FieldByName('MARKETING_ATIVO').AsString;
      Configuracao.CFOPECF := Query.FieldByName('CFOP_ECF').AsInteger;
      Configuracao.CFOPNF2 := Query.FieldByName('CFOP_NF2').AsInteger;
      Configuracao.TimeOutECF := Query.FieldByName('TIMEOUT_ECF').AsInteger;
      Configuracao.IntervaloECF := Query.FieldByName('INTERVALO_ECF').AsInteger;
      Configuracao.DescricaoSuprimento := Query.FieldByName('DESCRICAO_SUPRIMENTO').AsString;
      Configuracao.DescricaoSangria := Query.FieldByName('DESCRICAO_SANGRIA').AsString;
      Configuracao.TEFTipoGP := Query.FieldByName('TEF_TIPO_GP').AsInteger;
      Configuracao.TEFTempoEspera := Query.FieldByName('TEF_TEMPO_ESPERA').AsInteger;
      Configuracao.TEFEsperaSTS := Query.FieldByName('TEF_ESPERA_STS').AsInteger;
      Configuracao.TEFNumeroVias := Query.FieldByName('TEF_NUMERO_VIAS').AsInteger;
      Configuracao.DecimaisQuantidade := Query.FieldByName('DECIMAIS_QUANTIDADE').AsInteger;
      Configuracao.DecimaisValor := Query.FieldByName('DECIMAIS_VALOR').AsInteger;
      Configuracao.BitsPorSegundo := Query.FieldByName('BITS_POR_SEGUNDO').AsInteger;
      Configuracao.QuantidadeMaximaCartoes := Query.FieldByName('QTDE_MAXIMA_CARTOES').AsInteger;
      Configuracao.PesquisaParte := Query.FieldByName('PESQUISA_PARTE').AsString;
      Configuracao.ConfiguracaoBalanca := trim(Query.FieldByName('CONFIGURACAO_BALANCA').AsString);
      Configuracao.ParametrosDiversos := trim(Query.FieldByName('PARAMETROS_DIVERSOS').AsString);
      Configuracao.UltimaExclusao := Query.FieldByName('ULTIMA_EXCLUSAO').AsInteger;
      Configuracao.Laudo  := Query.FieldByName('LAUDO').AsString;
      Configuracao.IndiceGerencial := trim(Query.FieldByName('INDICE_GERENCIAL').AsString);
      Configuracao.DataAtualizacaoEstoque := trim(Query.FieldByName('DATA_ATUALIZACAO_ESTOQUE').AsString);

      Configuracao.ResolucaoVO.ResolucaoTela := Query.FieldByName('RESOLUCAO_TELA').AsString;
      Configuracao.ResolucaoVO.Largura := Query.FieldByName('LARGURA').AsInteger;
      Configuracao.ResolucaoVO.Altura := Query.FieldByName('ALTURA').AsInteger;
      Configuracao.ResolucaoVO.ImagemTela := Query.FieldByName('IMAGEM_TELA').AsString;
      Configuracao.ResolucaoVO.ImagemMenu := Query.FieldByName('IMAGEM_MENU').AsString;
      Configuracao.ResolucaoVO.ImagemSubMenu := Query.FieldByName('IMAGEM_SUBMENU').AsString;
      Configuracao.ResolucaoVO.HotTrackColor := Query.FieldByName('HOTTRACK_COLOR').AsString;
      Configuracao.ResolucaoVO.ItemStyleFontName := Query.FieldByName('ITEM_STYLE_FONT_NAME').AsString;
      Configuracao.ResolucaoVO.ItemStyleFontColor := Query.FieldByName('ITEM_STYLE_FONT_COLOR').AsString;
      Configuracao.ResolucaoVO.ItemSelStyleColor := Query.FieldByName('ITEM_SEL_STYLE_COLOR').AsString;
      Configuracao.ResolucaoVO.LabelTotalGeralFontColor := Query.FieldByName('LABEL_TOTAL_GERAL_FONT_COLOR').AsString;
      Configuracao.ResolucaoVO.ItemStyleFontStyle := Query.FieldByName('ITEM_STYLE_FONT_STYLE').AsString;
      Configuracao.ResolucaoVO.EditColor := Query.FieldByName('EDITS_COLOR').AsString;
      Configuracao.ResolucaoVO.EditFontColor := Query.FieldByName('EDITS_FONT_COLOR').AsString;
      Configuracao.ResolucaoVO.EditDisabledColor := Query.FieldByName('EDITS_DISABLED_COLOR').AsString;
      Configuracao.ResolucaoVO.EditFontName := Query.FieldByName('EDITS_FONT_NAME').AsString;
      Configuracao.ResolucaoVO.EditFontStyle := Query.FieldByName('EDITS_FONT_STYLE').AsString;

      Configuracao.NomeCaixa := Query.FieldByName('NOME_CAIXA').Asstring;
      Configuracao.ModeloImpressora := Query.FieldByName('MODELO_ACBR').AsString;
      Configuracao.NumSerieECF := Query.FieldByName('SERIE').AsString;

      //******* ConfiguracaoBalanca ********************************************
      Linha := Configuracao.ConfiguracaoBalanca;

      Configuracao.BalancaModelo := StrToIntDef(DevolveConteudoDelimitado('|',Linha),0);
      Configuracao.BalancaIdentificadorBalanca := DevolveConteudoDelimitado('|',Linha);
      Configuracao.BalancaHandShaking := StrToIntDef(DevolveConteudoDelimitado('|',Linha),0);
      Configuracao.BalancaParity := StrToIntDef(DevolveConteudoDelimitado('|',Linha),0);
      Configuracao.BalancaStopBits := StrToIntDef(DevolveConteudoDelimitado('|',Linha),0);
      Configuracao.BalancaDataBits := StrToIntDef(DevolveConteudoDelimitado('|',Linha),0);
      Configuracao.BalancaBaudRate := StrToIntDef(DevolveConteudoDelimitado('|',Linha),0);
      Configuracao.BalancaPortaSerial := DevolveConteudoDelimitado('|',Linha);
      Configuracao.BalancaTimeOut := StrToIntDef(DevolveConteudoDelimitado('|',Linha),0);
      Configuracao.BalancaTipoConfiguracaoBalanca := DevolveConteudoDelimitado('|',Linha);
      //*******  Fim ConfiguracaoBalanca ***************************************

       //******* IndiceGerencial ***********************************************
      Linha := Configuracao.IndiceGerencial;

      Configuracao.GerencialX := StrToIntDef(DevolveConteudoDelimitado('|',Linha),0);
      Configuracao.MeiosDePagamento := StrToIntDef(DevolveConteudoDelimitado('|',Linha),0);
      Configuracao.DavEmitidos := StrToIntDef(DevolveConteudoDelimitado('|',Linha),8);
      Configuracao.IdentificacaoPaf := StrToIntDef(DevolveConteudoDelimitado('|',Linha),0);
      Configuracao.ParametrosDeConfiguracao := StrToIntDef(DevolveConteudoDelimitado('|',Linha),0);
      Configuracao.Relatorio := StrToIntDef(DevolveConteudoDelimitado('|',Linha),0);
      //******* Fim IndiceGerencial ********************************************

      //******* ParametrosDiversos *********************************************
      Linha := Configuracao.ParametrosDiversos;

      Configuracao.PedeCPFCupom := StrToIntDef(DevolveConteudoDelimitado('|',Linha),0);
      Configuracao.UsaIntegracao := StrToIntDef(DevolveConteudoDelimitado('|',Linha),0);
      Configuracao.TimerIntegracao := StrToIntDef(DevolveConteudoDelimitado('|',Linha),8);
      Configuracao.GavetaDinheiro := StrToIntDef(DevolveConteudoDelimitado('|',Linha),0);
      Configuracao.SinalInvertido := StrToIntDef(DevolveConteudoDelimitado('|',Linha),0);
      Configuracao.QtdeMaximaParcelas := StrToIntDef(DevolveConteudoDelimitado('|',Linha),0);
      Configuracao.ImprimeParcelas := StrToIntDef(DevolveConteudoDelimitado('|',Linha),0);
      Configuracao.TecladoReduzido := StrToIntDef(DevolveConteudoDelimitado('|',Linha),0);
      //Parametros do Leitor Serial
      Configuracao.UsaLeitorSerial := StrToIntDef(DevolveConteudoDelimitado('|',Linha),0);
      Configuracao.PortaLeitorSerial := DevolveConteudoDelimitado('|',Linha);
      Configuracao.BaudLeitorSerial := DevolveConteudoDelimitado('|',Linha);
      Configuracao.SufixoLeitorSerial := DevolveConteudoDelimitado('|',Linha);
      Configuracao.IntervaloLeitorSerial := DevolveConteudoDelimitado('|',Linha);
      Configuracao.DataLeitorSerial := DevolveConteudoDelimitado('|',Linha);
      Configuracao.ParidadeLeitorSerial := StrToIntDef(DevolveConteudoDelimitado('|',Linha),0);
      Configuracao.HardFlowLeitorSerial := StrToIntDef(DevolveConteudoDelimitado('|',Linha),0);
      Configuracao.SoftFlowLeitorSerial := StrToIntDef(DevolveConteudoDelimitado('|',Linha),0);
      Configuracao.HandShakeLeitorSerial := StrToIntDef(DevolveConteudoDelimitado('|',Linha),0);
      Configuracao.StopLeitorSerial := StrToIntDef(DevolveConteudoDelimitado('|',Linha),0);
      Configuracao.FilaLeitorSerial := StrToIntDef(DevolveConteudoDelimitado('|',Linha),0);
      Configuracao.ExcluiSufixoLeitorSerial := StrToIntDef(DevolveConteudoDelimitado('|',Linha),0);
      //LancamentoNotasManuais
      Configuracao.LancamentoNotasManuais := StrToIntDef(DevolveConteudoDelimitado('|',Linha),0);
      //******* Fim ParametrosDiversos *****************************************

      result := Configuracao;
    except
      raise Exception.Create('Ocorreu um erro ao tentar ler as configurações');
    end;
  finally
    Query.Free;
  end;
end;

class function TConfiguracaoController.ConsultaDataAtualizacaoEstoque: String;
begin
  ConsultaSQL :=  'select DATA_ATUALIZACAO_ESTOQUE from ECF_CONFIGURACAO';
  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open();
      if not Query.IsEmpty then
        Result := DataParaTexto(Query.FieldByName('DATA_ATUALIZACAO_ESTOQUE').AsDateTime)
      else
        Result := '2000-01-01'
    except
      Result := '2000-01-01'
    end;
  finally
    Query.Free;
  end;

end;

class function TConfiguracaoController.ConsultaIdConfiguracao(Id: Integer): boolean;
begin
  ConsultaSQL := 'select ID from ECF_CONFIGURACAO where (ID = :pID) ';
  try
    try
      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.ParamByName('pID').AsInteger:=Id;
      Query.Open;
      if not Query.IsEmpty then
        result := true
      else
        result := false;
    except
    end;
  finally
    Query.Free;
  end;
end;

class function TConfiguracaoController.GravaCargaConfiguracao(vTupla: String): Boolean;
var
  ID: integer;
begin
  try
    try
      if FDataModule.BancoPAF = 'FIREBIRD' then
      begin
        ConsultaSQL:= ' UPDATE OR INSERT INTO ECF_CONFIGURACAO '+
        ' (ID, '+
        'ID_ECF_IMPRESSORA, '+
        'ID_ECF_RESOLUCAO, '+
        'ID_ECF_CAIXA, '+
        'ID_ECF_EMPRESA, '+
        'MENSAGEM_CUPOM, '+
        'PORTA_ECF, '+
        'IP_SERVIDOR, '+
        'IP_SITEF, '+
        'TIPO_TEF, '+
        'TITULO_TELA_CAIXA, '+
        'CAMINHO_IMAGENS_PRODUTOS, '+
        'CAMINHO_IMAGENS_MARKETING, '+
        'CAMINHO_IMAGENS_LAYOUT, '+
        'COR_JANELAS_INTERNAS, '+
        'MARKETING_ATIVO, '+
        'CFOP_ECF, '+
        'CFOP_NF2, '+
        'TIMEOUT_ECF, '+
        'INTERVALO_ECF, '+
        'DESCRICAO_SUPRIMENTO, '+
        'DESCRICAO_SANGRIA, '+
        'TEF_TIPO_GP, '+
        'TEF_TEMPO_ESPERA, '+
        'TEF_ESPERA_STS, '+
        'TEF_NUMERO_VIAS, '+
        'DECIMAIS_QUANTIDADE, '+
        'DECIMAIS_VALOR, '+
        'BITS_POR_SEGUNDO, '+
        'QTDE_MAXIMA_CARTOES, '+
        'PESQUISA_PARTE, '+
        'CONFIGURACAO_BALANCA, '+
        'PARAMETROS_DIVERSOS, '+
        'ULTIMA_EXCLUSAO, '+
        'LAUDO, '+
        'INDICE_GERENCIAL, '+
        'SINCRONIZADO, '+
        'DATA_ATUALIZACAO_ESTOQUE)'+
        'values ('+
        DevolveConteudoDelimitado('|',vTupla)+', '+  //    ID                         INTEGER NOT NULL,
        DevolveConteudoDelimitado('|',vTupla)+', '+  //    ID_ECF_IMPRESSORA          INTEGER NOT NULL,
        DevolveConteudoDelimitado('|',vTupla)+', '+  //    ID_ECF_RESOLUCAO           INTEGER NOT NULL,
        DevolveConteudoDelimitado('|',vTupla)+', '+  //    ID_ECF_CAIXA               INTEGER NOT NULL,
        DevolveConteudoDelimitado('|',vTupla)+', '+  //    ID_ECF_EMPRESA             INTEGER NOT NULL,
        DevolveConteudoDelimitado('|',vTupla)+', '+  //    MENSAGEM_CUPOM             VARCHAR(250),
        DevolveConteudoDelimitado('|',vTupla)+', '+  //    PORTA_ECF                  CHAR(10),
        DevolveConteudoDelimitado('|',vTupla)+', '+  //    IP_SERVIDOR                VARCHAR(15),
        DevolveConteudoDelimitado('|',vTupla)+', '+  //    IP_SITEF                   VARCHAR(15),
        DevolveConteudoDelimitado('|',vTupla)+', '+  //    TIPO_TEF                   CHAR(2),
        DevolveConteudoDelimitado('|',vTupla)+', '+  //    TITULO_TELA_CAIXA          VARCHAR(100),
        DevolveConteudoDelimitado('|',vTupla)+', '+  //    CAMINHO_IMAGENS_PRODUTOS   VARCHAR(250),
        DevolveConteudoDelimitado('|',vTupla)+', '+  //    CAMINHO_IMAGENS_MARKETING  VARCHAR(250),
        DevolveConteudoDelimitado('|',vTupla)+', '+  //    CAMINHO_IMAGENS_LAYOUT     VARCHAR(250),
        DevolveConteudoDelimitado('|',vTupla)+', '+  //    COR_JANELAS_INTERNAS       VARCHAR(20),
        DevolveConteudoDelimitado('|',vTupla)+', '+  //    MARKETING_ATIVO            CHAR(1),
        DevolveConteudoDelimitado('|',vTupla)+', '+  //    CFOP_ECF                   INTEGER,
        DevolveConteudoDelimitado('|',vTupla)+', '+  //    CFOP_NF2                   INTEGER,
        DevolveConteudoDelimitado('|',vTupla)+', '+  //    TIMEOUT_ECF                INTEGER,
        DevolveConteudoDelimitado('|',vTupla)+', '+  //    INTERVALO_ECF              INTEGER,
        DevolveConteudoDelimitado('|',vTupla)+', '+  //    DESCRICAO_SUPRIMENTO       VARCHAR(20),
        DevolveConteudoDelimitado('|',vTupla)+', '+  //    DESCRICAO_SANGRIA          VARCHAR(20),
        DevolveConteudoDelimitado('|',vTupla)+', '+  //    TEF_TIPO_GP                INTEGER,
        DevolveConteudoDelimitado('|',vTupla)+', '+  //    TEF_TEMPO_ESPERA           INTEGER,
        DevolveConteudoDelimitado('|',vTupla)+', '+  //    TEF_ESPERA_STS             INTEGER,
        DevolveConteudoDelimitado('|',vTupla)+', '+  //    TEF_NUMERO_VIAS            INTEGER,
        DevolveConteudoDelimitado('|',vTupla)+', '+  //    DECIMAIS_QUANTIDADE        INTEGER,
        DevolveConteudoDelimitado('|',vTupla)+', '+  //    DECIMAIS_VALOR             INTEGER,
        DevolveConteudoDelimitado('|',vTupla)+', '+  //    BITS_POR_SEGUNDO           INTEGER,
        DevolveConteudoDelimitado('|',vTupla)+', '+  //    QTDE_MAXIMA_CARTOES        INTEGER,
        DevolveConteudoDelimitado('|',vTupla)+', '+  //    PESQUISA_PARTE             CHAR(1),
        DevolveConteudoDelimitado('|',vTupla)+', '+  //    CONFIGURACAO_BALANCA       VARCHAR(100),
        DevolveConteudoDelimitado('|',vTupla)+', '+  //    PARAMETROS_DIVERSOS        VARCHAR(250),
        DevolveConteudoDelimitado('|',vTupla)+', '+  //    ULTIMA_EXCLUSAO            INTEGER,
        DevolveConteudoDelimitado('|',vTupla)+', '+  //    LAUDO                      VARCHAR(10),
        DevolveConteudoDelimitado('|',vTupla)+', '+  //    INDICE_GERENCIAL           VARCHAR(100),
        DevolveConteudoDelimitado('|',vTupla)+', '+  //    SINCRONIZADO               CHAR(1),
        DevolveConteudoDelimitado('|',vTupla)+')';   //    DATA_ATUALIZACAO_ESTOQUE   INTEGER
      end
      else if FDataModule.BancoPAF = 'MYSQL' then
      begin
        ID := StrToInt(DevolveConteudoDelimitado('|',vTupla));   //    ID              INTEGER NOT NULL,

        if not ConsultaIdConfiguracao(ID) then
          ConsultaSQL := 'INSERT INTO ECF_CONFIGURACAO '+
          ' (ID, '+
          'ID_ECF_IMPRESSORA, '+
          'ID_ECF_RESOLUCAO, '+
          'ID_ECF_CAIXA, '+
          'ID_ECF_EMPRESA, '+
          'MENSAGEM_CUPOM, '+
          'PORTA_ECF, '+
          'IP_SERVIDOR, '+
          'IP_SITEF, '+
          'TIPO_TEF, '+
          'TITULO_TELA_CAIXA, '+
          'CAMINHO_IMAGENS_PRODUTOS, '+
          'CAMINHO_IMAGENS_MARKETING, '+
          'CAMINHO_IMAGENS_LAYOUT, '+
          'COR_JANELAS_INTERNAS, '+
          'MARKETING_ATIVO, '+
          'CFOP_ECF, '+
          'CFOP_NF2, '+
          'TIMEOUT_ECF, '+
          'INTERVALO_ECF, '+
          'DESCRICAO_SUPRIMENTO, '+
          'DESCRICAO_SANGRIA, '+
          'TEF_TIPO_GP, '+
          'TEF_TEMPO_ESPERA, '+
          'TEF_ESPERA_STS, '+
          'TEF_NUMERO_VIAS, '+
          'DECIMAIS_QUANTIDADE, '+
          'DECIMAIS_VALOR, '+
          'BITS_POR_SEGUNDO, '+
          'QTDE_MAXIMA_CARTOES, '+
          'PESQUISA_PARTE, '+
          'CONFIGURACAO_BALANCA, '+
          'PARAMETROS_DIVERSOS, '+
          'ULTIMA_EXCLUSAO, '+
          'LAUDO, '+
          'INDICE_GERENCIAL, '+
          'SINCRONIZADO, '+
          'DATA_ATUALIZACAO_ESTOQUE)'+
          'values ('+
          IntToStr(ID)+', '+                            //    ID                    INTEGER NOT NULL,
          DevolveConteudoDelimitado('|',vTupla)+', '+  //    ID_ECF_IMPRESSORA          INTEGER NOT NULL,
          DevolveConteudoDelimitado('|',vTupla)+', '+  //    ID_ECF_RESOLUCAO           INTEGER NOT NULL,
          DevolveConteudoDelimitado('|',vTupla)+', '+  //    ID_ECF_CAIXA               INTEGER NOT NULL,
          DevolveConteudoDelimitado('|',vTupla)+', '+  //    ID_ECF_EMPRESA             INTEGER NOT NULL,
          DevolveConteudoDelimitado('|',vTupla)+', '+  //    MENSAGEM_CUPOM             VARCHAR(250),
          DevolveConteudoDelimitado('|',vTupla)+', '+  //    PORTA_ECF                  CHAR(10),
          DevolveConteudoDelimitado('|',vTupla)+', '+  //    IP_SERVIDOR                VARCHAR(15),
          DevolveConteudoDelimitado('|',vTupla)+', '+  //    IP_SITEF                   VARCHAR(15),
          DevolveConteudoDelimitado('|',vTupla)+', '+  //    TIPO_TEF                   CHAR(2),
          DevolveConteudoDelimitado('|',vTupla)+', '+  //    TITULO_TELA_CAIXA          VARCHAR(100),
          DevolveConteudoDelimitado('|',vTupla)+', '+  //    CAMINHO_IMAGENS_PRODUTOS   VARCHAR(250),
          DevolveConteudoDelimitado('|',vTupla)+', '+  //    CAMINHO_IMAGENS_MARKETING  VARCHAR(250),
          DevolveConteudoDelimitado('|',vTupla)+', '+  //    CAMINHO_IMAGENS_LAYOUT     VARCHAR(250),
          DevolveConteudoDelimitado('|',vTupla)+', '+  //    COR_JANELAS_INTERNAS       VARCHAR(20),
          DevolveConteudoDelimitado('|',vTupla)+', '+  //    MARKETING_ATIVO            CHAR(1),
          DevolveConteudoDelimitado('|',vTupla)+', '+  //    CFOP_ECF                   INTEGER,
          DevolveConteudoDelimitado('|',vTupla)+', '+  //    CFOP_NF2                   INTEGER,
          DevolveConteudoDelimitado('|',vTupla)+', '+  //    TIMEOUT_ECF                INTEGER,
          DevolveConteudoDelimitado('|',vTupla)+', '+  //    INTERVALO_ECF              INTEGER,
          DevolveConteudoDelimitado('|',vTupla)+', '+  //    DESCRICAO_SUPRIMENTO       VARCHAR(20),
          DevolveConteudoDelimitado('|',vTupla)+', '+  //    DESCRICAO_SANGRIA          VARCHAR(20),
          DevolveConteudoDelimitado('|',vTupla)+', '+  //    TEF_TIPO_GP                INTEGER,
          DevolveConteudoDelimitado('|',vTupla)+', '+  //    TEF_TEMPO_ESPERA           INTEGER,
          DevolveConteudoDelimitado('|',vTupla)+', '+  //    TEF_ESPERA_STS             INTEGER,
          DevolveConteudoDelimitado('|',vTupla)+', '+  //    TEF_NUMERO_VIAS            INTEGER,
          DevolveConteudoDelimitado('|',vTupla)+', '+  //    DECIMAIS_QUANTIDADE        INTEGER,
          DevolveConteudoDelimitado('|',vTupla)+', '+  //    DECIMAIS_VALOR             INTEGER,
          DevolveConteudoDelimitado('|',vTupla)+', '+  //    BITS_POR_SEGUNDO           INTEGER,
          DevolveConteudoDelimitado('|',vTupla)+', '+  //    QTDE_MAXIMA_CARTOES        INTEGER,
          DevolveConteudoDelimitado('|',vTupla)+', '+  //    PESQUISA_PARTE             CHAR(1),
          DevolveConteudoDelimitado('|',vTupla)+', '+  //    CONFIGURACAO_BALANCA       VARCHAR(100),
          DevolveConteudoDelimitado('|',vTupla)+', '+  //    PARAMETROS_DIVERSOS        VARCHAR(250),
          DevolveConteudoDelimitado('|',vTupla)+', '+  //    ULTIMA_EXCLUSAO            INTEGER,
          DevolveConteudoDelimitado('|',vTupla)+', '+  //    LAUDO                      VARCHAR(10),
          DevolveConteudoDelimitado('|',vTupla)+', '+  //    INDICE_GERENCIAL           VARCHAR(100),
          DevolveConteudoDelimitado('|',vTupla)+', '+  //    SINCRONIZADO               CHAR(1),
          DevolveConteudoDelimitado('|',vTupla)+')'    //    DATA_ATUALIZACAO_ESTOQUE   INTEGER
        else
          ConsultaSQL := ' update ECF_CONFIGURACAO set '+
          'ID_ECF_IMPRESSORA ='+          DevolveConteudoDelimitado('|',vTupla)+', '+  //    ID_ECF_IMPRESSORA          INTEGER NOT NULL,
          'ID_ECF_RESOLUCAO ='+           DevolveConteudoDelimitado('|',vTupla)+', '+  //    ID_ECF_RESOLUCAO           INTEGER NOT NULL,
          'ID_ECF_CAIXA ='+               DevolveConteudoDelimitado('|',vTupla)+', '+  //    ID_ECF_CAIXA               INTEGER NOT NULL,
          'ID_ECF_EMPRESA ='+             DevolveConteudoDelimitado('|',vTupla)+', '+  //    ID_ECF_EMPRESA             INTEGER NOT NULL,
          'MENSAGEM_CUPOM ='+             DevolveConteudoDelimitado('|',vTupla)+', '+  //    MENSAGEM_CUPOM             VARCHAR(250),
          'PORTA_ECF ='+                  DevolveConteudoDelimitado('|',vTupla)+', '+  //    PORTA_ECF                  CHAR(10),
          'IP_SERVIDOR ='+                DevolveConteudoDelimitado('|',vTupla)+', '+  //    IP_SERVIDOR                VARCHAR(15),
          'IP_SITEF ='+                   DevolveConteudoDelimitado('|',vTupla)+', '+  //    IP_SITEF                   VARCHAR(15),
          'TIPO_TEF ='+                   DevolveConteudoDelimitado('|',vTupla)+', '+  //    TIPO_TEF                   CHAR(2),
          'TITULO_TELA_CAIXA ='+          DevolveConteudoDelimitado('|',vTupla)+', '+  //    TITULO_TELA_CAIXA          VARCHAR(100),
          'CAMINHO_IMAGENS_PRODUTOS ='+   DevolveConteudoDelimitado('|',vTupla)+', '+  //    CAMINHO_IMAGENS_PRODUTOS   VARCHAR(250),
          'CAMINHO_IMAGENS_MARKETING ='+  DevolveConteudoDelimitado('|',vTupla)+', '+  //    CAMINHO_IMAGENS_MARKETING  VARCHAR(250),
          'CAMINHO_IMAGENS_LAYOUT ='+     DevolveConteudoDelimitado('|',vTupla)+', '+  //    CAMINHO_IMAGENS_LAYOUT     VARCHAR(250),
          'COR_JANELAS_INTERNAS ='+       DevolveConteudoDelimitado('|',vTupla)+', '+  //    COR_JANELAS_INTERNAS       VARCHAR(20),
          'MARKETING_ATIVO ='+            DevolveConteudoDelimitado('|',vTupla)+', '+  //    MARKETING_ATIVO            CHAR(1),
          'CFOP_ECF ='+                   DevolveConteudoDelimitado('|',vTupla)+', '+  //    CFOP_ECF                   INTEGER,
          'CFOP_NF2 ='+                   DevolveConteudoDelimitado('|',vTupla)+', '+  //    CFOP_NF2                   INTEGER,
          'TIMEOUT_ECF ='+                DevolveConteudoDelimitado('|',vTupla)+', '+  //    TIMEOUT_ECF                INTEGER,
          'INTERVALO_ECF ='+              DevolveConteudoDelimitado('|',vTupla)+', '+  //    INTERVALO_ECF              INTEGER,
          'DESCRICAO_SUPRIMENTO ='+       DevolveConteudoDelimitado('|',vTupla)+', '+  //    DESCRICAO_SUPRIMENTO       VARCHAR(20),
          'DESCRICAO_SANGRIA ='+          DevolveConteudoDelimitado('|',vTupla)+', '+  //    DESCRICAO_SANGRIA          VARCHAR(20),
          'TEF_TIPO_GP ='+                DevolveConteudoDelimitado('|',vTupla)+', '+  //    TEF_TIPO_GP                INTEGER,
          'TEF_TEMPO_ESPERA ='+           DevolveConteudoDelimitado('|',vTupla)+', '+  //    TEF_TEMPO_ESPERA           INTEGER,
          'TEF_ESPERA_STS ='+             DevolveConteudoDelimitado('|',vTupla)+', '+  //    TEF_ESPERA_STS             INTEGER,
          'TEF_NUMERO_VIAS ='+            DevolveConteudoDelimitado('|',vTupla)+', '+  //    TEF_NUMERO_VIAS            INTEGER,
          'DECIMAIS_QUANTIDADE ='+        DevolveConteudoDelimitado('|',vTupla)+', '+  //    DECIMAIS_QUANTIDADE        INTEGER,
          'DECIMAIS_VALOR ='+             DevolveConteudoDelimitado('|',vTupla)+', '+  //    DECIMAIS_VALOR             INTEGER,
          'BITS_POR_SEGUNDO ='+           DevolveConteudoDelimitado('|',vTupla)+', '+  //    BITS_POR_SEGUNDO           INTEGER,
          'QTDE_MAXIMA_CARTOES ='+        DevolveConteudoDelimitado('|',vTupla)+', '+  //    QTDE_MAXIMA_CARTOES        INTEGER,
          'PESQUISA_PARTE ='+             DevolveConteudoDelimitado('|',vTupla)+', '+  //    PESQUISA_PARTE             CHAR(1),
          'CONFIGURACAO_BALANCA ='+       DevolveConteudoDelimitado('|',vTupla)+', '+  //    CONFIGURACAO_BALANCA       VARCHAR(100),
          'PARAMETROS_DIVERSOS ='+        DevolveConteudoDelimitado('|',vTupla)+', '+  //    PARAMETROS_DIVERSOS        VARCHAR(250),
          'ULTIMA_EXCLUSAO ='+            DevolveConteudoDelimitado('|',vTupla)+', '+  //    ULTIMA_EXCLUSAO            INTEGER,
          'LAUDO ='+                      DevolveConteudoDelimitado('|',vTupla)+', '+  //    LAUDO                      VARCHAR(10),
          'INDICE_GERENCIAL ='+           DevolveConteudoDelimitado('|',vTupla)+', '+  //    INDICE_GERENCIAL           VARCHAR(100),
          'SINCRONIZADO ='+               DevolveConteudoDelimitado('|',vTupla)+', '+  //    SINCRONIZADO               CHAR(1),
          'DATA_ATUALIZACAO_ESTOQUE ='+   DevolveConteudoDelimitado('|',vTupla)+    //    DATA_ATUALIZACAO_ESTOQUE   INTEGER
          ' where ID ='+IntToStr(ID);
      end;

      Query := TSQLQuery.Create(nil);
      Query.SQLConnection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.ExecSQL();

      result := True;
    except
      result := false;
    end;
  finally
    Query.Free;
  end;
end;

end.
