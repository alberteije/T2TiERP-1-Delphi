{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: Controller do lado Servidor relacionado à tabela [CONTRATO] 
                                                                                
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
unit ContratoController;

interface

uses
  Classes, SQLExpr, SysUtils, Generics.Collections, Controller, DBXJSON, DBXCommon,
  Biblioteca, SWSystem;

type
  TContratoController = class(TController)
  private
    function ArmazenarArquivo: Boolean;
  protected
  public
    //consultar
    function Contrato(pSessao: String; pFiltro: String; pPagina: Integer): TJSONArray;
    //inserir
    function AcceptContrato(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //alterar
    function UpdateContrato(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //excluir
    function CancelContrato(pSessao: String; pId: Integer): TJSONArray;
  end;

implementation

uses
  ContratoVO, ContratoHistFaturamentoVO, ContratoHistoricoReajusteVO,
  ContratoPrevFaturamentoVO, T2TiORM, SA;

{ TContratoController }

var
  objContrato: TContratoVO;
  Resultado: Boolean;

function TContratoController.Contrato(pSessao, pFiltro: String; pPagina: Integer): TJSONArray;
begin
  Result := TJSONArray.Create;
  try
    if Pos('ID=', pFiltro) > 0 then
      Result := TT2TiORM.Consultar<TContratoVO>(pFiltro, pPagina, True)
    else
      Result := TT2TiORM.Consultar<TContratoVO>(pFiltro, pPagina, False);
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

function TContratoController.AcceptContrato(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  UltimoID:Integer;
  HistoricoFaturamento: TContratoHistFaturamentoVO;
  HistoricoReajuste: TContratoHistoricoReajusteVO;
  PrevisaoFaturamento: TContratoPrevFaturamentoVO;
  HistoricoFaturamentoEnumerator: TEnumerator<TContratoHistFaturamentoVO>;
  HistoricoReajusteEnumerator: TEnumerator<TContratoHistoricoReajusteVO>;
  PrevisaoFaturamentoEnumerator: TEnumerator<TContratoPrevFaturamentoVO>;
begin
  objContrato := TContratoVO.Create(pObjeto);
  Result := TJSONArray.Create;
  try
    try
      UltimoID := TT2TiORM.Inserir(objContrato);

      // Histórico Faturamento
      HistoricoFaturamentoEnumerator := objContrato.ListaContratoHistFaturamentoVO.GetEnumerator;
      try
        with HistoricoFaturamentoEnumerator do
        begin
          while MoveNext do
          begin
            HistoricoFaturamento := Current;
            HistoricoFaturamento.IdContrato := UltimoID;
            TT2TiORM.Inserir(HistoricoFaturamento);
          end;
        end;
      finally
        HistoricoFaturamentoEnumerator.Free;
      end;

      // Histórico Reajuste
      HistoricoReajusteEnumerator := objContrato.ListaContratoHistoricoReajusteVO.GetEnumerator;
      try
        with HistoricoReajusteEnumerator do
        begin
          while MoveNext do
          begin
            HistoricoReajuste := Current;
            HistoricoReajuste.IdContrato := UltimoID;
            TT2TiORM.Inserir(HistoricoReajuste);
          end;
        end;
      finally
        HistoricoReajusteEnumerator.Free;
      end;

      // Previsão Faturamento
      PrevisaoFaturamentoEnumerator := objContrato.ListaContratoPrevFaturamentoVO.GetEnumerator;
      try
        with PrevisaoFaturamentoEnumerator do
        begin
          while MoveNext do
          begin
            PrevisaoFaturamento := Current;
            PrevisaoFaturamento.IdContrato := UltimoID;
            TT2TiORM.Inserir(PrevisaoFaturamento);
          end;
        end;
      finally
        PrevisaoFaturamentoEnumerator.Free;
      end;

      // Se subiu um documento, armazena
      if objContrato.Arquivo <> '' then
      begin
        objContrato.Id := UltimoID;
        ArmazenarArquivo;
      end;

    except
      on E: Exception do
      begin
        Result.AddElement(TJSOnString.Create('ERRO'));
        Result.AddElement(TJSOnString.Create(E.Message));
      end;
    end;
  finally
    objContrato.Free;
  end;
  Result := Contrato(pSessao, 'ID = ' + IntToStr(UltimoID), 0);
end;

function TContratoController.UpdateContrato(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  HistoricoFaturamentoEnumerator: TEnumerator<TContratoHistFaturamentoVO>;
  HistoricoReajusteEnumerator: TEnumerator<TContratoHistoricoReajusteVO>;
  PrevisaoFaturamentoEnumerator: TEnumerator<TContratoPrevFaturamentoVO>;
  objContratoOld: TContratoVO;
begin
 //Objeto Novo
  objContrato := TContratoVO.Create((pObjeto as TJSONArray).Get(0));
  //Objeto Antigo
  objContratoOld := TContratoVO.Create((pObjeto as TJSONArray).Get(1));

  Result := TJSONArray.Create;
  try
    try
      // Se subiu um documento, armazena
      if objContrato.Arquivo <> '' then
        Resultado := ArmazenarArquivo;

      // Limpa o arquivo para saber se há mais alterações para efetuar no banco de dados
      objContrato.Arquivo := '';
      objContrato.TipoArquivo := '';

      // Se os objetos forem diferentes, realiza a alteração
      if TContratoVO(objContrato).ToJSONString <> TContratoVO(objContratoOld).ToJSONString then
        Resultado := TT2TiORM.Alterar(objContrato, objContratoOld);
    except
      on E: Exception do
      begin
        Result.AddElement(TJSOnString.Create('ERRO'));
        Result.AddElement(TJSOnString.Create(E.Message));
      end;
    end;

    // Histórico Faturamento
    try
      HistoricoFaturamentoEnumerator := objContrato.ListaContratoHistFaturamentoVO.GetEnumerator;
      with HistoricoFaturamentoEnumerator do
      begin
        while MoveNext do
        begin
          if Current.Id > 0 then
            Resultado := TT2TiORM.Alterar(Current)
          else
            Resultado := TT2TiORM.Inserir(Current) > 0;
        end;
      end;
    except
      on E: Exception do
      begin
        Result.AddElement(TJSOnString.Create('ERRO'));
        Result.AddElement(TJSOnString.Create(E.Message));
      end;
    end;

    // Histórico Reajuste
    try
      HistoricoReajusteEnumerator := objContrato.ListaContratoHistoricoReajusteVO.GetEnumerator;
      with HistoricoReajusteEnumerator do
      begin
        while MoveNext do
        begin
          if Current.Id > 0 then
            Resultado := TT2TiORM.Alterar(Current)
          else
            Resultado := TT2TiORM.Inserir(Current) > 0;
        end;
      end;
    except
      on E: Exception do
      begin
        Result.AddElement(TJSOnString.Create('ERRO'));
        Result.AddElement(TJSOnString.Create(E.Message));
      end;
    end;

    // Previsão Faturamento
    try
      PrevisaoFaturamentoEnumerator := objContrato.ListaContratoPrevFaturamentoVO.GetEnumerator;
      with PrevisaoFaturamentoEnumerator do
      begin
        while MoveNext do
        begin
          if Current.Id > 0 then
            Resultado := TT2TiORM.Alterar(Current)
          else
            Resultado := TT2TiORM.Inserir(Current) > 0;
        end;
      end;
    except
      on E: Exception do
      begin
        Result.AddElement(TJSOnString.Create('ERRO'));
        Result.AddElement(TJSOnString.Create(E.Message));
      end;
    end;

  finally
    HistoricoFaturamentoEnumerator.Free;
    HistoricoReajusteEnumerator.Free;
    PrevisaoFaturamentoEnumerator.Free;
    objContrato.Free;
    //
    if Resultado then
    begin
      Result.AddElement(TJSONTrue.Create);
    end;
  end;
end;

function TContratoController.CancelContrato(pSessao: String; pId: Integer): TJSONArray;
begin
  objContrato := TContratoVO.Create;
  Result := TJSONArray.Create;
  try
    objContrato.Id := pId;
    try
      Resultado := TT2TiORM.Excluir(objContrato);

      if FileExists(gsAppPath + 'Arquivos\Contratos\' + IntToStr(pId) + '.doc') then
        DeleteFile(gsAppPath + 'Arquivos\Contratos\' + IntToStr(pId) + '.doc');

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
    objContrato.Free;
  end;
end;

function TContratoController.ArmazenarArquivo: Boolean;
var
  ArrayStringsArquivo: TStringList;
  ArquivoBytes: TBytes;
  ArquivoStream: TStringStream;
  i: Integer;
begin
  try
    Result := False;

    ArrayStringsArquivo := TStringList.Create;
    Split(',', objContrato.Arquivo, ArrayStringsArquivo);
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
    ArquivoStream.SaveToFile(gsAppPath + 'Arquivos\Contratos\' + IntToStr(objContrato.Id) + objContrato.TipoArquivo);

    Result := True;
  finally
    ArrayStringsArquivo.Free;
    ArquivoStream.Free;
  end;
end;

end.
