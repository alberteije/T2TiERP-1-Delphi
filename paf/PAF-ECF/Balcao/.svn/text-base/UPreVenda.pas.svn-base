unit UPreVenda;

interface

uses
  SysUtils, Types, Windows, Classes, Forms, ACBrBase,StdCtrls,
  Controls, ComCtrls, ExtCtrls, ACBrEnterTab, Mask, Graphics, Generics.Collections,
  JvExStdCtrls, Dialogs, JvEdit, JvValidateEdit, Buttons,
  JvButton, JvCtrls, JvExButtons, JvBitBtn, ACBrValidador, JvExMask,
  JvToolEdit, JvExControls, JvLabel, JvGradient, COMObj, Grids, DBGrids,
  JvExDBGrids, JvDBGrid, JvDBUltimGrid, DB,PreVendaController, PreVendaDetalheVO,
  PreVendaCabecalhoVO, ClienteController, PessoaVO, Messages, pngimage;

type
  TFPreVenda = class(TForm)
    ACBrEnterTab1: TACBrEnterTab;
    ACBrValidador1: TACBrValidador;
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
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure editCodigoClienteKeyPress(Sender: TObject; var Key: Char);
    procedure editCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure editCodigoKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
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
    procedure GridItensDrawColumnCell(Sender: TObject; const Rect: TRect;  DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure editQuantidadeExit(Sender: TObject);

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
    procedure Grava;
    procedure AtualizaTotais;
    Procedure Soma;
    procedure LimpaCliente;

  public
  end;

var
  FPreVenda: TFPreVenda;
  SeqItem: Integer;
  SubTotal, TotalGeral, Desconto, Acrescimo, TaxaDesconto, TaxaAcrescimo: Extended;
  NumeroPV: Integer;
  StatusPreVenda: Integer; // 0-Livre | 1-Inclusão | 2-Alteração | 3-Exclusão
  PodeFinalizar: Integer; // 0-Pode finalizar |1-Não pode finalizar
  Cliente: TPessoaVO;

implementation

uses UImportaProduto, UDataModule, UProcuraCliente , Biblioteca, ProdutoVO,
  ProdutoController, Constantes, ULoginGerenteSupervisor, UDescontoAcrescimo;

var
  PreVendaCabecalho : TPreVendaCabecalhoVO;
  Produto: TProdutoVO;

{$R *.dfm}


procedure TFPreVenda.ShowHint(Sender: TObject);
begin
  labelDescricaoProduto.Caption := Application.Hint;
end;

procedure TFPreVenda.ConfiguraCDSGrid;
begin
  // Configuramos o ClientDataSet do DAV Detalhe
  FDataModule.CDSPV.Close;
  FDataModule.CDSPV.FieldDefs.Clear;

  FDataModule.CDSPV.FieldDefs.add('ITEM', ftInteger);
  FDataModule.CDSPV.FieldDefs.add('GTIN_PRODUTO', ftString, 14);
  FDataModule.CDSPV.FieldDefs.add('NOME_PRODUTO', ftString, 100);
  FDataModule.CDSPV.FieldDefs.add('QUANTIDADE', ftFloat);
  FDataModule.CDSPV.FieldDefs.add('UNIDADE_PRODUTO', ftString, 10);
  FDataModule.CDSPV.FieldDefs.add('VALOR_UNITARIO', ftFloat);
  FDataModule.CDSPV.FieldDefs.add('VALOR_TOTAL', ftFloat);
  FDataModule.CDSPV.FieldDefs.add('ID_PRODUTO', ftInteger);
  FDataModule.CDSPV.FieldDefs.add('ID_PV_CABECALHO', ftInteger);
  FDataModule.CDSPV.FieldDefs.add('CANCELADO', ftString, 1);
  FDataModule.CDSPV.FieldDefs.add('ECF_ICMS_ST', ftString, 4);
  FDataModule.CDSPV.CreateDataSet;
  TFloatField(FDataModule.CDSPV.FieldByName('QUANTIDADE')).displayFormat:='#########0.00';
  TFloatField(FDataModule.CDSPV.FieldByName('VALOR_UNITARIO')).displayFormat:='#########0.00';
  TFloatField(FDataModule.CDSPV.FieldByName('VALOR_TOTAL')).displayFormat:='#########0.00';

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

procedure TFPreVenda.Soma;
begin
  SubTotal := SubTotal + FDataModule.CDSPV.FieldByName('VALOR_TOTAL').AsFloat;
  AtualizaTotais;
end;

procedure TFPreVenda.IdentificaCliente;
begin
  if (StatusPreVenda <> 3) and (StatusPreVenda <> 4 ) then
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
    Application.MessageBox('Emissão de Pré-Venda em Estado de Alteração ou Exclusão.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
end;

procedure TFPreVenda.Confirma;
begin
  if (EditNome.Text <> '') and (editCpfCnpj.Text <> '') then
  begin
    Grava;
  end
  else if Application.MessageBox(
      'Nome do Cliente ou CPF/CNPJ não Identificado. Deseja Identificar um Cliente na Pré-Venda?' +
        #13 + 'Sim: Volta à Tela para Identificar Cliente.' + #13 +
        'Não: Grava Pré-Venda sem Identificar Cliente.', 'Pergunta do sistema',
      MB_YESNO + MB_ICONQUESTION) = IDYES then
    editCodigoCliente.SetFocus
  else
    Grava;
end;

procedure TFPreVenda.Grava;
var
  PreVendaControl : TPreVendaController;
  PreVendaDetalhe: TPreVendaDetalheVO;
  ListaPreVendaDetalhe: TObjectList<TPreVendaDetalheVO>;
  NumeroPV: Integer;
begin
  PreVendaControl := TPreVendaController.Create;
  ListaPreVendaDetalhe := TObjectList<TPreVendaDetalheVO>.Create;
  //
  PreVendaCabecalho.IdEmpresa := Constantes.TConstantes.EMPRESA_BALCAO;
  PreVendaCabecalho.IdPessoa := Cliente.Id;
  PreVendaCabecalho.NomeDestinatario := EditNome.Text;
  PreVendaCabecalho.CpfCnpjDestinatario := DevolveInteiro(EditCPFCNPJ.Text);
  PreVendaCabecalho.DataPv := FormatDateTime('yyyy-mm-dd', now);
  PreVendaCabecalho.HoraPv := FormatDateTime('hh:nn:ss', now);
  PreVendaCabecalho.Situacao := 'P';
  PreVendaCabecalho.TaxaAcrescimo := TaxaAcrescimo;
  PreVendaCabecalho.Acrescimo := Acrescimo;
  PreVendaCabecalho.TaxaDesconto := TaxaDesconto;
  PreVendaCabecalho.Desconto := Desconto;
  PreVendaCabecalho.SubTotal := SubTotal;
  PreVendaCabecalho.Valor := TotalGeral;

  FDataModule.CDSPV.DisableControls;
  FDataModule.CDSPV.First;
  while not FDataModule.CDSPV.Eof do
  begin
    PreVendaDetalhe := TPreVendaDetalheVO.Create;
    PreVendaDetalhe.IdProduto := FDataModule.CDSPV.FieldByName('ID_PRODUTO').AsInteger;
    PreVendaDetalhe.Item := FDataModule.CDSPV.FieldByName('ITEM').AsInteger;
    PreVendaDetalhe.GtinProduto := FDataModule.CDSPV.FieldByName('GTIN_PRODUTO').AsString;
    PreVendaDetalhe.NomeProduto := FDataModule.CDSPV.FieldByName('NOME_PRODUTO').AsString;
    PreVendaDetalhe.UnidadeProduto := FDataModule.CDSPV.FieldByName('UNIDADE_PRODUTO').AsString;
    PreVendaDetalhe.Quantidade := FDataModule.CDSPV.FieldByName('QUANTIDADE').AsFloat;
    PreVendaDetalhe.ValorUnitario := FDataModule.CDSPV.FieldByName('VALOR_UNITARIO').AsFloat;
    PreVendaDetalhe.ValorTotal := FDataModule.CDSPV.FieldByName('VALOR_TOTAL').AsFloat;
    PreVendaDetalhe.Cancelado := FDataModule.CDSPV.FieldByName('CANCELADO').AsString;
    PreVendaDetalhe.EcfIcmsSt := FDataModule.CDSPV.FieldByName('ECF_ICMS_ST').AsString;
    ListaPreVendaDetalhe.Add(PreVendaDetalhe);
    FDataModule.CDSPV.Next;
  end;
  NumeroPV := PreVendaControl.InserePreVenda(PreVendaCabecalho, ListaPreVendaDetalhe);
  ShowMessage('Pré-Venda inserida com sucesso. Número: ' + IntToStr(NumeroPV));
  TelaPadrao;
  AtualizaTotais;
  Cliente := nil;
  FDataModule.CDSPV.EnableControls;
  editCodigoCliente.SetFocus;
end;

procedure TFPreVenda.ExcluirItem;
var
  AuxProduto : String;
begin
  if FDataModule.CDSPV.RecordCount > 0 then
  begin
    if not (FDataModule.CDSPV.FieldByName('CANCELADO').AsAnsiString =  'S') then
    begin
      if Application.MessageBox('Deseja realmente Cancelar o registro selecionado?', 'Pergunta do sistema', MB_YESNO + MB_ICONQUESTION) = IDYES then
      begin
        try
          SubTotal := SubTotal - FDataModule.CDSPV.FieldByName('VALOR_TOTAL').AsFloat;
          AtualizaTotais;
          FDataModule.CDSPV.Edit;
          FDataModule.CDSPV.FieldByName('CANCELADO').AsAnsiString :=  'S';
          FDataModule.CDSPV.FieldByName('NOME_PRODUTO').AsString := FDataModule.CDSPV.FieldByName('NOME_PRODUTO').AsString + ' - CANCELADO';
          FDataModule.CDSPV.Post;
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

procedure TFPreVenda.FormActivate(Sender: TObject);
begin
  PodeFinalizar               := 1;
  StatusPreVenda              := 1;
  Cliente := TPessoaVO.Create;
  PreVendaCabecalho := TPreVendaCabecalhoVO.Create;
  editCodigoCliente.SetFocus;
  TelaPadrao;
end;

procedure TFPreVenda.AtualizaTotais;
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

procedure TFPreVenda.TelaPadrao;
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

procedure TFPreVenda.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Application.MessageBox('Deseja Realmente Fechar a Tela de Pré-Venda?', 'Sair do Sistema', MB_YesNo + MB_IconQuestion) <> IdYes then
    Action := caNone
  else
  begin
    Action := caFree;
    FPreVenda := Nil;
  end;
end;

procedure TFPreVenda.FormCreate(Sender: TObject);
begin
  ConfiguraCDSGrid;
  NumeroPV := 0;
  Application.OnHint := ShowHint;
end;

procedure TFPreVenda.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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

procedure TFPreVenda.LimpaCamposCabecalho;
begin
  editcpfcnpj.Text                  := '';
  editNome.Text                     := '';
  editCodigoCliente.Text            := '';
  FDataModule.CDSPV.EmptyDataSet;
end;

procedure TFPreVenda.LimpaCamposDetalhe;
begin
  editQuantidade.Text               := '1,000';
  editUnitario.Text                 := '0,000';
  editTotalItem.Text                := '0,000';
  labelDescricaoProduto.Caption     := '';
  editCodigo.Text                   := '';
end;

procedure TFPreVenda.localizaClienteId;
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

procedure TFPreVenda.LimpaCliente;
begin
  EditNome.Text    := '';
  editCPFCNPJ.Text := '';
end;

procedure TFPreVenda.localizaClienteCpfCnpj;
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

procedure TFPreVenda.IniciaVendaDeItens;
var
  Unitario, Quantidade, Total: Extended;
  vTipo:integer;
  vCodigoDeBarraOuDescricaoOuIdProduto: string;
  vPreco, vQtde: Extended;
begin
  if StatusPreVenda <> 3 then
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
          UImportaProduto.QuemChamou := 'PV';
          FImportaProduto.EditLocaliza.Text:= vCodigoDeBarraOuDescricaoOuIdProduto;
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

procedure TFPreVenda.VendeItem;
begin
  if Produto.ValorVenda > 0 then
  begin
    inc(SeqItem);

    FDataModule.CDSPV.Append;
    FDataModule.CDSPV.FieldByName('ITEM').AsInteger := SeqItem;
    FDataModule.CDSPV.FieldByName('GTIN_PRODUTO').AsAnsiString := Produto.GTIN;
    FDataModule.CDSPV.FieldByName('NOME_PRODUTO').AsString := Produto.Nome;
    FDataModule.CDSPV.FieldByName('UNIDADE_PRODUTO').AsString := Produto.UnidadeProduto.Nome;
    FDataModule.CDSPV.FieldByName('VALOR_UNITARIO').AsAnsiString := editUnitario.Text;
    FDataModule.CDSPV.FieldByName('QUANTIDADE').AsFloat := StrToFloat(editQuantidade.Text);
    FDataModule.CDSPV.FieldByName('ID_PRODUTO').AsInteger := Produto.Id;
    FDataModule.CDSPV.FieldByName('ECF_ICMS_ST').AsString := Produto.EcfIcmsSt;
    FDataModule.CDSPV.FieldByName('CANCELADO').AsString := 'N';
    FDataModule.CDSPV.FieldByName('VALOR_TOTAL').AsFloat := FDataModule.CDSPV.FieldByName('VALOR_UNITARIO').AsFloat * FDataModule.CDSPV.FieldByName('QUANTIDADE').AsFloat;
    FDataModule.CDSPV.Post;

    Soma;

    LimpaCamposDetalhe;
  end
  else
    Application.MessageBox('Produto não pode ser vendido com valor zerado ou negativo.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
end;

procedure TFPreVenda.LocalizaProduto;
begin
  Application.CreateForm(TFImportaProduto, FImportaProduto);
  UImportaProduto.QuemChamou := 'PV';
  FImportaProduto.ShowModal;
  if (trim(editCodigo.Text)<>'') then
  begin
    editCodigo.SetFocus;
    IniciaVendaDeItens;
  end;
end;

function TFPreVenda.DesmembraCodigoDigitado(var CodigoDeBarraOuDescricaoOuIdProduto: string; var Preco, Qtde: Extended): integer; // criado por jose rodrigues
var
  IdentificadorBalanca, vCodDescrId , vPesoOuValor:string;
  DigitosUsadosCodigoBalanca, DigitosUsadosPrecoQtde:integer;
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
      end else
      begin
        CodigoDeBarraOuDescricaoOuIdProduto:=Copy(vCodDescrId,2,DigitosUsadosCodigoBalanca);
        Qtde:=StrToFloat(Copy(vCodDescrId,13-DigitosUsadosPrecoQtde,DigitosUsadosPrecoQtde))/1000;
        Result:=1;
      end;
    end else
    begin
      CodigoDeBarraOuDescricaoOuIdProduto:=vCodDescrId;
      Result:= 2;
    end;
  end else
  if Length(DevolveInteiro(vCodDescrId))= Length(vCodDescrId) then
  begin
    CodigoDeBarraOuDescricaoOuIdProduto:=copy(vCodDescrId,1,14);
    Result := 4;
  end else
  begin
    CodigoDeBarraOuDescricaoOuIdProduto:=vCodDescrId;
    Result := 3;
  end;
end;

procedure TFPreVenda.ConsultaProduto(Codigo:String);
begin
  Produto := TProdutoController.Consulta(Codigo);
end;

procedure TFPreVenda.ConsultaProdutoCodigoBalanca(CodigoBalanca: Integer);
begin
  Produto := TProdutoController.ConsultaCodigoBalanca(CodigoBalanca);
end;

procedure TFPreVenda.ConsultaProdutoCodigoInterno(CodigoInterno: string);
begin
  Produto := TProdutoController.ConsultaCodigoInterno(CodigoInterno);
end;

procedure TFPreVenda.ConsultaProdutoId(id: Integer);
begin
  Produto := TProdutoController.ConsultaId(Id);
end;

procedure TFPreVenda.MensagemDeProdutoNaoEncontrado;
begin
  Application.MessageBox('Código não encontrado.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
  LimpaCamposDetalhe;
  editCodigo.SetFocus;
end;

procedure TFPreVenda.DescontoOuAcrescimo;
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

procedure TFPreVenda.editCodigoKeyPress(Sender: TObject; var Key: Char);
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

procedure TFPreVenda.editCodigoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case key of
    VK_RETURN:
    begin
      IniciaVendaDeItens;
    end;
  end;
end;

procedure TFPreVenda.editCodigoClienteKeyPress(Sender: TObject; var Key: Char);
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

procedure TFPreVenda.editQuantidadeExit(Sender: TObject);
begin
  Editcodigo.SetFocus;
end;

procedure TFPreVenda.editCodigoEnter(Sender: TObject);
begin
  ACBrEnterTab1.EnterAsTab := False;
end;

procedure TFPreVenda.editCodigoExit(Sender: TObject);
begin
  ACBrEnterTab1.EnterAsTab := True;
end;

procedure TFPreVenda.editCodigoClienteEnter(Sender: TObject);
begin
  ACBrEnterTab1.EnterAsTab := False;
end;

procedure TFPreVenda.editCodigoClienteExit(Sender: TObject);
begin
  ACBrEnterTab1.EnterAsTab := False;
end;

procedure TFPreVenda.GridItensDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if FDataModule.CDSPV.FieldByName('CANCELADO').AsAnsiString = 'S' then
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

procedure TFPreVenda.panelF1MouseEnter(Sender: TObject);
begin
  panelF1.BevelOuter := bvRaised;
  panelF1.BevelWidth := 2;
end;

procedure TFPreVenda.panelF1MouseLeave(Sender: TObject);
begin
  panelF1.BevelOuter := bvNone;
end;

procedure TFPreVenda.panelF1Click(Sender: TObject);
begin
  LocalizaProduto;
end;

procedure TFPreVenda.panelF6MouseEnter(Sender: TObject);
begin
  panelF6.BevelOuter := bvRaised;
  panelF6.BevelWidth := 2;
end;

procedure TFPreVenda.panelF6MouseLeave(Sender: TObject);
begin
  panelF6.BevelOuter := bvNone;
end;

procedure TFPreVenda.panelF6Click(Sender: TObject);
begin
  IdentificaCliente;
end;

procedure TFPreVenda.panelF8MouseEnter(Sender: TObject);
begin
  panelF8.BevelOuter := bvRaised;
  panelF8.BevelWidth := 2;
end;

procedure TFPreVenda.panelF8MouseLeave(Sender: TObject);
begin
  panelF8.BevelOuter := bvNone;
end;

procedure TFPreVenda.panelF8Click(Sender: TObject);
begin
   ExcluirItem;
end;

procedure TFPreVenda.panelF10MouseEnter(Sender: TObject);
begin
  panelF10.BevelOuter := bvRaised;
  panelF10.BevelWidth := 2;
end;

procedure TFPreVenda.panelF10MouseLeave(Sender: TObject);
begin
  panelF10.BevelOuter := bvNone;
end;

procedure TFPreVenda.panelF10Click(Sender: TObject);
begin
  DescontoOuAcrescimo;
end;

procedure TFPreVenda.panelF12MouseEnter(Sender: TObject);
begin
  panelF12.BevelOuter := bvRaised;
  panelF12.BevelWidth := 2;
end;

procedure TFPreVenda.panelF12MouseLeave(Sender: TObject);
begin
  panelF12.BevelOuter := bvNone;
end;

procedure TFPreVenda.panelF12Click(Sender: TObject);
begin
    Confirma;
end;

procedure TFPreVenda.PanelEscMouseEnter(Sender: TObject);
begin
 PanelEsc.BevelOuter := bvRaised;
 PanelEsc.BevelWidth := 2;
end;

procedure TFPreVenda.PanelEscMouseLeave(Sender: TObject);
begin
  PanelEsc.BevelOuter := bvNone;
end;

procedure TFPreVenda.PanelEscClick(Sender: TObject);
begin
   Close;
end;

end.
