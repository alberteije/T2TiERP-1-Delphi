object Form1: TForm1
  Left = 192
  Top = 114
  Width = 696
  Height = 480
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Chart1: TChart
    Left = 244
    Top = 92
    Width = 141
    Height = 105
    BackWall.Brush.Color = clWhite
    BackWall.Brush.Style = bsClear
    Title.Text.Strings = (
      'TChart')
    TabOrder = 0
  end
  object DBEdit1: TDBEdit
    Left = 268
    Top = 52
    Width = 65
    Height = 21
    TabOrder = 1
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 688
    Height = 29
    Caption = 'ToolBar1'
    TabOrder = 2
  end
  object DBGrid1: TDBGrid
    Left = 328
    Top = 252
    Width = 125
    Height = 37
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object IdTCPClient1: TIdTCPClient
    MaxLineAction = maException
    ReadTimeout = 0
    Port = 0
    Left = 76
    Top = 80
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 136
    Top = 56
  end
  object SQLConnection1: TSQLConnection
    Left = 144
    Top = 132
  end
  object SQLQuery1: TSQLQuery
    Params = <>
    Left = 184
    Top = 104
  end
  object PDFReport1: TPDFReport
    Title = 'Untitled'
    ShowPrintDialog = False
    Copies = 1
    Left = 436
    Top = 112
  end
  object VCLReport1: TVCLReport
    Title = 'Untitled'
    Left = 432
    Top = 184
  end
  object RpDesignerVCL1: TRpDesignerVCL
    Left = 496
    Top = 168
  end
end
