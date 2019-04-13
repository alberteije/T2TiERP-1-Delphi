{*******************************************************************************
Title: T2Ti ERP                                                                 
Description:  VO  relacionado à tabela [AUDITORIA] 
                                                                                
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
unit AuditoriaVO;

interface

uses
  JsonVO, Atributos, Classes, Constantes, Generics.Collections, DBXJSON, DBXJSONReflect,
  SysUtils, UsuarioVO;

type
  [TEntity]
  [TTable('AUDITORIA')]
  TAuditoriaVO = class(TJsonVO)
  private
    FID: Integer;
    FID_USUARIO: Integer;
    FDATA_REGISTRO: TDateTime;
    FHORA_REGISTRO: String;
    FLOCAL: String;
    FACAO: String;
    FCONTEUDO: String;

    FUsuarioLogin: String;
    FUsuarioVO: TUsuarioVO;

  public 
    destructor Destroy; override;
    function ToJSON: TJSONValue; override;

    [TId('ID')]
    [TGeneratedValue(sAuto)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property Id: Integer  read FID write FID;

    [TColumn('ID_USUARIO','Id Usuario',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property IdUsuario: Integer  read FID_USUARIO write FID_USUARIO;
    [TColumn('USUARIO.LOGIN','Usuário',300,[ldGrid,ldLookup,ldComboBox],True,'USUARIO','ID_USUARIO','ID')]
    property UsuarioLogin: string read FUsuarioLogin write FUsuarioLogin;

    [TColumn('DATA_REGISTRO','Data Registro',80,[ldGrid, ldLookup, ldCombobox], False)]
    property DataRegistro: TDateTime  read FDATA_REGISTRO write FDATA_REGISTRO;
    [TColumn('HORA_REGISTRO','Hora Registro',64,[ldGrid, ldLookup, ldCombobox], False)]
    property HoraRegistro: String  read FHORA_REGISTRO write FHORA_REGISTRO;
    [TColumn('LOCAL','Local',400,[ldGrid, ldLookup, ldCombobox], False)]
    property Local: String  read FLOCAL write FLOCAL;
    [TColumn('ACAO','Acao',400,[ldGrid, ldLookup, ldCombobox], False)]
    property Acao: String  read FACAO write FACAO;
    [TColumn('CONTEUDO','Conteudo',450,[ldGrid, ldLookup, ldCombobox], False)]
    property Conteudo: String  read FCONTEUDO write FCONTEUDO;

    [TAssociation(False, 'ID', 'ID_USUARIO', 'USUARIO')]
    property UsuarioVO: TUsuarioVO read FUsuarioVO write FUsuarioVO;

  end;

implementation

destructor TAuditoriaVO.Destroy;
begin
  if Assigned(FUsuarioVO) then
    FUsuarioVO.Free;
  inherited;
end;

function TAuditoriaVO.ToJSON: TJSONValue;
var
  Serializa: TJSONMarshal;
begin
  Serializa := TJSONMarshal.Create(TJSONConverter.Create);
  try
    if Assigned(Self.UsuarioVO) then
      Self.UsuarioLogin := Self.UsuarioVO.Login;

    Exit(Serializa.Marshal(Self));
  finally
    Serializa.Free;
  end;
end;


end.
