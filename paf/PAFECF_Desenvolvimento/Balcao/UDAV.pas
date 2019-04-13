{*******************************************************************************
Title: T2Ti ERP
Description: Tela DAV do sistema de balcão do PAF-ECF.

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
           fonte.clara@hotmail.com</p>

@author Eri Brito
@version 1.0
*******************************************************************************}

unit UDAV;

interface

uses
  SysUtils, Types, Windows, Classes, Forms, ACBrBase,StdCtrls,
  Controls, ComCtrls, ExtCtrls, ACBrEnterTab, Mask, Graphics, Generics.Collections,
  JvExStdCtrls, Dialogs, JvEdit, JvValidateEdit, Buttons,
  JvButton, JvCtrls, JvExButtons, JvBitBtn, ACBrValidador, JvExMask,
  JvToolEdit, JvExControls, JvLabel, JvGradient, COMObj, Grids, DBGrids,
  JvExDBGrids, JvDBGrid, JvDBUltimGrid, DB,DAVController, DavCabecalhoVO, DAVDetalheVO,
  ClienteController, PessoaVO, Messages, pngimage, inifiles, DBCtrls;

type
  TFDAV = class(TForm)
    ACBrEnterTab1: TACBrEnterTab;
    GroupBox1: TGroupBox;
    editCodigo: TEdit;
    editQuantidade: TJvValidateEdit;
    Label1: TLabel;
    Label2: TLabel;
    PanelBotoes: TPanel;
    GroupBox2: TGroupBox;
    Label3: TLabel;
    editCodigoCliente: TMaskEdit;
    GroupBox6: TGroupBox;
    GridItens: TJvDBUltimGrid;
    Label4: TLabel;
    editUnitario: TJvValidateEdit;
    EditNome: TLabeledEdit;
    lblTitulo: TLabel;
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
    editTotalItem: TJvValidateEdit;
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
    Label9: TLabel;
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
    procedure GridItensDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure editQuantidadeExit(Sender: TObject);
    procedure LimpaCliente;

  private
    { Private declarations }
    procedure ShowHint(Sender: TObject);
    procedure LimpaCamposCabecalho;
    procedure LimpaCamposDetalhe;
    procedure ConfiguraCDSGrid;
    procedure LocalizaClienteId;
    procedure LocalizaClienteCpfCnpj;
    procedure IdentificaCliente;
    procedure Confirma;
    procedure ImprimirDAV;
    procedure ConsultaProduto(Codigo: String);
    procedure ConsultaProdutoCodigoBalanca(CodigoBalanca: Integer);
    procedure ConsultaProdutoCodigoInterno(CodigoInterno: string);
    procedure ConsultaProdutoId(id: Integer);
    function DesmembraCodigoDigitado(var CodigoDeBarraOuDescricaoOuIdProduto: string; var Preco, Qtde: Extended): integer;
    procedure MensagemDeProdutoNaoEncontrado;
    procedure VendeItem;
    procedure LocalizaProduto;
    procedure IniciaVendaDeItens;
    procedure ExcluirItem;
    procedure DescontoOuAcrescimo;
    procedure TelaPadrao;
    procedure AtualizaTotais;
    procedure Soma;

  public
  end;

var
  FDAV: TFDAV;
  SeqItem: Integer;
  SubTotal, TotalGeral, Desconto, Acrescimo, TaxaDesconto, TaxaAcrescimo: Extended;
  CodigoDAV: Integer;
  StatusDav: Integer; // 0-Aberto | 1-Impresso
  PodeFinalizar: Integer; // 0-Pode finalizar |1-Não pode finalizar
  Cliente: TPessoaVO;

implementation

uses UImportaProduto, UDataModule, UProcuraCliente , Biblioteca, ProdutoVO,
  ProdutoController, Constantes, ULoginGerenteSupervisor, UDescontoAcrescimo,
  EmpresaVO, EmpresaController;

var
  DAVCabecalho : TDavCabecalhoVO;
  Produto: TProdutoVO;

{$R *.dfm}

procedure TFDAV.ShowHint(Sender: TObject);
begin
  labelDescricaoProduto.Caption := Application.Hint;
end;

