{*******************************************************************************
Title: T2Ti ERP                                                                 
Description:  VO  relacionado à tabela [CONTABIL_ENCERRAMENTO_EXE_CAB] 
                                                                                
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
unit ContabilEncerramentoExeCabVO;

interface

uses
  JsonVO, Atributos, Classes, Constantes, Generics.Collections, DBXJSON, DBXJSONReflect,
  SysUtils, ContabilEncerramentoExeDetVO;

type
  [TEntity]
  [TTable('CONTABIL_ENCERRAMENTO_EXE_CAB')]
  TContabilEncerramentoExeCabVO = class(TJsonVO)
  private
    FID: Integer;
    FID_EMPRESA: Integer;
    FDATA_INICIO: TDateTime;
    FDATA_FIM: TDateTime;
    FDATA_INCLUSAO: TDateTime;
    FMOTIVO: String;

    FListaContabilEncerramentoExeDetVO: TObjectList<TContabilEncerramentoExeDetVO>;

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
    [TColumn('DATA_INICIO','Data Inicio',80,[ldGrid, ldLookup, ldCombobox], False)]
    property DataInicio: TDateTime  read FDATA_INICIO write FDATA_INICIO;
    [TColumn('DATA_FIM','Data Fim',80,[ldGrid, ldLookup, ldCombobox], False)]
    property DataFim: TDateTime  read FDATA_FIM write FDATA_FIM;
    [TColumn('DATA_INCLUSAO','Data Inclusao',80,[ldGrid, ldLookup, ldCombobox], False)]
    property DataInclusao: TDateTime  read FDATA_INCLUSAO write FDATA_INCLUSAO;
    [TColumn('MOTIVO','Motivo',450,[ldGrid, ldLookup, ldCombobox], False)]
    property Motivo: String  read FMOTIVO write FMOTIVO;

    [TManyValuedAssociation(False,'ID_CONTABIL_ENCERRAMENTO_EXE','ID')]
    property ListaContabilEncerramentoExeDetVO: TObjectList<TContabilEncerramentoExeDetVO> read FListaContabilEncerramentoExeDetVO write FListaContabilEncerramentoExeDetVO;
  end;

implementation

constructor TContabilEncerramentoExeCabVO.Create;
begin
  inherited;
  ListaContabilEncerramentoExeDetVO := TObjectList<TContabilEncerramentoExeDetVO>.Create;
end;

constructor TContabilEncerramentoExeCabVO.Create(pJsonValue: TJSONValue);
var
  Deserializa: TJSONUnMarshal;
begin
  if pJsonValue is TJSONNull then
    Exception.Create('Erro ao criar objeto com um valor nulo.');

  Deserializa := TJSONUnMarshal.Create;
  try
    Self.Free;

    Deserializa.RegisterReverter(TContabilEncerramentoExeCabVO, 'FListaContabilEncerramentoExeDetVO', procedure(Data: TObject; Field: String; Args: TListOfObjects)
    var
      Obj: TObject;
    begin
  	  if not Assigned(TContabilEncerramentoExeCabVO(Data).FListaContabilEncerramentoExeDetVO) then
        TContabilEncerramentoExeCabVO(Data).FListaContabilEncerramentoExeDetVO := TObjectList<TContabilEncerramentoExeDetVO>.Create;

      for Obj in Args do
      begin
        TContabilEncerramentoExeCabVO(Data).FListaContabilEncerramentoExeDetVO.Add(TContabilEncerramentoExeDetVO(Obj));
      end
    end);

    Self := Deserializa.Unmarshal(pJsonValue) as TContabilEncerramentoExeCabVO;
  finally
    Deserializa.Free;
  end;
end;

destructor TContabilEncerramentoExeCabVO.Destroy;
begin
  ListaContabilEncerramentoExeDetVO.Free;
  inherited;
end;

function TContabilEncerramentoExeCabVO.ToJSON: TJSONValue;
var
  Serializa: TJSONMarshal;
begin
  Serializa := TJSONMarshal.Create(TJSONConverter.Create);
  try

    Serializa.RegisterConverter(TContabilEncerramentoExeCabVO, 'FListaContabilEncerramentoExeDetVO', function(Data: TObject; Field: string): TListOfObjects
      var
        I: Integer;
      begin
        if Assigned(TContabilEncerramentoExeCabVO(Data).FListaContabilEncerramentoExeDetVO) then
        begin
          SetLength(Result, TContabilEncerramentoExeCabVO(Data).FListaContabilEncerramentoExeDetVO.Count);
          for I := 0 to TContabilEncerramentoExeCabVO(Data).FListaContabilEncerramentoExeDetVO.Count - 1 do
          begin
            Result[I] := TContabilEncerramentoExeCabVO(Data).FListaContabilEncerramentoExeDetVO.Items[I];
          end;
        end;
      end);

  Exit(serializa.Marshal(Self));
  finally
    Serializa.Free;
  end;
end;


end.
