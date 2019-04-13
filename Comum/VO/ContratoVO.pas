{*******************************************************************************
Title: T2Ti ERP                                                                 
Description:  VO  relacionado à tabela [CONTRATO] 
                                                                                
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
unit ContratoVO;

interface

uses
  JsonVO, Atributos, Classes, Constantes, Generics.Collections, DBXJSON, DBXJSONReflect,
  SysUtils, ContratoHistFaturamentoVO, ContratoHistoricoReajusteVO, ContratoPrevFaturamentoVO,
  ContabilContaVO, TipoContratoVO, ContratoSolicitacaoServicoVO;

type
  [TEntity]
  [TTable('CONTRATO')]
  TContratoVO = class(TJsonVO)
  private
    FID: Integer;
    FID_CONTABIL_CONTA: Integer;
    FID_TIPO_CONTRATO: Integer;
    FID_SOLICITACAO_SERVICO: Integer;
    FNUMERO: String;
    FNOME: String;
    FDESCRICAO: String;
    FDATA_CADASTRO: TDateTime;
    FDATA_INICIO_VIGENCIA: TDateTime;
    FDATA_FIM_VIGENCIA: TDateTime;
    FDIA_FATURAMENTO: String;
    FVALOR: Extended;
    FQUANTIDADE_PARCELAS: Integer;
    FINTERVALO_ENTRE_PARCELAS: Integer;
    FOBSERVACAO: String;

    FArquivo: String;
    FTipoArquivo: String;

    FContabilContaClassificacao: String;
    FTipoContratoNome: String;
    FContratoSolicitacaoServicoDescricao: String;

    FContabilContaVO: TContabilContaVO;
    FTipoContratoVO: TTipoContratoVO;
    FContratoSolicitacaoServicoVO: TContratoSolicitacaoServicoVO;

    FListaContratoHistFaturamentoVO: TObjectList<TContratoHistFaturamentoVO>;
    FListaContratoHistoricoReajusteVO: TObjectList<TContratoHistoricoReajusteVO>;
    FListaContratoPrevFaturamentoVO: TObjectList<TContratoPrevFaturamentoVO>;

  public 
    constructor Create; overload; override;
    constructor Create(pJsonValue: TJSONValue); overload; override;
    destructor Destroy; override;
    function ToJSON: TJSONValue; override;

    [TId('ID')]
    [TGeneratedValue(sAuto)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property Id: Integer  read FID write FID;

    [TColumn('ID_CONTABIL_CONTA','Id Contabil Conta',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdContabilConta: Integer  read FID_CONTABIL_CONTA write FID_CONTABIL_CONTA;
    [TColumn('CONTABIL_CONTA.CLASSIFICACAO', 'Conta Contábil', 150, [ldGrid], True, 'CONTABIL_CONTA', 'ID_CONTABIL_CONTA', 'ID')]
    property ContabilContaClassificacao: String read FContabilContaClassificacao write FContabilContaClassificacao;

    [TColumn('ID_TIPO_CONTRATO','Id Tipo Contrato',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdTipoContrato: Integer  read FID_TIPO_CONTRATO write FID_TIPO_CONTRATO;
    [TColumn('TIPO_CONTRATO.NOME', 'Tipo Contrato', 200, [ldGrid], True, 'TIPO_CONTRATO', 'ID_TIPO_CONTRATO', 'ID')]
    property TipoContratoNome: String read FTipoContratoNome write FTipoContratoNome;

    [TColumn('ID_SOLICITACAO_SERVICO','Id Solicitação Serviço',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdSolicitacaoServico: Integer  read FID_SOLICITACAO_SERVICO write FID_SOLICITACAO_SERVICO;
    [TColumn('CONTRATO_SOLICITACAO_SERVICO.DESCRICAO', 'Descrição da Solicitação', 250, [ldGrid], True, 'CONTRATO_SOLICITACAO_SERVICO', 'ID_SOLICITACAO_SERVICO', 'ID')]
    property ContratoSolicitacaoServicoDescricao: String read FContratoSolicitacaoServicoDescricao write FContratoSolicitacaoServicoDescricao;

    [TColumn('NUMERO','Numero',400,[ldGrid, ldLookup, ldCombobox], False)]
    property Numero: String  read FNUMERO write FNUMERO;
    [TColumn('NOME','Nome',450,[ldGrid, ldLookup, ldCombobox], False)]
    property Nome: String  read FNOME write FNOME;
    [TColumn('DESCRICAO','Descricao',450,[ldGrid, ldLookup, ldCombobox], False)]
    property Descricao: String  read FDESCRICAO write FDESCRICAO;
    [TColumn('DATA_CADASTRO','Data Cadastro',80,[ldGrid, ldLookup, ldCombobox], False)]
    property DataCadastro: TDateTime  read FDATA_CADASTRO write FDATA_CADASTRO;
    [TColumn('DATA_INICIO_VIGENCIA','Data Inicio Vigencia',80,[ldGrid, ldLookup, ldCombobox], False)]
    property DataInicioVigencia: TDateTime  read FDATA_INICIO_VIGENCIA write FDATA_INICIO_VIGENCIA;
    [TColumn('DATA_FIM_VIGENCIA','Data Fim Vigencia',80,[ldGrid, ldLookup, ldCombobox], False)]
    property DataFimVigencia: TDateTime  read FDATA_FIM_VIGENCIA write FDATA_FIM_VIGENCIA;
    [TColumn('DIA_FATURAMENTO','Dia Faturamento',16,[ldGrid, ldLookup, ldCombobox], False)]
    property DiaFaturamento: String  read FDIA_FATURAMENTO write FDIA_FATURAMENTO;
    [TColumn('VALOR','Valor',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property Valor: Extended  read FVALOR write FVALOR;
    [TColumn('QUANTIDADE_PARCELAS','Quantidade Parcelas',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property QuantidadeParcelas: Integer  read FQUANTIDADE_PARCELAS write FQUANTIDADE_PARCELAS;
    [TColumn('INTERVALO_ENTRE_PARCELAS','Intervalo Entre Parcelas',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IntervaloEntreParcelas: Integer  read FINTERVALO_ENTRE_PARCELAS write FINTERVALO_ENTRE_PARCELAS;
    [TColumn('OBSERVACAO','Observacao',450,[ldGrid, ldLookup, ldCombobox], False)]
    property Observacao: String  read FOBSERVACAO write FOBSERVACAO;

    [TColumn('ARQUIVO', 'Arquivo', 80, [], True)]
    property Arquivo: String read FArquivo write FArquivo;
    [TColumn('TIPO_ARQUIVO', 'Tipo Arquivo', 80, [], True)]
    property TipoArquivo: String read FTipoArquivo write FTipoArquivo;

    [TAssociation(False, 'ID', 'ID_CONTABIL_CONTA', 'CONTABIL_CONTA')]
    property ContabilContaVO: TContabilContaVO read FContabilContaVO write FContabilContaVO;

    [TAssociation(False, 'ID', 'ID_TIPO_CONTRATO', 'TIPO_CONTRATO')]
    property TipoContratoVO: TTipoContratoVO read FTipoContratoVO write FTipoContratoVO;

    [TAssociation(False, 'ID', 'ID_SOLICITACAO_SERVICO', 'CONTRATO_SOLICITACAO_SERVICO')]
    property ContratoSolicitacaoServicoVO: TContratoSolicitacaoServicoVO read FContratoSolicitacaoServicoVO write FContratoSolicitacaoServicoVO;

    [TManyValuedAssociation(False,'ID_CONTRATO','ID')]
    property ListaContratoHistFaturamentoVO: TObjectList<TContratoHistFaturamentoVO> read FListaContratoHistFaturamentoVO write FListaContratoHistFaturamentoVO;

    [TManyValuedAssociation(False,'ID_CONTRATO','ID')]
    property ListaContratoHistoricoReajusteVO: TObjectList<TContratoHistoricoReajusteVO> read FListaContratoHistoricoReajusteVO write FListaContratoHistoricoReajusteVO;

    [TManyValuedAssociation(False,'ID_CONTRATO','ID')]
    property ListaContratoPrevFaturamentoVO: TObjectList<TContratoPrevFaturamentoVO> read FListaContratoPrevFaturamentoVO write FListaContratoPrevFaturamentoVO;

  end;

implementation

constructor TContratoVO.Create;
begin
  if Assigned(FContabilContaVO) then
    FContabilContaVO.Free;
  if Assigned(FTipoContratoVO) then
    FTipoContratoVO.Free;
  if Assigned(FContratoSolicitacaoServicoVO) then
    FContratoSolicitacaoServicoVO.Free;
  ListaContratoHistFaturamentoVO := TObjectList<TContratoHistFaturamentoVO>.Create;
  ListaContratoHistoricoReajusteVO := TObjectList<TContratoHistoricoReajusteVO>.Create;
  ListaContratoPrevFaturamentoVO := TObjectList<TContratoPrevFaturamentoVO>.Create;
  inherited;
end;

constructor TContratoVO.Create(pJsonValue: TJSONValue);
var
  Deserializa: TJSONUnMarshal;
begin
  if pJsonValue is TJSONNull then
    Exception.Create('Erro ao criar objeto com um valor nulo.');

  Deserializa := TJSONUnMarshal.Create;
  try
    Self.Free;

    //Historico Faturamento
    Deserializa.RegisterReverter(TContratoVO, 'FListaContratoHistFaturamentoVO', procedure(Data: TObject; Field: String; Args: TListOfObjects)
    var
      Obj: TObject;
    begin
  	  if not Assigned(TContratoVO(Data).FListaContratoHistFaturamentoVO) then
        TContratoVO(Data).FListaContratoHistFaturamentoVO := TObjectList<TContratoHistFaturamentoVO>.Create;

      for Obj in Args do
      begin
        TContratoVO(Data).FListaContratoHistFaturamentoVO.Add(TContratoHistFaturamentoVO(Obj));
      end
    end);

    //Historico Reajuste
    Deserializa.RegisterReverter(TContratoVO, 'FListaContratoHistoricoReajusteVO', procedure(Data: TObject; Field: String; Args: TListOfObjects)
    var
      Obj: TObject;
    begin
  	  if not Assigned(TContratoVO(Data).FListaContratoHistoricoReajusteVO) then
        TContratoVO(Data).FListaContratoHistoricoReajusteVO := TObjectList<TContratoHistoricoReajusteVO>.Create;

      for Obj in Args do
      begin
        TContratoVO(Data).FListaContratoHistoricoReajusteVO.Add(TContratoHistoricoReajusteVO(Obj));
      end
    end);

    //Previsao Faturamento
    Deserializa.RegisterReverter(TContratoVO, 'FListaContratoPrevFaturamentoVO', procedure(Data: TObject; Field: String; Args: TListOfObjects)
    var
      Obj: TObject;
    begin
  	  if not Assigned(TContratoVO(Data).FListaContratoPrevFaturamentoVO) then
        TContratoVO(Data).FListaContratoPrevFaturamentoVO := TObjectList<TContratoPrevFaturamentoVO>.Create;

      for Obj in Args do
      begin
        TContratoVO(Data).FListaContratoPrevFaturamentoVO.Add(TContratoPrevFaturamentoVO(Obj));
      end
    end);

    Self := Deserializa.Unmarshal(pJsonValue) as TContratoVO;
  finally
    Deserializa.Free;
  end;
end;

destructor TContratoVO.Destroy;
begin
  ListaContratoHistFaturamentoVO.Free;
  ListaContratoHistoricoReajusteVO.Free;
  ListaContratoPrevFaturamentoVO.Free;

  inherited;
end;

function TContratoVO.ToJSON: TJSONValue;
var
  Serializa: TJSONMarshal;
begin
  Serializa := TJSONMarshal.Create(TJSONConverter.Create);
  try
    //Historico Faturamento
    Serializa.RegisterConverter(TContratoVO, 'FListaContratoHistFaturamentoVO', function(Data: TObject; Field: string): TListOfObjects
      var
        I: Integer;
      begin
        if Assigned(TContratoVO(Data).FListaContratoHistFaturamentoVO) then
        begin
          SetLength(Result, TContratoVO(Data).FListaContratoHistFaturamentoVO.Count);
          for I := 0 to TContratoVO(Data).FListaContratoHistFaturamentoVO.Count - 1 do
          begin
            Result[I] := TContratoVO(Data).FListaContratoHistFaturamentoVO.Items[I];
          end;
        end;
      end);

    //Historico Reajuste
    Serializa.RegisterConverter(TContratoVO, 'FListaContratoHistoricoReajusteVO', function(Data: TObject; Field: string): TListOfObjects
      var
        I: Integer;
      begin
        if Assigned(TContratoVO(Data).FListaContratoHistoricoReajusteVO) then
        begin
          SetLength(Result, TContratoVO(Data).FListaContratoHistoricoReajusteVO.Count);
          for I := 0 to TContratoVO(Data).FListaContratoHistoricoReajusteVO.Count - 1 do
          begin
            Result[I] := TContratoVO(Data).FListaContratoHistoricoReajusteVO.Items[I];
          end;
        end;
      end);

    //Previsao Faturamento
    Serializa.RegisterConverter(TContratoVO, 'FListaContratoPrevFaturamentoVO', function(Data: TObject; Field: string): TListOfObjects
      var
        I: Integer;
      begin
        if Assigned(TContratoVO(Data).FListaContratoPrevFaturamentoVO) then
        begin
          SetLength(Result, TContratoVO(Data).FListaContratoPrevFaturamentoVO.Count);
          for I := 0 to TContratoVO(Data).FListaContratoPrevFaturamentoVO.Count - 1 do
          begin
            Result[I] := TContratoVO(Data).FListaContratoPrevFaturamentoVO.Items[I];
          end;
        end;
      end);

    if Assigned(Self.ContabilContaVO) then
      Self.ContabilContaClassificacao := Self.ContabilContaVO.Classificacao;
    if Assigned(Self.TipoContratoVO) then
      Self.TipoContratoNome := Self.TipoContratoVO.Nome;
    if Assigned(Self.ContratoSolicitacaoServicoVO) then
      Self.ContratoSolicitacaoServicoDescricao := Self.ContratoSolicitacaoServicoVO.Descricao;

    Exit(serializa.Marshal(Self));
  finally
    Serializa.Free;
  end;
end;

end.
