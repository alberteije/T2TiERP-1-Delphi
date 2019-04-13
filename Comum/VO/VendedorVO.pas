{*******************************************************************************
Title: T2Ti ERP                                                                 
Description:  VO  relacionado à tabela [VENDEDOR] 
                                                                                
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
unit VendedorVO;

interface

uses
  JsonVO, Atributos, Classes, Constantes, Generics.Collections, DBXJSON, DBXJSONReflect, SysUtils,
  ColaboradorPessoaVO;

type
  [TEntity]
  [TTable('VENDEDOR')]
  TVendedorVO = class(TJsonVO)
  private
    FID: Integer;
    FID_COLABORADOR: Integer;
    FCOMISSAO: Extended;
    FMETA_VENDAS: Extended;
    FTIPO_COMISSAO: String;

    FColaboradorPessoaNome: String;

    FColaboradorVO: TColaboradorVO;


  public
    destructor Destroy; override;
    function ToJSON: TJSONValue; override;


    [TId('ID')]
    [TGeneratedValue(sAuto)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property Id: Integer  read FID write FID;
    [TColumn('ID_COLABORADOR','Id Colaborador',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdColaborador: Integer  read FID_COLABORADOR write FID_COLABORADOR;
    [TColumn('COLABORADORPESSOA.NOME', 'Nome Vendedor', 250, [ldGrid, ldLookup, ldComboBox], True, 'COLABORADOR', 'ID_COLABORADOR', 'ID')]
    property ColaboradorPessoaNome: String read FColaboradorPessoaNome write FColaboradorPessoaNome;


    [TColumn('COMISSAO','Comissao',128,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property Comissao: Extended  read FCOMISSAO write FCOMISSAO;
    [TColumn('META_VENDAS','Meta Vendas',128,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftFloatComSeparador, taRightJustify)]
    property MetaVendas: Extended  read FMETA_VENDAS write FMETA_VENDAS;
    [TColumn('TIPO_COMISSAO','Tipo Comissao',8,[ldGrid, ldLookup, ldCombobox], False)]
    property TipoComissao: String  read FTIPO_COMISSAO write FTIPO_COMISSAO;

    [TAssociation(True, 'ID', 'ID_COLABORADOR')]
    property ColaboradorVO: TColaboradorVO read FColaboradorVO write FColaboradorVO;


  end;

implementation

destructor TVendedorVO.Destroy;
begin
  if Assigned(FColaboradorVO) then
    FColaboradorVO.Free;

  inherited;
end;

function TVendedorVO.ToJSON: TJSONValue;
var
  Serializa: TJSONMarshal;
begin
  Serializa := TJSONMarshal.Create(TJSONConverter.Create);
  try
    if Assigned(Self.ColaboradorVO) then
    begin
      Self.ColaboradorPessoaNome := Self.ColaboradorVO.PessoaVO.Nome;
    end;

    Exit(Serializa.Marshal(Self));
  finally
    Serializa.Free;
  end;
end;

end.
