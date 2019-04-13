{*******************************************************************************
Title: T2Ti ERP
Description: Tela principal do PAF-ECF - Caixa.

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

@author Albert Eije (T2Ti.COM) | Jose Rodrigues de Oliveira Junior
@version 1.0
*******************************************************************************}
unit UNotaFiscal;

interface

uses
  SysUtils, Types, Windows, Classes, Forms, ACBrBase,StdCtrls,
  Controls, ComCtrls, ExtCtrls, ACBrEnterTab, Mask, Graphics, Generics.Collections,
  JvExStdCtrls, Dialogs, JvEdit, JvValidateEdit, Buttons,
  JvExButtons, JvBitBtn, ACBrValidador, JvExMask,
  JvToolEdit, JvExControls, JvLabel, JvGradient, Grids, DBGrids,
  JvExDBGrids, JvDBGrid, JvDBUltimGrid, DB, NotaFiscalController, NotaFiscalDetalheVO,
  NotaFiscalCabecalhoVO, ClienteController, ClienteVO, Messages, pngimage, JvBaseEdits,
  JvMaskEdit;

type
  TFNotaFiscal = class(TForm)
    ACBrEnterTab1: TACBrEnterTab;
    ACBrValidador1: TACBrValidador;
    GroupBox1: TGroupBox;
    editCodigo: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    PanelBotoes: TPanel;
    GroupBox2: TGroupBox;
    Label3: TLabel;
    GroupBox6: TGroupBox;
    GridItens: TJvDBUltimGrid;
    Label4: TLabel;
    EditNome: TLabeledEdit;
    editCpfCnpj: TLabeledEdit;
    GroupBox3: TGroupBox;
    labelDescricaoProduto: TJvLabel;
    GroupBox5: TGroupBox;
    Bevel4: TBevel;
    Bevel2: TBevel;
    Bevel1: TBevel;
    Label7: TLabel;
    lblSubTotal: TLabel;
    LabelDescontoAcrescimo: TLabel;
    Label6: TLabel;
    lblValorTotal: TLabel;
    Label5: TLabel;
    Image1: TImage;
    panelF8: TPanel;
    labelF9: TLabel;
    imageF9: TImage;
    panelF12: TPanel;
    labelF12: TLabel;
    imageF12: TImage;
    PanelEsc: TPanel;
    Label8: TLabel;
    Image2: TImage;
    panelF1: TPanel;
    labelF1: TLabel;
    imageF1: TImage;
    PanelF6: TPanel;
    LabelF6: TLabel;
    ImageF6: TImage;
    panelF10: TPanel;
    labelF10: TLabel;
    imageF10: TImage;
    lblDescAcrescDescricao: TLabel;
    editCodigoCliente: TJvCalcEdit;
    Label11: TLabel;
    EditNumeroNF: TJvCalcEdit;
    Label9: TLabel;
    editCodigoVendedor: TJvCalcEdit;
    cmbNomeVendedor: TComboBox;
    Label12: TLabel;
    EditDataEmissao: TJvDateEdit;
    Label13: TLabel;
    EditHoraEmissao: TJvMaskEdit;
    editQuantidade: TJvCalcEdit;
    editUnitario: TJvCalcEdit;
    editTotalItem: TJvCalcEdit;
    procedure Soma;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure editCodigoClienteKeyPress(Sender: TObject; var Key: Char);
    procedure editCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure editCodigoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure editCodigoEnter(Sender: TObject);
    procedure editCodigoExit(Sender: TObject);
    procedure panelF1Click(Sender: TObject);
    procedure panelF6Click(Sender: TObject);
    procedure panelF8Click(Sender: TObject);
    procedure panelF10Click(Sender: TObject);
    procedure panelF12Click(Sender: TObject);
    procedure PanelEscClick(Sender: TObject);
    procedure panelF1MouseEnter(Sender: TObject);
    procedure panelF1MouseLeave(Sender: TObject);
    procedure panelF6MouseEnter(Sender: TObject);
    procedure panelF6MouseLeave(Sender: TObject);
    procedure panelF8MouseEnter(Sender: TObject);
    procedure panelF8MouseLeave(Sender: TObject);
    procedure panelF10MouseEnter(Sender: TObject);
    procedure panelF10MouseLeave(Sender: TObject);
    procedure panelF12MouseEnter(Sender: TObject);
    procedure panelF12MouseLeave(Sender: TObject);
    procedure PanelEscMouseEnter(Sender: TObject);
    procedure PanelEscMouseLeave(Sender: TObject);
    procedure editCodigoClienteEnter(Sender: TObject);
    procedure editCodigoClienteExit(Sender: TObject);
    procedure CarregaVendedor;
    procedure cmbNomeVendedorChange(Sender: TObject);
    procedure EditNumeroNFExit(Sender: TObject);

  private
    { Private declarations }
    procedure ShowHint(Sender: TObject);
    procedure LimpaCampos;
    procedure ConfiguraCDSGrid;
    procedure LocalizaClienteId;
    procedure LocalizaClienteCpfCnpj;
    procedure IdentificaCliente;
    procedure Confirma;
    procedure AtualizaTotais;
    procedure ConsultaProduto(Codigo:String;Tipo:integer);
    procedure DesmembraCodigoDigitado(CodigoDeBarraOuDescricaoOuIdProduto: string);
    procedure MensagemDeProdutoNaoEncontrado;
    procedure VendeItem;
    procedure LocalizaProduto;
    procedure IniciaVendaDeItens;
    procedure ExcluirItem;
    procedure DescontoOuAcrescimo;
    procedure TelaPadrao;
    procedure Grava;
    procedure LocalizaNota(Nota:string);
    function IntegracaoNotaFiscal(cancelada : string;Cabecalho : TNotaFiscalCabecalhoVO;Detalhe: TObjectList<TNotaFiscalDetalheVO>):boolean;


  public

var
  StatusNotaFiscal: Integer; // 0-Livre | 1-Inclusão | 2-Alteração | 3-Exclusão
  PodeFinalizar: Integer; // 0-Pode finalizar |1-Não pode finalizar
  Cliente: TClienteVO;
end;

var
  FNotaFiscal: TFNotaFiscal;
  SeqItem: Integer;
  SubTotal, TotalGeral, Desconto, Acrescimo: Extended;
  NumeroNF: Integer;

implementation

uses UImportaProduto, UDataModule, UImportaCliente , Biblioteca, ProdutoVO,
  ProdutoController, Constantes, ULoginGerenteSupervisor, UDescontoAcrescimo,
  UCaixa, FuncionarioVO, OperadorController, EmpresaVO, EmpresaController;

var
  NotaFiscalCabecalho : TNotaFiscalCabecalhoVO;
  Produto: TProdutoVO;
  ListaFuncionario: TObjectList<TFuncionarioVO>;

{$R *.dfm}

procedure TFNotaFiscal.ShowHint(Sender: TObject);
begin
  labelDescricaoProduto.Caption := Application.Hint;
end;

procedure TFNotaFiscal.Soma;
begin
  SubTotal := SubTotal + FDataModule.CDSNF.FieldByName('VALOR_TOTAL').AsFloat;
  TotalGeral := SubTotal + (Acrescimo - Desconto);
end;

procedure TFNotaFiscal.CarregaVendedor;
var
  i: Integer;
begin
  ListaFuncionario := TOperadorController.RetornaFuncionario;
  for i := 0 to ListaFuncionario.Count - 1 do
  begin
    cmbNomeVendedor.Items.Add(IntToStr(TFuncionarioVO(ListaFuncionario.Items[i]).Id)+'] '+ TFuncionarioVO(ListaFuncionario.Items[i]).Nome);
  end;
