object FDadosPadroes: TFDadosPadroes
  Left = 93
  Top = 189
  BorderStyle = bsSingle
  Caption = 'Dados Padr'#245'es'
  ClientHeight = 506
  ClientWidth = 836
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 836
    Height = 105
    Align = alTop
    TabOrder = 0
    DesignSize = (
      836
      105)
    object GroupBox1: TGroupBox
      Left = 8
      Top = 10
      Width = 809
      Height = 82
      Anchors = [akLeft, akTop, akRight]
      Caption = 'Conex'#227'o:'
      TabOrder = 0
      DesignSize = (
        809
        82)
      object Label1: TLabel
        Left = 223
        Top = 24
        Width = 26
        Height = 13
        Caption = 'Host:'
      end
      object Label3: TLabel
        Left = 423
        Top = 23
        Width = 40
        Height = 13
        Caption = 'Usu'#225'rio:'
      end
      object Label4: TLabel
        Left = 606
        Top = 24
        Width = 34
        Height = 13
        Caption = 'Senha:'
      end
      object Label5: TLabel
        Left = 11
        Top = 24
        Width = 30
        Height = 13
        Caption = 'SGBD:'
      end
      object Label7: TLabel
        Left = 11
        Top = 52
        Width = 81
        Height = 13
        Caption = 'Banco de Dados:'
      end
      object editHost: TEdit
        Left = 253
        Top = 20
        Width = 164
        Height = 21
        TabOrder = 1
        Text = 'localhost'
      end
      object editSenha: TEdit
        Left = 643
        Top = 20
        Width = 151
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        PasswordChar = '*'
        TabOrder = 3
        Text = 'root'
      end
      object editUsuario: TEdit
        Left = 469
        Top = 20
        Width = 131
        Height = 21
        TabOrder = 2
        Text = 'root'
      end
      object comboConexao: TComboBox
        Left = 44
        Top = 20
        Width = 173
        Height = 21
        ItemIndex = 0
        TabOrder = 0
        Text = 'MySQL'
        Items.Strings = (
          'MySQL'
          'MSSQL'
          'FIREBIRD'
          'INTERBASE'
          'Oracle')
      end
      object botaoConectar: TBitBtn
        Left = 711
        Top = 49
        Width = 83
        Height = 21
        Anchors = [akTop, akRight]
        Caption = 'Conectar'
        DoubleBuffered = True
        ParentDoubleBuffered = False
        TabOrder = 4
        OnClick = botaoConectarClick
      end
    end
    object editBancoDados: TJvFilenameEdit
      Left = 106
      Top = 59
      Width = 607
      Height = 21
      AddQuotes = False
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 1
      Text = 't2tierp'
    end
  end
  object Panel2: TPanel
    Left = 217
    Top = 105
    Width = 144
    Height = 382
    Align = alLeft
    TabOrder = 1
    object botaoSair: TButton
      Left = 9
      Top = 480
      Width = 100
      Height = 23
      Caption = 'Sair'
      TabOrder = 0
      OnClick = botaoSairClick
    end
    object botaoLimparMemo: TButton
      Left = 9
      Top = 472
      Width = 100
      Height = 23
      Caption = 'Limpar Memo'
      TabOrder = 1
    end
    object Button1: TButton
      Left = 5
      Top = 10
      Width = 133
      Height = 25
      Caption = 'Adicionar Campo 1'
      TabOrder = 2
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 5
      Top = 41
      Width = 133
      Height = 25
      Caption = 'Adicionar Campo 2'
      TabOrder = 3
      OnClick = Button2Click
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 105
    Width = 217
    Height = 382
    Align = alLeft
    TabOrder = 2
    object Splitter1: TSplitter
      Left = 1
      Top = 169
      Width = 159
      Height = 3
      Align = alNone
    end
    object Splitter2: TSplitter
      Left = 1
      Top = 257
      Width = 215
      Height = 3
      Cursor = crVSplit
      Align = alTop
      ExplicitTop = 172
      ExplicitWidth = 156
    end
    object listaCampo: TListBox
      Left = 1
      Top = 260
      Width = 215
      Height = 121
      Hint = 'Right Click Mouse'
      Align = alClient
      ItemHeight = 13
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
    end
    object listaTabelas: TListBox
      Left = 1
      Top = 42
      Width = 215
      Height = 215
      Align = alTop
      ItemHeight = 13
      TabOrder = 1
      OnClick = listaTabelasClick
    end
    object Panel4: TPanel
      Left = 1
      Top = 1
      Width = 215
      Height = 41
      Align = alTop
      TabOrder = 2
      object EditBusca: TLabeledEdit
        Left = 4
        Top = 16
        Width = 206
        Height = 21
        EditLabel.Width = 45
        EditLabel.Height = 13
        EditLabel.Caption = 'Localizar:'
        TabOrder = 0
        OnChange = EditBuscaChange
      end
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 487
    Width = 836
    Height = 19
    Panels = <>
  end
  object GridDadosPadroes: TJvDBUltimGrid
    Left = 361
    Top = 105
    Width = 475
    Height = 382
    Align = alClient
    DataSource = DSDadosPadroes
    TabOrder = 4
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    SelectColumnsDialogStrings.Caption = 'Select columns'
    SelectColumnsDialogStrings.OK = '&OK'
    SelectColumnsDialogStrings.NoSelectionWarning = 'At least one column must be visible!'
    EditControls = <>
    RowsHeight = 17
    TitleRowHeight = 17
    Columns = <
      item
        Expanded = False
        FieldName = 'CAMPO1'
        ReadOnly = True
        Title.Caption = 'Campo 1'
        Width = 120
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VALOR1'
        Title.Caption = 'Valor 1'
        Width = 120
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CAMPO2'
        ReadOnly = True
        Title.Caption = 'Campo 2'
        Width = 120
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VALOR2'
        Title.Caption = 'Valor 2'
        Width = 180
        Visible = True
      end>
  end
  object Entidade: TSQLDataSet
    SchemaName = 'dbo'
    CommandText = 'select * from "Sistema"'
    DbxCommandType = 'Dbx.SQL'
    MaxBlobSize = -1
    Params = <>
    Left = 752
    Top = 248
  end
  object DataSetEntidade: TClientDataSet
    Active = True
    Aggregates = <>
    Params = <>
    Left = 752
    Top = 216
    Data = {
      560000009619E0BD01000000180000000200000000000300000056000563616D
      706F01004900000001000557494454480200020032000D696D706C616D656E74
      6163616F01004900000001000557494454480200020064000000}
    object DataSetEntidadecampo: TStringField
      FieldName = 'campo'
      Size = 50
    end
    object DataSetEntidadeimplamentacao: TStringField
      FieldName = 'implamentacao'
      Size = 100
    end
  end
  object DataSource1: TDataSource
    DataSet = DataSetEntidade
    Left = 752
    Top = 360
  end
  object INTERBASE: TSQLConnection
    ConnectionName = 'IBCONNECTION'
    DriverName = 'Firebird'
    GetDriverFunc = 'getSQLDriverINTERBASE'
    LibraryName = 'dbxfb.dll'
    LoginPrompt = False
    Params.Strings = (
      
        'DriverPackageLoader=TDBXDynalinkDriverLoader,DbxCommonDriver140.' +
        'bpl'
      'VendorLib=fbclient.DLL')
    VendorLib = 'fbclient.dll'
    Left = 320
    Top = 248
  end
  object Oracle: TSQLConnection
    ConnectionName = 'IBCONNECTION'
    DriverName = 'Oracle'
    GetDriverFunc = 'getSQLDriverORACLE'
    LibraryName = 'dbxora30.dll'
    LoginPrompt = False
    Params.Strings = (
      
        'DriverPackageLoader=TDBXDynalinkDriverLoader,DBXCommonDriver140.' +
        'bpl')
    VendorLib = 'oci.dll'
    Left = 322
    Top = 408
  end
  object SQL: TSQLConnection
    ConnectionName = 'MSSQLCONNECTION'
    DriverName = 'MSSQL'
    GetDriverFunc = 'getSQLDriverMSSQL'
    LibraryName = 'dbxmss.dll'
    LoginPrompt = False
    Params.Strings = (
      'schemaoverride=sa.dbo'
      'drivername=MSSQL'
      'HostName=note-dell\sqlexpress'
      'Database=AXIAL_DB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'blobsize=-1'
      'localecode=0000'
      'isolationlevel=ReadCommitted'
      'os authentication=False'
      'prepare sql=False'
      'connecttimeout=60'
      'mars_connection=False'
      'ErrorResourceFile=')
    VendorLib = 'sqlncli10.dll'
    Left = 320
    Top = 302
  end
  object CONN: TSQLConnection
    ConnectionName = 'MSSQLCONNECTION'
    DriverName = 'MSSQL'
    GetDriverFunc = 'getSQLDriverMSSQL'
    LibraryName = 'dbxmss.dll'
    LoginPrompt = False
    Params.Strings = (
      'schemaoverride=sa.dbo'
      'drivername=MSSQL'
      'HostName=note-dell\sqlexpress'
      'Database=AXIAL_DB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'blobsize=-1'
      'localecode=0000'
      'isolationlevel=ReadCommitted'
      'os authentication=False'
      'prepare sql=False'
      'connecttimeout=60'
      'mars_connection=False'
      'ErrorResourceFile=')
    VendorLib = 'sqlncli10.dll'
    Left = 320
    Top = 356
  end
  object MySQL: TSQLConnection
    ConnectionName = 'IBCONNECTION'
    DriverName = 'MySQL'
    GetDriverFunc = 'getSQLDriverMYSQL'
    LibraryName = 'dbxmys.dll'
    LoginPrompt = False
    Params.Strings = (
      'DriverUnit=DBXMySQL'
      
        'DriverPackageLoader=TDBXDynalinkDriverLoader,DbxCommonDriver140.' +
        'bpl'
      'VendorLib=LIBMYSQL.dll')
    VendorLib = 'libmysql.dll'
    Left = 320
    Top = 464
  end
  object OpenDialog1: TOpenDialog
    Left = 752
    Top = 416
  end
  object FindDialog1: TFindDialog
    Left = 656
    Top = 416
  end
  object JvEnterAsTab1: TJvEnterAsTab
    Left = 448
    Top = 240
  end
  object CDSDadosPadroes: TClientDataSet
    Active = True
    Aggregates = <>
    FileName = 'TableDadosPadroes.xml'
    FieldDefs = <
      item
        Name = 'ID'
        Attributes = [faReadonly, faUnNamed]
        DataType = ftAutoInc
      end
      item
        Name = 'TABELA'
        Attributes = [faUnNamed]
        DataType = ftString
        Size = 50
      end
      item
        Name = 'CAMPO1'
        Attributes = [faUnNamed]
        DataType = ftString
        Size = 50
      end
      item
        Name = 'VALOR1'
        Attributes = [faUnNamed]
        DataType = ftString
        Size = 100
      end
      item
        Name = 'CAMPO2'
        Attributes = [faUnNamed]
        DataType = ftString
        Size = 50
      end
      item
        Name = 'VALOR2'
        Attributes = [faUnNamed]
        DataType = ftString
        Size = 100
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 560
    Top = 136
    Data = {
      7F0B00009619E0BD010000001800000006002E00000003000000420302494404
      0001001200010007535542545950450200490008004175746F696E6300065441
      42454C4101004900100001000557494454480200020032000643414D504F3101
      004900100001000557494454480200020032000656414C4F5231010049001000
      01000557494454480200020064000643414D504F320100490010000100055749
      4454480200020032000656414C4F523201004900100001000557494454480200
      0200640002000A4348414E47455F4C4F47040082009600000001000000000000
      0004000000020000000100000008000000030000000000000004000000040000
      0000000000040000000500000000000000040000000600000000000000040000
      0007000000040000000800000008000000050000000800000009000000060000
      00080000000A00000007000000080000000B00000008000000080000000C0000
      0009000000080000000D0000000A000000080000000E0000000B000000080000
      000F0000000C0000000800000010000000000000000400000011000000000000
      0004000000120000000000000004000000130000000000000004000000140000
      0000000000040000001400000000000000020000001500000010000000080000
      0016000000110000000800000017000000120000000800000018000000130000
      00080000001900000015000000080000001A00000016000000080000001B0000
      0017000000080000001C00000018000000080000001D00000000000000040000
      001E00000000000000040000001F0000000000000004000000200000001D0000
      0008000000210000001E00000008000000220000001F00000008000000230000
      0020000000080000002400000021000000080000002500000022000000080000
      0026000000000000000400000027000000000000000400000028000000000000
      00040000002900000026000000080000002A00000027000000080000002B0000
      0028000000080000002C00000029000000080000002D0000002A000000080000
      002E0000002B000000080000000D00000000000000020000000E000000000000
      00020000000F00000000000000020000000C4155544F494E4356414C55450400
      0100110000000500000100000016636F6D7072615F7469706F5F726571756973
      6963616F06434F4449474F0230310944455343524943414F0230320C00000100
      000016636F6D7072615F7469706F5F7265717569736963616F06434F4449474F
      0230310944455343524943414F07494E5445524E410400000200000016636F6D
      7072615F7469706F5F7265717569736963616F06434F4449474F023032094445
      5343524943414F0745585445524E410500050300000012636F6D7072615F7469
      706F5F70656469646F06434F4449474F064E4F524D414C050005040000001263
      6F6D7072615F7469706F5F70656469646F06434F4449474F09504C414E454A41
      444F0500050500000012636F6D7072615F7469706F5F70656469646F06434F44
      49474F0641424552544F0D00050300000012636F6D7072615F7469706F5F7065
      6469646F06434F4449474F0230310D00050400000012636F6D7072615F746970
      6F5F70656469646F06434F4449474F0230320D00050500000012636F6D707261
      5F7469706F5F70656469646F06434F4449474F0230330D00040300000012636F
      6D7072615F7469706F5F70656469646F06434F4449474F023031094445534352
      4943414F0D00040400000012636F6D7072615F7469706F5F70656469646F0643
      4F4449474F0230320944455343524943414F0D00040500000012636F6D707261
      5F7469706F5F70656469646F06434F4449474F0230330944455343524943414F
      0E00000300000012636F6D7072615F7469706F5F70656469646F06434F444947
      4F0230310944455343524943414F064E4F524D414C0E00000400000012636F6D
      7072615F7469706F5F70656469646F06434F4449474F02303209444553435249
      43414F09504C414E454A41444F0E00000500000012636F6D7072615F7469706F
      5F70656469646F06434F4449474F0230330944455343524943414F0641424552
      544F050005060000001266696E5F7374617475735F70617263656C6108534954
      554143414F023031050005070000001266696E5F7374617475735F7061726365
      6C6108534954554143414F023032050005080000001266696E5F737461747573
      5F70617263656C6108534954554143414F023033050005090000001266696E5F
      7374617475735F70617263656C6108534954554143414F0230340600050A0000
      001266696E5F7374617475735F70617263656C6108534954554143414F023035
      0D0004060000001266696E5F7374617475735F70617263656C61085349545541
      43414F0230310944455343524943414F0D0004070000001266696E5F73746174
      75735F70617263656C6108534954554143414F0230320944455343524943414F
      0D0004080000001266696E5F7374617475735F70617263656C61085349545541
      43414F0230330944455343524943414F0D0004090000001266696E5F73746174
      75735F70617263656C6108534954554143414F0230340944455343524943414F
      0C0000060000001266696E5F7374617475735F70617263656C61085349545541
      43414F0230310944455343524943414F0641424552544F0C0000070000001266
      696E5F7374617475735F70617263656C6108534954554143414F023032094445
      5343524943414F075155495441444F0C0000080000001266696E5F7374617475
      735F70617263656C6108534954554143414F0230330944455343524943414F0F
      5155495441444F205041524349414C0C0000090000001266696E5F7374617475
      735F70617263656C6108534954554143414F0230340944455343524943414F07
      56454E4349444F0500050B0000001266696E5F7469706F5F706167616D656E74
      6F045449504F0230310500050C0000001266696E5F7469706F5F706167616D65
      6E746F045449504F0230320500050D0000001266696E5F7469706F5F70616761
      6D656E746F045449504F0230330D00040B0000001266696E5F7469706F5F7061
      67616D656E746F045449504F0230310944455343524943414F0D00040C000000
      1266696E5F7469706F5F706167616D656E746F045449504F0230320944455343
      524943414F0D00040D0000001266696E5F7469706F5F706167616D656E746F04
      5449504F0230330944455343524943414F0C00000B0000001266696E5F746970
      6F5F706167616D656E746F045449504F0230310944455343524943414F084449
      4E484549524F0C00000C0000001266696E5F7469706F5F706167616D656E746F
      045449504F0230320944455343524943414F064348455155450C00000D000000
      1266696E5F7469706F5F706167616D656E746F045449504F0230330944455343
      524943414F0643415254414F0500050E0000001466696E5F7469706F5F726563
      6562696D656E746F045449504F0230310500050F0000001466696E5F7469706F
      5F7265636562696D656E746F045449504F023032050005100000001466696E5F
      7469706F5F7265636562696D656E746F045449504F0230330D00040E00000014
      66696E5F7469706F5F7265636562696D656E746F045449504F02303109444553
      43524943414F0D00040F0000001466696E5F7469706F5F7265636562696D656E
      746F045449504F0230320944455343524943414F0D0004100000001466696E5F
      7469706F5F7265636562696D656E746F045449504F0230330944455343524943
      414F0C00000E0000001466696E5F7469706F5F7265636562696D656E746F0454
      49504F0230310944455343524943414F0844494E484549524F0C00000F000000
      1466696E5F7469706F5F7265636562696D656E746F045449504F023032094445
      5343524943414F064348455155450C0000100000001466696E5F7469706F5F72
      65636562696D656E746F045449504F0230330944455343524943414F06434152
      54414F}
    object CDSDadosPadroesID: TAutoIncField
      DisplayLabel = 'Id'
      FieldName = 'ID'
    end
    object CDSDadosPadroesTABELA: TStringField
      DisplayLabel = 'Tabela'
      FieldName = 'TABELA'
      Size = 50
    end
    object CDSDadosPadroesCAMPO1: TStringField
      FieldName = 'CAMPO1'
      Size = 50
    end
    object CDSDadosPadroesVALOR1: TStringField
      FieldName = 'VALOR1'
      Size = 100
    end
    object CDSDadosPadroesCAMPO2: TStringField
      FieldName = 'CAMPO2'
      Size = 50
    end
    object CDSDadosPadroesVALOR2: TStringField
      FieldName = 'VALOR2'
      Size = 100
    end
  end
  object DSDadosPadroes: TDataSource
    DataSet = CDSDadosPadroes
    Left = 672
    Top = 136
  end
end
