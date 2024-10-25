{*******************************************************************************
Title: T2Ti ERP
Description: Janela Cadastro de TipoColaborador

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
unit UTipoColaborador;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UTelaCadastro, DB, DBClient, Menus, StdCtrls, ExtCtrls, Buttons, Grids,
  DBGrids, JvExDBGrids, JvDBGrid, JvDBUltimGrid, ComCtrls, TipoColaboradorVO,
  TipoColaboradorController, Tipos, Atributos, Constantes, LabeledCtrls;

type
  [TFormDescription(TConstantes.MODULO_CADASTROS,'Tipo Colaborador')]
  TFTipoColaborador = class(TFTelaCadastro)
    BevelEdits: TBevel;
    EditNome: TLabeledEdit;
    MemoDescricao: TLabeledMemo;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure GridParaEdits; override;

    //Controles CRUD
    function DoInserir: Boolean; override;
    function DoEditar: Boolean; override;
    function DoExcluir: Boolean; override;
    function DoSalvar: Boolean; override;
  end;

var
  FTipoColaborador: TFTipoColaborador;

implementation

{$R *.dfm}

{$REGION 'Infra'}
procedure TFTipoColaborador.FormCreate(Sender: TObject);
begin
  ClasseObjetoGridVO := TTipoColaboradorVO;
  ObjetoController := TTipoColaboradorController.Create;

  inherited;
end;
{$ENDREGION}

{$REGION 'Controles CRUD'}
function TFTipoColaborador.DoInserir: Boolean;
begin
  Result := inherited DoInserir;

  if Result then
  begin
    EditNome.SetFocus;
  end;
end;

function TFTipoColaborador.DoEditar: Boolean;
begin
  Result := inherited DoEditar;

  if Result then
  begin
    EditNome.SetFocus;
  end;
end;

function TFTipoColaborador.DoExcluir: Boolean;
begin
  if inherited DoExcluir then
  begin
    try
      Result := TTipoColaboradorController(ObjetoController).Exclui(IdRegistroSelecionado);
    except
      Result := False;
    end;
  end
  else
  begin
    Result := False;
  end;

  if Result then
    TTipoColaboradorController(ObjetoController).Consulta(Filtro, Pagina);
end;

function TFTipoColaborador.DoSalvar: Boolean;
begin
  Result := inherited DoSalvar;

  if Result then
  begin
    try
      if not Assigned(ObjetoVO) then
        ObjetoVO := TTipoColaboradorVO.Create;

      TTipoColaboradorVO(ObjetoVO).Nome      := EditNome.Text;
      TTipoColaboradorVO(ObjetoVO).Descricao := MemoDescricao.Text;

      if StatusTela = stInserindo then
        Result := TTipoColaboradorController(ObjetoController).Insere(TTipoColaboradorVO(ObjetoVO))
      else if StatusTela = stEditando then
      begin
        if TTipoColaboradorVO(ObjetoVO).ToJSONString <> TTipoColaboradorVO(ObjetoOldVO).ToJSONString then
        begin
          TTipoColaboradorVO(ObjetoVO).Id := IdRegistroSelecionado;
          Result := TTipoColaboradorController(ObjetoController).Altera(TTipoColaboradorVO(ObjetoVO), TTipoColaboradorVO(ObjetoOldVO));
        end
        else
          Application.MessageBox('Nenhum dado foi alterado.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
      end;
    except
      Result := False;
    end;
  end;
end;
{$ENDREGION}

{$REGION 'Controle de Grid'}
procedure TFTipoColaborador.GridParaEdits;
begin
  inherited;

  if not CDSGrid.IsEmpty then
  begin
    ObjetoVO := ObjetoController.VO<TTipoColaboradorVO>(IdRegistroSelecionado);
    if StatusTela = stEditando then
      ObjetoOldVO := ObjetoVO.Clone;
  end;

  if Assigned(ObjetoVO) then
  begin
    EditNome.Text      := TTipoColaboradorVO(ObjetoVO).Nome;
    MemoDescricao.Text := TTipoColaboradorVO(ObjetoVO).Descricao;
  end;
end;
{$ENDREGION}

end.
