{*******************************************************************************
Title: T2Ti ERP                                                                 
Description:  VO transiente relacionado à tabela [CLIENTE] para diminuir o tráfego
na rede trazendo os dados necessários para uma pesquisa simples do cliente
                                                                  
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
unit ClientePessoaVO;

interface

uses
  JsonVO, Atributos, Classes, Constantes, Generics.Collections, DBXJSON, DBXJSONReflect,
  SysUtils, PessoaFisicaJuridicaVO;

type
  [TEntity]
  [TTable('CLIENTE')]
  TClienteVO = class(TJsonVO)
  private
    FID: Integer;
    FID_PESSOA: Integer;
    FDESDE: TDateTime;
    FDATA_CADASTRO: TDateTime;

    FPessoaNome: String;
    FPessoaVO: TPessoaVO;

  public
    destructor Destroy; override;
    function ToJSON: TJSONValue; override;

    [TId('ID')]
    [TGeneratedValue(sAuto)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property Id: Integer  read FID write FID;

    [TColumn('ID_PESSOA','Id Pessoa',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdPessoa: Integer  read FID_PESSOA write FID_PESSOA;
    [TColumn('PESSOA.NOME', 'Nome', 250, [ldGrid, ldLookup, ldComboBox], True, 'PESSOA', 'ID_PESSOA', 'ID')]
    property PessoaNome: String read FPessoaNome write FPessoaNome;

    [TColumn('DESDE','Desde',80,[ldGrid, ldLookup, ldCombobox], False)]
    property Desde: TDateTime  read FDESDE write FDESDE;
    [TColumn('DATA_CADASTRO','Data Cadastro',80,[ldGrid, ldLookup, ldCombobox], False)]
    property DataCadastro: TDateTime  read FDATA_CADASTRO write FDATA_CADASTRO;

    [TAssociation(True, 'ID', 'ID_PESSOA', 'PESSOA')]
    property PessoaVO: TPessoaVO read FPessoaVO write FPessoaVO;

  end;

implementation

destructor TClienteVO.Destroy;
begin
  if Assigned(FPessoaVO) then
    FPessoaVO.Free;
  inherited;
end;

function TClienteVO.ToJSON: TJSONValue;
var
  Serializa: TJSONMarshal;
begin
  Serializa := TJSONMarshal.Create(TJSONConverter.Create);
  try
    if Assigned(Self.PessoaVO) then
      Self.PessoaNome := Self.PessoaVO.Nome;

    Exit(Serializa.Marshal(Self));
  finally
    Serializa.Free;
  end;
end;

end.

