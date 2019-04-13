{*******************************************************************************
Title: T2Ti ERP                                                                 
Description:  VO  relacionado à tabela [ESTOQUE_REAJUSTE_CABECALHO] 
                                                                                
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
unit EstoqueReajusteCabecalhoVO;

interface

uses
  JsonVO, Atributos, Classes, Constantes, Generics.Collections, DBXJSON, DBXJSONReflect,
  SysUtils, ColaboradorPessoaVO, EstoqueReajusteDetalheVO;

type
  [TEntity]
  [TTable('ESTOQUE_REAJUSTE_CABECALHO')]
  TEstoqueReajusteCabecalhoVO = class(TJsonVO)
  private
    FID: Integer;
    FID_COLABORADOR: Integer;
    FDATA_REAJUSTE: TDateTime;
    FPORCENTAGEM: Extended;
    FTIPO_REAJUSTE: String;

    FColaboradorPessoaNome: String;

    FColaboradorVO: TColaboradorVO;

    FListaEstoqueReajusteDetalheVO: TObjectList<TEstoqueReajusteDetalheVO>;

  public 
    constructor Create; overload; override;
    constructor Create(pJsonValue: TJSONValue); overload; override;
    destructor Destroy; override;
    function ToJSON: TJSONValue; override;

    [TId('ID')]
    [TGeneratedValue(sAuto)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property Id: Integer  read FID write FID;

    [TColumn('ID_COLABORADOR','Id Colaborador',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdColaborador: Integer  read FID_COLABORADOR write FID_COLABORADOR;
    [TColumn('COLABORADOR.PESSOA.NOME', 'Requisitante', 250, [ldGrid, ldLookup, ldComboBox], True, 'COLABORADOR.PESSOA', 'ID_COLABORADOR', 'ID')]
    property ColaboradorPessoaNome: String read FColaboradorPessoaNome write FColaboradorPessoaNome;

    [TColumn('DATA_REAJUSTE','Data Reajuste',80,[ldGrid, ldLookup, ldCombobox], False)]
    property DataReajuste: TDateTime  read FDATA_REAJUSTE write FDATA_REAJUSTE;
    [TColumn('PORCENTAGEM','Porcentagem',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property Porcentagem: Extended  read FPORCENTAGEM write FPORCENTAGEM;
    [TColumn('TIPO_REAJUSTE','Tipo Reajuste',8,[ldGrid, ldLookup, ldCombobox], False)]
    property TipoReajuste: String  read FTIPO_REAJUSTE write FTIPO_REAJUSTE;

    [TAssociation(True, 'ID', 'ID_COLABORADOR', 'COLABORADOR')]
    property ColaboradorVO: TColaboradorVO read FColaboradorVO write FColaboradorVO;

    [TManyValuedAssociation(True,'ID_ESTOQUE_REAJUSTE_CABECALHO','ID')]
    property ListaEstoqueReajusteDetalheVO: TObjectList<TEstoqueReajusteDetalheVO> read FListaEstoqueReajusteDetalheVO write FListaEstoqueReajusteDetalheVO;

  end;

implementation

constructor TEstoqueReajusteCabecalhoVO.Create;
begin
  inherited;
  ListaEstoqueReajusteDetalheVO := TObjectList<TEstoqueReajusteDetalheVO>.Create;
end;

constructor TEstoqueReajusteCabecalhoVO.Create(pJsonValue: TJSONValue);
var
  Deserializa: TJSONUnMarshal;
begin
  if pJsonValue is TJSONNull then
    Exception.Create('Erro ao criar objeto com um valor nulo.');

  Deserializa := TJSONUnMarshal.Create;
  try
    Self.Free;

    //Lista detalhe
    Deserializa.RegisterReverter(TEstoqueReajusteCabecalhoVO, 'FListaEstoqueReajusteDetalheVO', procedure(Data: TObject; Field: String; Args: TListOfObjects)
    var
      Obj: TObject;
    begin
      if not Assigned(TEstoqueReajusteCabecalhoVO(Data).FListaEstoqueReajusteDetalheVO) then
        TEstoqueReajusteCabecalhoVO(Data).FListaEstoqueReajusteDetalheVO := TObjectList<TEstoqueReajusteDetalheVO>.Create;

      for Obj in Args do
      begin
        TEstoqueReajusteCabecalhoVO(Data).FListaEstoqueReajusteDetalheVO.Add(TEstoqueReajusteDetalheVO(Obj));
      end
    end);

    Self := Deserializa.Unmarshal(pJsonValue) as TEstoqueReajusteCabecalhoVO;
  finally
    Deserializa.Free;
  end;
end;

destructor TEstoqueReajusteCabecalhoVO.Destroy;
begin
  ListaEstoqueReajusteDetalheVO.Free;

  if Assigned(FColaboradorVO) then
    FColaboradorVO.Free;
  inherited;
end;

function TEstoqueReajusteCabecalhoVO.ToJSON: TJSONValue;
var
  Serializa: TJSONMarshal;
begin
  Serializa := TJSONMarshal.Create(TJSONConverter.Create);
  try
    //Lista detalhe
    Serializa.RegisterConverter(TEstoqueReajusteCabecalhoVO, 'FListaEstoqueReajusteDetalheVO', function(Data: TObject; Field: string): TListOfObjects
      var
        I: Integer;
      begin
        if Assigned(TEstoqueReajusteCabecalhoVO(Data).FListaEstoqueReajusteDetalheVO) then
        begin
          SetLength(Result, TEstoqueReajusteCabecalhoVO(Data).FListaEstoqueReajusteDetalheVO.Count);
          for I := 0 to TEstoqueReajusteCabecalhoVO(Data).FListaEstoqueReajusteDetalheVO.Count - 1 do
          begin
            Result[I] := TEstoqueReajusteCabecalhoVO(Data).FListaEstoqueReajusteDetalheVO.Items[I];
          end;
        end;
      end);

    // Campos Transientes
     if Assigned(Self.ColaboradorVO) then
       Self.ColaboradorPessoaNome := Self.ColaboradorVO.PessoaVO.Nome;

  Exit(serializa.Marshal(Self));
  finally
    Serializa.Free;
  end;
end;


end.
