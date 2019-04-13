unit UExtratoContaBanco;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UTela, StdCtrls, ExtCtrls, Menus, Buttons, Grids, DBGrids,
  JvExDBGrids, JvDBGrid, JvDBUltimGrid, ComCtrls, ActnList,
  RibbonSilverStyleActnCtrls, ActnMan, Generics.Collections;

type
  TFExtratoContaBanco = class(TFTela)
    Bevel1: TBevel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    LabelSaldoExtrato: TLabel;
    LabelDebitos: TLabel;
    LabelCreditos: TLabel;
    BotaoConciliarLancamentos: TSpeedButton;
    ActionManager: TActionManager;
    BotaoConciliarCheques: TSpeedButton;
    BotaoImportaArquivo: TSpeedButton;
    ActionImportarArquivo: TAction;
    ActionConciliarCheques: TAction;
    procedure FormCreate(Sender: TObject);
    procedure ActionImportarArquivoExecute(Sender: TObject);
    procedure ActionConciliarChequesExecute(Sender: TObject);
  private
    { Private declarations }
    procedure AtualizarLabelValores;
    procedure PegarValores;
  public
    { Public declarations }
  end;

var
  FExtratoContaBanco: TFExtratoContaBanco;
  IdContaCaixa: Integer;
  Mes, Ano: String;
  Creditos, Debitos, Saldo: Double;

implementation

uses ExtratoContaBancoController, ExtratoContaBancoVO, NotificationService,
  YMOFXReader, YMOFCReader, UDataModule;

{$R *.dfm}


procedure TFExtratoContaBanco.ActionConciliarChequesExecute(Sender: TObject);
var
  ExtratoContaBanco: TExtratoContaBancoVO;
  ListaExtrato: TObjectList<TExtratoContaBancoVO>;
begin
  if Application.MessageBox('Deseja conciliar os cheques do extrato bancário corrente?', 'Pergunta do sistema', MB_YESNO + MB_ICONQUESTION) = IDYES then
  begin
    CDSGrid.DisableControls;
    CDSGrid.First;
    ListaExtrato := TObjectList<TExtratoContaBancoVO>.Create(True);
    while not CDSGrid.Eof do
    begin
      {TODO -oT2Ti -cConciliação Bancária : Essa é a forma mais indicada para testar se o lançamento é do tipo 'cheque'? Por que?}
      if Copy(CDSGrid.FieldByName('HISTORICO').AsString,1,6) = 'Cheque' then
      begin
        ExtratoContaBanco := TExtratoContaBancoVO.Create;
        ExtratoContaBanco.DataMovimento := CDSGrid.FieldByName('DATA_MOVIMENTO').AsDateTime;
        ExtratoContaBanco.GedDocumento := CDSGrid.FieldByName('GED_DOCUMENTO').AsString;
        ListaExtrato.Add(ExtratoContaBanco);

        {TODO -oT2Ti -cConciliação Bancária : Qual é o problema de já marcar o item como conciliado nessa ocasião?}
        {TODO -oT2Ti -cConciliação Bancária : Como informar ao banco de dados que esse item está conciliado?}
        CDSGrid.Edit;
        CDSGrid.FieldByName('CONCILIADO').AsString := 'S';
        CDSGrid.Post;
      end;
      CDSGrid.Next;
    end;
    //TExtratoContaBancoController.ConciliarCheques(ListaExtrato, 'CHEQUE');
    CDSGrid.First;
    CDSGrid.EnableControls;
  end;
  {TODO -oT2Ti -cConciliação Bancária : Seria interessante mostrar numa janela com a relação de cheques compensados ou não para o usuário? Por que?}
end;



procedure TFExtratoContaBanco.ActionImportarArquivoExecute(Sender: TObject);
var
  YMOFXReader1: TYMOFXReader;
  YMOFCReader1: TYMOFCReader;
  i: integer;
  ExtratoContaBanco: TExtratoContaBancoVO;
  ListaExtrato: TObjectList<TExtratoContaBancoVO>;
  TipoArquivo : String;
