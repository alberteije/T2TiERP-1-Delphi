{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: Controller do lado Cliente relacionado à tabela [USUARIO] 
                                                                                
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
                                                                                
fabio_thz@yahoo.com.br | t2ti.com@gmail.com | fernandololiver@gmail.com
@author @author Fábio Thomaz | Albert Eije (T2Ti.COM) | Fernando L Oliveira
@version 1.0                                                                    
*******************************************************************************}
unit UsuarioController;

interface

uses
  Classes, DBXJSON, DSHTTP, Dialogs, SysUtils, DBClient, DB,
  Windows, Forms, Controller, Rtti, Atributos, UsuarioVO;

type
  TUsuarioController = class(TController)
  private
    class var FDataSet: TClientDataSet;
  public
    class function Usuario(pLogin, pSenha: string): TUsuarioVO;
    
    class procedure Consulta(pFiltro: String; pPagina: Integer);
    class function Insere(pUsuario: TUsuarioVO): Boolean;
    class function Altera(pUsuario, pUsuarioOld: TUsuarioVO): Boolean;
    class function Exclui(pId: Integer): Boolean;

    class function GetDataSet: TClientDataSet; override;
    class procedure SetDataSet(pDataSet: TClientDataSet); override;

    class function MethodCtx: String; override;
    class function CriptografarLoginSenha(pLogin, pSenha: string): string;
  end;

implementation

uses UDataModule, Conversor, Biblioteca;

class procedure TUsuarioController.Consulta(pFiltro: String; pPagina: Integer);
var
  StreamResposta: TStringStream;
begin
  try
    StreamResposta := TStringStream.Create;
    try
      Get([pFiltro, IntToStr(pPagina)], StreamResposta);
      PopulaGrid<TUsuarioVO>(StreamResposta);
    finally
      StreamResposta.Free;
    end;
  except
    on E: Exception do
      Application.MessageBox(PChar('Ocorreu um erro durante a consulta. Informe a mensagem ao Administrador do sistema.' + #13 + #13 + E.Message), 'Erro do sistema', MB_OK + MB_ICONERROR);
  end;
end;

class function TUsuarioController.Insere(pUsuario: TUsuarioVO): Boolean;
var
  DataStream: TStringStream;
  StreamResposta: TStringStream;
  jRegistro: TJSONArray;
begin
  Result := False;
  try
    StreamResposta := TStringStream.Create;
    try
      DataStream := TStringStream.Create(pUsuario.ToJSONString);
      try
        Put([], DataStream, StreamResposta);
      finally
        DataStream.Free;
      end;

      jRegistro := TConversor.JSONArrayStreamToJSONArray(StreamResposta);
      try
        if jRegistro.Size > 0 then
        begin
          Result := True;
          PopulaGrid<TUsuarioVO>(StreamResposta);
        end;
      finally
        jRegistro.Free;
      end;
    finally
      StreamResposta.Free;
    end;
  except
    on E: Exception do
      Application.MessageBox(PChar('Ocorreu um erro na inclusão do registro. Informe a mensagem ao Administrador do sistema.' + #13 + #13 + E.Message), 'Erro do sistema', MB_OK + MB_ICONERROR);
  end;
end;

class function TUsuarioController.Altera(pUsuario, pUsuarioOld: TUsuarioVO): Boolean;
var
  DataStream: TStringStream;
  StreamResposta: TStringStream;
  ObjetosJson: TJSONArray;
begin
  try
    StreamResposta := TStringStream.Create;
    ObjetosJson := TJSONArray.Create;
    ObjetosJson.AddElement(pUsuario.ObjectToJSON<TUsuarioVO>(pUsuario));
    ObjetosJson.AddElement(pUsuarioOld.ObjectToJSON<TUsuarioVO>(pUsuarioOld));
    try
      DataStream := TStringStream.Create(ObjetosJson.ToString);
      try
        Post([], DataStream, StreamResposta);
      finally
        DataStream.Free;
        ObjetosJson.Free;
      end;
      Result := TConversor.JSONObjectStreamToBoolean(StreamResposta);
    finally
      StreamResposta.Free;
    end;
  except
    on E: Exception do
      Application.MessageBox(PChar('Ocorreu um erro na alteração do registro. Informe a mensagem ao Administrador do sistema.' + #13 + #13 + E.Message), 'Erro do sistema', MB_OK + MB_ICONERROR);
  end;
end;

class function TUsuarioController.Exclui(pId: Integer): Boolean;
begin
  try
    Result := TConversor.JSONPairStrToBoolean(Delete([IntToStr(pId)]));
  except
    on E: Exception do
      Application.MessageBox(PChar('Ocorreu um erro na exclusão do registro. Informe a mensagem ao Administrador do sistema.' + #13 + #13 + E.Message), 'Erro do sistema', MB_OK + MB_ICONERROR);
  end;
end;

class function TUsuarioController.GetDataSet: TClientDataSet;
begin
  Result := FDataSet;
end;

class function TUsuarioController.CriptografarLoginSenha(pLogin, pSenha: string): string;
begin
  Result := MD5String(pLogin+pSenha);
end;

class procedure TUsuarioController.SetDataSet(pDataSet: TClientDataSet);
begin
  FDataSet := pDataSet;
end;

class function TUsuarioController.MethodCtx: String;
begin
  Result := 'Usuario';
end;

class function TUsuarioController.Usuario(pLogin, pSenha: string): TUsuarioVO;
var
  streamResposta: TStringStream;
  jItems: TJSONArray;
  Filtro: string;
begin
  Result := nil;
  try
    Filtro := 'LOGIN = '+QuotedStr(pLogin)+' AND SENHA = '+QuotedStr(CriptografarLoginSenha(pLogin,pSenha));

    streamResposta := TStringStream.Create;
    try
      Get('Usuario', [Filtro,'0'] , streamResposta);

      jItems := TConversor.JSONArrayStreamToJSONArray(streamResposta);
      try
        if jItems.Size = 1 then
          Result := TUsuarioVO.JSONToObject<TUsuarioVO>(jItems.Get(0));
      finally
        jItems.Free;
      end;
    finally
      streamResposta.Free;
    end;
  except
    raise;
  end;
end;

end.
