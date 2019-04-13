inherited FColaborador: TFColaborador
  Left = 174
  Top = 61
  Caption = 'Colaborador'
  ClientHeight = 512
  ExplicitLeft = 174
  ExplicitTop = 61
  ExplicitHeight = 550
  PixelsPerInch = 96
  TextHeight = 13
  inherited PageControl: TPageControl
    Height = 512
    ExplicitHeight = 512
    inherited PaginaGrid: TTabSheet
      inherited PanelGrid: TPanel
        Height = 484
        ExplicitHeight = 484
        inherited Grid: TJvDBUltimGrid
          Height = 397
        end
        inherited PanelFiltroRapido: TPanel
          Top = 428
          ExplicitTop = 428
        end
        inherited PanelToolBarGrid: TPanel
          ExplicitTop = -2
          inherited BotaoFiltrar: TSpeedButton
            Left = 483
            ExplicitLeft = 483
          end
          inherited BotaoExportar: TSpeedButton
            Left = 587
            ExplicitLeft = 587
          end
          inherited BotaoImprimir: TSpeedButton
            Left = 701
            ExplicitLeft = 701
          end
          inherited BotaoSair: TSpeedButton
            Left = 815
            ExplicitLeft = 815
          end
          inherited BotaoSeparador2: TSpeedButton
            Left = 691
            ExplicitLeft = 691
          end
          inherited BotaoSeparador3: TSpeedButton
            Left = 473
            ExplicitLeft = 473
          end
          inherited BotaoSeparador4: TSpeedButton
            Left = 805
            ExplicitLeft = 805
          end
          object BotaoInserir: TSpeedButton
            Left = 161
            Top = 1
            Width = 104
            Height = 25
            Align = alLeft
            Caption = 'Inserir [F2]'
            ParentShowHint = False
            ShowHint = True
            ExplicitLeft = 261
            ExplicitTop = -4
          end
          object BotaoAlterar: TSpeedButton
            Left = 265
            Top = 1
            Width = 104
            Height = 25
            Align = alLeft
            Caption = 'Alterar [F3]'
            ParentShowHint = False
            ShowHint = True
            ExplicitLeft = 257
            ExplicitTop = -4
          end
          object BotaoExcluir: TSpeedButton
            Left = 369
            Top = 1
            Width = 104
            Height = 25
            Align = alLeft
            Caption = 'Excluir [F4]'
            ParentShowHint = False
            ShowHint = True
            ExplicitLeft = 313
            ExplicitTop = -4
          end
        end
      end
    end
    inherited PaginaEdits: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 24
      ExplicitWidth = 946
      ExplicitHeight = 484
      inherited PanelEdits: TPanel
        Height = 484
        ExplicitHeight = 484
        object BevelEdits: TBevel [0]
          Left = 10
          Top = 42
          Width = 919
          Height = 151
          Anchors = [akLeft, akTop, akRight]
          Constraints.MinWidth = 753
        end
        object Label1: TLabel [1]
          Left = 18
          Top = 96
          Width = 50
          Height = 13
          Caption = 'Descri'#231#227'o:'
        end
        inherited PanelToolBarEdits: TPanel
          object BotaoCancelar: TSpeedButton
            Left = 833
            Top = 1
            Width = 104
            Height = 25
            Align = alRight
            Caption = 'Cancelar [F11]'
            ParentShowHint = False
            ShowHint = True
            ExplicitLeft = 261
            ExplicitTop = -4
          end
          object BotaoSalvar: TSpeedButton
            Left = 729
            Top = 1
            Width = 104
            Height = 25
            Align = alRight
            Caption = 'Salvar [F12]'
            ParentShowHint = False
            ShowHint = True
            ExplicitLeft = 261
            ExplicitTop = -4
          end
        end
        object EditSigla: TLabeledEdit
          Left = 18
          Top = 69
          Width = 90
          Height = 21
          EditLabel.Width = 26
          EditLabel.Height = 13
          EditLabel.Caption = 'Sigla:'
          MaxLength = 10
          TabOrder = 1
        end
        object MemoDescricao: TMemo
          Left = 18
          Top = 112
          Width = 903
          Height = 74
          Anchors = [akLeft, akTop, akRight]
          ScrollBars = ssVertical
          TabOrder = 2
        end
      end
    end
  end
end
