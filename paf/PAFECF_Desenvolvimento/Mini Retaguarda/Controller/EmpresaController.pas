{*******************************************************************************
Title: T2Ti ERP
Description: Unit de controle da tabela EMPRESA

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
*******************************************************************************}
unit EmpresaController;

interface

uses
  Classes, Dialogs, SysUtils, DBClient, DB, Windows, Forms, EmpresaVO, DBXCommon;

type
  TEmpresaController = class
  private
  protected
  public
    class Procedure Consulta(pFiltro: String; pPagina: Integer; pLookup: Boolean);
    class Procedure Altera(pEmpresa: TEmpresaVO);
    class Function ConsultaObjeto(pFiltro: String): TEmpresaVO;
  end;

implementation

uses UDataModule, T2TiORM, Biblioteca;

var
  Empresa: TEmpresaVO;

class procedure TEmpresaController.Altera(pEmpresa: TEmpresaVO);
begin
  try
    try
      TT2TiORM.Alterar(pEmpresa);
    except
      Application.MessageBox('Ocorreu um erro. Alteração não realizada.', 'Erro do sistema', MB_OK + MB_ICONERROR);
    end;
  finally
  end;
end;

class procedure TEmpresaController.Consulta(pFiltro: String; pPagina: Integer; pLookup: Boolean);
var
  ResultSet : TDBXReader;
  I : Integer;
