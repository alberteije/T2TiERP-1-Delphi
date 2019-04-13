{*******************************************************************************
Title: T2Ti ERP
Description: Unit de controle Base - Servidor.

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

@author Fábio Thomaz | Albert Eije (T2Ti.COM)
@version 1.0
*******************************************************************************}
unit Controller;

interface

uses
  Classes, DSServer, DBXJSON, SessaoUsuario, AuditoriaVO, T2TiORM, SysUtils;

type
  {$METHODINFO ON}
  TController = class(TPersistent)
  public
    function Sessao(pIdSessao: String): TSessaoUsuario;
    procedure AuditoriaSistema(pIdSessao: String; pAcao:String; pConteudo: String);
  end;
  {$METHODINFO OFF}

implementation

{ TController }

function TController.Sessao(pIdSessao: String): TSessaoUsuario;
begin
  Result := TListaSessaoUsuario.Instance.GetSessao(pIdSessao);
end;

procedure TController.AuditoriaSistema(pIdSessao: String; pAcao:String; pConteudo: String);
var
  AuditoriaVO: TAuditoriaVO;
begin
  AuditoriaVO := TAuditoriaVO.Create;
  //
  AuditoriaVO.IdUsuario := Sessao(pIdSessao).Usuario.Id;
  AuditoriaVO.DataRegistro := Now;
  AuditoriaVO.HoraRegistro := FormatDateTime('hh:mm:ss', Now);
  AuditoriaVO.Local := Self.ClassName;
  AuditoriaVO.Acao := pAcao;
  AuditoriaVO.Conteudo := pConteudo;
  //
  TT2TiORM.Inserir(AuditoriaVO)
end;

end.
