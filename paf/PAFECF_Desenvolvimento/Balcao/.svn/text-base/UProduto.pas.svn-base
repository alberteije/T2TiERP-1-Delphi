
unit UProduto;

interface

uses
  SysUtils, Types, Windows, Classes, Forms, ACBrBase,StdCtrls,
  Controls, ComCtrls, ExtCtrls, ACBrEnterTab, Mask, Graphics, Generics.Collections,
  JvExStdCtrls, Dialogs, JvEdit, JvValidateEdit, Buttons,
  JvButton, JvCtrls, JvExButtons, JvBitBtn, ACBrValidador, JvExMask,
  JvToolEdit, JvExControls, JvLabel, JvGradient, COMObj, Grids, DBGrids,
  JvExDBGrids, JvDBGrid, JvDBUltimGrid, DB, Messages, pngimage, FMTBcd, SqlExpr,
  DBCtrls, DBClient, Provider;

type
  TFProduto = class(TForm)
    ACBrEnterTab1: TACBrEnterTab;
    ACBrValidador1: TACBrValidador;
    PanelBotoes: TPanel;
    GroupBox6: TGroupBox;
    GridItens: TJvDBUltimGrid;
    lblTitulo: TLabel;
    Image1: TImage;
    QProduto: TSQLQuery;
    DSPProduto: TDataSetProvider;
    CDSProduto: TClientDataSet;
    DSProduto: TDataSource;
    DBNavigator1: TDBNavigator;
    ScrollBox1: TScrollBox;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    Label4: TLabel;
    Label5: TLabel;
    DBEdit4: TDBEdit;
    Label6: TLabel;
    DBEdit5: TDBEdit;
    Label7: TLabel;
    DBEdit6: TDBEdit;
    Label9: TLabel;
    DBEdit8: TDBEdit;
    Label10: TLabel;
    DBEdit9: TDBEdit;
    Label13: TLabel;
    DBEdit12: TDBEdit;
    Label14: TLabel;
    DBEdit13: TDBEdit;
    Label16: TLabel;
    DBEdit15: TDBEdit;
    Label17: TLabel;
    DBEdit16: TDBEdit;
    Label18: TLabel;
    DBEdit17: TDBEdit;
    Label19: TLabel;
    DBEdit18: TDBEdit;
    Label20: TLabel;
    DBEdit19: TDBEdit;
    Label21: TLabel;
    DBEdit20: TDBEdit;
    Label22: TLabel;
    DBEdit21: TDBEdit;
    Label23: TLabel;
    DBEdit22: TDBEdit;
    Label24: TLabel;
    DBEdit23: TDBEdit;
    DBEdit25: TDBEdit;
    Panel1: TPanel;
    DBRadioGroup1: TDBRadioGroup;
    DBRadioGroup2: TDBRadioGroup;
    DBLookupComboBox4: TDBLookupComboBox;
    Label8: TLabel;
    DSUnidade: TDataSource;
    CDSUnidade: TClientDataSet;
    DSPUnidade: TDataSetProvider;
    QUnidade: TSQLQuery;
    DBRadioGroup3: TDBRadioGroup;
    DBEdit7: TDBEdit;
    Label11: TLabel;
    CDSProdutoID: TIntegerField;
    CDSProdutoID_UNIDADE_PRODUTO: TIntegerField;
    CDSProdutoGTIN: TStringField;
    CDSProdutoCODIGO_INTERNO: TStringField;
    CDSProdutoNOME: TStringField;
    CDSProdutoDESCRICAO_PDV: TStringField;
    CDSProdutoVALOR_VENDA: TFMTBCDField;
    CDSProdutoQTD_ESTOQUE: TFMTBCDField;
    CDSProdutoQTD_ESTOQUE_ANTERIOR: TFMTBCDField;
    CDSProdutoESTOQUE_MIN: TFMTBCDField;
    CDSProdutoESTOQUE_MAX: TFMTBCDField;
    CDSProdutoIAT: TStringField;
    CDSProdutoIPPT: TStringField;
    CDSProdutoNCM: TStringField;
    CDSProdutoTIPO_ITEM_SPED: TStringField;
    CDSProdutoDATA_ESTOQUE: TDateField;
    CDSProdutoCST: TStringField;
    CDSProdutoECF_ICMS_ST: TStringField;
    CDSProdutoCODIGO_BALANCA: TIntegerField;
    CDSProdutoTOTALIZADOR_PARCIAL: TStringField;
    CDSProdutoTAXA_ICMS: TFMTBCDField;
    CDSProdutoTAXA_IPI: TFMTBCDField;
    CDSProdutoTAXA_ISSQN: TFMTBCDField;
    CDSProdutoTAXA_PIS: TFMTBCDField;
    CDSProdutoTAXA_COFINS: TFMTBCDField;
    CDSProdutoPAF_P_ST: TStringField;
    CDSProdutoDESCRICAO: TStringField;
    CDSProdutoCSOSN: TStringField;
    QProdutoID: TIntegerField;
    QProdutoID_UNIDADE_PRODUTO: TIntegerField;
    QProdutoGTIN: TStringField;
    QProdutoCODIGO_INTERNO: TStringField;
    QProdutoNOME: TStringField;
    QProdutoDESCRICAO: TStringField;
    QProdutoDESCRICAO_PDV: TStringField;
    QProdutoVALOR_VENDA: TFMTBCDField;
    QProdutoQTD_ESTOQUE: TFMTBCDField;
    QProdutoQTD_ESTOQUE_ANTERIOR: TFMTBCDField;
    QProdutoESTOQUE_MIN: TFMTBCDField;
    QProdutoESTOQUE_MAX: TFMTBCDField;
    QProdutoIAT: TStringField;
    QProdutoIPPT: TStringField;
    QProdutoNCM: TStringField;
    QProdutoTIPO_ITEM_SPED: TStringField;
    QProdutoDATA_ESTOQUE: TDateField;
    QProdutoTAXA_IPI: TFMTBCDField;
    QProdutoTAXA_ISSQN: TFMTBCDField;
    QProdutoTAXA_PIS: TFMTBCDField;
    QProdutoTAXA_COFINS: TFMTBCDField;
    QProdutoTAXA_ICMS: TFMTBCDField;
    QProdutoCST: TStringField;
    QProdutoCSOSN: TStringField;
    QProdutoTOTALIZADOR_PARCIAL: TStringField;
    QProdutoECF_ICMS_ST: TStringField;
    QProdutoCODIGO_BALANCA: TIntegerField;
    QProdutoPAF_P_ST: TStringField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure DBNavigator1Click(Sender: TObject; Button: TNavigateBtn);
    procedure ExportaProduto;
    procedure CDSProdutoBeforePost(DataSet: TDataSet);

  private
    { Private declarations }
    PathExporta :string;
  public
  end;

