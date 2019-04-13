unit UPDVCarga;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, pngimage, ExtCtrls, Buttons,DB, Generics.Collections,
  ComCtrls,JvPageList;

type
  TFPDVCarga = class(TForm)
    PanelFiltroRapido: TPanel;
    Image1: TImage;
    Label2: TLabel;
    GroupBox1: TGroupBox;
    boxProduto: TCheckBox;
    boxCliente: TCheckBox;
    boxProdutoPromocao: TCheckBox;
    boxCFOP: TCheckBox;
    boxTurno: TCheckBox;
    boxBanco: TCheckBox;
    boxFichaTecnica: TCheckBox;
    boxFuncionario: TCheckBox;
    boxOperador: TCheckBox;
    boxContador: TCheckBox;
    boxResolucao: TCheckBox;
    boxEmpresa: TCheckBox;
    boxConfiguracao: TCheckBox;
    boxImpressora: TCheckBox;
    boxPosicaoComponentes: TCheckBox;
    Panel1: TPanel;
    GroupBox2: TGroupBox;
    RadioMarcarTodos: TRadioButton;
    RadioDesmarcarTodos: TRadioButton;
    Confirma: TSpeedButton;
    SpeedButton1: TSpeedButton;
    procedure ConfirmaClick(Sender: TObject);
    procedure FechaFormulario;
    procedure FormCreate(Sender: TObject);
    procedure RadioMarcarTodosMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure DesmarcarTodosCheckBox;
    procedure MarcarTodosCheckBox;
    procedure RadioMarcarTodosKeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
    procedure RadioDesmarcarTodosKeyUp(Sender: TObject; var Key: Word;   Shift: TShiftState);
    procedure RadioDesmarcarTodosMouseUp(Sender: TObject; Button: TMouseButton;  Shift: TShiftState; X, Y: Integer);
    procedure SpeedButton1Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FPDVCarga: TFPDVCarga;

implementation

uses   ExportaTabelasController, UMenu, UDataModule;

var
  Operacao:Integer; //1-Inserir | 2-Alterar | 3-Consultar
  Filtro: String;
  Pagina: Integer;


{$R *.dfm}

procedure TFPDVCarga.ConfirmaClick(Sender: TObject);
var
    TemTabela : integer;
begin

  if FileExists(FDataModule.PathExporta) then
  begin
    DeleteFile(FDataModule.PathExporta);
    Application.ProcessMessages;
  end;

  try
    Confirma.Enabled := false;
    TemTabela := 0;

    if boxProduto.Checked then
    begin
      ExportaUnidadeProduto;
      ExportaProduto(0);
      inc(TemTabela);
    end;

    if boxCliente.Checked then
    begin
      ExportaSituacaoCliente;
      ExportaCliente;
      inc(TemTabela);
    end;

    if boxProdutoPromocao.Checked then
    begin
      ExportaProdutoPromocao;
      inc(TemTabela);
    end;

    if boxCFOP.Checked then
    begin
      ExportaCFOP;
      inc(TemTabela);
    end;

    if boxTurno.Checked then
    begin
      ExportaTurno;
      inc(TemTabela);
    end;

    if boxBanco.Checked then
    begin
      ExportaBanco;
      inc(TemTabela);
    end;

    if boxFichaTecnica.Checked then
    begin
      ExportaFichaTecnica;
      inc(TemTabela);
    end;

    if boxFuncionario.Checked then
    begin
      ExportaFuncionario;
      inc(TemTabela);
    end;
    if boxOperador.Checked then
    begin
      ExportaOperador;
      inc(TemTabela);
    end;
    if boxContador.Checked then
    begin
      ExportaContador;
      inc(TemTabela);
    end;

    if boxResolucao.Checked then
    begin
      ExportaResolucao;
      inc(TemTabela);
    end;

    if boxEmpresa.Checked then
    begin
      ExportaEmpresa;
      inc(TemTabela);
    end;

    if boxConfiguracao.Checked then
    begin
      ExportaConfiguracao;
      inc(TemTabela);
    end;

    if boxImpressora.Checked then
    begin
      ExportaImpressora;
      inc(TemTabela);
    end;

    if boxPosicaoComponentes.Checked then
    begin
      ExportaPosicaoComponentes;
      inc(TemTabela);
    end;


  finally

    if TemTabela <= 0 then
      ShowMessage('Não há tabela selecionada')
    else
    begin

      try
        FDataModule.CopiaCargaParaPDVs;
        ShowMessage('Exportação realizada com sucesso');
      except
        ShowMessage('Falha na exportação dos arquivos');
      end;

    end;

    Confirma.Enabled := True;
  end;

end;


procedure TFPDVCarga.FormCreate(Sender: TObject);
begin
  RadioDesmarcarTodos.Checked := true;
end;



procedure TFPDVCarga.MarcarTodosCheckBox;
var i : integer;
begin

  for i := 0 to ComponentCount -1 do
  begin
    if Components[i] is TCheckBox then
    begin
      TCheckBox(Components[i]).checked := True;
    end;
  end;

end;

procedure TFPDVCarga.DesmarcarTodosCheckBox;
var i : integer;
begin

  for i := 0 to ComponentCount -1 do
  begin
    if Components[i] is TCheckBox then
    begin
      TCheckBox(Components[i]).checked := False;
    end;
  end;

end;

procedure TFPDVCarga.RadioDesmarcarTodosKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if RadioMarcarTodos.Checked then
     MarcarTodosCheckBox
  else if RadioDesmarcarTodos.Checked then
     DesmarcarTodosCheckBox;
end;

procedure TFPDVCarga.RadioDesmarcarTodosMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if RadioMarcarTodos.Checked then
     MarcarTodosCheckBox
  else if RadioDesmarcarTodos.Checked then
     DesmarcarTodosCheckBox;
end;

procedure TFPDVCarga.RadioMarcarTodosKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if RadioMarcarTodos.Checked then
     MarcarTodosCheckBox
  else if RadioDesmarcarTodos.Checked then
     DesmarcarTodosCheckBox;
end;

procedure TFPDVCarga.RadioMarcarTodosMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if RadioMarcarTodos.Checked then
     MarcarTodosCheckBox
  else if RadioDesmarcarTodos.Checked then
     DesmarcarTodosCheckBox;

end;

procedure TFPDVCarga.SpeedButton1Click(Sender: TObject);
begin
   FechaFormulario;
end;

procedure TFPDVCarga.FechaFormulario;
begin
  if (Self.Owner is TJvStandardPage) and (Assigned(FMenu)) then
    FMenu.FecharPagina(TJvStandardPage(Self.Owner))
  else
    Self.Close;
end;

end.
