{*******************************************************************************
Title: T2Ti ERP
Description:  VO  relacionado à tabela [PRODUTO_SUB_GRUPO]

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

@author  ()
@version 1.0
*******************************************************************************}
unit ProdutoSubGrupoVO;

interface

uses
  JsonVO, Atributos, Classes, Constantes, Generics.Collections, DBXJSON, DBXJSONReflect, SysUtils,
  ProdutoGrupoVO;

type
  [TEntity]
  [TTable('PRODUTO_SUB_GRUPO')]
  TProdutoSubGrupoVO = class(TJsonVO)
  private
    FID: Integer;
    FID_GRUPO: Integer;
    FNOME: String;
    FDESCRICAO: String;

    FProdutoGrupoNome: String;
    FProdutoGrupoVO: TProdutoGrupoVO;

  public
    destructor Destroy; override;
    function ToJSON: TJSONValue; override;

  public
    [TId('ID')]
    [TGeneratedValue(sAuto)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property Id: Integer  read FID write FID;

    [TColumn('ID_GRUPO','Id Grupo',[ldGrid, ldLookup] ,False)]
    property IdGrupo: Integer  read FID_GRUPO write FID_GRUPO;
    [TColumn('PRODUTO_GRUPO.NOME','Grupo Produto',250,[ldGrid, ldLookup,ldComboBox],True,'PRODUTO_GRUPO','ID_GRUPO','ID')]
    property ProdutoGrupoNome: String read FProdutoGrupoNome write FProdutoGrupoNome;

    [TColumn('NOME','Nome',[ldGrid, ldLookup] ,False)]
    property Nome: String  read FNOME write FNOME;
    [TColumn('DESCRICAO','Descrição',[ldGrid, ldLookup] ,False)]
    property Descricao: String  read FDESCRICAO write FDESCRICAO;

    [TAssociation(False,'ID','ID_GRUPO','PRODUTO_GRUPO' )]
    property ProdutoGrupoVO: TProdutoGrupoVO read FProdutoGrupoVO write FProdutoGrupoVO;


  end;

implementation

destructor TProdutoSubGrupoVO.Destroy;
begin
  if Assigned(FProdutoGrupoVO) then
    FProdutoGrupoVO.Free;
  inherited;
end;

function TProdutoSubGrupoVO.ToJSON: TJSONValue;
var
  Serializa: TJSONMarshal;
begin
  Serializa := TJSONMarshal.Create(TJSONConverter.Create);
  try
    if Assigned(Self.ProdutoGrupoVO) then
    Self.ProdutoGrupoNome := Self.ProdutoGrupoVO.Nome;

    Exit(serializa.Marshal(Self));
  finally
    Serializa.Free;
  end;
end;

end.

