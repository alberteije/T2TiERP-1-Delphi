{*******************************************************************************
Title: T2Ti ERP
Description: Unit de controle Base - Cliente.

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

@author Fábio Thomaz
@version 1.0
*******************************************************************************}
unit Controller;

interface

uses
  Classes, SessaoUsuario, SysUtils, Forms, Windows, DB, DBClient,
  Rtti, Atributos;

type
  TController = class
  private
    class function UrlFormatada(pClassCtx, pMethodCtx: string): string;
  public
    class function Delete(pClassCtx, pMethodCtx, pParametros: string): string; overload;
    class function Delete(pMethodCtx, pParametros: string): string; overload;
    class function Delete(pParametros: string): string; overload;

    class procedure Get(pClassCtx, pMethodCtx, pParametros: string;
      pStreamResposta: TStringStream); overload;
    class procedure Get(pMethodCtx, pParametros: string;
      pStreamResposta: TStringStream); overload;
    class procedure Get(pParametros: string;
      pStreamResposta: TStringStream); overload;

    class procedure Post(pClassCtx, pMethodCtx, pParametros: string;
      pDataStream, pStreamResposta: TStringStream); overload;
    class procedure Post(pMethodCtx, pParametros: string;
      pDataStream, pStreamResposta: TStringStream); overload;
    class procedure Post(pParametros: string; pDataStream,
      pStreamResposta: TStringStream); overload;

    class procedure Put(pClassCtx, pMethodCtx, pParametros: string;
      pDataStream, pStreamResposta: TStringStream); overload;
    class procedure Put(pMethodCtx, pParametros: string;
      pDataStream, pStreamResposta: TStringStream); overload;
    class procedure Put(pParametros: string; pDataStream,
      pStreamResposta: TStringStream); overload;

    class function GetDataSet: TClientDataSet; virtual;
    class procedure SetDataSet(pDataSet: TClientDataSet); virtual;

    class function VO<O: class>(pId: Integer): O;
  protected
    class function Sessao: TSessaoUsuario;

    class function MethodCtx: string; virtual;
    class procedure PopulaGrid<O: class>(pStreamResposta: TStringStream);
  end;

implementation

{ TController }

{$REGION 'Excluir'}
class function TController.Delete(pClassCtx, pMethodCtx, pParametros: string): string;
var
  Url: string;
begin
  Url := UrlFormatada(pClassCtx,pMethodCtx)+pParametros;
  Result := '';//Sessao.HTTP.Delete(Url);
end;

class function TController.Delete(pMethodCtx, pParametros: string): string;
begin
  Result := Delete(Self.ClassName,pMethodCtx,pParametros);
end;

class function TController.Delete(pParametros: string): string;
begin
  Result := Delete(MethodCtx,pParametros);
end;
{$ENDREGION}

{$REGION 'Consultar'}
class procedure TController.Get(pClassCtx, pMethodCtx, pParametros: string;
  pStreamResposta: TStringStream);
var
  Url: string;
begin
  Url := UrlFormatada(pClassCtx,pMethodCtx)+pParametros;
  try
   // Sessao.HTTP.Get(Url,pStreamResposta);
  except
    on E: Exception do
    begin
      Application.MessageBox(PWideChar(E.Message),'Erro do Sistema',MB_OK+MB_ICONERROR)
    end;
  end;
end;

class procedure TController.Get(pMethodCtx, pParametros: string;
  pStreamResposta: TStringStream);
begin
  Get(Self.ClassName,pMethodCtx,pParametros,pStreamResposta);
end;

class procedure TController.Get(pParametros: string;
  pStreamResposta: TStringStream);
begin
  Get(MethodCtx,pParametros,pStreamResposta);
end;
{$ENDREGION}

{$REGION 'Alterar'}
class procedure TController.Post(pClassCtx, pMethodCtx, pParametros: string;
  pDataStream, pStreamResposta: TStringStream);
var
  Url: string;
begin
  Url := UrlFormatada(pClassCtx,pMethodCtx)+pParametros;
//  Sessao.HTTP.Post(Url,pDataStream,pStreamResposta);
end;

class procedure TController.Post(pMethodCtx, pParametros: string; pDataStream,
  pStreamResposta: TStringStream);
