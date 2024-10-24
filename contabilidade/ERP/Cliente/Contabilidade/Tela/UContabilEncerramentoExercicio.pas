{ *******************************************************************************
  Title: T2Ti ERP
  Description: Janela de Encerramento do Exerc�cio para o m�dulo Contabilidade

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
unit UContabilEncerramentoExercicio;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UTelaCadastro, DB, DBClient, Menus, StdCtrls, ExtCtrls, Buttons, Grids,
  DBGrids, JvExDBGrids, JvDBGrid, JvDBUltimGrid, ComCtrls, ContabilEncerramentoExeCabVO,
  ContabilEncerramentoExeCabController, Tipos, Atributos, Constantes, LabeledCtrls, JvToolEdit,
  Mask, JvExMask, JvBaseEdits, Math, StrUtils, ActnList, Generics.Collections,
  RibbonSilverStyleActnCtrls, ActnMan, ToolWin, ActnCtrls;

type
  [TFormDescription(TConstantes.MODULO_CONTABILIDADE, 'Encerramento do Exerc�cio')]

  TFContabilEncerramentoExercicio = class(TFTelaCadastro)
    DSContabilEncerramentoExercicioDetalhe: TDataSource;
    CDSContabilEncerramentoExercicioDetalhe: TClientDataSet;
    PanelMestre: TPanel;
    PageControlItens: TPageControl;
    tsItens: TTabSheet;
    PanelItens: TPanel;
    GridDetalhe: TJvDBUltimGrid;
    EditDataInicio: TLabeledDateEdit;
    EditDataInclusao: TLabeledDateEdit;
    EditMotivo: TLabeledEdit;
    EditDataFim: TLabeledDateEdit;
    CDSContabilEncerramentoExercicioDetalheID: TIntegerField;
    CDSContabilEncerramentoExercicioDetalheID_CONTABIL_CONTA: TIntegerField;
    CDSContabilEncerramentoExercicioDetalheID_CONTABIL_ENCERRAMENTO_EXE: TIntegerField;
    CDSContabilEncerramentoExercicioDetalheSALDO_ANTERIOR: TFMTBCDField;
    CDSContabilEncerramentoExercicioDetalheVALOR_DEBITO: TFMTBCDField;
    CDSContabilEncerramentoExercicioDetalheVALOR_CREDITO: TFMTBCDField;
    CDSContabilEncerramentoExercicioDetalheSALDO: TFMTBCDField;
    procedure FormCreate(Sender: TObject);
    procedure GridDblClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    procedure GridParaEdits; override;
    procedure LimparCampos; override;
    procedure ControlaBotoes; override;
    procedure ControlaPopupMenu; override;

    // Controles CRUD
    function DoInserir: Boolean; override;
    function DoEditar: Boolean; override;
    function DoExcluir: Boolean; override;
    function DoSalvar: Boolean; override;

    procedure ConfigurarLayoutTela;
  end;

var
  FContabilEncerramentoExercicio: TFContabilEncerramentoExercicio;

implementation

uses ULookup, Biblioteca, UDataModule, ContabilEncerramentoExeDetVO;
{$R *.dfm}

{$REGION 'Controles Infra'}
procedure TFContabilEncerramentoExercicio.FormCreate(Sender: TObject);
begin
  ClasseObjetoGridVO := TContabilEncerramentoExeCabVO;
  ObjetoController := TContabilEncerramentoExeCabController.Create;

  inherited;
end;

procedure TFContabilEncerramentoExercicio.LimparCampos;
begin
  inherited;
  CDSContabilEncerramentoExercicioDetalhe.EmptyDataSet;
end;

procedure TFContabilEncerramentoExercicio.ConfigurarLayoutTela;
begin
  PanelEdits.Enabled := True;

  if StatusTela = stNavegandoEdits then
  begin
    PanelMestre.Enabled := False;
    PanelItens.Enabled := False;
  end
  else
  begin
    PanelMestre.Enabled := True;
    PanelItens.Enabled := True;
  end;
end;

procedure TFContabilEncerramentoExercicio.ControlaBotoes;
begin
  inherited;

  BotaoImprimir.Visible := False;
end;

procedure TFContabilEncerramentoExercicio.ControlaPopupMenu;
begin
  inherited;

  MenuImprimir.Visible := False;
end;
{$ENDREGION}

{$REGION 'Controles CRUD'}
function TFContabilEncerramentoExercicio.DoInserir: Boolean;
begin
  Result := inherited DoInserir;

  ConfigurarLayoutTela;
  if Result then
  begin
    EditMotivo.SetFocus;
  end;
end;

function TFContabilEncerramentoExercicio.DoEditar: Boolean;
begin
  Result := inherited DoEditar;

  ConfigurarLayoutTela;
  if Result then
  begin
    EditMotivo.SetFocus;
  end;
end;

function TFContabilEncerramentoExercicio.DoExcluir: Boolean;
begin
  if inherited DoExcluir then
  begin
    try
      Result := TContabilEncerramentoExeCabController(ObjetoController).Exclui(IdRegistroSelecionado);
    except
      Result := False;
    end;
  end
  else
  begin
    Result := False;
  end;

  if Result then
    TContabilEncerramentoExeCabController(ObjetoController).Consulta(Filtro, Pagina);
end;

function TFContabilEncerramentoExercicio.DoSalvar: Boolean;
var
  ContabilEncerramentoExercicioDetalhe: TContabilEncerramentoExeDetVO;
begin
  DecimalSeparator := '.';
  Result := inherited DoSalvar;

  if Result then
  begin
    try
      if not Assigned(ObjetoVO) then
        ObjetoVO := TContabilEncerramentoExeCabVO.Create;

      TContabilEncerramentoExeCabVO(ObjetoVO).IdEmpresa := Sessao.IdEmpresa;
      TContabilEncerramentoExeCabVO(ObjetoVO).Motivo := EditMotivo.Text;
      TContabilEncerramentoExeCabVO(ObjetoVO).DataInicio := EditDataInicio.Date;
      TContabilEncerramentoExeCabVO(ObjetoVO).DataFim := EditDataFim.Date;
      TContabilEncerramentoExeCabVO(ObjetoVO).DataInclusao := EditDataInclusao.Date;

      // Detalhes
      TContabilEncerramentoExeCabVO(ObjetoVO).ListaContabilEncerramentoExeDetVO := TObjectList<TContabilEncerramentoExeDetVO>.Create;
      CDSContabilEncerramentoExercicioDetalhe.DisableControls;
      CDSContabilEncerramentoExercicioDetalhe.First;
      while not CDSContabilEncerramentoExercicioDetalhe.Eof do
      begin
        ContabilEncerramentoExercicioDetalhe := TContabilEncerramentoExeDetVO.Create;
        ContabilEncerramentoExercicioDetalhe.Id := CDSContabilEncerramentoExercicioDetalheID.AsInteger;
        ContabilEncerramentoExercicioDetalhe.IdContabilEncerramentoExe := TContabilEncerramentoExeCabVO(ObjetoVO).Id;
        ContabilEncerramentoExercicioDetalhe.IdContabilConta := CDSContabilEncerramentoExercicioDetalheID_CONTABIL_CONTA.AsInteger;
        ContabilEncerramentoExercicioDetalhe.SaldoAnterior := CDSContabilEncerramentoExercicioDetalheSALDO_ANTERIOR.AsExtended;
        ContabilEncerramentoExercicioDetalhe.ValorDebito := CDSContabilEncerramentoExercicioDetalheVALOR_DEBITO.AsExtended;
        ContabilEncerramentoExercicioDetalhe.ValorCredito := CDSContabilEncerramentoExercicioDetalheVALOR_CREDITO.AsExtended;
        ContabilEncerramentoExercicioDetalhe.Saldo := CDSContabilEncerramentoExercicioDetalheSALDO.AsExtended;
        TContabilEncerramentoExeCabVO(ObjetoVO).ListaContabilEncerramentoExeDetVO.Add(ContabilEncerramentoExercicioDetalhe);
        CDSContabilEncerramentoExercicioDetalhe.Next;
      end;
      CDSContabilEncerramentoExercicioDetalhe.EnableControls;

      if StatusTela = stInserindo then
        Result := TContabilEncerramentoExeCabController(ObjetoController).Insere(TContabilEncerramentoExeCabVO(ObjetoVO))
      else if StatusTela = stEditando then
      begin
        if TContabilEncerramentoExeCabVO(ObjetoVO).ToJSONString <> TContabilEncerramentoExeCabVO(ObjetoOldVO).ToJSONString then
        begin
          Result := TContabilEncerramentoExeCabController(ObjetoController).Altera(TContabilEncerramentoExeCabVO(ObjetoVO), TContabilEncerramentoExeCabVO(ObjetoOldVO));
        end
        else
          Application.MessageBox('Nenhum dado foi alterado.', 'Mensagem do Sistema', MB_OK + MB_ICONINFORMATION);
      end;
    except
      Result := False;
    end;
  end;
  DecimalSeparator := ',';
end;
{$ENDREGION}

{$REGION 'Controle de Grid'}
procedure TFContabilEncerramentoExercicio.GridDblClick(Sender: TObject);
begin
  inherited;
  ConfigurarLayoutTela;
end;

procedure TFContabilEncerramentoExercicio.GridParaEdits;
var
  ContabilEncerramentoExercicioDetalheEnumerator: TEnumerator<TContabilEncerramentoExeDetVO>;
begin
  inherited;

  if not CDSGrid.IsEmpty then
  begin
    ObjetoVO := ObjetoController.VO<TContabilEncerramentoExeCabVO>(IdRegistroSelecionado);
    if StatusTela = stEditando then
      ObjetoOldVO := ObjetoController.VO<TContabilEncerramentoExeCabVO>(IdRegistroSelecionado);
  end;

  if Assigned(ObjetoVO) then
  begin
    EditMotivo.Text := TContabilEncerramentoExeCabVO(ObjetoVO).Motivo;
    EditDataInicio.Date := TContabilEncerramentoExeCabVO(ObjetoVO).DataInicio;
    EditDataFim.Date := TContabilEncerramentoExeCabVO(ObjetoVO).DataFim;
    EditDataInclusao.Date := TContabilEncerramentoExeCabVO(ObjetoVO).DataInclusao;

    // Detalhes
    ContabilEncerramentoExercicioDetalheEnumerator := TContabilEncerramentoExeCabVO(ObjetoVO).ListaContabilEncerramentoExeDetVO.GetEnumerator;
    try
      with ContabilEncerramentoExercicioDetalheEnumerator do
      begin
        while MoveNext do
        begin
          CDSContabilEncerramentoExercicioDetalhe.Append;
          CDSContabilEncerramentoExercicioDetalheID.AsInteger := Current.id;
          CDSContabilEncerramentoExercicioDetalheID_CONTABIL_ENCERRAMENTO_EXE.AsInteger := Current.IdContabilEncerramentoExe;
          CDSContabilEncerramentoExercicioDetalheID_CONTABIL_CONTA.AsInteger := Current.IdContabilConta;
          CDSContabilEncerramentoExercicioDetalheSALDO_ANTERIOR.AsExtended := Current.SaldoAnterior;
          CDSContabilEncerramentoExercicioDetalheVALOR_DEBITO.AsExtended := Current.ValorDebito;
          CDSContabilEncerramentoExercicioDetalheVALOR_CREDITO.AsExtended := Current.ValorCredito;
          CDSContabilEncerramentoExercicioDetalheSALDO.AsExtended := Current.Saldo;
          CDSContabilEncerramentoExercicioDetalhe.Post;
        end;
      end;
    finally
      ContabilEncerramentoExercicioDetalheEnumerator.Free;
    end;

    TContabilEncerramentoExeCabVO(ObjetoVO).ListaContabilEncerramentoExeDetVO := Nil;
    if Assigned(TContabilEncerramentoExeCabVO(ObjetoOldVO)) then
      TContabilEncerramentoExeCabVO(ObjetoOldVO).ListaContabilEncerramentoExeDetVO := Nil;
  end;

  ConfigurarLayoutTela;
end;
{$ENDREGION}

end.