begin
  Creditos := 0;
  Debitos := 0;
  Saldo := 0;

  FDataModule.OpenDialog.Filter := 'OFX|*.ofx|OFC|*.ofc';

  if FDataModule.OpenDialog.Execute then
  begin

    TipoArquivo := ExtractFileExt(FDataModule.OpenDialog.FileName);
    ListaExtrato := TObjectList<TExtratoContaBancoVO>.Create(True);

    // Verifica se o arquivo e ofx ou ofc
    if TipoArquivo = '.ofx' then
    begin
    //abre o arquivo
    YMOFXReader1:= TYMOFXReader.create(self);
    YMOFXReader1.OFXFile := FDataModule.OpenDialog.FileName;
    YMOFXReader1.Process;
   //processa a leitura do arquivo
    for i := 0 to YMOFXReader1.Count-1 do
    begin

      CDSGrid.Append;
      CDSGrid.FieldByName('MES').AsString := Mes;
      CDSGrid.FieldByName('ANO').AsString := Ano;
      CDSGrid.FieldByName('DATA_MOVIMENTO').AsString := DateToStr(YMOFXReader1.Get(i).MovDate);
      CDSGrid.FieldByName('HISTORICO').AsString := YMOFXReader1.Get(i).Desc;
      CDSGrid.FieldByName('GED_DOCUMENTO').AsString := YMOFXReader1.Get(i).Document;
      CDSGrid.FieldByName('VALOR').AsFloat := YMOFXReader1.Get(i).Value;
      CDSGrid.FieldByName('ID_CONTA_CAIXA').AsInteger := IdContaCaixa;
      CDSGrid.Post;


      //armazena os dados no banco de dados
      ExtratoContaBanco := TExtratoContaBancoVO.Create;
      ExtratoContaBanco.Mes           := Mes;
      ExtratoContaBanco.Ano           := Ano;
      //FormatDateTime('yyyy-mm-dd', YMOFXReader1.Get(i).MovDate);
      ExtratoContaBanco.DataMovimento := YMOFXReader1.Get(i).MovDate;
      {TODO -oT2Ti -cConciliação Bancária : Existe alguma TAG OFX para a data do balancete?}
      ExtratoContaBanco.DataBalancete := YMOFXReader1.Get(i).MovDate;
      ExtratoContaBanco.Historico     := YMOFXReader1.Get(i).Desc;
      ExtratoContaBanco.GedDocumento     := YMOFXReader1.Get(i).Document;
      ExtratoContaBanco.Valor         := YMOFXReader1.Get(i).Value;
      {TODO -oT2Ti -cConciliação Bancária : o que receber aqui?}
      ExtratoContaBanco.Observacao    := 'O que receber aqui';
      ExtratoContaBanco.IdContaCaixa  := IdContaCaixa;
      ListaExtrato.Add(ExtratoContaBanco);

      //guarda os valores para apresentar nos labels
      if YMOFXReader1.Get(i).Value > 0 then
        Creditos := Creditos + YMOFXReader1.Get(i).Value
      else
        Debitos := Debitos + YMOFXReader1.Get(i).Value;
    end;
    end
    else
    if TipoArquivo = '.ofc' then
    begin
    //abre o arquivo
    YMOFCReader1:= TYMOFCReader.create(self);
    YMOFCReader1.OFCFile := FDataModule.OpenDialog.FileName;
    YMOFCReader1.Process;
   //processa a leitura do arquivo
    for i := 0 to YMOFCReader1.Count-1 do
    begin

      CDSGrid.Append;
      CDSGrid.FieldByName('MES').AsString := Mes;
      CDSGrid.FieldByName('ANO').AsString := Ano;
      CDSGrid.FieldByName('DATA_MOVIMENTO').AsString := DateToStr(YMOFCReader1.Get(i).MovDate);
      CDSGrid.FieldByName('HISTORICO').AsString := YMOFCReader1.Get(i).Desc;
      CDSGrid.FieldByName('GED_DOCUMENTO').AsString := YMOFCReader1.Get(i).Document;
      CDSGrid.FieldByName('VALOR').AsFloat := YMOFCReader1.Get(i).Value;
      CDSGrid.FieldByName('ID_CONTA_CAIXA').AsInteger := IdContaCaixa;
      CDSGrid.Post;


      //armazena os dados no banco de dados
      ExtratoContaBanco := TExtratoContaBancoVO.Create;
      ExtratoContaBanco.Mes           := Mes;
      ExtratoContaBanco.Ano           := Ano;
      //FormatDateTime('yyyy-mm-dd', YMOFCReader1.Get(i).MovDate);
      ExtratoContaBanco.DataMovimento := YMOFCReader1.Get(i).MovDate;
      {TODO -oT2Ti -cConciliação Bancária : Existe alguma TAG OFC para a data do balancete?}
      ExtratoContaBanco.DataBalancete := YMOFCReader1.Get(i).MovDate;
      ExtratoContaBanco.Historico     := YMOFCReader1.Get(i).Desc;
      ExtratoContaBanco.GedDocumento     := YMOFCReader1.Get(i).Document;
      ExtratoContaBanco.Valor         := YMOFCReader1.Get(i).Value;
      {TODO -oT2Ti -cConciliação Bancária : o que receber aqui?}
      ExtratoContaBanco.Observacao    := 'O que receber aqui';
      ExtratoContaBanco.IdContaCaixa  := IdContaCaixa;

      //por enquanto insere de um por um. tirar e inserir a lista
      TExtratoContaBancoController.Insere(ExtratoContaBanco);

      ListaExtrato.Add(ExtratoContaBanco);
      //guarda os valores para apresentar nos labels
      if YMOFCReader1.Get(i).Value > 0 then
        Creditos := Creditos + YMOFCReader1.Get(i).Value
      else
        Debitos := Debitos + YMOFCReader1.Get(i).Value;
    end;
    end;

  end;
  FDataModule.OpenDialog.Filter := '';
  AtualizarLabelValores;
  // Albert daqui para frente ta tenso
  //TExtratoContaBancoController.Insere(ListaExtrato);

  CDSGrid.EnableControls;
  DecimalSeparator := '.';
end;

procedure TFExtratoContaBanco.PegarValores;
begin
  CDSGrid.DisableControls;
  CDSGrid.First;
  while not CDSGrid.Eof do
  begin
    if CDSGrid.FieldByName('VALOR').AsFloat > 0 then
      Creditos := Creditos + CDSGrid.FieldByName('VALOR').AsFloat
    else
      Debitos := Debitos + CDSGrid.FieldByName('VALOR').AsFloat;
    CDSGrid.Next;
  end;
  CDSGrid.EnableControls;

  AtualizarLabelValores;
end;

procedure TFExtratoContaBanco.AtualizarLabelValores;
begin
  Saldo := Creditos + Debitos;
  LabelCreditos.Caption := FormatFloat('#,###,###,##0.00', Creditos);
  LabelDebitos.Caption := FormatFloat('#,###,###,##0.00', Debitos);
  LabelSaldoExtrato.Caption := FormatFloat('#,###,###,##0.00', Saldo);
end;


procedure TFExtratoContaBanco.FormCreate(Sender: TObject);
begin
  ClasseObjetoGridVO := TExtratoContaBancoVO;
  ObjetoController := TExtratoContaBancoController.Create;
  inherited;

end;


end.
