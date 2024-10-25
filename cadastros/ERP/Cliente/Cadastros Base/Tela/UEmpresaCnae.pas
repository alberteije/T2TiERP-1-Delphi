{*******************************************************************************
Title: T2Ti ERP
Description: Janela Cadastro de Empresa Cnae

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

@author F�bio Thomaz (fabio_thz@yahoo.com.br)
@version 1.0   |   Fernando  @version 1.0.0.10
*******************************************************************************}
unit UEmpresaCnae;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UTelaCadastro, DB, DBClient, Menus, StdCtrls, ExtCtrls, Buttons, Grids,
  DBGrids, JvExDBGrids, JvDBGrid, JvDBUltimGrid, ComCtrls, EmpresaCnaeVO,
  EmpresaCnaeController, Tipos, Atributos, Constantes, LabeledCtrls, JvToolEdit,
  Mask, JvExMask, JvBaseEdits,Math,StrUtils;

type
  [TFormDescription(TConstantes.MODULO_CADASTROS,'Operadora de Cart�o')]
  TFEmpresaCnae = class(TFTelaCadastro)
    BevelEdits: TBevel;
    EditIdCnae: TLabeledEdit;
    EditDescricaoCnae: TLabeledEdit;
    EditIdEmpresa: TLabeledEdit;
    EditEmpresa: TLabeledEdit;
    EditRamoAtividade: TLabeledEdit;
    RadioGroupPrincipal: TRadioGroup;
    MemoObjetoSocial: TLabeledMemo;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure EditIdCnaeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditIdEmpresaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditIdCnaeExit(Sender: TObject);
    procedure EditIdEmpresaExit(Sender: TObject);
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

    procedure PopulaEditCnae(Sender: TObject);
    procedure PopulaEditEmpresa(Sender: TObject);

  end;

var
  FEmpresaCnae: TFEmpresaCnae;

implementation

uses ULookup,  Biblioteca, UDataModule, CnaeVO, CnaeController,
  EmpresaController, EmpresaVO;

{$R *.dfm}

procedure TFEmpresaCnae.FormCreate(Sender: TObject);
begin
  ClasseObjetoGridVO := TEmpresaCnaeVO;
  ObjetoController := TEmpresaCnaeController.Create;

  inherited;
end;

procedure TFEmpresaCnae.FormShow(Sender: TObject);
begin
  inherited;

end;

{$REGION 'Controles CRUD'}
function TFEmpresaCnae.DoInserir: Boolean;
begin
  Result := inherited DoInserir;

  if Result then
  begin
    EditIdCnae.SetFocus;
  end;
end;

function TFEmpresaCnae.DoEditar: Boolean;
begin
  Result := inherited DoEditar;

  if Result then
  begin
    EditIdCnae.SetFocus;
  end;
end;

function TFEmpresaCnae.DoExcluir: Boolean;
begin
  if inherited DoExcluir then
  begin
    try
      Result := TEmpresaCnaeController(ObjetoController).Exclui(IdRegistroSelecionado);
    except
      Result := False;
    end;
  end
  else
  begin
    Result := False;
  end;

  if Result then
    TEmpresaCnaeController(ObjetoController).Consulta(Filtro, Pagina);
end;

function TFEmpresaCnae.DoSalvar: Boolean;
begin
  if RadioGroupPrincipal.ItemIndex = -1 then
  begin
    Mensagem('Informe o tipo do Cnae.');
    RadioGroupPrincipal.SetFocus;
    Exit(False);
  end;
  if EditIdCnae.Text = '' then
  begin
    Mensagem('Informe o c�digo Cnae.');
    EditIdCnae.SetFocus;
    Exit(False);
  end;
  if EditIdEmpresa.Text = '' then
  begin
    Mensagem('Informe o c�digo da Empresa.');
    EditIdEmpresa.SetFocus;
    Exit(False);
  end;
  Result := inherited DoSalvar;

  if Result then
  begin
    try
      if not Assigned(ObjetoVO) then
        ObjetoVO := TEmpresaCnaeVO.Create;

        TEmpresaCnaeVO(ObjetoVO).IdCnae             := StrToInt(EditIdCnae.Text);
        TEmpresaCnaeVO(ObjetoVO).IdEmpresa          := StrToInt(EditIdEmpresa.Text);
        if RadioGroupPrincipal.ItemIndex = 0 then
          TEmpresaCnaeVO(ObjetoVO).Principal        := 'S'
        else
          TEmpresaCnaeVO(ObjetoVO).Principal        := 'N';
        TEmpresaCnaeVO(ObjetoVO).RamoAtividade      := EditRamoAtividade.Text;
        TEmpresaCnaeVO(ObjetoVO).ObjetoSocial       := MemoObjetoSocial.Text;

      if StatusTela = stInserindo then
        TEmpresaCnaeController(ObjetoController).Insere(TEmpresaCnaeVO(ObjetoVO))
      else
      if StatusTela = stEditando then
      begin
        TEmpresaCnaeVO(ObjetoVO).ID := IdRegistroSelecionado;
        TEmpresaCnaeController(ObjetoController).Altera(TEmpresaCnaeVO(ObjetoVO));
      end;

      Result := True;
      except
      Result := False;
    end;
  end;
