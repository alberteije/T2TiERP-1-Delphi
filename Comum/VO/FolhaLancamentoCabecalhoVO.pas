{*******************************************************************************
Title: T2Ti ERP                                                                 
Description:  VO  relacionado à tabela [FOLHA_LANCAMENTO_CABECALHO] 
                                                                                
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
unit FolhaLancamentoCabecalhoVO;

interface

uses
  JsonVO, Atributos, Classes, Constantes, Generics.Collections, DBXJSON, DBXJSONReflect, SysUtils,
  ColaboradorPessoaVO, FolhaLancamentoDetalheVO;

type
  [TEntity]
  [TTable('FOLHA_LANCAMENTO_CABECALHO')]
  TFolhaLancamentoCabecalhoVO = class(TJsonVO)
  private
    FID: Integer;
    FID_COLABORADOR: Integer;
    FCOMPETENCIA: String;
    FTIPO: String;
    FColaboradorNome: String;

    FColaboradorVO: TColaboradorVO;

    FListaFolhaLancamentoDetalheVO: TObjectList<TFolhaLancamentoDetalheVO>;

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

    [TColumn('COMPETENCIA','Competencia',56,[ldGrid, ldLookup, ldCombobox], False)]
    property Competencia: String  read FCOMPETENCIA write FCOMPETENCIA;
    [TColumn('TIPO','Tipo',8,[ldGrid, ldLookup, ldCombobox], False)]
    property Tipo: String  read FTIPO write FTIPO;

    [TAssociation(True, 'ID', 'ID_COLABORADOR')]
    property ColaboradorVO: TColaboradorVO read FColaboradorVO write FColaboradorVO;

    [TManyValuedAssociation(True,'ID_FOLHA_LANCAMENTO_CABECALHO','ID')]
    property ListaFolhaLancamentoDetalheVO: TObjectList<TFolhaLancamentoDetalheVO> read FListaFolhaLancamentoDetalheVO write FListaFolhaLancamentoDetalheVO;
  end;

implementation

constructor TFolhaLancamentoCabecalhoVO.Create;
begin
  inherited;
  ListaFolhaLancamentoDetalheVO := TObjectList<TFolhaLancamentoDetalheVO>.Create;
end;

constructor TFolhaLancamentoCabecalhoVO.Create(pJsonValue: TJSONValue);
var
  Deserializa: TJSONUnMarshal;
begin
  if pJsonValue is TJSONNull then
    Exception.Create('Erro ao criar objeto com um valor nulo.');

  Deserializa := TJSONUnMarshal.Create;
  try
    Self.Free;

    Deserializa.RegisterReverter(TFolhaLancamentoCabecalhoVO, 'FListaFolhaLancamentoDetalheVO', procedure(Data: TObject; Field: String; Args: TListOfObjects)
    var
      Obj: TObject;
    begin
  	  if not Assigned(TFolhaLancamentoCabecalhoVO(Data).FListaFolhaLancamentoDetalheVO) then
        TFolhaLancamentoCabecalhoVO(Data).FListaFolhaLancamentoDetalheVO := TObjectList<TFolhaLancamentoDetalheVO>.Create;

      for Obj in Args do
      begin
        TFolhaLancamentoCabecalhoVO(Data).FListaFolhaLancamentoDetalheVO.Add(TFolhaLancamentoDetalheVO(Obj));
      end
    end);

    Self := Deserializa.Unmarshal(pJsonValue) as TFolhaLancamentoCabecalhoVO;
  finally
    Deserializa.Free;
  end;
end;

destructor TFolhaLancamentoCabecalhoVO.Destroy;
begin
  ListaFolhaLancamentoDetalheVO.Free;

  if Assigned(FColaboradorVO) then
    FColaboradorVO.Free;

  inherited;
end;

function TFolhaLancamentoCabecalhoVO.ToJSON: TJSONValue;
var
  Serializa: TJSONMarshal;
begin
  Serializa := TJSONMarshal.Create(TJSONConverter.Create);
  try

    Serializa.RegisterConverter(TFolhaLancamentoCabecalhoVO, 'FListaFolhaLancamentoDetalheVO', function(Data: TObject; Field: string): TListOfObjects
      var
        I: Integer;
      begin
        if Assigned(TFolhaLancamentoCabecalhoVO(Data).FListaFolhaLancamentoDetalheVO) then
        begin
          SetLength(Result, TFolhaLancamentoCabecalhoVO(Data).FListaFolhaLancamentoDetalheVO.Count);
          for I := 0 to TFolhaLancamentoCabecalhoVO(Data).FListaFolhaLancamentoDetalheVO.Count - 1 do
          begin
            Result[I] := TFolhaLancamentoCabecalhoVO(Data).FListaFolhaLancamentoDetalheVO.Items[I];
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
