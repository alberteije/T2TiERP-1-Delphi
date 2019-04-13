inherited FAuditoria: TFAuditoria
  Tag = 1
  Left = 375
  Caption = 'Auditoria'
  ClientWidth = 927
  ExplicitLeft = 375
  ExplicitWidth = 935
  ExplicitHeight = 500
  PixelsPerInch = 96
  TextHeight = 13
  inherited PageControl: TPageControl
    Width = 927
    ActivePage = PaginaEdits
    ExplicitWidth = 927
    inherited PaginaGrid: TTabSheet
      ExplicitWidth = 991
      ExplicitHeight = 395
      inherited PanelGrid: TPanel
        Width = 919
        ExplicitWidth = 919
        inherited Grid: TJvDBUltimGrid
          Width = 919
        end
        inherited PanelFiltroRapido: TPanel
          Width = 919
          ExplicitWidth = 919
          inherited BotaoConsultar: TSpeedButton
            Left = 785
            ExplicitLeft = 785
          end
          inherited EditCriterioRapido: TLabeledMaskEdit
            Width = 621
            ExplicitWidth = 621
          end
        end
      end
    end
    inherited PaginaEdits: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 24
      ExplicitWidth = 919
      ExplicitHeight = 407
      inherited PanelEdits: TPanel
        Width = 919
        ExplicitWidth = 919
        object BevelEdits: TBevel
          Left = 11
          Top = 12
          Width = 895
          Height = 384
          Anchors = [akLeft, akTop, akRight]
          Constraints.MinWidth = 753
        end
        object EditIdUsuario: TLabeledEdit
          Left = 18
          Top = 33
          Width = 47
          Height = 21
          EditLabel.Width = 36
          EditLabel.Height = 13
          EditLabel.BiDiMode = bdLeftToRight
          EditLabel.Caption = 'Usu'#225'rio'
          EditLabel.ParentBiDiMode = False
          ReadOnly = True
          TabOrder = 0
        end
        object EditAcao: TLabeledEdit
          Left = 656
          Top = 78
          Width = 241
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          EditLabel.Width = 28
          EditLabel.Height = 13
          EditLabel.Caption = 'A'#231#227'o:'
          ReadOnly = True
          TabOrder = 5
        end
        object EditLoginUsuario: TLabeledEdit
          Left = 65
          Top = 33
          Width = 832
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          Color = clInfoBk
          Constraints.MinWidth = 90
          EditLabel.Width = 36
          EditLabel.Height = 13
          EditLabel.BiDiMode = bdLeftToRight
          EditLabel.Caption = 'Usu'#225'rio'
          EditLabel.ParentBiDiMode = False
          ReadOnly = True
          TabOrder = 1
        end
        object EditDataRegistro: TLabeledDateEdit
          Left = 18
          Top = 78
          Width = 121
          Height = 21
          ReadOnly = True
          TabOrder = 2
          DateEditLabel.Width = 85
          DateEditLabel.Height = 13
          DateEditLabel.Caption = 'Data do Registro:'
        end
        object EditHoraRegistro: TLabeledMaskEdit
          Left = 145
          Top = 78
          Width = 95
          Height = 21
          Alignment = taCenter
          EditLabel.Width = 85
          EditLabel.Height = 13
          EditLabel.Caption = 'Hora do Registro:'
          MaxLength = 8
          ReadOnly = True
          TabOrder = 3
          Text = '  :: : :'
          Required = False
          EditMask = '##:##:##;1;_'
          MaskState = [msMasked]
        end
        object EditLocal: TLabeledEdit
          Left = 246
          Top = 78
          Width = 404
          Height = 21
          EditLabel.Width = 28
          EditLabel.Height = 13
          EditLabel.Caption = 'Local:'
          ReadOnly = True
          TabOrder = 4
        end
        object MemoConteudo: TLabeledMemo
          Left = 18
          Top = 120
          Width = 879
          Height = 265
          Anchors = [akLeft, akTop, akRight, akBottom]
          ReadOnly = True
          TabOrder = 6
          MemoLabel.Width = 51
          MemoLabel.Height = 13
          MemoLabel.Caption = 'Conte'#250'do:'
        end
      end
    end
  end
  inherited PanelToolBar: TPanel
    Width = 927
    ExplicitWidth = 927
    inherited BotaoSair: TSpeedButton
      Left = 823
      ExplicitLeft = 823
    end
    inherited BotaoExportar: TSpeedButton
      Left = 723
      ExplicitLeft = 723
    end
    inherited BotaoImprimir: TSpeedButton
      Left = 623
      ExplicitLeft = 623
    end
    inherited BotaoSeparador1: TSpeedButton
      Left = 513
      ExplicitLeft = 513
    end
    inherited BotaoFiltrar: TSpeedButton
      Left = 523
      ExplicitLeft = 523
    end
  end
end
