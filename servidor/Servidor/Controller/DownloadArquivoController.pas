{ *******************************************************************************
  Title: T2Ti ERP
  Description: Unit que controla o download de arquivos solicitados - Lado Servidor

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

  @author Albert Eije (T2Ti.COM)
  @version 1.0
  ******************************************************************************* }
unit DownloadArquivoController;

interface

uses
  Classes, SQLExpr, SysUtils, Generics.Collections, Controller, DBXJSON, DBXCommon,
  SWSystem;

type
  TDownloadArquivoController = class(TController)
  protected
  public
    // consultar
    Function DownloadArquivo(pSessao: String; pArquivo: String; pModulo: String): TJSONArray;
  end;

implementation

uses
  T2TiORM, SA;

function TDownloadArquivoController.DownloadArquivo(pSessao: String; pArquivo: String; pModulo: String): TJSONArray;
var
  resultSet: TDBXReader;
  Arquivo, BytesArquivo, TipoArquivo: String;
  ArquivoStream: TStringStream;
  i: Integer;
begin
  resultSet := nil;
  try
    try
      result := TJSONArray.Create;
      ArquivoStream := TStringStream.Create;

      if pModulo = 'GED' then
        Arquivo := StringReplace(pArquivo,'|','\',[rfReplaceAll])
      else if pModulo = 'PRODUTO' then
        Arquivo := gsAppPath + 'Arquivos\Imagens\Produtos\' + pArquivo
      else if pModulo = 'EMPRESA' then
        Arquivo := gsAppPath + 'Arquivos\Imagens\Empresa\' + pArquivo
      else if pModulo = 'SPED' then
        Arquivo := gsAppPath + 'Arquivos\Sped\' + pArquivo
      else if pModulo = 'SINTEGRA' then
        Arquivo := gsAppPath + 'Arquivos\Sintegra\' + pArquivo
      else if pModulo = 'CONTRATOS' then
        Arquivo := gsAppPath + 'Arquivos\Contratos\' + pArquivo
      else if pModulo = 'CONTRATOS_TEMPLATE' then
        Arquivo := gsAppPath + 'Arquivos\Contratos\Templates\' + pArquivo;

      if FileExists(Arquivo) then
      begin
        ArquivoStream.LoadFromFile(Arquivo);

        BytesArquivo := '';

        // laço pra pegar os bytes do arquivo ou imagem
        for i := 0 to ArquivoStream.Size - 1 do
        begin
          BytesArquivo := BytesArquivo + IntToStr(ArquivoStream.Bytes[i]) + ', ';
        end;
        // Tira a ultima virgula
        Delete(BytesArquivo, Length(BytesArquivo) - 1, 2);

        // adiciona o arquivo no array do json (posicao zero do array)
        result.Add(BytesArquivo);

        TipoArquivo := ExtractFileExt(pArquivo);

        // adiciona o tipo do arquivo no array (posicao um do array)
        result.AddElement(TJSONString.Create(TipoArquivo));
      end
      else
      begin
        result.AddElement(TJSONString.Create('RESPOSTA'));
        result.AddElement(TJSONString.Create('Arquivo Inexistente.'));
      end;
      // Log Resposta
      FSA.MemoResposta.Lines.Clear;
      FSA.MemoResposta.Lines.Add(result.ToString);
    except
      on E: Exception do
      begin
        result.AddElement(TJSONString.Create('ERRO'));
        result.AddElement(TJSONString.Create(E.Message));
      end;
    end;
  finally
    resultSet.Free;
  end;
end;

end.
