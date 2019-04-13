{*******************************************************************************
Title: T2Ti ERP                                                                 
Description:  VO  relacionado à tabela [COMPRA_REQUISICAO] 
                                                                                
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
unit CompraRequisicaoVO;

interface

uses
  JsonVO, Atributos, Classes, Constantes, Generics.Collections, DBXJSON, DBXJSONReflect,
  SysUtils, ColaboradorPessoaVO, CompraTipoRequisicaoVO, CompraRequisicaoDetalheVO;

type
  [TEntity]
  [TTable('COMPRA_REQUISICAO')]
  TCompraRequisicaoVO = class(TJsonVO)
  private
    FID: Integer;
    FID_COMPRA_TIPO_REQUISICAO: Integer;
    FID_COLABORADOR: Integer;
    FDATA_REQUISICAO: TDateTime;

    FColaboradorPessoaNome: String;
    FCompraTipoRequisicaoNome: String;

    FColaboradorVO: TColaboradorVO;
    FCompraTipoRequisicaoVO: TCompraTipoRequisicaoVO;

    FListaCompraRequisicaoDetalheVO: TObjectList<TCompraRequisicaoDetalheVO>;

  public 
    constructor Create; overload; override;
    constructor Create(pJsonValue: TJSONValue); overload; override;
    destructor Destroy; override;
    function ToJSON: TJSONValue; override;

    [TId('ID')]
    [TGeneratedValue(sAuto)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property Id: Integer  read FID write FID;

    [TColumn('ID_COMPRA_TIPO_REQUISICAO','Id Tipo Requisicao',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdCompraTipoRequisicao: Integer  read FID_COMPRA_TIPO_REQUISICAO write FID_COMPRA_TIPO_REQUISICAO;
    [TColumn('COMPRA_TIPO_REQUISICAO.NOME', 'Tipo Requisição', 250, [ldGrid, ldLookup, ldComboBox], True, 'COMPRA_TIPO_REQUISICAO', 'ID_COMPRA_TIPO_REQUISICAO', 'ID')]
    property CompraTipoRequisicaoNome: String read FCompraTipoRequisicaoNome write FCompraTipoRequisicaoNome;

    [TColumn('ID_COLABORADOR','Id Colaborador',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdColaborador: Integer  read FID_COLABORADOR write FID_COLABORADOR;
    [TColumn('COLABORADOR.PESSOA.NOME', 'Requisitante', 250, [ldGrid, ldLookup, ldComboBox], True, 'COLABORADOR.PESSOA', 'ID_COLABORADOR', 'ID')]
    property ColaboradorPessoaNome: String read FColaboradorPessoaNome write FColaboradorPessoaNome;

    [TColumn('DATA_REQUISICAO','Data Requisicao',80,[ldGrid, ldLookup, ldCombobox], False)]
    property DataRequisicao: TDateTime  read FDATA_REQUISICAO write FDATA_REQUISICAO;

    [TAssociation(False, 'ID', 'ID_COMPRA_TIPO_REQUISICAO', 'COMPRA_TIPO_REQUISICAO')]
    property CompraTipoRequisicaoVO: TCompraTipoRequisicaoVO read FCompraTipoRequisicaoVO write FCompraTipoRequisicaoVO;

    [TAssociation(True, 'ID', 'ID_COLABORADOR', 'COLABORADOR')]
    property ColaboradorVO: TColaboradorVO read FColaboradorVO write FColaboradorVO;

    [TManyValuedAssociation(True,'ID_COMPRA_REQUISICAO','ID')]
    property ListaCompraRequisicaoDetalheVO: TObjectList<TCompraRequisicaoDetalheVO> read FListaCompraRequisicaoDetalheVO write FListaCompraRequisicaoDetalheVO;
  end;

implementation

constructor TCompraRequisicaoVO.Create;
begin
  inherited;
  ListaCompraRequisicaoDetalheVO := TObjectList<TCompraRequisicaoDetalheVO>.Create;
end;

constructor TCompraRequisicaoVO.Create(pJsonValue: TJSONValue);
var
  Deserializa: TJSONUnMarshal;
begin
  if pJsonValue is TJSONNull then
    Exception.Create('Erro ao criar objeto com um valor nulo.');

  Deserializa := TJSONUnMarshal.Create;
  try
    Self.Free;

    //Lista requisição detalhe
    Deserializa.RegisterReverter(TCompraRequisicaoVO, 'FListaCompraRequisicaoDetalheVO', procedure(Data: TObject; Field: String; Args: TListOfObjects)
    var
      Obj: TObject;
    begin
      if not Assigned(TCompraRequisicaoVO(Data).FListaCompraRequisicaoDetalheVO) then
        TCompraRequisicaoVO(Data).FListaCompraRequisicaoDetalheVO := TObjectList<TCompraRequisicaoDetalheVO>.Create;

      for Obj in Args do
      begin
        TCompraRequisicaoVO(Data).FListaCompraRequisicaoDetalheVO.Add(TCompraRequisicaoDetalheVO(Obj));
      end
    end);

    Self := Deserializa.Unmarshal(pJsonValue) as TCompraRequisicaoVO;
  finally
    Deserializa.Free;
  end;
end;

destructor TCompraRequisicaoVO.Destroy;
begin
  ListaCompraRequisicaoDetalheVO.Free;

  if Assigned(FCompraTipoRequisicaoVO) then
    FCompraTipoRequisicaoVO.Free;
  if Assigned(FColaboradorVO) then
    FColaboradorVO.Free;
  inherited;
end;

function TCompraRequisicaoVO.ToJSON: TJSONValue;
var
  Serializa: TJSONMarshal;
begin
  Serializa := TJSONMarshal.Create(TJSONConverter.Create);
  try
    //Lista requisição detalhe
    Serializa.RegisterConverter(TCompraRequisicaoVO, 'FListaCompraRequisicaoDetalheVO', function(Data: TObject; Field: string): TListOfObjects
      var
        I: Integer;
      begin
        if Assigned(TCompraRequisicaoVO(Data).FListaCompraRequisicaoDetalheVO) then
        begin
          SetLength(Result, TCompraRequisicaoVO(Data).FListaCompraRequisicaoDetalheVO.Count);
          for I := 0 to TCompraRequisicaoVO(Data).FListaCompraRequisicaoDetalheVO.Count - 1 do
          begin
            Result[I] := TCompraRequisicaoVO(Data).FListaCompraRequisicaoDetalheVO.Items[I];
          end;
        end;
      end);

    // Campos Transientes
     if Assigned(Self.CompraTipoRequisicaoVO) then
       Self.CompraTipoRequisicaoNome := Self.CompraTipoRequisicaoVO.Nome;
     if Assigned(Self.ColaboradorVO) then
       Self.ColaboradorPessoaNome := Self.ColaboradorVO.PessoaVO.Nome;

  Exit(serializa.Marshal(Self));
  finally
    Serializa.Free;
  end;
end;

end.