begin
  Post(Self.ClassName,pMethodCtx,pParametros,pDataStream,pStreamResposta);
end;

class procedure TController.Post(pParametros: string; pDataStream,
  pStreamResposta: TStringStream);
begin
  Post(MethodCtx,pParametros,pDataStream,pStreamResposta);
end;
{$ENDREGION}

{$REGION 'Inserir'}
class procedure TController.Put(pClassCtx, pMethodCtx, pParametros: string;
  pDataStream, pStreamResposta: TStringStream);
var
  Url: string;
begin
  Url := UrlFormatada(pClassCtx,pMethodCtx)+pParametros;
  //Sessao.HTTP.Put(Url,pDataStream,pStreamResposta);
end;

class procedure TController.Put(pMethodCtx, pParametros: string; pDataStream,
  pStreamResposta: TStringStream);
begin
  Put(Self.ClassName,pMethodCtx,pParametros,pDataStream,pStreamResposta);
end;

class procedure TController.Put(pParametros: string; pDataStream,
  pStreamResposta: TStringStream);
begin
  Put(MethodCtx,pParametros,pDataStream,pStreamResposta);
end;
{$ENDREGION}


class function TController.GetDataSet: TClientDataSet;
begin
  Result := nil;
  //Implementar nas classes filhas
end;

class function TController.Sessao: TSessaoUsuario;
begin
  Result := TSessaoUsuario.Instance;
end;

class procedure TController.SetDataSet(pDataSet: TClientDataSet);
begin
  //
end;

class function TController.UrlFormatada(pClassCtx, pMethodCtx: string): string;
begin
  if Sessao.IdSessao = '' then
    raise Exception.Create('Sessão não criada!');

  Result := ''; //Sessao.URL+pClassCtx+'/'+pMethodCtx+'/'+Sessao.IdSessao+'/';
end;

class function TController.MethodCtx: string;
begin
  //Implementar nos controllers filhos
end;

class procedure TController.PopulaGrid<O>(pStreamResposta: TStringStream);
var
  I: Integer;
  ObjetoVO: O;
  InstanciaObj: TObject;
  Contexto: TRttiContext;
  Tipo: TRttiType;
  Propriedade: TRttiProperty;
  Atributo: TCustomAttribute;
  DataSetField: TField;
  DataSet: TClientDataSet;
begin
  DataSet := GetDataSet;

  if not Assigned(DataSet) then
     Exit;

  DataSet.DisableControls;
  DataSet.EmptyDataSet;

  try
    Contexto := TRttiContext.Create;
    Tipo := Contexto.GetType(TClass(O));

   { for I := 0 to jItems.Size - 1 do
    begin
      jItem := jItems.Get(I);
      ObjetoVO := TJSonVO.JSONToObject<O>(jItem);
      InstanciaObj := ObjetoVO;

      DataSet.Append;

      for Propriedade in Tipo.GetProperties do
      begin
        for Atributo in Propriedade.GetAttributes do
        begin
          if Atributo is TColumn then
          begin
            DataSetField := DataSet.FindField((Atributo as TColumn).Name);
            if Assigned(DataSetField) then
            begin
              DataSetField.Value := Propriedade.GetValue(InstanciaObj).AsVariant;
            end;
          end
          else
          if Atributo is TId then
          begin
            DataSetField := DataSet.FindField((Atributo as TId).NameField);
            if Assigned(DataSetField) then
            begin
              DataSetField.Value := Propriedade.GetValue(InstanciaObj).AsVariant;
            end;
          end;
        end;
      end;
            }
      DataSet.Post;

  finally

  end;

  DataSet.Open;
  DataSet.First;
  DataSet.EnableControls;
end;

class function TController.VO<O>(pId: Integer): O;
var
  StreamResposta: TStringStream;

begin
  Result := nil;
  try
    StreamResposta := TStringStream.Create;
    try
      Get(MethodCtx, 'ID='+IntToStr(pId) + '/0', StreamResposta);


    except
      Application.MessageBox('Ocorreu um erro na consulta aos dados.', 'Erro do sistema', MB_OK + MB_ICONERROR);
    end;
  finally
    StreamResposta.Free;
  end;
end;

end.
