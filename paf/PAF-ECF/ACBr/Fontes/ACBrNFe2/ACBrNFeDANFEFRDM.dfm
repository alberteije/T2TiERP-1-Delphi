object dmACBrNFeFR: TdmACBrNFeFR
  OldCreateOrder = False
  Height = 341
  Width = 539
  object frxPDFExport: TfrxPDFExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    PrintOptimized = True
    Outline = False
    Background = True
    HTMLTags = True
    Author = 'FastReport'
    Subject = 'Exportando DANFE para PDF'
    ProtectionFlags = [ePrint, eModify, eCopy, eAnnot]
    HideToolbar = False
    HideMenubar = False
    HideWindowUI = False
    FitWindow = False
    CenterWindow = False
    PrintScaling = False
    Left = 48
    Top = 92
  end
  object cdsIdentificacao: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 140
    Top = 36
  end
  object cdsEmitente: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 140
    Top = 92
  end
  object cdsDestinatario: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 140
    Top = 148
  end
  object cdsDadosProdutos: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 140
    Top = 204
  end
  object cdsParametros: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 140
    Top = 260
  end
  object cdsInformacoesAdicionais: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 400
    Top = 260
  end
  object cdsDuplicatas: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 272
    Top = 36
  end
  object cdsCalculoImposto: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 272
    Top = 92
  end
  object cdsTransportador: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 272
    Top = 148
  end
  object cdsVeiculo: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 272
    Top = 204
  end
  object cdsVolumes: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 272
    Top = 260
  end
  object cdsISSQN: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 400
    Top = 36
  end
  object cdsFatura: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 400
    Top = 92
  end
  object cdsLocalRetirada: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 400
    Top = 148
  end
  object cdsLocalEntrega: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 400
    Top = 204
  end
  object frxIdentificacao: TfrxDBDataset
    UserName = 'Identificacao'
    CloseDataSource = False
    OpenDataSource = False
    DataSet = cdsIdentificacao
    BCDToCurrency = False
    Left = 172
    Top = 36
  end
  object frxEmitente: TfrxDBDataset
    UserName = 'Emitente'
    CloseDataSource = False
    OpenDataSource = False
    DataSet = cdsEmitente
    BCDToCurrency = False
    Left = 172
    Top = 92
  end
  object frxDestinatario: TfrxDBDataset
    UserName = 'Destinatario'
    CloseDataSource = False
    OpenDataSource = False
    DataSet = cdsDestinatario
    BCDToCurrency = False
    Left = 172
    Top = 148
  end
  object frxDadosProdutos: TfrxDBDataset
    UserName = 'DadosProdutos'
    CloseDataSource = False
    OpenDataSource = False
    DataSet = cdsDadosProdutos
    BCDToCurrency = False
    Left = 172
    Top = 204
  end
  object frxParametros: TfrxDBDataset
    UserName = 'Parametros'
    CloseDataSource = False
    OpenDataSource = False
    DataSet = cdsParametros
    BCDToCurrency = False
    Left = 172
    Top = 260
  end
  object frxDuplicatas: TfrxDBDataset
    UserName = 'Duplicatas'
    CloseDataSource = False
    OpenDataSource = False
    DataSet = cdsDuplicatas
    BCDToCurrency = False
    Left = 304
    Top = 36
  end
  object frxCalculoImposto: TfrxDBDataset
    UserName = 'CalculoImposto'
    CloseDataSource = False
    OpenDataSource = False
    DataSet = cdsCalculoImposto
    BCDToCurrency = False
    Left = 304
    Top = 92
  end
  object frxTransportador: TfrxDBDataset
    UserName = 'Transportador'
    CloseDataSource = False
    OpenDataSource = False
    DataSet = cdsTransportador
    BCDToCurrency = False
    Left = 304
    Top = 148
  end
  object frxVeiculo: TfrxDBDataset
    UserName = 'Veiculo'
    CloseDataSource = False
    OpenDataSource = False
    DataSet = cdsVeiculo
    BCDToCurrency = False
    Left = 304
    Top = 204
  end
  object frxVolumes: TfrxDBDataset
    UserName = 'Volumes'
    CloseDataSource = False
    OpenDataSource = False
    DataSet = cdsVolumes
    BCDToCurrency = False
    Left = 304
    Top = 260
  end
  object frxISSQN: TfrxDBDataset
    UserName = 'ISSQN'
    CloseDataSource = False
    OpenDataSource = False
    DataSet = cdsISSQN
    BCDToCurrency = False
    Left = 432
    Top = 36
  end
  object frxFatura: TfrxDBDataset
    UserName = 'Fatura'
    CloseDataSource = False
    OpenDataSource = False
    DataSet = cdsFatura
    BCDToCurrency = False
    Left = 432
    Top = 92
  end
  object frxLocalRetirada: TfrxDBDataset
    UserName = 'LocalRetirada'
    CloseDataSource = False
    OpenDataSource = False
    DataSet = cdsLocalRetirada
    BCDToCurrency = False
    Left = 432
    Top = 148
  end
  object frxLocalEntrega: TfrxDBDataset
    UserName = 'LocalEntrega'
    CloseDataSource = False
    OpenDataSource = False
    DataSet = cdsLocalEntrega
    BCDToCurrency = False
    Left = 432
    Top = 204
  end
  object frxInformacoesAdicionais: TfrxDBDataset
    UserName = 'InformacoesAdicionais'
    CloseDataSource = False
    OpenDataSource = False
    DataSet = cdsInformacoesAdicionais
    BCDToCurrency = False
    Left = 432
    Top = 260
  end
  object frxBarCodeObject: TfrxBarCodeObject
    Left = 48
    Top = 148
  end
  object frxReport: TfrxReport
    Version = '4.10.5'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.AllowEdit = False
    PreviewOptions.Buttons = [pbPrint, pbZoom, pbFind, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 40401.475989294000000000
    ReportOptions.LastChange = 40415.404595682900000000
    ScriptLanguage = 'PascalScript'
    StoreInDFM = False
    Left = 48
    Top = 36
  end
end
