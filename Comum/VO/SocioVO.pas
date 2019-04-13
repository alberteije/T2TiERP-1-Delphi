{*******************************************************************************
Title: T2Ti ERP                                                                 
Description:  VO  relacionado à tabela [SOCIO] 
                                                                                
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
unit SocioVO;

interface

uses
  JsonVO, Atributos, Classes, Constantes, Generics.Collections, DBXJSON,
  DBXJSONReflect, SysUtils, PessoaVO, SocioDependenteVO, SocioParticipacaoSocietariaVO;

type
  [TEntity]
  [TTable('SOCIO')]
  TSocioVO = class(TJsonVO)
  private
    FID: Integer;
    FID_PESSOA: Integer;
    FID_QUADRO_SOCIETARIO: Integer;
    FLOGRADOURO: String;
    FNUMERO: Integer;
    FCOMPLEMENTO: String;
    FBAIRRO: String;
    FMUNICIPIO: String;
    FUF: String;
    FCEP: String;
    FFONE: String;
    FCELULAR: String;
    FEMAIL: String;
    FPARTICIPACAO: Extended;
    FQUOTAS: Integer;
    FINTEGRALIZAR: Extended;
    FDATA_INGRESSO: TDateTime;
    FDATA_SAIDA: TDateTime;

    FPessoaNome: String;

    FPessoaVO: TPessoaVO;

    FListaSocioDependenteVO : TObjectList<TSocioDependenteVO>;
    FListaSocioParticipacaoSocietariaVO: TObjectList<TSocioParticipacaoSocietariaVO>;

  public
    constructor Create; overload; override;
    constructor Create(pJsonValue: TJSONValue); overload; override;
    destructor Destroy; override;

    function ToJSON: TJSONValue; override;

    [TId('ID')]
    [TGeneratedValue(sAuto)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property Id: Integer  read FID write FID;

    [TColumn('ID_PESSOA','Id Pessoa',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdPessoa: Integer  read FID_PESSOA write FID_PESSOA;

    [TColumn('PESSOA.N0ME','Nome do Sócio',250,[ldGrid, ldLookup], True)]
    property PessoaNome: String  read FPessoaNome write FPessoaNome;

    [TColumn('ID_QUADRO_SOCIETARIO','Id Quadro Societario',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdQuadroSocietario: Integer  read FID_QUADRO_SOCIETARIO write FID_QUADRO_SOCIETARIO;
    [TColumn('LOGRADOURO','Logradouro',450,[ldGrid, ldLookup, ldCombobox], False)]
    property Logradouro: String  read FLOGRADOURO write FLOGRADOURO;
    [TColumn('NUMERO','Numero',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property Numero: Integer  read FNUMERO write FNUMERO;
    [TColumn('COMPLEMENTO','Complemento',450,[ldGrid, ldLookup, ldCombobox], False)]
    property Complemento: String  read FCOMPLEMENTO write FCOMPLEMENTO;
    [TColumn('BAIRRO','Bairro',450,[ldGrid, ldLookup, ldCombobox], False)]
    property Bairro: String  read FBAIRRO write FBAIRRO;
    [TColumn('MUNICIPIO','Municipio',450,[ldGrid, ldLookup, ldCombobox], False)]
    property Municipio: String  read FMUNICIPIO write FMUNICIPIO;
    [TColumn('UF','Uf',16,[ldGrid, ldLookup, ldCombobox], False)]
    property Uf: String  read FUF write FUF;
    [TColumn('CEP','Cep',64,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftCep, taLeftJustify)]
    property Cep: String  read FCEP write FCEP;
    [TColumn('FONE','Fone',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftTelefone, taLeftJustify)]
    property Fone: String  read FFONE write FFONE;
    [TColumn('CELULAR','Celular',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftTelefone, taLeftJustify)]
    property Celular: String  read FCELULAR write FCELULAR;
    [TColumn('EMAIL','Email',450,[ldGrid, ldLookup, ldCombobox], False)]
    property Email: String  read FEMAIL write FEMAIL;
    [TColumn('PARTICIPACAO','Participacao',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property Participacao: Extended  read FPARTICIPACAO write FPARTICIPACAO;
    [TColumn('QUOTAS','Quotas',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property Quotas: Integer  read FQUOTAS write FQUOTAS;
    [TColumn('INTEGRALIZAR','Integralizar',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property Integralizar: Extended  read FINTEGRALIZAR write FINTEGRALIZAR;
    [TColumn('DATA_INGRESSO','Data Ingresso',80,[ldGrid, ldLookup, ldCombobox], False)]
    property DataIngresso: TDateTime  read FDATA_INGRESSO write FDATA_INGRESSO;
    [TColumn('DATA_SAIDA','Data Saida',80,[ldGrid, ldLookup, ldCombobox], False)]
    property DataSaida: TDateTime  read FDATA_SAIDA write FDATA_SAIDA;

    [TAssociation(False, 'ID', 'ID_PESSOA')]
    property PessoaVO: TPessoaVO read FPessoaVO write FPessoaVO;

    [TManyValuedAssociation(True, 'ID_SOCIO', 'ID')]
    property ListaSocioDependenteVO: TObjectList<TSocioDependenteVO> read FListaSocioDependenteVO write FListaSocioDependenteVO;

    [TManyValuedAssociation(False, 'ID_SOCIO', 'ID')]
    property ListaSocioParticipacaoSocietariaVO: TObjectList<TSocioParticipacaoSocietariaVO> read FListaSocioParticipacaoSocietariaVO write FListaSocioParticipacaoSocietariaVO;

  end;

implementation


{ TSocioVO }

constructor TSocioVO.Create;
begin
  inherited;
  if Assigned(FPessoaVO) then
    FPessoaVO.Free;

  ListaSocioDependenteVO := TObjectList<TSocioDependenteVO>.Create;
  ListaSocioParticipacaoSocietariaVO := TObjectList<TSocioParticipacaoSocietariaVO>.Create;
end;

constructor TSocioVO.Create(pJsonValue: TJSONValue);
var
  Deserializa: TJSONUnMarshal;
begin
  if pJsonValue is TJSONNull then
    Exception.Create('Erro ao criar objeto com um valor nulo.');

  Deserializa := TJSONUnMarshal.Create;
  try
    Self.Free;

    // Dependentes do socio
    Deserializa.RegisterReverter(TSocioVO, 'FListaSocioDependenteVO', procedure(Data: TObject; Field: String; Args: TListOfObjects)
    var
      Obj: TObject;
    begin
  	  if not Assigned(TSocioVO(Data).FListaSocioDependenteVO) then
        TSocioVO(Data).FListaSocioDependenteVO := TObjectList<TSocioDependenteVO>.Create;

      for Obj in Args do
      begin
        TSocioVO(Data).FListaSocioDependenteVO.Add(TSocioDependenteVO(Obj));
      end
    end);

    // Participacao societária
    Deserializa.RegisterReverter(TSocioVO, 'FListaSocioParticipacaoSocietariaVO', procedure(Data: TObject; Field: String; Args: TListOfObjects)
    var
      Obj: TObject;
    begin
  	  if not Assigned(TSocioVO(Data).FListaSocioParticipacaoSocietariaVO) then
        TSocioVO(Data).FListaSocioParticipacaoSocietariaVO := TObjectList<TSocioParticipacaoSocietariaVO>.Create;

      for Obj in Args do
      begin
        TSocioVO(Data).FListaSocioParticipacaoSocietariaVO.Add(TSocioParticipacaoSocietariaVO(Obj));
      end
    end);

    Self := Deserializa.Unmarshal(pJsonValue) as TSocioVO;
  finally
    Deserializa.Free;
  end;

end;

destructor TSocioVO.Destroy;
begin
  if Assigned(FPessoaVO) then
    FPessoaVO.Free;

  ListaSocioDependenteVO.Free;
  ListaSocioParticipacaoSocietariaVO.Free;

  inherited;
end;

function TSocioVO.ToJSON: TJSONValue;
var
  Serializa: TJSONMarshal;
begin
  Serializa := TJSONMarshal.Create(TJSONConverter.Create);
  try
    //Dependentes
    Serializa.RegisterConverter(TSocioVO, 'FListaSocioDependenteVO', function(Data: TObject; Field: string): TListOfObjects
      var
        I: Integer;
      begin
        if Assigned(TSocioVO(Data).FListaSocioDependenteVO) then
        begin
          SetLength(Result, TSocioVO(Data).FListaSocioDependenteVO.Count);
          for I := 0 to TSocioVO(Data).FListaSocioDependenteVO.Count - 1 do
          begin
            Result[I] := TSocioVO(Data).FListaSocioDependenteVO.Items[I];
          end;
        end;
      end);

    // Participacao societária
    Serializa.RegisterConverter(TSocioVO, 'FListaSocioParticipacaoSocietariaVO', function(Data: TObject; Field: String): TListOfObjects
      var
        I: Integer;
      begin
  	    if Assigned(TSocioVO(Data).FListaSocioParticipacaoSocietariaVO) then
        begin
          SetLength(Result, TSocioVO(Data).FListaSocioParticipacaoSocietariaVO.Count);
          for I := 0 to TSocioVO(Data).FListaSocioParticipacaoSocietariaVO.Count - 1 do
          begin
            Result[I] := TSocioVO(Data).FListaSocioParticipacaoSocietariaVO.Items[I];
          end;
        end;
      end);

    if Assigned(FPessoaVO) then
      Self.PessoaNome := Self.PessoaVO.Nome;

    Exit(serializa.Marshal(Self));
  finally
    Serializa.Free;
  end;
end;

end.
