{*******************************************************************************
Title: T2Ti ERP                                                                 
Description:  VO  relacionado � tabela [FOLHA_LANCAMENTO_DETALHE] 
                                                                                
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
unit FolhaLancamentoDetalheVO;

interface

uses
  JsonVO, Atributos, Classes, Constantes, Generics.Collections, DBXJSON, DBXJSONReflect,
  SysUtils, FolhaEventoVO;

type
  [TEntity]
  [TTable('FOLHA_LANCAMENTO_DETALHE')]
  TFolhaLancamentoDetalheVO = class(TJsonVO)
  private
    FID: Integer;
    FID_FOLHA_EVENTO: Integer;
    FID_FOLHA_LANCAMENTO_CABECALHO: Integer;
    FORIGEM: Extended;
    FPROVENTO: Extended;
    FDESCONTO: Extended;

    FFolhaEventoNome: String;

    FFolhaEventoVO: TFolhaEventoVO;

  public 
    destructor Destroy; override;
    function ToJSON: TJSONValue; override;

    [TId('ID')]
    [TGeneratedValue(sAuto)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property Id: Integer  read FID write FID;

    [TColumn('ID_FOLHA_EVENTO','Id Folha Evento',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdFolhaEvento: Integer  read FID_FOLHA_EVENTO write FID_FOLHA_EVENTO;
    [TColumn('FOLHA_EVENTO.NOME', 'Evento', 200, [ldGrid, ldLookup, ldComboBox], True, 'FOLHA_EVENTO', 'ID_FOLHA_EVENTO', 'ID')]
    property FolhaEventoNome: String read FFolhaEventoNome write FFolhaEventoNome;

    [TColumn('ID_FOLHA_LANCAMENTO_CABECALHO','Id Folha Lancamento Cabecalho',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdFolhaLancamentoCabecalho: Integer  read FID_FOLHA_LANCAMENTO_CABECALHO write FID_FOLHA_LANCAMENTO_CABECALHO;
    [TColumn('ORIGEM','Origem',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property Origem: Extended  read FORIGEM write FORIGEM;
    [TColumn('PROVENTO','Provento',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property Provento: Extended  read FPROVENTO write FPROVENTO;
    [TColumn('DESCONTO','Desconto',168,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property Desconto: Extended  read FDESCONTO write FDESCONTO;

    [TAssociation(False, 'ID', 'ID_FOLHA_EVENTO', 'FOLHA_EVENTO')]
    property FolhaEventoVO: TFolhaEventoVO read FFolhaEventoVO write FFolhaEventoVO;
  end;

implementation

destructor TFolhaLancamentoDetalheVO.Destroy;
begin
  if Assigned(FFolhaEventoVO) then
    FFolhaEventoVO.Free;

  inherited;
end;

function TFolhaLancamentoDetalheVO.ToJSON: TJSONValue;
var
  Serializa: TJSONMarshal;
begin
  Serializa := TJSONMarshal.Create(TJSONConverter.Create);
  try
    if Assigned(Self.FFolhaEventoVO) then
      Self.FolhaEventoNome := Self.FFolhaEventoVO.Nome;

    Exit(Serializa.Marshal(Self));
  finally
    Serializa.Free;
  end;
end;


end.
