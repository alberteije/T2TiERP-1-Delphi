{*******************************************************************************
Title: T2Ti ERP                                                                 
Description:  VO  relacionado à tabela [EcfImpressora]
                                                                                
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
                                                                                
@author  Marcos Leite
@version 1.0                                                                    
*******************************************************************************}
unit EcfImpressoraVO;

interface

uses
  Atributos;

type
  [TEntity]
  [TTable('ECF_IMPRESSORA')]
  TEcfImpressoraVO = class
  private
    FID: Integer;
    FNUMERO: Integer;
    FCODIGO: String;
    FSERIE: String;
    FIDENTIFICACAO: String;
    FMC: String;
    FMD: String;
    FVR: String;
    FTIPO: String;
    FMARCA: String;
    FMODELO: String;
    FMODELO_ACBR: String;
    FMODELO_DOCUMENTO_FISCAL: String;
    FVERSAO: String;
    FLE: String;
    FLEF: String;
    FMFD: String;
    FLACRE_NA_MFD: String;
    FDOCTO: String;
    FDATA_INSTALACAO_SB: String;
    FHORA_INSTALACAO_SB: String;
    FNUMERO_ECF: String;

  public
    [TId('ID')]
    [TGeneratedValue('AUTO')]
    property Id: Integer  read FID write FID;
    [TColumn('NUMERO','Numero',ldGridLookup ,False)]
    property Numero: Integer  read FNUMERO write FNUMERO;
    [TColumn('CODIGO','Codigo',ldGridLookup ,False)]
    property Codigo: String  read FCODIGO write FCODIGO;
    [TColumn('SERIE','Serie',ldGridLookup ,False)]
    property Serie: String  read FSERIE write FSERIE;
    [TColumn('IDENTIFICACAO','Identificacao',ldGridLookup ,False)]
    property Identificacao: String  read FIDENTIFICACAO write FIDENTIFICACAO;
    [TColumn('MC','Mc',ldGridLookup ,False)]
    property Mc: String  read FMC write FMC;
    [TColumn('MD','Md',ldGridLookup ,False)]
    property Md: String  read FMD write FMD;
    [TColumn('VR','Vr',ldGridLookup ,False)]
    property Vr: String  read FVR write FVR;
    [TColumn('TIPO','Tipo',ldGridLookup ,False)]
    property Tipo: String  read FTIPO write FTIPO;
    [TColumn('MARCA','Marca',ldGridLookup ,False)]
    property Marca: String  read FMARCA write FMARCA;
    [TColumn('MODELO','Modelo',ldGridLookup ,False)]
    property Modelo: String  read FMODELO write FMODELO;
    [TColumn('MODELO_ACBR','Modelo Acbr',ldGridLookup ,False)]
    property ModeloAcbr: String  read FMODELO_ACBR write FMODELO_ACBR;
    [TColumn('MODELO_DOCUMENTO_FISCAL','Modelo Documento Fiscal',ldGridLookup ,False)]
    property ModeloDocumentoFiscal: String  read FMODELO_DOCUMENTO_FISCAL write FMODELO_DOCUMENTO_FISCAL;
    [TColumn('VERSAO','Versao',ldGridLookup ,False)]
    property Versao: String  read FVERSAO write FVERSAO;
    [TColumn('LE','Le',ldGridLookup ,False)]
    property Le: String  read FLE write FLE;
    [TColumn('LEF','Lef',ldGridLookup ,False)]
    property Lef: String  read FLEF write FLEF;
    [TColumn('MFD','Mfd',ldGridLookup ,False)]
    property Mfd: String  read FMFD write FMFD;
    [TColumn('LACRE_NA_MFD','Lacre Na Mfd',ldGridLookup ,False)]
    property LacreNaMfd: String  read FLACRE_NA_MFD write FLACRE_NA_MFD;
    [TColumn('DOCTO','Docto',ldGridLookup ,False)]
    property Docto: String  read FDOCTO write FDOCTO;
    [TColumn('DATA_INSTALACAO_SB','Data Instalação SB',ldGridLookup ,False)]
    property DataInstalacaoSB: String  read FDATA_INSTALACAO_SB write FDATA_INSTALACAO_SB;
    [TColumn('HORA_INSTALACAO_SB','Hora Instalação SB',ldGridLookup ,False)]
    property HoraInstalacaoSB: String  read FHORA_INSTALACAO_SB write FHORA_INSTALACAO_SB;
    [TColumn('NUMERO_ECF','Numero ECF',ldGridLookup ,False)]
    property NumeroEcf: String  read FNUMERO_ECF write FNUMERO_ECF;

  end;

implementation



end.
