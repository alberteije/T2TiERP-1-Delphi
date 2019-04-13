{ ****************** }
{ ***Contribuição*** }
{ Marco Chagas Costa }
{ ***Agosto 2011**** }
{ ****************** }

unit UUsuario;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FMTBcd, DB, DBClient, Provider, SqlExpr, StdCtrls, pngimage, ExtCtrls,
  Grids, DBGrids, JvExDBGrids, JvDBGrid, Mask, JvExMask, JvToolEdit, JvBaseEdits,
  Buttons, JvExButtons, JvBitBtn, OperadorVO, FuncionarioVO, JvExStdCtrls,
  JvButton, JvCtrls, Generics.Collections, JvComponentBase, JvEnterTab;

type
  TFUsuario = class(TForm)
    Image1: TImage;
    GroupBox1: TGroupBox;
    GroupBox3: TGroupBox;
    GridOperador: TJvDBGrid;
    GroupBox4: TGroupBox;
    editCodigo: TLabeledEdit;
    editCelular: TLabeledEdit;
    editTelefone: TLabeledEdit;
    editNome: TLabeledEdit;
    editEmail: TLabeledEdit;
    editSenha: TLabeledEdit;
    editLogin: TLabeledEdit;
    editComVista: TJvCalcEdit;
    editComPrazo: TJvCalcEdit;
    cbNivelAutorizacao: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    btnInserir: TJvBitBtn;
    btnSalvar: TJvBitBtn;
    botaoSair: TJvImgBtn;
    JvEnterAsTab1: TJvEnterAsTab;
    btnCancelar: TJvBitBtn;
    procedure GridOperadorTitleClick(Column: TColumn);
    procedure btnSalvarClick(Sender: TObject);
    procedure CarregaDados;
    procedure FormCreate(Sender: TObject);
    procedure btnInserirClick(Sender: TObject);
    procedure CarregaDadosFromCreate;
    procedure GridOperadorKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CDSFuncionarioNavega(DataSet: TDataSet);
    procedure btnCancelarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FUsuario: TFUsuario;
  Operador: TOperadorVO;
  Funcionario: TFuncionarioVO;
  DatasetCarregado: Boolean;
  CDSOperador: TClientDataSet;
  DSOperador: TDataSource;
  CDSFuncionario: TClientDataSet;
  DSFuncionario: TDataSource;

implementation

uses OperadorFuncionarioController, UDataModule;

{$R *.dfm}

procedure TFUsuario.btnCancelarClick(Sender: TObject);
begin
  CarregaDados;
end;

procedure TFUsuario.btnInserirClick(Sender: TObject);
var
  I: Integer;
begin
  for I := 0 to ComponentCount - 1 do
  begin
    if (Components[I] is TLabeledEdit)  then (Components[I] as TLabeledEdit).Clear;
    if (Components[I] is TJvCalcEdit)  then (Components[I] as TJvCalcEdit).Clear;
    if (Components[I] is TComboBox)  then (Components[I] as TComboBox).ItemIndex := 2;
  end;
  editNome.SetFocus;
end;

