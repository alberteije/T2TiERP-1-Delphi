{*******************************************************************************
Title: T2Ti ERP                                                                 
Description:  VO  relacionado à tabela [TRIBUT_CONFIGURA_OF_GT] 
                                                                                
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
unit TributConfiguraOfGtVO;

interface

uses
  JsonVO, Atributos, Classes, Constantes, Generics.Collections, DBXJSON, DBXJSONReflect,
  SysUtils, TributGrupoTributarioVO, TributOperacaoFiscalVO, TributPisCodApuracaoVO,
  TributCofinsCodApuracaoVO, TributIpiDipiVO, TributIcmsUfVO;

type
  [TEntity]
  [TTable('TRIBUT_CONFIGURA_OF_GT')]
  TTributConfiguraOfGtVO = class(TJsonVO)
  private
    FID: Integer;
    FID_TRIBUT_GRUPO_TRIBUTARIO: Integer;
    FID_TRIBUT_OPERACAO_FISCAL: Integer;

    FTributGrupoTributarioDescricao: String;
    FTributOperacaoFiscalDescricao: String;

    FTributGrupoTributarioVO: TTributGrupoTributarioVO;
    FTributOperacaoFiscalVO: TTributOperacaoFiscalVO;

    FTributPisCodApuracaoVO: TTributPisCodApuracaoVO; //0:1
    FTributCofinsCodApuracaoVO: TTributCofinsCodApuracaoVO; //0:1
    FTributIpiDipiVO: TTributIpiDipiVO; //0:1

    FListaTributIcmsUfVO: TObjectList<TTributIcmsUfVO>; //0:N

  public
    constructor Create; overload; override;
    constructor Create(pJsonValue: TJSONValue); overload; override;
    destructor Destroy; override;
    function ToJSON: TJSONValue; override;

    [TId('ID')]
    [TGeneratedValue(sAuto)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property Id: Integer  read FID write FID;

    [TColumn('ID_TRIBUT_OPERACAO_FISCAL','Id Tribut Operacao Fiscal',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdTributOperacaoFiscal: Integer  read FID_TRIBUT_OPERACAO_FISCAL write FID_TRIBUT_OPERACAO_FISCAL;
    [TColumn('TRIBUT_OPERACAO_FISCAL.DESCRICAO', 'Descrição Operação Fiscal', 400, [ldGrid, ldLookup, ldComboBox], True, 'TRIBUT_OPERACAO_FISCAL', 'ID_TRIBUT_OPERACAO_FISCAL', 'ID')]
    property TributOperacaoFiscalDescricao: String read FTributOperacaoFiscalDescricao write FTributOperacaoFiscalDescricao;

    [TColumn('ID_TRIBUT_GRUPO_TRIBUTARIO','Id Tribut Grupo Tributario',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdTributGrupoTributario: Integer  read FID_TRIBUT_GRUPO_TRIBUTARIO write FID_TRIBUT_GRUPO_TRIBUTARIO;
    [TColumn('TRIBUT_GRUPO_TRIBUTARIO.DESCRICAO', 'Descrição Grupo Tributário', 400, [ldGrid, ldLookup, ldComboBox], True, 'TRIBUT_GRUPO_TRIBUTARIO', 'ID_TRIBUT_GRUPO_TRIBUTARIO', 'ID')]
    property TributGrupoTributarioDescricao: String read FTributGrupoTributarioDescricao write FTributGrupoTributarioDescricao;

    [TAssociation(False,'ID','ID_TRIBUT_OPERACAO_FISCAL','TRIBUT_OPERACAO_FISCAL')]
    property TributOperacaoFiscalVO: TTributOperacaoFiscalVO read FTributOperacaoFiscalVO write FTributOperacaoFiscalVO;

    [TAssociation(False,'ID','ID_TRIBUT_GRUPO_TRIBUTARIO','TRIBUT_GRUPO_TRIBUTARIO')]
    property TributGrupoTributarioVO: TTributGrupoTributarioVO read FTributGrupoTributarioVO write FTributGrupoTributarioVO;

    [TAssociation(True, 'ID_TRIBUT_CONFIGURA_OF_GT','ID')]
    property TributPisCodApuracaoVO: TTributPisCodApuracaoVO read FTributPisCodApuracaoVO write FTributPisCodApuracaoVO;

    [TAssociation(True, 'ID_TRIBUT_CONFIGURA_OF_GT','ID')]
    property TributCofinsCodApuracaoVO: TTributCofinsCodApuracaoVO read FTributCofinsCodApuracaoVO write FTributCofinsCodApuracaoVO;

    [TAssociation(True, 'ID_TRIBUT_CONFIGURA_OF_GT','ID')]
    property TributIpiDipiVO: TTributIpiDipiVO read FTributIpiDipiVO write FTributIpiDipiVO;

    [TManyValuedAssociation(False, 'ID_TRIBUT_CONFIGURA_OF_GT','ID')]
    property ListaTributIcmsUfVO: TObjectList<TTributIcmsUfVO>read FListaTributIcmsUfVO write FListaTributIcmsUfVO;

  end;

implementation

constructor TTributConfiguraOfGtVO.Create;
begin
  inherited;
  FListaTributIcmsUfVO := TObjectList<TTributIcmsUfVO>.Create; //0:N
end;

constructor TTributConfiguraOfGtVO.Create(pJsonValue: TJSONValue);
var
  Deserializa: TJSONUnMarshal;
begin
  if pJsonValue is TJSONNull then
    Exception.Create('Erro ao criar objeto com um valor nulo.');

  Deserializa := TJSONUnMarshal.Create;
  try
    Self.Free;

    //Lista Icms Uf
    Deserializa.RegisterReverter(TTributConfiguraOfGtVO, 'FListaTributIcmsUfVO', procedure(Data: TObject; Field: String; Args: TListOfObjects)
    var
      Obj: TObject;
    begin
      if not Assigned(TTributConfiguraOfGtVO(Data).FListaTributIcmsUfVO) then
        TTributConfiguraOfGtVO(Data).FListaTributIcmsUfVO := TObjectList<TTributIcmsUfVO>.Create;

      for Obj in Args do
      begin
        TTributConfiguraOfGtVO(Data).FListaTributIcmsUfVO.Add(TTributIcmsUfVO(Obj));
      end
    end);

    Self := Deserializa.Unmarshal(pJsonValue) as TTributConfiguraOfGtVO;
  finally
    Deserializa.Free;
  end;
end;

destructor TTributConfiguraOfGtVO.Destroy;
begin
  FListaTributIcmsUfVO.Free;

  if Assigned(FTributOperacaoFiscalVO) then
    FTributOperacaoFiscalVO.Free;
  if Assigned(FTributGrupoTributarioVO) then
    FTributGrupoTributarioVO.Free;
  if Assigned(FTributPisCodApuracaoVO) then
    FTributPisCodApuracaoVO.Free;
  if Assigned(FTributCofinsCodApuracaoVO) then
    FTributCofinsCodApuracaoVO.Free;
  if Assigned(FTributIpiDipiVO) then
    FTributIpiDipiVO.Free;
  inherited;
end;

function TTributConfiguraOfGtVO.ToJSON: TJSONValue;
var
  Serializa: TJSONMarshal;
begin
  Serializa := TJSONMarshal.Create(TJSONConverter.Create);
  try

    //Lista Icms Uf
    Serializa.RegisterConverter(TTributConfiguraOfGtVO, 'FListaTributIcmsUfVO', function(Data: TObject; Field: string): TListOfObjects
      var
        I: Integer;
      begin
        if Assigned(TTributConfiguraOfGtVO(Data).FListaTributIcmsUfVO) then
        begin
          SetLength(Result, TTributConfiguraOfGtVO(Data).FListaTributIcmsUfVO.Count);
          for I := 0 to TTributConfiguraOfGtVO(Data).FListaTributIcmsUfVO.Count - 1 do
          begin
            Result[I] := TTributConfiguraOfGtVO(Data).FListaTributIcmsUfVO.Items[I];
          end;
        end;
      end);

    if Assigned(Self.TributOperacaoFiscalVO) then
      Self.TributOperacaoFiscalDescricao := Self.TributOperacaoFiscalVO.Descricao;
    if Assigned(Self.TributGrupoTributarioVO) then
      Self.TributGrupoTributarioDescricao := Self.TributGrupoTributarioVO.Descricao;

    Exit(serializa.Marshal(Self));
  finally
    Serializa.Free;
  end;
end;


end.