procedure TFDAV.ConfiguraCDSGrid;
begin
  // Configuramos o ClientDataSet do DAV Detalhe
  FDataModule.CDSDAV.Close;
  FDataModule.CDSDAV.FieldDefs.Clear;

  FDataModule.CDSDAV.FieldDefs.add('ITEM', ftInteger);
  FDataModule.CDSDAV.FieldDefs.add('GTIN_PRODUTO', ftString, 14);
  FDataModule.CDSDAV.FieldDefs.add('NOME_PRODUTO', ftString, 100);
  FDataModule.CDSDAV.FieldDefs.add('QUANTIDADE', ftFloat);
  FDataModule.CDSDAV.FieldDefs.add('UNIDADE_PRODUTO', ftString, 10);
  FDataModule.CDSDAV.FieldDefs.add('VALOR_UNITARIO', ftFloat);
  FDataModule.CDSDAV.FieldDefs.add('VALOR_TOTAL', ftFloat);
  FDataModule.CDSDAV.FieldDefs.add('ID_PRODUTO', ftInteger);
  FDataModule.CDSDAV.FieldDefs.add('ID_DAV_CABECALHO', ftInteger);
  FDataModule.CDSDAV.FieldDefs.add('CANCELADO', ftString, 1);
  FDataModule.CDSDAV.FieldDefs.add('TOTALIZADOR_PARCIAL', ftString, 10);
  FDataModule.CDSDAV.CreateDataSet;
  TFloatField(FDataModule.CDSDAV.FieldByName('QUANTIDADE')).displayFormat := '#########0.00';
  TFloatField(FDataModule.CDSDAV.FieldByName('VALOR_UNITARIO')).displayFormat := '#########0.00';
  TFloatField(FDataModule.CDSDAV.FieldByName('VALOR_TOTAL')).displayFormat := '#########0.00';

  GridItens.Columns[0].Title.Caption := 'Item';
  GridItens.Columns[0].Title.Alignment := taCenter;
  GridItens.Columns[0].Width := 40;

  GridItens.Columns[1].Title.Caption := 'GTIN Produto';
  GridItens.Columns[1].Title.Alignment := taCenter;
  GridItens.Columns[1].Alignment := taLeftJustify;
  GridItens.Columns[1].Width := 70;

  GridItens.Columns[2].Title.Caption := 'Descrição';
  GridItens.Columns[2].Title.Alignment := taCenter;
  GridItens.Columns[2].Width := 200;

  GridItens.Columns[3].Title.Caption := 'Qtde';
  GridItens.Columns[3].Title.Alignment := taCenter;

  GridItens.Columns[4].Title.Caption := 'Unidade';
  GridItens.Columns[4].Title.Alignment := taCenter;
  GridItens.Columns[4].Width := 70;

  GridItens.Columns[5].Title.Caption := 'Vlr. Unitário';
  GridItens.Columns[5].Title.Alignment := taCenter;
  GridItens.Columns[5].Alignment := taRightJustify;

  GridItens.Columns[6].Title.Caption := 'Vlr. Total';
  GridItens.Columns[6].Title.Alignment := taCenter;
  GridItens.Columns[6].Alignment := taRightJustify;

  GridItens.Columns.Items[7].Visible := False;
  GridItens.Columns.Items[8].Visible := False;
  GridItens.Columns.Items[9].Visible := False;
  GridItens.Columns.Items[10].Visible := False;
end;

procedure TFDAV.Soma;
begin
  SubTotal := SubTotal + FDataModule.CDSDAV.FieldByName('VALOR_TOTAL').AsFloat;
  AtualizaTotais;
end;

