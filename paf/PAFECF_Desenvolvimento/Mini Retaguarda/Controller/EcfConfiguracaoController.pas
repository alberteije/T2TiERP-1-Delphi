{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: Controller do lado Cliente relacionado à tabela [EcfConfiguracao]
                                                                                
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

@author  Marcos Leite
@version 1.0
*******************************************************************************}
unit EcfConfiguracaoController;

interface

uses
 Classes, Dialogs, SysUtils, DBClient, DB, Windows, Forms, DBXCommon, EcfConfiguracaoVO;


type
  TEcfConfiguracaoController = class
  private
  protected
  public
    class procedure Consulta(pFiltro: String; pPagina: Integer; pLookup: Boolean);
    class procedure Insere(pEcfConfiguracao: TEcfConfiguracaoVO);
    class procedure Altera(pEcfConfiguracao: TEcfConfiguracaoVO; pFiltro: String; pPagina: Integer);
    class procedure Exclui(pId: Integer);
  end;

implementation

uses UDataModule, T2TiORM, Biblioteca;

var
  EcfConfiguracao: TEcfConfiguracaoVO;

class procedure TEcfConfiguracaoController.Consulta(pFiltro: String; pPagina: Integer; pLookup: Boolean);
var
  ResultSet: TDBXReader;
  ConsultaSQL: String;
  i: integer;
