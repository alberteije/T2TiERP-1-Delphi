{*******************************************************************************
Title: T2Ti ERP                                                                 
Description:  VO  relacionado à tabela [PONTO_ABONO] 
                                                                                
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
                                                                                
@author Albert Eije
@version 1.0                                                                    
*******************************************************************************}
unit PontoAbonoVO;

interface

uses
  JsonVO, Atributos, Classes, Constantes, Generics.Collections, DBXJSON, DBXJSONReflect,
  SysUtils, ColaboradorVO, PontoAbonoUtilizacaoVO;

type
  [TEntity]
  [TTable('PONTO_ABONO')]
  TPontoAbonoVO = class(TJsonVO)
  private
    FID: Integer;
    FID_COLABORADOR: Integer;
    FQUANTIDADE: Integer;
    FUTILIZADO: Integer;
    FSALDO: Integer;
    FDATA_CADASTRO: TDateTime;
    FINICIO_UTILIZACAO: TDateTime;
    FOBSERVACAO: String;

    FColaboradorNome: String;

    FColaboradorVO: TColaboradorVO;

    FListaPontoAbonoUtilizacaoVO: TObjectList<TPontoAbonoUtilizacaoVO>;

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

    [TColumn('QUANTIDADE','Quantidade',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property Quantidade: Integer  read FQUANTIDADE write FQUANTIDADE;
    [TColumn('UTILIZADO','Utilizado',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property Utilizado: Integer  read FUTILIZADO write FUTILIZADO;
    [TColumn('SALDO','Saldo',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property Saldo: Integer  read FSALDO write FSALDO;
    [TColumn('DATA_CADASTRO','Data Cadastro',80,[ldGrid, ldLookup, ldCombobox], False)]
    property DataCadastro: TDateTime  read FDATA_CADASTRO write FDATA_CADASTRO;
    [TColumn('INICIO_UTILIZACAO','Inicio Utilizacao',80,[ldGrid, ldLookup, ldCombobox], False)]
    property InicioUtilizacao: TDateTime  read FINICIO_UTILIZACAO write FINICIO_UTILIZACAO;
    [TColumn('OBSERVACAO','Observacao',450,[ldGrid, ldLookup, ldCombobox], False)]
    property Observacao: String  read FOBSERVACAO write FOBSERVACAO;

    [TAssociation(True, 'ID', 'ID_COLABORADOR')]
    property ColaboradorVO: TColaboradorVO read FColaboradorVO write FColaboradorVO;

    [TManyValuedAssociation(False,'ID_PONTO_ABONO','ID')]
    property ListaPontoAbonoUtilizacaoVO: TObjectList<TPontoAbonoUtilizacaoVO> read FListaPontoAbonoUtilizacaoVO write FListaPontoAbonoUtilizacaoVO;
  end;

implementation

constructor TPontoAbonoVO.Create;
begin
  inherited;
  ListaPontoAbonoUtilizacaoVO := TObjectList<TPontoAbonoUtilizacaoVO>.Create;
end;

constructor TPontoAbonoVO.Create(pJsonValue: TJSONValue);
var
  Deserializa: TJSONUnMarshal;
begin
  if pJsonValue is TJSONNull then
    Exception.Create('Erro ao criar objeto com um valor nulo.');

  Deserializa := TJSONUnMarshal.Create;
  try
    Self.Free;

    //Lista Abono Utilização
    Deserializa.RegisterReverter(TPontoAbonoVO, 'FListaPontoAbonoUtilizacaoVO', procedure(Data: TObject; Field: String; Args: TListOfObjects)
    var
      Obj: TObject;
    begin
  	  if not Assigned(TPontoAbonoVO(Data).FListaPontoAbonoUtilizacaoVO) then
        TPontoAbonoVO(Data).FListaPontoAbonoUtilizacaoVO := TObjectList<TPontoAbonoUtilizacaoVO>.Create;

      for Obj in Args do
      begin
        TPontoAbonoVO(Data).FListaPontoAbonoUtilizacaoVO.Add(TPontoAbonoUtilizacaoVO(Obj));
      end
    end);

    Self := Deserializa.Unmarshal(pJsonValue) as TPontoAbonoVO;
  finally
    Deserializa.Free;
  end;
end;

destructor TPontoAbonoVO.Destroy;
begin
  ListaPontoAbonoUtilizacaoVO.Free;

  if Assigned(FColaboradorVO) then
    FColaboradorVO.Free;

  inherited;
end;

function TPontoAbonoVO.ToJSON: TJSONValue;
var
  Serializa: TJSONMarshal;
begin
  Serializa := TJSONMarshal.Create(TJSONConverter.Create);
  try
    //Lista Abono Utilização
    Serializa.RegisterConverter(TPontoAbonoVO, 'FListaPontoAbonoUtilizacaoVO', function(Data: TObject; Field: string): TListOfObjects
      var
        I: Integer;
      begin
        if Assigned(TPontoAbonoVO(Data).FListaPontoAbonoUtilizacaoVO) then
        begin
          SetLength(Result, TPontoAbonoVO(Data).FListaPontoAbonoUtilizacaoVO.Count);
          for I := 0 to TPontoAbonoVO(Data).FListaPontoAbonoUtilizacaoVO.Count - 1 do
          begin
            Result[I] := TPontoAbonoVO(Data).FListaPontoAbonoUtilizacaoVO.Items[I];
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
