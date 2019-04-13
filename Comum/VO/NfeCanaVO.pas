{*******************************************************************************
Title: T2Ti ERP                                                                 
Description:  VO  relacionado à tabela [NFE_CANA] 
                                                                                
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
unit NfeCanaVO;

interface

uses
  JsonVO, Atributos, Classes, Constantes, Generics.Collections, DBXJSON, DBXJSONReflect,
  SysUtils, NfeCanaFornecimentoDiarioVO, NfeCanaDeducoesSafraVO;

type
  [TEntity]
  [TTable('NFE_CANA')]
  TNfeCanaVO = class(TJsonVO)
  private
    FID: Integer;
    FID_NFE_CABECALHO: Integer;
    FSAFRA: String;
    FMES_ANO_REFERENCIA: String;

    FListaNfeCanaFornecimentoDiarioVO: TObjectList<TNfeCanaFornecimentoDiarioVO>; //1:31
    FListaNfeCanaDeducoesSafraVO: TObjectList<TNfeCanaDeducoesSafraVO>; //0:10

  public
    constructor Create; overload; override;
    constructor Create(pJsonValue: TJSONValue); overload; override;
    destructor Destroy; override;
    function ToJSON: TJSONValue; override;

    [TId('ID')]
    [TGeneratedValue(sAuto)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property Id: Integer  read FID write FID;
    [TColumn('ID_NFE_CABECALHO','Id Nfe Cabecalho',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdNfeCabecalho: Integer  read FID_NFE_CABECALHO write FID_NFE_CABECALHO;
    [TColumn('SAFRA','Safra',72,[ldGrid, ldLookup, ldCombobox], False)]
    property Safra: String  read FSAFRA write FSAFRA;
    [TColumn('MES_ANO_REFERENCIA','Mes Ano Referencia',72,[ldGrid, ldLookup, ldCombobox], False)]
    property MesAnoReferencia: String  read FMES_ANO_REFERENCIA write FMES_ANO_REFERENCIA;

    [TManyValuedAssociation(True,'ID_NFE_CANA','ID')]
    property ListaNfeCanaFornecimentoDiarioVO: TObjectList<TNfeCanaFornecimentoDiarioVO> read FListaNfeCanaFornecimentoDiarioVO write FListaNfeCanaFornecimentoDiarioVO;

    [TManyValuedAssociation(True,'ID_NFE_CANA','ID')]
    property ListaNfeCanaDeducoesSafraVO: TObjectList<TNfeCanaDeducoesSafraVO> read FListaNfeCanaDeducoesSafraVO write FListaNfeCanaDeducoesSafraVO;

  end;

implementation

constructor TNfeCanaVO.Create;
begin
  inherited;
  ListaNfeCanaFornecimentoDiarioVO := TObjectList<TNfeCanaFornecimentoDiarioVO>.Create;
  ListaNfeCanaDeducoesSafraVO := TObjectList<TNfeCanaDeducoesSafraVO>.Create;
end;

constructor TNfeCanaVO.Create(pJsonValue: TJSONValue);
var
  Deserializa: TJSONUnMarshal;
begin
  if pJsonValue is TJSONNull then
    Exception.Create('Erro ao criar objeto com um valor nulo.');

  Deserializa := TJSONUnMarshal.Create;
  try
    Self.Free;

    //Lista Cana Fornecimento
    Deserializa.RegisterReverter(TNfeCanaVO, 'FListaNfeCanaFornecimentoDiarioVO', procedure(Data: TObject; Field: String; Args: TListOfObjects)
    var
      Obj: TObject;
    begin
      if not Assigned(TNfeCanaVO(Data).FListaNfeCanaFornecimentoDiarioVO) then
        TNfeCanaVO(Data).FListaNfeCanaFornecimentoDiarioVO := TObjectList<TNfeCanaFornecimentoDiarioVO>.Create;

      for Obj in Args do
      begin
        TNfeCanaVO(Data).FListaNfeCanaFornecimentoDiarioVO.Add(TNfeCanaFornecimentoDiarioVO(Obj));
      end
    end);

    //Lista Cana Deduções Safra
    Deserializa.RegisterReverter(TNfeCanaVO, 'FListaNfeCanaDeducoesSafraVO', procedure(Data: TObject; Field: String; Args: TListOfObjects)
    var
      Obj: TObject;
    begin
      if not Assigned(TNfeCanaVO(Data).FListaNfeCanaDeducoesSafraVO) then
        TNfeCanaVO(Data).FListaNfeCanaDeducoesSafraVO := TObjectList<TNfeCanaDeducoesSafraVO>.Create;

      for Obj in Args do
      begin
        TNfeCanaVO(Data).FListaNfeCanaDeducoesSafraVO.Add(TNfeCanaDeducoesSafraVO(Obj));
      end
    end);

    Self := Deserializa.Unmarshal(pJsonValue) as TNfeCanaVO;
  finally
    Deserializa.Free;
  end;
end;

destructor TNfeCanaVO.Destroy;
begin
  ListaNfeCanaFornecimentoDiarioVO.Free;
  ListaNfeCanaDeducoesSafraVO.Free;
  inherited;
end;

function TNfeCanaVO.ToJSON: TJSONValue;
var
  Serializa: TJSONMarshal;
begin
  Serializa := TJSONMarshal.Create(TJSONConverter.Create);
  try

    //Lista Cana Fornecimento
    Serializa.RegisterConverter(TNfeCanaVO, 'FListaNfeCanaFornecimentoDiarioVO', function(Data: TObject; Field: string): TListOfObjects
      var
        I: Integer;
      begin
        if Assigned(TNfeCanaVO(Data).FListaNfeCanaFornecimentoDiarioVO) then
        begin
          SetLength(Result, TNfeCanaVO(Data).FListaNfeCanaFornecimentoDiarioVO.Count);
          for I := 0 to TNfeCanaVO(Data).FListaNfeCanaFornecimentoDiarioVO.Count - 1 do
          begin
            Result[I] := TNfeCanaVO(Data).FListaNfeCanaFornecimentoDiarioVO.Items[I];
          end;
        end;
      end);

    //Lista Cana Deduções Safra
    Serializa.RegisterConverter(TNfeCanaVO, 'FListaNfeCanaDeducoesSafraVO', function(Data: TObject; Field: string): TListOfObjects
      var
        I: Integer;
      begin
        if Assigned(TNfeCanaVO(Data).FListaNfeCanaDeducoesSafraVO) then
        begin
          SetLength(Result, TNfeCanaVO(Data).FListaNfeCanaDeducoesSafraVO.Count);
          for I := 0 to TNfeCanaVO(Data).FListaNfeCanaDeducoesSafraVO.Count - 1 do
          begin
            Result[I] := TNfeCanaVO(Data).FListaNfeCanaDeducoesSafraVO.Items[I];
          end;
        end;
      end);

    // Campos Transientes
    {}

    Exit(serializa.Marshal(Self));
  finally
    Serializa.Free;
  end;
end;


end.
