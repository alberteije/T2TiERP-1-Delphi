{*******************************************************************************
Title: T2Ti ERP
Description: Unit de controle da tabela PAPEL - Lado Cliente

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
           fabio_thz@yahoo.com.br</p>

@author Fábio Thomaz (T2Ti.COM)
@version 1.0
*******************************************************************************}
unit PapelController;

interface

uses
  Classes, DBXJSON, DSHTTP, Dialogs, SysUtils, DBClient, DB, Windows, Forms,
  PapelVO, Controller, Rtti, Atributos;

type
  TPapelController = class(TController)
  private
    class var FDataSet: TClientDataSet;
  public
    class procedure Consulta(pFiltro: String; pPagina: Integer);
    class procedure Insere(pPapel: TPapelVO);
    class procedure Altera(pPapel: TPapelVO; pFiltro: String; pPagina: Integer);
    class procedure Exclui(pId: Integer);

    class function GetDataSet: TClientDataSet; override;
    class procedure SetDataSet(pDataSet: TClientDataSet); override;

    class function MethodCtx: string; override;
  end;

implementation

uses UDataModule;

class procedure TPapelController.Insere(pPapel: TPapelVO);
var
  dataStream: TStringStream;
  streamResposta: TStringStream;
  jItem: TJSONValue;
begin
  dataStream := nil;
  try
    try
      jItem := TPapelVO.ObjectToJSON<TPapelVO>(pPapel);
      dataStream := TStringStream.Create(jItem.ToString);
      streamResposta := TStringStream.Create;
      Put([],dataStream, streamResposta);
      PopulaGrid<TPapelVO>(streamResposta);
    except
      Application.MessageBox('Ocorreu um erro. Inclusão não realizada.', 'Erro do sistema', MB_OK + MB_ICONERROR);
    end;
  finally
    dataStream.Free;
    streamResposta.Free;
    jItem.Free;
  end;
end;

class function TPapelController.MethodCtx: string;
begin
  Result := 'Papel';
end;

class procedure TPapelController.SetDataSet(pDataSet: TClientDataSet);
begin
  FDataSet := pDataSet;
end;

class procedure TPapelController.Altera(pPapel: TPapelVO; pFiltro: String; pPagina: Integer);
var
  dataStream: TStringStream;
  streamResposta: TStringStream;
  jItems: TJSONArray;
  jItem: TJSONValue;
begin
  dataStream := nil;
  try
    try
      jItem := TPapelVO.ObjectToJSON<TPapelVO>(pPapel);

      jItems := TJSONArray.Create;
      jItems.AddElement(jItem);

      pFiltro := StringReplace(pFiltro,'"','\"',[rfReplaceAll]);
      jItems.AddElement(TJSOnString.Create(pFiltro));
      jItems.AddElement(TJSONNumber.Create(pPagina));

      dataStream := TStringStream.Create(jItems.ToString);
      streamResposta := TStringStream.Create;
      Post([], dataStream, streamResposta);
      //PopulaGrid<TPapelVO>(streamResposta);
    except
      Application.MessageBox('Ocorreu um erro. Alteração não realizada.', 'Erro do sistema', MB_OK + MB_ICONERROR);
    end;
  finally
    dataStream.Free;
    jItems.Free;
    streamResposta.Free;
  end;
end;

class procedure TPapelController.Exclui(pId: Integer);
begin
  try
    Delete(MethodCtx,[IntToStr(pId)]);
  except
    Application.MessageBox('Ocorreu um erro na exclusão do papel.', 'Erro do sistema', MB_OK + MB_ICONERROR);
  end;
end;

class function TPapelController.GetDataSet: TClientDataSet;
begin
  Result := FDataSet;
end;

class procedure TPapelController.Consulta(pFiltro: String; pPagina: Integer);
var
  streamResposta: TStringStream;
begin
  streamResposta := nil;
  try
    try
      streamResposta := TStringStream.Create;
      Get([pFiltro ,IntToStr(pPagina)], streamResposta);
      PopulaGrid<TPapelVO>(streamResposta);
    except
      Application.MessageBox('Ocorreu um erro na consulta aos dados.', 'Erro do sistema', MB_OK + MB_ICONERROR);
    end;
  finally
    streamResposta.Free;
  end;
end;

end.
