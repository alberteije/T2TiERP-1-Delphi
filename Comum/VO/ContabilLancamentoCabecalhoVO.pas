{*******************************************************************************
Title: T2Ti ERP                                                                 
Description:  VO  relacionado à tabela [CONTABIL_LANCAMENTO_CABECALHO] 
                                                                                
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
unit ContabilLancamentoCabecalhoVO;

interface

uses
  JsonVO, Atributos, Classes, Constantes, Generics.Collections, DBXJSON, DBXJSONReflect,
  SysUtils, ContabilLoteVO, ContabilLancamentoDetalheVO;

type
  [TEntity]
  [TTable('CONTABIL_LANCAMENTO_CABECALHO')]
  TContabilLancamentoCabecalhoVO = class(TJsonVO)
  private
    FID: Integer;
    FID_EMPRESA: Integer;
    FID_CONTABIL_LOTE: Integer;
    FDATA_LANCAMENTO: TDateTime;
    FTIPO: String;
    FLIBERADO: String;
    FDATA_INCLUSAO: TDateTime;
    FVALOR: Extended;

    FLoteDescricao: String;

    FContabilLoteVO: TContabilLoteVO;

    FListaContabilLancamentoDetalheVO: TObjectList<TContabilLancamentoDetalheVO>;

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
    [TColumn('ID_CONTABIL_LOTE','Id Lote',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdContabilLote: Integer  read FID_CONTABIL_LOTE write FID_CONTABIL_LOTE;

    [TColumn('CONTABIL_LOTE.DESCRICAO', 'Lote Descrição', 300, [ldGrid, ldLookup], True)]
    property LoteDescricao: String read FLoteDescricao write FLoteDescricao;

    [TColumn('DATA_LANCAMENTO','Data Lancamento',80,[ldGrid, ldLookup, ldCombobox], False)]
    property DataLancamento: TDateTime  read FDATA_LANCAMENTO write FDATA_LANCAMENTO;
    [TColumn('TIPO','Tipo',32,[ldGrid, ldLookup, ldCombobox], False)]
    property Tipo: String  read FTIPO write FTIPO;
    [TColumn('LIBERADO','Liberado',8,[ldGrid, ldLookup, ldCombobox], False)]
    property Liberado: String  read FLIBERADO write FLIBERADO;
    [TColumn('DATA_INCLUSAO','Data Inclusao',80,[ldGrid, ldLookup, ldCombobox], False)]
    property DataInclusao: TDateTime  read FDATA_INCLUSAO write FDATA_INCLUSAO;

    [TColumn('VALOR','Valor',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property Valor: Extended  read FVALOR write FVALOR;

    [TAssociation(True, 'ID', 'ID_CONTABIL_LOTE')]
    property ContabilLoteVO: TContabilLoteVO read FContabilLoteVO write FContabilLoteVO;

    [TManyValuedAssociation(True,'ID_CONTABIL_LANCAMENTO_CAB','ID')]
    property ListaContabilLancamentoDetalheVO: TObjectList<TContabilLancamentoDetalheVO> read FListaContabilLancamentoDetalheVO write FListaContabilLancamentoDetalheVO;
  end;

implementation

constructor TContabilLancamentoCabecalhoVO.Create;
begin
  inherited;
  ListaContabilLancamentoDetalheVO := TObjectList<TContabilLancamentoDetalheVO>.Create;
end;

constructor TContabilLancamentoCabecalhoVO.Create(pJsonValue: TJSONValue);
var
  Deserializa: TJSONUnMarshal;
begin
  if pJsonValue is TJSONNull then
    Exception.Create('Erro ao criar objeto com um valor nulo.');

  Deserializa := TJSONUnMarshal.Create;
  try
    Self.Free;

    Deserializa.RegisterReverter(TContabilLancamentoCabecalhoVO, 'FListaContabilLancamentoDetalheVO', procedure(Data: TObject; Field: String; Args: TListOfObjects)
    var
      Obj: TObject;
    begin
  	  if not Assigned(TContabilLancamentoCabecalhoVO(Data).FListaContabilLancamentoDetalheVO) then
        TContabilLancamentoCabecalhoVO(Data).FListaContabilLancamentoDetalheVO := TObjectList<TContabilLancamentoDetalheVO>.Create;

      for Obj in Args do
      begin
        TContabilLancamentoCabecalhoVO(Data).FListaContabilLancamentoDetalheVO.Add(TContabilLancamentoDetalheVO(Obj));
      end
    end);

    Self := Deserializa.Unmarshal(pJsonValue) as TContabilLancamentoCabecalhoVO;
  finally
    Deserializa.Free;
  end;
end;

destructor TContabilLancamentoCabecalhoVO.Destroy;
begin
  ListaContabilLancamentoDetalheVO.Free;

  if Assigned(FContabilLoteVO) then
    FContabilLoteVO.Free;

  inherited;
end;

function TContabilLancamentoCabecalhoVO.ToJSON: TJSONValue;
var
  Serializa: TJSONMarshal;
begin
  Serializa := TJSONMarshal.Create(TJSONConverter.Create);
  try

    Serializa.RegisterConverter(TContabilLancamentoCabecalhoVO, 'FListaContabilLancamentoDetalheVO', function(Data: TObject; Field: string): TListOfObjects
      var
        I: Integer;
      begin
        if Assigned(TContabilLancamentoCabecalhoVO(Data).FListaContabilLancamentoDetalheVO) then
        begin
          SetLength(Result, TContabilLancamentoCabecalhoVO(Data).FListaContabilLancamentoDetalheVO.Count);
          for I := 0 to TContabilLancamentoCabecalhoVO(Data).FListaContabilLancamentoDetalheVO.Count - 1 do
          begin
            Result[I] := TContabilLancamentoCabecalhoVO(Data).FListaContabilLancamentoDetalheVO.Items[I];
          end;
        end;
      end);

    // Campos Transientes
    if Assigned(Self.FContabilLoteVO) then
      Self.LoteDescricao := Self.FContabilLoteVO.Descricao;

  Exit(serializa.Marshal(Self));
  finally
    Serializa.Free;
  end;
end;

end.
