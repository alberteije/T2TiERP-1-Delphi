unit UCheques;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, JvExDBGrids, JvDBGrid, JvExControls, JvSpeedButton,
  pngimage, ExtCtrls, JvComponentBase, JvEnterTab, StdCtrls, Buttons,
  JvExButtons, JvBitBtn, ACBrExtenso, ACBrBase, ACBrCHQ, DB, DBClient, ACBrUtil, DateUtils, Generics.Collections, BancoVo;

type
  TFCheques = class(TForm)
    botaoConfirma: TJvBitBtn;
    JvEnterAsTab1: TJvEnterAsTab;
    Image1: TImage;
    botaoCancela: TJvSpeedButton;
    GroupBox1: TGroupBox;
    JvDBGrid1: TJvDBGrid;
    btnRemover: TBitBtn;
    btnAdicionar: TBitBtn;
    pVerso: TPanel;
    Image2: TImage;
    bImpVerso: TButton;
    bFrente: TButton;
    mVerso: TMemo;
    pFrente: TPanel;
    Image3: TImage;
    lExtenso2: TLabel;
    lExtenso1: TLabel;
    edValor: TEdit;
    edFavorecido: TEdit;
    edDia: TEdit;
    edCidade: TEdit;
    edBanco: TEdit;
    edAno: TEdit;
    cbMes: TComboBox;
    bVerso: TButton;
    bImprimir: TButton;
    edAgencia: TEdit;
    edConta: TEdit;
    edNumero: TEdit;
    ACBrCHQ1: TACBrCHQ;
    ACBrExtenso1: TACBrExtenso;
    CDSCheque: TClientDataSet;
    DSCheque: TDataSource;
    CDSChequeBanco: TIntegerField;
    CDSChequeAgencia: TStringField;
    CDSChequeConta: TStringField;
    CDSChequeCheque: TStringField;
    CDSChequeData: TDateField;
    CDSChequeValor: TFloatField;
    GroupBox2: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    SpeedButton1: TSpeedButton;
    editNome: TEdit;
    editCPF: TEdit;
    MemObs: TMemo;
    Label1: TLabel;
    CDSChequeObs: TStringField;
    CDSChequeTipo: TStringField;
    cmbTipo: TComboBox;
    Label4: TLabel;
    btObterCheque: TButton;
    CDSChequeIDBANCO: TIntegerField;
    procedure edBancoExit(Sender: TObject);
    procedure edValorExit(Sender: TObject);
    procedure edValorKeyPress(Sender: TObject; var Key: Char);
    procedure bImprimirClick(Sender: TObject);
    procedure bVersoClick(Sender: TObject);
    procedure bFrenteClick(Sender: TObject);
    procedure bImpVersoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnRemoverClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure botaoConfirmaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btObterChequeClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    Banco: TBancoVO;
  end;

var
  FCheques: TFCheques;
  Confirmou: Boolean;

implementation

uses UCaixa, ChequeClienteVO, ChequeController, UIdentificaCliente,
  VendaController, Biblioteca, BancoController;

{$R *.dfm}

procedure TFCheques.bFrenteClick(Sender: TObject);
begin
  pVerso.Visible  := False;
  pFrente.Visible := True;
end;

procedure TFCheques.bImprimirClick(Sender: TObject);
var
  Data: TDateTime;
