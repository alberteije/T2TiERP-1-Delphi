{*******************************************************************************
Title: T2Ti ERP                                                                 
Description:  VO  relacionado à tabela [CONTABIL_DRE_CABECALHO] 
                                                                                
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
unit ContabilDreCabecalhoVO;

interface

uses
  JsonVO, Atributos, Classes, Constantes, Generics.Collections, DBXJSON, DBXJSONReflect,
  ContabilDreDetalheVO, SysUtils;

type
  [TEntity]
  [TTable('CONTABIL_DRE_CABECALHO')]
  TContabilDreCabecalhoVO = class(TJsonVO)
  private
    FID: Integer;
    FID_EMPRESA: Integer;
    FDESCRICAO: String;
    FPADRAO: String;
    FPERIODO_INICIAL: String;
    FPERIODO_FINAL: String;

    FListaContabilDreDetalheVO: TObjectList<TContabilDreDetalheVO>;

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
    [TColumn('PADRAO','Padrao',8,[ldGrid, ldLookup, ldCombobox], False)]
    property Padrao: String  read FPADRAO write FPADRAO;
    [TColumn('PERIODO_INICIAL','Periodo Inicial',56,[ldGrid, ldLookup, ldCombobox], False)]
    property PeriodoInicial: String  read FPERIODO_INICIAL write FPERIODO_INICIAL;
    [TColumn('PERIODO_FINAL','Periodo Final',56,[ldGrid, ldLookup, ldCombobox], False)]
    property PeriodoFinal: String  read FPERIODO_FINAL write FPERIODO_FINAL;

    [TManyValuedAssociation(False,'ID_CONTABIL_DRE_CABECALHO','ID')]
    property ListaContabilDreDetalheVO: TObjectList<TContabilDreDetalheVO> read FListaContabilDreDetalheVO write FListaContabilDreDetalheVO;
  end;

implementation

constructor TContabilDreCabecalhoVO.Create;
begin
  inherited;
  ListaContabilDreDetalheVO := TObjectList<TContabilDreDetalheVO>.Create;
end;

constructor TContabilDreCabecalhoVO.Create(pJsonValue: TJSONValue);
var
  Deserializa: TJSONUnMarshal;
begin
  if pJsonValue is TJSONNull then
    Exception.Create('Erro ao criar objeto com um valor nulo.');

  Deserializa := TJSONUnMarshal.Create;
  try
    Self.Free;

    Deserializa.RegisterReverter(TContabilDreCabecalhoVO, 'FListaContabilDreDetalheVO', procedure(Data: TObject; Field: String; Args: TListOfObjects)
    var
      Obj: TObject;
    begin
  	  if not Assigned(TContabilDreCabecalhoVO(Data).FListaContabilDreDetalheVO) then
        TContabilDreCabecalhoVO(Data).FListaContabilDreDetalheVO := TObjectList<TContabilDreDetalheVO>.Create;

      for Obj in Args do
      begin
        TContabilDreCabecalhoVO(Data).FListaContabilDreDetalheVO.Add(TContabilDreDetalheVO(Obj));
      end
    end);

    Self := Deserializa.Unmarshal(pJsonValue) as TContabilDreCabecalhoVO;
  finally
    Deserializa.Free;
  end;
end;

destructor TContabilDreCabecalhoVO.Destroy;
begin
  ListaContabilDreDetalheVO.Free;
  inherited;
end;

function TContabilDreCabecalhoVO.ToJSON: TJSONValue;
var
  Serializa: TJSONMarshal;
begin
  Serializa := TJSONMarshal.Create(TJSONConverter.Create);
  try

    Serializa.RegisterConverter(TContabilDreCabecalhoVO, 'FListaContabilDreDetalheVO', function(Data: TObject; Field: string): TListOfObjects
      var
        I: Integer;
      begin
        if Assigned(TContabilDreCabecalhoVO(Data).FListaContabilDreDetalheVO) then
        begin
          SetLength(Result, TContabilDreCabecalhoVO(Data).FListaContabilDreDetalheVO.Count);
          for I := 0 to TContabilDreCabecalhoVO(Data).FListaContabilDreDetalheVO.Count - 1 do
          begin
            Result[I] := TContabilDreCabecalhoVO(Data).FListaContabilDreDetalheVO.Items[I];
          end;
        end;
      end);

  Exit(serializa.Marshal(Self));
  finally
    Serializa.Free;
  end;
end;

end.
