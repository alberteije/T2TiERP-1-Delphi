{*******************************************************************************
Title: T2Ti ERP
Description: Janela Cadastro de Matriz

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

@author Fernando L Oliveira
@version 1.0   |   Fernando  @version 1.0.0.10
*******************************************************************************}
unit UMatriz;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UTelaCadastro, DB, DBClient, Menus, StdCtrls, ExtCtrls, Buttons, Grids,
  DBGrids, JvExDBGrids, JvDBGrid, JvDBUltimGrid, ComCtrls, MatrizVO,
  MatrizController, Tipos, Atributos, Constantes, LabeledCtrls;

type
  [TFormDescription(TConstantes.MODULO_CADASTROS,'Matriz')]
  TFMatriz = class(TFTelaCadastro)
    BevelEdits: TBevel;
    EditNome: TLabeledEdit;
    EditCNPJ: TLabeledMaskEdit;
    procedure FormCreate(Sender: TObject);
    procedure EditCodigoExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
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
  FMatriz: TFMatriz;

implementation

{$R *.dfm}

procedure TFMatriz.FormCreate(Sender: TObject);
begin
  ClasseObjetoGridVO := TMatrizVO;
  ObjetoController := TMatrizController.Create;

  inherited;
end;

procedure TFMatriz.FormShow(Sender: TObject);
begin
  inherited;

end;

{$REGION 'Controles CRUD'}
function TFMatriz.DoInserir: Boolean;
begin
  Result := inherited DoInserir;

  if Result then
  begin
    EditNome.SetFocus;
  end;
end;

function TFMatriz.DoEditar: Boolean;
begin
  Result := inherited DoEditar;

  if Result then
  begin
    EditNome.SetFocus;
  end;
end;

function TFMatriz.DoExcluir: Boolean;
begin
  if inherited DoExcluir then
  begin
    try
      Result := TMatrizController(ObjetoController).Exclui(IdRegistroSelecionado);
    except
      Result := False;
    end;
  end
  else
  begin
    Result := False;
  end;

  if Result then
    TMatrizController(ObjetoController).Consulta(Filtro, Pagina);
end;

function TFMatriz.DoSalvar: Boolean;
begin
  Result := inherited DoSalvar;

  if Result then
  begin
    try
      if not Assigned(ObjetoVO) then
        ObjetoVO := TMatrizVO.Create;

      TMatrizVO(ObjetoVO).RazaoSocial := EditNome.Text;
      TMatrizVO(ObjetoVO).Cnpj        := EditCNPJ.Text;

      if StatusTela = stInserindo then
        TMatrizController(ObjetoController).Insere(TMatrizVO(ObjetoVO))
      else
      if StatusTela = stEditando then
      begin
        TMatrizVO(ObjetoVO).ID := IdRegistroSelecionado;
        TMatrizController(ObjetoController).Altera(TMatrizVO(ObjetoVO));
      end;

      Result := True;
    except
      Result := False;
    end;
  end;
end;
procedure TFMatriz.EditCodigoExit(Sender: TObject);
begin
  inherited;

end;

{$ENDREGION}

procedure TFMatriz.GridParaEdits;
begin
  inherited;

  if not CDSGrid.IsEmpty then
  begin
    ObjetoVO := ObjetoController.VO<TMatrizVO>(IdRegistroSelecionado);
  end;

  if Assigned(ObjetoVO) then
  begin
    EditNome.Text := TMatrizVO(ObjetoVO).RazaoSocial;
    EditCNPJ.Text := TMatrizVO(ObjetoVO).Cnpj;
  end;
end;

end.