end;

procedure TFNotaFiscal.cmbNomeVendedorChange(Sender: TObject);
var
  Linha: String;
begin
  Linha:= trim(cmbNomeVendedor.Text);
  if linha <> '' then
    editCodigoVendedor.Text:= DevolveConteudoDelimitado(']',linha);
end;

procedure TFNotaFiscal.ConfiguraCDSGrid;
var
  i: Integer;
begin
  // Configuramos o ClientDataSet do DAV Detalhe
  FDataModule.CDSNF.Close;
  FDataModule.CDSNF.FieldDefs.Clear;

  FDataModule.CDSNF.FieldDefs.add('ITEM', ftInteger);
  FDataModule.CDSNF.FieldDefs.add('GTIN', ftString, 14);
  FDataModule.CDSNF.FieldDefs.add('DESCRICAO_PDV', ftString, 30);
  FDataModule.CDSNF.FieldDefs.add('QUANTIDADE', ftFloat);
  FDataModule.CDSNF.FieldDefs.add('VALOR_UNITARIO', ftFloat);
  FDataModule.CDSNF.FieldDefs.add('VALOR_TOTAL', ftFloat);
  FDataModule.CDSNF.FieldDefs.add('ID_PRODUTO', ftInteger);
  FDataModule.CDSNF.FieldDefs.add('CFOP', ftInteger);
  FDataModule.CDSNF.FieldDefs.add('BASE_ICMS', ftFloat);
  FDataModule.CDSNF.FieldDefs.add('TAXA_ICMS', ftFloat);
  FDataModule.CDSNF.FieldDefs.add('ICMS', ftFloat);
  FDataModule.CDSNF.FieldDefs.add('ICMS_OUTRAS', ftFloat);
  FDataModule.CDSNF.FieldDefs.add('ICMS_ISENTO', ftFloat);
  FDataModule.CDSNF.FieldDefs.add('TAXA_DESCONTO', ftFloat);
  FDataModule.CDSNF.FieldDefs.add('DESCONTO', ftFloat);
  FDataModule.CDSNF.FieldDefs.add('TAXA_ISSQN', ftFloat);
  FDataModule.CDSNF.FieldDefs.add('ISSQN', ftFloat);
  FDataModule.CDSNF.FieldDefs.add('TAXA_PIS', ftFloat);
  FDataModule.CDSNF.FieldDefs.add('PIS', ftFloat);
  FDataModule.CDSNF.FieldDefs.add('TAXA_COFINS', ftFloat);
  FDataModule.CDSNF.FieldDefs.add('COFINS', ftFloat);
  FDataModule.CDSNF.FieldDefs.add('TAXA_ACRESCIMO', ftFloat);
  FDataModule.CDSNF.FieldDefs.add('ACRESCIMO', ftFloat);
  FDataModule.CDSNF.FieldDefs.add('TAXA_IPI', ftFloat);
  FDataModule.CDSNF.FieldDefs.add('IPI', ftFloat);
  FDataModule.CDSNF.FieldDefs.add('CANCELADO', ftString, 1);
  FDataModule.CDSNF.FieldDefs.add('CST', ftString, 3);
  FDataModule.CDSNF.FieldDefs.add('ECF_ICMS_ST', ftString, 4);
  FDataModule.CDSNF.FieldDefs.add('TOTALIZADOR_PARCIAL', ftString, 10);
  FDataModule.CDSNF.FieldDefs.add('MOVIMENTA_ESTOQUE', ftString, 1);
  //FDataModule.CDSNF.FieldDefs.add('ID_CLIENTE', ftInteger);
  FDataModule.CDSNF.CreateDataSet;
  TFloatField(FDataModule.CDSNF.FieldByName('QUANTIDADE')).displayFormat:='#########0.00';
  TFloatField(FDataModule.CDSNF.FieldByName('VALOR_UNITARIO')).displayFormat:='#########0.00';
  TFloatField(FDataModule.CDSNF.FieldByName('VALOR_TOTAL')).displayFormat:='#########0.00';
  // Definimos os cabeçalhos da Grid Principal

  GridItens.Columns[0].Title.Caption := 'Item';
  GridItens.Columns[0].Title.Alignment := taCenter;
  GridItens.Columns[0].Alignment := taCenter;
  GridItens.Columns[0].Width := 40;

  GridItens.Columns[1].Title.Caption := 'Produto GTIN';
  GridItens.Columns[1].Title.Alignment := taCenter;
  GridItens.Columns[1].Alignment := taLeftJustify;
  GridItens.Columns[1].Width := 100;

  GridItens.Columns[2].Title.Caption := 'Descrição';
  GridItens.Columns[2].Title.Alignment := taCenter;
  GridItens.Columns[2].Width := 300;

  GridItens.Columns[3].Title.Caption := 'Qtde';
  GridItens.Columns[3].Title.Alignment := taCenter;
  GridItens.Columns[3].Width := 80;

  GridItens.Columns[4].Title.Caption := 'Unitário';
  GridItens.Columns[4].Title.Alignment := taCenter;
  GridItens.Columns[4].Alignment := taRightJustify;
  GridItens.Columns[4].Width := 80;

  GridItens.Columns[5].Title.Caption := 'Total';
  GridItens.Columns[5].Title.Alignment := taCenter;
  GridItens.Columns[5].Alignment := taRightJustify;
  GridItens.Columns[5].Width := 80;

  GridItens.Columns[6].Title.Caption := '#';
  GridItens.Columns[6].Title.Alignment := taCenter;
  GridItens.Columns[6].Alignment := taRightJustify;
  GridItens.Columns[6].Width := 20;

  for i := 0 to GridItens.Columns.Count -1 do
  begin
    //  GridItens.Columns[i].ReadOnly := True;
    if i > 6 then   //nao exibe a coluna
      GridItens.Columns[i].Visible := False;
  end;
end;

procedure TFNotaFiscal.editCodigoClienteEnter(Sender: TObject);
begin
  ACBrEnterTab1.EnterAsTab := False;
end;

procedure TFNotaFiscal.editCodigoClienteExit(Sender: TObject);
begin
  ACBrEnterTab1.EnterAsTab := False;
end;

procedure TFNotaFiscal.editCodigoClienteKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    if trim(editCodigoCliente.Text) <> '' then
    begin
      if Length(editCodigoCliente.Text) <= 9 then
        localizaClienteId;
      if Length(editCodigoCliente.Text) > 9 then
        localizaClienteCpfCnpj;
    end;
  end;
end;

procedure TFNotaFiscal.editCodigoEnter(Sender: TObject);
begin
  ACBrEnterTab1.EnterAsTab := False;
end;

procedure TFNotaFiscal.editCodigoExit(Sender: TObject);
begin
  ACBrEnterTab1.EnterAsTab := True;
end;

procedure TFNotaFiscal.editCodigoKeyPress(Sender: TObject; var Key: Char);
var
  Quantidade: Extended;
begin
  if key = #13 then
  begin
    Key:= #0;
    Perform(Wm_NextDlgCtl,0,0);
  end;

  if key = '*' then
  begin
    Key := #0;
    try
      Quantidade:=StrToFloat(editCodigo.Text);
      if (Quantidade <= 0) or (Quantidade > 999) then
      begin
        Application.MessageBox('Quantidade inválida.', 'Erro', MB_OK + MB_ICONERROR);
        editCodigo.Text := '';
        editQuantidade.Text := '1';
      end
      else
      begin
        editQuantidade.Text := editCodigo.Text;
        editCodigo.Text := '';
      end;
    except
      Application.MessageBox('Quantidade inválida.', 'Erro', MB_OK + MB_ICONERROR);
      editCodigo.Text := '';
      editQuantidade.Text := '1';
    end;
  end;
