{ *******************************************************************************
  Title: T2Ti ERP
  Description: Janela Cadastro de Parâmetros

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

  @author Albert Eije (alberteije@gmail.com)
  @version 1.0
  ******************************************************************************* }

unit UParametrizacao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UTelaCadastro, Menus, StdCtrls, ExtCtrls, Buttons, Grids, DBGrids,
  JvExDBGrids, JvDBGrid, JvDBUltimGrid, ComCtrls, Mask, JvExMask, JvToolEdit,
  JvCombobox, LabeledCtrls, DBCtrls, LabeledDBCtrls, DB, DBClient, StrUtils,
  Math, JSonVO, Generics.Collections, Atributos, Constantes, CheckLst,
  JvExCheckLst, JvCheckListBox, JvBaseEdits, OleCtnrs, WideStrings, FMTBcd,
  Provider, SqlExpr, ActnList, ToolWin, ActnMan, ActnCtrls, ShellApi,
  PlatformDefaultStyleActnCtrls;

type
  [TFormDescription(TConstantes.MODULO_ADMINISTRATIVO, 'Tributação')]

  TFParametrizacao = class(TFTelaCadastro)
    ScrollBox: TScrollBox;
    BevelEdits: TBevel;
    PageControlDadosParametrizacao: TPageControl;
    tsCompras: TTabSheet;
    tsFinanceiro: TTabSheet;
    PanelFinanceiro: TPanel;
    EditIdEmpresa: TLabeledCalcEdit;
    EditEmpresa: TLabeledEdit;
    PanelCompras: TPanel;
    EditIdFinParcelaAberto: TLabeledCalcEdit;
    EditIdFinParcelaQuitado: TLabeledCalcEdit;
    EditIdFinParcelaQuitadoParcial: TLabeledCalcEdit;
    EditIdFinTipoRecebimentoEdi: TLabeledCalcEdit;
    EditIdCompraFinDocOrigem: TLabeledCalcEdit;
    EditIdCompraContaCaixa: TLabeledCalcEdit;
    procedure FormCreate(Sender: TObject);
    procedure EditIdEmpresaExit(Sender: TObject);
    procedure EditIdEmpresaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditIdEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure EditIdFinParcelaAbertoExit(Sender: TObject);
    procedure EditIdFinParcelaAbertoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditIdFinParcelaQuitadoExit(Sender: TObject);
    procedure EditIdFinParcelaQuitadoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditIdFinParcelaQuitadoParcialExit(Sender: TObject);
    procedure EditIdFinParcelaQuitadoParcialKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditIdFinTipoRecebimentoEdiExit(Sender: TObject);
    procedure EditIdFinTipoRecebimentoEdiKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditIdCompraFinDocOrigemExit(Sender: TObject);
    procedure EditIdCompraFinDocOrigemKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditIdCompraContaCaixaExit(Sender: TObject);
    procedure EditIdCompraContaCaixaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure GridParaEdits; override;

    // Controles CRUD
    function DoInserir: Boolean; override;
    function DoEditar: Boolean; override;
    function DoExcluir: Boolean; override;
    function DoSalvar: Boolean; override;

    procedure ConfigurarLayoutTela;
  end;

var
  FParametrizacao: TFParametrizacao;
  FormEditor: TForm;

implementation

uses UDataModule, ULookup, AdmParametroVO, AdmParametroController, EmpresaVO,
EmpresaController, FinStatusParcelaVO, FinStatusParcelaController,
FinTipoRecebimentoVO, FinTipoRecebimentoController,
FinDocumentoOrigemVO, FinDocumentoOrigemController, ContaCaixaVO, ContaCaixaController;
{$R *.dfm}

{$REGION 'Infra'}
procedure TFParametrizacao.FormCreate(Sender: TObject);
begin
  ClasseObjetoGridVO := TAdmParametroVO;
  ObjetoController := TAdmParametroController.Create;

  inherited;
end;

procedure TFParametrizacao.ConfigurarLayoutTela;
begin
  PanelEdits.Enabled := True;
  PageControlDadosParametrizacao.ActivePageIndex := 0;
end;
{$ENDREGION}

{$REGION 'Controles CRUD'}
function TFParametrizacao.DoInserir: Boolean;
begin
  Result := inherited DoInserir;

  ConfigurarLayoutTela;
  if Result then
  begin
    EditIdEmpresa.SetFocus;
  end;
end;

function TFParametrizacao.DoEditar: Boolean;
begin
  Result := inherited DoEditar;

  ConfigurarLayoutTela;
  if Result then
  begin
    EditIdEmpresa.SetFocus;
  end;
end;

