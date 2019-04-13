object FLangInfo: TFLangInfo
  Left = 108
  Top = 85
  Width = 630
  Height = 431
  Caption = 'Language information'
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  Position = poScreenCenter
  ShowHint = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 622
    Height = 53
    Align = alTop
    TabOrder = 0
    object LActiveLang: TLabel
      Left = 8
      Top = 8
      Width = 77
      Height = 13
      Caption = 'Active language'
    end
    object LSystemLang: TLabel
      Left = 8
      Top = 32
      Width = 81
      Height = 13
      Caption = 'System language'
    end
    object LActiveExt: TLabel
      Left = 128
      Top = 8
      Width = 51
      Height = 13
      Caption = 'LActiveExt'
    end
    object LSystemExt: TLabel
      Left = 128
      Top = 32
      Width = 51
      Height = 13
      Caption = 'LActiveExt'
    end
    object LActiveName: TLabel
      Left = 168
      Top = 8
      Width = 51
      Height = 13
      Caption = 'LActiveExt'
    end
    object LSystemname: TLabel
      Left = 168
      Top = 32
      Width = 51
      Height = 13
      Caption = 'LActiveExt'
    end
  end
  object GridLang: TDBGrid
    Left = 0
    Top = 53
    Width = 622
    Height = 344
    Align = alClient
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object DLang: TClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <
      item
        Name = 'IEXT'
        Fields = 'EXTENSION'
      end>
    IndexName = 'IEXT'
    Params = <>
    StoreDefs = True
    Left = 128
    Top = 112
    object DLangLANGID: TStringField
      DisplayLabel = 'Id'
      DisplayWidth = 8
      FieldName = 'LANGID'
      Size = 10
    end
    object DLangEXTENSION: TStringField
      DisplayLabel = 'Extension'
      FieldName = 'EXTENSION'
      Size = 3
    end
    object DLangLANGIDBIN: TLargeintField
      FieldName = 'LANGIDBIN'
      Visible = False
    end
    object DLangDESCRIPTION: TStringField
      DisplayLabel = 'Description'
      DisplayWidth = 40
      FieldName = 'DESCRIPTION'
      Size = 50
    end
    object DLangENGDESC: TStringField
      DisplayLabel = 'English description'
      DisplayWidth = 40
      FieldName = 'ENGDESC'
      Size = 50
    end
  end
  object SLang: TDataSource
    DataSet = DLang
    Left = 160
    Top = 112
  end
end
