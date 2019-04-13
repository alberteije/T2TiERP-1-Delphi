object frEmulador: TfrEmulador
  Left = 681
  Top = 171
  Width = 347
  Height = 426
  HorzScrollBar.Range = 339
  VertScrollBar.Range = 180
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Emulador de balan'#231'as'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 16
    Top = 8
    Width = 305
    Height = 376
    TabOrder = 0
    object Label1: TLabel
      Left = 32
      Top = 225
      Width = 65
      Height = 13
      Caption = 'Peso a enviar'
    end
    object Label4: TLabel
      Left = 208
      Top = 89
      Width = 25
      Height = 13
      Caption = 'Porta'
    end
    object Label2: TLabel
      Left = 32
      Top = 15
      Width = 238
      Height = 73
      Alignment = taCenter
      AutoSize = False
      Caption = 
        'Emulador de Balan'#231'as TOLEDO e FILIZOLA'#13#10'Use uma porta serial dif' +
        'erente da usada no ACBrBalancaTeste...'#13#10'Use o mesmo cabo utiliza' +
        'do pelos Emuladores de ECF para ligar as duas portas seriais'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      WordWrap = True
    end
    object Label3: TLabel
      Left = 32
      Top = 132
      Width = 81
      Height = 13
      Caption = 'C'#243'digo Enviado: '
    end
    object lEnviado: TLabel
      Left = 27
      Top = 160
      Width = 246
      Height = 20
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 11
      Font.Name = 'MS Sans Serif'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label5: TLabel
      Left = 32
      Top = 89
      Width = 39
      Height = 13
      Caption = 'Balan'#231'a'
    end
    object edBarra: TLabel
      Left = 32
      Top = 244
      Width = 193
      Height = 49
      Alignment = taRightJustify
      AutoSize = False
      Caption = '0,314'
      Color = clBlack
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -37
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object Label6: TLabel
      Left = 225
      Top = 244
      Width = 42
      Height = 49
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'kg'
      Color = clBlack
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -27
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
    end
    object cbxPorta: TComboBox
      Left = 208
      Top = 105
      Width = 65
      Height = 21
      TabOrder = 0
      Text = 'COM1'
      OnChange = cbxPortaChange
      Items.Strings = (
        'COM1'
        'COM2'
        'COM3'
        'COM4'
        'COM5'
        'COM6'
        'COM7'
        'COM8'
        'COM9'
        'COM10'
        'COM11'
        'COM12'
        'LPT1'
        'LPT2'
        'LPT3')
    end
    object btEnviar: TButton
      Left = 162
      Top = 332
      Width = 111
      Height = 25
      Caption = 'Enviar'
      Default = True
      TabOrder = 1
      OnClick = btEnviarClick
    end
    object cbModelo: TComboBox
      Left = 32
      Top = 105
      Width = 121
      Height = 21
      TabOrder = 2
      Text = 'TOLEDO'
      OnChange = cbxPortaChange
      Items.Strings = (
        'FILIZOLA'
        'TOLEDO')
    end
    object cbAutoEnvio: TCheckBox
      Left = 199
      Top = 180
      Width = 79
      Height = 17
      Caption = 'Auto Enviar'
      TabOrder = 3
      OnClick = cbAutoEnvioClick
    end
    object btPesar: TButton
      Left = 32
      Top = 197
      Width = 241
      Height = 25
      Caption = 'Pesar'
      TabOrder = 4
      OnClick = btPesarClick
    end
    object cbVariaPeso: TCheckBox
      Left = 32
      Top = 180
      Width = 158
      Height = 17
      Caption = 'Variar peso autom'#225'ticamente'
      TabOrder = 5
      OnClick = cbVariaPesoClick
    end
    object btSobrepeso: TButton
      Left = 32
      Top = 305
      Width = 110
      Height = 25
      Caption = 'Simular Sobrepeso'
      Default = True
      TabOrder = 6
      OnClick = btSobrepesoClick
    end
    object btInstavel: TButton
      Left = 163
      Top = 305
      Width = 110
      Height = 25
      Caption = 'Simular Instabilidade'
      Default = True
      TabOrder = 7
      OnClick = btInstavelClick
    end
    object Button1: TButton
      Left = 32
      Top = 332
      Width = 110
      Height = 25
      Caption = 'Peso Negativo'
      Default = True
      TabOrder = 8
      OnClick = Button1Click
    end
  end
  object tmVariaPeso: TTimer
    Enabled = False
    Interval = 1500
    OnTimer = tmVariaPesoTimer
    Left = 80
    Top = 144
  end
  object tmEnviar: TTimer
    Enabled = False
    Interval = 800
    OnTimer = tmEnviarTimer
    Left = 152
    Top = 144
  end
end
