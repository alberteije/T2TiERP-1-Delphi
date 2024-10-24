{ *******************************************************************************
  Title: T2Ti ERP
  Description: Janela de Cadastro de Livros Fiscais para o m�dulo Escrita Fiscal

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
unit UFiscalLivro;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UTelaCadastro, DB, DBClient, Menus, StdCtrls, ExtCtrls, Buttons, Grids,
  DBGrids, JvExDBGrids, JvDBGrid, JvDBUltimGrid, ComCtrls, FiscalLivroVO,
  FiscalLivroController, Tipos, Atributos, Constantes, LabeledCtrls, JvToolEdit,
  Mask, JvExMask, JvBaseEdits, Math, StrUtils, ActnList, Generics.Collections,
  RibbonSilverStyleActnCtrls, ActnMan, ToolWin, ActnCtrls;

type
  [TFormDescription(TConstantes.MODULO_ESCRITA_FISCAL, 'Livros Fiscais')]

  TFFiscalLivro = class(TFTelaCadastro)
    DSFiscalTermo: TDataSource;
    CDSFiscalTermo: TClientDataSet;
    PanelMestre: TPanel;
    PageControlItens: TPageControl;
    tsItens: TTabSheet;
    PanelItens: TPanel;
    GridDetalhe: TJvDBUltimGrid;
    EditDescricao: TLabeledEdit;
    CDSFiscalTermoID: TIntegerField;
    CDSFiscalTermoID_FISCAL_LIVRO: TIntegerField;
    CDSFiscalTermoABERTURA_ENCERRAMENTO: TStringField;
    CDSFiscalTermoNUMERO: TIntegerField;
    CDSFiscalTermoPAGINA_INICIAL: TIntegerField;
    CDSFiscalTermoPAGINA_FINAL: TIntegerField;
    CDSFiscalTermoREGISTRADO: TStringField;
    CDSFiscalTermoNUMERO_REGISTRO: TStringField;
    CDSFiscalTermoDATA_DESPACHO: TDateField;
    CDSFiscalTermoDATA_ABERTURA: TDateField;
    CDSFiscalTermoDATA_ENCERRAMENTO: TDateField;
    CDSFiscalTermoESCRITURACAO_INICIO: TDateField;
    CDSFiscalTermoESCRITURACAO_FIM: TDateField;
    CDSFiscalTermoTEXTO: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure GridDblClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    procedure GridParaEdits; override;
    procedure LimparCampos; override;
    procedure ControlaBotoes; override;

    // Controles CRUD
    function DoInserir: Boolean; override;
    function DoEditar: Boolean; override;
    function DoExcluir: Boolean; override;
    function DoSalvar: Boolean; override;

    procedure ConfigurarLayoutTela;
  end;

var
  FFiscalLivro: TFFiscalLivro;

implementation

uses ULookup, Biblioteca, UDataModule, FiscalTermoVO;
{$R *.dfm}

{$REGION 'Controles Infra'}
procedure TFFiscalLivro.FormCreate(Sender: TObject);
begin
  ClasseObjetoGridVO := TFiscalLivroVO;
  ObjetoController := TFiscalLivroController.Create;

  inherited;
end;

procedure TFFiscalLivro.LimparCampos;
begin
  inherited;
  CDSFiscalTermo.EmptyDataSet;
end;

procedure TFFiscalLivro.ConfigurarLayoutTela;
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

procedure TFFiscalLivro.ControlaBotoes;
begin
  inherited;

  BotaoImprimir.Visible := False;
end;
{$ENDREGION}

{$REGION 'Controles CRUD'}
function TFFiscalLivro.DoInserir: Boolean;
begin
  Result := inherited DoInserir;

  ConfigurarLayoutTela;
  if Result then
  begin
    EditDescricao.SetFocus;
  end;
end;

function TFFiscalLivro.DoEditar: Boolean;
begin
  Result := inherited DoEditar;

  ConfigurarLayoutTela;
  if Result then
  begin
    EditDescricao.SetFocus;
  end;
end;

function TFFiscalLivro.DoExcluir: Boolean;
begin
  if inherited DoExcluir then
  begin
    try
      Result := TFiscalLivroController(ObjetoController).Exclui(IdRegistroSelecionado);
    except
      Result := False;
    end;
  end
  else
  begin
    Result := False;
  end;

  if Result then
    TFiscalLivroController(ObjetoController).Consulta(Filtro, Pagina);
end;

function TFFiscalLivro.DoSalvar: Boolean;
var
  FiscalTermo: TFiscalTermoVO;
begin
  DecimalSeparator := '.';
  Result := inherited DoSalvar;

  if Result then
  begin
    try
      if not Assigned(ObjetoVO) then
        ObjetoVO := TFiscalLivroVO.Create;

      TFiscalLivroVO(ObjetoVO).IdEmpresa := Sessao.IdEmpresa;
      TFiscalLivroVO(ObjetoVO).Descricao := EditDescricao.Text;

      // Termos
      TFiscalLivroVO(ObjetoVO).ListaFiscalTermoVO := TObjectList<TFiscalTermoVO>.Create;
      CDSFiscalTermo.DisableControls;
      CDSFiscalTermo.First;
      while not CDSFiscalTermo.Eof do
      begin
        FiscalTermo := TFiscalTermoVO.Create;
        FiscalTermo.Id := CDSFiscalTermoID.AsInteger;
        FiscalTermo.IdFiscalLivro := TFiscalLivroVO(ObjetoVO).Id;
        FiscalTermo.AberturaEncerramento := CDSFiscalTermoABERTURA_ENCERRAMENTO.AsString;
        FiscalTermo.Numero := CDSFiscalTermoNUMERO.AsInteger;
        FiscalTermo.PaginaInicial := CDSFiscalTermoPAGINA_INICIAL.AsInteger;
        FiscalTermo.PaginaFinal := CDSFiscalTermoPAGINA_FINAL.AsInteger;
        FiscalTermo.Registrado := CDSFiscalTermoREGISTRADO.AsString;
        FiscalTermo.NumeroRegistro := CDSFiscalTermoNUMERO_REGISTRO.AsString;
        FiscalTermo.DataDespacho := CDSFiscalTermoDATA_DESPACHO.AsDateTime;
        FiscalTermo.DataAbertura := CDSFiscalTermoDATA_ABERTURA.AsDateTime;
        FiscalTermo.DataEncerramento := CDSFiscalTermoDATA_ENCERRAMENTO.AsDateTime;
        FiscalTermo.EscrituracaoInicio := CDSFiscalTermoESCRITURACAO_INICIO.AsDateTime;
        FiscalTermo.EscrituracaoFim := CDSFiscalTermoESCRITURACAO_FIM.AsDateTime;
        FiscalTermo.Texto := CDSFiscalTermoTEXTO.AsString;
        TFiscalLivroVO(ObjetoVO).ListaFiscalTermoVO.Add(FiscalTermo);
        CDSFiscalTermo.Next;
      end;
      CDSFiscalTermo.EnableControls;

      if StatusTela = stInserindo then
        Result := TFiscalLivroController(ObjetoController).Insere(TFiscalLivroVO(ObjetoVO))
      else if StatusTela = stEditando then
      begin
        if TFiscalLivroVO(ObjetoVO).ToJSONString <> TFiscalLivroVO(ObjetoOldVO).ToJSONString then
        begin
          Result := TFiscalLivroController(ObjetoController).Altera(TFiscalLivroVO(ObjetoVO), TFiscalLivroVO(ObjetoOldVO));
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
procedure TFFiscalLivro.GridDblClick(Sender: TObject);
begin
  inherited;
  ConfigurarLayoutTela;
end;

procedure TFFiscalLivro.GridParaEdits;
var
  FiscalTermoEnumerator: TEnumerator<TFiscalTermoVO>;
begin
  inherited;

  if not CDSGrid.IsEmpty then
  begin
    ObjetoVO := ObjetoController.VO<TFiscalLivroVO>(IdRegistroSelecionado);
    if StatusTela = stEditando then
      ObjetoOldVO := ObjetoController.VO<TFiscalLivroVO>(IdRegistroSelecionado);
  end;

  if Assigned(ObjetoVO) then
  begin
    EditDescricao.Text := TFiscalLivroVO(ObjetoVO).Descricao;

    // Termos
    FiscalTermoEnumerator := TFiscalLivroVO(ObjetoVO).ListaFiscalTermoVO.GetEnumerator;
    try
      with FiscalTermoEnumerator do
      begin
        while MoveNext do
        begin
          CDSFiscalTermo.Append;
          CDSFiscalTermoID.AsInteger := Current.id;
          CDSFiscalTermoID_Fiscal_Livro.AsInteger := Current.IdFiscalLivro;
          CDSFiscalTermoABERTURA_ENCERRAMENTO.AsString := Current.AberturaEncerramento;
          CDSFiscalTermoNUMERO.AsInteger := Current.Numero;
          CDSFiscalTermoPAGINA_INICIAL.AsInteger := Current.PaginaInicial;
          CDSFiscalTermoPAGINA_FINAL.AsInteger := Current.PaginaFinal;
          CDSFiscalTermoREGISTRADO.AsString := Current.Registrado;
          CDSFiscalTermoNUMERO_REGISTRO.AsString := Current.NumeroRegistro;
          CDSFiscalTermoDATA_DESPACHO.AsDateTime := Current.DataDespacho;
          CDSFiscalTermoDATA_ABERTURA.AsDateTime := Current.DataAbertura;
          CDSFiscalTermoDATA_ENCERRAMENTO.AsDateTime := Current.DataEncerramento;
          CDSFiscalTermoESCRITURACAO_INICIO.AsDateTime := Current.EscrituracaoInicio;
          CDSFiscalTermoESCRITURACAO_FIM.AsDateTime := Current.EscrituracaoFim;
          CDSFiscalTermoTEXTO.AsString := Current.Texto;
          CDSFiscalTermo.Post;
        end;
      end;
    finally
      FiscalTermoEnumerator.Free;
    end;

    TFiscalLivroVO(ObjetoVO).ListaFiscalTermoVO := Nil;
    if Assigned(TFiscalLivroVO(ObjetoOldVO)) then
      TFiscalLivroVO(ObjetoOldVO).ListaFiscalTermoVO := Nil;
  end;

  ConfigurarLayoutTela;
end;
{$ENDREGION}

end.
