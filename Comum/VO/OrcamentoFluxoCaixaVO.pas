{*******************************************************************************
Title: T2Ti ERP                                                                 
Description:  VO  relacionado à tabela [ORCAMENTO_FLUXO_CAIXA] 
                                                                                
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
unit OrcamentoFluxoCaixaVO;

interface

uses
  JsonVO, Atributos, Classes, Constantes, Generics.Collections, DBXJSON, DBXJSONReflect,
  SysUtils, OrcamentoFluxoCaixaDetalheVO, OrcamentoFluxoCaixaPeriodoVO;

type
  [TEntity]
  [TTable('ORCAMENTO_FLUXO_CAIXA')]
  TOrcamentoFluxoCaixaVO = class(TJsonVO)
  private
    FID: Integer;
    FID_ORC_FLUXO_CAIXA_PERIODO: Integer;
    FNOME: String;
    FDESCRICAO: String;
    FDATA_INICIAL: TDateTime;
    FNUMERO_PERIODOS: Integer;
    FDATA_BASE: TDateTime;

    FOrcamentoPeriodoNome: String;
    FOrcamentoPeriodoCodigo: String;

    FOrcamentoPeriodoVO: TOrcamentoFluxoCaixaPeriodoVO;

    FListaOrcamentoDetalheVO: TObjectList<TOrcamentoFluxoCaixaDetalheVO>;

  public
    constructor Create; overload; override;
    constructor Create(pJsonValue: TJSONValue); overload; override;
    destructor Destroy; override;
    function ToJSON: TJSONValue; override;

    [TId('ID')]
    [TGeneratedValue(sAuto)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property Id: Integer  read FID write FID;

    [TColumn('ID_ORC_FLUXO_CAIXA_PERIODO','Id Orc Fluxo Caixa Periodo',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdOrcFluxoCaixaPeriodo: Integer  read FID_ORC_FLUXO_CAIXA_PERIODO write FID_ORC_FLUXO_CAIXA_PERIODO;

    [TColumn('ORCAMENTOPERIODO.PERIODO', 'Código Período', 80, [ldGrid, ldLookup, ldComboBox], True, 'ORCAMENTO_FLUXO_CAIXA', 'ID_ORC_FLUXO_CAIXA_PERIODO', 'ID')]
    property OrcamentoPeriodoCodigo: String read FOrcamentoPeriodoCodigo write FOrcamentoPeriodoCodigo;
    [TColumn('ORCAMENTOPERIODO.NOME', 'Nome Período', 300, [ldGrid, ldLookup, ldComboBox], True, 'ORCAMENTO_FLUXO_CAIXA', 'ID_ORC_FLUXO_CAIXA_PERIODO', 'ID')]
    property OrcamentoPeriodoNome: String read FOrcamentoPeriodoNome write FOrcamentoPeriodoNome;


    [TColumn('NOME','Nome',240,[ldGrid, ldLookup, ldCombobox], False)]
    property Nome: String  read FNOME write FNOME;
    [TColumn('DESCRICAO','Descricao',450,[ldGrid, ldLookup, ldCombobox], False)]
    property Descricao: String  read FDESCRICAO write FDESCRICAO;
    [TColumn('DATA_INICIAL','Data Inicial',80,[ldGrid, ldLookup, ldCombobox], False)]
    property DataInicial: TDateTime  read FDATA_INICIAL write FDATA_INICIAL;
    [TColumn('NUMERO_PERIODOS','Numero Periodos',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property NumeroPeriodos: Integer  read FNUMERO_PERIODOS write FNUMERO_PERIODOS;
    [TColumn('DATA_BASE','Data Base',80,[ldGrid, ldLookup, ldCombobox], False)]
    property DataBase: TDateTime  read FDATA_BASE write FDATA_BASE;

    [TAssociation(True, 'ID', 'ID_ORC_FLUXO_CAIXA_PERIODO', 'ORCAMENTO_FLUXO_CAIXA')]
    property OrcamentoPeriodoVO: TOrcamentoFluxoCaixaPeriodoVO read FOrcamentoPeriodoVO write FOrcamentoPeriodoVO;

    [TManyValuedAssociation(True,'ID_ORCAMENTO_FLUXO_CAIXA','ID')]
    property ListaOrcamentoDetalheVO: TObjectList<TOrcamentoFluxoCaixaDetalheVO> read FListaOrcamentoDetalheVO write FListaOrcamentoDetalheVO;

  end;

implementation

constructor TOrcamentoFluxoCaixaVO.Create;
begin
  inherited;
  ListaOrcamentoDetalheVO := TObjectList<TOrcamentoFluxoCaixaDetalheVO>.Create;
end;

constructor TOrcamentoFluxoCaixaVO.Create(pJsonValue: TJSONValue);
var
  Deserializa: TJSONUnMarshal;
begin
  if pJsonValue is TJSONNull then
    Exception.Create('Erro ao criar objeto com um valor nulo.');

  Deserializa := TJSONUnMarshal.Create;
  try
    Self.Free;

    //Lista Orçamento Detalhe
    Deserializa.RegisterReverter(TOrcamentoFluxoCaixaVO, 'FListaOrcamentoDetalheVO', procedure(Data: TObject; Field: String; Args: TListOfObjects)
    var
      Obj: TObject;
    begin
      if not Assigned(TOrcamentoFluxoCaixaVO(Data).FListaOrcamentoDetalheVO) then
        TOrcamentoFluxoCaixaVO(Data).FListaOrcamentoDetalheVO := TObjectList<TOrcamentoFluxoCaixaDetalheVO>.Create;

      for Obj in Args do
      begin
        TOrcamentoFluxoCaixaVO(Data).FListaOrcamentoDetalheVO.Add(TOrcamentoFluxoCaixaDetalheVO(Obj));
      end
    end);

    Self := Deserializa.Unmarshal(pJsonValue) as TOrcamentoFluxoCaixaVO;
  finally
    Deserializa.Free;
  end;
end;

destructor TOrcamentoFluxoCaixaVO.Destroy;
begin
  ListaOrcamentoDetalheVO.Free;

  if Assigned(FOrcamentoPeriodoVO) then
    FOrcamentoPeriodoVO.Free;
  inherited;
end;

function TOrcamentoFluxoCaixaVO.ToJSON: TJSONValue;
var
  Serializa: TJSONMarshal;
begin
  Serializa := TJSONMarshal.Create(TJSONConverter.Create);
  try

    //Lista Orçamento Detalhe
    Serializa.RegisterConverter(TOrcamentoFluxoCaixaVO, 'FListaOrcamentoDetalheVO', function(Data: TObject; Field: string): TListOfObjects
      var
        I: Integer;
      begin
        if Assigned(TOrcamentoFluxoCaixaVO(Data).FListaOrcamentoDetalheVO) then
        begin
          SetLength(Result, TOrcamentoFluxoCaixaVO(Data).FListaOrcamentoDetalheVO.Count);
          for I := 0 to TOrcamentoFluxoCaixaVO(Data).FListaOrcamentoDetalheVO.Count - 1 do
          begin
            Result[I] := TOrcamentoFluxoCaixaVO(Data).FListaOrcamentoDetalheVO.Items[I];
          end;
        end;
      end);

    // Campos Transientes
    if Assigned(Self.OrcamentoPeriodoVO) then
    begin
      Self.OrcamentoPeriodoNome := Self.OrcamentoPeriodoVO.Nome;
      Self.OrcamentoPeriodoCodigo := Self.OrcamentoPeriodoVO.Periodo;
    end;

  Exit(serializa.Marshal(Self));
  finally
    Serializa.Free;
  end;
end;


end.
