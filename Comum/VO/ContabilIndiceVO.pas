{*******************************************************************************
Title: T2Ti ERP                                                                 
Description:  VO  relacionado à tabela [CONTABIL_INDICE] 
                                                                                
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
unit ContabilIndiceVO;

interface

uses
  JsonVO, Atributos, Classes, Constantes, Generics.Collections, DBXJSON, DBXJSONReflect,
  SysUtils, IndiceEconomicoVO, ContabilIndiceValorVO;

type
  [TEntity]
  [TTable('CONTABIL_INDICE')]
  TContabilIndiceVO = class(TJsonVO)
  private
    FID: Integer;
    FID_INDICE_ECONOMICO: Integer;
    FID_EMPRESA: Integer;
    FPERIODICIDADE: String;
    FDIARIO_A_PARTIR_DE: TDateTime;
    FMENSAL_MES_ANO: String;

    FIndiceEconomicoSigla: String;
    FIndiceEconomicoVO: TIndiceEconomicoVO;

    FListaContabilIndiceValorVO: TObjectList<TContabilIndiceValorVO>;

  public
    constructor Create; overload; override;
    constructor Create(pJsonValue: TJSONValue); overload; override;
    destructor Destroy; override;
    function ToJSON: TJSONValue; override;

    [TId('ID')]
    [TGeneratedValue(sAuto)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property Id: Integer  read FID write FID;
    [TColumn('ID_INDICE_ECONOMICO','Id Indice Economico',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdIndiceEconomico: Integer  read FID_INDICE_ECONOMICO write FID_INDICE_ECONOMICO;

    [TColumn('INDICE_ECONOMICO.SIGLA', 'Sigla Índice', 300, [ldGrid, ldLookup], True)]
    property IndiceEconomicoSigla: String read FIndiceEconomicoSigla write FIndiceEconomicoSigla;

    [TColumn('ID_EMPRESA','Id Empresa',80,[], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdEmpresa: Integer  read FID_EMPRESA write FID_EMPRESA;
    [TColumn('PERIODICIDADE','Periodicidade',8,[ldGrid, ldLookup, ldCombobox], False)]
    property Periodicidade: String  read FPERIODICIDADE write FPERIODICIDADE;
    [TColumn('DIARIO_A_PARTIR_DE','Diario A Partir De',80,[ldGrid, ldLookup, ldCombobox], False)]
    property DiarioAPartirDe: TDateTime  read FDIARIO_A_PARTIR_DE write FDIARIO_A_PARTIR_DE;
    [TColumn('MENSAL_MES_ANO','Mensal Mes Ano',56,[ldGrid, ldLookup, ldCombobox], False)]
    property MensalMesAno: String  read FMENSAL_MES_ANO write FMENSAL_MES_ANO;

    [TAssociation(True, 'ID', 'ID_INDICE_ECONOMICO')]
    property IndiceEconomicoVO: TIndiceEconomicoVO read FIndiceEconomicoVO write FIndiceEconomicoVO;

    [TManyValuedAssociation(False,'ID_CONTABIL_INDICE','ID')]
    property ListaContabilIndiceValorVO: TObjectList<TContabilIndiceValorVO> read FListaContabilIndiceValorVO write FListaContabilIndiceValorVO;
  end;

implementation

constructor TContabilIndiceVO.Create;
begin
  inherited;
  ListaContabilIndiceValorVO := TObjectList<TContabilIndiceValorVO>.Create;
end;

constructor TContabilIndiceVO.Create(pJsonValue: TJSONValue);
var
  Deserializa: TJSONUnMarshal;
begin
  if pJsonValue is TJSONNull then
    Exception.Create('Erro ao criar objeto com um valor nulo.');

  Deserializa := TJSONUnMarshal.Create;
  try
    Self.Free;

    Deserializa.RegisterReverter(TContabilIndiceVO, 'FListaContabilIndiceValorVO', procedure(Data: TObject; Field: String; Args: TListOfObjects)
    var
      Obj: TObject;
    begin
  	  if not Assigned(TContabilIndiceVO(Data).FListaContabilIndiceValorVO) then
        TContabilIndiceVO(Data).FListaContabilIndiceValorVO := TObjectList<TContabilIndiceValorVO>.Create;

      for Obj in Args do
      begin
        TContabilIndiceVO(Data).FListaContabilIndiceValorVO.Add(TContabilIndiceValorVO(Obj));
      end
    end);

    Self := Deserializa.Unmarshal(pJsonValue) as TContabilIndiceVO;
  finally
    Deserializa.Free;
  end;
end;

destructor TContabilIndiceVO.Destroy;
begin
  ListaContabilIndiceValorVO.Free;

  if Assigned(FIndiceEconomicoVO) then
    FIndiceEconomicoVO.Free;

  inherited;
end;

function TContabilIndiceVO.ToJSON: TJSONValue;
var
  Serializa: TJSONMarshal;
begin
  Serializa := TJSONMarshal.Create(TJSONConverter.Create);
  try

    Serializa.RegisterConverter(TContabilIndiceVO, 'FListaContabilIndiceValorVO', function(Data: TObject; Field: string): TListOfObjects
      var
        I: Integer;
      begin
        if Assigned(TContabilIndiceVO(Data).FListaContabilIndiceValorVO) then
        begin
          SetLength(Result, TContabilIndiceVO(Data).FListaContabilIndiceValorVO.Count);
          for I := 0 to TContabilIndiceVO(Data).FListaContabilIndiceValorVO.Count - 1 do
          begin
            Result[I] := TContabilIndiceVO(Data).FListaContabilIndiceValorVO.Items[I];
          end;
        end;
      end);

    // Campos Transientes
    if Assigned(Self.FIndiceEconomicoVO) then
      Self.IndiceEconomicoSigla := Self.FIndiceEconomicoVO.Sigla;

  Exit(serializa.Marshal(Self));
  finally
    Serializa.Free;
  end;
end;

end.
