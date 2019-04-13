{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: Controller do lado Cliente relacionado à tabela [EcfImpressora]
                                                                                
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
unit EcfImpressoraController;

interface


uses
 Classes, Dialogs, SysUtils, DBClient, DB, Windows, Forms, DBXCommon, EcfImpressoraVO;


type
  TEcfImpressoraController = class
  private
  protected
  public
    class procedure Consulta(pFiltro: String; pPagina: Integer; pLookup: Boolean);
    class procedure Insere(pEcfImpressora: TEcfImpressoraVO);
    class procedure Altera(pEcfImpressora: TEcfImpressoraVO; pFiltro: String; pPagina: Integer);
    class procedure Exclui(pId: Integer);
  end;

implementation

uses UDataModule, T2TiORM;

var
  EcfImpressora: TEcfImpressoraVO;

class procedure TEcfImpressoraController.Consulta(pFiltro: String; pPagina: Integer; pLookup: Boolean);
var
  ResultSet: TDBXReader;
  ConsultaSQL: String;
begin
  try
    try
      pFiltro := StringReplace(pFiltro,'*','%',[rfReplaceAll]);
      ResultSet := TT2TiORM.Consultar(TEcfImpressoraVO.Create, pFiltro, pPagina);

      if pLookup then
      begin
        FDataModule.CDSLookup.DisableControls;
        FDataModule.CDSLookup.EmptyDataSet;
        while ResultSet.Next do
        begin
          FDataModule.CDSLookup.Append;
          FDataModule.CDSLookup.FieldByName('ID').AsInteger := ResultSet.Value['ID'].AsInt32;
          FDataModule.CDSLookup.FieldByName('NUMERO').AsInteger := ResultSet.Value['NUMERO'].AsInt32;
          FDataModule.CDSLookup.FieldByName('CODIGO').AsString := ResultSet.Value['CODIGO'].AsString;
          FDataModule.CDSLookup.FieldByName('SERIE').AsString := ResultSet.Value['SERIE'].AsString;
          FDataModule.CDSLookup.FieldByName('IDENTIFICACAO').AsString := ResultSet.Value['IDENTIFICACAO'].AsString;
          FDataModule.CDSLookup.FieldByName('MC').AsString := ResultSet.Value['MC'].AsString;
          FDataModule.CDSLookup.FieldByName('MD').AsString := ResultSet.Value['MD'].AsString;
          FDataModule.CDSLookup.FieldByName('VR').AsString := ResultSet.Value['VR'].AsString;
          FDataModule.CDSLookup.FieldByName('TIPO').AsString := ResultSet.Value['TIPO'].AsString;
          FDataModule.CDSLookup.FieldByName('MARCA').AsString := ResultSet.Value['MARCA'].AsString;
          FDataModule.CDSLookup.FieldByName('MODELO').AsString := ResultSet.Value['MODELO'].AsString;
          FDataModule.CDSLookup.FieldByName('MODELO_ACBR').AsString := ResultSet.Value['MODELO_ACBR'].AsString;
          FDataModule.CDSLookup.FieldByName('MODELO_DOCUMENTO_FISCAL').AsString := ResultSet.Value['MODELO_DOCUMENTO_FISCAL'].AsString;
          FDataModule.CDSLookup.FieldByName('VERSAO').AsString := ResultSet.Value['VERSAO'].AsString;
          FDataModule.CDSLookup.FieldByName('LE').AsString := ResultSet.Value['LE'].AsString;
          FDataModule.CDSLookup.FieldByName('LEF').AsString := ResultSet.Value['LEF'].AsString;
          FDataModule.CDSLookup.FieldByName('MFD').AsString := ResultSet.Value['MFD'].AsString;
          FDataModule.CDSLookup.FieldByName('LACRE_NA_MFD').AsString := ResultSet.Value['LACRE_NA_MFD'].AsString;
          FDataModule.CDSLookup.FieldByName('DOCTO').AsString := ResultSet.Value['DOCTO'].AsString;
          FDataModule.CDSLookup.Post;
        end;
        FDataModule.CDSLookup.Open;
        FDataModule.CDSLookup.EnableControls;
      end
      else
      begin
        FDataModule.CDSImpressora.DisableControls;
        FDataModule.CDSImpressora.EmptyDataSet;
        while ResultSet.Next do
        begin
          FDataModule.CDSImpressora.Append;
          FDataModule.CDSImpressora.FieldByName('ID').AsInteger := ResultSet.Value['ID'].AsInt32;
          FDataModule.CDSImpressora.FieldByName('NUMERO').AsInteger := ResultSet.Value['NUMERO'].AsInt32;
          FDataModule.CDSImpressora.FieldByName('CODIGO').AsString := ResultSet.Value['CODIGO'].AsString;
          FDataModule.CDSImpressora.FieldByName('SERIE').AsString := ResultSet.Value['SERIE'].AsString;
          FDataModule.CDSImpressora.FieldByName('IDENTIFICACAO').AsString := ResultSet.Value['IDENTIFICACAO'].AsString;
          FDataModule.CDSImpressora.FieldByName('MC').AsString := ResultSet.Value['MC'].AsString;
          FDataModule.CDSImpressora.FieldByName('MD').AsString := ResultSet.Value['MD'].AsString;
          FDataModule.CDSImpressora.FieldByName('VR').AsString := ResultSet.Value['VR'].AsString;
          FDataModule.CDSImpressora.FieldByName('TIPO').AsString := ResultSet.Value['TIPO'].AsString;
          FDataModule.CDSImpressora.FieldByName('MARCA').AsString := ResultSet.Value['MARCA'].AsString;
          FDataModule.CDSImpressora.FieldByName('MODELO').AsString := ResultSet.Value['MODELO'].AsString;
          FDataModule.CDSImpressora.FieldByName('MODELO_ACBR').AsString := ResultSet.Value['MODELO_ACBR'].AsString;
          FDataModule.CDSImpressora.FieldByName('MODELO_DOCUMENTO_FISCAL').AsString := ResultSet.Value['MODELO_DOCUMENTO_FISCAL'].AsString;
          FDataModule.CDSImpressora.FieldByName('VERSAO').AsString := ResultSet.Value['VERSAO'].AsString;
          FDataModule.CDSImpressora.FieldByName('LE').AsString := ResultSet.Value['LE'].AsString;
          FDataModule.CDSImpressora.FieldByName('LEF').AsString := ResultSet.Value['LEF'].AsString;
          FDataModule.CDSImpressora.FieldByName('MFD').AsString := ResultSet.Value['MFD'].AsString;
          FDataModule.CDSImpressora.FieldByName('LACRE_NA_MFD').AsString := ResultSet.Value['LACRE_NA_MFD'].AsString;
          FDataModule.CDSImpressora.FieldByName('DOCTO').AsString := ResultSet.Value['DOCTO'].AsString;
          FDataModule.CDSImpressora.Post;
        end;
        FDataModule.CDSImpressora.Open;
        FDataModule.CDSImpressora.EnableControls;
      end;
    except
    end;
  finally
    ResultSet.Free;
  end;
end;

class Procedure TEcfImpressoraController.Insere(pEcfImpressora: TEcfImpressoraVO);
var
  UltimoID:Integer;
begin
  try
    try
      UltimoID := TT2TiORM.Inserir(pEcfImpressora);
      Consulta('ID='+IntToStr(UltimoID),0,False);
    except
      Application.MessageBox('Ocorreu um erro. Inclusão não realizada.', 'Erro do sistema', MB_OK + MB_ICONERROR);
    end;
  finally
  end;
end;

class Procedure TEcfImpressoraController.Altera(pEcfImpressora: TEcfImpressoraVO; pFiltro: String; pPagina: Integer);
begin
  try
    try
      TT2TiORM.Alterar(pEcfImpressora);
      Consulta(pFiltro, pPagina,False);
    except
      Application.MessageBox('Ocorreu um erro. Alteração não realizada.', 'Erro do sistema', MB_OK + MB_ICONERROR);
    end;
  finally
  end;
end;

class Procedure TEcfImpressoraController.Exclui(pId: Integer);
begin
  try
    try
      EcfImpressora := TEcfImpressoraVO.Create;
      EcfImpressora.Id := pId;
      TT2TiORM.Excluir(EcfImpressora);
    except
      Application.MessageBox('Ocorreu um erro na exclusão do cliente.', 'Erro do sistema', MB_OK + MB_ICONERROR);
    end;
  finally
  end;
end;

end.
