unit UDataModule;

interface

uses
  windows,SysUtils, Classes, DB, DBClient, Provider, ImgList, Controls, JvDataSource,
  JvDBGridExport, JvComponentBase, Dialogs, JvPageList, DBXFirebird, DBXMySql,
  WideStrings, SqlExpr, Inifiles, SWSystem, Forms, ACBrBoleto, ACBrBase,
  RLConsts, Tipos, Graphics, ACBrNFe, ACBrBoletoFCFortesFr, ACBrNFeDANFEClass,
  ACBrNFeDANFERave;

type
  TFDataModule = class(TDataModule)
    CDSBanco: TClientDataSet;
    DSBanco: TDataSource;
    ImagensCadastros: TImageList;
    ImagensCadastrosD: TImageList;
    ExportarWord: TJvDBGridWordExport;
    ExportarExcel: TJvDBGridExcelExport;
    ExportarHTML: TJvDBGridHTMLExport;
    ExportarCSV: TJvDBGridCSVExport;
    ExportarXML: TJvDBGridXMLExport;
    SaveDialog: TSaveDialog;
    OpenDialog: TOpenDialog;
    CDSLookup: TClientDataSet;
    DSLookup: TDataSource;
    CDSCep: TClientDataSet;
    DSCep: TDataSource;
    Conexao: TSQLConnection;
    CDSTipoEndereco: TClientDataSet;
    DSTipoEndereco: TDataSource;
    CDSAgencia: TClientDataSet;
    DSAgencia: TDataSource;
    CDSContaCaixa: TClientDataSet;
    DSContaCaixa: TDataSource;
    CDSCfop: TClientDataSet;
    DSCfop: TDataSource;
    CDSTalonarioCheque: TClientDataSet;
    DSTalonarioCheque: TDataSource;
    CDSCheque: TClientDataSet;
    DSCheque: TDataSource;
    CDSSituacaoPessoa: TClientDataSet;
    DSSituacaoPessoa: TDataSource;
    CDSSetor: TClientDataSet;
    DSSetor: TDataSource;
    CDSCargo: TClientDataSet;
    DSCargo: TDataSource;
    CDSTipoDocumento: TClientDataSet;
    DSTipoDocumento: TDataSource;
    CDSMeiosPagamento: TClientDataSet;
    DSMeiosPagamento: TDataSource;
    CDSPlanoContas: TClientDataSet;
    DSPlanoContas: TDataSource;
    CDSUnidadeProduto: TClientDataSet;
    DSUnidadeProduto: TDataSource;
    CDSPessoa: TClientDataSet;
    DSPessoa: TDataSource;
    CDSPessoaEndereco: TClientDataSet;
    DSPessoaEndereco: TDataSource;
    CDSLancamentoReceber: TClientDataSet;
    DSLancamentoReceber: TDataSource;
    CDSParcelaReceber: TClientDataSet;
    DSParcelaReceber: TDataSource;
    CDSEmpresa: TClientDataSet;
    DSEmpresa: TDataSource;
    ACBrBoleto: TACBrBoleto;
    CDSParcelaRecebimento: TClientDataSet;
    DSParcelaRecebimento: TDataSource;
    CDSLancamentoPagar: TClientDataSet;
    DSLancamentoPagar: TDataSource;
    CDSParcelaPagar: TClientDataSet;
    DSParcelaPagar: TDataSource;
    CDSParcelaPagamento: TClientDataSet;
    DSParcelaPagamento: TDataSource;
    CDSMovimentoCaixaBanco: TClientDataSet;
    DSMovimentoCaixaBanco: TDataSource;
    CDSPedidoCompra: TClientDataSet;
    DSPedidoCompra: TDataSource;
    CDSPedidoCompraDetalhe: TClientDataSet;
    DSPedidoCompraDetalhe: TDataSource;
    CDSProduto: TClientDataSet;
    DSProduto: TDataSource;
    CDSImpostoIcms: TClientDataSet;
    DSImpostoIcms: TDataSource;
    CDSUsuario: TClientDataSet;
    DSUsuario: TDataSource;
    CDSNFe: TClientDataSet;
    DSNFe: TDataSource;
    CDSNFeItens: TClientDataSet;
    DSNFeItens: TDataSource;
    ACBrNFe: TACBrNFe;
    CDSContador: TClientDataSet;
    DSContador: TDataSource;
    CDSTurno: TClientDataSet;
    DSTurno: TDataSource;
    CDSFuncionario: TClientDataSet;
    DSFuncionario: TDataSource;
    CDSFicha: TClientDataSet;
    DSFicha: TDataSource;
    CDSPromocao: TClientDataSet;
    DSPromocao: TDataSource;
    CDSResolucao: TClientDataSet;
    DSResolucao: TDataSource;
    CDSImpressora: TClientDataSet;
    DSImpressora: TDataSource;
    CDSConfiguracao: TClientDataSet;
    DSConfiguracao: TDataSource;
    CDSComponentes: TClientDataSet;
    DSComponentes: TDataSource;
    CDSNFeConfiguracao: TClientDataSet;
    DSNFeConfiguracao: TDataSource;
    ACBrNFeDANFERave: TACBrNFeDANFERave;
    CDSNcm: TClientDataSet;
    DSNcm: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
    procedure CDSPessoaEnderecoAfterEdit(DataSet: TDataSet);
    procedure CDSPessoaEnderecoAfterInsert(DataSet: TDataSet);
    procedure CDSParcelaReceberAfterEdit(DataSet: TDataSet);
    procedure CDSParcelaRecebimentoAfterScroll(DataSet: TDataSet);
    procedure CDSParcelaPagarAfterEdit(DataSet: TDataSet);
    procedure CDSParcelaPagamentoAfterScroll(DataSet: TDataSet);
    procedure CopiaCargaParaPDVs;
  private
    { Private declarations }
  public
    RemoteAppPath, PathExporta :string;
    EmpresaID, QuantidadeECF:integer;
    function Imagem(pTipo: TImagem; pStatus: TStatusImagem;
       pTamanho: TTamanhoImagem): TBitmap;
  end;

