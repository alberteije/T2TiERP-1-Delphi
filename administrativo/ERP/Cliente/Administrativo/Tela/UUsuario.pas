{ *******************************************************************************
  Title: T2Ti ERP
  Description: Janela Cadastro de Usuários

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
  ******************************************************************************* }
unit UUsuario;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UTelaCadastro, Menus, StdCtrls, ExtCtrls, Buttons, Grids, DBGrids,
  JvExDBGrids, JvDBGrid, JvDBUltimGrid, ComCtrls, UsuarioController, UsuarioVO,
  DBCtrls, DB, DBClient, NotificationService, Constantes, Atributos,
  LabeledCtrls;

type
  [TFormDescription(TConstantes.MODULO_SEGURANCA, 'Usuário')]

  TFUsuario = class(TFTelaCadastro)
    ComboBoxColaborador: TDBLookupComboBox;
    Label1: TLabel;
    BevelEdits: TBevel;
    ComboBoxPapel: TDBLookupComboBox;
    Label2: TLabel;
    EditSenha: TLabeledEdit;
    EditLogin: TLabeledEdit;
    cdsColaborador: TClientDataSet;
    dsColaborador: TDataSource;
    cdsPapel: TClientDataSet;
    dsPapel: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure GridParaEdits; override;
    procedure LimparCampos; override;

    // Controles CRUD
    function DoInserir: Boolean; override;
    function DoEditar: Boolean; override;
    function DoExcluir: Boolean; override;
    function DoSalvar: Boolean; override;

    procedure PopulaComboColaborador(Sender: TObject);
    procedure PopulaComboPapel(Sender: TObject);

  end;

var
  FUsuario: TFUsuario;

implementation

uses ULookup, PapelController, PapelVO, ColaboradorController, ColaboradorVO, Biblioteca, UDataModule;
{$R *.dfm}

{$REGION 'Infra'}
procedure TFUsuario.FormCreate(Sender: TObject);
begin
  ClasseObjetoGridVO := TUsuarioVO;
  ObjetoController := TUsuarioController.Create;

  inherited;

  PopulaComboColaborador(Self);
  PopulaComboPapel(Self);

  GetNotificationService.Subscribe(PopulaComboColaborador, TConstantes.IF_Colaborador);
  GetNotificationService.Subscribe(PopulaComboPapel, TConstantes.IF_Papel);
end;

procedure TFUsuario.FormDestroy(Sender: TObject);
begin
  GetNotificationService.UnSubscribe(PopulaComboColaborador);
  GetNotificationService.UnSubscribe(PopulaComboPapel);

  inherited;
end;

procedure TFUsuario.LimparCampos;
begin
  inherited;
  ComboBoxColaborador.KeyValue := Null;
  ComboBoxPapel.KeyValue := Null;
end;

procedure TFUsuario.PopulaComboColaborador(Sender: TObject);
var
  ColaboradorController: TColaboradorController;
begin
  ConfiguraCDSFromVO(cdsColaborador, TColaboradorVO);

  ColaboradorController := TColaboradorController.Create;
  try
    ColaboradorController.SetDataSet(cdsColaborador);
    ColaboradorController.Consulta('ID > 0', 0);

    ComboBoxColaborador.ListField := 'PESSOA.NOME';
    ComboBoxColaborador.KeyField := 'ID'
  finally
    ColaboradorController.Free;
  end;
end;

procedure TFUsuario.PopulaComboPapel(Sender: TObject);
var
  PapelController: TPapelController;
begin
  ConfiguraCDSFromVO(cdsPapel, TPapelVO);

  PapelController := TPapelController.Create;
  try
    PapelController.SetDataSet(cdsPapel);
    PapelController.Consulta('ID > 0', 0);

    ComboBoxPapel.ListField := 'NOME';
    ComboBoxPapel.KeyField := 'ID'
  finally
    PapelController.Free;
  end;
end;
{$ENDREGION}

{$REGION 'Controles CRUD'}
function TFUsuario.DoInserir: Boolean;
begin
  Result := inherited DoInserir;

  if Result then
  begin
    ComboBoxColaborador.SetFocus;
  end;
end;

function TFUsuario.DoEditar: Boolean;
begin
  Result := inherited DoEditar;

  if Result then
  begin
    ComboBoxColaborador.SetFocus;
  end;
end;

