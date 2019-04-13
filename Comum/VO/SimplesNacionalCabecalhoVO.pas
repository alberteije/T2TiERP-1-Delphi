{*******************************************************************************
Title: T2Ti ERP                                                                 
Description:  VO  relacionado à tabela [SIMPLES_NACIONAL_CABECALHO] 
                                                                                
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
unit SimplesNacionalCabecalhoVO;

interface

uses
  JsonVO, Atributos, Classes, Constantes, Generics.Collections, DBXJSON, DBXJSONReflect,
  SysUtils, SimplesNacionalDetalheVO;

type
  [TEntity]
  [TTable('SIMPLES_NACIONAL_CABECALHO')]
  TSimplesNacionalCabecalhoVO = class(TJsonVO)
  private
    FID: Integer;
    FVIGENCIA_INICIAL: TDateTime;
    FVIGENCIA_FINAL: TDateTime;
    FANEXO: String;
    FTABELA: String;

    FListaSimplesNacionalDetalheVO: TObjectList<TSimplesNacionalDetalheVO>;

  public 
    constructor Create; overload; override;
    constructor Create(pJsonValue: TJSONValue); overload; override;
    destructor Destroy; override;
    function ToJSON: TJSONValue; override;

    [TId('ID')]
    [TGeneratedValue(sAuto)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property Id: Integer  read FID write FID;
    [TColumn('VIGENCIA_INICIAL','Vigencia Inicial',80,[ldGrid, ldLookup, ldCombobox], False)]
    property VigenciaInicial: TDateTime  read FVIGENCIA_INICIAL write FVIGENCIA_INICIAL;
    [TColumn('VIGENCIA_FINAL','Vigencia Final',80,[ldGrid, ldLookup, ldCombobox], False)]
    property VigenciaFinal: TDateTime  read FVIGENCIA_FINAL write FVIGENCIA_FINAL;
    [TColumn('ANEXO','Anexo',80,[ldGrid, ldLookup, ldCombobox], False)]
    property Anexo: String  read FANEXO write FANEXO;
    [TColumn('TABELA','Tabela',80,[ldGrid, ldLookup, ldCombobox], False)]
    property Tabela: String  read FTABELA write FTABELA;

    [TManyValuedAssociation(False,'ID_SIMPLES_NACIONAL_CABECALHO','ID')]
    property ListaSimplesNacionalDetalheVO: TObjectList<TSimplesNacionalDetalheVO> read FListaSimplesNacionalDetalheVO write FListaSimplesNacionalDetalheVO;
  end;

implementation

constructor TSimplesNacionalCabecalhoVO.Create;
begin
  inherited;
  ListaSimplesNacionalDetalheVO := TObjectList<TSimplesNacionalDetalheVO>.Create;
end;

constructor TSimplesNacionalCabecalhoVO.Create(pJsonValue: TJSONValue);
var
  Deserializa: TJSONUnMarshal;
begin
  if pJsonValue is TJSONNull then
    Exception.Create('Erro ao criar objeto com um valor nulo.');

  Deserializa := TJSONUnMarshal.Create;
  try
    Self.Free;

    Deserializa.RegisterReverter(TSimplesNacionalCabecalhoVO, 'FListaSimplesNacionalDetalheVO', procedure(Data: TObject; Field: String; Args: TListOfObjects)
    var
      Obj: TObject;
    begin
  	  if not Assigned(TSimplesNacionalCabecalhoVO(Data).FListaSimplesNacionalDetalheVO) then
        TSimplesNacionalCabecalhoVO(Data).FListaSimplesNacionalDetalheVO := TObjectList<TSimplesNacionalDetalheVO>.Create;

      for Obj in Args do
      begin
        TSimplesNacionalCabecalhoVO(Data).FListaSimplesNacionalDetalheVO.Add(TSimplesNacionalDetalheVO(Obj));
      end
    end);

    Self := Deserializa.Unmarshal(pJsonValue) as TSimplesNacionalCabecalhoVO;
  finally
    Deserializa.Free;
  end;
end;

destructor TSimplesNacionalCabecalhoVO.Destroy;
begin
  ListaSimplesNacionalDetalheVO.Free;

  inherited;
end;

function TSimplesNacionalCabecalhoVO.ToJSON: TJSONValue;
var
  Serializa: TJSONMarshal;
begin
  Serializa := TJSONMarshal.Create(TJSONConverter.Create);
  try

    Serializa.RegisterConverter(TSimplesNacionalCabecalhoVO, 'FListaSimplesNacionalDetalheVO', function(Data: TObject; Field: string): TListOfObjects
      var
        I: Integer;
      begin
        if Assigned(TSimplesNacionalCabecalhoVO(Data).FListaSimplesNacionalDetalheVO) then
        begin
          SetLength(Result, TSimplesNacionalCabecalhoVO(Data).FListaSimplesNacionalDetalheVO.Count);
          for I := 0 to TSimplesNacionalCabecalhoVO(Data).FListaSimplesNacionalDetalheVO.Count - 1 do
          begin
            Result[I] := TSimplesNacionalCabecalhoVO(Data).FListaSimplesNacionalDetalheVO.Items[I];
          end;
        end;
      end);

  Exit(serializa.Marshal(Self));
  finally
    Serializa.Free;
  end;
end;


end.