procedure TFDAV.IdentificaCliente;
begin
  if (StatusDav <> 3) and (StatusDav <> 4 ) then
  begin
    Application.CreateForm(TFProcuraCliente, FProcuraCliente);
    FProcuraCliente.ShowModal;
    if FProcuraCliente.IdClientePassou > 0 then
    begin
      editCodigoCliente.Text := IntToStr(FProcuraCliente.IdClientePassou);
      EditNome.Text := FProcuraCliente.NomePassou;
      editCpfCnpj.Text := FProcuraCliente.CpfCnpjPassou;
      editCodigoCliente.SetFocus;
    end
    else
      keybd_event(VK_Return, 0, 0, 0);
  end
  else
    Application.MessageBox('Emissão de DAV em Estado de Alteração ou Exclusão.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
end;

procedure TFDAV.Confirma;
var
  DAVControl : TDAVController;
  DAVDetalhe: TDAVDetalheVO;
  ListaDAVDetalhe: TObjectList<TDAVDetalheVO>;
begin
  if (EditNome.Text <> '') and (EditCPFCNPJ.Text <> '') then
  begin
    if (ValidaCPF(DevolveInteiro(EditCPFCNPJ.Text))) or (ValidaCNPJ(DevolveInteiro(EditCPFCNPJ.Text))) then
    begin
      if FDataModule.CDSDAV.RecordCount > 0 then
      begin
        DAVControl := TDAVController.Create;
        ListaDAVDetalhe := TObjectList<TDAVDetalheVO>.Create;
        //
        DAVCabecalho.IdEmpresa := Constantes.TConstantes.EMPRESA_BALCAO;
        DAVCabecalho.IdPessoa := Cliente.Id;
        DAVCabecalho.NomeDestinatario := EditNome.Text;
        DAVCabecalho.CpfCnpjDestinatario := DevolveInteiro(EditCPFCNPJ.Text);
        DAVCabecalho.DataEmissao := FormatDateTime('yyyy-mm-dd', now);
        DAVCabecalho.HoraEmissao := FormatDateTime('hh:nn:ss', now);
        DAVCabecalho.Situacao := 'P';
        DAVCabecalho.TaxaAcrescimo := TaxaAcrescimo;
        DAVCabecalho.Acrescimo := Acrescimo;
        DAVCabecalho.TaxaDesconto := TaxaDesconto;
        DAVCabecalho.Desconto := Desconto;
        DAVCabecalho.SubTotal := SubTotal;
        DAVCabecalho.Valor := TotalGeral;

        FDataModule.CDSDAV.DisableControls;
        FDataModule.CDSDAV.First;
        while not FDataModule.CDSDAV.Eof do
        begin
          DAVDetalhe := TDAVDetalheVO.Create;
          DAVDetalhe.IdProduto := FDataModule.CDSDAV.FieldByName('ID_PRODUTO').AsInteger;
          DAVDetalhe.Item := FDataModule.CDSDAV.FieldByName('ITEM').AsInteger;
          DAVDetalhe.GtinProduto := FDataModule.CDSDAV.FieldByName('GTIN_PRODUTO').AsString;
          DAVDetalhe.NomeProduto := FDataModule.CDSDAV.FieldByName('NOME_PRODUTO').AsString;
          DAVDetalhe.UnidadeProduto := FDataModule.CDSDAV.FieldByName('UNIDADE_PRODUTO').AsString;
          DAVDetalhe.Quantidade := FDataModule.CDSDAV.FieldByName('QUANTIDADE').AsFloat;
          DAVDetalhe.ValorUnitario := FDataModule.CDSDAV.FieldByName('VALOR_UNITARIO').AsFloat;
          DAVDetalhe.ValorTotal := FDataModule.CDSDAV.FieldByName('VALOR_TOTAL').AsFloat;
          DAVDetalhe.Cancelado := FDataModule.CDSDAV.FieldByName('CANCELADO').AsString;
          DAVDetalhe.TotalizadorParcial := FDataModule.CDSDAV.FieldByName('TOTALIZADOR_PARCIAL').AsString;
          ListaDAVDetalhe.Add(DAVDetalhe);
          FDataModule.CDSDAV.Next;
        end;
        DAVCabecalho := DAVControl.InsereDAV(DAVCabecalho, ListaDAVDetalhe);
        CodigoDAV := DavCabecalho.Id;
        ShowMessage('Orçamento(DAV) inserido com sucesso. Número: ' + DavCabecalho.NumeroDav);
        StatusDav := 0;
        if Application.MessageBox('Deseja Imprimir o DAV?', 'Pergunta do sistema', MB_YESNO + MB_ICONQUESTION) = IDYES then
          ImprimirDAV;
        TelaPadrao;
        AtualizaTotais;
        Cliente := nil;
        FDataModule.CDSDAV.EnableControls;
        editCodigoCliente.SetFocus;
      end;
    end
    else
    begin
      Application.MessageBox('Não é possível emitir um DAV com CPF ou CNPJ inválido.'+#13+
      '            Preenchimento correto é obrigatório!', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
      editCodigoCliente.SetFocus;
    end;
  end
  else
  begin
    Application.MessageBox('Nome e CPF/CNPJ do destinatário são obrigatórios.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
    editCodigoCliente.SetFocus;
  end;
end;

procedure TFDAV.ExcluirItem;
var
  AuxProduto: string;
begin
  if FDataModule.CDSDAV.RecordCount > 0 then
  begin
    if not (FDataModule.CDSDAV.FieldByName('CANCELADO').AsString =  'S') then
    begin
      if Application.MessageBox('Deseja realmente cancelar o registro selecionado?', 'Pergunta do sistema', MB_YESNO + MB_ICONQUESTION) = IDYES then
      begin
        try
          SubTotal := SubTotal - FDataModule.CDSDAV.FieldByName('VALOR_TOTAL').AsFloat;
          AtualizaTotais;
          FDataModule.CDSDAV.Edit;
          FDataModule.CDSDAV.FieldByName('CANCELADO').AsString := 'S';
          FDataModule.CDSDAV.FieldByName('NOME_PRODUTO').AsString := FDataModule.CDSDAV.FieldByName('NOME_PRODUTO').AsString + ' - CANCELADO';
          FDataModule.CDSDAV.Post;
          GridItens.SetFocus;
        except
          Application.MessageBox('Ocorreu um erro. Cancelamento não realizado!', 'Erro do sistema', MB_OK + MB_ICONERROR);
        end;
      end;
    end
    else
      Application.MessageBox('Item já Cancelado!', 'Não autorizado!', MB_OK + MB_ICONERROR);
  end
  else
    Application.MessageBox('Não Existe Produto Disponível Para Cancelamento.', 'Mensagem do sistema.', MB_OK + MB_ICONERROR);
end;

procedure TFDAV.ImprimirDAV;
var
  Empresa: TEmpresaVO;
  ReportManager: Variant;
begin

  if (CodigoDAV <> 0) and (StatusDav = 0) then
  begin
    try
    Empresa := TEmpresaController.PegaEmpresa(Constantes.TConstantes.EMPRESA_BALCAO);

    ReportManager := CreateOleObject('ReportMan.ReportManX');
    ReportManager.Preview := False;
    ReportManager.ShowProgress := True;
    ReportManager.ShowPrintDialog := False;
    ReportManager.Filename := 'DAV.rep';
    ReportManager.SetParamValue('ID', CodigoDAV);
    ReportManager.SetParamValue('EMPRESA', 'Denominação: ' + Empresa.RazaoSocial);
    ReportManager.SetParamValue('CNPJ', 'CNPJ: ' + MascTexto(Empresa.Cnpj,'99.999.999/9999-99'));
    ReportManager.SetParamValue('SUBTOTAL', FormatFloat('0.00', SubTotal));
    if Desconto >  0 then
      ReportManager.SetParamValue('DESCONTO_ACRESCIMO', '(' + FormatFloat('0.00', Desconto) + ')')
    else if Acrescimo >  0 then
      ReportManager.SetParamValue('DESCONTO_ACRESCIMO', FormatFloat('0.00', Acrescimo))
    else
      ReportManager.SetParamValue('DESCONTO_ACRESCIMO', '0,00');
    ReportManager.SetParamValue('TOTAL', FormatFloat('0.00', TotalGeral));
    ReportManager.execute;
    StatusDav := 1;
    CodigoDAV := 0;
    except
        Application.MessageBox('Falha na Impressão!', 'Informação do Sistema', MB_OK + MB_ICONERROR);
    end;
  end
  else
    Application.MessageBox('DAV ainda não gravado, ou já impresso.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
end;

procedure TFDAV.FormActivate(Sender: TObject);
var
  ini : Tinifile;
  ImprimeDav : String;
begin
  try
    ini := TIniFile.Create(ExtractFilePath(Application.ExeName)+'ArquivoAuxiliar.ini');
    ImprimeDav := UpperCase(Codifica('D', ini.ReadString('ESTABELECIMENTO','IMPRIMEDAV','')));
  finally
    ini.Free;
  end;

  PodeFinalizar               := 1;
  StatusDav                   := 0;
  Cliente := TPessoaVO.Create;
  DAVCabecalho := TDAVCabecalhoVO.Create;
  editCodigoCliente.SetFocus;
  TelaPadrao;
end;

procedure TFDAV.AtualizaTotais;
begin
  TotalGeral := SubTotal + (Acrescimo - Desconto);

  if Desconto >  0 then
  begin
    lblDescAcrescDescricao.Caption := 'Desconto:';
    LabelDescontoAcrescimo.Caption := FormatFloat('0.00',Desconto);
    lblDescAcrescDescricao.Font.Color := clRed;
    LabelDescontoAcrescimo.Font.Color := clRed;
  end
  else if Acrescimo >  0 then
  begin
    lblDescAcrescDescricao.Caption := 'Acréscimo:';
    LabelDescontoAcrescimo.Caption := FormatFloat('0.00',Acrescimo);
    lblDescAcrescDescricao.Font.Color := clGreen;
    LabelDescontoAcrescimo.Font.Color := clGreen;
  end
  else
  begin
    LabelDescontoAcrescimo.Caption := '';
    lblDescAcrescDescricao.Caption := '';
  end;

  lblSubTotal.Caption := FormatFloat('0.00', SubTotal);
  lblValorTotal.Caption := FormatFloat('0.00', TotalGeral);
end;

procedure TFDAV.TelaPadrao;
begin
  LimpaCamposCabecalho;
  LimpaCamposDetalhe;
  TotalGeral    := 0;
  SubTotal      := 0;
  Desconto      := 0;
  Acrescimo     := 0;
  TaxaDesconto  := 0;
  TaxaAcrescimo := 0;
  SeqItem       := 0;
end;

procedure TFDAV.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Application.MessageBox('Deseja Realmente Fechar a Tela de Orçamento(DAV)?', 'Sair do Sistema', MB_YesNo + MB_IconQuestion) <> IdYes then
    Action := caNone
  else
  begin
    Action := caFree;
    FDav := Nil;
  end;
end;

procedure TFDAV.FormCreate(Sender: TObject);
begin
  ConfiguraCDSGrid;
  CodigoDAV := 0;
  Application.OnHint := ShowHint;
end;

procedure TFDAV.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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

procedure TFDAV.LimpaCamposCabecalho;
begin
  editcpfcnpj.Text                  := '';
  editNome.Text                     := '';
  editCodigoCliente.Text            := '';
  FDataModule.CDSDAV.EmptyDataSet;
end;

procedure TFDAV.LimpaCamposDetalhe;
begin
  editQuantidade.Text               := '1,000';
  editUnitario.Text                 := '0,000';
  editTotalItem.Text                := '0,000';
  labelDescricaoProduto.Caption     := '';
  editCodigo.Text                   := '';
end;

procedure TFDAV.LocalizaClienteId;
begin
  Cliente := TClienteController.ConsultaPeloId(StrToint(editCodigoCliente.Text));
  LimpaCliente;

  if Cliente.Id <> 0 then
  begin
    editCodigoCliente.Text    := IntToStr(Cliente.Id);
    EditNome.Text             := Cliente.Nome;
    if Length(DevolveInteiro(Cliente.CPFCNPJ)) = 11 then
       editCPFCNPJ.Text := MascTexto(Cliente.CPFCNPJ,'999.999.999-99');
    if Length(DevolveInteiro(Cliente.CPFCNPJ)) = 14 then
       editCPFCNPJ.Text := MascTexto(Cliente.CPFCNPJ,'99.999.999/9999-99');
  end;
end;

procedure TFDAV.LimpaCliente;
begin
  EditNome.Text    := '';
  editCPFCNPJ.Text := '';
end;

procedure TFDAV.LocalizaClienteCpfCnpj;
begin
  Cliente := TClienteController.ConsultaCPFCNPJ(editCpfCnpj.Text);

  if Cliente.Id <> 0 then
  begin
    editCodigoCliente.Text    := IntToStr(Cliente.Id);
    EditNome.Text             := Cliente.Nome;
    if Length(DevolveInteiro(Cliente.CPFCNPJ)) = 11 then
       editCPFCNPJ.Text := MascTexto(Cliente.CPFCNPJ,'999.999.999-99');
    if Length(DevolveInteiro(Cliente.CPFCNPJ)) = 14 then
       editCPFCNPJ.Text := MascTexto(Cliente.CPFCNPJ,'99.999.999/9999-99');
  end;
end;

procedure TFDAV.IniciaVendaDeItens;
var
  Unitario, Quantidade, Total: Extended;
  vTipo:integer;
  vCodigoDeBarraOuDescricaoOuIdProduto: string;
  vPreco, vQtde: Extended;
begin
  if StatusDav <> 3 then
  begin
    if trim(editCodigo.Text) <> '' then
    begin
      vCodigoDeBarraOuDescricaoOuIdProduto := trim(editCodigo.Text);
      vpreco := 0;
      vQtde := 0;

      vTipo := DesmembraCodigoDigitado(vCodigoDeBarraOuDescricaoOuIdProduto, vPreco,vQtde);

      case vTipo of
        0:
        begin
          MensagemDeProdutoNaoEncontrado;
          abort;
        end;
        1:
          ConsultaProdutoCodigoBalanca(StrToInt(vCodigoDeBarraOuDescricaoOuIdProduto));
        2:
          ConsultaProduto(vCodigoDeBarraOuDescricaoOuIdProduto);
        3:
        begin
          Application.CreateForm(TFImportaProduto, FImportaProduto);
          UImportaProduto.QuemChamou := 'DAV';
          FImportaProduto.EditLocaliza.Text := vCodigoDeBarraOuDescricaoOuIdProduto;
          FImportaProduto.ShowModal;
          if (Length(DevolveInteiro(editCodigo.text))) = (Length(trim(editCodigo.text))) then
          begin
            Produto.Id := 0;
            ConsultaProdutoId(StrToInt64(editCodigo.text));
          end else
          begin
            MensagemDeProdutoNaoEncontrado;
            abort;
          end;
        end;
        4:
          ConsultaProdutoId(StrToInt64(vCodigoDeBarraOuDescricaoOuIdProduto));

      end;
      Application.ProcessMessages;

      if Produto.Id <> 0 then
      begin
        if vQtde > 0  then
           editQuantidade.Value:= vQtde;

        if vpreco > 0 then
           editQuantidade.Text:= FormataFloat('Q',(vPreco/Produto.ValorVenda));

        if (Produto.UnidadeProduto.PodeFracionar = 'N') and (Frac(StrToFloat(EditQuantidade.Text))>0) then
        begin
          Application.MessageBox('Produto não pode ser vendido com quantidade fracionada.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
          LimpaCamposDetalhe;
          editCodigo.SetFocus;
        end
        else
        begin
          editUnitario.Text := FormataFloat('V',Produto.ValorVenda);
          labelDescricaoProduto.Caption := Produto.DescricaoPDV;
          Unitario := StrToFloat(editUnitario.Text);
          Quantidade := StrToFloat(editQuantidade.Text);

          VendeItem;

          Total := TruncaValor(Unitario * Quantidade, Constantes.TConstantes.DECIMAIS_VALOR);

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

procedure TFDAV.VendeItem;
begin
  if Produto.ValorVenda > 0 then
  begin
    inc(SeqItem);
    FDataModule.CDSDAV.Append;
    FDataModule.CDSDAV.FieldByName('ITEM').AsInteger := SeqItem;
    FDataModule.CDSDAV.FieldByName('GTIN_PRODUTO').AsString := Produto.GTIN;
    FDataModule.CDSDAV.FieldByName('NOME_PRODUTO').AsString := Produto.Nome;
    FDataModule.CDSDAV.FieldByName('UNIDADE_PRODUTO').AsString := Produto.UnidadeProduto.Nome;
    FDataModule.CDSDAV.FieldByName('VALOR_UNITARIO').AsString := editUnitario.Text;
    FDataModule.CDSDAV.FieldByName('QUANTIDADE').AsFloat := StrToFloat(editQuantidade.Text);
    FDataModule.CDSDAV.FieldByName('ID_PRODUTO').AsInteger := Produto.Id;
    FDataModule.CDSDAV.FieldByName('CANCELADO').AsString := 'N';
    FDataModule.CDSDAV.FieldByName('TOTALIZADOR_PARCIAL').AsString := Produto.TotalizadorParcial;
    FDataModule.CDSDAV.FieldByName('VALOR_TOTAL').AsFloat := FDataModule.CDSDAV.FieldByName('VALOR_UNITARIO').AsFloat * FDataModule.CDSDAV.FieldByName('QUANTIDADE').AsFloat;
    FDataModule.CDSDAV.Post;
    Soma;
    LimpaCamposDetalhe;
  end
  else
    Application.MessageBox('Produto não pode ser vendido com valor zerado ou negativo.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
end;

procedure TFDAV.LocalizaProduto;
begin
  Application.CreateForm(TFImportaProduto, FImportaProduto);
  UImportaProduto.QuemChamou := 'DAV';
  FImportaProduto.ShowModal;
  if (trim(editCodigo.Text)<>'') then
  begin
    editCodigo.SetFocus;
    IniciaVendaDeItens;
  end;
end;

function TFDAV.DesmembraCodigoDigitado(var CodigoDeBarraOuDescricaoOuIdProduto: string; var Preco, Qtde: Extended): integer; // criado por jose rodrigues
var
  IdentificadorBalanca, vCodDescrId , vPesoOuValor: String;
  DigitosUsadosCodigoBalanca, DigitosUsadosPrecoQtde: Integer;
begin
 { Apenas para complementar, podem haver algumas variações na etiqueta impressa pela impressora.

  Essas variações podem ser:

  A - 2 C C C C 0 T T T T T T DV           Onde:         2 - Digito 2 sempre
  B - 2 C C C C 0 0 P P P P P DV                         C - Código do Produto
  C - 2 C C C C C T T T T T T DV                         0 - Espaço, não utilizado
  D - 2 C C C C C 0 P P P P P DV                         T - Valor Total a Pagar
  E - 2 C C C C C C P P P P P DV                         P - Peso ou Quantidade
                                                         DV- Digito Verificador EAN-13    }

  IdentificadorBalanca := '2';     // colocar na configuração do caixa
  DigitosUsadosCodigoBalanca := 4; //  colocar na configuração do caixa -- pode ser 4 , 5 ou 6
  DigitosUsadosPrecoQtde := 6;    // colocar na configuração do caixa pode ser 5 ou 6
  vPesoOuValor := 'VALOR';         // colocar na configuração do caixa -- pode ser VALOR OU PESO
  vCodDescrId := CodigoDeBarraOuDescricaoOuIdProduto;

  Result:= 0;

  if Length(CodigoDeBarraOuDescricaoOuIdProduto) <= 20 then
  begin
     ConsultaProdutoCodigoInterno(CodigoDeBarraOuDescricaoOuIdProduto);
     if Produto.Id <> 0 then
     begin
       Result:=5;
       exit;
     end;
  end;

  if (Length(DevolveInteiro(vCodDescrId))= 13) or (Length(DevolveInteiro(vCodDescrId))= 14) then
  begin
    if (Length(DevolveInteiro(vCodDescrId))= 13) and (IdentificadorBalanca=Copy(vCodDescrId,1,1)) then
    begin
      if vPesoOuValor = 'VALOR' then
      begin
        Preco:=StrToFloat(Copy(vCodDescrId,13-DigitosUsadosPrecoQtde,DigitosUsadosPrecoQtde))/100;
        CodigoDeBarraOuDescricaoOuIdProduto:=Copy(vCodDescrId,2,DigitosUsadosCodigoBalanca);
        Result:= 1;
      end
      else
      begin
        CodigoDeBarraOuDescricaoOuIdProduto:=Copy(vCodDescrId,2,DigitosUsadosCodigoBalanca);
        Qtde:=StrToFloat(Copy(vCodDescrId,13-DigitosUsadosPrecoQtde,DigitosUsadosPrecoQtde))/1000;
        Result:=1;
      end;
    end
    else
    begin
      CodigoDeBarraOuDescricaoOuIdProduto:=vCodDescrId;
      Result:= 2;
    end;
  end
  else if Length(DevolveInteiro(vCodDescrId))= Length(vCodDescrId) then
  begin
    CodigoDeBarraOuDescricaoOuIdProduto:=copy(vCodDescrId,1,14);
    Result := 4;
  end
  else
  begin
    CodigoDeBarraOuDescricaoOuIdProduto:=vCodDescrId;
    Result := 3;
  end;
end;

procedure TFDAV.ConsultaProduto(Codigo:String);
begin
  Produto := TProdutoController.Consulta(Codigo);
end;

procedure TFDAV.ConsultaProdutoCodigoBalanca(CodigoBalanca: Integer);
begin
  Produto := TProdutoController.ConsultaCodigoBalanca(CodigoBalanca);
end;

procedure TFDAV.ConsultaProdutoCodigoInterno(CodigoInterno: string);
begin
  Produto := TProdutoController.ConsultaCodigoInterno(CodigoInterno);
end;

procedure TFDAV.ConsultaProdutoId(id: Integer);
begin
  Produto := TProdutoController.ConsultaId(Id);
end;

procedure TFDAV.MensagemDeProdutoNaoEncontrado;
begin
  Application.MessageBox('Código não encontrado.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
  LimpaCamposDetalhe;
  editCodigo.SetFocus;
end;

procedure TFDAV.DescontoOuAcrescimo;
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
              if Valor >= SubTotal then
                Application.MessageBox('Desconto não pode ser superior ou igual ao valor da venda.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION)
              else
              begin
                if Valor <= 0 then
                  Application.MessageBox('Valor zerado ou negativo. Operação não realizada.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION)
                else
                begin
                  Desconto := Valor;
                  TaxaDesconto := TruncaValor((Valor/SubTotal)*100,Constantes.TConstantes.DECIMAIS_VALOR);
                  TaxaAcrescimo := 0;
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
                  TaxaDesconto := Valor;
                  Desconto := TruncaValor(SubTotal * (Valor/100),Constantes.TConstantes.DECIMAIS_VALOR);
                  TaxaAcrescimo := 0;
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
                TaxaAcrescimo := TruncaValor((Valor/SubTotal)*100,Constantes.TConstantes.DECIMAIS_VALOR);
                TaxaDesconto := 0;
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
                TaxaAcrescimo := Valor;
                Acrescimo := TruncaValor(SubTotal * (Valor/100),Constantes.TConstantes.DECIMAIS_VALOR);
                TaxaDesconto := 0;
                Desconto := 0;
                AtualizaTotais;
              end;
            end;

            //cancela desconto ou acrescimo
            if Operacao = 5 then
            begin
              TaxaAcrescimo := 0;
              TaxaDesconto := 0;
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
end;

procedure TFDAV.editCodigoKeyPress(Sender: TObject; var Key: Char);
var
  Quantidade: Extended;
begin
  If key = #13 then
  Begin
    Key := #0;
    Perform(Wm_NextDlgCtl,0,0);
  End;

  If key = '*' then
  Begin
    Key := #0;
    try
      Quantidade := StrToFloat(editCodigo.Text);
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

procedure TFDAV.editCodigoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case key of
    VK_RETURN:
    begin
      IniciaVendaDeItens;
    end;
  end;
end;

procedure TFDAV.editCodigoClienteKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    if trim(editCodigoCliente.Text) <> '' then
    begin
      if Length(DevolveInteiro(editCodigoCliente.Text)) <= 9 then
        LocalizaClienteId;
      if Length(DevolveInteiro(editCodigoCliente.Text)) > 9 then
        LocalizaClienteCpfCnpj;
    end;
    if (trim(editCodigoCliente.Text) <> '') and (trim(editNome.Text) <> '') and (trim(editCpfCnpj.Text) <> '') then
        editCodigo.SetFocus;
  end;
end;

procedure TFDAV.editQuantidadeExit(Sender: TObject);
begin
  Editcodigo.SetFocus;
end;

procedure TFDAV.editCodigoEnter(Sender: TObject);
begin
  ACBrEnterTab1.EnterAsTab := False;
end;

procedure TFDAV.editCodigoExit(Sender: TObject);
begin
  ACBrEnterTab1.EnterAsTab := True;
end;

procedure TFDAV.editCodigoClienteEnter(Sender: TObject);
begin
  ACBrEnterTab1.EnterAsTab := False;
end;

procedure TFDAV.editCodigoClienteExit(Sender: TObject);
begin
  ACBrEnterTab1.EnterAsTab := True;
end;

procedure TFDAV.GridItensDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if FDataModule.CDSDAV.FieldByName('CANCELADO').AsString = 'S' then
    GridItens.Canvas.Brush.Color := $00C6C6FF
  else
    GridItens.Canvas.Brush.Color := clWhite;
  If gdselected in state then
  begin
    GridItens.Canvas.Font.Style := [fsbold];
    GridItens.Canvas.Font.Color := clBlack;
  end;
  GridItens.DefaultDrawDataCell(Rect, GridItens.columns[datacol].field, State);
end;

//****************************************************************************//
// Aparência e controle dos painéis com as funções do programa - F1 a F12     //
//****************************************************************************//

procedure TFDAV.panelF1MouseEnter(Sender: TObject);
begin
  panelF1.BevelOuter := bvRaised;
  panelF1.BevelWidth := 2;
end;

procedure TFDAV.panelF1MouseLeave(Sender: TObject);
begin
  panelF1.BevelOuter := bvNone;
end;

procedure TFDAV.panelF1Click(Sender: TObject);
begin
  LocalizaProduto;
end;

procedure TFDAV.panelF6MouseEnter(Sender: TObject);
begin
  panelF6.BevelOuter := bvRaised;
  panelF6.BevelWidth := 2;
end;

procedure TFDAV.panelF6MouseLeave(Sender: TObject);
begin
  panelF6.BevelOuter := bvNone;
end;

procedure TFDAV.panelF6Click(Sender: TObject);
begin
  IdentificaCliente;
end;

procedure TFDAV.panelF8MouseEnter(Sender: TObject);
begin
  panelF8.BevelOuter := bvRaised;
  panelF8.BevelWidth := 2;
end;

procedure TFDAV.panelF8MouseLeave(Sender: TObject);
begin
  panelF8.BevelOuter := bvNone;
end;

procedure TFDAV.panelF8Click(Sender: TObject);
begin
  ExcluirItem;
end;

procedure TFDAV.panelF10MouseEnter(Sender: TObject);
begin
  panelF10.BevelOuter := bvRaised;
  panelF10.BevelWidth := 2;
end;

procedure TFDAV.panelF10MouseLeave(Sender: TObject);
begin
  panelF10.BevelOuter := bvNone;
end;

procedure TFDAV.panelF10Click(Sender: TObject);
begin
  DescontoOuAcrescimo;
end;

procedure TFDAV.panelF12MouseEnter(Sender: TObject);
begin
  panelF12.BevelOuter := bvRaised;
  panelF12.BevelWidth := 2;
end;

procedure TFDAV.panelF12MouseLeave(Sender: TObject);
begin
  panelF12.BevelOuter := bvNone;
end;

procedure TFDAV.panelF12Click(Sender: TObject);
begin
  Confirma;
end;

procedure TFDAV.PanelEscMouseEnter(Sender: TObject);
begin
 PanelEsc.BevelOuter := bvRaised;
 PanelEsc.BevelWidth := 2;
end;

procedure TFDAV.PanelEscMouseLeave(Sender: TObject);
begin
  PanelEsc.BevelOuter := bvNone;
end;

procedure TFDAV.PanelEscClick(Sender: TObject);
begin
   Close;
end;

end.
