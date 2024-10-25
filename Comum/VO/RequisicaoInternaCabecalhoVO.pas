{*******************************************************************************
Title: T2Ti ERP
Description:  VO  relacionado � tabela [REQUISICAO_INTERNA_CABECALHO] 
                                                                                
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
unit RequisicaoInternaCabecalhoVO;

interface

uses
  JsonVO, Atributos, Classes, Constantes, Generics.Collections, DBXJSON, DBXJSONReflect,
  SysUtils, RequisicaoInternaDetalheVO, ColaboradorPessoaVO;

type
  [TEntity]
  [TTable('REQUISICAO_INTERNA_CABECALHO')]
  TRequisicaoInternaCabecalhoVO = class(TJsonVO)
  private
    FID: Integer;
    FID_COLABORADOR: Integer;
    FDATA_REQUISICAO: TDateTime;
    FSITUACAO: String;

    FColaboradorPessoaNome: String;

    FColaboradorVO: TColaboradorVO;

    FListaRequisicaoInterna: TObjectList<TRequisicaoInternaDetalheVO>;

  public
    constructor Create; overload; override;
    constructor Create(pJsonValue: TJSONValue); overload; override;
    destructor Destroy; override;
    function ToJSON: TJSONValue; override;

    [TId('ID')]
    [TGeneratedValue(sAuto)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property Id: Integer  read FID write FID;

    [TColumn('ID_COLABORADOR','Id Requisitante',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdColaborador: Integer  read FID_COLABORADOR write FID_COLABORADOR;
    [TColumn('COLABORADOR.PESSOA.NOME', 'Requisitante', 350, [ldGrid, ldLookup, ldComboBox], True, 'COLABORADOR.PESSOA', 'ID_COLABORADOR', 'ID')]
    property ColaboradorPessoaNome: String read FColaboradorPessoaNome write FColaboradorPessoaNome;

    [TColumn('DATA_REQUISICAO','Data Requisicao',100,[ldGrid, ldLookup, ldCombobox], False)]
    property DataRequisicao: TDateTime  read FDATA_REQUISICAO write FDATA_REQUISICAO;

    [TColumn('SITUACAO','Situacao',100,[ldGrid, ldLookup, ldCombobox], False)]
    property Situacao: String  read FSITUACAO write FSITUACAO;

    [TAssociation(True, 'ID', 'ID_COLABORADOR', 'COLABORADOR')]
    property ColaboradorVO: TColaboradorVO read FColaboradorVO write FColaboradorVO;

    [TManyValuedAssociation(True,'ID_REQ_INTERNA_CABECALHO','ID')]
    property ListaRequisicaoInterna: TObjectList<TRequisicaoInternaDetalheVO> read FListaRequisicaoInterna write FListaRequisicaoInterna;
  end;

implementation

constructor TRequisicaoInternaCabecalhoVO.Create;
begin
  inherited;

  ListaRequisicaoInterna := TObjectList<TRequisicaoInternaDetalheVO>.Create;
end;

constructor TRequisicaoInternaCabecalhoVO.Create(pJsonValue: TJSONValue);
var
  Deserializa: TJSONUnMarshal;
begin
  if pJsonValue is TJSONNull then
    Exception.Create('Erro ao criar objeto com um valor nulo.');

  Deserializa := TJSONUnMarshal.Create;
  try
    Self.Free;

    Deserializa.RegisterReverter(TRequisicaoInternaCabecalhoVO, 'FListaRequisicaoInterna', procedure(Data: TObject; Field: String; Args: TListOfObjects)
    var
      Obj: TObject;
    begin
  	  if not Assigned(TRequisicaoInternaCabecalhoVO(Data).FListaRequisicaoInterna) then
        TRequisicaoInternaCabecalhoVO(Data).FListaRequisicaoInterna := TObjectList<TRequisicaoInternaDetalheVO>.Create;

      for Obj in Args do
      begin
        TRequisicaoInternaCabecalhoVO(Data).FListaRequisicaoInterna.Add(TRequisicaoInternaDetalheVO(Obj));
      end
    end);

    Self := Deserializa.Unmarshal(pJsonValue) as TRequisicaoInternaCabecalhoVO;
  finally
    Deserializa.Free;
  end;
end;

destructor TRequisicaoInternaCabecalhoVO.Destroy;
begin
  ListaRequisicaoInterna.Free;
  if Assigned(FColaboradorVO) then
    FColaboradorVO.Free;
  inherited;
end;

function TRequisicaoInternaCabecalhoVO.ToJSON: TJSONValue;
var
  Serializa: TJSONMarshal;
begin
  Serializa := TJSONMarshal.Create(TJSONConverter.Create);
  try
    Serializa.RegisterConverter(TRequisicaoInternaCabecalhoVO, 'FListaRequisicaoInterna', function(Data: TObject; Field: string): TListOfObjects
      var
        I: Integer;
      begin
        if Assigned(TRequisicaoInternaCabecalhoVO(Data).FListaRequisicaoInterna) then
        begin
          SetLength(Result, TRequisicaoInternaCabecalhoVO(Data).FListaRequisicaoInterna.Count);
          for I := 0 to TRequisicaoInternaCabecalhoVO(Data).FListaRequisicaoInterna.Count - 1 do
          begin
            Result[I] := TRequisicaoInternaCabecalhoVO(Data).FListaRequisicaoInterna.Items[I];
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
