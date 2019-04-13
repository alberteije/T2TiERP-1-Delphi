{*******************************************************************************
Title: T2Ti ERP
Description: Janela Cadastro de Fap

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

@author Fábio Thomaz (fabio_thz@yahoo.com.br)
@version 1.0
*******************************************************************************}
unit UFap;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UTelaCadastro, DB, DBClient, Menus, StdCtrls, ExtCtrls, Buttons, Grids,
  DBGrids, JvExDBGrids, JvDBGrid, JvDBUltimGrid, ComCtrls, FapVO,
  FapController, Tipos, Atributos, Constantes, LabeledCtrls, JvToolEdit,
  Mask, JvExMask, JvBaseEdits,Math,StrUtils;

type
  [TFormDescription(TConstantes.MODULO_CADASTROS,'Fap')]
  TFFap = class(TFTelaCadastro)
    BevelEdits: TBevel;
    EditEmpresa: TLabeledEdit;
    EditDataInicial: TLabeledDateEdit;
    EditFap: TLabeledCalcEdit;
    EditDataFinal: TLabeledDateEdit;
    EditIdEmpresa: TLabeledCalcEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure GridDblClick(Sender: TObject);
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

    procedure PopulaEditEmpresa(Sender: TObject);

  end;

var
  FFap: TFFap;

implementation

uses ULookup,  Biblioteca, UDataModule, EmpresaController, EmpresaVO;

{$R *.dfm}
{$REGION 'Infra'}
procedure TFFap.FormCreate(Sender: TObject);
begin
  ClasseObjetoGridVO := TFapVO;
  ObjetoController := TFapController.Create;

  inherited;
end;

procedure TFFap.FormShow(Sender: TObject);
begin
  inherited;

end;
{$ENDREGION}
{$REGION 'Controles CRUD'}
function TFFap.DoInserir: Boolean;
begin
  Result := inherited DoInserir;

  if Result then
  begin
    EditIdEmpresa.AsInteger := Sessao.IdEmpresa;
    PopulaEditEmpresa(Self);
    EditFap.SetFocus;
  end;
end;

function TFFap.DoEditar: Boolean;
begin
  Result := inherited DoEditar;

  if Result then
  begin
    EditIdEmpresa.AsInteger := Sessao.IdEmpresa;
    PopulaEditEmpresa(Self);
    EditFap.SetFocus;
  end;
end;

function TFFap.DoExcluir: Boolean;
begin
  if inherited DoExcluir then
  begin
    try
      Result := TFapController(ObjetoController).Exclui(IdRegistroSelecionado);
    except
      Result := False;
    end;
  end
  else
  begin
    Result := False;
  end;

  if Result then
    TFapController(ObjetoController).Consulta(Filtro, Pagina);
end;

function TFFap.DoSalvar: Boolean;
begin
  if EditFap.AsInteger = 0 then
  begin
    Mensagem('Informe o valor do fap.');
    EditFap.SetFocus;
    Exit(False);
  end;
  if EditDataInicial.Text = '  /  /    ' then
  begin
    Mensagem('Informe a data inicial.');
    EditDataInicial.SetFocus;
    Exit(False);
  end;
  if EditDataFinal.Text = '  /  /    ' then
  begin
    Mensagem('Informe a data final.');
    EditDataFinal.SetFocus;
    Exit(False);
  end;
  Result := inherited DoSalvar;

  if Result then
  begin
    try
      if not Assigned(ObjetoVO) then
        ObjetoVO := TFapVO.Create;

      TFapVO(ObjetoVO).IdEmpresa   := StrToInt(EditIdEmpresa.Text);
      TFapVO(ObjetoVO).Fap         := EditFap.Value;
      TFapVO(ObjetoVO).DataInicial := EditDataInicial.Date;
      TFapVO(ObjetoVO).DataFinal   := EditDataFinal.Date;

      if StatusTela = stInserindo then
        Result := TFapController(ObjetoController).Insere(TFapVO(ObjetoVO))
      else
      if StatusTela = stEditando then
      begin
        if TFapVO(ObjetoVO).ToJSONString <> TFapVO(ObjetoOldVO).ToJSONString then
        begin
          TFapVO(ObjetoVO).ID := IdRegistroSelecionado;
          Result := TFapController(ObjetoController).Altera(TFapVO(ObjetoVO), TFapVO(ObjetoOldVO));
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
{$REGION 'Controle Grid'}
procedure TFFap.GridDblClick(Sender: TObject);
begin
  inherited;
  EditIdEmpresa.AsInteger := Sessao.IdEmpresa;
  PopulaEditEmpresa(Self);
end;

procedure TFFap.GridParaEdits;
begin
  inherited;

  if not CDSGrid.IsEmpty then
  begin
    ObjetoVO := ObjetoController.VO<TFapVO>(IdRegistroSelecionado);
    if StatusTela = stEditando then
      ObjetoOldVO := ObjetoController.VO<TFapVO>(IdRegistroSelecionado);
  end;

  if Assigned(ObjetoVO) then
  begin
    EditIdEmpresa.Text   := IntToStr(TFapVO(ObjetoVO).IdEmpresa);
    PopulaEditEmpresa(Self);
    EditFap.Value        := TFapVO(ObjetoVO).Fap;
    EditDataInicial.Date := TFapVO(ObjetoVO).DataInicial;
    EditDataFinal.Date   := TFapVO(ObjetoVO).DataFinal;

  end;

end;
{$ENDREGION}
{$REGION 'Campos Transientes'}
procedure TFFap.PopulaEditEmpresa(Sender: TObject);
var
  Filtro: String;
begin

  Filtro := 'ID = ' + EditIdEmpresa.Text;

  ConfiguraCDSFromVO(FDataModule.CDSLookup, TEmpresaVO);

  TEmpresaController.SetDataSet(FDataModule.CDSLookup);
  TEmpresaController.Consulta(Filtro,0);
  try
    if (FDataModule.CDSLookup.FieldByName('ID').AsString <> '') then
    begin
      EditIdEmpresa.Text := FDataModule.CDSLookup.FieldByName('ID').AsString;
      EditEmpresa.Text   := FDataModule.CDSLookup.FieldByName('RAZAO_SOCIAL').AsString;
    end
    else
    begin
      EditIdEmpresa.SetFocus;
      keybd_event(VK_F1, 0, 0, 0);
    end;
  finally
    FDataModule.CDSLookup.Close;
  end;
end;
{$ENDREGION}
end.
