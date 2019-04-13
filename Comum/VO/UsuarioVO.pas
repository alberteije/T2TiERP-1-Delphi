{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: VO relacionado à tabela [USUARIO]
                                                                                
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
                                                                                
@author Albert Eije (T2Ti.COM)                                                  
@version 1.0                                                                    
*******************************************************************************}
unit UsuarioVO;

interface

uses
  JsonVO, Atributos, Classes, Constantes, Generics.Collections, DBXJSON, DBXJSONReflect, SysUtils,
  ColaboradorVO, PapelVO;

type
  [TEntity]
  [TTable('USUARIO')]
  TUsuarioVO = class(TJsonVO)
  private
    FID: Integer;
    FID_COLABORADOR: Integer;
    FID_PAPEL: Integer;
    FLOGIN: String;
    FSENHA: String;
    FDATA_CADASTRO: TDateTime;
    FADMINISTRADOR: String;

    FColaboradorNome: String;
    FPapelNome: String;

    FColaboradorVO: TColaboradorVO;
    FPapelVO: TPapelVO;

  public
    destructor Destroy; override;
    function ToJSON: TJSONValue; override;

    [TId('ID')]
    [TGeneratedValue(sAuto)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property Id: Integer  read FID write FID;

    [TColumn('ID_COLABORADOR', 'Id Colaborador', 80, [ldGrid, ldComboBox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]    property IdColaborador: Integer  read FID_COLABORADOR write FID_COLABORADOR;
    [TColumn('COLABORADOR.NOME', 'Nome Colaborador', 350, [ldGrid], True)]
    property ColaboradorNome: String read FColaboradorNome write FColaboradorNome;

    [TColumn('ID_PAPEL', 'Id Papel', 80, [ldGrid, ldComboBox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdPapel: Integer  read FID_PAPEL write FID_PAPEL;
    [TColumn('PAPEL.NOME', 'Nome Papel', 250, [ldGrid, ldLookup, ldComboBox], True)]
    property PapelNome: String read FPapelNome write FPapelNome;

    [TColumn('LOGIN','Login',[ldGrid, ldLookup],False)]
    property Login: String  read FLOGIN write FLOGIN;
    [TColumn('SENHA')]
    property Senha: String  read FSENHA write FSENHA;
    [TColumn('DATA_CADASTRO','Data do Cadastro',[ldGrid],False)]
    property DataCadastro: TDateTime  read FDATA_CADASTRO write FDATA_CADASTRO;
    [TColumn('ADMINISTRADOR')]
    property Administrador: String read FADMINISTRADOR write FADMINISTRADOR;

    [TAssociation(True, 'ID', 'ID_COLABORADOR')]
    property ColaboradorVO: TColaboradorVO read FColaboradorVO write FColaboradorVO;

    [TAssociation(False, 'ID', 'ID_PAPEL')]
    property PapelVO: TPapelVO read FPapelVO write FPapelVO;
  end;

implementation

destructor TUsuarioVO.Destroy;
begin
  if Assigned(FColaboradorVO) then
    FColaboradorVO.Free;
  if Assigned(FPapelVO) then
    FPapelVO.Free;
  inherited;
end;

function TUsuarioVO.ToJSON: TJSONValue;
var
  Serializa: TJSONMarshal;
begin
  Serializa := TJSONMarshal.Create(TJSONConverter.Create);
  try
    if Assigned(Self.ColaboradorVO) then
      Self.ColaboradorNome := Self.ColaboradorVO.PessoaVO.Nome;
    if Assigned(Self.PapelVO) then
      Self.PapelNome := Self.PapelVO.Nome;

    Exit(Serializa.Marshal(Self));
  finally
    Serializa.Free;
  end;
end;

end.
