{*******************************************************************************
Title: T2Ti ERP
Description:  VO  relacionado à tabela [Almoxarifado]

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
unit AlmoxarifadoVO;

interface

uses
  JsonVO, Atributos, Classes, Constantes, Generics.Collections, DBXJSON, DBXJSONReflect, SysUtils,
  EmpresaVO;

type
  [TEntity]
  [TTable('ALMOXARIFADO')]
  TAlmoxarifadoVO = class(TJsonVO)
  private
    FID: Integer;
    FID_EMPRESA: Integer;
    FNOME: String;

    FEmpresaRazaoSocial: String;
    FEmpresaVO: TEmpresaVO;

  public
    constructor Create; overload; override;
    constructor Create(pJsonValue: TJSONValue); overload; override;
    destructor Destroy; override;

    [TId('ID')]
    [TGeneratedValue(sAuto)]
    property Id: Integer  read FID write FID;
    [TColumn('ID_EMPRESA','Id Empresa',[] ,False)]
    property IdEmpresa: Integer  read FID_EMPRESA write FID_EMPRESA;
    [TColumn('EMPRESA.RAZAO_SOCIAL','Razão Social',250,[],True,'EMPRESA','ID_EMPRESA','ID')]
    property EmpresaRazaoSocial: string read FEmpresaRazaoSocial write FEmpresaRazaoSocial;

    [TColumn('NOME','Nome',700,[ldGrid, ldLookup,ldComboBox] ,False)]
    property Nome: String  read FNOME write FNOME;

    [TAssociation(False,'ID','ID_EMPRESA','EMPRESA')]
    property EmpresaVO: TEmpresaVO read FEmpresaVO write FEmpresaVO;
  end;

implementation

constructor TAlmoxarifadoVO.Create;
begin
  inherited;
end;

constructor TAlmoxarifadoVO.Create(pJsonValue: TJSONValue);
var
  Deserializa: TJSONUnMarshal;
begin
  if pJsonValue is TJSONNull then
    Exception.Create('Erro ao criar objeto com um valor nulo.');

  Deserializa := TJSONUnMarshal.Create;
  try
    Self := Deserializa.Unmarshal(pJsonValue) as TAlmoxarifadoVO;
    if Assigned(Self.EmpresaVO) then
      Self.EmpresaRazaoSocial := Self.EmpresaVO.RazaoSocial;
  finally
    Deserializa.Free;
  end;
end;

destructor TAlmoxarifadoVO.Destroy;
begin
  if Assigned(FEmpresaVO) then
    FEmpresaVO.Free;

  inherited;
end;


end.