var
  FProduto: TFProduto;

implementation

uses UDataModule, Biblioteca;

{$R *.dfm}

procedure TFProduto.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Application.MessageBox('Deseja Realmente Fechar a Tela de Cadastro de Produtos?', 'Sair do Sistema', MB_YesNo + MB_IconQuestion) <> IdYes then
    Action := caNone
  else
   begin
    Action := caFree;
    FProduto := Nil;
   end;
end;

procedure TFProduto.FormCreate(Sender: TObject);
begin
  CDSUnidade.Active := True;
  CDSProduto.Active := True;
end;

procedure TFProduto.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key = 27 then
    Close;
end;

procedure TFProduto.CDSProdutoBeforePost(DataSet: TDataSet);
begin
  CDSProdutoDATA_ESTOQUE.AsDateTime := now;
end;

procedure TFProduto.DBNavigator1Click(Sender: TObject; Button: TNavigateBtn);
begin
  case Button of
    nbInsert:
    begin
      DBEdit1.SetFocus;
      CDSProduto.Append;
      CDSProdutoGTIN.AsString :=  ColocaZerosEsquerda(inttostr(CDSProduto.RecordCount + 1), 13);   //0001180000002
      CDSProdutoCODIGO_INTERNO.AsString :=  ColocaZerosEsquerda(inttostr(CDSProduto.RecordCount + 1), 5);   //0001180000002
      CDSProdutoVALOR_VENDA.AsFloat := 0;
      CDSProdutoQTD_ESTOQUE.AsFloat := 10;
      CDSProdutoQTD_ESTOQUE_ANTERIOR.AsFloat := 0;
      CDSProdutoESTOQUE_MIN.AsFloat := 1;
      CDSProdutoESTOQUE_MAX.AsFloat := 100;
      CDSProdutoIAT.AsString := 'T';
      CDSProdutoIPPT.AsString := 'T';
      CDSProdutoNCM.AsString := '40129010';
      CDSProdutoTIPO_ITEM_SPED.AsString := '04';
      CDSProdutoDATA_ESTOQUE.AsDateTime := NOW;
      CDSProdutoCST.AsString := '000';
      CDSProdutoECF_ICMS_ST.AsString := '17';
      CDSProdutoTOTALIZADOR_PARCIAL.AsString := '05T1700';
      CDSProdutoCSOSN.AsString := '1900';
      CDSProdutoPAF_P_ST.AsString := 'T';
      CDSProdutoTAXA_COFINS.AsFloat := 0;
      CDSProdutoTAXA_ICMS.AsFloat := 17;
      CDSProdutoTAXA_PIS.AsFloat := 0;
      CDSProdutoTAXA_IPI.AsFloat := 0;
      CDSProdutoTAXA_ISSQN.AsFloat := 0;
      CDSProdutoTAXA_COFINS.AsFloat := 0;
      CDSProdutoTOTALIZADOR_PARCIAL.AsString := '05T1700';
    end;
    nbPost:
    begin
      CDSProduto.ApplyUpdates(0);
      ExportaProduto;
    end;
    nbDelete:
    begin
      CDSProduto.ApplyUpdates(0);
    end;
    {nbprior = move o ponteiro para o registro anterior;
    nbnext = move o ponteiro para o proximo registro;
    nblast = vai para o último registro;
    nbinsert = insere um novo registro na tabela;
    delete = apaga o registro atual;
    edit = edita o registro atual;
    cancel = cancela a operação (edit, insert);
    refresh = re-le a tabela de registros;}
  end;
