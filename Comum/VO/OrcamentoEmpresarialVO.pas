{*******************************************************************************
Title: T2Ti ERP                                                                 
Description:  VO  relacionado à tabela [ORCAMENTO_EMPRESARIAL] 
                                                                                
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
           t2ti.com@gmail.com</p>                                               
                                                                                
fernandololiver@gmail.com
@author @author Fernando L Oliveira
@version 1.0                                                                    
*******************************************************************************}
unit OrcamentoEmpresarialVO;

interface

uses
  JsonVO, Atributos, Classes, Constantes, Generics.Collections, DBXJSON, DBXJSONReflect, SysUtils,
  OrcamentoDetalheVO, OrcamentoPeriodoVO;

type
  [TEntity]
  [TTable('ORCAMENTO_EMPRESARIAL')]
  TOrcamentoEmpresarialVO = class(TJsonVO)
  private
    FID: Integer;
    FID_ORCAMENTO_PERIODO: Integer;
    FNOME: String;
    FDESCRICAO: String;
    FDATA_INICIAL: TDateTime;
    FNUMERO_PERIODOS: Integer;
    FDATA_BASE: TDateTime;

    FOrcamentoPeriodoNome: String;
    FOrcamentoPeriodoCodigo: String;

    FOrcamentoPeriodoVO: TOrcamentoPeriodoVO;

    FListaOrcamentoDetalheVO: TObjectList<TOrcamentoDetalheVO>;

  public
    constructor Create; overload; override;
    constructor Create(pJsonValue: TJSONValue); overload; override;
    destructor Destroy; override;
    function ToJSON: TJSONValue; override;

    [TId('ID')]
    [TGeneratedValue(sAuto)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property Id: Integer  read FID write FID;

    // Orçamento Período
    [TColumn('ID_ORCAMENTO_PERIODO','Id Orcamento Periodo',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdOrcamentoPeriodo: Integer  read FID_ORCAMENTO_PERIODO write FID_ORCAMENTO_PERIODO;
    [TColumn('ORCAMENTOPERIODO.PERIODO', 'Código Período', 80, [ldGrid, ldLookup, ldComboBox], True, 'ORCAMENTO_PERIODO', 'ID_ORCAMENTO_PERIODO', 'ID')]
    property OrcamentoPeriodoCodigo: String read FOrcamentoPeriodoCodigo write FOrcamentoPeriodoCodigo;
    [TColumn('ORCAMENTOPERIODO.NOME', 'Nome Período', 300, [ldGrid, ldLookup, ldComboBox], True, 'ORCAMENTO_PERIODO', 'ID_ORCAMENTO_PERIODO', 'ID')]
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

    [TAssociation(False, 'ID', 'ID_ORCAMENTO_PERIODO', 'ORCAMENTO_PERIODO')]
    property OrcamentoPeriodoVO: TOrcamentoPeriodoVO read FOrcamentoPeriodoVO write FOrcamentoPeriodoVO;

    [TManyValuedAssociation(True,'ID_ORCAMENTO_EMPRESARIAL','ID')]
    property ListaOrcamentoDetalheVO: TObjectList<TOrcamentoDetalheVO> read FListaOrcamentoDetalheVO write FListaOrcamentoDetalheVO;

  end;

implementation



{ TOrcamentoEmpresarialVO }

constructor TOrcamentoEmpresarialVO.Create;
begin
  inherited;
  ListaOrcamentoDetalheVO := TObjectList<TOrcamentoDetalheVO>.Create;
end;

constructor TOrcamentoEmpresarialVO.Create(pJsonValue: TJSONValue);
var
  Deserializa: TJSONUnMarshal;
begin
  if pJsonValue is TJSONNull then
    Exception.Create('Erro ao criar objeto com um valor nulo.');

  Deserializa := TJSONUnMarshal.Create;
  try
    Self.Free;

    //Lista Orçamento Detalhe
    Deserializa.RegisterReverter(TOrcamentoEmpresarialVO, 'FListaOrcamentoDetalheVO', procedure(Data: TObject; Field: String; Args: TListOfObjects)
    var
      Obj: TObject;
    begin
      if not Assigned(TOrcamentoEmpresarialVO(Data).FListaOrcamentoDetalheVO) then
        TOrcamentoEmpresarialVO(Data).FListaOrcamentoDetalheVO := TObjectList<TOrcamentoDetalheVO>.Create;

      for Obj in Args do
      begin
        TOrcamentoEmpresarialVO(Data).FListaOrcamentoDetalheVO.Add(TOrcamentoDetalheVO(Obj));
      end
    end);

    Self := Deserializa.Unmarshal(pJsonValue) as TOrcamentoEmpresarialVO;
  finally
    Deserializa.Free;
  end;
end;

destructor TOrcamentoEmpresarialVO.Destroy;
begin
  ListaOrcamentoDetalheVO.Free;

  if Assigned(FOrcamentoPeriodoVO) then
    FOrcamentoPeriodoVO.Free;
  inherited;
end;

function TOrcamentoEmpresarialVO.ToJSON: TJSONValue;
var
  Serializa: TJSONMarshal;
begin
  Serializa := TJSONMarshal.Create(TJSONConverter.Create);
  try

    //Lista Orçamento Detalhe
    Serializa.RegisterConverter(TOrcamentoEmpresarialVO, 'FListaOrcamentoDetalheVO', function(Data: TObject; Field: string): TListOfObjects
      var
        I: Integer;
      begin
        if Assigned(TOrcamentoEmpresarialVO(Data).FListaOrcamentoDetalheVO) then
        begin
          SetLength(Result, TOrcamentoEmpresarialVO(Data).FListaOrcamentoDetalheVO.Count);
          for I := 0 to TOrcamentoEmpresarialVO(Data).FListaOrcamentoDetalheVO.Count - 1 do
          begin
            Result[I] := TOrcamentoEmpresarialVO(Data).FListaOrcamentoDetalheVO.Items[I];
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
