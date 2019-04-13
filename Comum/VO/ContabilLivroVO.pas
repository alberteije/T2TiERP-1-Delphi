{*******************************************************************************
Title: T2Ti ERP                                                                 
Description:  VO  relacionado à tabela [CONTABIL_LIVRO] 
                                                                                
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
unit ContabilLivroVO;

interface

uses
  JsonVO, Atributos, Classes, Constantes, Generics.Collections, DBXJSON, DBXJSONReflect,
  SysUtils, ContabilTermoVO;

type
  [TEntity]
  [TTable('CONTABIL_LIVRO')]
  TContabilLivroVO = class(TJsonVO)
  private
    FID: Integer;
    FID_EMPRESA: Integer;
    FDESCRICAO: String;
    FCOMPETENCIA: String;
    FFORMA_ESCRITURACAO: String;

    FListaContabilTermoVO: TObjectList<TContabilTermoVO>;

  public
    constructor Create; overload; override;
    constructor Create(pJsonValue: TJSONValue); overload; override;
    destructor Destroy; override;
    function ToJSON: TJSONValue; override;

    [TId('ID')]
    [TGeneratedValue(sAuto)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property Id: Integer  read FID write FID;
    [TColumn('ID_EMPRESA','Id Empresa',80,[], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdEmpresa: Integer  read FID_EMPRESA write FID_EMPRESA;
    [TColumn('DESCRICAO','Descricao',400,[ldGrid, ldLookup, ldCombobox], False)]
    property Descricao: String  read FDESCRICAO write FDESCRICAO;
    [TColumn('COMPETENCIA','Competência',150,[ldGrid, ldLookup, ldCombobox], False)]
    property Competencia: String  read FCOMPETENCIA write FCOMPETENCIA;
    [TColumn('FORMA_ESCRITURACAO','Forma Escrituração',200,[ldGrid, ldLookup, ldCombobox], False)]
    property FormaEscrituracao: String  read FFORMA_ESCRITURACAO write FFORMA_ESCRITURACAO;

    [TManyValuedAssociation(False,'ID_CONTABIL_LIVRO','ID')]
    property ListaContabilTermoVO: TObjectList<TContabilTermoVO> read FListaContabilTermoVO write FListaContabilTermoVO;
  end;

implementation

constructor TContabilLivroVO.Create;
begin
  inherited;
  ListaContabilTermoVO := TObjectList<TContabilTermoVO>.Create;
end;

constructor TContabilLivroVO.Create(pJsonValue: TJSONValue);
var
  Deserializa: TJSONUnMarshal;
begin
  if pJsonValue is TJSONNull then
    Exception.Create('Erro ao criar objeto com um valor nulo.');

  Deserializa := TJSONUnMarshal.Create;
  try
    Self.Free;

    Deserializa.RegisterReverter(TContabilLivroVO, 'FListaContabilTermoVO', procedure(Data: TObject; Field: String; Args: TListOfObjects)
    var
      Obj: TObject;
    begin
  	  if not Assigned(TContabilLivroVO(Data).FListaContabilTermoVO) then
        TContabilLivroVO(Data).FListaContabilTermoVO := TObjectList<TContabilTermoVO>.Create;

      for Obj in Args do
      begin
        TContabilLivroVO(Data).FListaContabilTermoVO.Add(TContabilTermoVO(Obj));
      end
    end);

    Self := Deserializa.Unmarshal(pJsonValue) as TContabilLivroVO;
  finally
    Deserializa.Free;
  end;
end;

destructor TContabilLivroVO.Destroy;
begin
  ListaContabilTermoVO.Free;

  inherited;
end;

function TContabilLivroVO.ToJSON: TJSONValue;
var
  Serializa: TJSONMarshal;
begin
  Serializa := TJSONMarshal.Create(TJSONConverter.Create);
  try

    Serializa.RegisterConverter(TContabilLivroVO, 'FListaContabilTermoVO', function(Data: TObject; Field: string): TListOfObjects
      var
        I: Integer;
      begin
        if Assigned(TContabilLivroVO(Data).FListaContabilTermoVO) then
        begin
          SetLength(Result, TContabilLivroVO(Data).FListaContabilTermoVO.Count);
          for I := 0 to TContabilLivroVO(Data).FListaContabilTermoVO.Count - 1 do
          begin
            Result[I] := TContabilLivroVO(Data).FListaContabilTermoVO.Items[I];
          end;
        end;
      end);

  Exit(serializa.Marshal(Self));
  finally
    Serializa.Free;
  end;
end;

end.