begin
  if cbMes.Items.IndexOf(cbMes.Text) < 0 then
  begin
    Application.MessageBox('Mês inválido!', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
    cbMes.SetFocus;
    exit;
  end;

  if StrToFloatDef(edValor.Text, 0) = 0 then
  begin
    Application.MessageBox('Valor inválido!', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
    edValor.SetFocus;
    exit;
  end;

  Data := EncodeDate(StrToIntDef(edAno.Text,YearOf(now)),
                     cbMes.Items.IndexOf(cbMes.Text) + 1,
                     StrToIntDef(edDia.Text,DayOf(now)));

  if (not ACBrCHQ1.ChequePronto) then
  begin
    Application.MessageBox('Cheque não está posicionado na Impressora!', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
    bImprimir.SetFocus;
    exit;
  end;

  ACBrCHQ1.Banco := edBanco.Text;
  ACBrCHQ1.Valor := StrToFloat(edValor.Text);
  ACBrCHQ1.Data  := Data;
  ACBrCHQ1.Favorecido := edFavorecido.Text;
  ACBrCHQ1.Cidade := edCidade.Text;

  ACBrCHQ1.ImprimirCheque;
end;

procedure TFCheques.bImpVersoClick(Sender: TObject);
begin
  ACBrCHQ1.ImprimirVerso(mVerso.Lines);
end;

procedure TFCheques.botaoConfirmaClick(Sender: TObject);
var
  Cheque: TChequeClienteVO;
  ListaCheques: TObjectList<TChequeClienteVO>;
begin
  if VendaCabecalho.IdCliente < 1 then
  begin
    Application.MessageBox('Escolha um cliente para Parcelar!', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
    Abort;
  end;

  ListaCheques := TObjectList<TChequeClienteVO>.Create;

  CDSCheque.First;
  CDSCheque.DisableControls;

  while not CDSCheque.Eof do
  begin
    Cheque := TChequeClienteVO.Create;

    Cheque.IdEcfMovimento := UCaixa.VendaCabecalho.IdMovimento;
    Cheque.IdCliente      := UCaixa.VendaCabecalho.IdCliente;
    Cheque.DataCheque     := FormatDateTime('yyyy-mm-dd', CDSChequeData.AsDatetime);
    Cheque.NumeroCheque   := CDSChequeCheque.AsInteger;
    Cheque.ValorCheque    := CDSChequeValor.AsFloat;
    Cheque.Agencia        := CDSChequeAgencia.AsString;
    Cheque.Conta          := CDSChequeConta.AsString;
    Cheque.IdBanco        := CDSChequeIDBANCO.AsInteger;
    Cheque.Observacoes    := CDSChequeObs.AsString;
    Cheque.TipoCheque     := CDSChequeTipo.AsString;

    ListaCheques.Add(Cheque);
    CDSCheque.next;
  end;

  CDSCheque.EnableControls;

  if TChequeController.IncluirCheque(ListaCheques) then
     Confirmou := True;
  Close;
end;

procedure TFCheques.btnAdicionarClick(Sender: TObject);
var
  Data : TDateTime;
begin
  if cbMes.Items.IndexOf(cbMes.Text) < 0 then
  begin
    Application.MessageBox('Mês inválido!', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
    cbMes.SetFocus;
    exit;
  end;

  if StrToFloatDef(edValor.Text, 0) = 0 then
  begin
    Application.MessageBox('Valor inválido!', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
    edValor.SetFocus;
    exit;
  end;

  if Trim(edBanco.Text) = '' then
  begin
    Application.MessageBox('Banco inválido!', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
    edBanco.SetFocus;
    exit;
  end;

  if Trim(edAgencia.Text) = '' then
  begin
    Application.MessageBox('Agencia inválida!', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
    edAgencia.SetFocus;
    exit;
  end;

  if Trim(edConta.Text) = '' then
  begin
    Application.MessageBox('Conta inválida!', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
    edConta.SetFocus;
    exit;
  end;

  if Trim(edNumero.Text) = '' then
  begin
    Application.MessageBox('Cheque inválido!', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
    edNumero.SetFocus;
    exit;
  end;

  try
    Data := EncodeDate(StrToInt(edAno.Text),
                       cbMes.Items.IndexOf(cbMes.Text) + 1,
                       StrToInt(edDia.Text));
  except
    Application.MessageBox('Data Invalida!', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
    edDia.Text;
    exit;
  end;

  CDSCheque.Append;
  CDSChequeIDBANCO.AsInteger := Banco.Id;
  CDSChequeBanco.AsString   := edBanco.Text;
  CDSChequeAgencia.AsString := edAgencia.Text;
  CDSChequeConta.AsString   := edConta.Text;
  CDSChequeCheque.AsString  := edNumero.Text;
  CDSChequeObs.AsString     := MemObs.Text;
  CDSChequeData.AsDateTime  := Data;
  CDSChequeTipo.AsString    := Copy(cmbTipo.Text,1,1);
  CDSChequeValor.AsFloat    := StrToFloat(edValor.Text);
  CDSCheque.Post;
  Banco.Id := 0;
end;

procedure TFCheques.btnRemoverClick(Sender: TObject);
begin
  if not CDSCheque.IsEmpty then
    CDSCheque.Delete;
end;

procedure TFCheques.btObterChequeClick(Sender: TObject);
var
  sDado, sBanco, sAgencia, sCheque, sContacc: String;
begin
  if not(InputQuery('Leitura Otica do Cheque', 'Passe o Cheque no Leitor', sDado)) then
    exit;

  if sDado <> '' then
  begin
    sDado := DevolveInteiro(sDado);
    sBanco := copy(Sdado,1,3);
    sAgencia := copy(Sdado,4,4);
    sCheque := copy(Sdado,12,6);
    sContacc := copy(Sdado,22,7) + '-'+ copy (Sdado,29,1);
  end;
end;

procedure TFCheques.bVersoClick(Sender: TObject);
begin
  pFrente.Visible := False;
  pVerso.Visible  := True;
end;

procedure TFCheques.edBancoExit(Sender: TObject);
begin
  edBanco.Text := IntToStrZero(StrToIntDef(edBanco.Text, 0), 3);
  Banco.Id := TBancoController.ConsultaIDBanco(strtoint(edBanco.text));
  if Banco.Id = 0 then
  begin
    Application.MessageBox('Banco inválido!!!' , 'Informação do Sistema', Mb_Ok);
    edBanco.SetFocus;
  end;
end;

procedure TFCheques.edValorExit(Sender: TObject);
var
  Texto, Tracos: String;
  Pos, Tamanho: Integer;
begin
  ACBrExtenso1.Valor := StrToFloatDef(edValor.Text, 0);

  { Verificando se o extenso cabe na linha de cima }
  Tracos:= '';
  Texto := '('+Trim(ACBrExtenso1.Texto)+')';
  Pos   := Length(Texto);
  with FCheques.Canvas do
  begin
    Font    := lExtenso1.Font;
    Tamanho := TextWidth(Texto);

    while (Tamanho > lExtenso1.Width) do
    begin
      { Acha um espaço }
      while (Texto[Pos] <> ' ') and (Pos > 0) do
        Pos := Pos - 1;
      Pos := Pos - 1;
      Tamanho := TextWidth(copy(Texto,1,Pos));
    end;

    { Inserindo traços no inicio }
    if Pos < Length(Texto) then
    begin
      while (Tamanho < lExtenso1.Width) do
      begin
        Tracos  := Tracos + '-';
        Tamanho := TextWidth(Tracos + copy(Texto,1,Pos));
      end;
      Tracos := copy(Tracos,1,Length(Tracos)-1);
    end;
  end;

  lExtenso1.Caption := Tracos + copy(Texto,1,Pos);
  lExtenso2.Caption := copy(Texto,Pos+2, Length(Texto))
end;

procedure TFCheques.edValorKeyPress(Sender: TObject; var Key: Char);
begin
  if CharInSet(Key,[',','.']) then
    Key := DecimalSeparator;
end;

procedure TFCheques.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 if Confirmou then
   ModalResult := MROK;
  Banco.Free;
end;

procedure TFCheques.FormCreate(Sender: TObject);
begin
  Banco := TBancoVO.Create;
  Confirmou := False;
  pFrente.Visible := true;
  pVerso.Visible  := false;

  edDia.Text := IntToStr(DayOf(now));
  cbMes.Text := cbMes.Items[ MonthOf(now)-1 ];
  edAno.Text := IntToStr(YearOf(now));

  // TALVEZ SEJA O CASO DE MAIS UM PARAMETRO PARA DETERMINAR SE O COMPONENTE
  // ACBrCHQ VAI IMPRIMIR EM UMA IMPRESSORA COMUM OU NA PROPRIA IMPRESSORA FISCAL
  // SE FOR O CASO DA PROPRIA IMPRESSORA FISCA (PARA OS MODELOS QUE TEM ESTA FUNCAO NATURALMENTE)
  // FAZER O DEVIDO LINK ENTRE ESTE COMPONETE E O ACBRECF.

  if CDSCheque.Active then
    CDSCheque.EmptyDataSet
  else
    CDSCheque.CreateDataSet;
end;

procedure TFCheques.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key = 27 then
    BotaoCancela.Click;
end;

procedure TFCheques.FormShow(Sender: TObject);
begin
  edBanco.SetFocus;
  edBanco.SelectAll;
end;

procedure TFCheques.SpeedButton1Click(Sender: TObject);
begin
  Application.CreateForm(TFIdentificaCliente, FIdentificaCliente);
  FIdentificaCliente.ShowModal;

  if trim (Cliente.Nome)<>'' then
  begin
    editNome.Text:= Cliente.Nome;
    editCPF.Text:= Cliente.CPFOuCNPJ;
    TVendaController.AlteraClienteNaVenda(VendaCabecalho.Id, Cliente.Id, Cliente.CPFOuCNPJ, Cliente.Nome);
    VendaCabecalho.IdCliente:= Cliente.Id;
    VendaCabecalho.NomeCliente:= Cliente.Nome;
    VendaCabecalho.CPFouCNPJCliente:= Cliente.CPFOuCNPJ;
  end;
end;

end.
