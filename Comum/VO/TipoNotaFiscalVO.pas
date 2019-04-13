{*******************************************************************************
Title: T2Ti ERP                                                                 
Description:  VO  relacionado à tabela [TIPO_NOTA_FISCAL] 
                                                                                
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
unit TipoNotaFiscalVO;

interface

uses
  JsonVO, Atributos, Classes, Constantes, Generics.Collections, DBXJSON, DBXJSONReflect, SysUtils;

type
  [TEntity]
  [TTable('TIPO_NOTA_FISCAL')]
  TTipoNotaFiscalVO = class(TJsonVO)
  private
    FID: Integer;
    FID_EMPRESA: Integer;
    FMODELO: String;
    FSERIE: String;
    FNOME: String;
    FDESCRICAO: String;
    FTEMPLATE: String;
    FNUMERO_ITENS: Integer;
    FULTIMO_IMPRESSO: Integer;

  public 
    [TId('ID')]
    [TGeneratedValue(sAuto)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property Id: Integer  read FID write FID;
    [TColumn('ID_EMPRESA','Id Empresa',80,[], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdEmpresa: Integer  read FID_EMPRESA write FID_EMPRESA;
    [TColumn('MODELO','Modelo',16,[ldGrid, ldLookup, ldCombobox], False)]
    property Modelo: String  read FMODELO write FMODELO;
    [TColumn('SERIE','Serie',16,[ldGrid, ldLookup, ldCombobox], False)]
    property Serie: String  read FSERIE write FSERIE;
    [TColumn('NOME','Nome',400,[ldGrid, ldLookup, ldCombobox], False)]
    property Nome: String  read FNOME write FNOME;
    [TColumn('DESCRICAO','Descricao',450,[ldGrid, ldLookup, ldCombobox], False)]
    property Descricao: String  read FDESCRICAO write FDESCRICAO;
    [TColumn('TEMPLATE','Template',450,[ldGrid, ldLookup, ldCombobox], False)]
    property Template: String  read FTEMPLATE write FTEMPLATE;
    [TColumn('NUMERO_ITENS','Numero Itens',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property NumeroItens: Integer  read FNUMERO_ITENS write FNUMERO_ITENS;
    [TColumn('ULTIMO_IMPRESSO','Ultimo Impresso',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property UltimoImpresso: Integer  read FULTIMO_IMPRESSO write FULTIMO_IMPRESSO;

  end;

implementation



end.
