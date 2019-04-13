{*******************************************************************************
Title: T2Ti ERP                                                                 
Description:  VO  relacionado à tabela [PONTO_BANCO_HORAS] 
                                                                                
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

       t2ti.com@gmail.com
@author Albert Eije
@version 1.0
*******************************************************************************}
unit PontoBancoHorasVO;

interface

uses
  JsonVO, Atributos, Classes, Constantes, Generics.Collections, DBXJSON, DBXJSONReflect,
  SysUtils, ColaboradorVO, PontoBancoHorasUtilizacaoVO;

type
  [TEntity]
  [TTable('PONTO_BANCO_HORAS')]
  TPontoBancoHorasVO = class(TJsonVO)
  private
    FID: Integer;
    FID_COLABORADOR: Integer;
    FDATA_TRABALHO: TDateTime;
    FQUANTIDADE: String;
    FSITUACAO: String;

    FColaboradorNome: String;

    FColaboradorVO: TColaboradorVO;

    FListaPontoBancoHorasUtilizacaoVO: TObjectList<TPontoBancoHorasUtilizacaoVO>;

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
    [TColumn('COLABORADOR.NOME', 'Colaborador Nome', 300, [ldGrid, ldLookup], True)]
    property ColaboradorNome: String read FColaboradorNome write FColaboradorNome;

    [TColumn('DATA_TRABALHO','Data Trabalho',80,[ldGrid, ldLookup, ldCombobox], False)]
    property DataTrabalho: TDateTime  read FDATA_TRABALHO write FDATA_TRABALHO;
    [TColumn('QUANTIDADE','Quantidade',64,[ldGrid, ldLookup, ldCombobox], False)]
    property Quantidade: String  read FQUANTIDADE write FQUANTIDADE;
    [TColumn('SITUACAO','Situacao',8,[ldGrid, ldLookup, ldCombobox], False)]
    property Situacao: String  read FSITUACAO write FSITUACAO;

    [TAssociation(True, 'ID', 'ID_COLABORADOR')]
    property ColaboradorVO: TColaboradorVO read FColaboradorVO write FColaboradorVO;

    [TManyValuedAssociation(False,'ID_PONTO_BANCO_HORAS','ID')]
    property ListaPontoBancoHorasUtilizacaoVO: TObjectList<TPontoBancoHorasUtilizacaoVO> read FListaPontoBancoHorasUtilizacaoVO write FListaPontoBancoHorasUtilizacaoVO;
  end;

implementation

constructor TPontoBancoHorasVO.Create;
begin
  inherited;
  ListaPontoBancoHorasUtilizacaoVO := TObjectList<TPontoBancoHorasUtilizacaoVO>.Create;
end;

constructor TPontoBancoHorasVO.Create(pJsonValue: TJSONValue);
var
  Deserializa: TJSONUnMarshal;
begin
  if pJsonValue is TJSONNull then
    Exception.Create('Erro ao criar objeto com um valor nulo.');

  Deserializa := TJSONUnMarshal.Create;
  try
    Self.Free;

    //Lista Utilização
    Deserializa.RegisterReverter(TPontoBancoHorasVO, 'FListaPontoBancoHorasUtilizacaoVO', procedure(Data: TObject; Field: String; Args: TListOfObjects)
    var
      Obj: TObject;
    begin
  	  if not Assigned(TPontoBancoHorasVO(Data).FListaPontoBancoHorasUtilizacaoVO) then
        TPontoBancoHorasVO(Data).FListaPontoBancoHorasUtilizacaoVO := TObjectList<TPontoBancoHorasUtilizacaoVO>.Create;

      for Obj in Args do
      begin
        TPontoBancoHorasVO(Data).FListaPontoBancoHorasUtilizacaoVO.Add(TPontoBancoHorasUtilizacaoVO(Obj));
      end
    end);

    Self := Deserializa.Unmarshal(pJsonValue) as TPontoBancoHorasVO;
  finally
    Deserializa.Free;
  end;
end;

destructor TPontoBancoHorasVO.Destroy;
begin
  ListaPontoBancoHorasUtilizacaoVO.Free;

  if Assigned(FColaboradorVO) then
    FColaboradorVO.Free;

  inherited;
end;

function TPontoBancoHorasVO.ToJSON: TJSONValue;
var
  Serializa: TJSONMarshal;
begin
  Serializa := TJSONMarshal.Create(TJSONConverter.Create);
  try
    //Lista Utilização
    Serializa.RegisterConverter(TPontoBancoHorasVO, 'FListaPontoBancoHorasUtilizacaoVO', function(Data: TObject; Field: string): TListOfObjects
      var
        I: Integer;
      begin
        if Assigned(TPontoBancoHorasVO(Data).FListaPontoBancoHorasUtilizacaoVO) then
        begin
          SetLength(Result, TPontoBancoHorasVO(Data).FListaPontoBancoHorasUtilizacaoVO.Count);
          for I := 0 to TPontoBancoHorasVO(Data).FListaPontoBancoHorasUtilizacaoVO.Count - 1 do
          begin
            Result[I] := TPontoBancoHorasVO(Data).FListaPontoBancoHorasUtilizacaoVO.Items[I];
          end;
        end;
      end);

    // Campos Transientes
    if Assigned(Self.FColaboradorVO) then
      Self.ColaboradorNome := Self.FColaboradorVO.PessoaVO.Nome;

  Exit(serializa.Marshal(Self));
  finally
    Serializa.Free;
  end;
end;

end.
