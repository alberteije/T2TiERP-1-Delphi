{*******************************************************************************
Title: T2Ti ERP
Description: Unit de controle da tabela Usuario - Lado Cliente

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
unit UsuarioController;

interface

uses
  Classes, DBXJSON, DSHTTP, Dialogs, SysUtils, DBClient, DB, Windows, Forms, DBXCommon, UsuarioVO;

type
  TUsuarioController = class
  private
    class var FDataSet: TClientDataSet;
  public
    class function Usuario(pLogin, pSenha: string): TUsuarioVO;
    class procedure Consulta(pFiltro: String; pPagina: Integer; pLookup: Boolean);
    class procedure Insere(pUsuario: TUsuarioVO);
    class procedure Altera(pUsuario: TUsuarioVO; pFiltro: String; pPagina: Integer);
    class function MethodCtx: string;
    class procedure Exclui(pUsuario : TUsuarioVO);

    class function GetDataSet: TClientDataSet;
    class procedure SetDataSet(pDataSet: TClientDataSet);


  end;

implementation

uses UDataModule, Biblioteca, T2TiORM;

var
  Usuario: TUsuarioVO;

class procedure TUsuarioController.Altera(pUsuario: TUsuarioVO; pFiltro: String;
  pPagina: Integer);
var
  I:Integer;
  Usuario: TUsuarioVO;
begin
  try
    try
      TT2TiORM.Alterar(pUsuario);

     { for I := 0 to pListaEndereco.Count - 1 do
      begin
        PessoaEndereco := pListaEndereco.Items[i];
        TT2TiORM.Alterar(PessoaEndereco);
      end;
      }
      Consulta(pFiltro, pPagina, False);
    except
      Application.MessageBox('Ocorreu um erro. Alteração não realizada.', 'Erro do sistema', MB_OK + MB_ICONERROR);
    end;
  finally
  end;
end;


class procedure TUsuarioController.Consulta(pFiltro: String; pPagina: Integer; pLookup: Boolean);
var
  ResultSet: TDBXReader;
  ConsultaSQL: String;
  i: integer;
begin
  try
    {
    try
      pFiltro := StringReplace(pFiltro,'*','%',[rfReplaceAll]);
      pFiltro := 'u1.' + pFiltro;
      ConsultaSQL := 'select '+
                       '   u1.ID '+
                       ' , p1.NOME '+
                       ' , u1.LOGIN '+
                       ' , u1.SENHA '+
                       ' , u1.DATA_CADASTRO '+
                       ' , u1.ID_COLABORADOR '+
                       ' , u1.ID_PAPEL '+
                  ' from USUARIO u1 '+
                  '       inner join PESSOA p1 ON u1.ID = p1.ID '+
                  '       inner join COLABORADOR c1 ON u1.ID_COLABORADOR = c1.ID ';
    }
    try
      pFiltro := StringReplace(pFiltro,'*','%',[rfReplaceAll]);
      pFiltro := 'U1.' + pFiltro;
      ConsultaSQL :=     'SELECT '+
                         'U1.ID, '+
                         'P1.NOME, '+
                         'U1.LOGIN, '+
                         'U1.SENHA, '+
                         'U1.DATA_CADASTRO, '+
                         'U1.ID_COLABORADOR, '+
                         'U1.ID_PAPEL '+
                         'FROM USUARIO U1 INNER JOIN COLABORADOR C1 '+
                         'ON '+
                         'U1.ID_COLABORADOR = C1.ID INNER JOIN PESSOA P1 '+
                         'ON '+
                         'C1.ID_PESSOA = P1.ID ';

      resultSet := TT2TiORM.Consultar(ConsultaSQL, pFiltro, pPagina);

      if pLookup then
      begin
        FDataModule.CDSLookup.DisableControls;
        FDataModule.CDSLookup.EmptyDataSet;
        while ResultSet.Next do
        begin
          FDataModule.CDSLookup.Append;
          FDataModule.CDSLookup.FieldByName('ID').AsInteger := ResultSet.Value['ID'].AsInt32;
          FDataModule.CDSLookup.FieldByName('NOME').AsString := ResultSet.Value['NOME'].AsString;
          FDataModule.CDSLookup.Post;
        end;
        FDataModule.CDSLookup.Open;
        FDataModule.CDSLookup.EnableControls;
      end
      else
      begin
        FDataModule.CDSUsuario.DisableControls;
        FDataModule.CDSUsuario.EmptyDataSet;
        while ResultSet.Next do
        begin
        FDataModule.CDSUsuario.Append;
          for I := 0 to FDataModule.CDSUsuario.FieldCount -1 do
          begin
            if  ResultSet.Value[FDataModule.CDSUsuario.FieldDefList[i].Name].ValueType.DataType = 2 then
            begin
             if ResultSet.Value[FDataModule.CDSUsuario.FieldDefList[i].Name].GetDate > 0 then
                FDataModule.CDSUsuario.Fields[i].AsString := DataParaTexto(ResultSet.Value[FDataModule.CDSUsuario.FieldDefList[i].Name].AsDateTime);
            end
            else
            if  ResultSet.Value[FDataModule.CDSUsuario.FieldDefList[i].Name].ValueType.DataType = 8 then
            begin
              if not ResultSet.Value[FDataModule.CDSUsuario.FieldDefList[i].Name].IsNull  then
              begin
                FDataModule.CDSUsuario.Fields[i].AsFloat :=  ResultSet.Value[FDataModule.CDSUsuario.FieldDefList[i].Name].AsDouble;
              end
              else FDataModule.CDSUsuario.Fields[i].AsFloat := 0;
            end
            else
            if ResultSet.Value[FDataModule.CDSUsuario.FieldDefList[i].Name].AsString <> '' then
              FDataModule.CDSUsuario.Fields[i].AsString := ResultSet.Value[FDataModule.CDSUsuario.FieldDefList[i].Name].AsString;
          end;
          FDataModule.CDSUsuario.Post;
          {
          FDataModule.CDSUsuario.Append;
          FDataModule.CDSUsuario.FieldByName('ID').AsInteger := ResultSet.Value['ID'].AsInt32;
          FDataModule.CDSUsuario.FieldByName('ID_COLABORADOR').AsInteger := ResultSet.Value['ID_COLABORADOR'].AsInt32;
          FDataModule.CDSUsuario.FieldByName('ID_PAPEL').AsInteger := ResultSet.Value['ID_PAPEL'].AsInt32;
          FDataModule.CDSUsuario.FieldByName('NOME').AsString := ResultSet.Value['NOME'].AsString;
          FDataModule.CDSUsuario.FieldByName('LOGIN').AsString := ResultSet.Value['LOGIN'].AsString;
          FDataModule.CDSUsuario.FieldByName('SENHA').AsString := ResultSet.Value['SENHA'].AsString;
          FDataModule.CDSUsuario.FieldByName('DATA_CADASTRO').AsString := ResultSet.Value['DATA_CADASTRO'].AsString;
          FDataModule.CDSUsuario.Post;
          }
        end;
        //FDataModule.CDSUsuario.Open;
        FDataModule.CDSUsuario.EnableControls;
      end;
    except
    end;
  finally
    ResultSet.Free;
  end;
end;

class function TUsuarioController.GetDataSet: TClientDataSet;
begin
  Result := FDataSet;
end;

class procedure TUsuarioController.Exclui(pUsuario : TUsuarioVO);
begin
  try
    TT2TiORM.Excluir(pUsuario);
  except
    Application.MessageBox('Ocorreu um erro na exclusão do Usuario.', 'Erro do sistema', MB_OK + MB_ICONERROR);
  end;
end;

class procedure TUsuarioController.Insere(pUsuario: TUsuarioVO);
var
  I, UltimoID:Integer;
begin
  try
    try
      UltimoID := TT2TiORM.Inserir(pUsuario);
      Consulta('ID='+IntToStr(UltimoID),0,False);
    except
      Application.MessageBox('Ocorreu um erro. Inclusão não realizada.', 'Erro do sistema', MB_OK + MB_ICONERROR);
    end;
  finally
  end;
end;

class function TUsuarioController.MethodCtx: string;
begin
  Result := 'Usuario';
end;

class procedure TUsuarioController.SetDataSet(pDataSet: TClientDataSet);
begin
  FDataSet := pDataSet;
end;

class function TUsuarioController.Usuario(pLogin, pSenha: string): TUsuarioVO;
var
  ResultSet: TDBXReader;
  ConsultaSQL: String;
  vUsuario : TUsuarioVO;
begin
  try
    try
       ConsultaSQL := 'select u.ID, p.NOME, u.LOGIN, u.SENHA, u.DATA_CADASTRO, u.ID_COLABORADOR, u.ID_PAPEL '+
                      ' from usuario u, colaborador c, pessoa p '+
                      '  where u.ID_COLABORADOR = c.ID'+
                      '    and c.ID_PESSOA = p.ID ';


        resultSet := TT2TiORM.Consultar(ConsultaSQL, 'u.SENHA='+QuotedStr(pSenha)+ ' and u.login='+QuotedStr(pLogin), 0);

        while ResultSet.Next do
        begin
          vUsuario := TUsuarioVO.Create;
          vUsuario.Id := ResultSet.Value['ID'].AsInt32;
          vUsuario.IdColaborador := ResultSet.Value['ID_COLABORADOR'].AsInt32;
          vUsuario.IdPapel := ResultSet.Value['ID_PAPEL'].AsInt32;
          vUsuario.Nome := ResultSet.Value['NOME'].AsString;
          vUsuario.Login := ResultSet.Value['LOGIN'].AsString;
          vUsuario.Senha := ResultSet.Value['SENHA'].AsString;
          vUsuario.DataCadastro := ResultSet.Value['DATA_CADASTRO'].AsString;
        end;
        if Assigned(vUsuario) then
           Result := vUsuario
        else
           Result := nil;

    except
    end;
  finally
    ResultSet.Free;
    if Assigned(vUsuario) then
       vUsuario.free;
  end;
end;


end.
