{ *******************************************************************************
  Title: T2Ti ERP
  Description: Controller do lado Cliente relacionado à tabela [Funcao]

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
  ******************************************************************************* }
unit FuncaoController;

interface

uses
  Classes, DBXJSON, DSHTTP, Dialogs, SysUtils, DBClient, DB, Windows, Forms,
  Controller, Rtti, Atributos, FuncaoVO, Generics.Collections, Conversor,
  AdministrativoFormularioVO;

type
  TFuncaoController = class(TController)
  private
    class var FDataSet: TClientDataSet;
  public
    class procedure Consulta(pFiltro: String; pPagina: Integer);
    class procedure Insere(pFuncao: TFuncaoVO);
    class procedure Altera(pFuncao: TFuncaoVO; pFiltro: String; pPagina: Integer);
    class procedure Exclui(pId: Integer);

    class function FuncoesUsuario: TObjectList<TFuncaoVO>;
    class procedure VerificaAtualizaFuncoes(pFormularios: TObjectList<TAdministrativoFormularioVO>);

    class function GetDataSet: TClientDataSet; override;
    class procedure SetDataSet(pDataSet: TClientDataSet); override;

    class function MethodCtx: string; override;
  end;

implementation

class procedure TFuncaoController.Insere(pFuncao: TFuncaoVO);
var
  dataStream: TStringStream;
  streamResposta: TStringStream;
  jItem: TJSONValue;
begin
  dataStream := nil;
  try
    try
      jItem := TFuncaoVO.ObjectToJSON<TFuncaoVO>(pFuncao);
      dataStream := TStringStream.Create(jItem.ToString);
      streamResposta := TStringStream.Create;
      Put([], dataStream, streamResposta);
      PopulaGrid<TFuncaoVO>(streamResposta);
    except
      Application.MessageBox('Ocorreu um erro. Inclusão não realizada.', 'Erro do sistema', MB_OK + MB_ICONERROR);
    end;
  finally
    dataStream.Free;
    jItem.Free;
    streamResposta.Free;
  end;
end;

class procedure TFuncaoController.SetDataSet(pDataSet: TClientDataSet);
begin
  FDataSet := pDataSet;
end;

class function TFuncaoController.GetDataSet: TClientDataSet;
begin
  Result := FDataSet;
end;

class function TFuncaoController.MethodCtx: string;
begin
  Result := 'Funcao';
end;

class procedure TFuncaoController.Altera(pFuncao: TFuncaoVO; pFiltro: String; pPagina: Integer);
var
  dataStream: TStringStream;
  streamResposta: TStringStream;
  jItems: TJSONArray;
  jItem: TJSONValue;
begin
  dataStream := nil;
  try
    try
      jItem := TFuncaoVO.ObjectToJSON<TFuncaoVO>(pFuncao);

      jItems := TJSONArray.Create;
      jItems.AddElement(jItem);

      pFiltro := StringReplace(pFiltro, '"', '\"', [rfReplaceAll]);
      jItems.AddElement(TJSOnString.Create(pFiltro));
      jItems.AddElement(TJSONNumber.Create(pPagina));

      dataStream := TStringStream.Create(jItems.ToString);
      streamResposta := TStringStream.Create;
      Post([], dataStream, streamResposta);
      PopulaGrid<TFuncaoVO>(streamResposta);
    except
      Application.MessageBox('Ocorreu um erro. Alteração não realizada.', 'Erro do sistema', MB_OK + MB_ICONERROR);
    end;
  finally
    dataStream.Free;
    jItems.Free;
    streamResposta.Free;
    jItem.Free;
  end;
end;

class procedure TFuncaoController.Exclui(pId: Integer);
begin
  try
    Delete(MethodCtx, [IntToStr(pId)]);
  except
    Application.MessageBox('Ocorreu um erro na exclusão do registro.', 'Erro do sistema', MB_OK + MB_ICONERROR);
  end;
end;

class procedure TFuncaoController.Consulta(pFiltro: String; pPagina: Integer);
var
  streamResposta: TStringStream;
begin
  streamResposta := nil;
  try
    try
      streamResposta := TStringStream.Create;
      Get([pFiltro, IntToStr(pPagina)], streamResposta);
      PopulaGrid<TFuncaoVO>(streamResposta);
    except
      Application.MessageBox('Ocorreu um erro na consulta aos dados.', 'Erro do sistema', MB_OK + MB_ICONERROR);
    end;
  finally
    streamResposta.Free;
  end;
end;

class function TFuncaoController.FuncoesUsuario: TObjectList<TFuncaoVO>;
var
  streamResposta: TStringStream;
  jItems: TJSONArray;
  I: Integer;
  loFuncao: TFuncaoVO;
begin
  Result := TObjectList<TFuncaoVO>.Create;

  try
    streamResposta := TStringStream.Create;
    try
      Get('TListaFuncaoController', 'ListaFuncaoComAcesso', [], streamResposta);

      jItems := TConversor.JSONArrayStreamToJSONArray(streamResposta);
      try
        for I := 0 to jItems.Size - 1 do
        begin
          loFuncao := TFuncaoVO.JSONToObject<TFuncaoVO>(jItems.Get(I));
          Result.Add(loFuncao);
        end;
      finally
        jItems.Free;
      end;
    finally
      streamResposta.Free;
    end;
  except
    Application.MessageBox('Ocorreu um erro na consulta aos dados.', 'Erro do sistema', MB_OK + MB_ICONERROR);
  end;
end;

class procedure TFuncaoController.VerificaAtualizaFuncoes(pFormularios: TObjectList<TAdministrativoFormularioVO>);
var
  dataStream: TStringStream;
  streamResposta: TStringStream;
  ObjetosJson: TJSONArray;
  Enumerator: TEnumerator<TAdministrativoFormularioVO>;
begin
  try
    ObjetosJson := TJSONArray.Create;
    try
      Enumerator := pFormularios.GetEnumerator;
      try
        with Enumerator do
        begin
          while MoveNext do
          begin
            ObjetosJson.AddElement(Current.ToJSON);
          end;
        end;
      finally
        Enumerator.Free;
      end;

      dataStream := TStringStream.Create(ObjetosJson.ToString);
      try
        streamResposta := TStringStream.Create;
        try
          Post('TListaFuncaoController', 'ListaFuncao', [], dataStream, streamResposta);
        finally
          streamResposta.Free;
        end;
      finally
        dataStream.Free;
      end;
    finally
      ObjetosJson.Free;
    end;
  except
    Application.MessageBox('Ocorreu um erro. Alteração não realizada.', 'Erro do sistema', MB_OK + MB_ICONERROR);
  end;
end;

end.
