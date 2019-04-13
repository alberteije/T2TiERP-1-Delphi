{*******************************************************************************
Title: T2Ti ERP                                                                 
Description:  VO  relacionado à tabela [COMPRA_COTACAO] 
                                                                                
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
unit CompraCotacaoVO;

interface

uses
  JsonVO, Atributos, Classes, Constantes, Generics.Collections, DBXJSON, DBXJSONReflect,
  SysUtils, CompraReqCotacaoDetalheVO;

type
  [TEntity]
  [TTable('COMPRA_COTACAO')]
  TCompraCotacaoVO = class(TJsonVO)
  private
    FID: Integer;
    FDATA_COTACAO: TDateTime;
    FDESCRICAO: String;
    FSITUACAO: String;

    FListaCompraReqCotacaoDetalheVO: TObjectList<TCompraReqCotacaoDetalheVO>;

  public
    constructor Create; overload; override;
    constructor Create(pJsonValue: TJSONValue); overload; override;
    destructor Destroy; override;
    function ToJSON: TJSONValue; override;

    [TId('ID')]
    [TGeneratedValue(sAuto)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property Id: Integer  read FID write FID;
    [TColumn('DATA_COTACAO','Data Cotação',80,[ldGrid, ldLookup, ldCombobox], False)]
    property DataCotacao: TDateTime  read FDATA_COTACAO write FDATA_COTACAO;
    [TColumn('DESCRICAO','Descrição',450,[ldGrid, ldLookup, ldCombobox], False)]
    property Descricao: String  read FDESCRICAO write FDESCRICAO;
    [TColumn('SITUACAO','Situação',80,[ldGrid, ldLookup, ldCombobox], False)]
    property Situacao: String  read FSITUACAO write FSITUACAO;

    [TManyValuedAssociation(False,'ID_COMPRA_COTACAO','ID')]
    property ListaCompraReqCotacaoDetalheVO: TObjectList<TCompraReqCotacaoDetalheVO> read FListaCompraReqCotacaoDetalheVO write FListaCompraReqCotacaoDetalheVO;

  end;

implementation

constructor TCompraCotacaoVO.Create;
begin
  inherited;
  ListaCompraReqCotacaoDetalheVO := TObjectList<TCompraReqCotacaoDetalheVO>.Create;
end;

constructor TCompraCotacaoVO.Create(pJsonValue: TJSONValue);
var
  Deserializa: TJSONUnMarshal;
begin
  if pJsonValue is TJSONNull then
    Exception.Create('Erro ao criar objeto com um valor nulo.');

  Deserializa := TJSONUnMarshal.Create;
  try
    Self.Free;

    //Lista de itens da requisição que foram utilizados na cotação
    Deserializa.RegisterReverter(TCompraCotacaoVO, 'FListaCompraReqCotacaoDetalheVO', procedure(Data: TObject; Field: String; Args: TListOfObjects)
    var
      Obj: TObject;
    begin
      if not Assigned(TCompraCotacaoVO(Data).FListaCompraReqCotacaoDetalheVO) then
        TCompraCotacaoVO(Data).FListaCompraReqCotacaoDetalheVO := TObjectList<TCompraReqCotacaoDetalheVO>.Create;

      for Obj in Args do
      begin
        TCompraCotacaoVO(Data).FListaCompraReqCotacaoDetalheVO.Add(TCompraReqCotacaoDetalheVO(Obj));
      end
    end);

    Self := Deserializa.Unmarshal(pJsonValue) as TCompraCotacaoVO;
  finally
    Deserializa.Free;
  end;
end;

destructor TCompraCotacaoVO.Destroy;
begin
  ListaCompraReqCotacaoDetalheVO.Free;
  inherited;
end;

function TCompraCotacaoVO.ToJSON: TJSONValue;
var
  Serializa: TJSONMarshal;
begin
  Serializa := TJSONMarshal.Create(TJSONConverter.Create);
  try
    //Lista de itens da requisição que foram utilizados na cotação
    Serializa.RegisterConverter(TCompraCotacaoVO, 'FListaCompraReqCotacaoDetalheVO', function(Data: TObject; Field: string): TListOfObjects
      var
        I: Integer;
      begin
        if Assigned(TCompraCotacaoVO(Data).FListaCompraReqCotacaoDetalheVO) then
        begin
          SetLength(Result, TCompraCotacaoVO(Data).FListaCompraReqCotacaoDetalheVO.Count);
          for I := 0 to TCompraCotacaoVO(Data).FListaCompraReqCotacaoDetalheVO.Count - 1 do
          begin
            Result[I] := TCompraCotacaoVO(Data).FListaCompraReqCotacaoDetalheVO.Items[I];
          end;
        end;
      end);

  Exit(serializa.Marshal(Self));
  finally
    Serializa.Free;
  end;
end;

end.
