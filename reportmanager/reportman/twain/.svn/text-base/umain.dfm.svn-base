object Form1: TForm1
  Left = 264
  Top = 110
  Width = 895
  Height = 746
  Caption = 'Twain Test'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 887
    Height = 253
    Align = alTop
    TabOrder = 0
    DesignSize = (
      887
      253)
    object Label1: TLabel
      Left = 8
      Top = 12
      Width = 127
      Height = 13
      Caption = 'URL subida (comando put)'
    end
    object Label2: TLabel
      Left = 8
      Top = 36
      Width = 173
      Height = 13
      Caption = 'URL subida completa (comando get)'
    end
    object Label3: TLabel
      Left = 8
      Top = 84
      Width = 58
      Height = 13
      Caption = 'Calidad jpeg'
    end
    object Label4: TLabel
      Left = 8
      Top = 108
      Width = 56
      Height = 13
      Caption = 'Gif dithering'
    end
    object Label5: TLabel
      Left = 8
      Top = 156
      Width = 156
      Height = 13
      Caption = 'Tama'#241'o del buffer de transmisi'#243'n'
    end
    object Label6: TLabel
      Left = 8
      Top = 132
      Width = 105
      Height = 13
      Caption = 'T'#237'tulo de la aplicaci'#243'n'
    end
    object Label7: TLabel
      Left = 8
      Top = 60
      Width = 90
      Height = 13
      Caption = 'Formato de imagen'
    end
    object Label8: TLabel
      Left = 8
      Top = 180
      Width = 118
      Height = 13
      Caption = 'Tama'#241'o m'#225'ximo (Kbytes)'
    end
    object EURL: TEdit
      Left = 192
      Top = 8
      Width = 688
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
      Text = 'http://amdxp/upload/test4.gif'
    end
    object EURLComplete: TEdit
      Left = 192
      Top = 32
      Width = 688
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 1
      Text = 'http://amdxp'
    end
    object EJpeg: TSpinEdit
      Left = 192
      Top = 80
      Width = 73
      Height = 22
      MaxValue = 100
      MinValue = 1
      TabOrder = 2
      Value = 80
    end
    object ComboDithering: TComboBox
      Left = 192
      Top = 104
      Width = 688
      Height = 21
      Style = csDropDownList
      Anchors = [akLeft, akTop, akRight]
      ItemHeight = 13
      TabOrder = 3
      Items.Strings = (
        'Nearest color matching w/o error correction'
        'Floyd Steinberg Error Diffusion dithering'
        'Stucki Error Diffusion dithering'
        'Sierra Error Diffusion dithering'
        'Jarvis, Judice & Ninke Error Diffusion dithering'
        'Stevenson & Arche Error Diffusion dithering'
        'Burkes Error Diffusion dithering')
    end
    object EBuffer: TSpinEdit
      Left = 192
      Top = 152
      Width = 69
      Height = 22
      MaxValue = 100000
      MinValue = 1
      TabOrder = 4
      Value = 4096
    end
    object ETitle: TEdit
      Left = 192
      Top = 128
      Width = 688
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 5
      Text = 'Prueba de scanner'
    end
    object ComboFormat: TComboBox
      Left = 192
      Top = 56
      Width = 73
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 6
      Items.Strings = (
        'Bitmap'
        'JPeg'
        'Gif')
    end
    object Button1: TButton
      Left = 8
      Top = 216
      Width = 133
      Height = 25
      Caption = 'Comenzar'
      TabOrder = 7
      OnClick = Empezar1Click
    end
    object EMaxSize: TSpinEdit
      Left = 192
      Top = 176
      Width = 69
      Height = 22
      MaxValue = 100000
      MinValue = 1
      TabOrder = 8
      Value = 1000
    end
  end
  object XPManifest1: TXPManifest
    Left = 260
    Top = 76
  end
  object MainMenu1: TMainMenu
    Left = 336
    Top = 228
    object Archivo1: TMenuItem
      Caption = 'Archivo'
      object Empezar1: TMenuItem
        Caption = 'Empezar'
        OnClick = Empezar1Click
      end
    end
  end
end
