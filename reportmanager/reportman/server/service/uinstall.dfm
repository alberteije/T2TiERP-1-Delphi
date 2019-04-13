object FStartService: TFStartService
  Left = 213
  Top = 147
  ActiveControl = EUserName
  BorderStyle = bsDialog
  Caption = 'Instalation of Report Manager Service'
  ClientHeight = 367
  ClientWidth = 441
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object LUser: TLabel
    Left = 12
    Top = 120
    Width = 51
    Height = 13
    Caption = 'User name'
  end
  object LPassword: TLabel
    Left = 12
    Top = 148
    Width = 46
    Height = 13
    Caption = 'Password'
  end
  object LConfirm: TLabel
    Left = 12
    Top = 176
    Width = 83
    Height = 13
    Caption = 'Confirm password'
  end
  object Label1: TLabel
    Left = 12
    Top = 52
    Width = 417
    Height = 49
    AutoSize = False
    Caption = 
      'You should enter a valid user system account and password. This ' +
      'account will start the service and should have rights to access ' +
      'report directories. If left blank the LocalSystem account will b' +
      'e used but it does not work in all systems'
    WordWrap = True
  end
  object Label2: TLabel
    Left = 12
    Top = 4
    Width = 413
    Height = 49
    AutoSize = False
    Caption = 
      'This application must be executed in the server machine you want' +
      ' to install the service. You must have Administration rights in ' +
      'this machine.'
    WordWrap = True
  end
  object EUserName: TEdit
    Left = 156
    Top = 116
    Width = 121
    Height = 21
    TabOrder = 0
  end
  object EPassword: TEdit
    Left = 156
    Top = 144
    Width = 121
    Height = 21
    PasswordChar = '*'
    TabOrder = 1
  end
  object EConfirm: TEdit
    Left = 156
    Top = 172
    Width = 121
    Height = 21
    PasswordChar = '*'
    TabOrder = 2
  end
  object BInstall: TButton
    Left = 12
    Top = 212
    Width = 133
    Height = 33
    Caption = 'Install service'
    TabOrder = 3
    OnClick = BInstallClick
  end
  object BUnInstall: TButton
    Left = 252
    Top = 208
    Width = 133
    Height = 33
    Caption = 'Uninstall service'
    TabOrder = 4
    OnClick = BUnInstallClick
  end
  object GroupBox1: TGroupBox
    Left = 12
    Top = 252
    Width = 421
    Height = 105
    Caption = 'Current service status'
    TabOrder = 5
    object LStatus: TLabel
      Left = 12
      Top = 24
      Width = 213
      Height = 21
      AutoSize = False
    end
    object Label3: TLabel
      Left = 8
      Top = 84
      Width = 226
      Height = 13
      Caption = 'Go to system services to change startup options'
    end
    object BStart: TButton
      Left = 8
      Top = 52
      Width = 125
      Height = 29
      Caption = 'Start Service'
      Enabled = False
      TabOrder = 0
      OnClick = BStartClick
    end
    object BStop: TButton
      Left = 136
      Top = 52
      Width = 129
      Height = 29
      Caption = 'Stop service'
      Enabled = False
      TabOrder = 1
      OnClick = BStopClick
    end
    object BRefresh: TButton
      Left = 272
      Top = 52
      Width = 141
      Height = 29
      Caption = 'Refresh Status'
      TabOrder = 2
      OnClick = BRefreshClick
    end
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 3000
    OnTimer = Timer1Timer
    Left = 328
    Top = 140
  end
end