function TFParametrizacao.DoExcluir: Boolean;
begin
  if inherited DoExcluir then
  begin
    try
      Result := TAdmParametroController(ObjetoController).Exclui(IdRegistroSelecionado);
    except
      Result := False;
    end;
  end
  else
  begin
    Result := False;
  end;

  if Result then
    TAdmParametroController(ObjetoController).Consulta(Filtro, Pagina);
end;

function TFParametrizacao.DoSalvar: Boolean;
begin
  Result := inherited DoSalvar;

  if Result then
  begin
    try
      if not Assigned(ObjetoVO) then
        ObjetoVO := TAdmParametroVO.Create;

      TAdmParametroVO(ObjetoVO).IdEmpresa := EditIdEmpresa.AsInteger;
      TAdmParametroVO(ObjetoVO).EmpresaRazaoSocial := EditEmpresa.Text;
      TAdmParametroVO(ObjetoVO).FinParcelaAberto := EditIdFinParcelaAberto.AsInteger;
      TAdmParametroVO(ObjetoVO).FinParcelaQuitado := EditIdFinParcelaQuitado.AsInteger;
      TAdmParametroVO(ObjetoVO).FinParcelaQuitadoParcial := EditIdFinParcelaQuitadoParcial.AsInteger;
      TAdmParametroVO(ObjetoVO).FinTipoRecebimentoEdi := EditIdFinTipoRecebimentoEdi.AsInteger;
      TAdmParametroVO(ObjetoVO).CompraFinDocOrigem := EditIdCompraFinDocOrigem.AsInteger;
      TAdmParametroVO(ObjetoVO).CompraContaCaixa := EditIdCompraContaCaixa.AsInteger;

      if StatusTela = stInserindo then
        Result := TAdmParametroController(ObjetoController).Insere(TAdmParametroVO(ObjetoVO))
      else if StatusTela = stEditando then
      begin
        if TAdmParametroVO(ObjetoVO).ToJSONString <> TAdmParametroVO(ObjetoOldVO).ToJSONString then
        begin
          TAdmParametroVO(ObjetoVO).Id := IdRegistroSelecionado;
          Result := TAdmParametroController(ObjetoController).Altera(TAdmParametroVO(ObjetoVO), TAdmParametroVO(ObjetoOldVO));
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

{$REGION 'Campos Transientes'}
procedure TFParametrizacao.EditIdCompraContaCaixaExit(Sender: TObject);
var
  Filtro: String;
begin
  if EditIdCompraContaCaixa.AsInteger <> 0 then
  begin
    try
      Filtro := 'ID = ' + QuotedStr(EditIdCompraContaCaixa.Text);
      EditIdCompraContaCaixa.Clear;
      if not PopulaCamposTransientes(Filtro, TContaCaixaVO, TContaCaixaController) then
        PopulaCamposTransientesLookup(TContaCaixaVO, TContaCaixaController);
      if CDSTransiente.RecordCount > 0 then
      begin
        EditIdCompraContaCaixa.AsInteger := CDSTransiente.FieldByName('ID').AsInteger;
      end
      else
      begin
        Exit;
        EditIdCompraContaCaixa.SetFocus;
      end;
    finally
      CDSTransiente.Close;
    end;
  end
  else
  begin
    EditIdCompraContaCaixa.Clear;
  end;
end;

procedure TFParametrizacao.EditIdCompraContaCaixaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditIdCompraContaCaixa.AsInteger := -1;
    EditIdCompraContaCaixa.OnExit(Sender);
    EditIdCompraFinDocOrigem.SetFocus;
  end;
  if Key = VK_RETURN then
    EditIdCompraFinDocOrigem.SetFocus;
end;

procedure TFParametrizacao.EditIdCompraFinDocOrigemExit(Sender: TObject);
var
  Filtro: String;
begin
  if EditIdCompraFinDocOrigem.AsInteger <> 0 then
  begin
    try
      Filtro := 'ID = ' + QuotedStr(EditIdCompraFinDocOrigem.Text);
      EditIdCompraFinDocOrigem.Clear;
      if not PopulaCamposTransientes(Filtro, TFinDocumentoOrigemVO, TFinDocumentoOrigemController) then
        PopulaCamposTransientesLookup(TFinDocumentoOrigemVO, TFinDocumentoOrigemController);
      if CDSTransiente.RecordCount > 0 then
      begin
        EditIdCompraFinDocOrigem.AsInteger := CDSTransiente.FieldByName('ID').AsInteger;
      end
      else
      begin
        Exit;
        EditIdCompraFinDocOrigem.SetFocus;
      end;
    finally
      CDSTransiente.Close;
    end;
  end
  else
  begin
    EditIdCompraFinDocOrigem.Clear;
  end;
