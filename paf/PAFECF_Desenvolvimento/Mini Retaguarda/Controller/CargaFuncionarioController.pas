{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: Controller do lado Cliente relacionado à tabela [CargaFuncionario]
                                                                                
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
unit CargaFuncionarioController;

interface

uses
 Classes, Dialogs, SysUtils, DBClient, DB, Windows, Forms, CargaFuncionarioVO, DBXCommon;

type
  TCargaFuncionarioController = class
  private
  protected
  public
    class Procedure Consulta(pFiltro: String; pPagina: Integer; pLookup: Boolean);
  end;

implementation

uses UDataModule, T2TiORM;

var
  CargaFuncionario: TCargaFuncionarioVO;

class procedure TCargaFuncionarioController.Consulta(pFiltro: String; pPagina: Integer; pLookup: Boolean);
var
  ResultSet: TDBXReader;
  ConsultaSQL: String;
begin
  try
    try
      pFiltro := StringReplace(pFiltro,'*','%',[rfReplaceAll]);
      ResultSet := TT2TiORM.Consultar(TCargaFuncionarioVO.Create, pFiltro, pPagina);

      if pLookup then
      begin
        FDataModule.CDSLookup.DisableControls;
        FDataModule.CDSLookup.EmptyDataSet;
        while ResultSet.Next do
        begin
          FDataModule.CDSLookup.Append;
          FDataModule.CDSLookup.FieldByName('ID').AsInteger := ResultSet.Value['ID'].AsInt32;
          FDataModule.CDSLookup.FieldByName('NOME').AsString := ResultSet.Value['NOME'].AsString;
          FDataModule.CDSLookup.FieldByName('FONE1').AsString := ResultSet.Value['FONE1'].AsString;
          FDataModule.CDSLookup.FieldByName('CELULAR').AsString := ResultSet.Value['CELULAR'].AsString;
          FDataModule.CDSLookup.FieldByName('EMAIL').AsString := ResultSet.Value['EMAIL'].AsString;
          FDataModule.CDSLookup.FieldByName('NIVEL_AUTORIZACAO_ECF').AsString := ResultSet.Value['NIVEL_AUTORIZACAO_ECF'].AsString;
          FDataModule.CDSLookup.Post;
        end;
        FDataModule.CDSLookup.Open;
        FDataModule.CDSLookup.EnableControls;
      end
      else
      begin
        FDataModule.CDSFuncionario.DisableControls;
        FDataModule.CDSFuncionario.EmptyDataSet;
        while ResultSet.Next do
        begin
          FDataModule.CDSFuncionario.Append;
          FDataModule.CDSFuncionario.FieldByName('ID').AsInteger := ResultSet.Value['ID'].AsInt32;
          FDataModule.CDSFuncionario.FieldByName('NOME').AsString := ResultSet.Value['NOME'].AsString;
          FDataModule.CDSFuncionario.FieldByName('FONE1').AsString := ResultSet.Value['FONE1'].AsString;
          FDataModule.CDSFuncionario.FieldByName('CELULAR').AsString := ResultSet.Value['CELULAR'].AsString;
          FDataModule.CDSFuncionario.FieldByName('EMAIL').AsString := ResultSet.Value['EMAIL'].AsString;
          FDataModule.CDSFuncionario.FieldByName('NIVEL_AUTORIZACAO_ECF').AsString := ResultSet.Value['NIVEL_AUTORIZACAO_ECF'].AsString;
          FDataModule.CDSFuncionario.Post;
        end;
        FDataModule.CDSFuncionario.Open;
        FDataModule.CDSFuncionario.EnableControls;
      end;
    except
    end;
  finally
    ResultSet.Free;
  end;
end;


end.
