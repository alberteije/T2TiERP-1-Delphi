{ *******************************************************************************
  Title: T2Ti ERP
  Description: Controller do lado Cliente relacionado ao Sintegra

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
  @version 1.0   |   Fernando  @version 1.0.0.10
  ******************************************************************************* }
unit SintegraController;

interface

uses
  Classes, DBXJSON, DSHTTP, Dialogs, SysUtils, DBClient, DB,
  Windows, Forms, Controller, Rtti, Atributos;

type
  TSintegraController = class(TController)
  private
    class var FDataSet: TClientDataSet;
  public
    class procedure Consulta(pFiltro: String; pPagina: Integer);

    class function GetDataSet: TClientDataSet; override;
    class procedure SetDataSet(pDataSet: TClientDataSet); override;

    class function MethodCtx: String; override;
  end;

implementation

uses UDataModule, Conversor, UPreview;

class procedure TSintegraController.Consulta(pFiltro: String; pPagina: Integer);
var
  StreamResposta: TStringStream;
  ObjResposta: TJSONObject;
  ParResposta: TJSONPair;
  ArrayResposta: TJSONArray;
  ArquivoRemoto, ArquivoLocal: String;
begin
  try
    StreamResposta := TStringStream.Create;
    try
      Get([pFiltro, IntToStr(pPagina)], StreamResposta);
      //
      ObjResposta := TJSONObject.Create;
      ObjResposta.Parse(StreamResposta.Bytes, 0);
      ParResposta := ObjResposta.Get(0);
      ArrayResposta := TJSONArray(TJSONArray(ParResposta.JsonValue).Get(0));
      if ArrayResposta.Size > 0 then
      begin
        if ArrayResposta.Get(0).ToString = '"OK"' then
        begin
          ArquivoRemoto := ArrayResposta.Get(1).ToString;
          //retira as aspas do JSON
          System.Delete(ArquivoRemoto, Length(ArquivoRemoto), 1);
          System.Delete(ArquivoRemoto, 1, 1);

          //Baixa o arquivo
          ArquivoLocal := DownloadArquivo(ArquivoRemoto, 'SINTEGRA');
          if ArquivoLocal <> '' then
            Application.CreateForm(TFPreview, FPreview);
            FPreview.RichEdit.Lines.LoadFromFile(ArquivoLocal);
            FPreview.ShowModal;
        end;
      end;
    finally
      StreamResposta.Free;
      ObjResposta.Free;
    end;
  except
    on E: Exception do
      Application.MessageBox(PChar('Ocorreu um erro durante a consulta. Informe a mensagem ao Administrador do sistema.' + #13 + #13 + E.Message), 'Erro do sistema', MB_OK + MB_ICONERROR);
  end;
end;

class function TSintegraController.GetDataSet: TClientDataSet;
begin
  Result := FDataSet;
end;

class procedure TSintegraController.SetDataSet(pDataSet: TClientDataSet);
begin
  FDataSet := pDataSet;
end;

class function TSintegraController.MethodCtx: String;
begin
  Result := 'Sintegra';
end;

end.