end;

procedure TFProduto.ExportaProduto;
var
  ExportaPDV: TextFile;
  Tripa: String;
begin
  try
    try
      DecimalSeparator := '.';
      ForceDirectories(ExtractFilePath(Application.ExeName)+'Script');
      PathExporta :=  ExtractFilePath(Application.ExeName)+'Script\Carga.txt';

      if FileExists(PathExporta) then
      begin
        DeleteFile(pchar(PathExporta));
        Application.ProcessMessages;
      end;

      AssignFile(ExportaPDV,PathExporta);
      CDSProduto.Active := False;
      CDSProduto.Active := True;
      CDSProduto.First;
      CDSProduto.DisableControls;

      Application.ProcessMessages;
      while not CDSProduto.Eof do
      begin
        if FileExists(PathExporta) then
          Append(ExportaPDV)
        else
          Rewrite(ExportaPDV);

        Tripa :=  CDSProduto.FieldByName('GTIN').AsString +
                  CDSProduto.FieldByName('DESCRICAO').AsString +
                  CDSProduto.FieldByName('DESCRICAO_PDV').AsString +
                  FormataFloat('Q',CDSProduto.FieldByName('QTD_ESTOQUE_ANTERIOR').AsFloat) +
                  CDSProduto.FieldByName('DATA_ESTOQUE').AsString +
                  CDSProduto.FieldByName('CST').AsString +
                  FormataFloat('V',CDSProduto.FieldByName('TAXA_ICMS').AsFloat) +
                  FormataFloat('V',CDSProduto.FieldByName('VALOR_VENDA').AsFloat) + '0';

        Write(ExportaPDV,'PRODUTO|'+

        VerificaNULL(CDSProduto.FieldByName('ID').AsString,0)+'|'+                        //  INTEGER NOT NULL,
        VerificaNULL(CDSProduto.FieldByName('ID_UNIDADE_PRODUTO').AsString,0)+'|'+        //  INTEGER NOT NULL,
        VerificaNULL(CDSProduto.FieldByName('GTIN').AsString,2)+'|'+                      //  VARCHAR(14),
        VerificaNULL(CDSProduto.FieldByName('CODIGO_INTERNO').AsString,2)+'|'+            //  VARCHAR(20),
        VerificaNULL(CDSProduto.FieldByName('NOME').AsString,2)+'|'+                      //  VARCHAR(100),
        VerificaNULL(CDSProduto.FieldByName('DESCRICAO').AsString,2)+'|'+                 //  VARCHAR(250),
        VerificaNULL(CDSProduto.FieldByName('DESCRICAO_PDV').AsString,2)+'|'+             //  VARCHAR(30),
        VerificaNULL(CDSProduto.FieldByName('VALOR_VENDA').AsString,0)+'|'+               //  DECIMAL(18,6),
        VerificaNULL(CDSProduto.FieldByName('QTD_ESTOQUE').AsString,0)+'|'+               //  DECIMAL(18,6),
        VerificaNULL(CDSProduto.FieldByName('QTD_ESTOQUE_ANTERIOR').AsString,0)+'|'+      //  DECIMAL(18,6),
        VerificaNULL(CDSProduto.FieldByName('ESTOQUE_MIN').AsString,0)+'|'+               //  DECIMAL(18,6),
        VerificaNULL(CDSProduto.FieldByName('ESTOQUE_MAX').AsString,0)+'|'+               //  DECIMAL(18,6),
        VerificaNULL(CDSProduto.FieldByName('IAT').AsString,2)+'|'+                       //  CHAR(1),
        VerificaNULL(CDSProduto.FieldByName('IPPT').AsString,2)+'|'+                      //  CHAR(1),
        VerificaNULL(CDSProduto.FieldByName('NCM').AsString,2)+'|'+                       //  VARCHAR(8),
        VerificaNULL(CDSProduto.FieldByName('TIPO_ITEM_SPED').AsString,2)+'|'+            //  CHAR(2),
        DataParaTexto(CDSProduto.FieldByName('DATA_ESTOQUE').AsDateTime)+'|'+             //  DATE,
        VerificaNULL(CDSProduto.FieldByName('TAXA_IPI').AsString,0)+'|'+                  //  DECIMAL(18,6),
        VerificaNULL(CDSProduto.FieldByName('TAXA_ISSQN').AsString,0)+'|'+                //  DECIMAL(18,6),
        VerificaNULL(CDSProduto.FieldByName('TAXA_PIS').AsString,0)+'|'+                  //  DECIMAL(18,6),
        VerificaNULL(CDSProduto.FieldByName('TAXA_COFINS').AsString,0)+'|'+               //  DECIMAL(18,6),
        VerificaNULL(CDSProduto.FieldByName('TAXA_ICMS').AsString,0)+'|'+                 //  DECIMAL(18,6),
        VerificaNULL(CDSProduto.FieldByName('CST').AsString,2)+'|'+                       //  CHAR(3),
        VerificaNULL(CDSProduto.FieldByName('CSOSN').AsString,2)+'|'+                     //  CHAR(4),
        VerificaNULL(CDSProduto.FieldByName('TOTALIZADOR_PARCIAL').AsString,2)+'|'+       //  VARCHAR(10),
        VerificaNULL(CDSProduto.FieldByName('ECF_ICMS_ST').AsString,2)+'|'+               //  VARCHAR(4),
        VerificaNULL(CDSProduto.FieldByName('CODIGO_BALANCA').AsString,0)+'|'+            //  INTEGER,
        VerificaNULL(CDSProduto.FieldByName('PAF_P_ST').AsString,2)+'|'+                  //  CHAR(1),
        VerificaNULL(MD5String(Tripa), 2)+'|'+                                            //  VARCHAR(32),
        '0|');                                                                            //  INTEGER

        Writeln(ExportaPDV);
        CDSProduto.Next;
        Application.ProcessMessages;

      end;

      CDSProduto.First;
      CDSProduto.EnableControls;

    except
      Application.MessageBox('Não foi possivel exportar os produtos para o PDV.', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
    end;
  finally
    CloseFile(ExportaPDV);
    DecimalSeparator := ',';
    CDSProduto.EnableConstraints;
    CDSProduto.Refresh;
    try
     FDataModule.CopiaCargaParaPDVs;
    except
     ShowMessage('Falha na exportação dos arquivos');
    end;

  end;

end;


end.
