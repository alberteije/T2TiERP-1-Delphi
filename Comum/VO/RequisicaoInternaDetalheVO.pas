{*******************************************************************************
Title: T2Ti ERP                                                                 
Description:  VO  relacionado à tabela [REQUISICAO_INTERNA_DETALHE] 
                                                                                
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
unit RequisicaoInternaDetalheVO;

interface

uses
  JsonVO, Atributos, Classes, Constantes, Generics.Collections, DBXJSON, DBXJSONReflect,
  SysUtils, ProdutoVO;

type
  [TEntity]
  [TTable('REQUISICAO_INTERNA_DETALHE')]
  TRequisicaoInternaDetalheVO = class(TJsonVO)
  private
    FID: Integer;
    FID_REQ_INTERNA_CABECALHO: Integer;
    FID_PRODUTO: Integer;
    FQUANTIDADE: Extended;

    FProdutoNome: String;

    FProdutoVO: TProdutoVO;

  public 
    destructor Destroy; override;
    function ToJSON: TJSONValue; override;

    [TId('ID')]
    [TGeneratedValue(sAuto)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property Id: Integer  read FID write FID;
    [TColumn('ID_REQ_INTERNA_CABECALHO','Id Req Interna Cabecalho',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdReqInternaCabecalho: Integer  read FID_REQ_INTERNA_CABECALHO write FID_REQ_INTERNA_CABECALHO;

    [TColumn('ID_PRODUTO','Id Produto',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdProduto: Integer  read FID_PRODUTO write FID_PRODUTO;
    [TColumn('PRODUTO.NOME', 'Produto Nome', 100, [ldGrid, ldLookup, ldComboBox], True, 'PRODUTO', 'ID_PRODUTO', 'ID')]
    property ProdutoNome: String read FProdutoNome write FProdutoNome;

    [TColumn('QUANTIDADE','Quantidade',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property Quantidade: Extended  read FQUANTIDADE write FQUANTIDADE;

    [TAssociation(False, 'ID', 'ID_PRODUTO', 'PRODUTO')]
    property ProdutoVO: TProdutoVO read FProdutoVO write FProdutoVO;
  end;

implementation

destructor TRequisicaoInternaDetalheVO.Destroy;
begin
  if Assigned(FProdutoVO) then
    FProdutoVO.Free;

  inherited;
end;

function TRequisicaoInternaDetalheVO.ToJSON: TJSONValue;
var
  Serializa: TJSONMarshal;
begin
  Serializa := TJSONMarshal.Create(TJSONConverter.Create);
  try
    if Assigned(Self.ProdutoVO) then
      Self.ProdutoNome := Self.ProdutoVO.Nome;

    Exit(Serializa.Marshal(Self));
  finally
    Serializa.Free;
  end;
end;

end.