begin
  try
    try
      pFiltro := StringReplace(pFiltro,'*','%',[rfReplaceAll]);
      ResultSet := TT2TiORM.Consultar(TEcfConfiguracaoVO.Create, pFiltro, pPagina);

      if pLookup then
      begin
        FDataModule.CDSLookup.DisableControls;
        FDataModule.CDSLookup.EmptyDataSet;
        while ResultSet.Next do
        begin
          FDataModule.CDSLookup.Append;
          FDataModule.CDSLookup.FieldByName('ID').AsInteger := ResultSet.Value['ID'].AsInt32;
          FDataModule.CDSLookup.FieldByName('NOME_CAIXA').AsString := ResultSet.Value['NOME_CAIXA'].AsString;
          FDataModule.CDSLookup.FieldByName('ID_GERADO_CAIXA').AsInteger := ResultSet.Value['ID_GERADO_CAIXA'].AsInt32;
          FDataModule.CDSLookup.FieldByName('ID_EMPRESA').AsInteger := ResultSet.Value['ID_EMPRESA'].AsInt32;
          FDataModule.CDSLookup.FieldByName('ID_ECF_IMPRESSORA').AsInteger := ResultSet.Value['ID_ECF_IMPRESSORA'].AsInt32;
          FDataModule.CDSLookup.FieldByName('ID_ECF_RESOLUCAO').AsInteger := ResultSet.Value['ID_ECF_RESOLUCAO'].AsInt32;
          FDataModule.CDSLookup.FieldByName('ID_ECF_CAIXA').AsInteger := ResultSet.Value['ID_ECF_CAIXA'].AsInt32;
          FDataModule.CDSLookup.FieldByName('ID_ECF_EMPRESA').AsInteger := ResultSet.Value['ID_ECF_EMPRESA'].AsInt32;
          FDataModule.CDSLookup.FieldByName('MENSAGEM_CUPOM').AsString := ResultSet.Value['MENSAGEM_CUPOM'].AsString;
          FDataModule.CDSLookup.FieldByName('PORTA_ECF').AsString := ResultSet.Value['PORTA_ECF'].AsString;
          FDataModule.CDSLookup.FieldByName('PORTA_PINPAD').AsString := ResultSet.Value['PORTA_PINPAD'].AsString;
          FDataModule.CDSLookup.FieldByName('PORTA_BALANCA').AsString := ResultSet.Value['PORTA_BALANCA'].AsString;
          FDataModule.CDSLookup.FieldByName('IP_SERVIDOR').AsString := ResultSet.Value['IP_SERVIDOR'].AsString;
          FDataModule.CDSLookup.FieldByName('IP_SITEF').AsString := ResultSet.Value['IP_SITEF'].AsString;
          FDataModule.CDSLookup.FieldByName('TIPO_TEF').AsString := ResultSet.Value['TIPO_TEF'].AsString;
          FDataModule.CDSLookup.FieldByName('TITULO_TELA_CAIXA').AsString := ResultSet.Value['TITULO_TELA_CAIXA'].AsString;
          FDataModule.CDSLookup.FieldByName('CAMINHO_IMAGENS_PRODUTOS').AsString := ResultSet.Value['CAMINHO_IMAGENS_PRODUTOS'].AsString;
          FDataModule.CDSLookup.FieldByName('CAMINHO_IMAGENS_MARKETING').AsString := ResultSet.Value['CAMINHO_IMAGENS_MARKETING'].AsString;
          FDataModule.CDSLookup.FieldByName('CAMINHO_IMAGENS_LAYOUT').AsString := ResultSet.Value['CAMINHO_IMAGENS_LAYOUT'].AsString;
          FDataModule.CDSLookup.FieldByName('COR_JANELAS_INTERNAS').AsString := ResultSet.Value['COR_JANELAS_INTERNAS'].AsString;
          FDataModule.CDSLookup.FieldByName('MARKETING_ATIVO').AsString := ResultSet.Value['MARKETING_ATIVO'].AsString;
          FDataModule.CDSLookup.FieldByName('CFOP_ECF').AsInteger := ResultSet.Value['CFOP_ECF'].AsInt32;
          FDataModule.CDSLookup.FieldByName('CFOP_NF2').AsInteger := ResultSet.Value['CFOP_NF2'].AsInt32;
          FDataModule.CDSLookup.FieldByName('TIMEOUT_ECF').AsInteger := ResultSet.Value['TIMEOUT_ECF'].AsInt32;
          FDataModule.CDSLookup.FieldByName('INTERVALO_ECF').AsInteger := ResultSet.Value['INTERVALO_ECF'].AsInt32;
          FDataModule.CDSLookup.FieldByName('DESCRICAO_SUPRIMENTO').AsString := ResultSet.Value['DESCRICAO_SUPRIMENTO'].AsString;
          FDataModule.CDSLookup.FieldByName('DESCRICAO_SANGRIA').AsString := ResultSet.Value['DESCRICAO_SANGRIA'].AsString;
          FDataModule.CDSLookup.FieldByName('TEF_TIPO_GP').AsInteger := ResultSet.Value['TEF_TIPO_GP'].AsInt32;
          FDataModule.CDSLookup.FieldByName('TEF_TEMPO_ESPERA').AsInteger := ResultSet.Value['TEF_TEMPO_ESPERA'].AsInt32;
          FDataModule.CDSLookup.FieldByName('TEF_ESPERA_STS').AsInteger := ResultSet.Value['TEF_ESPERA_STS'].AsInt32;
          FDataModule.CDSLookup.FieldByName('TEF_NUMERO_VIAS').AsInteger := ResultSet.Value['TEF_NUMERO_VIAS'].AsInt32;
          FDataModule.CDSLookup.FieldByName('INDICE_GERENCIAL_DAV').AsInteger := ResultSet.Value['INDICE_GERENCIAL_DAV'].AsInt32;
          FDataModule.CDSLookup.FieldByName('DECIMAIS_QUANTIDADE').AsInteger := ResultSet.Value['DECIMAIS_QUANTIDADE'].AsInt32;
          FDataModule.CDSLookup.FieldByName('DECIMAIS_VALOR').AsInteger := ResultSet.Value['DECIMAIS_VALOR'].AsInt32;
          FDataModule.CDSLookup.FieldByName('BITS_POR_SEGUNDO').AsInteger := ResultSet.Value['BITS_POR_SEGUNDO'].AsInt32;
          FDataModule.CDSLookup.FieldByName('QTDE_MAXIMA_CARTOES').AsInteger := ResultSet.Value['QTDE_MAXIMA_CARTOES'].AsInt32;
          FDataModule.CDSLookup.FieldByName('PESQUISA_PARTE').AsString := ResultSet.Value['PESQUISA_PARTE'].AsString;
          FDataModule.CDSLookup.FieldByName('CONFIGURACAO_BALANCA').AsString := ResultSet.Value['CONFIGURACAO_BALANCA'].AsString;
          FDataModule.CDSLookup.FieldByName('PARAMETROS_DIVERSOS').AsString := ResultSet.Value['PARAMETROS_DIVERSOS'].AsString;
          FDataModule.CDSLookup.FieldByName('ULTIMA_EXCLUSAO').AsInteger := ResultSet.Value['ULTIMA_EXCLUSAO'].AsInt32;
          FDataModule.CDSLookup.FieldByName('INDICE_GERENCIAL_IDENTIFICA').AsInteger := ResultSet.Value['INDICE_GERENCIAL_IDENTIFICA'].AsInt32;
          FDataModule.CDSLookup.FieldByName('LAUDO').AsString := ResultSet.Value['LAUDO'].AsString;
          FDataModule.CDSLookup.FieldByName('DATA_SINCRONIZACAO').AsDateTime := ResultSet.Value['DATA_SINCRONIZACAO'].AsDate;
          FDataModule.CDSLookup.FieldByName('HORA_SINCRONIZACAO').AsString := ResultSet.Value['HORA_SINCRONIZACAO'].AsString;
          FDataModule.CDSLookup.Post;
        end;
        FDataModule.CDSLookup.Open;
        FDataModule.CDSLookup.EnableControls;
      end
      else
      begin
        FDataModule.CDSConfiguracao.DisableControls;
        FDataModule.CDSConfiguracao.EmptyDataSet;
        while ResultSet.Next do
        begin
          FDataModule.CDSConfiguracao.Append;
          for I := 0 to FDataModule.CDSConfiguracao.FieldCount -1 do
          begin
            if  ResultSet.Value[FDataModule.CDSConfiguracao.FieldDefList[i].Name].ValueType.DataType = 2 then
            begin
             if ResultSet.Value[FDataModule.CDSConfiguracao.FieldDefList[i].Name].GetDate > 0 then
                FDataModule.CDSConfiguracao.Fields[i].AsString := DataParaTexto(ResultSet.Value[FDataModule.CDSConfiguracao.FieldDefList[i].Name].AsDateTime);
            end
            else
            if  ResultSet.Value[FDataModule.CDSConfiguracao.FieldDefList[i].Name].ValueType.DataType = 8 then
            begin
              if not ResultSet.Value[FDataModule.CDSConfiguracao.FieldDefList[i].Name].IsNull  then
              begin
                FDataModule.CDSConfiguracao.Fields[i].AsFloat :=  ResultSet.Value[FDataModule.CDSConfiguracao.FieldDefList[i].Name].AsDouble;
              end
              else FDataModule.CDSConfiguracao.Fields[i].AsFloat := 0;
            end
            else
            if ResultSet.Value[FDataModule.CDSConfiguracao.FieldDefList[i].Name].AsString <> '' then
              FDataModule.CDSConfiguracao.Fields[i].AsString := ResultSet.Value[FDataModule.CDSConfiguracao.FieldDefList[i].Name].AsString;
          end;
          FDataModule.CDSConfiguracao.Post;
          {
          FDataModule.CDSConfiguracao.Append;
          FDataModule.CDSConfiguracao.FieldByName('ID').AsInteger := ResultSet.Value['ID'].AsInt32;
          FDataModule.CDSConfiguracao.FieldByName('NOME_CAIXA').AsString := ResultSet.Value['NOME_CAIXA'].AsString;
          FDataModule.CDSConfiguracao.FieldByName('ID_GERADO_CAIXA').AsInteger := ResultSet.Value['ID_GERADO_CAIXA'].AsInt32;
          FDataModule.CDSConfiguracao.FieldByName('ID_EMPRESA').AsInteger := ResultSet.Value['ID_EMPRESA'].AsInt32;
          FDataModule.CDSConfiguracao.FieldByName('ID_ECF_IMPRESSORA').AsInteger := ResultSet.Value['ID_ECF_IMPRESSORA'].AsInt32;
          FDataModule.CDSConfiguracao.FieldByName('ID_ECF_RESOLUCAO').AsInteger := ResultSet.Value['ID_ECF_RESOLUCAO'].AsInt32;
          FDataModule.CDSConfiguracao.FieldByName('ID_ECF_CAIXA').AsInteger := ResultSet.Value['ID_ECF_CAIXA'].AsInt32;
          FDataModule.CDSConfiguracao.FieldByName('ID_ECF_EMPRESA').AsInteger := ResultSet.Value['ID_ECF_EMPRESA'].AsInt32;
          FDataModule.CDSConfiguracao.FieldByName('MENSAGEM_CUPOM').AsString := ResultSet.Value['MENSAGEM_CUPOM'].AsString;
          FDataModule.CDSConfiguracao.FieldByName('PORTA_ECF').AsString := ResultSet.Value['PORTA_ECF'].AsString;
          FDataModule.CDSConfiguracao.FieldByName('PORTA_PINPAD').AsString := ResultSet.Value['PORTA_PINPAD'].AsString;
          FDataModule.CDSConfiguracao.FieldByName('PORTA_BALANCA').AsString := ResultSet.Value['PORTA_BALANCA'].AsString;
          FDataModule.CDSConfiguracao.FieldByName('IP_SERVIDOR').AsString := ResultSet.Value['IP_SERVIDOR'].AsString;
          FDataModule.CDSConfiguracao.FieldByName('IP_SITEF').AsString := ResultSet.Value['IP_SITEF'].AsString;
          FDataModule.CDSConfiguracao.FieldByName('TIPO_TEF').AsString := ResultSet.Value['TIPO_TEF'].AsString;
          FDataModule.CDSConfiguracao.FieldByName('TITULO_TELA_CAIXA').AsString := ResultSet.Value['TITULO_TELA_CAIXA'].AsString;
          FDataModule.CDSConfiguracao.FieldByName('CAMINHO_IMAGENS_PRODUTOS').AsString := ResultSet.Value['CAMINHO_IMAGENS_PRODUTOS'].AsString;
          FDataModule.CDSConfiguracao.FieldByName('CAMINHO_IMAGENS_MARKETING').AsString := ResultSet.Value['CAMINHO_IMAGENS_MARKETING'].AsString;
          FDataModule.CDSConfiguracao.FieldByName('CAMINHO_IMAGENS_LAYOUT').AsString := ResultSet.Value['CAMINHO_IMAGENS_LAYOUT'].AsString;
          FDataModule.CDSConfiguracao.FieldByName('COR_JANELAS_INTERNAS').AsString := ResultSet.Value['COR_JANELAS_INTERNAS'].AsString;
          FDataModule.CDSConfiguracao.FieldByName('MARKETING_ATIVO').AsString := ResultSet.Value['MARKETING_ATIVO'].AsString;
          FDataModule.CDSConfiguracao.FieldByName('CFOP_ECF').AsInteger := ResultSet.Value['CFOP_ECF'].AsInt32;
          FDataModule.CDSConfiguracao.FieldByName('CFOP_NF2').AsInteger := ResultSet.Value['CFOP_NF2'].AsInt32;
          FDataModule.CDSConfiguracao.FieldByName('TIMEOUT_ECF').AsInteger := ResultSet.Value['TIMEOUT_ECF'].AsInt32;
          FDataModule.CDSConfiguracao.FieldByName('INTERVALO_ECF').AsInteger := ResultSet.Value['INTERVALO_ECF'].AsInt32;
          FDataModule.CDSConfiguracao.FieldByName('DESCRICAO_SUPRIMENTO').AsString := ResultSet.Value['DESCRICAO_SUPRIMENTO'].AsString;
          FDataModule.CDSConfiguracao.FieldByName('DESCRICAO_SANGRIA').AsString := ResultSet.Value['DESCRICAO_SANGRIA'].AsString;
          FDataModule.CDSConfiguracao.FieldByName('TEF_TIPO_GP').AsInteger := ResultSet.Value['TEF_TIPO_GP'].AsInt32;
          FDataModule.CDSConfiguracao.FieldByName('TEF_TEMPO_ESPERA').AsInteger := ResultSet.Value['TEF_TEMPO_ESPERA'].AsInt32;
          FDataModule.CDSConfiguracao.FieldByName('TEF_ESPERA_STS').AsInteger := ResultSet.Value['TEF_ESPERA_STS'].AsInt32;
          FDataModule.CDSConfiguracao.FieldByName('TEF_NUMERO_VIAS').AsInteger := ResultSet.Value['TEF_NUMERO_VIAS'].AsInt32;
          FDataModule.CDSConfiguracao.FieldByName('INDICE_GERENCIAL_DAV').AsInteger := ResultSet.Value['INDICE_GERENCIAL_DAV'].AsInt32;
          FDataModule.CDSConfiguracao.FieldByName('DECIMAIS_QUANTIDADE').AsInteger := ResultSet.Value['DECIMAIS_QUANTIDADE'].AsInt32;
          FDataModule.CDSConfiguracao.FieldByName('DECIMAIS_VALOR').AsInteger := ResultSet.Value['DECIMAIS_VALOR'].AsInt32;
          FDataModule.CDSConfiguracao.FieldByName('BITS_POR_SEGUNDO').AsInteger := ResultSet.Value['BITS_POR_SEGUNDO'].AsInt32;
          FDataModule.CDSConfiguracao.FieldByName('QTDE_MAXIMA_CARTOES').AsInteger := ResultSet.Value['QTDE_MAXIMA_CARTOES'].AsInt32;
          FDataModule.CDSConfiguracao.FieldByName('PESQUISA_PARTE').AsString := ResultSet.Value['PESQUISA_PARTE'].AsString;
          FDataModule.CDSConfiguracao.FieldByName('CONFIGURACAO_BALANCA').AsString := ResultSet.Value['CONFIGURACAO_BALANCA'].AsString;
          FDataModule.CDSConfiguracao.FieldByName('PARAMETROS_DIVERSOS').AsString := ResultSet.Value['PARAMETROS_DIVERSOS'].AsString;
          FDataModule.CDSConfiguracao.FieldByName('ULTIMA_EXCLUSAO').AsInteger := ResultSet.Value['ULTIMA_EXCLUSAO'].AsInt32;
          FDataModule.CDSConfiguracao.FieldByName('INDICE_GERENCIAL_IDENTIFICA').AsInteger := ResultSet.Value['INDICE_GERENCIAL_IDENTIFICA'].AsInt32;
          FDataModule.CDSConfiguracao.FieldByName('LAUDO').AsString := ResultSet.Value['LAUDO'].AsString;
          FDataModule.CDSConfiguracao.FieldByName('DATA_SINCRONIZACAO').AsDateTime := ResultSet.Value['DATA_SINCRONIZACAO'].AsDate;
          FDataModule.CDSConfiguracao.FieldByName('HORA_SINCRONIZACAO').AsString := ResultSet.Value['HORA_SINCRONIZACAO'].AsString;
          FDataModule.CDSConfiguracao.Post;
          }
        end;
        //FDataModule.CDSConfiguracao.Open;
        FDataModule.CDSConfiguracao.EnableControls;
      end;
    except
    end;
  finally
    ResultSet.Free;
  end;
