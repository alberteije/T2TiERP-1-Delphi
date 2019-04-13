{*******************************************************************************
Title: T2Ti ERP                                                                 
Description:  VO  relacionado à tabela [TRIBUT_ICMS_CUSTOM_CAB] 
                                                                                
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
unit TributIcmsCustomCabVO;

interface

uses
  JsonVO, Atributos, Classes, Constantes, Generics.Collections, DBXJSON, DBXJSONReflect,
  SysUtils, TributIcmsCustomDetVO;

type
  [TEntity]
  [TTable('TRIBUT_ICMS_CUSTOM_CAB')]
  TTributIcmsCustomCabVO = class(TJsonVO)
  private
    FID: Integer;
    FID_EMPRESA: Integer;
    FDESCRICAO: String;
    FORIGEM_MERCADORIA: String;

    FListaTributIcmsCustomDetVO: TObjectList<TTributIcmsCustomDetVO>; //0:N

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
    [TColumn('DESCRICAO','Descricao',450,[ldGrid, ldLookup, ldCombobox], False)]
    property Descricao: String  read FDESCRICAO write FDESCRICAO;
    [TColumn('ORIGEM_MERCADORIA','Origem Mercadoria',8,[ldGrid, ldLookup, ldCombobox], False)]
    property OrigemMercadoria: String  read FORIGEM_MERCADORIA write FORIGEM_MERCADORIA;

    [TManyValuedAssociation(False, 'ID_TRIBUT_ICMS_CUSTOM_CAB','ID')]
    property ListaTributIcmsCustomDetVO: TObjectList<TTributIcmsCustomDetVO> read FListaTributIcmsCustomDetVO write FListaTributIcmsCustomDetVO;

  end;

implementation

constructor TTributIcmsCustomCabVO.Create;
begin
  inherited;
  FListaTributIcmsCustomDetVO := TObjectList<TTributIcmsCustomDetVO>.Create; //0:N
end;

constructor TTributIcmsCustomCabVO.Create(pJsonValue: TJSONValue);
var
  Deserializa: TJSONUnMarshal;
begin
  if pJsonValue is TJSONNull then
    Exception.Create('Erro ao criar objeto com um valor nulo.');

  Deserializa := TJSONUnMarshal.Create;
  try
    Self.Free;

    //Lista Detalhe
    Deserializa.RegisterReverter(TTributIcmsCustomCabVO, 'FListaTributIcmsCustomDetVO', procedure(Data: TObject; Field: String; Args: TListOfObjects)
    var
      Obj: TObject;
    begin
      if not Assigned(TTributIcmsCustomCabVO(Data).FListaTributIcmsCustomDetVO) then
        TTributIcmsCustomCabVO(Data).FListaTributIcmsCustomDetVO := TObjectList<TTributIcmsCustomDetVO>.Create;

      for Obj in Args do
      begin
        TTributIcmsCustomCabVO(Data).FListaTributIcmsCustomDetVO.Add(TTributIcmsCustomDetVO(Obj));
      end
    end);

    Self := Deserializa.Unmarshal(pJsonValue) as TTributIcmsCustomCabVO;
  finally
    Deserializa.Free;
  end;
end;

destructor TTributIcmsCustomCabVO.Destroy;
begin
  FListaTributIcmsCustomDetVO.Free;

  inherited;
end;

function TTributIcmsCustomCabVO.ToJSON: TJSONValue;
var
  Serializa: TJSONMarshal;
begin
  Serializa := TJSONMarshal.Create(TJSONConverter.Create);
  try

    //Lista Detalhe
    Serializa.RegisterConverter(TTributIcmsCustomCabVO, 'FListaTributIcmsCustomDetVO', function(Data: TObject; Field: string): TListOfObjects
      var
        I: Integer;
      begin
        if Assigned(TTributIcmsCustomCabVO(Data).FListaTributIcmsCustomDetVO) then
        begin
          SetLength(Result, TTributIcmsCustomCabVO(Data).FListaTributIcmsCustomDetVO.Count);
          for I := 0 to TTributIcmsCustomCabVO(Data).FListaTributIcmsCustomDetVO.Count - 1 do
          begin
            Result[I] := TTributIcmsCustomCabVO(Data).FListaTributIcmsCustomDetVO.Items[I];
          end;
        end;
      end);

    Exit(serializa.Marshal(Self));
  finally
    Serializa.Free;
  end;
end;


end.
