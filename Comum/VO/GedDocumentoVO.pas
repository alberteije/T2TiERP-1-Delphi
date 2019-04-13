{*******************************************************************************
Title: T2Ti ERP                                                                 
Description:  VO  relacionado à tabela [GED_DOCUMENTO] 
                                                                                
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
unit GedDocumentoVO;

interface

uses
  JsonVO, Atributos, Classes, Constantes, Generics.Collections, DBXJSON, DBXJSONReflect,
  SysUtils, GedTipoDocumentoVO, GedVersaoDocumentoVO;

type
  [TEntity]
  [TTable('GED_DOCUMENTO')]
  TGedDocumentoVO = class(TJsonVO)
  private
    FID: Integer;
    FID_EMPRESA: Integer;
    FID_GED_TIPO_DOCUMENTO: Integer;
    FNOME: String;
    FDESCRICAO: String;
    FPALAVRA_CHAVE: String;
    FPODE_EXCLUIR: String;
    FPODE_ALTERAR: String;
    FASSINADO: String;
    FDATA_FIM_VIGENCIA: TDateTime;
    FDATA_EXCLUSAO: TDateTime;

    FGedTipoDocumentoNome: String;
    FGedTipoDocumentoVO: TGedTipoDocumentoVO;

    FListaGedVersaoDocumentoVO: TObjectList<TGedVersaoDocumentoVO>;

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
    [TColumn('ID_GED_TIPO_DOCUMENTO','Id Tipo Documento',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdGedTipoDocumento: Integer  read FID_GED_TIPO_DOCUMENTO write FID_GED_TIPO_DOCUMENTO;

    [TColumn('GED_TIPO_DOCUMENTO.NOME', 'Tipo Documento Nome', 300, [ldGrid, ldLookup], True)]
    property GedTipoDocumentoNome: string read FGedTipoDocumentoNome write FGedTipoDocumentoNome;

    [TColumn('NOME','Nome',450,[ldGrid, ldLookup, ldCombobox], False)]
    property Nome: String  read FNOME write FNOME;
    [TColumn('DESCRICAO','Descricao',450,[ldGrid, ldLookup, ldCombobox], False)]
    property Descricao: String  read FDESCRICAO write FDESCRICAO;
    [TColumn('PALAVRA_CHAVE','Palavra Chave',450,[ldGrid, ldLookup, ldCombobox], False)]
    property PalavraChave: String  read FPALAVRA_CHAVE write FPALAVRA_CHAVE;
    [TColumn('PODE_EXCLUIR','Pode Excluir',8,[ldGrid, ldLookup, ldCombobox], False)]
    property PodeExcluir: String  read FPODE_EXCLUIR write FPODE_EXCLUIR;
    [TColumn('PODE_ALTERAR','Pode Alterar',8,[ldGrid, ldLookup, ldCombobox], False)]
    property PodeAlterar: String  read FPODE_ALTERAR write FPODE_ALTERAR;
    [TColumn('ASSINADO','Assinado',8,[ldGrid, ldLookup, ldCombobox], False)]
    property Assinado: String  read FASSINADO write FASSINADO;
    [TColumn('DATA_FIM_VIGENCIA','Data Fim Vigencia',80,[ldGrid, ldLookup, ldCombobox], False)]
    property DataFimVigencia: TDateTime  read FDATA_FIM_VIGENCIA write FDATA_FIM_VIGENCIA;
    [TColumn('DATA_EXCLUSAO','Data Exclusao',80,[ldGrid, ldLookup, ldCombobox], False)]
    property DataExclusao: TDateTime  read FDATA_EXCLUSAO write FDATA_EXCLUSAO;

    [TAssociation(False, 'ID', 'ID_GED_TIPO_DOCUMENTO')]
    property GedTipoDocumentoVO: TGedTipoDocumentoVO read FGedTipoDocumentoVO write FGedTipoDocumentoVO;

    [TManyValuedAssociation(False,'ID_GED_DOCUMENTO','ID')]
    property ListaGedVersaoDocumentoVO: TObjectList<TGedVersaoDocumentoVO> read FListaGedVersaoDocumentoVO write FListaGedVersaoDocumentoVO;
  end;

implementation

constructor TGedDocumentoVO.Create;
begin
  inherited;
  ListaGedVersaoDocumentoVO := TObjectList<TGedVersaoDocumentoVO>.Create;
end;

constructor TGedDocumentoVO.Create(pJsonValue: TJSONValue);
var
  Deserializa: TJSONUnMarshal;
begin
  if pJsonValue is TJSONNull then
    Exception.Create('Erro ao criar objeto com um valor nulo.');

  Deserializa := TJSONUnMarshal.Create;
  try
    Self.Free;

    Deserializa.RegisterReverter(TGedDocumentoVO, 'FListaGedVersaoDocumentoVO', procedure(Data: TObject; Field: String; Args: TListOfObjects)
    var
      Obj: TObject;
    begin
  	  if not Assigned(TGedDocumentoVO(Data).FListaGedVersaoDocumentoVO) then
        TGedDocumentoVO(Data).FListaGedVersaoDocumentoVO := TObjectList<TGedVersaoDocumentoVO>.Create;

      for Obj in Args do
      begin
        TGedDocumentoVO(Data).FListaGedVersaoDocumentoVO.Add(TGedVersaoDocumentoVO(Obj));
      end
    end);

    Self := Deserializa.Unmarshal(pJsonValue) as TGedDocumentoVO;
  finally
    Deserializa.Free;
  end;
end;

destructor TGedDocumentoVO.Destroy;
begin
  ListaGedVersaoDocumentoVO.Free;

  if Assigned(FGedTipoDocumentoVO) then
    FGedTipoDocumentoVO.Free;

  inherited;
end;

function TGedDocumentoVO.ToJSON: TJSONValue;
var
  Serializa: TJSONMarshal;
begin
  Serializa := TJSONMarshal.Create(TJSONConverter.Create);
  try

    Serializa.RegisterConverter(TGedDocumentoVO, 'FListaGedVersaoDocumentoVO', function(Data: TObject; Field: string): TListOfObjects
      var
        I: Integer;
      begin
        if Assigned(TGedDocumentoVO(Data).FListaGedVersaoDocumentoVO) then
        begin
          SetLength(Result, TGedDocumentoVO(Data).FListaGedVersaoDocumentoVO.Count);
          for I := 0 to TGedDocumentoVO(Data).FListaGedVersaoDocumentoVO.Count - 1 do
          begin
            Result[I] := TGedDocumentoVO(Data).FListaGedVersaoDocumentoVO.Items[I];
          end;
        end;
      end);

    // Campos Transientes
    if Assigned(Self.GedTipoDocumentoVO) then
      Self.GedTipoDocumentoNome := Self.GedTipoDocumentoVO.Nome;

  Exit(serializa.Marshal(Self));
  finally
    Serializa.Free;
  end;
end;


end.
