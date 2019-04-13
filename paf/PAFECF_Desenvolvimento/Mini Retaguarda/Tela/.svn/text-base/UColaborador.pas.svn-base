unit UColaborador;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UTela, DB, DBClient, Menus, StdCtrls, ExtCtrls, Buttons, Grids,
  DBGrids, JvExDBGrids, JvDBGrid, JvDBUltimGrid, ComCtrls, UnidadeProdutoVO,
  Tipos, UnidadeProdutoController;

type
  TFColaborador = class(TFTela)
    BotaoInserir: TSpeedButton;
    BotaoAlterar: TSpeedButton;
    BotaoExcluir: TSpeedButton;
    BotaoCancelar: TSpeedButton;
    BotaoSalvar: TSpeedButton;
    BevelEdits: TBevel;
    EditSigla: TLabeledEdit;
    MemoDescricao: TMemo;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    procedure ControlaBotoes; override;
    procedure GridParaEdits; override;
    procedure LimparCampos; override;
  public
    { Public declarations }
  end;

var
  FColaborador: TFColaborador;

implementation

{$R *.dfm}

procedure TFColaborador.ControlaBotoes;
var
  NovaTag: Integer;
begin
  inherited;

  //Botão Alterar
  NovaTag := TagBotao[not CDSGrid.IsEmpty];
  if NovaTag <> BotaoAlterar.Tag then
  begin
    BotaoAlterar.Tag := NovaTag;
    IconeBotao(BotaoAlterar,iAlterar,TStatusImagem(NovaTag),ti16);
  end;

  //Botão Excluir
  NovaTag := TagBotao[not CDSGrid.IsEmpty];
  if NovaTag <> BotaoExcluir.Tag then
  begin
    BotaoExcluir.Tag := NovaTag;
    IconeBotao(BotaoExcluir,iExcluir,TStatusImagem(NovaTag),ti16);
  end;
end;


procedure TFColaborador.FormCreate(Sender: TObject);
begin
  ClasseObjetoGridVO := TUnidadeProdutoVO;
  ObjetoController := TUnidadeProdutoController.Create;

  inherited;

  BotaoInserir.Flat := True;
  BotaoAlterar.Flat := True;
  BotaoExcluir.Flat := True;
  BotaoSalvar.Flat := True;
  BotaoCancelar.Flat := True;

  IconeBotao(BotaoInserir,iIncluir,siHabilitada,ti16);
  IconeBotao(BotaoSalvar,iSalvar,siHabilitada,ti16);
  IconeBotao(BotaoCancelar,iCancelar,siHabilitada,ti16);
end;

procedure TFColaborador.GridParaEdits;
begin
 inherited;
  { TODO : Passar este bloco para o form pai }
  if not CDSGrid.IsEmpty then
  begin
 //   ObjetoVO := ObjetoController.VO<TUnidadeProdutoVO>(IdRegistroSelecionado);
  end;

  if Assigned(ObjetoVO) then
  begin
    EditSigla.Text := TUnidadeProdutoVO(ObjetoVO).Nome;
    MemoDescricao.Text := TUnidadeProdutoVO(ObjetoVO).Descricao;
  end;
end;

procedure TFColaborador.LimparCampos;
begin
  inherited;
  EditSigla.Clear;
  MemoDescricao.Clear;

end;

end.