function TFUsuario.DoExcluir: Boolean;
begin
  if inherited DoExcluir then
  begin
    try
      Result := TUsuarioController(ObjetoController).Exclui(IdRegistroSelecionado);
    except
      Result := False;
    end;
  end
  else
  begin
    Result := False;
  end;

  if Result then
    TUsuarioController(ObjetoController).Consulta(Filtro, Pagina);
end;

function TFUsuario.DoSalvar: Boolean;
begin
  if ComboBoxColaborador.KeyValue = Null then
  begin
    Application.MessageBox('Informe um colaborador.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
    ComboBoxColaborador.SetFocus;
    Exit(False);
  end
  else if ComboBoxPapel.KeyValue = Null then
  begin
    Application.MessageBox('Informe um papel.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
    ComboBoxPapel.SetFocus;
    Exit(False);
  end
  else if Trim(EditLogin.Text) = '' then
  begin
    Application.MessageBox('Informe um login.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
    EditLogin.SetFocus;
    Exit(False);
  end
  else if Trim(EditSenha.Text) = '' then
  begin
    Application.MessageBox('Informe uma senha.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
    EditSenha.SetFocus;
    Exit(False);
  end;

  Result := inherited DoSalvar;

  if Result then
  begin
    try
      if not Assigned(ObjetoVO) then
        ObjetoVO := TUsuarioVO.Create;

      TUsuarioVO(ObjetoVO).IdColaborador := ComboBoxColaborador.KeyValue;
      TUsuarioVO(ObjetoVO).ColaboradorNome := ComboBoxColaborador.Text;
      TUsuarioVO(ObjetoVO).IdPapel := ComboBoxPapel.KeyValue;
      TUsuarioVO(ObjetoVO).PapelNome := ComboBoxPapel.Text;
      TUsuarioVO(ObjetoVO).Login := EditLogin.Text;
      TUsuarioVO(ObjetoVO).Senha := MD5String(EditLogin.Text+EditSenha.Text);
      TUsuarioVO(ObjetoVO).DataCadastro := Date;

      if ComboBoxPapel.Text = 'ADMINISTRADOR' then
        TUsuarioVO(ObjetoVO).Administrador := 'S'
      else
        TUsuarioVO(ObjetoVO).Administrador := 'N';

      // ObjetoVO - libera objetos vinculados (TAssociation) - não tem necessidade de subir
      TUsuarioVO(ObjetoVO).ColaboradorVO := Nil;
      TUsuarioVO(ObjetoVO).PapelVO := Nil;

      // ObjetoOldVO - libera objetos vinculados (TAssociation) - não tem necessidade de subir
      if Assigned(ObjetoOldVO) then
      begin
        TUsuarioVO(ObjetoOldVO).ColaboradorVO := Nil;
        TUsuarioVO(ObjetoOldVO).PapelVO := Nil;
      end;

      if StatusTela = stInserindo then
        Result := TUsuarioController(ObjetoController).Insere(TUsuarioVO(ObjetoVO))
      else if StatusTela = stEditando then
        if TUsuarioVO(ObjetoVO).ToJSONString <> TUsuarioVO(ObjetoOldVO).ToJSONString then
        begin
          TUsuarioVO(ObjetoVO).Id := IdRegistroSelecionado;
          Result := TUsuarioController(ObjetoController).Altera(TUsuarioVO(ObjetoVO), TUsuarioVO(ObjetoOldVO));
        end
        else
          Application.MessageBox('Nenhum dado foi alterado.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
    except
      Result := False;
    end;
  end;
end;
{$ENDREGION}

{$REGION 'Controle de Grid'}
procedure TFUsuario.GridParaEdits;
begin
  inherited;

  if not CDSGrid.IsEmpty then
  begin
    ObjetoVO := ObjetoController.VO<TUsuarioVO>(IdRegistroSelecionado);
    if StatusTela = stEditando then
      ObjetoOldVO := ObjetoController.VO<TUsuarioVO>(IdRegistroSelecionado);
  end;

  if Assigned(ObjetoVO) then
  begin

    ComboBoxColaborador.KeyValue := TUsuarioVO(ObjetoVO).IdColaborador;
    ComboBoxPapel.KeyValue := TUsuarioVO(ObjetoVO).IdPapel;
    EditLogin.Text := TUsuarioVO(ObjetoVO).Login;
  end;
end;
{$ENDREGION}

end.
