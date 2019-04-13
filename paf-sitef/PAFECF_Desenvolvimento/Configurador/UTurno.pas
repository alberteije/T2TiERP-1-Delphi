{ ****************** }
{ ***Contribuição*** }
{ Marco Chagas Costa }
{ ***Agosto 2011**** }
{ ****************** }

unit UTurno;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FMTBcd, StdCtrls, JvExStdCtrls, JvButton, JvCtrls, JvExButtons,
  JvBitBtn, Buttons, pngimage, ExtCtrls, Grids, DBGrids, JvExDBGrids, JvDBGrid,
  Provider, DBClient, DB, SqlExpr, JvComponentBase, JvEnterTab;

type
  TFTurno = class(TForm)
    QTurno: TSQLQuery;
    DSTurno: TDataSource;
    CDSTurno: TClientDataSet;
    DSPTurno: TDataSetProvider;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GridTurno: TJvDBGrid;
    GroupBox4: TGroupBox;
    editDescricao: TLabeledEdit;
    editHoraFim: TLabeledEdit;
    Image1: TImage;
    editHoraInicio: TLabeledEdit;
    btnSalvar: TBitBtn;
    botaoCancela: TJvImgBtn;
    JvEnterAsTab1: TJvEnterAsTab;
    btnInserir: TJvBitBtn;
    editCodigo: TLabeledEdit;
    procedure FormCreate(Sender: TObject);
    procedure CDSTurnoAfterScroll(DataSet: TDataSet);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnInserirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FTurno: TFTurno;

implementation

uses TurnoVO, TurnoController;

{$R *.dfm}

procedure TFTurno.btnInserirClick(Sender: TObject);
var
  I: Integer;
begin
  for I := 0 to ComponentCount - 1 do
  begin
    if (Components[I] is TLabeledEdit)  then (Components[I] as TLabeledEdit).Clear;
  end;

  editDescricao.SetFocus;
end;

procedure TFTurno.btnSalvarClick(Sender: TObject);
var
  Turno: TTurnoVO;
begin
  Turno := TTurnoVO.Create;

  Turno.Id :=  StrToIntDef(editCodigo.Text,0);     // ID|
  Turno.Descricao := editDescricao.Text;           // DESCRICAO|
  Turno.HoraInicio := editHoraInicio.Text;         // HORA_INICIO|
  Turno.HoraFim := editHoraFim.Text;               // HORA_FIM|

  TTurnoController.GravaCargaTurno(Turno);

  CDSTurno.Active := False;
  CDSTurno.Active := True;
end;

procedure TFTurno.CDSTurnoAfterScroll(DataSet: TDataSet);
begin
  editCodigo.Text :=  CDSTurno.FieldByName('ID').AsString;
  editDescricao.Text := CDSTurno.FieldByName('DESCRICAO').AsString;
  editHoraInicio.Text := CDSTurno.FieldByName('HORA_INICIO').AsString;
  editHoraFim.Text := CDSTurno.FieldByName('HORA_FIM').AsString;
end;

procedure TFTurno.FormCreate(Sender: TObject);
begin
  CDSTurno.Active := True;
end;

end.