end;

procedure TFNotaFiscal.IdentificaCliente;
begin
  if (StatusNotaFiscal <> 3) and (StatusNotaFiscal <> 4 ) then
  begin
    Application.CreateForm(TFImportaCliente, FImportaCliente);
    FImportaCliente.QuemChamou := 'NF';
    FImportaCliente.ShowModal;
    if editCodigoCliente.AsInteger > 0 then
    begin
      editCodigoCliente.SetFocus;
      keybd_event(VK_Return, 0, 0, 0);
    end;
  end
  else
    Application.MessageBox('Emissão de Nota Fiscal em Estado de Alteração ou Exclusão.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
end;

procedure TFNotaFiscal.LocalizaClienteId;
begin
  Cliente := TClienteController.ConsultaPeloID(StrToint(editCodigoCliente.Text));

  if Cliente.Id <> 0 then
  begin
    editCodigoCliente.Text    := IntToStr(Cliente.Id);
    EditNome.Text             := Cliente.Nome;
    editCpfCnpj.Text          := Cliente.CPFOuCNPJ;
  end;
end;

procedure TFNotaFiscal.LocalizaClienteCpfCnpj;
begin
  Cliente := TClienteController.ConsultaCPFCNPJ(editCpfCnpj.Text);
  if Cliente.Id <> 0 then
  begin
    editCodigoCliente.Text    := IntToStr(Cliente.Id);
    EditNome.Text             := Cliente.Nome;
    editCpfCnpj.Text          := Cliente.CPFOuCNPJ;
  end;
end;

procedure TFNotaFiscal.Confirma;
  begin
    if (EditNome.Text <> '') and (editCpfCnpj.Text <> '') then
    begin
      Grava;
    end
    else if Application.MessageBox(
        'Nome do Cliente ou CPF/CNPJ não Identificado. Deseja Identificar um Cliente na Nota Fiscal?' +
        #13 + 'Sim: Volta à Tela para Identificar Cliente.' + #13 +
        'Não: Grava Nota Fiscal sem Identificar Cliente.', 'Pergunta do sistema',
      MB_YESNO + MB_ICONQUESTION) = IDYES then
      editCodigoCliente.SetFocus
    else
      Grava;
  end;

procedure TFNotaFiscal.Grava;
var
  NotaFiscalControl: TNotaFiscalController;
  NotaFiscalDetalhe: TNotaFiscalDetalheVO;
  Empresa: TEmpresaVO;
  ListaNotaFiscalDetalhe: TObjectList<TNotaFiscalDetalheVO>;
  Cabecalho: TNotaFiscalCabecalhoVO;
  Detalhe: TObjectList<TNotaFiscalDetalheVO>;
  NumeroNF: Integer;
begin
  NotaFiscalControl := TNotaFiscalController.Create;
  ListaNotaFiscalDetalhe := TObjectList<TNotaFiscalDetalheVO>.Create;
  if editCodigoVendedor.AsInteger <= 0 then
  begin
    ShowMessage('Escolha um Vendedor');
    cmbNomeVendedor.SetFocus;
    abort;
  end;

  Cabecalho := TNotaFiscalController.TabelaNotaFiscalCabecalho(Trim(EditNumeroNF.Text));
  if Cabecalho.Id > 0 then
  begin
    Detalhe:= TNotaFiscalController.TabelaNotaFiscalDetalhe(Cabecalho.Id);
    if IntegracaoNotaFiscal('S',Cabecalho,Detalhe) then
      Application.ProcessMessages;
  end;
  if (Cliente.Id > 1) then
    NotaFiscalCabecalho.IdCliente := Cliente.Id
  else
    NotaFiscalCabecalho.IdCliente := 1;

  //Quando a venda é feita para fora do estado qual o CFOP que deve ser utilizado? Devemos inserir isso na tabela de configuração?
  Empresa := TEmpresaController.PegaEmpresa(UCaixa.Configuracao.IdEmpresa);
  NotaFiscalCabecalho.Cfop := UCaixa.Configuracao.CFOPNF2;

  if Empresa.UF <> Cliente.Uf then
    NotaFiscalCabecalho.Cfop := UCaixa.Configuracao.CFOPNF2
  else
    NotaFiscalCabecalho.Cfop := 5102;

  //a série da nota sempre será 'D' para este caso de entrada de dados?
  NotaFiscalCabecalho.Serie := 'D';

  //qual será a sub-serie da nota? precisamos informar isso?
  NotaFiscalCabecalho.Subserie := '';

  //o cancelado sempre será 'N'?
  NotaFiscalCabecalho.Cancelada := 'N';

  //precisa mesmo desse campo para armazenar o tipo de nota? 1=NFE | 2=NF2
  NotaFiscalCabecalho.TipoNota := '2';

  NotaFiscalCabecalho.Sincronizado := 'N';

  NotaFiscalCabecalho.IdEcfFuncionario := editCodigoVendedor.AsInteger;
  NotaFiscalCabecalho.Numero := EditNumeroNF.Text;
  NotaFiscalCabecalho.DataEmissao := EditDataEmissao.Text;
  NotaFiscalCabecalho.HoraEmissao := EditHoraEmissao.Text;
  FDataModule.CDSNF.DisableControls;
  FDataModule.CDSNF.First;
  while not FDataModule.CDSNF.Eof do
  begin
    NotaFiscalDetalhe := TNotaFiscalDetalheVO.Create;
    NotaFiscalDetalhe.IdProduto := FDataModule.CDSNF.FieldByName('ID_PRODUTO').AsInteger;
    NotaFiscalDetalhe.Item := FDataModule.CDSNF.FieldByName('ITEM').AsInteger;
    NotaFiscalDetalhe.Quantidade := FDataModule.CDSNF.FieldByName('QUANTIDADE').AsFloat;
    NotaFiscalDetalhe.ValorUnitario := FDataModule.CDSNF.FieldByName('VALOR_UNITARIO').AsFloat;
    NotaFiscalDetalhe.ValorTotal := FDataModule.CDSNF.FieldByName('VALOR_TOTAL').AsFloat;
    NotaFiscalDetalhe.Cfop := FDataModule.CDSNF.FieldByName('CFOP').AsInteger;
    NotaFiscalDetalhe.BaseIcms := FDataModule.CDSNF.FieldByName('BASE_ICMS').AsFloat;
    NotaFiscalDetalhe.TaxaIcms := FDataModule.CDSNF.FieldByName('TAXA_ICMS').AsFloat;
    NotaFiscalDetalhe.Icms := FDataModule.CDSNF.FieldByName('ICMS').AsFloat;
    NotaFiscalDetalhe.IcmsOutras := FDataModule.CDSNF.FieldByName('ICMS_OUTRAS').AsFloat;
    NotaFiscalDetalhe.IcmsIsento := FDataModule.CDSNF.FieldByName('ICMS_ISENTO').AsFloat;
    NotaFiscalDetalhe.TaxaDesconto := FDataModule.CDSNF.FieldByName('TAXA_DESCONTO').AsFloat;
    NotaFiscalDetalhe.Desconto := FDataModule.CDSNF.FieldByName('DESCONTO').AsFloat;
    NotaFiscalDetalhe.TaxaIssqn := FDataModule.CDSNF.FieldByName('TAXA_ISSQN').AsFloat;
    NotaFiscalDetalhe.Issqn := FDataModule.CDSNF.FieldByName('ISSQN').AsFloat;
    NotaFiscalDetalhe.TaxaPis := FDataModule.CDSNF.FieldByName('TAXA_PIS').AsFloat;
    NotaFiscalDetalhe.Pis := FDataModule.CDSNF.FieldByName('PIS').AsFloat;
    NotaFiscalDetalhe.TaxaCofins := FDataModule.CDSNF.FieldByName('TAXA_COFINS').AsFloat;
    NotaFiscalDetalhe.Cofins := FDataModule.CDSNF.FieldByName('COFINS').AsFloat;
    NotaFiscalDetalhe.TaxaAcrescimo := FDataModule.CDSNF.FieldByName('TAXA_ACRESCIMO').AsFloat;
    NotaFiscalDetalhe.Acrescimo := FDataModule.CDSNF.FieldByName('ACRESCIMO').AsFloat;
    NotaFiscalDetalhe.TaxaIpi := FDataModule.CDSNF.FieldByName('TAXA_IPI').AsFloat;
    NotaFiscalDetalhe.Ipi := FDataModule.CDSNF.FieldByName('IPI').AsFloat;
    NotaFiscalDetalhe.Cancelado := FDataModule.CDSNF.FieldByName('CANCELADO').AsString;
    NotaFiscalDetalhe.Cst := FDataModule.CDSNF.FieldByName('CST').asString;
    NotaFiscalDetalhe.MovimentaEstoque := FDataModule.CDSNF.FieldByName('MOVIMENTA_ESTOQUE').AsString;
    NotaFiscalDetalhe.TotalizadorParcial := FDataModule.CDSNF.FieldByName('TOTALIZADOR_PARCIAL').AsString;

    ListaNotaFiscalDetalhe.Add(NotaFiscalDetalhe);
    FDataModule.CDSNF.Next;
  end;


  NumeroNF := NotaFiscalControl.InsereNotaFiscal(NotaFiscalCabecalho, ListaNotaFiscalDetalhe);
  Cabecalho := TNotaFiscalController.TabelaNotaFiscalCabecalho(Trim(EditNumeroNF.Text));
  if Cabecalho.Id > 0 then
  begin
    Detalhe:= TNotaFiscalController.TabelaNotaFiscalDetalhe(Cabecalho.Id);
    if IntegracaoNotaFiscal('N',Cabecalho,Detalhe) then
      Application.ProcessMessages;
  end;

  ShowMessage('Nota Fiscal Número: '+ trim(EditNumeroNF.Text)+' inserida com sucesso. ');

  TelaPadrao;
  AtualizaTotais;
  Cliente := nil;
  FDataModule.CDSNF.EnableControls;

  EditCodigo.SetFocus;
end;

procedure TFNotaFiscal.EditNumeroNFExit(Sender: TObject);
begin
  if trim(EditNumeroNF.Text) <> '' then
  begin
    LocalizaNota(trim(EditNumeroNF.Text));
  end;
end;

procedure TFNotaFiscal.ExcluirItem;
begin
  if FDataModule.CDSNF.RecordCount > 0 then
  begin
    if Application.MessageBox('Deseja realmente excluir o registro selecionado?', 'Pergunta do sistema', MB_YESNO + MB_ICONQUESTION) = IDYES then
    begin
      try
        SubTotal := SubTotal - FDataModule.CDSNF.FieldByName('VALOR_TOTAL').AsFloat;
        AtualizaTotais;
        FDataModule.CDSNF.Delete;
        editQuantidade.Text := '1';
        editUnitario.Text :='0,00';
        editTotalItem.Text :='0,00';
        EditCodigo.SetFocus;
      except
        Application.MessageBox('Ocorreu um erro. Exclusão não realizada.', 'Erro do sistema', MB_OK + MB_ICONERROR);
      end;
    end;
  end
  else
    Application.MessageBox('Não Existe Produto Disponível Para Exclusão.', 'Não autorizado!', MB_OK + MB_ICONERROR);
end;

procedure TFNotaFiscal.DescontoOuAcrescimo;
var
  Operacao: integer;
  {
  0-Desconto em Dinheiro
  1-Desconto Percentual
  2-Acréscimo em Dinheiro
  3-Acréscimo Percentual
  5-Cancela o Desconto ou Acréscimo
  }
  Valor: Extended;
begin
  if StatusNotaFiscal <>4 then     ///verificar status
  begin
    Application.CreateForm(TFLoginGerenteSupervisor, FLoginGerenteSupervisor);
    try
      if (FLoginGerenteSupervisor.ShowModal = MROK) then
      begin
        if FLoginGerenteSupervisor.LoginOK then
        begin
          Application.CreateForm(TFDescontoAcrescimo, FDescontoAcrescimo);
          FDescontoAcrescimo.Caption := 'Desconto em Dinheiro';
          try
            if (FDescontoAcrescimo.ShowModal = MROK) then
            begin
              Operacao := FDescontoAcrescimo.ComboOperacao.ItemIndex;
              Valor := StrToFloat(FDescontoAcrescimo.EditEntrada.Text);

              //desconto em valor
              if Operacao = 0 then
              begin
                if Valor >= NotaFiscalCabecalho.TotalNf then
                  Application.MessageBox('Desconto não pode ser superior ou igual ao valor da venda.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION)
                else
                begin
                  if Valor <= 0 then
                    Application.MessageBox('Valor zerado ou negativo. Operação não realizada.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION)
                  else
                  begin
                    Desconto := Valor;
                    NotaFiscalCabecalho.TaxaAcrescimo := 0;
                    Acrescimo := 0;
                    AtualizaTotais;
                  end;
                end;
              end;

              //desconto em taxa
              if Operacao = 1 then
              begin
                if Valor > 99 then
                  Application.MessageBox('Desconto não pode ser superior a 100%.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION)
                else
                begin
                  if Valor <= 0 then
                    Application.MessageBox('Valor zerado ou negativo. Operação não realizada.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION)
                  else
                  begin
                    NotaFiscalCabecalho.TaxaDesconto := Valor;
                    Desconto := TruncaValor(SubTotal * (Valor/100),Constantes.TConstantes.DECIMAIS_VALOR);
                    NotaFiscalCabecalho.TaxaAcrescimo := 0;
                    Acrescimo := 0;
                    AtualizaTotais;
                  end;
                end;
              end;

              //acrescimo em valor
              if Operacao = 2 then
              begin
                if Valor <= 0 then
                  Application.MessageBox('Valor zerado ou negativo. Operação não realizada.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION)
                else
                begin
                  Acrescimo := Valor;
                  NotaFiscalCabecalho.TaxaDesconto := 0;
                  Desconto := 0;
                  AtualizaTotais;
                end;
              end;

              //acrescimo em taxa
              if Operacao = 3 then
              begin
                if Valor <= 0 then
                  Application.MessageBox('Valor zerado ou negativo. Operação não realizada.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION)
                else
                begin
                  NotaFiscalCabecalho.TaxaAcrescimo := Valor;
                  Acrescimo := TruncaValor(SubTotal * (Valor/100),Constantes.TConstantes.DECIMAIS_VALOR);
                  NotaFiscalCabecalho.TaxaDesconto := 0;
                  Desconto := 0;
                  AtualizaTotais;
                end;
              end;

              //cancela desconto ou acrescimo
              if Operacao = 5 then
              begin
                NotaFiscalCabecalho.TaxaAcrescimo := 0;
                NotaFiscalCabecalho.TaxaDesconto := 0;
                Acrescimo := 0;
                Desconto := 0;
                AtualizaTotais;
              end;

            end;
          finally
            if Assigned(FDescontoAcrescimo) then
              FDescontoAcrescimo.Free;
          end;
        end
        else
          Application.MessageBox('Login - dados incorretos.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
      end;
    finally
      if Assigned(FLoginGerenteSupervisor) then
        FLoginGerenteSupervisor.Free;
    end;
  end
  else
    Application.MessageBox('Não existe venda em andamento.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
end;

procedure TFNotaFiscal.FormActivate(Sender: TObject);
begin
  PodeFinalizar := 1;
  StatusNotaFiscal := 1;
  TelaPadrao;
  Cliente := TClienteVO.Create;
  NotaFiscalCabecalho := TNotaFiscalCabecalhoVO.Create;
  EditNumeroNF.SetFocus;
end;

procedure TFNotaFiscal.AtualizaTotais;
begin
  NotaFiscalCabecalho.TotalProdutos := SubTotal;
  NotaFiscalCabecalho.Desconto := Desconto;
  NotaFiscalCabecalho.Acrescimo := Acrescimo;
  NotaFiscalCabecalho.TotalNf := SubTotal + (Acrescimo - Desconto);

  if Desconto >  0 then
  begin
    lblDescAcrescDescricao.Caption := 'Desconto:';
    LabelDescontoAcrescimo.Caption := FormatFloat('0.00',NotaFiscalCabecalho.Desconto);
    lblDescAcrescDescricao.Font.Color := clRed;
    LabelDescontoAcrescimo.Font.Color := clRed;
  end
  else if Acrescimo >  0 then
  begin
    lblDescAcrescDescricao.Caption := 'Acréscimo:';
    LabelDescontoAcrescimo.Caption := FormatFloat('0.00',NotaFiscalCabecalho.Acrescimo);
    lblDescAcrescDescricao.Font.Color := clGreen;
    LabelDescontoAcrescimo.Font.Color := clGreen;
  end
  else
  begin
    LabelDescontoAcrescimo.Caption := '';
    lblDescAcrescDescricao.Caption := '';
  end;

  lblSubTotal.Caption := FormatFloat('0.00', NotaFiscalCabecalho.TotalProdutos);
  lblValorTotal.Caption := FormatFloat('0.00', NotaFiscalCabecalho.TotalNf);
end;

procedure TFNotaFiscal.TelaPadrao;
begin
  limpaCampos;
  TotalGeral  := 0;
  SubTotal    := 0;
  Desconto    := 0;
  Acrescimo   := 0;
  SeqItem     := 0;
  cmbNomeVendedor.Style:= csDropDownList;
end;

procedure TFNotaFiscal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Application.MessageBox('Deseja Realmente Fechar a Tela de Nota Fiscal?', 'Sair do Sistema', MB_YesNo + MB_IconQuestion) <> IdYes then
    Action := caNone
  else
  begin
    Action := caFree;
    FNotaFiscal := Nil;
  end;
end;

procedure TFNotaFiscal.FormCreate(Sender: TObject);
begin
  ConfiguraCDSGrid;
  CarregaVendedor;
  Application.OnHint := ShowHint;
  ForceDirectories(ExtractFilePath(Application.ExeName)+'Script');
end;

procedure TFNotaFiscal.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key = 112 then
     LocalizaProduto;
  if key = 117 then
     IdentificaCliente;
  if key = 119 then
     ExcluirItem;
  if key = 121 then
    DescontoOuAcrescimo;
  if key = 123 then
    Confirma;
  if key = 27 then
    Close;
end;

procedure TFNotaFiscal.limpaCampos;
begin
  editcpfcnpj.Text                  := '';
  editNome.Text                     := '';
  editQuantidade.Text               := '1,000';
  editUnitario.Text                 := '0,000';
  editTotalItem.Text                := '0,000';
  labelDescricaoProduto.Caption     := '';
  editCodigoCliente.Text            := '';
  editCodigo.Text                   := '';
  FDataModule.CDSNF.EmptyDataSet;
  EditNumeroNF.Text                 := '';
  editCodigoVendedor.Text           := '';
  cmbNomeVendedor.ItemIndex         := -1;
  EditDataEmissao.Date              := now;
  EditHoraEmissao.Text              := FormatDateTime('hh:nn:ss', now);
end;

{desmembrando editcodigo}
procedure TFNotaFiscal.ConsultaProduto(Codigo:String;Tipo:integer);
begin
  Produto := TProdutoController.Consulta(Codigo,Tipo);
end;

procedure TFNotaFiscal.MensagemDeProdutoNaoEncontrado;
begin
  Application.MessageBox('Código não encontrado.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
  editUnitario.Text := '0';
  editTotalItem.Text := '0';
  editQuantidade.Text := '1';
  labelDescricaoProduto.Caption := '';
  editCodigo.SetFocus;
end;

procedure TFNotaFiscal.DesmembraCodigoDigitado(CodigoDeBarraOuDescricaoOuIdProduto: string);
var
  IdentificadorBalanca, vCodDescrId: String;
  LengthInteiro, LengthCodigo: Integer;
begin
  IdentificadorBalanca := Configuracao.BalancaIdentificadorBalanca;
  vCodDescrId := CodigoDeBarraOuDescricaoOuIdProduto;
  LengthInteiro := Length(DevolveInteiro(vCodDescrId));
  LengthCodigo := Length(vCodDescrId);
  FCaixa.ACBrInStore1.ZerarDados;

  if ((LengthInteiro = 13) and (LengthCodigo= 13))  or  ((LengthInteiro = 14) and (LengthCodigo = 14)) then
  begin
    if (LengthInteiro = 13) and (IdentificadorBalanca = Copy(vCodDescrId,1,1)) then
    begin
      FCaixa.ACBrInStore1.Codificacao := trim(Configuracao.BalancaTipoConfiguracaoBalanca);
      FCaixa.ACBrInStore1.Desmembrar(trim(vCodDescrId));
      ConsultaProduto(FCaixa.ACBrInStore1.Codigo,1);
      if Produto.Id <> 0 then
        exit
      else
        FCaixa.ACBrInStore1.ZerarDados;
    end;
    ConsultaProduto(vCodDescrId,2);
    if Produto.Id <> 0 then
      exit;
  end;
  ConsultaProduto(vCodDescrId,3);
  if Produto.Id <> 0 then
    exit;
  if LengthInteiro = LengthCodigo then
  begin
    ConsultaProduto(copy(vCodDescrId,1,14),4);
    if Produto.Id <> 0 then
      exit;
  end
  else
  begin
    Application.CreateForm(TFImportaProduto, FImportaProduto);
    FImportaProduto.EditLocaliza.Text:= vCodDescrId;
    FImportaProduto.QuemChamou := 'NF';
    FImportaProduto.ShowModal;
    if (Length(DevolveInteiro(editCodigo.text))) = (Length(trim(editCodigo.text))) then
    begin
      Produto.Id :=0;
      ConsultaProduto(trim(editCodigo.text),4);
    end
    else
    begin
      MensagemDeProdutoNaoEncontrado;
      abort;
    end;
  end;
end;

procedure TFNotaFiscal.VendeItem;
begin
  if Produto.ValorVenda > 0 then
  begin
    inc(SeqItem);
    FNotaFiscal.GridItens.Columns[0].ReadOnly := False;
    FNotaFiscal.GridItens.Columns[1].ReadOnly := False;
    FNotaFiscal.GridItens.Columns[2].ReadOnly := False;
    FNotaFiscal.GridItens.Columns[3].ReadOnly := False;
    FNotaFiscal.GridItens.Columns[4].ReadOnly := False;
    FNotaFiscal.GridItens.Columns[5].ReadOnly := False;


    FDataModule.CDSNF.Append;
    FDataModule.CDSNF.FieldByName('ITEM').AsInteger := SeqItem;
    FDataModule.CDSNF.FieldByName('GTIN').AsAnsiString := Produto.GTIN;
    FDataModule.CDSNF.FieldByName('DESCRICAO_PDV').AsAnsiString := Produto.DescricaoPDV;
    FDataModule.CDSNF.FieldByName('VALOR_UNITARIO').AsFloat := editUnitario.Value;
    FDataModule.CDSNF.FieldByName('QUANTIDADE').AsFloat := editQuantidade.Value;
    FDataModule.CDSNF.FieldByName('VALOR_TOTAL').AsFloat :=  editTotalItem.Value;
    FDataModule.CDSNF.FieldByName('ID_PRODUTO').AsInteger := Produto.Id;
    FDataModule.CDSNF.FieldByName('CFOP').AsInteger := Configuracao.CFOPNF2;
    FDataModule.CDSNF.FieldByName('CST').AsString := Produto.CST;
    // FDataModule.CDSNF.FieldByName('BASE_ICMS').AsFloat := ;
    FDataModule.CDSNF.FieldByName('TAXA_ICMS').AsFloat := Produto.AliquotaICMS;
    //  FDataModule.CDSNF.FieldByName('ICMS').AsFloat := ;
    // FDataModule.CDSNF.FieldByName('ICMS_OUTRAS').AsFloat := ;
    //  FDataModule.CDSNF.FieldByName('ICMS_ISENTO').AsFloat :=  ;
    //  FDataModule.CDSNF.FieldByName('TAXA_DESCONTO').AsFloat := ;
    //  FDataModule.CDSNF.FieldByName('DESCONTO').AsFloat := ;
    FDataModule.CDSNF.FieldByName('TAXA_ISSQN').AsFloat := Produto.AliquotaISSQN;
    //  FDataModule.CDSNF.FieldByName('ISSQN').AsFloat := ;
    FDataModule.CDSNF.FieldByName('TAXA_PIS').AsFloat := Produto.AliquotaPIS;
    //  FDataModule.CDSNF.FieldByName('PIS').AsFloat := ;
    FDataModule.CDSNF.FieldByName('TAXA_COFINS').AsFloat := Produto.AliquotaCOFINS;
    FDataModule.CDSNF.FieldByName('COFINS').AsFloat := Produto.AliquotaCOFINS;
    // FDataModule.CDSNF.FieldByName('TAXA_ACRESCIMO').AsFloat := ;
    //  FDataModule.CDSNF.FieldByName('ACRESCIMO').AsFloat := ;
    FDataModule.CDSNF.FieldByName('TAXA_IPI').AsFloat := Produto.AliquotaIPI;
    //  FDataModule.CDSNF.FieldByName('IPI').AsFloat := ;
    //  FDataModule.CDSNF.FieldByName('CANCELADO').AsString :=;
    //  FDataModule.CDSNF.FieldByName('CST').asString := ;
    // FDataModule.CDSNF.FieldByName('MOVIMENTA_ESTOQUE').AsString := Produto. ;
    FDataModule.CDSNF.FieldByName('TOTALIZADOR_PARCIAL').AsString := Produto.TotalizadorParcial;

    if Produto.IPPT = 'T' then
      FDataModule.CDSNF.FieldByName('MOVIMENTA_ESTOQUE').AsString := 'S'
    else
      FDataModule.CDSNF.FieldByName('MOVIMENTA_ESTOQUE').AsString := 'N';
    FDataModule.CDSNF.Post;

    FNotaFiscal.GridItens.Columns[0].ReadOnly := False;
    FNotaFiscal.GridItens.Columns[1].ReadOnly := True;
    FNotaFiscal.GridItens.Columns[2].ReadOnly := True;
    FNotaFiscal.GridItens.Columns[3].ReadOnly := True;
    FNotaFiscal.GridItens.Columns[4].ReadOnly := True;
    FNotaFiscal.GridItens.Columns[5].ReadOnly := True;

    FNotaFiscal.GridItens.SetFocus;
  end
  else
    Application.MessageBox('Produto não pode ser vendido com valor zerado ou negativo.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
end;

procedure TFNotaFiscal.LocalizaNota(nota:string);
var
  Cabecalho: TNotaFiscalCabecalhoVO;
  NotaDetalhe: TNotaFiscalDetalheVO;
  Detalhe: TObjectList<TNotaFiscalDetalheVO>;
  i: Integer;
  Msg:string;
begin
  try
    Cabecalho := TNotaFiscalController.TabelaNotaFiscalCabecalho(nota);
    if Cabecalho.Id > 0 then
    begin
      Msg := 'A Nota Fiscal Nº '+Nota+#13+' já foi digitada, deseja visualizar?';
      if Application.MessageBox((PWideChar(Msg)), 'Pergunta do sistema', MB_YesNo + MB_IconQuestion) <> IdYes then
        Abort;

      FDataModule.CDSNF.EmptyDataSet;
      editCodigoVendedor.AsInteger:= Cabecalho.IdEcfFuncionario;
      editCodigoCliente.AsInteger := Cabecalho.IdCliente;
      EditNumeroNF.Text := Cabecalho.Numero;
      EditDataEmissao.Text := Cabecalho.DataEmissao;
      EditHoraEmissao.Text := Cabecalho.HoraEmissao;
      localizaClienteId;

      cmbNomeVendedor.Style := csDropDown;
      cmbNomeVendedor.Text := editCodigoVendedor.Text+'] '+ TOperadorController.ConsultaFuncionario(editCodigoVendedor.AsInteger);

      Detalhe := TNotaFiscalController.TabelaNotaFiscalDetalhe(Cabecalho.Id);
      FDataModule.CDSNF.DisableControls;
      for i := 0 to Detalhe.Count - 1 do
      begin
        editCodigo.Text:= IntToStr(TNotaFiscalDetalheVO(Detalhe.Items[i]).IdProduto);
        editQuantidade.Value:= TNotaFiscalDetalheVO(Detalhe.Items[i]).Quantidade;
        Application.ProcessMessages;
        IniciaVendaDeItens;
      end;
      FDataModule.CDSNF.EnableControls;
    end
    else
      cmbNomeVendedor.Style:= csDropDownList;
  except
    FDataModule.CDSNF.EmptyDataSet;
  end;
end;

procedure TFNotaFiscal.LocalizaProduto;
begin
  Application.CreateForm(TFImportaProduto, FImportaProduto);
  FImportaProduto.QuemChamou := 'NF';
  FImportaProduto.ShowModal;
  if (trim(editCodigo.Text)<>'') then
  begin
    editCodigo.SetFocus;
    IniciaVendaDeItens;
  end;
end;

procedure TFNotaFiscal.IniciaVendaDeItens;
var
  Unitario, Quantidade, Total: Extended;
  vTipo:integer;
  vCodigoDeBarraOuDescricaoOuIdProduto: String;
  vPreco, vQtde: Extended;
begin
  if StatusNotaFiscal <> 3 then
  begin
    if trim(editCodigo.Text) <> '' then
    begin
      DesmembraCodigoDigitado(trim(editCodigo.Text));
      Application.ProcessMessages;
      if Produto.Id <> 0 then
      begin
        if Produto.ValorVenda <= 0 then
        begin
          Application.MessageBox('Produto não pode ser vendido com valor Zerado ou negativo!', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
          editCodigo.SetFocus;
          editCodigo.SelectAll;
          abort;
        end;
        if FCaixa.ACBrInStore1.Peso > 0  then
           editQuantidade.Value:= FCaixa.ACBrInStore1.Peso;

        if FCaixa.ACBrInStore1.Total > 0 then
           editQuantidade.Text:= FormataFloat('Q',(FCaixa.ACBrInStore1.Total/Produto.ValorVenda));

        if (Produto.PodeFracionarUnidade = 'N') and (Frac(EditQuantidade.Value)>0) then
        begin
          Application.MessageBox('Produto não pode ser vendido com quantidade fracionada.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
          editUnitario.Text := '0';
          editTotalItem.Text := '0';
          editQuantidade.Text := '1';
          labelDescricaoProduto.Caption := '';
          editCodigo.Text := '';
          editCodigo.SetFocus;
        end
        else
        begin
          editUnitario.Value := Produto.ValorVenda;
          labelDescricaoProduto.Caption := Produto.DescricaoPDV;
          Unitario := editUnitario.Value;
          Quantidade := editQuantidade.Value;

          VendeItem;

          Total := TruncaValor(Unitario * Quantidade, Constantes.TConstantes.DECIMAIS_VALOR);
          editTotalItem.Value := Total;

          AtualizaTotais;
          editCodigo.Clear;
          editCodigo.SetFocus;
          editQuantidade.Text := '1';
          Application.ProcessMessages;
        end;
      end
      else
      begin
        MensagemDeProdutoNaoEncontrado;
      end;
    end;
  end;
end;

function TFNotaFiscal.IntegracaoNotaFiscal(cancelada : string; Cabecalho : TNotaFiscalCabecalhoVO;Detalhe: TObjectList<TNotaFiscalDetalheVO>):boolean;
var
  PathNota, Tipo, Identificacao: String;
  i: Integer;
  atNota: TextFile;
begin
  try
    Identificacao := 'E'+IntToStr(Configuracao.IdEmpresa)+'X'+DevolveInteiro(Configuracao.NomeCaixa)+'N'+IntToStr(Cabecalho.Id)+'D'+DevolveInteiro(DateTimeToStr(now));

    PathNota := ExtractFilePath(Application.ExeName)+'Script\NF2.txt';
    AssignFile(atNota,PathNota);
    Application.ProcessMessages;
    if Cancelada = 'S' then
      Tipo := 'CANCELANF2'
    else
      Tipo := 'INSERENF2';

    if FileExists(PathNota) then
      Append(atNota)
    else
      Rewrite(atNota);

    DecimalSeparator := '.';
    Application.ProcessMessages;

    Write(
      atNota,Tipo+'CAB|'+
      Identificacao+'N|'+
      Configuracao.NomeCaixa+'|'+
      IntToStr(Cabecalho.Id)+'|'+
      IntToStr(Configuracao.IdEmpresa)+'|'+
      Cabecalho.Numero+'|'+

      VerificaNULL(Configuracao.NomeCaixa,1)+'|'+  //   NOME_CAIXA          VARCHAR(30),
      IntToStr(Cabecalho.Id)+'|'+                  //   ID_GERADO_CAIXA     INTEGER,
      IntToStr(Configuracao.IdEmpresa)+'|'+        //   ID_EMPRESA          INTEGER,
      IntToStr(Cabecalho.IdEcfFuncionario)+'|'+    //   ID_ECF_FUNCIONARIO  INTEGER,
      IntToStr(Cabecalho.IdCliente)+'|'+           //   ID_CLIENTE          INTEGER,
      IntToStr(Cabecalho.Cfop)+'|'+                //   CFOP                INTEGER NOT NULL,
      VerificaNULL(Cabecalho.Numero,1)+'|'+        //   NUMERO              VARCHAR(6),
      VerificaNULL(Cabecalho.DataEmissao,1)+'|'+   //   DATA_EMISSAO        DATE,
      VerificaNULL(Cabecalho.HoraEmissao,1)+'|'+   //   HORA_EMISSAO        VARCHAR(8),
      VerificaNULL(Cabecalho.Serie,1)+'|'+         //   SERIE               CHAR(2),
      VerificaNULL(Cabecalho.Subserie,1)+'|'+      //   SUBSERIE            CHAR(2),
      FloatToStr(Cabecalho.TotalProdutos)+'|'+     //   TOTAL_PRODUTOS      DECIMAL(18,6),
      FloatToStr(Cabecalho.TotalNf)+'|'+           //   TOTAL_NF            DECIMAL(18,6),
      FloatToStr(Cabecalho.BaseIcms)+'|'+          //   BASE_ICMS           DECIMAL(18,6),
      FloatToStr(Cabecalho.Icms)+'|'+              //   ICMS                DECIMAL(18,6),
      FloatToStr(Cabecalho.IcmsOutras)+'|'+        //   ICMS_OUTRAS         DECIMAL(18,6),
      FloatToStr(Cabecalho.Issqn)+'|'+             //   ISSQN               DECIMAL(18,6),
      FloatToStr(Cabecalho.Pis)+'|'+               //   PIS                 DECIMAL(18,6),
      FloatToStr(Cabecalho.Cofins)+'|'+            //   COFINS              DECIMAL(18,6),
      FloatToStr(Cabecalho.Ipi)+'|'+               //   IPI                 DECIMAL(18,6),
      FloatToStr(Cabecalho.TaxaAcrescimo)+'|'+     //   TAXA_ACRESCIMO      DECIMAL(18,6),
      FloatToStr(Cabecalho.Acrescimo)+'|'+         //   ACRESCIMO           DECIMAL(18,6),
      FloatToStr(Cabecalho.AcrescimoItens)+'|'+    //   ACRESCIMO_ITENS     DECIMAL(18,6),
      FloatToStr(Cabecalho.TaxaDesconto)+'|'+      //   TAXA_DESCONTO       DECIMAL(18,6),
      FloatToStr(Cabecalho.Desconto)+'|'+          //   DESCONTO            DECIMAL(18,6),
      FloatToStr(Cabecalho.DescontoItens)+'|'+     //   DESCONTO_ITENS      DECIMAL(18,6),
      VerificaNULL(Cabecalho.Cancelada,1)+'|'+     //   CANCELADA           CHAR(1),
      VerificaNULL(Cabecalho.TipoNota,1)+'|'       //   TIPO_NOTA           CHAR(1),
      );                                           //   DATA_SINCRONIZACAO  DATE,
                                                   //   HORA_SINCRONIZACAO  VARCHAR(8)


    Writeln(atNota);
    Application.ProcessMessages;

    for i := 0 to Detalhe.Count - 1 do
    begin
      Write(
        atNota,Tipo+'DET|'+
        Identificacao+'I'+IntToStr(TNotaFiscalDetalheVO(Detalhe.Items[i]).Item)+'|'+

        Configuracao.NomeCaixa+'|'+
        IntToStr(Cabecalho.Id)+'|'+
        IntToStr(Configuracao.IdEmpresa)+'|'+
        Cabecalho.Numero+'|'+
	    	IntToStr(TNotaFiscalDetalheVO(Detalhe.Items[i]).IdProduto)+ '|'+
	    	FloatToStr(TNotaFiscalDetalheVO(Detalhe.Items[i]).Quantidade)+ '|'+

        VerificaNULL(Configuracao.NomeCaixa,1)+'|'+                                   // NOME_CAIXA          INTEGER,
        IntToStr(Cabecalho.Id)+'|'+                                                   // ID_GERADO_CAIXA     INTEGER,
        IntToStr(Configuracao.IdEmpresa)+'|'+                                         // ID_EMPRESA          INTEGER,
        IntToStr(TNotaFiscalDetalheVO(Detalhe.Items[i]).IdNfCabecalho)+ '|'+          // ID_NF_CABECALHO     INTEGER,
        IntToStr(TNotaFiscalDetalheVO(Detalhe.Items[i]).IdProduto)+ '|'+              // ID_PRODUTO          INTEGER,
        IntToStr(TNotaFiscalDetalheVO(Detalhe.Items[i]).Cfop)+ '|'+                   // CFOP                INTEGER NOT NULL,
        IntToStr(TNotaFiscalDetalheVO(Detalhe.Items[i]).Item)+ '|'+                   // ITEM                INTEGER,
        FloatToStr(TNotaFiscalDetalheVO(Detalhe.Items[i]).Quantidade)+ '|'+           // QUANTIDADE          DECIMAL(18,6),
        FloatToStr(TNotaFiscalDetalheVO(Detalhe.Items[i]).ValorUnitario)+ '|'+        // VALOR_UNITARIO      DECIMAL(18,6),
        FloatToStr(TNotaFiscalDetalheVO(Detalhe.Items[i]).ValorTotal)+ '|'+           // VALOR_TOTAL         DECIMAL(18,6),
        FloatToStr(TNotaFiscalDetalheVO(Detalhe.Items[i]).BaseIcms)+ '|'+             // BASE_ICMS           DECIMAL(18,6),
        FloatToStr(TNotaFiscalDetalheVO(Detalhe.Items[i]).TaxaIcms)+ '|'+             // TAXA_ICMS           DECIMAL(18,6),
        FloatToStr(TNotaFiscalDetalheVO(Detalhe.Items[i]).Icms)+ '|'+                 // ICMS                DECIMAL(18,6),
        FloatToStr(TNotaFiscalDetalheVO(Detalhe.Items[i]).IcmsOutras)+ '|'+           // ICMS_OUTRAS         DECIMAL(18,6),
        FloatToStr(TNotaFiscalDetalheVO(Detalhe.Items[i]).IcmsIsento)+ '|'+           // ICMS_ISENTO         DECIMAL(18,6),
        FloatToStr(TNotaFiscalDetalheVO(Detalhe.Items[i]).TaxaDesconto)+ '|'+         // TAXA_DESCONTO       DECIMAL(18,6),
        FloatToStr(TNotaFiscalDetalheVO(Detalhe.Items[i]).Desconto)+ '|'+             // DESCONTO            DECIMAL(18,6),
        FloatToStr(TNotaFiscalDetalheVO(Detalhe.Items[i]).TaxaIssqn)+ '|'+            // TAXA_ISSQN          DECIMAL(18,6),
        FloatToStr(TNotaFiscalDetalheVO(Detalhe.Items[i]).Issqn)+ '|'+                // ISSQN               DECIMAL(18,6),
        FloatToStr(TNotaFiscalDetalheVO(Detalhe.Items[i]).TaxaPis)+ '|'+              // TAXA_PIS            DECIMAL(18,6),
        FloatToStr(TNotaFiscalDetalheVO(Detalhe.Items[i]).Pis)+ '|'+                  // PIS                 DECIMAL(18,6),
        FloatToStr(TNotaFiscalDetalheVO(Detalhe.Items[i]).TaxaCofins)+ '|'+           // TAXA_COFINS         DECIMAL(18,6),
        FloatToStr(TNotaFiscalDetalheVO(Detalhe.Items[i]).Cofins)+ '|'+               // COFINS              DECIMAL(18,6),
        FloatToStr(TNotaFiscalDetalheVO(Detalhe.Items[i]).TaxaAcrescimo)+ '|'+        // TAXA_ACRESCIMO      DECIMAL(18,6),
        FloatToStr(TNotaFiscalDetalheVO(Detalhe.Items[i]).Acrescimo)+ '|'+            // ACRESCIMO           DECIMAL(18,6),
        FloatToStr(TNotaFiscalDetalheVO(Detalhe.Items[i]).TaxaIpi)+ '|'+              // TAXA_IPI            DECIMAL(18,6),
        FloatToStr(TNotaFiscalDetalheVO(Detalhe.Items[i]).Ipi)+ '|'+                  // IPI                 DECIMAL(18,6),
        VerificaNULL(cancelada,1)+ '|'+                                               // CANCELADO           CHAR(1),
        VerificaNULL(TNotaFiscalDetalheVO(Detalhe.Items[i]).Cst,1)+ '|'+              // CST                 CHAR(3),
        VerificaNULL(TNotaFiscalDetalheVO(Detalhe.Items[i]).MovimentaEstoque,1)+'|'+  // MOVIMENTA_ESTOQUE   CHAR(1),
        VerificaNULL(TNotaFiscalDetalheVO(Detalhe.Items[i]).ECFIcmsST,1)+ '|'         // ECF_ICMS_ST         VARCHAR(4),
     );                                                                               // DATA_SINCRONIZACAO  DATE,
                                                                                      // HORA_SINCRONIZACAO  VARCHAR(8)

      Writeln(atNota);
      Application.ProcessMessages;
    end;
  finally
    CloseFile(atNota);
    DecimalSeparator := '.';
  end;
end;

procedure TFNotaFiscal.editCodigoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case key of VK_RETURN:
    begin
      IniciaVendaDeItens;
    end;
  end;
end;

//****************************************************************************//
// Aparência e controle dos painéis com as funções do programa - F1 a F12     //
//****************************************************************************//

procedure TFNotaFiscal.panelF1MouseEnter(Sender: TObject);
begin
  panelF1.BevelOuter := bvRaised;
  panelF1.BevelWidth := 2;
end;

procedure TFNotaFiscal.panelF1MouseLeave(Sender: TObject);
begin
  panelF1.BevelOuter := bvNone;
end;

procedure TFNotaFiscal.panelF1Click(Sender: TObject);
begin
  LocalizaProduto;
end;

procedure TFNotaFiscal.panelF6MouseEnter(Sender: TObject);
begin
  panelF6.BevelOuter := bvRaised;
  panelF6.BevelWidth := 2;
end;

procedure TFNotaFiscal.panelF6MouseLeave(Sender: TObject);
begin
  panelF6.BevelOuter := bvNone;
end;

procedure TFNotaFiscal.panelF6Click(Sender: TObject);
begin
  IdentificaCliente;
end;

procedure TFNotaFiscal.panelF8MouseEnter(Sender: TObject);
begin
  panelF8.BevelOuter := bvRaised;
  panelF8.BevelWidth := 2;
end;

procedure TFNotaFiscal.panelF8MouseLeave(Sender: TObject);
begin
  panelF8.BevelOuter := bvNone;
end;

procedure TFNotaFiscal.panelF8Click(Sender: TObject);
begin
   ExcluirItem;
end;

procedure TFNotaFiscal.panelF10MouseEnter(Sender: TObject);
begin
  panelF10.BevelOuter := bvRaised;
  panelF10.BevelWidth := 2;
end;

procedure TFNotaFiscal.panelF10MouseLeave(Sender: TObject);
begin
  panelF10.BevelOuter := bvNone;
end;

procedure TFNotaFiscal.panelF10Click(Sender: TObject);
begin
  DescontoOuAcrescimo;
end;

procedure TFNotaFiscal.panelF12MouseEnter(Sender: TObject);
begin
  panelF12.BevelOuter := bvRaised;
  panelF12.BevelWidth := 2;
end;

procedure TFNotaFiscal.panelF12MouseLeave(Sender: TObject);
begin
  panelF12.BevelOuter := bvNone;
end;

procedure TFNotaFiscal.panelF12Click(Sender: TObject);
begin
  Confirma;
end;

procedure TFNotaFiscal.PanelEscMouseEnter(Sender: TObject);
begin
 PanelEsc.BevelOuter := bvRaised;
 PanelEsc.BevelWidth := 2;
end;

procedure TFNotaFiscal.PanelEscMouseLeave(Sender: TObject);
begin
  PanelEsc.BevelOuter := bvNone;
end;

procedure TFNotaFiscal.PanelEscClick(Sender: TObject);
begin
   Close;
end;

end.
