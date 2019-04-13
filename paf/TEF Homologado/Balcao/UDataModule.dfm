object FDataModule: TFDataModule
  OldCreateOrder = False
  Left = 313
  Top = 155
  Height = 253
  Width = 247
  object Conexao: TSQLConnection
    DriverName = 'MySQL'
    GetDriverFunc = 'getSQLDriverMYSQL'
    LibraryName = 'dbxmys.dll'
    LoginPrompt = False
    Params.Strings = (
      'User_Name=root'
      'Password=root'
      'HostName=localhost'
      'Database=t2tipafecf')
    VendorLib = 'libmysql.dll'
    Connected = True
    Left = 40
    Top = 16
  end
  object CDSDAV: TClientDataSet
    Aggregates = <>
    Params = <>
    BeforePost = CDSDAVBeforePost
    Left = 40
    Top = 80
  end
  object DSDAV: TDataSource
    DataSet = CDSDAV
    Left = 40
    Top = 136
  end
  object CDSPV: TClientDataSet
    Aggregates = <>
    Params = <>
    BeforePost = CDSPVBeforePost
    Left = 144
    Top = 80
  end
  object DSPV: TDataSource
    DataSet = CDSPV
    Left = 144
    Top = 136
  end
end
