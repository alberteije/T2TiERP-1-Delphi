{ *******************************************************************************
  Title: T2Ti ERP
  Description: Controller do lado Servidor relacionado à tabela [Funcao]

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

  t2ti.com@gmail.com
  @author Fábio Thomaz (fabio_thz@yahoo.com.br) | Albert Eije (T2Ti.COM)
  @version 1.0
  ******************************************************************************* }
unit ListaFuncaoController;

interface

uses
  Classes, SQLExpr, SysUtils, Generics.Collections, Controller, DBXJSON,
  DBXCommon, FuncaoVO, PapelVO, PapelFuncaoVO, AdministrativoFormularioVO;

type
  TListaFuncaoController = class(TController)
  protected
    procedure VincularFuncoesAosPapeis;
  public
    function ListaFuncao(pSessao: String): TJSONArray;
    function ListaFuncaoComAcesso(pSessao: String): TJSONArray;
    function UpdateListaFuncao(pSessao: String; pFormularios: TJSONValue): TJSONArray;
  end;

implementation

uses
  T2TiORM, SA;

{ TFuncaoController }

var
  objFormulario: TAdministrativoFormularioVO;
  objFuncao: TFuncaoVO;

function TListaFuncaoController.ListaFuncao(pSessao: String): TJSONArray;
var
  SQL: String;
  IdUsuario: Integer;
begin
  IdUsuario := Sessao(pSessao).Usuario.Id;

  SQL := 'SELECT DISTINCT F.ID, F.FORMULARIO, F.NOME, PF.HABILITADO ' +
         'FROM USUARIO U ' +
         'INNER JOIN PAPEL P ON (P.ID = U.ID_PAPEL) ' +
         'INNER JOIN PAPEL_FUNCAO PF ON (PF.ID_PAPEL = P.ID) ' +
         'INNER JOIN FUNCAO F ON (F.ID = PF.ID_FUNCAO) ';

  Result := TT2TiORM.Consultar<TFuncaoVO>(SQL, 'U.ID = ' + IntToStr(IdUsuario), -1);

  FSA.MemoResposta.Lines.Clear;
  FSA.MemoResposta.Lines.Add(Result.ToString);
end;

function TListaFuncaoController.ListaFuncaoComAcesso(pSessao: String): TJSONArray;
var
  SQL: String;
  IdUsuario: Integer;
begin
  IdUsuario := Sessao(pSessao).Usuario.Id;

  SQL := 'SELECT DISTINCT F.ID, F.FORMULARIO, F.NOME, PF.HABILITADO ' +
         'FROM USUARIO U ' +
         'INNER JOIN PAPEL P ON (P.ID = U.ID_PAPEL) ' +
         'INNER JOIN PAPEL_FUNCAO PF ON (PF.ID_PAPEL = P.ID) ' +
         'INNER JOIN FUNCAO F ON (F.ID = PF.ID_FUNCAO) ';

  Result := TT2TiORM.Consultar<TFuncaoVO>(SQL, 'PF.HABILITADO = ' + QuotedStr('S') + ' AND U.ID = ' + IntToStr(IdUsuario), -1);

  FSA.MemoResposta.Lines.Clear;
  FSA.MemoResposta.Lines.Add(Result.ToString);
end;

function TListaFuncaoController.UpdateListaFuncao(pSessao: String; pFormularios: TJSONValue): TJSONArray;
var
  i, j: Integer;
  Filtro: String;
  ListaFuncoes: TObjectList<TFuncaoVO>;
begin
  Result := TJSONArray.Create;

  try
    try
      for i := 0 to (pFormularios as TJSONArray).Size - 1 do
      begin
        objFormulario := TAdministrativoFormularioVO.Create((pFormularios as TJSONArray).Get(i));
        for j := 0 to objFormulario.ListaFuncaoVO.Count - 1 do
        begin
          Filtro := 'NOME = ' +  QuotedStr(objFormulario.ListaFuncaoVO[j].Nome) + ' AND FORMULARIO = ' + QuotedStr(objFormulario.NomeFormulario);

          ListaFuncoes := TT2TiORM.Consultar<TFuncaoVO>(Filtro, False, -1);
          try
            if ListaFuncoes.Count = 0 then
            begin
              objFuncao := objFormulario.ListaFuncaoVO[j];
              TT2TiORM.Inserir(objFuncao);
            end;
          finally
            ListaFuncoes.Free;
          end;
        end;
      end;

      Result.AddElement(TJSOnString.Create('OK'));
    except
      on E: Exception do
      begin
        Result.AddElement(TJSOnString.Create('ERRO'));
        Result.AddElement(TJSOnString.Create(E.Message));
      end;
    end;
  finally
    objFormulario.Free;
  end;

  VincularFuncoesAosPapeis;
end;

procedure TListaFuncaoController.VincularFuncoesAosPapeis;
var
  IdPapel: Integer;
  IdFuncao: Integer;
  ListaPapel: TObjectList<TPapelVO>;
  ListaFuncao: TObjectList<TFuncaoVO>;
  ListaPapelFuncao: TObjectList<TPapelFuncaoVO>;
  EnumeratorPapel: TEnumerator<TPapelVO>;
  EnumeratorFuncao: TEnumerator<TFuncaoVO>;
  PapelFuncao: TPapelFuncaoVO;
begin
  // Lista todos os Papeis
  ListaPapel := TT2TiORM.Consultar<TPapelVO>('', False);
  try
    ListaFuncao := TT2TiORM.Consultar<TFuncaoVO>('', False, -1);
    try
      // Percorre lista de Papeis
      EnumeratorPapel := ListaPapel.GetEnumerator;
      try
        with EnumeratorPapel do
        begin
          while MoveNext do
          begin
            if Current.AcessoCompleto <> 'S' then
            begin
              // Armazena o ID do Papel
              IdPapel := Current.Id;

              // Percorre funções para verificar e existe alguma sem vinculo
              EnumeratorFuncao := ListaFuncao.GetEnumerator;
              try
                with EnumeratorFuncao do
                begin
                  while MoveNext do
                  begin
                    // Armazena o ID da função
                    IdFuncao := Current.Id;

                    // Lista Funcoes e Papeis Vinculados
                    ListaPapelFuncao := TT2TiORM.Consultar<TPapelFuncaoVO>('ID_PAPEL = ' + IntToStr(IdPapel) + ' AND ID_FUNCAO = ' + IntToStr(IdFuncao), False);
                    try
                      // Se a função não estiver vinculada, vincula...
                      if ListaPapelFuncao.Count = 0 then
                      begin
                        PapelFuncao := TPapelFuncaoVO.Create;
                        try
                          PapelFuncao.IdPapel := IdPapel;
                          PapelFuncao.IdFuncao := IdFuncao;
                          PapelFuncao.Habilitado := 'N';
                          TT2TiORM.Inserir(PapelFuncao);
                        finally
                          PapelFuncao.Free;
                        end;
                      end;
                    finally
                      ListaPapelFuncao.Free;
                    end;
                  end;
                end;
              finally
                EnumeratorFuncao.Free;
              end;
            end;
          end;
        end;
      finally
        EnumeratorPapel.Free;
      end;
    finally
      ListaFuncao.Free;
    end;
  finally
    ListaPapel.Free;
  end;
end;

end.
