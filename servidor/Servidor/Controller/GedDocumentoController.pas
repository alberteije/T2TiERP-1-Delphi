{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: Controller do lado Servidor relacionado à tabela [GED_DOCUMENTO] 
                                                                                
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
                                                                                
fernandololiver@gmail.com
@author @author Fernando L Oliveira
@version 1.0                                                                    
*******************************************************************************}
unit GedDocumentoController;

interface

uses
  Classes, SQLExpr, SysUtils, Generics.Collections, Controller, DBXJSON, DBXCommon;

type
  TGedDocumentoController = class(TController)
  private
    function ArmazenarArquivo(pSessao: String; pArrayArquivos: TJSONValue; pOperacao: String): Boolean;
  protected
  public
    // consultar
    function GedDocumento(pSessao: String; pFiltro: String; pPagina: Integer): TJSONArray;
    // inserir
    function AcceptGedDocumento(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    function AcceptGedDocumentoComArquivo(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    // alterar
    function UpdateGedDocumento(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    function UpdateGedDocumentoComArquivo(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    // excluir
    function CancelGedDocumento(pSessao: String; pId: Integer): TJSONArray;
  end;

implementation

uses
  GedDocumentoVO, GedVersaoDocumentoVO, Biblioteca, T2TiORM, SA;

{ TGedDocumentoController }

var
  objGedDocumento: TGedDocumentoVO;
  Resultado: Boolean;

function TGedDocumentoController.GedDocumento(pSessao, pFiltro: String; pPagina: Integer): TJSONArray;
begin
  pFiltro := pFiltro + ' AND ID_EMPRESA = ' + IntToStr(Sessao(pSessao).IdEmpresa);
  Result := TJSONArray.Create;
  try
    if Pos('ID=', pFiltro) > 0 then
      Result := TT2TiORM.Consultar<TGedDocumentoVO>(pFiltro, pPagina, True)
    else
    begin
      pFiltro := pFiltro + ' and DATA_EXCLUSAO is null';
      Result := TT2TiORM.Consultar<TGedDocumentoVO>(pFiltro, pPagina, False);
    end;
  except
    on E: Exception do
    begin
      Result.AddElement(TJSOnString.Create('ERRO'));
      Result.AddElement(TJSOnString.Create(E.Message));
    end;
  end;

  FSA.MemoResposta.Lines.Clear;
  FSA.MemoResposta.Lines.Add(Result.ToString);
end;

function TGedDocumentoController.AcceptGedDocumento(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  UltimoID: Integer;
begin
  objGedDocumento := TGedDocumentoVO.Create(pObjeto);
  Result := TJSONArray.Create;
  try
    try
      UltimoID := TT2TiORM.Inserir(objGedDocumento);
      Result := GedDocumento(pSessao, 'ID = ' + IntToStr(UltimoID), 0);
    except
      on E: Exception do
      begin
        Result.AddElement(TJSOnString.Create('ERRO'));
        Result.AddElement(TJSOnString.Create(E.Message));
      end;
    end;
  finally
    objGedDocumento.Free;
  end;
end;

function TGedDocumentoController.AcceptGedDocumentoComArquivo(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  UltimoID: Integer;
begin
  try
    try
      //pega o objeto Documento
      objGedDocumento := TGedDocumentoVO.Create((pObjeto as TJSONArray).Get(0));
      UltimoID := TT2TiORM.Inserir(objGedDocumento);
      objGedDocumento.Id := UltimoID;

      // Armazena o arquivo
      Resultado := ArmazenarArquivo(pSessao, (pObjeto as TJSONArray).Get(1), 'I');

      result := GedDocumento(pSessao,'ID='+IntToStr(UltimoID),0);
    except
      result := TJSONArray.Create;
    end;
  finally
    objGedDocumento.Free;
  end;
end;

function TGedDocumentoController.UpdateGedDocumento(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  objGedDocumentoOld: TGedDocumentoVO;
begin
  // Objeto Novo
  objGedDocumento := TGedDocumentoVO.Create((pObjeto as TJSONArray).Get(0));
  // Objeto Antigo
  objGedDocumentoOld := TGedDocumentoVO.Create((pObjeto as TJSONArray).Get(1));
  Result := TJSONArray.Create;
  try
    // Verifica se houve alterações no objeto principal
    if objGedDocumento.MainObject.ToJSONString <> objGedDocumentoOld.MainObject.ToJSONString then
    begin
    try
      Resultado := TT2TiORM.Alterar(objGedDocumento, objGedDocumentoOld);
    except
      on E: Exception do
      begin
        Result.AddElement(TJSOnString.Create('ERRO'));
        Result.AddElement(TJSOnString.Create(E.Message));
      end;
     end;
    end;
  finally
    if Resultado then
    begin
      Result.AddElement(TJSONTrue.Create);
    end;
    objGedDocumento.Free;
  end;
end;

function TGedDocumentoController.UpdateGedDocumentoComArquivo(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  objGedDocumentoOld: TGedDocumentoVO;
begin
  Result := TJSONArray.Create;
  try
    try
      // Objeto Novo
      objGedDocumento := TGedDocumentoVO.Create((pObjeto as TJSONArray).Get(0));
      // Objeto Antigo
      objGedDocumentoOld := TGedDocumentoVO.Create((pObjeto as TJSONArray).Get(1));

      // Verifica se houve alterações no objeto principal
      if objGedDocumento.MainObject.ToJSONString <> objGedDocumentoOld.MainObject.ToJSONString then
      begin
        Resultado := TT2TiORM.Alterar(objGedDocumento, objGedDocumentoOld);
      end;

      // Armazena o arquivo
      Resultado := ArmazenarArquivo(pSessao, (pObjeto as TJSONArray).Get(2), 'A');
    except
      result := TJSONArray.Create;
    end;
  finally
    if Resultado then
    begin
      Result.AddElement(TJSONTrue.Create);
    end;
    objGedDocumento.Free;
    objGedDocumentoOld.Free;
  end;
end;

//apenas o administrador do sistema conseguirá reverter a exclusão de um documento do GED
function TGedDocumentoController.CancelGedDocumento(pSessao: String; pId: Integer): TJSONArray;
var
  objGedDocumentoOld: TGedDocumentoVO;
  VersaoDocumento: TGedVersaoDocumentoVO;
  UltimoIdVersao: Integer;
begin
  objGedDocumento := TGedDocumentoVO.Create;
  objGedDocumentoOld := TGedDocumentoVO.Create;
  Result := TJSONArray.Create;
  try
    objGedDocumento.Id := pId;
    objGedDocumentoOld.Id := pId;
    objGedDocumento.DataExclusao := Now;
    try
      //manda os dois objetos para o ORM montar uma consulta dinâmica apenas com o campo alterado
      Resultado := TT2TiORM.Alterar(objGedDocumento, objGedDocumentoOld);

      //devemos inserir um registro de versionamento informando a exclusão do documento
      UltimoIdVersao := TT2TiORM.SelectMax('GED_VERSAO_DOCUMENTO', 'ID_GED_DOCUMENTO=' + QuotedStr(IntToStr(pId)));
      VersaoDocumento := TGedVersaoDocumentoVO.Create(((TT2TiORM.Consultar<TGedVersaoDocumentoVO>('ID=' + QuotedStr(IntToStr(UltimoIdVersao)), 0, False)) as TJSONArray).Get(0));
      VersaoDocumento.IdColaborador := Sessao(pSessao).Usuario.Id;
      VersaoDocumento.IdGedDocumento := pId;
      VersaoDocumento.Versao := VersaoDocumento.Versao + 1;
      VersaoDocumento.DataHora := Now;
      VersaoDocumento.Acao := 'E';
      TT2TiORM.Inserir(VersaoDocumento);
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
    objGedDocumento.Free;
    objGedDocumentoOld.Free;
  end;
end;

function TGedDocumentoController.ArmazenarArquivo(pSessao: String; pArrayArquivos: TJSONValue; pOperacao: String): Boolean;
var
  TipoArquivo, ArquivoString, AssinaturaString, MD5: String;
  I, TamanhoArquivo, TamanhoAssinatura, UltimoIdVersao: Integer;
  ArrayStringsArquivo, ArrayStringsAssinatura: TStringList;
  ArquivoBytes, AssinaturaBytes: Tbytes;
  ArquivoStream, AssinaturaStream: TStringStream;
  VersaoDocumento: TGedVersaoDocumentoVO;
begin
  if not DirectoryExists(CaminhoApp + 'Arquivos\GED\') then
    ForceDirectories(CaminhoApp + 'Arquivos\GED\');

  ArrayStringsArquivo := nil;
  ArrayStringsAssinatura := nil;
  ArquivoStream := nil;
  AssinaturaStream := nil;

  try
    try
      //na posicao cinco temos o MD5 do arquivo enviado
      MD5 := (pArrayArquivos as TJSONArray).Get(5).ToString;
      //retira as aspas do JSON
      Delete(MD5, Length(MD5), 1);
      Delete(MD5, 1, 1);

      //na posicao zero temos o arquivo de assinatura
      AssinaturaString := (pArrayArquivos as TJSONArray).Get(0).ToString;
      //retira as aspas do JSON
      Delete(AssinaturaString, Length(AssinaturaString), 1);
      Delete(AssinaturaString, 1, 1);

      //na posicao um temos o tamanho do arquivo de assinatura
      TamanhoAssinatura := StrToInt((pArrayArquivos as TJSONArray).Get(1).ToString);

      if TamanhoAssinatura > 0 then
      begin
        //salva o arquivo de assinatura em disco
        ArrayStringsAssinatura := TStringList.Create;
        Split(',',AssinaturaString, ArrayStringsAssinatura);

        SetLength(AssinaturaBytes, TamanhoAssinatura);

        for I := 0 to TamanhoAssinatura - 1 do
        begin
          AssinaturaBytes[i] := StrToInt(ArrayStringsAssinatura[i]);
        end;
        AssinaturaStream := TStringStream.Create(AssinaturaBytes);
        AssinaturaStream.SaveToFile(CaminhoApp + 'Arquivos\GED\' + MD5 + '.assinatura');
      end;

      //na posicao dois temos o arquivo enviado
      ArquivoString := (pArrayArquivos as TJSONArray).Get(2).ToString;
      //retira as aspas do JSON
      Delete(ArquivoString, Length(ArquivoString), 1);
      Delete(ArquivoString, 1, 1);

      //na posicao tres temos o tamanho do arquivo enviado
      TamanhoArquivo := StrToInt((pArrayArquivos as TJSONArray).Get(3).ToString);

      //na posicao quatro temos o tipo de arquivo enviado
      TipoArquivo := (pArrayArquivos as TJSONArray).Get(4).ToString;
      //retira as aspas do JSON
      Delete(TipoArquivo, Length(TipoArquivo), 1);
      Delete(TipoArquivo, 1, 1);

      //salva o arquivo enviado em disco
      ArrayStringsArquivo := TStringList.Create;
      Split(',',ArquivoString, ArrayStringsArquivo);

      SetLength(ArquivoBytes, TamanhoArquivo);

      for I := 0 to TamanhoArquivo - 1 do
      begin
        ArquivoBytes[i] := StrToInt(ArrayStringsArquivo[i]);
      end;
      ArquivoStream := TStringStream.Create(ArquivoBytes);
      ArquivoStream.SaveToFile(CaminhoApp + 'Arquivos\GED\' + MD5 + tipoarquivo);

      //devemos inserir um registro de versionamento informando a inclusão/alteração do documento
      if pOperacao = 'I' then
      begin
        VersaoDocumento := TGedVersaoDocumentoVO.Create;
        VersaoDocumento.Versao := 1;
        VersaoDocumento.Acao := 'I';
      end
      else if pOperacao = 'A' then
      begin
        UltimoIdVersao := TT2TiORM.SelectMax('GED_VERSAO_DOCUMENTO', 'ID_GED_DOCUMENTO=' + QuotedStr(IntToStr(objGedDocumento.Id)));
        VersaoDocumento := TGedVersaoDocumentoVO.Create(((TT2TiORM.Consultar<TGedVersaoDocumentoVO>('ID=' + QuotedStr(IntToStr(UltimoIdVersao)), 0, False)) as TJSONArray).Get(0));
        VersaoDocumento.Versao := VersaoDocumento.Versao + 1;
        VersaoDocumento.Acao := 'A';
      end;

      VersaoDocumento.IdColaborador := Sessao(pSessao).Usuario.Id;
      VersaoDocumento.IdGedDocumento := objGedDocumento.Id;
      VersaoDocumento.DataHora := Now;
      VersaoDocumento.HashArquivo := MD5;
      VersaoDocumento.Caminho := CaminhoApp + 'Arquivos\GED\' + MD5 + tipoarquivo;
      VersaoDocumento.Caminho := StringReplace(VersaoDocumento.Caminho,'\','/',[rfReplaceAll]);

      TT2TiORM.Inserir(VersaoDocumento);

      Result := True;
    except
      Result := False;
    end;
  finally
    ArrayStringsArquivo.Free;
    ArrayStringsAssinatura.Free;
    ArquivoStream.Free;
    AssinaturaStream.Free;
  end;
end;

end.
