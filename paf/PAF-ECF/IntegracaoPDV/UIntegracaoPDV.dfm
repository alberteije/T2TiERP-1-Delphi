object FIntegracaoPDV: TFIntegracaoPDV
  Left = 329
  Top = 185
  Caption = 'Integracao com o PDV'
  ClientHeight = 72
  ClientWidth = 387
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object ListTXT: TFileListBox
    Left = 120
    Top = 8
    Width = 121
    Height = 41
    ItemHeight = 13
    TabOrder = 0
    Visible = False
  end
  object pBanco: TProgressBar
    Left = 0
    Top = 56
    Width = 387
    Height = 16
    Align = alBottom
    Max = 30
    TabOrder = 1
  end
  object pLabel: TPanel
    Left = 0
    Top = 0
    Width = 387
    Height = 56
    Align = alClient
    BevelInner = bvLowered
    BevelKind = bkFlat
    Caption = 'Conectando ao Banco ...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
  end
  object TimeIntegracao: TTimer
    Enabled = False
    Interval = 5000
    OnTimer = TimeIntegracaoTimer
    Left = 288
    Top = 40
  end
  object JvTrayIcon1: TJvTrayIcon
    Active = True
    IconIndex = 0
    Visibility = [tvVisibleTaskList, tvAutoHide, tvRestoreDbClick, tvMinimizeDbClick]
    Left = 136
    Top = 16
  end
  object timeConexao: TTimer
    OnTimer = timeConexaoTimer
    Left = 32
    Top = 24
  end
end