begin
  try
    try
      pFiltro := StringReplace(pFiltro,'*','%',[rfReplaceAll]);
      ResultSet := TT2TiORM.Consultar(TEmpresaVO.Create, pFiltro, pPagina);

      if pLookup then
      begin
        FDataModule.CDSLookup.DisableControls;
        FDataModule.CDSLookup.EmptyDataSet;
        if ResultSet.Next then
        begin
          FDataModule.CDSLookup.Append;
          FDataModule.CDSLookup.FieldByName('ID').AsInteger := ResultSet.Value['ID'].AsInt32;
          FDataModule.CDSLookup.FieldByName('RAZAO_SOCIAL').AsString := ResultSet.Value['RAZAO_SOCIAL'].AsString;
          FDataModule.CDSLookup.FieldByName('NOME_FANTASIA').AsString := ResultSet.Value['NOME_FANTASIA'].AsString;
          FDataModule.CDSLookup.FieldByName('CNPJ').AsString := ResultSet.Value['CNPJ'].AsString;
          FDataModule.CDSLookup.FieldByName('INCRICAO_ESTADUAL').AsString := ResultSet.Value['INCRICAO_ESTADUAL'].AsString;
          FDataModule.CDSLookup.FieldByName('INSCRICAO_ESTADUAL_ST').AsString := ResultSet.Value['INSCRICAO_ESTADUAL_ST'].AsString;
          FDataModule.CDSLookup.FieldByName('INSCRICAO_MUNICIPAL').AsString := ResultSet.Value['INSCRICAO_MUNICIPAL'].AsString;
          FDataModule.CDSLookup.FieldByName('INSCRICAO_JUNTA_COMERCIAL').AsString := ResultSet.Value['INSCRICAO_JUNTA_COMERCIAL'].AsString;
          FDataModule.CDSLookup.FieldByName('DATA_INSC_JUNTA_COMERCIAL').AsString := ResultSet.Value['DATA_INSC_JUNTA_COMERCIAL'].AsString;
          FDataModule.CDSLookup.FieldByName('DATA_CADASTRO').AsString := ResultSet.Value['DATA_CADASTRO'].AsString;
          FDataModule.CDSLookup.FieldByName('DATA_INICIO_ATIVIDADES').AsString := ResultSet.Value['DATA_INICIO_ATIVIDADES'].AsString;
          FDataModule.CDSLookup.FieldByName('SUFRAMA').AsString := ResultSet.Value['SUFRAMA'].AsString;
          FDataModule.CDSLookup.FieldByName('EMAIL').AsString := ResultSet.Value['EMAIL'].AsString;
          FDataModule.CDSLookup.FieldByName('IMAGEM_LOGOTIPO').AsString := ResultSet.Value['IMAGEM_LOGOTIPO'].AsString;
          FDataModule.CDSLookup.FieldByName('CRT').AsString := ResultSet.Value['CRT'].AsString;
          FDataModule.CDSLookup.FieldByName('TIPO_REGIME').AsString := ResultSet.Value['TIPO_REGIME'].AsString;
          FDataModule.CDSLookup.FieldByName('ALIQUOTA_PIS').AsFloat := ResultSet.Value['ALIQUOTA_PIS'].AsDouble;
          FDataModule.CDSLookup.FieldByName('ALIQUOTA_COFINS').AsFloat := ResultSet.Value['ALIQUOTA_COFINS'].AsDouble;
          FDataModule.CDSLookup.FieldByName('LOGRADOURO').AsString := ResultSet.Value['LOGRADOURO'].AsString;
          FDataModule.CDSLookup.FieldByName('NUMERO').AsString := ResultSet.Value['NUMERO'].AsString;
          FDataModule.CDSLookup.FieldByName('COMPLEMENTO').AsString := ResultSet.Value['COMPLEMENTO'].AsString;
          FDataModule.CDSLookup.FieldByName('CEP').AsString := ResultSet.Value['CEP'].AsString;
          FDataModule.CDSLookup.FieldByName('BAIRRO').AsString := ResultSet.Value['BAIRRO'].AsString;
          FDataModule.CDSLookup.FieldByName('CIDADE').AsString := ResultSet.Value['CIDADE'].AsString;
          FDataModule.CDSLookup.FieldByName('UF').AsString := ResultSet.Value['UF'].AsString;
          FDataModule.CDSLookup.FieldByName('FONE').AsString := ResultSet.Value['FONE'].AsString;
          FDataModule.CDSLookup.FieldByName('FAX').AsString := ResultSet.Value['FAX'].AsString;
          FDataModule.CDSLookup.FieldByName('CONTATO').AsString := ResultSet.Value['CONTATO'].AsString;
          FDataModule.CDSLookup.FieldByName('CODIGO_IBGE_CIDADE').AsInteger := ResultSet.Value['CODIGO_IBGE_CIDADE'].AsInt32;
          FDataModule.CDSLookup.FieldByName('CODIGO_IBGE_UF').AsInteger := ResultSet.Value['CODIGO_IBGE_UF'].AsInt32;
          FDataModule.CDSLookup.Post;
        end;
        FDataModule.CDSLookup.Open;
        FDataModule.CDSLookup.EnableControls;
      end
      else
      begin
        FDataModule.CDSEmpresa.DisableControls;
        FDataModule.CDSEmpresa.EmptyDataSet;
        while ResultSet.Next do
        begin

          FDataModule.CDSEmpresa.Append;
          for I := 0 to FDataModule.CDSEmpresa.FieldCount -1 do
          begin
            if  ResultSet.Value[FDataModule.CDSEmpresa.FieldDefList[i].Name].ValueType.DataType = 2 then
            begin
             if ResultSet.Value[FDataModule.CDSEmpresa.FieldDefList[i].Name].GetDate > 0 then
                FDataModule.CDSEmpresa.Fields[i].AsString := DataParaTexto(ResultSet.Value[FDataModule.CDSEmpresa.FieldDefList[i].Name].AsDateTime);
            end
            else
            if  ResultSet.Value[FDataModule.CDSEmpresa.FieldDefList[i].Name].ValueType.DataType = 8 then
            begin
              if not ResultSet.Value[FDataModule.CDSEmpresa.FieldDefList[i].Name].IsNull  then
              begin
                FDataModule.CDSEmpresa.Fields[i].AsFloat :=  ResultSet.Value[FDataModule.CDSEmpresa.FieldDefList[i].Name].AsDouble;
              end
              else FDataModule.CDSEmpresa.Fields[i].AsFloat := 0;
            end
            else
            if ResultSet.Value[FDataModule.CDSEmpresa.FieldDefList[i].Name].AsString <> '' then
              FDataModule.CDSEmpresa.Fields[i].AsString := ResultSet.Value[FDataModule.CDSEmpresa.FieldDefList[i].Name].AsString;
          end;
          FDataModule.CDSEmpresa.Post;
{
          FDataModule.CDSEmpresa.Append;
          for I := 0 to FDataModule.CDSEmpresa.FieldCount -1 do
          begin
            if  ResultSet.Value[FDataModule.CDSEmpresa.FieldDefList[i].Name].ValueType.DataType = 2 then
            begin
              if ResultSet.Value[FDataModule.CDSEmpresa.FieldDefList[i].Name].GetDate > 0 then
                FDataModule.CDSEmpresa.Fields[i].AsString := FormatDateTime('DD/MM/YYYY', ResultSet.Value[FDataModule.CDSEmpresa.FieldDefList[i].Name].AsDateTime);
            end
            else
            if  ResultSet.Value[FDataModule.CDSEmpresa.FieldDefList[i].Name].ValueType.DataType = 8 then
            begin
               if not ResultSet.Value[FDataModule.CDSEmpresa.FieldDefList[i].Name].IsNull then
                 FDataModule.CDSEmpresa.Fields[i].AsFloat := ResultSet.Value[FDataModule.CDSEmpresa.FieldDefList[i].Name].AsDouble;
            end
            else
            if ResultSet.Value[FDataModule.CDSEmpresa.FieldDefList[i].Name].AsString <> '' then
              FDataModule.CDSEmpresa.Fields[i].AsString := ResultSet.Value[FDataModule.CDSEmpresa.FieldDefList[i].Name].AsString;
          end;
          FDataModule.CDSEmpresa.Post;

          {
          FDataModule.CDSEmpresa.Append;
          FDataModule.CDSEmpresa.FieldByName('ID').AsInteger := ResultSet.Value['ID'].AsInt32;
          FDataModule.CDSEmpresa.FieldByName('RAZAO_SOCIAL').AsString := ResultSet.Value['RAZAO_SOCIAL'].AsString;
          FDataModule.CDSEmpresa.FieldByName('FANTASIA').AsString := ResultSet.Value['FANTASIA'].AsString;
          FDataModule.CDSEmpresa.FieldByName('CNPJ').AsString := ResultSet.Value['CNPJ'].AsString;
          FDataModule.CDSEmpresa.FieldByName('INSCRICAO_ESTADUAL').AsString := ResultSet.Value['INSCRICAO_ESTADUAL'].AsString;
          FDataModule.CDSEmpresa.FieldByName('INSCRICAO_ESTADUAL_ST').AsString := ResultSet.Value['INSCRICAO_ESTADUAL_ST'].AsString;
          FDataModule.CDSEmpresa.FieldByName('INSCRICAO_MUNICIPAL').AsString := ResultSet.Value['INSCRICAO_MUNICIPAL'].AsString;
          FDataModule.CDSEmpresa.FieldByName('INSCRICAO_JUNTA_COMERCIAL').AsString := ResultSet.Value['INSCRICAO_JUNTA_COMERCIAL'].AsString;
          FDataModule.CDSEmpresa.FieldByName('DATA_INSC_JUNTA_COMERCIAL').AsString := ResultSet.Value['DATA_INSC_JUNTA_COMERCIAL'].AsString;
          FDataModule.CDSEmpresa.FieldByName('DATA_CADASTRO').AsString := ResultSet.Value['DATA_CADASTRO'].AsString;
          FDataModule.CDSEmpresa.FieldByName('DATA_INICIO_ATIVIDADES').AsString := ResultSet.Value['DATA_INICIO_ATIVIDADES'].AsString;
          FDataModule.CDSEmpresa.FieldByName('SUFRAMA').AsString := ResultSet.Value['SUFRAMA'].AsString;
          FDataModule.CDSEmpresa.FieldByName('EMAIL').AsString := ResultSet.Value['EMAIL'].AsString;
          FDataModule.CDSEmpresa.FieldByName('IMAGEM_LOGOTIPO').AsString := ResultSet.Value['IMAGEM_LOGOTIPO'].AsString;
          FDataModule.CDSEmpresa.FieldByName('CRT').AsString := ResultSet.Value['CRT'].AsString;
          FDataModule.CDSEmpresa.FieldByName('TIPO_REGIME').AsString := ResultSet.Value['TIPO_REGIME'].AsString;
          FDataModule.CDSEmpresa.FieldByName('ALIQUOTA_PIS').AsFloat := ResultSet.Value['ALIQUOTA_PIS'].AsDouble;
          FDataModule.CDSEmpresa.FieldByName('ALIQUOTA_COFINS').AsFloat := ResultSet.Value['ALIQUOTA_COFINS'].AsDouble;
          FDataModule.CDSEmpresa.FieldByName('LOGRADOURO').AsString := ResultSet.Value['LOGRADOURO'].AsString;
          FDataModule.CDSEmpresa.FieldByName('NUMERO').AsString := ResultSet.Value['NUMERO'].AsString;
          FDataModule.CDSEmpresa.FieldByName('COMPLEMENTO').AsString := ResultSet.Value['COMPLEMENTO'].AsString;
          FDataModule.CDSEmpresa.FieldByName('CEP').AsString := ResultSet.Value['CEP'].AsString;
          FDataModule.CDSEmpresa.FieldByName('BAIRRO').AsString := ResultSet.Value['BAIRRO'].AsString;
          FDataModule.CDSEmpresa.FieldByName('CIDADE').AsString := ResultSet.Value['CIDADE'].AsString;
          FDataModule.CDSEmpresa.FieldByName('UF').AsString := ResultSet.Value['UF'].AsString;
          FDataModule.CDSEmpresa.FieldByName('FONE').AsString := ResultSet.Value['FONE'].AsString;
          FDataModule.CDSEmpresa.FieldByName('FAX').AsString := ResultSet.Value['FAX'].AsString;
          FDataModule.CDSEmpresa.FieldByName('CONTATO').AsString := ResultSet.Value['CONTATO'].AsString;
          FDataModule.CDSEmpresa.FieldByName('CODIGO_IBGE_CIDADE').AsInteger := ResultSet.Value['CODIGO_IBGE_CIDADE'].AsInt32;
          FDataModule.CDSEmpresa.FieldByName('CODIGO_IBGE_UF').AsInteger := ResultSet.Value['CODIGO_IBGE_UF'].AsInt32;
          FDataModule.CDSEmpresa.Post;
          }
        end;
        //FDataModule.CDSEmpresa.Open;
        FDataModule.CDSEmpresa.EnableControls;
      end;

    except
    end;
  finally
    ResultSet.Free;
  end;
end;

class function TEmpresaController.ConsultaObjeto(pFiltro: String): TEmpresaVO;
var
  ResultSet : TDBXReader;
begin
  try
    try
      pFiltro := StringReplace(pFiltro,'*','%',[rfReplaceAll]);
      ResultSet := TT2TiORM.Consultar(TEmpresaVO.Create, pFiltro, 0);

      Result := TEmpresaVO.Create;

      if ResultSet.Next then
      begin
        Empresa.Id := ResultSet.Value['ID'].AsInt32;
        Empresa.RazaoSocial := ResultSet.Value['RAZAO_SOCIAL'].AsString;
        Empresa.NomeFantasia := ResultSet.Value['NOME_FANTASIA'].AsString;
        Empresa.Cnpj := ResultSet.Value['CNPJ'].AsString;
        Empresa.InscricaoEstadual := ResultSet.Value['INCRICAO_ESTADUAL'].AsString;
        Empresa.InscricaoEstadualSt := ResultSet.Value['INSCRICAO_ESTADUAL_ST'].AsString;
        Empresa.InscricaoMunicipal := ResultSet.Value['INSCRICAO_MUNICIPAL'].AsString;
        Empresa.InscricaoJuntaComercial := ResultSet.Value['INSCRICAO_JUNTA_COMERCIAL'].AsString;
        Empresa.DataInscJuntaComercial := ResultSet.Value['DATA_INSC_JUNTA_COMERCIAL'].AsString;
        Empresa.DataCadastro := ResultSet.Value['DATA_CADASTRO'].AsString;
        Empresa.DataInicioAtividades := ResultSet.Value['DATA_INICIO_ATIVIDADES'].AsString;
        Empresa.Suframa := ResultSet.Value['SUFRAMA'].AsString;
        Empresa.Email := ResultSet.Value['EMAIL'].AsString;
        Empresa.ImagemLogotipo := ResultSet.Value['IMAGEM_LOGOTIPO'].AsString;
        Empresa.Crt := ResultSet.Value['CRT'].AsString;
        Empresa.TipoRegime := ResultSet.Value['TIPO_REGIME'].AsString;
        Empresa.AliquotaPis := ResultSet.Value['ALIQUOTA_PIS'].AsDouble;
        Empresa.AliquotaCofins := ResultSet.Value['ALIQUOTA_COFINS'].AsDouble;
        Empresa.Logradouro := ResultSet.Value['LOGRADOURO'].AsString;
        Empresa.Numero := ResultSet.Value['NUMERO'].AsString;
        Empresa.Complemento := ResultSet.Value['COMPLEMENTO'].AsString;
        Empresa.Cep := ResultSet.Value['CEP'].AsString;
        Empresa.Bairro := ResultSet.Value['BAIRRO'].AsString;
        Empresa.Cidade := ResultSet.Value['CIDADE'].AsString;
        Empresa.Uf := ResultSet.Value['UF'].AsString;
        Empresa.Fone := ResultSet.Value['FONE'].AsString;
        Empresa.Fax := ResultSet.Value['FAX'].AsString;
        Empresa.Contato := ResultSet.Value['CONTATO'].AsString;
        Empresa.CodigoIbgeCidade := ResultSet.Value['CODIGO_IBGE_CIDADE'].AsInt32;
        Empresa.CodigoIbgeUf := ResultSet.Value['CODIGO_IBGE_UF'].AsInt32;
      end;

    except
    end;
  finally
    ResultSet.Free;
  end;
end;

end.
