object WebReportMan: TWebReportMan
  Left = 194
  Top = 114
  Width = 428
  Height = 307
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnCreate = ActiveFormCreate
  OnKeyDown = ActiveFormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object webmetaprint: TRpWebMetaPrint
    Left = 8
    Top = 148
    Width = 389
    Height = 77
    Install = False
    PrinterConfig = False
    Port = 80
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 100
    OnTimer = Timer1Timer
    Left = 108
    Top = 52
  end
end
