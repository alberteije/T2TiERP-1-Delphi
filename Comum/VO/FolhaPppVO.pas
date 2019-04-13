{*******************************************************************************
Title: T2Ti ERP                                                                 
Description:  VO  relacionado à tabela [FOLHA_PPP] 
                                                                                
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
unit FolhaPppVO;

interface

uses
  JsonVO, Atributos, Classes, Constantes, Generics.Collections, DBXJSON, DBXJSONReflect,
  SysUtils, ColaboradorPessoaVO, FolhaPppCatVO, FolhaPppAtividadeVO, FolhaPppFatorRiscoVO,
  FolhaPppExameMedicoVO;

type
  [TEntity]
  [TTable('FOLHA_PPP')]
  TFolhaPppVO = class(TJsonVO)
  private
    FID: Integer;
    FID_COLABORADOR: Integer;
    FColaboradorNome: String;
    FOBSERVACAO: String;

    FColaboradorVO: TColaboradorVO;

    FListaFolhaPppCatVO: TObjectList<TFolhaPppCatVO>;
    FListaFolhaPppAtividadeVO: TObjectList<TFolhaPppAtividadeVO>;
    FListaFolhaPppFatorRiscoVO: TObjectList<TFolhaPppFatorRiscoVO>;
    FListaFolhaPppExameMedicoVO: TObjectList<TFolhaPppExameMedicoVO>;

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

    [TColumn('OBSERVACAO','Observacao',450,[ldGrid, ldLookup, ldCombobox], False)]
    property Observacao: String  read FOBSERVACAO write FOBSERVACAO;

    [TAssociation(True, 'ID', 'ID_COLABORADOR')]
    property ColaboradorVO: TColaboradorVO read FColaboradorVO write FColaboradorVO;

    [TManyValuedAssociation(False,'ID_FOLHA_PPP','ID')]
    property ListaFolhaPppCatVO: TObjectList<TFolhaPppCatVO> read FListaFolhaPppCatVO write FListaFolhaPppCatVO;
    [TManyValuedAssociation(False,'ID_FOLHA_PPP','ID')]
    property ListaFolhaPppAtividadeVO: TObjectList<TFolhaPppAtividadeVO> read FListaFolhaPppAtividadeVO write FListaFolhaPppAtividadeVO;
    [TManyValuedAssociation(False,'ID_FOLHA_PPP','ID')]
    property ListaFolhaPppFatorRiscoVO: TObjectList<TFolhaPppFatorRiscoVO> read FListaFolhaPppFatorRiscoVO write FListaFolhaPppFatorRiscoVO;
    [TManyValuedAssociation(False,'ID_FOLHA_PPP','ID')]
    property ListaFolhaPppExameMedicoVO: TObjectList<TFolhaPppExameMedicoVO> read FListaFolhaPppExameMedicoVO write FListaFolhaPppExameMedicoVO;

  end;

implementation

constructor TFolhaPppVO.Create;
begin
  inherited;
  ListaFolhaPppCatVO := TObjectList<TFolhaPppCatVO>.Create;
  ListaFolhaPppAtividadeVO := TObjectList<TFolhaPppAtividadeVO>.Create;
  ListaFolhaPppFatorRiscoVO := TObjectList<TFolhaPppFatorRiscoVO>.Create;
  ListaFolhaPppExameMedicoVO := TObjectList<TFolhaPppExameMedicoVO>.Create;
end;

constructor TFolhaPppVO.Create(pJsonValue: TJSONValue);
var
  Deserializa: TJSONUnMarshal;
begin
  if pJsonValue is TJSONNull then
    Exception.Create('Erro ao criar objeto com um valor nulo.');

  Deserializa := TJSONUnMarshal.Create;
  try
    Self.Free;

    //CAT
    Deserializa.RegisterReverter(TFolhaPppVO, 'FListaFolhaPppCatVO', procedure(Data: TObject; Field: String; Args: TListOfObjects)
    var
      Obj: TObject;
    begin
  	  if not Assigned(TFolhaPppVO(Data).FListaFolhaPppCatVO) then
        TFolhaPppVO(Data).FListaFolhaPppCatVO := TObjectList<TFolhaPppCatVO>.Create;

      for Obj in Args do
      begin
        TFolhaPppVO(Data).FListaFolhaPppCatVO.Add(TFolhaPppCatVO(Obj));
      end
    end);

    //Atividade
    Deserializa.RegisterReverter(TFolhaPppVO, 'FListaFolhaPppAtividadeVO', procedure(Data: TObject; Field: String; Args: TListOfObjects)
    var
      Obj: TObject;
    begin
  	  if not Assigned(TFolhaPppVO(Data).FListaFolhaPppAtividadeVO) then
        TFolhaPppVO(Data).FListaFolhaPppAtividadeVO := TObjectList<TFolhaPppAtividadeVO>.Create;

      for Obj in Args do
      begin
        TFolhaPppVO(Data).FListaFolhaPppAtividadeVO.Add(TFolhaPppAtividadeVO(Obj));
      end
    end);

    //Fator Risco
    Deserializa.RegisterReverter(TFolhaPppVO, 'FListaFolhaPppFatorRiscoVO', procedure(Data: TObject; Field: String; Args: TListOfObjects)
    var
      Obj: TObject;
    begin
  	  if not Assigned(TFolhaPppVO(Data).FListaFolhaPppFatorRiscoVO) then
        TFolhaPppVO(Data).FListaFolhaPppFatorRiscoVO := TObjectList<TFolhaPppFatorRiscoVO>.Create;

      for Obj in Args do
      begin
        TFolhaPppVO(Data).FListaFolhaPppFatorRiscoVO.Add(TFolhaPppFatorRiscoVO(Obj));
      end
    end);

    //Exame Médico
    Deserializa.RegisterReverter(TFolhaPppVO, 'FListaFolhaPppExameMedicoVO', procedure(Data: TObject; Field: String; Args: TListOfObjects)
    var
      Obj: TObject;
    begin
  	  if not Assigned(TFolhaPppVO(Data).FListaFolhaPppExameMedicoVO) then
        TFolhaPppVO(Data).FListaFolhaPppExameMedicoVO := TObjectList<TFolhaPppExameMedicoVO>.Create;

      for Obj in Args do
      begin
        TFolhaPppVO(Data).FListaFolhaPppExameMedicoVO.Add(TFolhaPppExameMedicoVO(Obj));
      end
    end);

    Self := Deserializa.Unmarshal(pJsonValue) as TFolhaPppVO;
  finally
    Deserializa.Free;
  end;
end;

destructor TFolhaPppVO.Destroy;
begin
  ListaFolhaPppCatVO.Free;
  ListaFolhaPppAtividadeVO.Free;
  ListaFolhaPppFatorRiscoVO.Free;
  ListaFolhaPppExameMedicoVO.Free;

  if Assigned(FColaboradorVO) then
    FColaboradorVO.Free;

  inherited;
end;

function TFolhaPppVO.ToJSON: TJSONValue;
var
  Serializa: TJSONMarshal;
begin
  Serializa := TJSONMarshal.Create(TJSONConverter.Create);
  try

    //CAT
    Serializa.RegisterConverter(TFolhaPppVO, 'FListaFolhaPppCatVO', function(Data: TObject; Field: string): TListOfObjects
      var
        I: Integer;
      begin
        if Assigned(TFolhaPppVO(Data).FListaFolhaPppCatVO) then
        begin
          SetLength(Result, TFolhaPppVO(Data).FListaFolhaPppCatVO.Count);
          for I := 0 to TFolhaPppVO(Data).FListaFolhaPppCatVO.Count - 1 do
          begin
            Result[I] := TFolhaPppVO(Data).FListaFolhaPppCatVO.Items[I];
          end;
        end;
      end);

    //Atividade
    Serializa.RegisterConverter(TFolhaPppVO, 'FListaFolhaPppAtividadeVO', function(Data: TObject; Field: string): TListOfObjects
      var
        I: Integer;
      begin
        if Assigned(TFolhaPppVO(Data).FListaFolhaPppAtividadeVO) then
        begin
          SetLength(Result, TFolhaPppVO(Data).FListaFolhaPppAtividadeVO.Count);
          for I := 0 to TFolhaPppVO(Data).FListaFolhaPppAtividadeVO.Count - 1 do
          begin
            Result[I] := TFolhaPppVO(Data).FListaFolhaPppAtividadeVO.Items[I];
          end;
        end;
      end);

    //Fator Risco
    Serializa.RegisterConverter(TFolhaPppVO, 'FListaFolhaPppFatorRiscoVO', function(Data: TObject; Field: string): TListOfObjects
      var
        I: Integer;
      begin
        if Assigned(TFolhaPppVO(Data).FListaFolhaPppFatorRiscoVO) then
        begin
          SetLength(Result, TFolhaPppVO(Data).FListaFolhaPppFatorRiscoVO.Count);
          for I := 0 to TFolhaPppVO(Data).FListaFolhaPppFatorRiscoVO.Count - 1 do
          begin
            Result[I] := TFolhaPppVO(Data).FListaFolhaPppFatorRiscoVO.Items[I];
          end;
        end;
      end);

    //Exame Médico
    Serializa.RegisterConverter(TFolhaPppVO, 'FListaFolhaPppExameMedicoVO', function(Data: TObject; Field: string): TListOfObjects
      var
        I: Integer;
      begin
        if Assigned(TFolhaPppVO(Data).FListaFolhaPppExameMedicoVO) then
        begin
          SetLength(Result, TFolhaPppVO(Data).FListaFolhaPppExameMedicoVO.Count);
          for I := 0 to TFolhaPppVO(Data).FListaFolhaPppExameMedicoVO.Count - 1 do
          begin
            Result[I] := TFolhaPppVO(Data).FListaFolhaPppExameMedicoVO.Items[I];
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
