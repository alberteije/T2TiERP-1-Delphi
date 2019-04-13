{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: Controller do lado Cliente relacionado à tabela [EcfResolucao]
                                                                                
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
unit EcfResolucaoController;

interface

uses
 Classes, Dialogs, SysUtils, DBClient, DB, Windows, Forms, DBXCommon, EcfResolucaoVO;


type
  TEcfResolucaoController = class
  private
  protected
  public
    class procedure Consulta(pFiltro: String; pPagina: Integer; pLookup: Boolean);
    class procedure Insere(pEcfResolucao: TEcfResolucaoVO);
    class procedure Altera(pEcfResolucao: TEcfResolucaoVO; pFiltro: String; pPagina: Integer);
    class procedure Exclui(pId: Integer);
  end;

implementation

uses UDataModule, T2TiORM, Biblioteca;

var
  EcfResolucao: TEcfResolucaoVO;

class procedure TEcfResolucaoController.Consulta(pFiltro: String; pPagina: Integer; pLookup: Boolean);
var
  ResultSet: TDBXReader;
  ConsultaSQL: String;
  i: integer;
begin
  try
    try
      pFiltro := StringReplace(pFiltro,'*','%',[rfReplaceAll]);
      ResultSet := TT2TiORM.Consultar(TEcfResolucaoVO.Create, pFiltro, pPagina);

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
          FDataModule.CDSLookup.FieldByName('RESOLUCAO_TELA').AsString := ResultSet.Value['RESOLUCAO_TELA'].AsString;
          FDataModule.CDSLookup.FieldByName('LARGURA').AsInteger := ResultSet.Value['LARGURA'].AsInt32;
          FDataModule.CDSLookup.FieldByName('ALTURA').AsInteger := ResultSet.Value['ALTURA'].AsInt32;
          FDataModule.CDSLookup.FieldByName('IMAGEM_TELA').AsString := ResultSet.Value['IMAGEM_TELA'].AsString;
          FDataModule.CDSLookup.FieldByName('IMAGEM_MENU').AsString := ResultSet.Value['IMAGEM_MENU'].AsString;
          FDataModule.CDSLookup.FieldByName('IMAGEM_SUBMENU').AsString := ResultSet.Value['IMAGEM_SUBMENU'].AsString;
          FDataModule.CDSLookup.FieldByName('HOTTRACK_COLOR').AsString := ResultSet.Value['HOTTRACK_COLOR'].AsString;
          FDataModule.CDSLookup.FieldByName('ITEM_STYLE_FONT_NAME').AsString := ResultSet.Value['ITEM_STYLE_FONT_NAME'].AsString;
          FDataModule.CDSLookup.FieldByName('ITEM_STYLE_FONT_COLOR').AsString := ResultSet.Value['ITEM_STYLE_FONT_COLOR'].AsString;
          FDataModule.CDSLookup.FieldByName('ITEM_SEL_STYLE_COLOR').AsString := ResultSet.Value['ITEM_SEL_STYLE_COLOR'].AsString;
          FDataModule.CDSLookup.FieldByName('LABEL_TOTAL_GERAL_FONT_COLOR').AsString := ResultSet.Value['LABEL_TOTAL_GERAL_FONT_COLOR'].AsString;
          FDataModule.CDSLookup.FieldByName('ITEM_STYLE_FONT_STYLE').AsString := ResultSet.Value['ITEM_STYLE_FONT_STYLE'].AsString;
          FDataModule.CDSLookup.FieldByName('EDITS_COLOR').AsString := ResultSet.Value['EDITS_COLOR'].AsString;
          FDataModule.CDSLookup.FieldByName('EDITS_FONT_COLOR').AsString := ResultSet.Value['EDITS_FONT_COLOR'].AsString;
          FDataModule.CDSLookup.FieldByName('EDITS_DISABLED_COLOR').AsString := ResultSet.Value['EDITS_DISABLED_COLOR'].AsString;
          FDataModule.CDSLookup.FieldByName('EDITS_FONT_NAME').AsString := ResultSet.Value['EDITS_FONT_NAME'].AsString;
          FDataModule.CDSLookup.FieldByName('EDITS_FONT_STYLE').AsString := ResultSet.Value['EDITS_FONT_STYLE'].AsString;
          FDataModule.CDSLookup.FieldByName('DATA_SINCRONIZACAO').AsDateTime := ResultSet.Value['DATA_SINCRONIZACAO'].AsDate;
          FDataModule.CDSLookup.FieldByName('HORA_SINCRONIZACAO').AsString := ResultSet.Value['HORA_SINCRONIZACAO'].AsString;
          FDataModule.CDSLookup.Post;
        end;
        FDataModule.CDSLookup.Open;
        FDataModule.CDSLookup.EnableControls;
      end
      else
      begin
        FDataModule.CDSResolucao.DisableControls;
        FDataModule.CDSResolucao.EmptyDataSet;
        while ResultSet.Next do
        begin
          FDataModule.CDSResolucao.Append;
          for I := 0 to FDataModule.CDSResolucao.FieldCount -1 do
          begin
            if  ResultSet.Value[FDataModule.CDSResolucao.FieldDefList[i].Name].ValueType.DataType = 2 then
            begin
             if ResultSet.Value[FDataModule.CDSResolucao.FieldDefList[i].Name].GetDate > 0 then
                FDataModule.CDSResolucao.Fields[i].AsString := DataParaTexto(ResultSet.Value[FDataModule.CDSResolucao.FieldDefList[i].Name].AsDateTime);
            end
            else
            if  ResultSet.Value[FDataModule.CDSResolucao.FieldDefList[i].Name].ValueType.DataType = 8 then
            begin
              if not ResultSet.Value[FDataModule.CDSResolucao.FieldDefList[i].Name].IsNull  then
              begin
                FDataModule.CDSResolucao.Fields[i].AsFloat :=  ResultSet.Value[FDataModule.CDSResolucao.FieldDefList[i].Name].AsDouble;
              end
              else FDataModule.CDSResolucao.Fields[i].AsFloat := 0;
            end
            else
            if ResultSet.Value[FDataModule.CDSResolucao.FieldDefList[i].Name].AsString <> '' then
              FDataModule.CDSResolucao.Fields[i].AsString := ResultSet.Value[FDataModule.CDSResolucao.FieldDefList[i].Name].AsString;
          end;
          FDataModule.CDSResolucao.Post;
          {
          FDataModule.CDSResolucao.Append;
          FDataModule.CDSResolucao.FieldByName('ID').AsInteger := ResultSet.Value['ID'].AsInt32;
          FDataModule.CDSResolucao.FieldByName('NOME_CAIXA').AsString := ResultSet.Value['NOME_CAIXA'].AsString;
          FDataModule.CDSResolucao.FieldByName('ID_GERADO_CAIXA').AsInteger := ResultSet.Value['ID_GERADO_CAIXA'].AsInt32;
          FDataModule.CDSResolucao.FieldByName('ID_EMPRESA').AsInteger := ResultSet.Value['ID_EMPRESA'].AsInt32;
          FDataModule.CDSResolucao.FieldByName('RESOLUCAO_TELA').AsString := ResultSet.Value['RESOLUCAO_TELA'].AsString;
          FDataModule.CDSResolucao.FieldByName('LARGURA').AsInteger := ResultSet.Value['LARGURA'].AsInt32;
          FDataModule.CDSResolucao.FieldByName('ALTURA').AsInteger := ResultSet.Value['ALTURA'].AsInt32;
          FDataModule.CDSResolucao.FieldByName('IMAGEM_TELA').AsString := ResultSet.Value['IMAGEM_TELA'].AsString;
          FDataModule.CDSResolucao.FieldByName('IMAGEM_MENU').AsString := ResultSet.Value['IMAGEM_MENU'].AsString;
          FDataModule.CDSResolucao.FieldByName('IMAGEM_SUBMENU').AsString := ResultSet.Value['IMAGEM_SUBMENU'].AsString;
          FDataModule.CDSResolucao.FieldByName('HOTTRACK_COLOR').AsString := ResultSet.Value['HOTTRACK_COLOR'].AsString;
          FDataModule.CDSResolucao.FieldByName('ITEM_STYLE_FONT_NAME').AsString := ResultSet.Value['ITEM_STYLE_FONT_NAME'].AsString;
          FDataModule.CDSResolucao.FieldByName('ITEM_STYLE_FONT_COLOR').AsString := ResultSet.Value['ITEM_STYLE_FONT_COLOR'].AsString;
          FDataModule.CDSResolucao.FieldByName('ITEM_SEL_STYLE_COLOR').AsString := ResultSet.Value['ITEM_SEL_STYLE_COLOR'].AsString;
          FDataModule.CDSResolucao.FieldByName('LABEL_TOTAL_GERAL_FONT_COLOR').AsString := ResultSet.Value['LABEL_TOTAL_GERAL_FONT_COLOR'].AsString;
          FDataModule.CDSResolucao.FieldByName('ITEM_STYLE_FONT_STYLE').AsString := ResultSet.Value['ITEM_STYLE_FONT_STYLE'].AsString;
          FDataModule.CDSResolucao.FieldByName('EDITS_COLOR').AsString := ResultSet.Value['EDITS_COLOR'].AsString;
          FDataModule.CDSResolucao.FieldByName('EDITS_FONT_COLOR').AsString := ResultSet.Value['EDITS_FONT_COLOR'].AsString;
          FDataModule.CDSResolucao.FieldByName('EDITS_DISABLED_COLOR').AsString := ResultSet.Value['EDITS_DISABLED_COLOR'].AsString;
          FDataModule.CDSResolucao.FieldByName('EDITS_FONT_NAME').AsString := ResultSet.Value['EDITS_FONT_NAME'].AsString;
          FDataModule.CDSResolucao.FieldByName('EDITS_FONT_STYLE').AsString := ResultSet.Value['EDITS_FONT_STYLE'].AsString;
          FDataModule.CDSResolucao.FieldByName('DATA_SINCRONIZACAO').AsDateTime := ResultSet.Value['DATA_SINCRONIZACAO'].AsDate;
          FDataModule.CDSResolucao.FieldByName('HORA_SINCRONIZACAO').AsString := ResultSet.Value['HORA_SINCRONIZACAO'].AsString;
          FDataModule.CDSResolucao.Post;
          }
        end;
        //FDataModule.CDSResolucao.Open;
        FDataModule.CDSResolucao.EnableControls;
      end;
    except
    end;
  finally
    ResultSet.Free;
  end;
end;

class Procedure TEcfResolucaoController.Insere(pEcfResolucao: TEcfResolucaoVO);
var
  UltimoID:Integer;
begin
  try
    try
      UltimoID := TT2TiORM.Inserir(pEcfResolucao);
      Consulta('ID='+IntToStr(UltimoID),0,False);
    except
      Application.MessageBox('Ocorreu um erro. Inclusão não realizada.', 'Erro do sistema', MB_OK + MB_ICONERROR);
    end;
  finally
  end;
end;

class Procedure TEcfResolucaoController.Altera(pEcfResolucao: TEcfResolucaoVO; pFiltro: String; pPagina: Integer);
begin
  try
    try
      TT2TiORM.Alterar(pEcfResolucao);
      Consulta(pFiltro, pPagina,False);
    except
      Application.MessageBox('Ocorreu um erro. Alteração não realizada.', 'Erro do sistema', MB_OK + MB_ICONERROR);
    end;
  finally
  end;
end;

class Procedure TEcfResolucaoController.Exclui(pId: Integer);
begin
  try
    try
      EcfResolucao := TEcfResolucaoVO.Create;
      EcfResolucao.Id := pId;
      TT2TiORM.Excluir(EcfResolucao);
    except
      Application.MessageBox('Ocorreu um erro na exclusão do cliente.', 'Erro do sistema', MB_OK + MB_ICONERROR);
    end;
  finally
  end;
end;

end.