end;

procedure TFParametrizacao.EditIdCompraFinDocOrigemKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditIdCompraFinDocOrigem.AsInteger := -1;
    EditIdCompraFinDocOrigem.OnExit(Sender);
    EditIdCompraContaCaixa.SetFocus;
  end;
  if Key = VK_RETURN then
    EditIdCompraContaCaixa.SetFocus;
end;

procedure TFParametrizacao.EditIdEmpresaExit(Sender: TObject);
var
  Filtro: String;
begin
  if EditIdEmpresa.Value <> 0 then
  begin
    try
      Filtro := 'ID = ' + EditIdEmpresa.Text;
      EditIdEmpresa.Clear;
      EditEmpresa.Clear;
      if not PopulaCamposTransientes(Filtro, TEmpresaVO, TEmpresaController) then
        PopulaCamposTransientesLookup(TEmpresaVO, TEmpresaController);

      if CDSTransiente.RecordCount > 0 then
      begin
        EditIdEmpresa.Text := CDSTransiente.FieldByName('ID').AsString;
        EditEmpresa.Text := CDSTransiente.FieldByName('RAZAO_SOCIAL').AsString;
      end
      else
      begin
        Exit;
        EditIdEmpresa.SetFocus;
      end;
    finally
      CDSTransiente.Close;
    end;
  end
  else
  begin
    EditEmpresa.Clear;
  end;
end;

procedure TFParametrizacao.EditIdEmpresaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditIdEmpresa.Value := -1;
    PageControlDadosParametrizacao.ActivePageIndex := 0;
    EditIdFinParcelaAberto.SetFocus;
  end;
end;

procedure TFParametrizacao.EditIdEmpresaKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    PageControlDadosParametrizacao.ActivePageIndex := 0;
    EditIdFinParcelaAberto.SetFocus;
  end;
end;

procedure TFParametrizacao.EditIdFinParcelaAbertoExit(Sender: TObject);
var
  Filtro: String;
begin
  if EditIdFinParcelaAberto.AsInteger <> 0 then
  begin
    try
      Filtro := 'ID = ' + QuotedStr(EditIdFinParcelaAberto.Text);
      EditIdFinParcelaAberto.Clear;
      if not PopulaCamposTransientes(Filtro, TFinStatusParcelaVO, TFinStatusParcelaController) then
        PopulaCamposTransientesLookup(TFinStatusParcelaVO, TFinStatusParcelaController);
      if CDSTransiente.RecordCount > 0 then
      begin
        EditIdFinParcelaAberto.AsInteger := CDSTransiente.FieldByName('ID').AsInteger;
      end
      else
      begin
        Exit;
        EditIdFinParcelaAberto.SetFocus;
      end;
    finally
      CDSTransiente.Close;
    end;
  end
  else
  begin
    EditIdFinParcelaAberto.Clear;
  end;
end;