procedure TFUsuario.btnSalvarClick(Sender: TObject);
begin
  try
    Operador := TOperadorVO.Create;
    Funcionario := TFuncionarioVO.Create;

    if editCodigo.Text <> '' then
      Funcionario.Id := strtoint(editCodigo.Text);

    Funcionario.Nome := editNome.Text;
    Funcionario.Telefone := editTelefone.Text;
    Funcionario.Celular := editCelular.Text;
    Funcionario.Email := editEmail.Text;
    Funcionario.ComissaoVista := editComVista.Value;
    Funcionario.ComissaoPrazo := editComPrazo.Value;

    if cbNivelAutorizacao.ItemIndex = 0 then
      Funcionario.NivelAutorizacao := 'G';

    if cbNivelAutorizacao.ItemIndex = 1 then
      Funcionario.NivelAutorizacao := 'S';

    if cbNivelAutorizacao.ItemIndex = 2 then
      Funcionario.NivelAutorizacao := 'O';

    if cbNivelAutorizacao.ItemIndex = 3 then
      Funcionario.NivelAutorizacao := 'A';

    if Funcionario.Id <> 0 then
    begin
      Operador.Id := Funcionario.Id;
      Operador.IdFuncionario := Funcionario.Id;
    end;
    Operador.Login := editLogin.Text;
    Operador.Senha := editSenha.Text;

    TOperadorFuncionarioController.GravaCargaOperador(Operador, Funcionario);

    CarregaDadosFromCreate;
    CarregaDados;

    if Funcionario.Id <> 0 then
      CDSFuncionario.Locate('ID', Funcionario.Id, []);
  except
     Application.MessageBox('Erro ao salvar modificações.', 'Informação do Sistema', MB_OK + MB_ICONERROR);
     Abort;
  end;
  Application.MessageBox('Dados salvos corretamente.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
end;

procedure TFUsuario.CDSFuncionarioNavega(DataSet: TDataSet);
begin
  if DatasetCarregado then
  begin
    DatasetCarregado := false;
    CarregaDados;
  end;
end;



procedure TFUsuario.FormCreate(Sender: TObject);
begin
  CarregaDadosFromCreate;
end;

procedure TFUsuario.GridOperadorKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    editNome.SetFocus;
end;

procedure TFUsuario.GridOperadorTitleClick(Column: TColumn);
var
  sIndexName: string;
  Options: TIndexOptions;
begin
  CDSFuncionario.IndexDefs.Update;
  if CDSFuncionario.IndexName = Column.FieldName + '_ASC' then
  begin
    sIndexName := Column.FieldName + '_DESC';
    Options := [ixDescending];
  end
  else
  begin
    sIndexName := Column.FieldName + '_ASC';
    Options := [];
  end;

  if CDSFuncionario.IndexDefs.IndexOf(sIndexName) < 0 then
    CDSFuncionario.AddIndex(sIndexName, Column.FieldName, Options);

  CDSFuncionario.IndexName := sIndexName;
end;

procedure TFUsuario.CarregaDadosFromCreate;
var
  I: integer;
  ListaOperador: TObjectList<TOperadorVO>;
  ListaFuncionario: TObjectList<TFuncionarioVO>;
begin
  // inicio cria datasets e dbgrid
  CDSFuncionario := TClientDataSet.Create(nil);
  CDSFuncionario.FieldDefs.Add('ID', ftInteger);
  CDSFuncionario.FieldDefs.Add('NOME',ftString,100);
  CDSFuncionario.FieldDefs.Add('TELEFONE',ftString,10);
  CDSFuncionario.FieldDefs.Add('CELULAR',ftString,10);
  CDSFuncionario.FieldDefs.Add('EMAIL',ftString,250);
  CDSFuncionario.FieldDefs.Add('COMISSAO_VISTA',ftFloat);
  CDSFuncionario.FieldDefs.Add('COMISSAO_PRAZO',ftFloat);
  CDSFuncionario.FieldDefs.Add('NIVEL_AUTORIZACAO',ftString,1);
  CDSFuncionario.CreateDataSet;

  with CDSFuncionario do
  begin
    AfterScroll := CDSFuncionarioNavega;
  end;
  DSFuncionario := TDataSource.Create(nil);
  DSFuncionario.DataSet := CDSFuncionario;

  CDSOperador := TClientDataSet.Create(nil);
  CDSOperador.FieldDefs.Add('ID', ftInteger);
  CDSOperador.FieldDefs.Add('ID_ECF_FUNCIONARIO',ftInteger);
  CDSOperador.FieldDefs.Add('LOGIN',ftString,20);
  CDSOperador.FieldDefs.Add('SENHA',ftString,20);
  CDSOperador.CreateDataSet;

  DSOperador := TDataSource.Create(nil);
  DSOperador.DataSet := CDSOperador;

  GridOperador.DataSource := DSFuncionario;

  DatasetCarregado := false;
  ListaFuncionario := TOperadorFuncionarioController.ConsultaFuncinario();

  CDSFuncionario.Close;
  CDSFuncionario.CreateDataSet;

  for I := 0 to ListaFuncionario.Count - 1 do
  begin
    CDSFuncionario.Append;
    CDSFuncionario.FieldByName('ID').AsInteger := ListaFuncionario.Items[I].Id;
    CDSFuncionario.FieldByName('NOME').AsString := ListaFuncionario.Items[I].Nome;
    CDSFuncionario.FieldByName('TELEFONE').AsString := ListaFuncionario.Items[I].Telefone;
    CDSFuncionario.FieldByName('CELULAR').AsString := ListaFuncionario.Items[I].Celular;
    CDSFuncionario.FieldByName('EMAIL').AsString := ListaFuncionario.Items[I].Email;
    CDSFuncionario.FieldByName('COMISSAO_VISTA').AsFloat := ListaFuncionario.Items[I].ComissaoVista;
    CDSFuncionario.FieldByName('COMISSAO_PRAZO').AsFloat := ListaFuncionario.Items[I].ComissaoPrazo;
    CDSFuncionario.FieldByName('NIVEL_AUTORIZACAO').AsString := ListaFuncionario.Items[I].NivelAutorizacao;
    CDSFuncionario.Post;
  end;

  ListaOperador := TOperadorFuncionarioController.ConsultaOperador();

  CDSOperador.Close;
  CDSOperador.CreateDataSet;

  for I := 0 to ListaOperador.Count - 1 do
  begin
    CDSOperador.Append;
    CDSOperador.FieldByName('ID').AsInteger := ListaOperador.Items[I].Id;
    CDSOperador.FieldByName('ID_ECF_FUNCIONARIO').AsInteger := ListaOperador.Items[I].IdFuncionario;
    CDSOperador.FieldByName('LOGIN').AsString := ListaOperador.Items[I].Login;
    CDSOperador.FieldByName('SENHA').AsString := ListaOperador.Items[I].Senha;
    CDSOperador.Post;
  end;

  DatasetCarregado := true;
  CDSFuncionario.First;
end;

procedure TFUsuario.CarregaDados;

begin
  try
    CDSOperador.Locate('ID_ECF_FUNCIONARIO', CDSFuncionario.FieldByName('ID').AsString, []);
    editCodigo.Text := CDSFuncionario.FieldByName('ID').AsString;
    editNome.Text := CDSFuncionario.FieldByName('NOME').AsString;
    editTelefone.Text := CDSFuncionario.FieldByName('TELEFONE').AsString;
    editCelular.Text := CDSFuncionario.FieldByName('CELULAR').AsString;
    editEmail.Text := CDSFuncionario.FieldByName('EMAIL').AsString;
    editComVista.Text := CDSFuncionario.FieldByName('COMISSAO_VISTA').AsString;
    editComPrazo.Text := CDSFuncionario.FieldByName('COMISSAO_PRAZO').AsString;
    editLogin.Text := CDSOperador.FieldByName('LOGIN').AsString;
    editSenha.Text := CDSOperador.FieldByName('SENHA').AsString;
    if CDSFuncionario.FieldByName('NIVEL_AUTORIZACAO').AsString = 'G' then
      cbNivelAutorizacao.ItemIndex := 0;
    if CDSFuncionario.FieldByName('NIVEL_AUTORIZACAO').AsString = 'S' then
      cbNivelAutorizacao.ItemIndex := 1;
    if CDSFuncionario.FieldByName('NIVEL_AUTORIZACAO').AsString = 'O' then
      cbNivelAutorizacao.ItemIndex := 2;
    if CDSFuncionario.FieldByName('NIVEL_AUTORIZACAO').AsString = 'A' then
      cbNivelAutorizacao.ItemIndex := 3;
  except
    Application.MessageBox('Erro ao carregar os dados.', 'Informação do Sistema', MB_OK + MB_ICONERROR);
    Abort;
  end;
  DatasetCarregado := true;
end;

end.
