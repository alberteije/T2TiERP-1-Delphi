object Form1: TForm1
  Left = 227
  Top = 116
  Width = 544
  Height = 375
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
  object Button1: TButton
    Left = 24
    Top = 32
    Width = 97
    Height = 49
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 52
    Top = 152
    Width = 173
    Height = 21
    TabOrder = 1
    Text = 'sample2.rep'
  end
  object VCLReport1: TVCLReport
    Filename = 'sample4.rep'
    Title = 'Untitled'
    Left = 48
    Top = 96
  end
end
