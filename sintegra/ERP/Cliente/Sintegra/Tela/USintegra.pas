{ *******************************************************************************
  Title: T2Ti ERP
  Description: Janela Sintegra

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
unit USintegra;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, Grids, DBGrids, StdCtrls, rpgraphicex, ExtCtrls,
  JvExDBGrids, JvDBGrid, JvDBUltimGrid, ActnList, RibbonSilverStyleActnCtrls,
  ActnMan, ToolWin, ActnCtrls, DBXJSON, Mask, JvExMask, JvToolEdit, LabeledCtrls,
  ComCtrls, JvBaseEdits, Biblioteca, SessaoUsuario;

type
  TFSintegra = class(TForm)
    PanelCabecalho: TPanel;
    Bevel1: TBevel;
    Image1: TImage;
    Label2: TLabel;
    ActionToolBarPrincipal: TActionToolBar;
    ActionManagerLocal: TActionManager;
    ActionCancelar: TAction;
    ActionGerarSintegra: TAction;
    PageControlItens: TPageControl;
    tsDados: TTabSheet;
    PanelDados: TPanel;
    ActionSair: TAction;
    PanelMestre: TPanel;
    ComboBoxCodigoConvenio: TLabeledComboBox;
    ComboBoxFinalidadeArquivoSped: TLabeledComboBox;
    ComboBoxNaturezaInformacoes: TLabeledComboBox;
    EditPeriodoInicial: TLabeledDateEdit;
    EditPeriodoFinal: TLabeledDateEdit;
    CDSContador: TClientDataSet;
    DSContador: TDataSource;
    GroupBox1: TGroupBox;
    Grid: TJvDBUltimGrid;
    CDSContadorID: TIntegerField;
    CDSContadorID_PESSOA: TIntegerField;
    CDSContadorINSCRICAO_CRC: TStringField;
    CDSContadorUF_CRC: TStringField;
    CDSContadorFONE: TStringField;
    CDSContadorFAX: TStringField;
    CDSContadorLOGRADOURO: TStringField;
    CDSContadorNUMERO: TStringField;
    CDSContadorCOMPLEMENTO: TStringField;
    CDSContadorBAIRRO: TStringField;
    CDSContadorCIDADE: TStringField;
    CDSContadorCEP: TStringField;
    CDSContadorMUNICIPIO_IBGE: TIntegerField;
    CDSContadorUF: TStringField;
    CDSContadorEMAIL: TStringField;
    CDSContadorNOME: TStringField;
    ComboBoxInventario: TLabeledComboBox;
    procedure ActionCancelarExecute(Sender: TObject);
    procedure ActionSairExecute(Sender: TObject);
    procedure ActionGerarSintegraExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FSintegra: TFSintegra;

implementation

uses
  UDataModule, SintegraController, ViewPessoaContadorController;
{$R *.dfm}

procedure TFSintegra.ActionCancelarExecute(Sender: TObject);
begin
  Close;
end;

procedure TFSintegra.ActionSairExecute(Sender: TObject);
begin
  Close;
end;

procedure TFSintegra.FormShow(Sender: TObject);
begin
  EditPeriodoInicial.Clear;
  EditPeriodoFinal.Clear;
  ComboBoxCodigoConvenio.SetFocus;
  EditPeriodoInicial.Date := Now;
  EditPeriodoFinal.Date := Now;
  //
  TViewPessoaContadorController.SetDataSet(CDSContador);
  TViewPessoaContadorController.Consulta('ID > 0', 0);
end;

procedure TFSintegra.ActionGerarSintegraExecute(Sender: TObject);
begin
  TSintegraController.Consulta(
    DataParaTexto(EditPeriodoInicial.Date) + '|' +                   //0
    DataParaTexto(EditPeriodoFinal.Date) + '|' +                     //1
    IntToStr(ComboBoxCodigoConvenio.ItemIndex) + '|' +               //2
    IntToStr(ComboBoxFinalidadeArquivoSped.ItemIndex) + '|' +        //3
    IntToStr(ComboBoxNaturezaInformacoes.ItemIndex) + '|' +          //4
    IntToStr(TSessaoUsuario.Instance.IdEmpresa) + '|' +              //5
    IntToStr(ComboBoxInventario.ItemIndex) + '|' +                   //6
    CDSContadorID.AsString,                                          //7
    0                                                                //página
  );
end;

procedure TFSintegra.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    ActionSair.Execute;
end;

end.
