{*******************************************************************************
Title: T2Ti ERP                                                                 
Description:  VO  relacionado à tabela [VIEW_PONTO_MARCACAO] 
                                                                                
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
unit ViewPontoMarcacaoVO;

interface

uses
  JsonVO, Atributos, Classes, Constantes, Generics.Collections, DBXJSON, DBXJSONReflect, SysUtils;

type
  [TEntity]
  [TTable('VIEW_PONTO_MARCACAO')]
  TViewPontoMarcacaoVO = class(TJsonVO)
  private
    FID: Integer;
    FID_COLABORADOR: Integer;
    FID_PONTO_RELOGIO: Integer;
    FDATA_MARCACAO: TDateTime;
    FHORA_MARCACAO: String;
    FTIPO_MARCACAO: String;
    FTIPO_REGISTRO: String;
    FJUSTIFICATIVA: String;
    FNSR: Integer;
    FPIS_NUMERO: String;
    FPESSOA_NOME: String;
    FNUMERO_SERIE: String;

  public 
    [TId('ID')]
    [TGeneratedValue(sAuto)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property Id: Integer  read FID write FID;
    [TColumn('ID_COLABORADOR','Id Colaborador',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdColaborador: Integer  read FID_COLABORADOR write FID_COLABORADOR;
    [TColumn('ID_PONTO_RELOGIO','Id Ponto Relogio',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdPontoRelogio: Integer  read FID_PONTO_RELOGIO write FID_PONTO_RELOGIO;
    [TColumn('DATA_MARCACAO','Data Marcacao',80,[ldGrid, ldLookup, ldCombobox], False)]
    property DataMarcacao: TDateTime  read FDATA_MARCACAO write FDATA_MARCACAO;
    [TColumn('HORA_MARCACAO','Hora Marcacao',64,[ldGrid, ldLookup, ldCombobox], False)]
    property HoraMarcacao: String  read FHORA_MARCACAO write FHORA_MARCACAO;
    [TColumn('TIPO_MARCACAO','Tipo Marcacao',8,[ldGrid, ldLookup, ldCombobox], False)]
    property TipoMarcacao: String  read FTIPO_MARCACAO write FTIPO_MARCACAO;
    [TColumn('TIPO_REGISTRO','Tipo Registro',8,[ldGrid, ldLookup, ldCombobox], False)]
    property TipoRegistro: String  read FTIPO_REGISTRO write FTIPO_REGISTRO;
    [TColumn('JUSTIFICATIVA','Justificativa',450,[ldGrid, ldLookup, ldCombobox], False)]
    property Justificativa: String  read FJUSTIFICATIVA write FJUSTIFICATIVA;
    [TColumn('NSR','Nsr',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property Nsr: Integer  read FNSR write FNSR;
    [TColumn('PIS_NUMERO','Pis Numero',96,[ldGrid, ldLookup, ldCombobox], False)]
    property PisNumero: String  read FPIS_NUMERO write FPIS_NUMERO;
    [TColumn('PESSOA_NOME','Pessoa Nome',450,[ldGrid, ldLookup, ldCombobox], False)]
    property PessoaNome: String  read FPESSOA_NOME write FPESSOA_NOME;
    [TColumn('NUMERO_SERIE','Numero Serie',400,[ldGrid, ldLookup, ldCombobox], False)]
    property NumeroSerie: String  read FNUMERO_SERIE write FNUMERO_SERIE;

  end;

implementation



end.
