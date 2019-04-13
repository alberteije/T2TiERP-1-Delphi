{*******************************************************************************
Title: T2Ti ERP
Description: Janela Cadastro de Dependentes dos Socios

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
unit USocioDependente;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UTelaCadastro, DB, DBClient, Menus, StdCtrls, ExtCtrls, Buttons, Grids,
  DBGrids, JvExDBGrids, JvDBGrid, JvDBUltimGrid, ComCtrls, SocioDependenteVO,
  SocioDependenteController, Tipos, Atributos, Constantes, TipoRelacionamentoVO,
  TipoRelacionamentoController, SocioVO, SocioController,
  LabeledCtrls, Mask, JvExMask, JvToolEdit;

type
  [TFormDescription(TConstantes.MODULO_CADASTROS,'SocioDependente')]
  TFSocioDependente = class(TFTelaCadastro)
    BevelEdits: TBevel;
    EditDependente: TLabeledEdit;
    EditIdSocio: TLabeledEdit;
    EditIdRelacionamento: TLabeledEdit;
    EditCPF: TLabeledMaskEdit;
    EditNascimento: TLabeledDateEdit;
    EditInicioDependencia: TLabeledDateEdit;
    EditFimDependencia: TLabeledDateEdit;
    EditSocio: TLabeledEdit;
    EditRelacionamento: TLabeledEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure EditIdSocioExit(Sender: TObject);
    procedure EditIdRelacionamentoExit(Sender: TObject);
    procedure EditIdSocioKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditIdRelacionamentoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditCPFExit(Sender: TObject);
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

    procedure PopulaEditSocio(Sender: TObject);
    procedure PopulaEditRelacionamento(Sender: TObject);
    function ConsultaCpf(Cpf:String): Boolean;

  end;

var
  FSocioDependente: TFSocioDependente;

implementation

uses ULookup, MunicipioController, MunicipioVO, Biblioteca, UDataModule;

{$R *.dfm}

procedure TFSocioDependente.FormCreate(Sender: TObject);
begin
  ClasseObjetoGridVO := TSocioDependenteVO;
  ObjetoController := TSocioDependenteController.Create;

  inherited;
end;

procedure TFSocioDependente.FormShow(Sender: TObject);
begin
  inherited;

end;

{$REGION 'Controles CRUD'}
function TFSocioDependente.DoInserir: Boolean;
begin
  Result := inherited DoInserir;

  if Result then
  begin
    EditIdSocio.SetFocus;
  end;
end;

function TFSocioDependente.ConsultaCpf(Cpf: String): Boolean;
var
  Filtro: String;
begin
  Filtro := 'CPF = '+ Cpf;
    ConfiguraCDSFromVO(FDataModule.CDSLookup,TSocioDependenteVO);

  TSocioDependenteController.SetDataSet(FDataModule.CDSLookup);
  TSocioDependenteController.Consulta(Filtro,0);
  try
    if (FDataModule.CDSLookup.FieldByName('ID').AsString <> '') then
      Result := True
    else
      Result := False;
  finally
    FDataModule.CDSLookup.Close;
  end;
end;

function TFSocioDependente.DoEditar: Boolean;
begin
  Result := inherited DoEditar;

  if Result then
  begin
    EditIdSocio.SetFocus;
  end;
end;

function TFSocioDependente.DoExcluir: Boolean;
begin
  if inherited DoExcluir then
  begin
    try
      Result := TSocioDependenteController(ObjetoController).Exclui(IdRegistroSelecionado);
    except
      Result := False;
    end;
  end
  else
  begin
    Result := False;
  end;

  if Result then
    TSocioDependenteController(ObjetoController).Consulta(Filtro, Pagina);
end;

function TFSocioDependente.DoSalvar: Boolean;
begin
  Result := inherited DoSalvar;

  if Result then
  begin
    try
      if not Assigned(ObjetoVO) then
        ObjetoVO := TSocioDependenteVO.Create;

      TSocioDependenteVO(ObjetoVO).IdSocio             := StrToInt(EditIdSocio.Text);
      TSocioDependenteVO(ObjetoVO).IdTipoRelacionamento:= StrToInt(EditIdRelacionamento.Text);
      TSocioDependenteVO(ObjetoVO).Nome                := EditDependente.Text;
      TSocioDependenteVO(ObjetoVO).Cpf                 := EditCpf.Text;
      TSocioDependenteVO(ObjetoVO).DataNascimento      := EditNascimento.Date;
      TSocioDependenteVO(ObjetoVO).DataInicioDepedencia:= EditInicioDependencia.Date;
      TSocioDependenteVO(ObjetoVO).DataFimDependencia  := EditFimDependencia.Date;

      if StatusTela = stInserindo then
        Result := TSocioDependenteController(ObjetoController).Insere(TSocioDependenteVO(ObjetoVO))
      else
      if StatusTela = stEditando then
      begin
        if TSocioVO(ObjetoVO).ToJSONString <> TSocioVO(ObjetoOldVO).ToJSONString then
        begin
          TSocioVO(ObjetoVO).ID := IdRegistroSelecionado;
          Result := TSocioController(ObjetoController).Altera(TSocioVO(ObjetoVO), TSocioVO(ObjetoOldVO));
        end
        else
          Application.MessageBox('Nenhum dado foi alterado.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
      end;
    except
      Result := False;
    end;
  end;
end;
procedure TFSocioDependente.PopulaEditRelacionamento(Sender: TObject);
var
  Filtro : String;
begin

  Filtro := 'ID = ' + EditIdRelacionamento.Text;

  ConfiguraCDSFromVO(FDataModule.CDSLookup,TTipoRelacionamentoVO);

  TTipoRelacionamentoController.SetDataSet(FDataModule.CDSLookup);
  TTipoRelacionamentoController.Consulta(Filtro,0);
  try
    if (FDataModule.CDSLookup.FieldByName('ID').AsString <> '') then
   begin
     EditIdRelacionamento.Text := FDataModule.CDSLookup.FieldByName('ID').AsString;
     EditRelacionamento.Text   := FDataModule.CDSLookup.FieldByName('NOME').AsString;
   end
   else
     begin
       EditIdSocio.SetFocus;
       keybd_event(VK_F1, 0, 0, 0);
     end;
  finally
    FDataModule.CDSLookup.Close;
  end;
end;

procedure TFSocioDependente.PopulaEditSocio(Sender: TObject);
var
  Filtro : String;
begin

  Filtro := 'ID = ' + EditIdSocio.Text;

  ConfiguraCDSFromVO(FDataModule.CDSLookup,TSocioVO);

  TSocioController.SetDataSet(FDataModule.CDSLookup);
  TSocioController.Consulta(Filtro,0);
  try
    if (FDataModule.CDSLookup.FieldByName('ID').AsString <> '') then
   begin
     EditIdSocio.Text := FDataModule.CDSLookup.FieldByName('ID').AsString;
     EditSocio.Text   := FDataModule.CDSLookup.Fields[2].Value;
   end
   else
     begin
       EditIdSocio.SetFocus;
       keybd_event(VK_F1, 0, 0, 0);
     end;
  finally
    FDataModule.CDSLookup.Close;
  end;
end;


procedure TFSocioDependente.EditCPFExit(Sender: TObject);
begin
  if EditCpf.Text = '' then
    Exit;
  if not validacpf(EditCPF.Text) then
  begin
    Application.MessageBox('Cpf inválido.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
//    Mensagem('Cpf inválido.');
    EditCPF.SetFocus;
  end;
  if StatusTela = stInserindo then
    if ConsultaCpf(EditCpf.Text) then
    begin
      Application.MessageBox('Cpf já cadastrado.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
//      Mensagem('Cpf já cadastrado.');
      EditCPF.SetFocus;
    end;
end;

procedure TFSocioDependente.EditIdRelacionamentoExit(Sender: TObject);
begin
  if (EditIdRelacionamento.Text <> '') and (EditIdRelacionamento.Text <> '0') then
   PopulaEditRelacionamento(Self);
end;

procedure TFSocioDependente.EditIdRelacionamentoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    Application.CreateForm(TFLookup, FLookup);
    ULookup.FLookup.ObjetoVO := TTipoRelacionamentoVO.Create;
    ULookup.FLookup.ObjetoController := TTipoRelacionamentoController.Create;
    FLookup.ShowModal;
    EditIdRelacionamento.Text := IntToStr(ULookup.FLookup.CDSLookup.FieldByName('ID').AsInteger);
    EditRelacionamento.Text   := ULookup.FLookup.CDSLookup.FieldByName('NOME').AsString;
    EditDependente.SetFocus;
  end;
  if Key = VK_RETURN then
    EditDependente.SetFocus;
end;

procedure TFSocioDependente.EditIdSocioExit(Sender: TObject);
begin
  if (EditIdSocio.Text <> '') and (EditIdSocio.Text <> '0') then
   PopulaEditSocio(Self);
end;
procedure TFSocioDependente.EditIdSocioKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    Application.CreateForm(TFLookup, FLookup);
    ULookup.FLookup.ObjetoVO := TSocioVO.Create;
    ULookup.FLookup.ObjetoController := TSocioController.Create;
    FLookup.ShowModal;
    EditIdSocio.Text := IntToStr(ULookup.FLookup.CDSLookup.FieldByName('ID').AsInteger);
    EditSocio.Text   := ULookup.FLookup.CDSLookup.Fields[2].Value;
  end;
  if Key = VK_RETURN then
    EditIdRelacionamento.SetFocus;
end;

{$ENDREGION}

procedure TFSocioDependente.GridParaEdits;
begin
  inherited;

  if not CDSGrid.IsEmpty then
  begin
    ObjetoVO := ObjetoController.VO<TSocioDependenteVO>(IdRegistroSelecionado);
    if StatusTela = stEditando then
      ObjetoOldVO := ObjetoController.VO<TSocioDependenteVO>(IdRegistroSelecionado);
  end;

  if Assigned(ObjetoVO) then
  begin
    EditIdSocio.Text           := IntToStr(TSocioDependenteVO(ObjetoVO).IdSocio);
    EditSocio.Text             := TSocioDependenteVO(ObjetoVO).NomeSocio;
    EditIdRelacionamento.Text  := IntToStr(TSocioDependenteVO(ObjetoVO).IdTipoRelacionamento);
    EditRelacionamento.Text    := TSocioDependenteVO(ObjetoVO).RelacionamentoNome;
    EditDependente.Text        := TSocioDependenteVO(ObjetoVO).Nome;
    EditCpf.Text               := TSocioDependenteVO(ObjetoVO).Cpf;
    EditNascimento.Date        := TSocioDependenteVO(ObjetoVO).DataNascimento;
    EditInicioDependencia.Date := TSocioDependenteVO(ObjetoVO).DataInicioDepedencia;
    EditFimDependencia.Date    := TSocioDependenteVO(ObjetoVO).DataFimDependencia;
  end;
end;

end.

