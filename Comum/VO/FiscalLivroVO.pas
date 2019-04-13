{*******************************************************************************
Title: T2Ti ERP                                                                 
Description:  VO  relacionado à tabela [FISCAL_LIVRO] 
                                                                                
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
unit FiscalLivroVO;

interface

uses
  JsonVO, Atributos, Classes, Constantes, Generics.Collections, DBXJSON, DBXJSONReflect,
  SysUtils, FiscalTermoVO;

type
  [TEntity]
  [TTable('Fiscal_LIVRO')]
  TFiscalLivroVO = class(TJsonVO)
  private
    FID: Integer;
    FID_EMPRESA: Integer;
    FDESCRICAO: String;

    FListaFiscalTermoVO: TObjectList<TFiscalTermoVO>;

  public
    constructor Create; overload; override;
    constructor Create(pJsonValue: TJSONValue); overload; override;
    destructor Destroy; override;
    function ToJSON: TJSONValue; override;

    [TId('ID')]
    [TGeneratedValue(sAuto)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property Id: Integer  read FID write FID;
    [TColumn('ID_EMPRESA','Id Empresa',80,[], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdEmpresa: Integer  read FID_EMPRESA write FID_EMPRESA;
    [TColumn('DESCRICAO','Descricao',400,[ldGrid, ldLookup, ldCombobox], False)]
    property Descricao: String  read FDESCRICAO write FDESCRICAO;

    [TManyValuedAssociation(False,'ID_Fiscal_LIVRO','ID')]
    property ListaFiscalTermoVO: TObjectList<TFiscalTermoVO> read FListaFiscalTermoVO write FListaFiscalTermoVO;
  end;

implementation

constructor TFiscalLivroVO.Create;
begin
  inherited;
  ListaFiscalTermoVO := TObjectList<TFiscalTermoVO>.Create;
end;

constructor TFiscalLivroVO.Create(pJsonValue: TJSONValue);
var
  Deserializa: TJSONUnMarshal;
begin
  if pJsonValue is TJSONNull then
    Exception.Create('Erro ao criar objeto com um valor nulo.');

  Deserializa := TJSONUnMarshal.Create;
  try
    Self.Free;

    Deserializa.RegisterReverter(TFiscalLivroVO, 'FListaFiscalTermoVO', procedure(Data: TObject; Field: String; Args: TListOfObjects)
    var
      Obj: TObject;
    begin
  	  if not Assigned(TFiscalLivroVO(Data).FListaFiscalTermoVO) then
        TFiscalLivroVO(Data).FListaFiscalTermoVO := TObjectList<TFiscalTermoVO>.Create;

      for Obj in Args do
      begin
        TFiscalLivroVO(Data).FListaFiscalTermoVO.Add(TFiscalTermoVO(Obj));
      end
    end);

    Self := Deserializa.Unmarshal(pJsonValue) as TFiscalLivroVO;
  finally
    Deserializa.Free;
  end;
end;

destructor TFiscalLivroVO.Destroy;
begin
  ListaFiscalTermoVO.Free;

  inherited;
end;

function TFiscalLivroVO.ToJSON: TJSONValue;
var
  Serializa: TJSONMarshal;
begin
  Serializa := TJSONMarshal.Create(TJSONConverter.Create);
  try

    Serializa.RegisterConverter(TFiscalLivroVO, 'FListaFiscalTermoVO', function(Data: TObject; Field: string): TListOfObjects
      var
        I: Integer;
      begin
        if Assigned(TFiscalLivroVO(Data).FListaFiscalTermoVO) then
        begin
          SetLength(Result, TFiscalLivroVO(Data).FListaFiscalTermoVO.Count);
          for I := 0 to TFiscalLivroVO(Data).FListaFiscalTermoVO.Count - 1 do
          begin
            Result[I] := TFiscalLivroVO(Data).FListaFiscalTermoVO.Items[I];
          end;
        end;
      end);

  Exit(serializa.Marshal(Self));
  finally
    Serializa.Free;
  end;
end;

end.

