object FRpDInfoVCL: TFRpDInfoVCL
  Left = 183
  Top = 112
  Width = 800
  Height = 600
  Caption = 'Database connections and datasets'
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  Position = poScreenCenter
  ShowHint = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PBottom: TPanel
    Left = 0
    Top = 523
    Width = 784
    Height = 39
    Align = alBottom
    TabOrder = 0
    object BOk: TButton
      Left = 12
      Top = 8
      Width = 89
      Height = 25
      Caption = 'OK'
      TabOrder = 0
      OnClick = BOkClick
    end
    object BCancel: TButton
      Left = 116
      Top = 8
      Width = 89
      Height = 25
      Caption = 'Cancel'
      TabOrder = 1
      OnClick = BCancelClick
    end
  end
  object PControl: TPageControl
    Left = 0
    Top = 0
    Width = 784
    Height = 523
    ActivePage = TabConnections
    Align = alClient
    TabOrder = 1
    OnChange = PControlChange
    object TabConnections: TTabSheet
      Caption = 'Connections'
    end
    object TabDatasets: TTabSheet
      Caption = 'Datasets'
      ImageIndex = 1
    end
  end
end
