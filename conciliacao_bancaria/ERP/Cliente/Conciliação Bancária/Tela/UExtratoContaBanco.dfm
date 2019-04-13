inherited FExtratoContaBanco: TFExtratoContaBanco
  Caption = 'Extrato Banc'#225'rio'
  PixelsPerInch = 96
  TextHeight = 13
  inherited PageControl: TPageControl
    inherited PaginaGrid: TTabSheet
      Caption = 'Extrato'
      inherited PanelGrid: TPanel
        inherited PanelFiltroRapido: TPanel
          object Bevel1: TBevel
            Left = 8
            Top = 7
            Width = 978
            Height = 40
            Anchors = [akLeft, akTop, akRight]
            ExplicitWidth = 873
          end
          object Label2: TLabel
            Left = 57
            Top = 10
            Width = 40
            Height = 13
            Caption = 'Cr'#233'ditos'
          end
          object Label3: TLabel
            Left = 227
            Top = 10
            Width = 40
            Height = 13
            Caption = 'D'#233'bitos:'
          end
          object Label4: TLabel
            Left = 378
            Top = 10
            Width = 69
            Height = 13
            Caption = 'Saldo Extrato:'
          end
          object LabelSaldoExtrato: TLabel
            Left = 378
            Top = 28
            Width = 70
            Height = 13
            Alignment = taRightJustify
            Caption = 'Saldo Conta:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelDebitos: TLabel
            Left = 227
            Top = 29
            Width = 46
            Height = 13
            Alignment = taRightJustify
            Caption = 'D'#233'bitos:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object LabelCreditos: TLabel
            Left = 57
            Top = 29
            Width = 50
            Height = 13
            Alignment = taRightJustify
            Caption = 'Creditos:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
        end
      end
    end
  end
  inherited PanelToolBar: TPanel
    object BotaoConciliarLancamentos: TSpeedButton [4]
      Left = 510
      Top = 0
      Width = 175
      Height = 27
      Align = alRight
      Caption = 'Co&nciliar Lan'#231'amentos [F11]'
      ParentShowHint = False
      ShowHint = True
      ExplicitLeft = 497
    end
    object BotaoConciliarCheques: TSpeedButton [5]
      Left = 340
      Top = 0
      Width = 170
      Height = 27
      Align = alRight
      Caption = 'Conciliar Cheques [F10]'
      ParentShowHint = False
      ShowHint = True
      ExplicitLeft = 309
    end
    object BotaoImportaArquivo: TSpeedButton [6]
      Left = 170
      Top = 0
      Width = 170
      Height = 27
      Action = ActionImportarArquivo
      Align = alRight
      ParentShowHint = False
      ShowHint = True
      ExplicitTop = -4
    end
  end
  object ActionManager: TActionManager
    ActionBars.ShowHints = False
    ActionBars = <
      item
      end
      item
        Items = <
          item
            Caption = '-'
          end
          item
            Caption = '-'
          end
          item
            Caption = '-'
          end>
      end
      item
      end
      item
      end>
    DisabledImages = FDataModule.ImagensCadastrosD
    Images = FDataModule.ImagensCadastros
    Left = 760
    Top = 208
    StyleName = 'Ribbon - Silver'
    object ActionImportarArquivo: TAction
      Caption = 'Importar Arquivo [F5]'
      OnExecute = ActionImportarArquivoExecute
    end
    object ActionConciliarCheques: TAction
      Caption = 'Conciliar Cheques [F10]'
      OnExecute = ActionConciliarChequesExecute
    end
  end
end