procedure TFParametrizacao.EditIdFinParcelaAbertoKeyDown(Sender: TObject;  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditIdFinParcelaAberto.AsInteger := -1;
    EditIdFinParcelaAberto.OnExit(Sender);
    EditIdFinParcelaQuitado.SetFocus;
  end;
  if Key = VK_RETURN then
    EditIdFinParcelaQuitado.SetFocus;
end;

procedure TFParametrizacao.EditIdFinParcelaQuitadoExit(Sender: TObject);
var
  Filtro: String;
begin
  if EditIdFinParcelaQuitado.AsInteger <> 0 then
  begin
    try
      Filtro := 'ID = ' + QuotedStr(EditIdFinParcelaQuitado.Text);
      EditIdFinParcelaQuitado.Clear;
      if not PopulaCamposTransientes(Filtro, TFinStatusParcelaVO, TFinStatusParcelaController) then
        PopulaCamposTransientesLookup(TFinStatusParcelaVO, TFinStatusParcelaController);
      if CDSTransiente.RecordCount > 0 then
      begin
        EditIdFinParcelaQuitado.AsInteger := CDSTransiente.FieldByName('ID').AsInteger;
      end
      else
      begin
        Exit;
        EditIdFinParcelaQuitado.SetFocus;
      end;
    finally
      CDSTransiente.Close;
    end;
  end
  else
  begin
    EditIdFinParcelaQuitado.Clear;
  end;
end;

procedure TFParametrizacao.EditIdFinParcelaQuitadoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditIdFinParcelaQuitado.AsInteger := -1;
    EditIdFinParcelaQuitado.OnExit(Sender);
    EditIdFinParcelaQuitadoParcial.SetFocus;
  end;
  if Key = VK_RETURN then
    EditIdFinParcelaQuitadoParcial.SetFocus;
end;

procedure TFParametrizacao.EditIdFinParcelaQuitadoParcialExit(Sender: TObject);
var
  Filtro: String;
begin
  if EditIdFinParcelaQuitadoParcial.AsInteger <> 0 then
  begin
    try
      Filtro := 'ID = ' + QuotedStr(EditIdFinParcelaQuitadoParcial.Text);
      EditIdFinParcelaQuitadoParcial.Clear;
      if not PopulaCamposTransientes(Filtro, TFinStatusParcelaVO, TFinStatusParcelaController) then
        PopulaCamposTransientesLookup(TFinStatusParcelaVO, TFinStatusParcelaController);
      if CDSTransiente.RecordCount > 0 then
      begin
        EditIdFinParcelaQuitadoParcial.AsInteger := CDSTransiente.FieldByName('ID').AsInteger;
      end
      else
      begin
        Exit;
        EditIdFinParcelaQuitadoParcial.SetFocus;
      end;
    finally
      CDSTransiente.Close;
    end;
  end
  else
  begin
    EditIdFinParcelaQuitadoParcial.Clear;
  end;
end;

procedure TFParametrizacao.EditIdFinParcelaQuitadoParcialKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditIdFinParcelaQuitadoParcial.AsInteger := -1;
    EditIdFinParcelaQuitadoParcial.OnExit(Sender);
    EditIdFinTipoRecebimentoEdi.SetFocus;
  end;
  if Key = VK_RETURN then
    EditIdFinTipoRecebimentoEdi.SetFocus;
end;

procedure TFParametrizacao.EditIdFinTipoRecebimentoEdiExit(Sender: TObject);
var
  Filtro: String;
begin
  if EditIdFinTipoRecebimentoEdi.AsInteger <> 0 then
  begin
    try
      Filtro := 'ID = ' + QuotedStr(EditIdFinTipoRecebimentoEdi.Text);
      EditIdFinTipoRecebimentoEdi.Clear;
      if not PopulaCamposTransientes(Filtro, TFinTipoRecebimentoVO, TFinTipoRecebimentoController) then
        PopulaCamposTransientesLookup(TFinTipoRecebimentoVO, TFinTipoRecebimentoController);
      if CDSTransiente.RecordCount > 0 then
      begin
        EditIdFinTipoRecebimentoEdi.AsInteger := CDSTransiente.FieldByName('ID').AsInteger;
      end
      else
      begin
        Exit;
        EditIdFinTipoRecebimentoEdi.SetFocus;
      end;
    finally
      CDSTransiente.Close;
    end;
  end
  else
  begin
    EditIdFinTipoRecebimentoEdi.Clear;
  end;
end;

procedure TFParametrizacao.EditIdFinTipoRecebimentoEdiKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    EditIdFinTipoRecebimentoEdi.AsInteger := -1;
    EditIdFinTipoRecebimentoEdi.OnExit(Sender);
    EditIdFinParcelaAberto.SetFocus;
  end;
  if Key = VK_RETURN then
    EditIdFinParcelaAberto.SetFocus;
end;
{$ENDREGION}

{$REGION 'Controle de Grid'}
procedure TFParametrizacao.GridParaEdits;
begin
  inherited;

  if not CDSGrid.IsEmpty then
  begin
    ObjetoVO := ObjetoController.VO<TAdmParametroVO>(IdRegistroSelecionado);
    if StatusTela = stEditando then
      ObjetoOldVO := ObjetoVO.Clone;
  end;

  if Assigned(ObjetoVO) then
  begin
    EditIdEmpresa.AsInteger := TAdmParametroVO(ObjetoVO).IdEmpresa;
    EditEmpresa.Text := TAdmParametroVO(ObjetoVO).EmpresaRazaoSocial;
    EditIdFinParcelaAberto.AsInteger := TAdmParametroVO(ObjetoVO).FinParcelaAberto;
    EditIdFinParcelaQuitado.AsInteger := TAdmParametroVO(ObjetoVO).FinParcelaQuitado;
    EditIdFinParcelaQuitadoParcial.AsInteger := TAdmParametroVO(ObjetoVO).FinParcelaQuitadoParcial;
    EditIdFinTipoRecebimentoEdi.AsInteger := TAdmParametroVO(ObjetoVO).FinTipoRecebimentoEdi;
    EditIdCompraFinDocOrigem.AsInteger := TAdmParametroVO(ObjetoVO).CompraFinDocOrigem;
    EditIdCompraContaCaixa.AsInteger := TAdmParametroVO(ObjetoVO).CompraContaCaixa;
  end;
end;
{$ENDREGION}

end.
