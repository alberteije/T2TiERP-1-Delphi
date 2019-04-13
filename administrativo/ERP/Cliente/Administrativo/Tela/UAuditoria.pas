{*******************************************************************************
Title: T2Ti ERP
Description: Módulo Administrativo - Auditoria

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

@author Albert Eije
@version 1.0   |   Fernando  @version 1.0.0.10
*******************************************************************************}

unit UAuditoria;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UTelaCadastro, Menus, StdCtrls, ExtCtrls, Buttons, Grids, DBGrids,
  JvExDBGrids, JvDBGrid, JvDBUltimGrid, ComCtrls, AuditoriaVO, AuditoriaController,
  Atributos, Constantes, LabeledCtrls, Mask, JvExMask, JvToolEdit;

type
  [TFormDescription(TConstantes.MODULO_ADMINISTRATIVO, 'Auditoria')]
  TFAuditoria = class(TFTelaCadastro)
    EditIdUsuario: TLabeledEdit;
    BevelEdits: TBevel;
    EditAcao: TLabeledEdit;
    EditLoginUsuario: TLabeledEdit;
    EditDataRegistro: TLabeledDateEdit;
    EditHoraRegistro: TLabeledMaskEdit;
    EditLocal: TLabeledEdit;
    MemoConteudo: TLabeledMemo;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure GridParaEdits; override;

    procedure ControlaBotoes; override;
  end;

var
  FAuditoria: TFAuditoria;

implementation

{$R *.dfm}

{$REGION 'Infra'}
procedure TFAuditoria.FormCreate(Sender: TObject);
begin
  ClasseObjetoGridVO := TAuditoriaVO;
  ObjetoController := TAuditoriaController.Create;

  inherited;
end;

procedure TFAuditoria.ControlaBotoes;
begin
  inherited;

  BotaoInserir.Visible := False;
  BotaoAlterar.Visible := False;
  BotaoExcluir.Visible := False;
  BotaoSalvar.Visible := False;
end;
{$ENDREGION}

{$REGION 'Controle de Grid'}
procedure TFAuditoria.GridParaEdits;
begin
  inherited;

  if not CDSGrid.IsEmpty then
  begin
    ObjetoVO := ObjetoController.VO<TAuditoriaVO>(IdRegistroSelecionado);
  end;

  if Assigned(ObjetoVO) then
  begin
    EditIdUsuario.Text := IntToStr(TAuditoriaVO(ObjetoVO).IdUsuario);
    EditLoginUsuario.Text := TAuditoriaVO(ObjetoVO).UsuarioLogin;
    EditDataRegistro.Date := TAuditoriaVO(ObjetoVO).DataRegistro;
    EditHoraRegistro.Text := TAuditoriaVO(ObjetoVO).HoraRegistro;
    EditLocal.Text := TAuditoriaVO(ObjetoVO).Local;
    EditAcao.Text := TAuditoriaVO(ObjetoVO).Acao;
    MemoConteudo.Text := TAuditoriaVO(ObjetoVO).Conteudo;
  end;
end;
{$ENDREGION}

end.
