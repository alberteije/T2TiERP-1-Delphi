{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: Controller do lado Servidor relacionado à tabela [VENDEDOR] 
                                                                                
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
                                                                                
@author Albert Eije (t2ti.com@gmail.com)                    
@version 1.0                                                                    
*******************************************************************************}
unit VendedorController;

interface

uses
  Classes, SQLExpr, SysUtils, Generics.Collections, Controller, DBXJSON, DBXCommon;

type
  TVendedorController = class(TController)
  protected
  public
    //consultar
    function Vendedor(pSessao: String; pFiltro: String; pPagina: Integer): TJSONArray;
    //inserir
    function AcceptVendedor(pSessao: String; pObjeto: TJSONValue): TJSONArray;
    //alterar
    function UpdateVendedor(pSessao: String; pObjeto: TJSONValue): Boolean;
    //excluir
    function CancelVendedor(pSessao: String; pId: Integer): Boolean;
  end;

implementation

uses
  VendedorVO, T2TiORM, SA;

{ TVendedorController }

var
  objVendedor: TVendedorVO;


function TVendedorController.Vendedor(pSessao, pFiltro: String; pPagina: Integer): TJSONArray;
begin
  Result := TT2TiORM.Consultar<TVendedorVO>(pFiltro, pPagina);
end;

function TVendedorController.AcceptVendedor(pSessao: String; pObjeto: TJSONValue): TJSONArray;
var
  UltimoID:Integer;
begin
  objVendedor := TVendedorVO.Create(pObjeto);
  try
    try
      UltimoID := TT2TiORM.Inserir(objVendedor);
      Result := Vendedor(pSessao, 'ID = ' + IntToStr(UltimoID),0);
    except
      Result := TJSONArray.Create;
    end;
  finally
    objVendedor.Free;
  end;
end;

function TVendedorController.UpdateVendedor(pSessao: String; pObjeto: TJSONValue): Boolean;
begin
  objVendedor := TVendedorVO.Create(pObjeto);
  try
    try
      Result := TT2TiORM.Alterar(objVendedor);
    except
      Result := False;
    end;
  finally
    objVendedor.Free;
  end;
end;

function TVendedorController.CancelVendedor(pSessao: String; pId: Integer): Boolean;
begin
  objVendedor := TVendedorVO.Create;
  try
    objVendedor.Id := pId;
    try
      Result := TT2TiORM.Excluir(objVendedor);
    except
      Result := False;
    end;
  finally
    objVendedor.Free;
  end;
end;

end.