end;



procedure TFEmpresaCnae.EditIdEmpresaExit(Sender: TObject);
begin
  inherited;
  if (EditIdCnae.Text <> '') and (EditIdCnae.Text <> '0') then
   PopulaEditCnae(Self)
  else
  if (EditIdCnae.Text = '0') then
   begin
     EditIdCnae.Clear;
     EditIdCnae.SetFocus;
   end;
end;

procedure TFEmpresaCnae.EditIdEmpresaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
begin
  if key = VK_F1 then
  begin
    Application.CreateForm(TFLookup, FLookup);
    ULookup.FLookup.ObjetoVO:= TEmpresaVO.Create;
    ULookup.FLookup.ObjetoController := TEmpresaController.Create;
    FLookup.ShowModal;
    EditIdEmpresa.Text := IntToStr(ULookup.FLookup.CDSLookup.FieldByName('ID').AsInteger);
    EditEmpresa.Text   := ULookup.FLookup.CDSLookup.FieldByName('RAZAO_SOCIAL').AsString;
    //EditRegistroAns.SetFocus;
  end;
  if key = VK_RETURN then
   //EditRegistroAns.SetFocus;

end;

end;

procedure TFEmpresaCnae.EditIdCnaeExit(Sender: TObject);
begin
  inherited;
  if (EditIdCnae.Text <> '') and (EditIdCnae.Text <> '0') then
   PopulaEditCnae(Self)
  else
  if (EditIdCnae.Text = '0') then
   begin
     EditIdCnae.Clear;
     EditIdCnae.SetFocus;
   end;
end;

procedure TFEmpresaCnae.EditIdCnaeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_F1 then
  begin
    Application.CreateForm(TFLookup, FLookup);
    ULookup.FLookup.ObjetoVO:= TCnaeVO.Create;
    ULookup.FLookup.ObjetoController := TCnaeController.Create;
    FLookup.ShowModal;
    EditIdCnae.Text        := IntToStr(ULookup.FLookup.CDSLookup.FieldByName('ID').AsInteger);
    EditDescricaoCnae.Text := ULookup.FLookup.CDSLookup.FieldByName('DENOMINACAO').AsString;
  end;
  if key = VK_RETURN then
  // EditIdContabilConta.SetFocus;

end;

{$ENDREGION}

procedure TFEmpresaCnae.GridParaEdits;
begin
  inherited;

  if not CDSGrid.IsEmpty then
  begin
    ObjetoVO := ObjetoController.VO<TEmpresaCnaeVO>(IdRegistroSelecionado);
  end;

  if Assigned(ObjetoVO) then
  begin
    EditIdCnae.Text        := IntToStr(TEmpresaCnaeVO(ObjetoVO).IdCnae);
    EditDescricaoCnae.Text := TEmpresaCnaeVO(ObjetoVO).DescricaoCnae;
    EditIdEmpresa.Text     := IntToStr(TEmpresaCnaeVO(ObjetoVO).IdEmpresa);
    EditEmpresa.Text       := TEmpresaCnaeVO(ObjetoVO).RazaoSocial;
    if TEmpresaCnaeVO(ObjetoVO).RamoAtividade = 'S' then
      RadioGroupPrincipal.ItemIndex := 0
    else
      RadioGroupPrincipal.ItemIndex := 0;
    EditRamoAtividade.Text := TEmpresaCnaeVO(ObjetoVO).RamoAtividade;
    MemoObjetoSocial.Text  := TEmpresaCnaeVO(ObjetoVO).ObjetoSocial;

  end;

end;

procedure TFEmpresaCnae.PopulaEditCnae(Sender: TObject);
var
  Filtro: String;
begin

  Filtro := 'ID = ' + EditIdCnae.Text;

  ConfiguraCDSFromVO(FDataModule.CDSLookup, TCnaeVO);

  TCnaeController.SetDataSet(FDataModule.CDSLookup);
  TCnaeController.Consulta(Filtro,0);
  try
    if (FDataModule.CDSLookup.FieldByName('ID').AsString <> '') then
    begin
      EditIdCnae.Text        := FDataModule.CDSLookup.FieldByName('ID').AsString;
      EditDescricaoCnae.Text := FDataModule.CDSLookup.FieldByName('DENOMINACAO').AsString;
    end
    else
    begin
      EditIdCnae.SetFocus;
      keybd_event(VK_F1, 0, 0, 0);
    end;
  finally
    FDataModule.CDSLookup.Close;
  end;
end;


procedure TFEmpresaCnae.PopulaEditEmpresa(Sender: TObject);
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

end.
