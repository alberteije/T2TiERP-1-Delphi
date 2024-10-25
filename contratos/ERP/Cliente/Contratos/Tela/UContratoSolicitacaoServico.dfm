inherited FContratoSolicitacaoServico: TFContratoSolicitacaoServico
  Tag = 1
  Left = 309
  Top = 215
  Caption = 'Solicita'#231#227'o de Servi'#231'o'
  ClientWidth = 893
  ExplicitLeft = 309
  ExplicitTop = 215
  ExplicitWidth = 901
  ExplicitHeight = 500
  PixelsPerInch = 96
  TextHeight = 13
  inherited PageControl: TPageControl
    Width = 893
    ActivePage = PaginaEdits
    ExplicitWidth = 930
    inherited PaginaGrid: TTabSheet
      inherited PanelGrid: TPanel
        Width = 885
        ExplicitWidth = 922
        inherited Grid: TJvDBUltimGrid
          Width = 885
        end
        inherited PanelFiltroRapido: TPanel
          Width = 885
          ExplicitWidth = 922
          inherited BotaoConsultar: TSpeedButton
            Left = 753
            ExplicitLeft = 790
          end
          inherited EditCriterioRapido: TLabeledMaskEdit
            Width = 584
            ExplicitWidth = 621
          end
        end
      end
    end
    inherited PaginaEdits: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 24
      ExplicitWidth = 922
      ExplicitHeight = 395
      inherited PanelEdits: TPanel
        Width = 885
        ExplicitWidth = 922
        object BevelEdits: TBevel
          Left = 10
          Top = 11
          Width = 864
          Height = 294
          Anchors = [akLeft, akTop, akRight]
          Constraints.MinWidth = 753
          ExplicitWidth = 753
        end
        object ComboBoxUrgente: TLabeledComboBox
          Left = 270
          Top = 274
          Width = 75
          Height = 21
          Style = csDropDownList
          ItemIndex = 1
          TabOrder = 13
          Text = 'N'#227'o'
          Items.Strings = (
            'Sim'
            'N'#227'o')
          ComboBoxLabel.Width = 43
          ComboBoxLabel.Height = 13
          ComboBoxLabel.Caption = 'Urgente:'
        end
        object EditIdCliente: TLabeledCalcEdit
          Left = 163
          Top = 42
          Width = 61
          Height = 21
          ShowButton = False
          TabOrder = 0
          Visible = False
          DecimalPlacesAlwaysShown = False
          OnExit = EditIdClienteExit
          OnKeyDown = EditIdClienteKeyDown
          OnKeyPress = EditIdClienteKeyPress
          CalcEditLabel.Width = 60
          CalcEditLabel.Height = 13
          CalcEditLabel.Caption = 'Cliente [F1]:'
        end
        object EditCliente: TLabeledEdit
          Left = 224
          Top = 42
          Width = 640
          Height = 21
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          Color = clInfoBk
          EditLabel.Width = 6
          EditLabel.Height = 13
          EditLabel.Caption = '  '
          ReadOnly = True
          TabOrder = 1
          Visible = False
          ExplicitWidth = 529
        end
        object EditIdFornecedor: TLabeledCalcEdit
          Left = 163
          Top = 42
          Width = 61
          Height = 21
          ShowButton = False
          TabOrder = 2
          Visible = False
          DecimalPlacesAlwaysShown = False
          OnExit = EditIdFornecedorExit
          OnKeyDown = EditIdFornecedorKeyDown
          OnKeyPress = EditIdFornecedorKeyPress
          CalcEditLabel.Width = 82
          CalcEditLabel.Height = 13
          CalcEditLabel.Caption = 'Fornecedor [F1]:'
        end
        object EditFornecedor: TLabeledEdit
          Left = 224
          Top = 42
          Width = 640
          Height = 21
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          Color = clInfoBk
          EditLabel.Width = 6
          EditLabel.Height = 13
          EditLabel.Caption = '  '
          ReadOnly = True
          TabOrder = 3
          Visible = False
          ExplicitWidth = 529
        end
        object EditIdSetor: TLabeledCalcEdit
          Left = 16
          Top = 104
          Width = 61
          Height = 21
          ShowButton = False
          TabOrder = 4
          DecimalPlacesAlwaysShown = False
          OnExit = EditIdSetorExit
          OnKeyDown = EditIdSetorKeyDown
          OnKeyPress = EditIdSetorKeyPress
          CalcEditLabel.Width = 53
          CalcEditLabel.Height = 13
          CalcEditLabel.Caption = 'Setor [F1]:'
        end
        object EditSetor: TLabeledEdit
          Left = 77
          Top = 104
          Width = 787
          Height = 21
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          Color = clInfoBk
          EditLabel.Width = 6
          EditLabel.Height = 13
          EditLabel.Caption = '  '
          ReadOnly = True
          TabOrder = 5
          ExplicitWidth = 676
        end
        object EditColaborador: TLabeledEdit
          Left = 77
          Top = 147
          Width = 787
          Height = 21
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          Color = clInfoBk
          EditLabel.Width = 6
          EditLabel.Height = 13
          EditLabel.Caption = '  '
          ReadOnly = True
          TabOrder = 7
          ExplicitWidth = 676
        end
        object EditIdColaborador: TLabeledCalcEdit
          Left = 16
          Top = 147
          Width = 61
          Height = 21
          ShowButton = False
          TabOrder = 6
          DecimalPlacesAlwaysShown = False
          OnExit = EditIdColaboradorExit
          OnKeyDown = EditIdColaboradorKeyDown
          OnKeyPress = EditIdColaboradorKeyPress
          CalcEditLabel.Width = 86
          CalcEditLabel.Height = 13
          CalcEditLabel.Caption = 'Colaborador [F1]:'
        end
        object EditTipoServico: TLabeledEdit
          Left = 77
          Top = 190
          Width = 787
          Height = 21
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          Color = clInfoBk
          EditLabel.Width = 6
          EditLabel.Height = 13
          EditLabel.Caption = '  '
          ReadOnly = True
          TabOrder = 9
          ExplicitWidth = 676
        end
        object EditIdTipoServico: TLabeledCalcEdit
          Left = 16
          Top = 190
          Width = 61
          Height = 21
          ShowButton = False
          TabOrder = 8
          DecimalPlacesAlwaysShown = False
          OnExit = EditIdTipoServicoExit
          OnKeyDown = EditIdTipoServicoKeyDown
          OnKeyPress = EditIdTipoServicoKeyPress
          CalcEditLabel.Width = 85
          CalcEditLabel.Height = 13
          CalcEditLabel.Caption = 'Tipo Servi'#231'o [F1]:'
        end
        object EditDataSolicitacao: TLabeledDateEdit
          Left = 16
          Top = 274
          Width = 121
          Height = 21
          TabOrder = 11
          DateEditLabel.Width = 80
          DateEditLabel.Height = 13
          DateEditLabel.Caption = 'Data Solicita'#231#227'o:'
        end
        object EditDataDesejadaInicio: TLabeledDateEdit
          Left = 143
          Top = 274
          Width = 121
          Height = 21
          TabOrder = 12
          DateEditLabel.Width = 103
          DateEditLabel.Height = 13
          DateEditLabel.Caption = 'Data Desejada In'#237'cio:'
        end
        object ComboBoxStatusSolicitacao: TLabeledComboBox
          Left = 351
          Top = 274
          Width = 110
          Height = 21
          Style = csDropDownList
          ItemIndex = 0
          TabOrder = 14
          Text = 'Aguardando'
          Items.Strings = (
            'Aguardando'
            'Deferido'
            'Indeferido')
          ComboBoxLabel.Width = 35
          ComboBoxLabel.Height = 13
          ComboBoxLabel.Caption = 'Status:'
        end
        object RadioGroupTipoContratacao: TRadioGroup
          Left = 16
          Top = 22
          Width = 134
          Height = 60
          Caption = 'Tipo Contrata'#231#227'o:'
          Items.Strings = (
            'Servi'#231'o Prestado'
            'Servi'#231'o Contratado')
          TabOrder = 15
          OnClick = RadioGroupTipoContratacaoClick
        end
        object EditDescricao: TLabeledEdit
          Left = 16
          Top = 232
          Width = 848
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          EditLabel.Width = 46
          EditLabel.Height = 13
          EditLabel.Caption = 'Descri'#231#227'o'
          TabOrder = 10
          ExplicitWidth = 737
        end
      end
    end
  end
  inherited PanelToolBar: TPanel
    Width = 893
    ExplicitWidth = 930
    inherited BotaoSair: TSpeedButton
      Left = 789
      ExplicitLeft = 826
    end
    inherited BotaoExportar: TSpeedButton
      Left = 689
      ExplicitLeft = 726
    end
    inherited BotaoImprimir: TSpeedButton
      Left = 589
      ExplicitLeft = 626
    end
    inherited BotaoSeparador1: TSpeedButton
      Left = 479
      ExplicitLeft = 516
    end
    inherited BotaoFiltrar: TSpeedButton
      Left = 489
      ExplicitLeft = 526
    end
  end
end