var
  FDataModule: TFDataModule;

implementation

uses UMenu, ConexaoBD, UParcelaRecebimento, UParcelaPagamento, UConfigConexao;

{$R *.dfm}

procedure TFDataModule.DataModuleCreate(Sender: TObject);
var ini: TIniFile;
    Banco: String;
begin
  try

    ini := TIniFile.Create(ExtractFilePath(Application.ExeName)+'Conexao.ini');
    Banco := UpperCase(ini.ReadString('SGBD','BDBalcao',''));
    RemoteAppPath := UpperCase(ini.ReadString('IMPORTA','REMOTEAPP',''));
    EmpresaID := StrToIntDef(ini.ReadString('ECFS','EMPRESA',''),1);
    QuantidadeECF := StrToIntDef(ini.ReadString('ECFS','QUANTIDADE',''),1);

    PathExporta := (ExtractFilePath(Application.ExeName)+'Script\carga.txt');

    try
      if Banco = 'MYSQL'then
        TDBExpress.Conectar('MySQL')
      else if Banco = 'FIREBIRD'then
        TDBExpress.Conectar('Firebird');
    except
       Application.CreateForm(TFConfigConexao,FConfigConexao);
       if FConfigConexao.ShowModal <> mrOK then
         Application.Terminate
       else
       begin
        FreeAndNil(FConfigConexao);
        FDataModule.Conexao.Close;
        if Banco = 'MYSQL'then
          TDBExpress.Conectar('MySQL')
        else if Banco = 'FIREBIRD'then
          TDBExpress.Conectar('Firebird');
       end;
    end;

  finally
    ini.Free;
  end;

end;

