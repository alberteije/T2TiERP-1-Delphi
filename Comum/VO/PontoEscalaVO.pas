{*******************************************************************************
Title: T2Ti ERP                                                                 
Description:  VO  relacionado à tabela [PONTO_ESCALA] 
                                                                                
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
unit PontoEscalaVO;

interface

uses
  JsonVO, Atributos, Classes, Constantes, Generics.Collections, DBXJSON, DBXJSONReflect,
  SysUtils, PontoTurmaVO;

type
  [TEntity]
  [TTable('PONTO_ESCALA')]
  TPontoEscalaVO = class(TJsonVO)
  private
    FID: Integer;
    FID_EMPRESA: Integer;
    FNOME: String;
    FDESCONTO_HORA_DIA: String;
    FDESCONTO_DSR: String;
    FCODIGO_HORARIO_DOMINGO: String;
    FCODIGO_HORARIO_SEGUNDA: String;
    FCODIGO_HORARIO_TERCA: String;
    FCODIGO_HORARIO_QUARTA: String;
    FCODIGO_HORARIO_QUINTA: String;
    FCODIGO_HORARIO_SEXTA: String;
    FCODIGO_HORARIO_SABADO: String;

    FListaPontoTurmaVO: TObjectList<TPontoTurmaVO>;

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
    [TColumn('NOME','Nome',400,[ldGrid, ldLookup, ldCombobox], False)]
    property Nome: String  read FNOME write FNOME;
    [TColumn('DESCONTO_HORA_DIA','Desconto Hora Dia',64,[ldGrid, ldLookup, ldCombobox], False)]
    property DescontoHoraDia: String  read FDESCONTO_HORA_DIA write FDESCONTO_HORA_DIA;
    [TColumn('DESCONTO_DSR','Desconto Dsr',64,[ldGrid, ldLookup, ldCombobox], False)]
    property DescontoDsr: String  read FDESCONTO_DSR write FDESCONTO_DSR;
    [TColumn('CODIGO_HORARIO_DOMINGO','Codigo Horario Domingo',16,[ldGrid, ldLookup, ldCombobox], False)]
    property CodigoHorarioDomingo: String  read FCODIGO_HORARIO_DOMINGO write FCODIGO_HORARIO_DOMINGO;
    [TColumn('CODIGO_HORARIO_SEGUNDA','Codigo Horario Segunda',16,[ldGrid, ldLookup, ldCombobox], False)]
    property CodigoHorarioSegunda: String  read FCODIGO_HORARIO_SEGUNDA write FCODIGO_HORARIO_SEGUNDA;
    [TColumn('CODIGO_HORARIO_TERCA','Codigo Horario Terca',16,[ldGrid, ldLookup, ldCombobox], False)]
    property CodigoHorarioTerca: String  read FCODIGO_HORARIO_TERCA write FCODIGO_HORARIO_TERCA;
    [TColumn('CODIGO_HORARIO_QUARTA','Codigo Horario Quarta',16,[ldGrid, ldLookup, ldCombobox], False)]
    property CodigoHorarioQuarta: String  read FCODIGO_HORARIO_QUARTA write FCODIGO_HORARIO_QUARTA;
    [TColumn('CODIGO_HORARIO_QUINTA','Codigo Horario Quinta',16,[ldGrid, ldLookup, ldCombobox], False)]
    property CodigoHorarioQuinta: String  read FCODIGO_HORARIO_QUINTA write FCODIGO_HORARIO_QUINTA;
    [TColumn('CODIGO_HORARIO_SEXTA','Codigo Horario Sexta',16,[ldGrid, ldLookup, ldCombobox], False)]
    property CodigoHorarioSexta: String  read FCODIGO_HORARIO_SEXTA write FCODIGO_HORARIO_SEXTA;
    [TColumn('CODIGO_HORARIO_SABADO','Codigo Horario Sabado',16,[ldGrid, ldLookup, ldCombobox], False)]
    property CodigoHorarioSabado: String  read FCODIGO_HORARIO_SABADO write FCODIGO_HORARIO_SABADO;

    [TManyValuedAssociation(False,'ID_PONTO_ESCALA','ID')]
    property ListaPontoTurmaVO: TObjectList<TPontoTurmaVO> read FListaPontoTurmaVO write FListaPontoTurmaVO;

  end;

implementation

constructor TPontoEscalaVO.Create;
begin
  inherited;
  ListaPontoTurmaVO := TObjectList<TPontoTurmaVO>.Create;
end;

constructor TPontoEscalaVO.Create(pJsonValue: TJSONValue);
var
  Deserializa: TJSONUnMarshal;
begin
  if pJsonValue is TJSONNull then
    Exception.Create('Erro ao criar objeto com um valor nulo.');

  Deserializa := TJSONUnMarshal.Create;
  try
    Self.Free;

    //Lista Turmas
    Deserializa.RegisterReverter(TPontoEscalaVO, 'FListaPontoTurmaVO', procedure(Data: TObject; Field: String; Args: TListOfObjects)
    var
      Obj: TObject;
    begin
  	  if not Assigned(TPontoEscalaVO(Data).FListaPontoTurmaVO) then
        TPontoEscalaVO(Data).FListaPontoTurmaVO := TObjectList<TPontoTurmaVO>.Create;

      for Obj in Args do
      begin
        TPontoEscalaVO(Data).FListaPontoTurmaVO.Add(TPontoTurmaVO(Obj));
      end
    end);

    Self := Deserializa.Unmarshal(pJsonValue) as TPontoEscalaVO;
  finally
    Deserializa.Free;
  end;
end;

destructor TPontoEscalaVO.Destroy;
begin
  ListaPontoTurmaVO.Free;
  inherited;
end;

function TPontoEscalaVO.ToJSON: TJSONValue;
var
  Serializa: TJSONMarshal;
begin
  Serializa := TJSONMarshal.Create(TJSONConverter.Create);
  try
    //Lista Turmas
    Serializa.RegisterConverter(TPontoEscalaVO, 'FListaPontoTurmaVO', function(Data: TObject; Field: string): TListOfObjects
      var
        I: Integer;
      begin
        if Assigned(TPontoEscalaVO(Data).FListaPontoTurmaVO) then
        begin
          SetLength(Result, TPontoEscalaVO(Data).FListaPontoTurmaVO.Count);
          for I := 0 to TPontoEscalaVO(Data).FListaPontoTurmaVO.Count - 1 do
          begin
            Result[I] := TPontoEscalaVO(Data).FListaPontoTurmaVO.Items[I];
          end;
        end;
      end);

    Exit(serializa.Marshal(Self));
  finally
    Serializa.Free;
  end;
end;


end.
