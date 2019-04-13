inherited FFap: TFFap
  Left = 318
  Top = 203
  Caption = 'Fap'
  ClientWidth = 988
  ExplicitWidth = 996
  ExplicitHeight = 488
  PixelsPerInch = 96
  TextHeight = 13
  inherited PageControl: TPageControl
    Width = 988
    ActivePage = PaginaEdits
    ExplicitWidth = 988
    inherited PaginaGrid: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 24
      ExplicitWidth = 980
      ExplicitHeight = 395
      inherited PanelGrid: TPanel
        Width = 980
        ExplicitWidth = 980
        inherited Grid: TJvDBUltimGrid
          Width = 980
        end
        inherited PanelFiltroRapido: TPanel
          Width = 980
          ExplicitWidth = 980
          inherited BotaoConsultar: TSpeedButton
            Left = 848
            ExplicitLeft = 825
          end
          inherited EditCriterioRapido: TLabeledMaskEdit
            Width = 679
            ExplicitWidth = 679
          end
        end
      end
    end
    inherited PaginaEdits: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 24
      ExplicitWidth = 980
      ExplicitHeight = 395
      inherited PanelEdits: TPanel
        Width = 980
        ExplicitWidth = 980
        object BevelEdits: TBevel
          Left = 0
          Top = 0
          Width = 973
          Height = 265
          Anchors = [akLeft, akTop, akRight]
          Constraints.MinWidth = 753
        end
        object EditEmpresa: TLabeledEdit
          Left = 82
          Top = 37
          Width = 871
          Height = 21
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          Color = clInfoBk
          EditLabel.Width = 6
          EditLabel.Height = 13
          EditLabel.Caption = '  '
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          ReadOnly = True
          TabOrder = 1
        end
        object EditDataInicial: TLabeledDateEdit
          Left = 144
          Top = 92
          Width = 99
          Height = 21
          TabOrder = 3
          DateEditLabel.Width = 57
          DateEditLabel.Height = 13
          DateEditLabel.Caption = 'Data Inicial:'
        end
        object EditFap: TLabeledCalcEdit
          Left = 16
          Top = 92
          Width = 95
          Height = 21
          DisplayFormat = '###,###,##0.00'
          ShowButton = False
          TabOrder = 2
          DecimalPlacesAlwaysShown = False
          CalcEditLabel.Width = 22
          CalcEditLabel.Height = 13
          CalcEditLabel.Caption = 'Fap:'
        end
        object EditDataFinal: TLabeledDateEdit
          Left = 280
          Top = 92
          Width = 99
          Height = 21
          TabOrder = 4
          DateEditLabel.Width = 52
          DateEditLabel.Height = 13
          DateEditLabel.Caption = 'Data Final:'
        end
        object EditIdEmpresa: TLabeledCalcEdit
          Left = 18
          Top = 37
          Width = 65
          Height = 21
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          ShowButton = False
          TabOrder = 0
          DecimalPlacesAlwaysShown = False
          CalcEditLabel.Width = 41
          CalcEditLabel.Height = 13
          CalcEditLabel.Caption = 'Empresa'
        end
      end
    end
  end
  inherited PanelToolBar: TPanel
    Width = 988
    ExplicitWidth = 988
    inherited BotaoSair: TSpeedButton
      Left = 884
      ExplicitLeft = 889
    end
    inherited BotaoExportar: TSpeedButton
      Left = 784
      ExplicitLeft = 799
    end
    inherited BotaoImprimir: TSpeedButton
      Left = 674
      ExplicitLeft = 719
    end
    inherited BotaoSeparador1: TSpeedButton
      Left = 774
      ExplicitLeft = 895
      ExplicitTop = -4
    end
    inherited BotaoFiltrar: TSpeedButton
      Left = 574
      ExplicitLeft = 639
    end
  end
end
