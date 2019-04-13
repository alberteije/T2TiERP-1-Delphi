{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: Controller do lado Cliente relacionado à tabela [EcfPosicaoComponentes]
                                                                                
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
unit EcfPosicaoComponentesController;

interface

uses
  Classes, Dialogs, SysUtils, DBClient, DB, Windows, Forms, EcfPosicaoComponentesVO, DBXCommon;

type
  TEcfPosicaoComponentesController = class
  private
  public
    class Procedure Consulta(pFiltro: String; pPagina: Integer; pLookup: Boolean);
    class procedure Insere(pEcfPosicaoComponentes: TEcfPosicaoComponentesVO);
    class procedure Altera(pEcfPosicaoComponentes: TEcfPosicaoComponentesVO; pFiltro: String; pPagina: Integer);
    class procedure Exclui(pId: Integer);
  end;

implementation

uses UDataModule, T2TiORM, Biblioteca;


var
  EcfPosicaoComponentes: TEcfPosicaoComponentesVO;

class procedure TEcfPosicaoComponentesController.Consulta(pFiltro: String; pPagina: Integer; pLookup: Boolean);
var
  ResultSet: TDBXReader;
  ConsultaSQL: String;
  i: integer;
begin
  try
    try
      pFiltro := StringReplace(pFiltro,'*','%',[rfReplaceAll]);
      ResultSet := TT2TiORM.Consultar(TEcfPosicaoComponentesVO.Create, pFiltro, pPagina);

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
          FDataModule.CDSLookup.FieldByName('NOME').AsString := ResultSet.Value['NOME'].AsString;
          FDataModule.CDSLookup.FieldByName('ALTURA').AsInteger := ResultSet.Value['ALTURA'].AsInt32;
          FDataModule.CDSLookup.FieldByName('LARGURA').AsInteger := ResultSet.Value['LARGURA'].AsInt32;
          FDataModule.CDSLookup.FieldByName('TOPO').AsInteger := ResultSet.Value['TOPO'].AsInt32;
          FDataModule.CDSLookup.FieldByName('ESQUERDA').AsInteger := ResultSet.Value['ESQUERDA'].AsInt32;
          FDataModule.CDSLookup.FieldByName('TAMANHO_FONTE').AsInteger := ResultSet.Value['TAMANHO_FONTE'].AsInt32;
          FDataModule.CDSLookup.FieldByName('TEXTO').AsString := ResultSet.Value['TEXTO'].AsString;
          FDataModule.CDSLookup.FieldByName('DATA_SINCRONIZACAO').AsString := ResultSet.Value['DATA_SINCRONIZACAO'].AsString;
          FDataModule.CDSLookup.FieldByName('HORA_SINCRONIZACAO').AsString := ResultSet.Value['HORA_SINCRONIZACAO'].AsString;
          FDataModule.CDSLookup.Post;
        end;
        FDataModule.CDSLookup.Open;
        FDataModule.CDSLookup.EnableControls;
      end
      else
      begin
        FDataModule.CDSComponentes.DisableControls;
        FDataModule.CDSComponentes.EmptyDataSet;
        while ResultSet.Next do
        begin
          FDataModule.CDSComponentes.Append;
          for I := 0 to FDataModule.CDSComponentes.FieldCount -1 do
          begin
            if  ResultSet.Value[FDataModule.CDSComponentes.FieldDefList[i].Name].ValueType.DataType = 2 then
            begin
             if ResultSet.Value[FDataModule.CDSComponentes.FieldDefList[i].Name].GetDate > 0 then
                FDataModule.CDSComponentes.Fields[i].AsString := DataParaTexto(ResultSet.Value[FDataModule.CDSComponentes.FieldDefList[i].Name].AsDateTime);
            end
            else
            if  ResultSet.Value[FDataModule.CDSComponentes.FieldDefList[i].Name].ValueType.DataType = 8 then
            begin
              if not ResultSet.Value[FDataModule.CDSComponentes.FieldDefList[i].Name].IsNull  then
              begin
                FDataModule.CDSComponentes.Fields[i].AsFloat :=  ResultSet.Value[FDataModule.CDSComponentes.FieldDefList[i].Name].AsDouble;
              end
              else FDataModule.CDSComponentes.Fields[i].AsFloat := 0;
            end
            else
            if ResultSet.Value[FDataModule.CDSComponentes.FieldDefList[i].Name].AsString <> '' then
              FDataModule.CDSComponentes.Fields[i].AsString := ResultSet.Value[FDataModule.CDSComponentes.FieldDefList[i].Name].AsString;
          end;
          FDataModule.CDSComponentes.Post;
          {
          FDataModule.CDSComponentes.Append;
          FDataModule.CDSComponentes.FieldByName('ID').AsInteger := ResultSet.Value['ID'].AsInt32;
          FDataModule.CDSComponentes.FieldByName('NOME_CAIXA').AsString := ResultSet.Value['NOME_CAIXA'].AsString;
          FDataModule.CDSComponentes.FieldByName('ID_GERADO_CAIXA').AsInteger := ResultSet.Value['ID_GERADO_CAIXA'].AsInt32;
          FDataModule.CDSComponentes.FieldByName('ID_EMPRESA').AsInteger := ResultSet.Value['ID_EMPRESA'].AsInt32;
          FDataModule.CDSComponentes.FieldByName('NOME').AsString := ResultSet.Value['NOME'].AsString;
          FDataModule.CDSComponentes.FieldByName('ALTURA').AsInteger := ResultSet.Value['ALTURA'].AsInt32;
          FDataModule.CDSComponentes.FieldByName('LARGURA').AsInteger := ResultSet.Value['LARGURA'].AsInt32;
          FDataModule.CDSComponentes.FieldByName('TOPO').AsInteger := ResultSet.Value['TOPO'].AsInt32;
          FDataModule.CDSComponentes.FieldByName('ESQUERDA').AsInteger := ResultSet.Value['ESQUERDA'].AsInt32;
          FDataModule.CDSComponentes.FieldByName('TAMANHO_FONTE').AsInteger := ResultSet.Value['TAMANHO_FONTE'].AsInt32;
          FDataModule.CDSComponentes.FieldByName('TEXTO').AsString := ResultSet.Value['TEXTO'].AsString;
          FDataModule.CDSComponentes.FieldByName('DATA_SINCRONIZACAO').AsString := ResultSet.Value['DATA_SINCRONIZACAO'].AsString;
          FDataModule.CDSComponentes.FieldByName('HORA_SINCRONIZACAO').AsString := ResultSet.Value['HORA_SINCRONIZACAO'].AsString;
          FDataModule.CDSComponentes.Post;
          }
        end;
        //FDataModule.CDSComponentes.Open;
        FDataModule.CDSComponentes.EnableControls;
      end;
    except
    end;
  finally
    ResultSet.Free;
  end;
end;

class Procedure TEcfPosicaoComponentesController.Insere(pEcfPosicaoComponentes: TEcfPosicaoComponentesVO);
var
  UltimoID:Integer;
begin
  try
    try
      UltimoID := TT2TiORM.Inserir(pEcfPosicaoComponentes);
      Consulta('ID='+IntToStr(UltimoID),0,False);
    except
      Application.MessageBox('Ocorreu um erro. Inclusão não realizada.', 'Erro do sistema', MB_OK + MB_ICONERROR);
    end;
  finally
  end;
end;

class Procedure TEcfPosicaoComponentesController.Altera(pEcfPosicaoComponentes: TEcfPosicaoComponentesVO; pFiltro: String; pPagina: Integer);
begin
  try
    try
      TT2TiORM.Alterar(pEcfPosicaoComponentes);
      Consulta(pFiltro, pPagina,False);
    except
      Application.MessageBox('Ocorreu um erro. Alteração não realizada.', 'Erro do sistema', MB_OK + MB_ICONERROR);
    end;
  finally
  end;
end;


class Procedure TEcfPosicaoComponentesController.Exclui(pId: Integer);
begin
  try
    try
      EcfPosicaoComponentes := TEcfPosicaoComponentesVO.Create;
      EcfPosicaoComponentes.Id := pId;
      TT2TiORM.Excluir(EcfPosicaoComponentes);
    except
      Application.MessageBox('Ocorreu um erro na exclusão do cliente.', 'Erro do sistema', MB_OK + MB_ICONERROR);
    end;
  finally
  end;
end;

end.