function TFDataModule.Imagem(pTipo: TImagem; pStatus: TStatusImagem;
  pTamanho: TTamanhoImagem): TBitmap;
var
  ImageList: TImageList;
begin
  Result := TBitmap.Create;

  //Captura Instância do ImageList a ser utilizado
  if pStatus = siDesabilitada then
    ImageList := ImagensCadastrosD
  else
    ImageList := ImagensCadastros;

  case pTamanho of
    ti16:
      case pTipo of
        iIncluir: ImageList.GetBitmap(0,Result);
        iAlterar: ImageList.GetBitmap(1,Result);
        iExcluir: ImageList.GetBitmap(2,Result);
        iConsultar: ImageList.GetBitmap(3,Result);
        iImprimir: ImageList.GetBitmap(4,Result);
        iSalvar: ImageList.GetBitmap(9,Result);
        iCancelar: ImageList.GetBitmap(10,Result);
        iLocalizar: ImageList.GetBitmap(11,Result);
        iSair: ImageList.GetBitmap(12,Result);
        iExportar: ImageList.GetBitmap(13,Result);
        iExcel: ImageList.GetBitmap(14,Result);
        iHTML: ImageList.GetBitmap(15,Result);
        iCSV: ImageList.GetBitmap(16,Result);
        iWord: ImageList.GetBitmap(17,Result);
        iXML: ImageList.GetBitmap(18,Result);
        iAnterior: ImageList.GetBitmap(19,Result);
        iPrimeiro: ImageList.GetBitmap(20,Result);
        iUltimo: ImageList.GetBitmap(21,Result);
        iProximo: ImageList.GetBitmap(22,Result);
        iProximaPagina: ImageList.GetBitmap(23,Result);
        iPaginaAnterior: ImageList.GetBitmap(24,Result);
      end;
  end;
end;

procedure TFDataModule.CDSPessoaEnderecoAfterInsert(DataSet: TDataSet);
begin
  CDSPessoaEndereco.FieldByName('PERSISTE').AsString := 'S';
end;

procedure TFDataModule.CopiaCargaParaPDVs;
var
   LocalAppPath :string;
   i : integer;
begin
  LocalAppPath :=  ExtractFilePath(Application.ExeName)+'Script\Carga.txt';
  if not (DirectoryExists(RemoteAppPath)) then
  begin
   ShowMessage(' Configure corretamente o diretorio de exportação no Conexao.ini');
  end;


  for i := 1 to QuantidadeECF do
  begin
    ForceDirectories(RemoteAppPath+'Caixa'+IntToStr(i));
    if CopyFile(PChar(LocalAppPath), PChar(RemoteAppPath+'Caixa'+IntToStr(i)+'\Carga.txt'),false) then
       Application.ProcessMessages;
  end;

end;

procedure TFDataModule.CDSPessoaEnderecoAfterEdit(DataSet: TDataSet);
begin
  CDSPessoaEndereco.FieldByName('PERSISTE').AsString := 'S';
end;

procedure TFDataModule.CDSParcelaReceberAfterEdit(DataSet: TDataSet);
begin
  CDSParcelaReceber.FieldByName('PERSISTE').AsString := 'S';
end;

procedure TFDataModule.CDSParcelaRecebimentoAfterScroll(DataSet: TDataSet);
var
  FormAtual: TForm;
begin
  FormAtual := FMenu.FormAtual;
  (FormAtual as TFParcelaRecebimento).GridParaEdits;
end;

procedure TFDataModule.CDSParcelaPagarAfterEdit(DataSet: TDataSet);
begin
  CDSParcelaPagar.FieldByName('PERSISTE').AsString := 'S';
end;

procedure TFDataModule.CDSParcelaPagamentoAfterScroll(DataSet: TDataSet);
var
  FormAtual: TForm;
begin
  FormAtual := FMenu.FormAtual;
  (FormAtual as TFParcelaPagamento).GridParaEdits;
end;


initialization
  RLConsts.SetVersion(3,71,'B');

end.
