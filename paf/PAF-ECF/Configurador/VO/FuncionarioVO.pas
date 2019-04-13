{*******************************************************************************
Title: T2Ti ERP
Description: VO do funcionário.

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
unit FuncionarioVO;

interface

type
  TFuncionarioVO = class
  private
    FID: Integer;
	  FNOME: String;
    FTELEFONE: String;
  	FCELULAR: String;
	  FEMAIL: String;
  	FCOMISSAO_VISTA: Extended;
	  FCOMISSAO_PRAZO: Extended;
  	FNIVEL_AUTORIZACAO: String;

  published

    property Id: Integer read FID write FID;
    property Nome: String read FNOME write FNOME;
    property Telefone: String read FTELEFONE write FTELEFONE;
    property Celular: String read FCELULAR write FCELULAR;
    property Email: String read FEMAIL write FEMAIL;
    property ComissaoVista: Extended read FCOMISSAO_VISTA write FCOMISSAO_VISTA;
    property ComissaoPrazo: Extended read FCOMISSAO_PRAZO write FCOMISSAO_PRAZO;
    property NivelAutorizacao: String read FNIVEL_AUTORIZACAO write FNIVEL_AUTORIZACAO;

  end;

implementation

end.