end;

class Procedure TEcfConfiguracaoController.Insere(pEcfConfiguracao: TEcfConfiguracaoVO);
var
  UltimoID:Integer;
begin
  try
    try
      UltimoID := TT2TiORM.Inserir(pEcfConfiguracao);
      Consulta('ID='+IntToStr(UltimoID),0,False);
    except
      Application.MessageBox('Ocorreu um erro. Inclusão não realizada.', 'Erro do sistema', MB_OK + MB_ICONERROR);
    end;
  finally
  end;
end;

class Procedure TEcfConfiguracaoController.Altera(pEcfConfiguracao: TEcfConfiguracaoVO; pFiltro: String; pPagina: Integer);
begin
  try
    try
      TT2TiORM.Alterar(pEcfConfiguracao);
      Consulta(pFiltro, pPagina,False);
    except
      Application.MessageBox('Ocorreu um erro. Alteração não realizada.', 'Erro do sistema', MB_OK + MB_ICONERROR);
    end;
  finally
  end;
end;

class Procedure TEcfConfiguracaoController.Exclui(pId: Integer);
begin
  try
    try
      EcfConfiguracao := TEcfConfiguracaoVO.Create;
      EcfConfiguracao.Id := pId;
      TT2TiORM.Excluir(EcfConfiguracao);
    except
      Application.MessageBox('Ocorreu um erro na exclusão do cliente.', 'Erro do sistema', MB_OK + MB_ICONERROR);
    end;
  finally
  end;
end;

end.
