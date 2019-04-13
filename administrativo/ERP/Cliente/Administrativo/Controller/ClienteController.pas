{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: Controller do lado Cliente relacionado à tabela [Cliente]
                                                                                
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
                                                                                
@author Fábio Thomaz (fabio_thz@yahoo.com.br)                            
@version 1.0                                                                    
*******************************************************************************}
unit ClienteController;

interface

uses
 Classes, DBXJSON, DSHTTP, Dialogs, SysUtils, DBClient, DB, Windows, Forms,Controller, Rtti, Atributos,ClienteVO;


type
  TClienteController = class(TController)
  private 
    class var FDataSet: TClientDataSet; 
  public
    class procedure Consulta(pFiltro: String; pPagina: Integer);
    class procedure Insere(pCliente: TClienteVO);
    class procedure Altera(pCliente: TClienteVO; pFiltro: String; pPagina: Integer);
    class procedure Exclui(pId: Integer);
    class function GetDataSet: TClientDataSet; override;
    class procedure SetDataSet(pDataSet: TClientDataSet); override;

    class function MethodCtx: string; override; 
  end;

implementation

uses UDataModule;

class procedure TClienteController.Insere(pCliente: TClienteVO);
var
  dataStream: TStringStream;
  streamResposta: TStringStream;
  jItem: TJSONValue;
begin
  dataStream := nil;
  try
    try
      jItem := TClienteVO.ObjectToJSON<TClienteVO>(pCliente);
      dataStream := TStringStream.Create(jItem.ToString);
      streamResposta := TStringStream.Create;
      Put([''],dataStream, streamResposta);
      PopulaGrid<TClienteVO>(streamResposta); 
    except
      Application.MessageBox('Ocorreu um erro. Inclusão não realizada.', 'Erro do sistema' , MB_OK + MB_ICONERROR);
    end;
  finally 
    dataStream.Free;
  end;
end;

class procedure TClienteController.SetDataSet(pDataSet: TClientDataSet);
begin
  FDataSet := pDataSet;
end;

class function TClienteController.GetDataSet: TClientDataSet;
begin
  Result := FDataSet;
end;

class function TClienteController.MethodCtx: string;
begin
  Result := 'Cliente';
end;

class procedure TClienteController.Altera(pCliente: TClienteVO; pFiltro: String; pPagina: Integer);
var
  dataStream: TStringStream;
  streamResposta: TStringStream;
  jItems: TJSONArray;
  jItem: TJSONValue;
begin
  dataStream := nil;
  try
    try
      jItem := TClienteVO.ObjectToJSON<TClienteVO>(pCliente);

      jItems := TJSONArray.Create;
      jItems.AddElement(jItem);

      pFiltro := StringReplace(pFiltro,'"','\"',[rfReplaceAll]);
      jItems.AddElement(TJSOnString.Create(pFiltro));
      jItems.AddElement(TJSONNumber.Create(pPagina));

      dataStream := TStringStream.Create(jItems.ToString);
      streamResposta := TStringStream.Create;
      Post([''], dataStream, streamResposta);
      PopulaGrid<TClienteVO>(streamResposta);
    except
      Application.MessageBox('Ocorreu um erro. Alteração não realizada.','Erro do sistema', MB_OK + MB_ICONERROR);
    end;
  finally
    dataStream.Free;
  end;
end;

class procedure TClienteController.Exclui(pId: Integer);
begin
  try
    Delete(MethodCtx,[IntToStr(pId)]);
  except
    Application.MessageBox('Ocorreu um erro na exclusão do registro.', 'Erro do sistema', MB_OK + MB_ICONERROR);
  end;
end;

class procedure TClienteController.Consulta(pFiltro: String; pPagina: Integer);
var
  streamResposta: TStringStream;
begin
  streamResposta := nil;
  try
    try
      streamResposta := TStringStream.Create;
      Get([pFiltro,IntToStr(pPagina)], streamResposta);
      PopulaGrid<TClienteVO>(streamResposta);
    except
      Application.MessageBox('Ocorreu um erro na consulta aos dados.', 'Erro do sistema', MB_OK + MB_ICONERROR);
    end;
  finally
    streamResposta.Free;
  end;
end;

end.
