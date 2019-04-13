{*******************************************************************************
Title: T2Ti ERP                                                                 
Description:  VO  relacionado à tabela [TRANSPORTADORA] 
                                                                                
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
                                                                                
t2ti.com@gmail.com | fernandololiver@gmail.com
@author Albert Eije (T2Ti.COM) | Fernando L Oliveira
@version 1.0                                                                    
*******************************************************************************}
unit TransportadoraVO;

interface

uses
  JsonVO, Atributos, Classes, Constantes, Generics.Collections, DBXJSON, DBXJSONReflect, SysUtils,
  PessoaVO, ContabilContaVO, ContatoVO, EnderecoVO;

type
  [TEntity]
  [TTable('TRANSPORTADORA')]
  TTransportadoraVO = class(TJsonVO)
  private
    FID: Integer;
    FID_CONTABIL_CONTA: Integer;
    FID_PESSOA: Integer;
    FDATA_CADASTRO: TDateTime;
    FOBSERVACAO: String;

    FPessoaNome: String;
    FContabilContaClassificacao: String;

    FPessoaVO: TPessoaVO;
    FContabilContaVO: TContabilContaVO;

  public
    constructor Create; overload; override;
    constructor Create(pJsonValue: TJSONValue); overload; override;
    destructor Destroy; override;
    function ToJSON: TJSONValue; override;

    [TId('ID')]
    [TGeneratedValue(sAuto)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property Id: Integer  read FID write FID;

    [TColumn('ID_CONTABIL_CONTA','Id Contábil Conta',80,[], False)]
    property IdContabilConta: Integer  read FID_CONTABIL_CONTA write FID_CONTABIL_CONTA;
    [TColumn('CONTABIL_CONTA.CLASSIFICACAO','Conta Contábil',150,[ldGrid],True,'CONTABIL_CONTA','ID_CONTABIL_CONTA','ID')]
    property ContabilContaClassificacao: String read FContabilContaClassificacao write FContabilContaClassificacao;

    [TColumn('ID_PESSOA','Id Pessoa',80,[], False)]
    property IdPessoa: Integer  read FID_PESSOA write FID_PESSOA;
    [TColumn('PESSOA.NOME','Pessoa Nome',300,[ldGrid, ldLookup,ldComboBox],True,'PESSOA','ID_PESSOA','ID')]
    property PessoaNome: String read FPessoaNome write FPessoaNome;

    [TColumn('DATA_CADASTRO','Data Cadastro',80,[ldGrid, ldLookup, ldCombobox], False)]
    property DataCadastro: TDateTime  read FDATA_CADASTRO write FDATA_CADASTRO;
    [TColumn('OBSERVACAO','Observacao',450,[ldGrid, ldLookup, ldCombobox], False)]
    property Observacao: String  read FOBSERVACAO write FOBSERVACAO;


    [TAssociation(True,'ID','ID_PESSOA','PESSOA')]
    property PessoaVO: TPessoaVO read FPessoaVO write FPessoaVO;

    [TAssociation(False,'ID','ID_CONTABIL_CONTA','CONTABIL_CONTA')]
    property ContabilContaVO: TContabilContaVO read FContabilContaVO write FContabilContaVO;

  end;

implementation

constructor TTransportadoraVO.Create;
begin
  inherited;
end;

constructor TTransportadoraVO.Create(pJsonValue: TJSONValue);
var
  Deserializa: TJSONUnMarshal;
begin
  if pJsonValue is TJSONNull then
    Exception.Create('Erro ao criar objeto com um valor nulo.');

  Deserializa := TJSONUnMarshal.Create;
  try
    Self.Free;

    //Contatos
    Deserializa.RegisterReverter(TPessoaVO, 'FListaContatoVO', procedure(Data: TObject; Field: String; Args: TListOfObjects)
    var
      Obj: TObject;
    begin
      if not Assigned(TPessoaVO(Data).ListaContatoVO) then
        TPessoaVO(Data).ListaContatoVO := TObjectList<TContatoVO>.Create;

      for Obj in Args do
      begin
        TPessoaVO(Data).ListaContatoVO.Add(TContatoVO(Obj));
      end
    end);

    //Endereços
    Deserializa.RegisterReverter(TPessoaVO, 'FListaEnderecoVO', procedure(Data: TObject; Field: String; Args: TListOfObjects)
    var
      Obj: TObject;
    begin
      if not Assigned(TPessoaVO(Data).ListaEnderecoVO) then
        TPessoaVO(Data).ListaEnderecoVO := TObjectList<TEnderecoVO>.Create;

      for Obj in Args do
      begin
        TPessoaVO(Data).ListaEnderecoVO.Add(TEnderecoVO(Obj));
      end
    end);

    Self := Deserializa.Unmarshal(pJsonValue) as TTransportadoraVO;
  finally
    Deserializa.Free;
  end;
end;

destructor TTransportadoraVO.Destroy;
begin
  if Assigned(FPessoaVO) then
    FPessoaVO.Free;
  if Assigned(FContabilContaVO) then
    FContabilContaVO.Free;
  inherited;
end;

function TTransportadoraVO.ToJSON: TJSONValue;
var
  Serializa: TJSONMarshal;
begin
  Serializa := TJSONMarshal.Create(TJSONConverter.Create);
  try

    //Contatos
    Serializa.RegisterConverter(TPessoaVO, 'FListaContatoVO', function(Data: TObject; Field: string): TListOfObjects
      var
        I: Integer;
      begin
        if Assigned(TpessoaVO(Data).ListaContatoVO) then
        begin
          SetLength(Result, TpessoaVO(Data).ListaContatoVO.Count);
          for I := 0 to TPessoaVO(Data).ListaContatoVO.Count - 1 do
          begin
            Result[I] := TPessoaVO(Data).ListaContatoVO.Items[I];
          end;
        end;
      end);

    //Endereços
    Serializa.RegisterConverter(TPessoaVO, 'FListaEnderecoVO', function(Data: TObject; Field: string): TListOfObjects
      var
        I: Integer;
      begin
        if Assigned(TPessoaVO(Data).ListaEnderecoVO) then
        begin
          SetLength(Result, TPessoaVO(Data).ListaEnderecoVO.Count);
          for I := 0 to TPessoaVO(Data).ListaEnderecoVO.Count - 1 do
          begin
            Result[I] := TPessoaVO(Data).ListaEnderecoVO.Items[I];
          end;
        end;
      end);

    if Assigned(Self.PessoaVO) then
     Self.PessoaNome := Self.PessoaVO.Nome;
    if Assigned(Self.ContabilContaVO) then
      Self.ContabilContaClassificacao := Self.ContabilContaVO.Classificacao;

    Exit(serializa.Marshal(Self));
  finally
    Serializa.Free;
  end;
end;

end.
