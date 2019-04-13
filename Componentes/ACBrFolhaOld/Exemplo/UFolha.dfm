object Form1: TForm1
  Left = 419
  Top = 223
  BorderStyle = bsDialog
  Caption = 'ACBrFolha - Demonstra'#231#227'o'
  ClientHeight = 447
  ClientWidth = 664
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 664
    Height = 447
    ActivePage = TabSheet2
    Align = alClient
    TabOrder = 0
    object TabSheet2: TTabSheet
      Caption = 'Sefip'
      ImageIndex = 1
      object EditCnpj: TLabeledEdit
        Left = 11
        Top = 24
        Width = 110
        Height = 21
        EditLabel.Width = 29
        EditLabel.Height = 13
        EditLabel.Caption = 'CNPJ:'
        TabOrder = 0
        Text = '10793118000178'
      end
      object EditInscricaoEstadual: TLabeledEdit
        Left = 127
        Top = 24
        Width = 110
        Height = 21
        EditLabel.Width = 21
        EditLabel.Height = 13
        EditLabel.Caption = 'CEI:'
        TabOrder = 1
        Text = '123456789102'
      end
      object EditRazaoSocial: TLabeledEdit
        Left = 243
        Top = 24
        Width = 398
        Height = 21
        EditLabel.Width = 64
        EditLabel.Height = 13
        EditLabel.Caption = 'Raz'#227'o Social:'
        TabOrder = 2
        Text = 'T2Ti Tecnologia da Informa'#231#227'o'
      end
      object Memo2: TMemo
        Left = 3
        Top = 51
        Width = 650
        Height = 334
        TabOrder = 3
      end
      object Button2: TButton
        Left = 204
        Top = 391
        Width = 249
        Height = 25
        Caption = 'Gerar Sefip'
        TabOrder = 4
        OnClick = Button2Click
      end
    end
  end
  object ACBrFolha: TACBrFolha
    Path = 'C:\'
    Left = 592
    Top = 16
  end
end
