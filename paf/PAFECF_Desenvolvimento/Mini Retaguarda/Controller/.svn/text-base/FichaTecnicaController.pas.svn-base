{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: Controller do lado Cliente relacionado à tabela [FichaTecnica]
                                                                                
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
unit FichaTecnicaController;

interface

uses
   Classes, Dialogs, SysUtils, DBClient, DB, Windows, Forms, DBXCommon, FichaTecnicaVO;


type
  TFichaTecnicaController = class
  private
  protected
  public
    class Procedure Consulta(pFiltro: String; pPagina: Integer; pLookup: Boolean);
    class Procedure Insere(pFichaTecnica: TFichaTecnicaVO);
    class Procedure Altera(pFichaTecnica: TFichaTecnicaVO; pFiltro: String; pPagina: Integer);
    class Procedure Exclui(pId: Integer);
  end;

implementation


uses UDataModule, T2TiORM;

var
  FichaTecnica: TFichaTecnicaVO;

class procedure TFichaTecnicaController.Consulta(pFiltro: String; pPagina: Integer; pLookup: Boolean);
var
  ResultSet: TDBXReader;
  ConsultaSQL: String;
begin
  try
    try
      pFiltro := StringReplace(pFiltro,'*','%',[rfReplaceAll]);
      ResultSet := TT2TiORM.Consultar(TFichaTecnicaVO.Create, pFiltro, pPagina);

      if pLookup then
      begin
        FDataModule.CDSLookup.DisableControls;
        FDataModule.CDSLookup.EmptyDataSet;
        while ResultSet.Next do
        begin
          FDataModule.CDSLookup.Append;
          FDataModule.CDSLookup.FieldByName('ID').AsInteger := ResultSet.Value['ID'].AsInt32;
          FDataModule.CDSLookup.FieldByName('ID_PRODUTO').AsInteger := ResultSet.Value['ID_PRODUTO'].AsInt32;
          FDataModule.CDSLookup.FieldByName('DESCRICAO').AsString := ResultSet.Value['DESCRICAO'].AsString;
          FDataModule.CDSLookup.FieldByName('ID_PRODUTO_FILHO').AsInteger := ResultSet.Value['ID_PRODUTO_FILHO'].AsInt32;
          FDataModule.CDSLookup.FieldByName('QUANTIDADE').AsFloat := ResultSet.Value['QUANTIDADE'].AsDouble;
          FDataModule.CDSLookup.Post;
        end;
        FDataModule.CDSLookup.Open;
        FDataModule.CDSLookup.EnableControls;
      end
      else
      begin
        FDataModule.CDSFicha.DisableControls;
        FDataModule.CDSFicha.EmptyDataSet;
        while ResultSet.Next do
        begin
          FDataModule.CDSFicha.Append;
          FDataModule.CDSFicha.FieldByName('ID').AsInteger := ResultSet.Value['ID'].AsInt32;
          FDataModule.CDSFicha.FieldByName('ID_PRODUTO').AsInteger := ResultSet.Value['ID_PRODUTO'].AsInt32;
          FDataModule.CDSFicha.FieldByName('DESCRICAO').AsString := ResultSet.Value['DESCRICAO'].AsString;
          FDataModule.CDSFicha.FieldByName('ID_PRODUTO_FILHO').AsInteger := ResultSet.Value['ID_PRODUTO_FILHO'].AsInt32;
          FDataModule.CDSFicha.FieldByName('QUANTIDADE').AsFloat := ResultSet.Value['QUANTIDADE'].AsDouble;
          FDataModule.CDSFicha.Post;
        end;
        FDataModule.CDSFicha.Open;
        FDataModule.CDSFicha.EnableControls;
      end;
    except
    end;
  finally
    ResultSet.Free;
  end;
end;

class Procedure TFichaTecnicaController.Insere(pFichaTecnica: TFichaTecnicaVO);
var
  UltimoID:Integer;
begin
  try
    try
      UltimoID := TT2TiORM.Inserir(pFichaTecnica);
      Consulta('ID='+IntToStr(UltimoID),0,False);
    except
      Application.MessageBox('Ocorreu um erro. Inclusão não realizada.', 'Erro do sistema', MB_OK + MB_ICONERROR);
    end;
  finally
  end;
end;

class Procedure TFichaTecnicaController.Altera(pFichaTecnica: TFichaTecnicaVO; pFiltro: String; pPagina: Integer);
begin
  try
    try
      TT2TiORM.Alterar(pFichaTecnica);
      Consulta(pFiltro, pPagina,False);
    except
      Application.MessageBox('Ocorreu um erro. Alteração não realizada.', 'Erro do sistema', MB_OK + MB_ICONERROR);
    end;
  finally
  end;
end;

class Procedure TFichaTecnicaController.Exclui(pId: Integer);
begin
  try
    try
      FichaTecnica := TFichaTecnicaVO.Create;
      FichaTecnica.Id := pId;
      TT2TiORM.Excluir(FichaTecnica);
    except
      Application.MessageBox('Ocorreu um erro na exclusão do cliente.', 'Erro do sistema', MB_OK + MB_ICONERROR);
    end;
  finally
  end;
end;

end.
