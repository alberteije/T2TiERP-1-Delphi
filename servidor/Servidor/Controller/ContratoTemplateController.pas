{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: Controller do lado Servidor relacionado à tabela [CONTRATO_TEMPLATE] 
                                                                                
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
           t2ti.com@gmail.com                                                   

@author Albert Eije (t2ti.com@gmail.com)
@version 1.0
*******************************************************************************}
unit ContratoTemplateController;

interface

uses
  Classes, SQLExpr, SysUtils, Generics.Collections, Controller, DBXJSON, DBXCommon,
  Biblioteca, SWSystem;

type
  TContratoTemplateController = class(TController)
  private
    function ArmazenarArquivo: Boolean;
  protected
  public
    //consultar
    function ContratoTemplate(pSessao: String; pFiltro: String; pPagina: Integer): TJSONArray;
    //inserir
    function AcceptContratoTemplate(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //alterar
    function UpdateContratoTemplate(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //excluir
    function CancelContratoTemplate(pSessao: String; pId: Integer): TJSONArray;
  end;

implementation

uses
  ContratoTemplateVO, T2TiORM, SA;

{ TContratoTemplateController }

var
  objContratoTemplate: TContratoTemplateVO;
  Resultado: Boolean;

function TContratoTemplateController.ContratoTemplate(pSessao, pFiltro: String; pPagina: Integer): TJSONArray;
begin
  pFiltro := pFiltro + ' AND ID_EMPRESA = ' + IntToStr(Sessao(pSessao).IdEmpresa);
  Result := TJSONArray.Create;
  try
    if Pos('ID=', pFiltro) > 0 then
      Result := TT2TiORM.Consultar<TContratoTemplateVO>(pFiltro, pPagina, True)
    else
      Result := TT2TiORM.Consultar<TContratoTemplateVO>(pFiltro, pPagina, False);
  except
    on E: Exception do
    begin
      Result.AddElement(TJSOnString.Create('ERRO'));
      Result.AddElement(TJSOnString.Create(E.Message));
    end;
  end;

  FSA.MemoResposta.Lines.Clear;
  FSA.MemoResposta.Lines.Add(result.ToString);
end;

function TContratoTemplateController.AcceptContratoTemplate(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  UltimoID:Integer;
begin
  objContratoTemplate := TContratoTemplateVO.Create(pObjeto);
  Result := TJSONArray.Create;
  try
    try
      UltimoID := TT2TiORM.Inserir(objContratoTemplate);

      // Se subiu um documento, armazena
      if objContratoTemplate.Arquivo <> '' then
      begin
        objContratoTemplate.Id := UltimoID;
        ArmazenarArquivo;
      end;

      Result := ContratoTemplate(pSessao, 'ID = ' + IntToStr(UltimoID), 0);
    except
      on E: Exception do
      begin
        Result.AddElement(TJSOnString.Create('ERRO'));
        Result.AddElement(TJSOnString.Create(E.Message));
      end;
    end;
  finally
    objContratoTemplate.Free;
  end;
end;

function TContratoTemplateController.UpdateContratoTemplate(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  objContratoTemplateOld: TContratoTemplateVO;
begin
 //Objeto Novo
  objContratoTemplate := TContratoTemplateVO.Create((pObjeto as TJSONArray).Get(0));
  //Objeto Antigo
  objContratoTemplateOld := TContratoTemplateVO.Create((pObjeto as TJSONArray).Get(1));
  Result := TJSONArray.Create;
  try
    try
      // Se subiu um documento, armazena
      if objContratoTemplate.Arquivo <> '' then
        Resultado := ArmazenarArquivo;

      // Limpa o arquivo para saber se há mais alterações para efetuar no banco de dados
      objContratoTemplate.Arquivo := '';
      objContratoTemplate.TipoArquivo := '';

      // Se os objetos forem diferentes, realiza a alteração
      if TContratoTemplateVO(objContratoTemplate).ToJSONString <> TContratoTemplateVO(objContratoTemplateOld).ToJSONString then
        Resultado := TT2TiORM.Alterar(objContratoTemplate, objContratoTemplateOld);
    except
      on E: Exception do
      begin
        Result.AddElement(TJSOnString.Create('ERRO'));
        Result.AddElement(TJSOnString.Create(E.Message));
      end;
    end;
  finally
    if Resultado then
    begin
      Result.AddElement(TJSONTrue.Create);
    end;
    objContratoTemplate.Free;
  end;
end;

function TContratoTemplateController.CancelContratoTemplate(pSessao: String; pId: Integer): TJSONArray;
begin
  objContratoTemplate := TContratoTemplateVO.Create;
  Result := TJSONArray.Create;
  try
    objContratoTemplate.Id := pId;
    try
      Resultado := TT2TiORM.Excluir(objContratoTemplate);

      if FileExists(gsAppPath + 'Arquivos\Contratos\Templates\' + IntToStr(pId) + '.doc') then
        DeleteFile(gsAppPath + 'Arquivos\Contratos\Templates\' + IntToStr(pId) + '.doc');

    except
      on E: Exception do
      begin
        Result.AddElement(TJSOnString.Create('ERRO'));
        Result.AddElement(TJSOnString.Create(E.Message));
      end;
    end;
  finally
    if Resultado then
    begin
      Result.AddElement(TJSONTrue.Create);
    end;
    objContratoTemplate.Free;
  end;
end;

function TContratoTemplateController.ArmazenarArquivo: Boolean;
var
  ArrayStringsArquivo: TStringList;
  ArquivoBytes: TBytes;
  ArquivoStream: TStringStream;
  i: Integer;
begin
  try
    Result := False;

    ArrayStringsArquivo := TStringList.Create;
    Split(',', objContratoTemplate.Arquivo, ArrayStringsArquivo);
    SetLength(ArquivoBytes, ArrayStringsArquivo.Count);
    for i := 0 to ArrayStringsArquivo.Count - 1 do
    begin
      ArquivoBytes[i] := StrToInt(ArrayStringsArquivo[i]);
    end;
    ArquivoStream := TStringStream.Create(ArquivoBytes);
    if not DirectoryExists(gsAppPath + 'Arquivos')then
      CreateDir(gsAppPath + 'Arquivos');
    if not DirectoryExists(gsAppPath + 'Arquivos\Contratos')then
      CreateDir(gsAppPath + 'Arquivos\Contratos');
    if not DirectoryExists(gsAppPath + 'Arquivos\Contratos\Templates')then
      CreateDir(gsAppPath + 'Arquivos\Contratos\Templates');
    ArquivoStream.SaveToFile(gsAppPath + 'Arquivos\Contratos\Templates\' + IntToStr(objContratoTemplate.Id) + objContratoTemplate.TipoArquivo);

    Result := True;
  finally
    ArrayStringsArquivo.Free;
    ArquivoStream.Free;
  end;
end;

end.
