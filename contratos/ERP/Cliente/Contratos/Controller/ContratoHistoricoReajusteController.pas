{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: Controller do lado Cliente relacionado � tabela [CONTRATO_HISTORICO_REAJUSTE] 
                                                                                
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
                                                                                
@author Albert Eije (t2ti.com@gmail.com)                    
@version 1.0                                                                    
*******************************************************************************}
unit ContratoHistoricoReajusteController;

interface

uses
  Classes, DBXJSON, DSHTTP, Dialogs, SysUtils, DBClient, DB,
  Windows, Forms, Controller, Rtti, Atributos, ContratoHistoricoReajusteVO;


type
  TContratoHistoricoReajusteController = class(TController)
  private
    class var FDataSet: TClientDataSet;
  public
    class procedure Consulta(pFiltro: String; pPagina: Integer);
    class function Insere(pContratoHistoricoReajuste: TContratoHistoricoReajusteVO): Boolean;
    class function Altera(pContratoHistoricoReajuste: TContratoHistoricoReajusteVO): Boolean;
    class function Exclui(pId: Integer): Boolean;

    class function GetDataSet: TClientDataSet; override;
    class procedure SetDataSet(pDataSet: TClientDataSet); override;

    class function MethodCtx: String; override;
  end;

implementation

uses UDataModule, Conversor;

class procedure TContratoHistoricoReajusteController.Consulta(pFiltro: String; pPagina: Integer);
var
  StreamResposta: TStringStream;
  V: TJSONValue;
begin
  try
    StreamResposta := TStringStream.Create;
    try
      Get([pFiltro, IntToStr(pPagina)], StreamResposta);
      PopulaGrid<TContratoHistoricoReajusteVO>(StreamResposta);
    except
      Application.MessageBox('Ocorreu um erro na consulta aos dados.', 'Erro do sistema', MB_OK + MB_ICONERROR);
    end;
  finally
    StreamResposta.Free;
  end;
end;

class function TContratoHistoricoReajusteController.Insere(pContratoHistoricoReajuste: TContratoHistoricoReajusteVO): Boolean;
var
  DataStream: TStringStream;
  StreamResposta: TStringStream;
  jRegistro: TJSONArray;
begin
  Result := False;
  try
    StreamResposta := TStringStream.Create;
    try
      DataStream := TStringStream.Create(pContratoHistoricoReajuste.ToJSONString);
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
          PopulaGrid<TContratoHistoricoReajusteVO>(StreamResposta);
        end;
      finally
        jRegistro.Free;
      end;
    finally
      StreamResposta.Free;
    end;
  except
    Application.MessageBox('Ocorreu um erro. Inclus�o n�o realizada.', 'Erro do sistema', MB_OK + MB_ICONERROR);
  end;
end;

class function TContratoHistoricoReajusteController.Altera(pContratoHistoricoReajuste: TContratoHistoricoReajusteVO): Boolean;
var
  DataStream: TStringStream;
  StreamResposta: TStringStream;
begin
  try
    StreamResposta := TStringStream.Create;
    try
      DataStream := TStringStream.Create(pContratoHistoricoReajuste.ToJSONString);
      try
        Post([], DataStream, StreamResposta);
      finally
        DataStream.Free;
      end;
      Result := TConversor.JSONObjectStreamToBoolean(StreamResposta);
    finally
      StreamResposta.Free;
    end;
  except
    Application.MessageBox('Ocorreu um erro. Altera��o n�o realizada.', 'Erro do sistema', MB_OK + MB_ICONERROR);
  end;
end;

class function TContratoHistoricoReajusteController.Exclui(pId: Integer): Boolean;
begin
  try
    Result := TConversor.JSONPairStrToBoolean(Delete([IntToStr(pId)]));
  except
    Application.MessageBox('Ocorreu um erro na exclus�o do registro.', 'Erro do sistema', MB_OK + MB_ICONERROR);
  end;
end;

class function TContratoHistoricoReajusteController.GetDataSet: TClientDataSet;
begin
  Result := FDataSet;
end;

class procedure TContratoHistoricoReajusteController.SetDataSet(pDataSet: TClientDataSet);
begin
  FDataSet := pDataSet;
end;

class function TContratoHistoricoReajusteController.MethodCtx: String;
begin
  Result := 'ContratoHistoricoReajuste';
end;

end.
