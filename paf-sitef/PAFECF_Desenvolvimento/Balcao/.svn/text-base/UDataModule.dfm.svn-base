object FDataModule: TFDataModule
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 552
  Top = 277
  Height = 360
  Width = 260
  object Conexao: TSQLConnection
    ConnectionName = 'IBConnection'
    DriverName = 'MySQL'
    GetDriverFunc = 'getSQLDriverMYSQL'
    KeepConnection = False
    LibraryName = 'dbxmys.dll'
    LoginPrompt = False
    Params.Strings = (
      'Database=mini'
      'HostName=localhost'
      'Password=root'
      'User_Name=root')
    VendorLib = 'libmysql.dll'
    Left = 40
    Top = 16
  end
  object CDSPV: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 144
    Top = 80
  end
  object DSPV: TDataSource
    DataSet = CDSPV
    Left = 144
    Top = 136
  end
  object ACBrNFe: TACBrNFe
    Configuracoes.Geral.PathSalvar = 'C:\Arquivos de programas\Embarcadero\RAD Studio\7.0\bin\'
    Configuracoes.WebServices.UF = 'DF'
    Configuracoes.WebServices.AguardarConsultaRet = 0
    Configuracoes.WebServices.IntervaloTentativas = 0
    Configuracoes.WebServices.AjustaAguardaConsultaRet = False
    DANFE = ACBrNFeDANFERave
    Left = 144
    Top = 264
  end
  object CDSNF: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 40
    Top = 216
  end
  object DSNF: TDataSource
    DataSet = CDSNF
    Left = 40
    Top = 272
  end
  object ACBrNFeDANFERave: TACBrNFeDANFERave
    ACBrNFe = ACBrNFe
    PathPDF = 'C:\Arquivos de programas\Embarcadero\RAD Studio\7.0\bin\'
    MostrarPreview = True
    MostrarStatus = True
    TipoDANFE = tiRetrato
    NumCopias = 1
    ImprimirDescPorc = True
    ImprimirTotalLiquido = True
    MargemInferior = 0.800000000000000000
    MargemSuperior = 0.800000000000000000
    MargemEsquerda = 0.600000000000000000
    MargemDireita = 0.510000000000000000
    CasasDecimais._qCom = 2
    CasasDecimais._vUnCom = 2
    ExibirResumoCanhoto = False
    FormularioContinuo = False
    TamanhoFonte_DemaisCampos = 10
    ProdutosPorPagina = 0
    ImprimirDetalhamentoEspecifico = True
    NFeCancelada = False
    RavFile = 
      'C:\ERP\Modulos\PAF-ECF-TEF\Desenvolvimento\Fontes\Balcao\NotaFis' +
      'calEletronica.rav'
    EspessuraBorda = 1
    TamanhoFonte_RazaoSocial = 12
    TamanhoFonte_ANTT = 10
    Left = 144
    Top = 208
  end
  object CDSDAV: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 40
    Top = 80
  end
  object DSDAV: TDataSource
    DataSet = CDSDAV
    Left = 32
    Top = 136
  end
end
