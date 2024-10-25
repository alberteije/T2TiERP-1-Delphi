inherited FFinParcelaRecebimento: TFFinParcelaRecebimento
  Tag = 1
  Left = 324
  Top = 157
  Caption = 'Recebimento'
  ClientHeight = 498
  ClientWidth = 958
  ExplicitLeft = 324
  ExplicitTop = 157
  ExplicitWidth = 966
  ExplicitHeight = 532
  PixelsPerInch = 96
  TextHeight = 13
  inherited PageControl: TPageControl
    Width = 958
    Height = 467
    ActivePage = PaginaEdits
    ExplicitWidth = 909
    ExplicitHeight = 467
    inherited PaginaGrid: TTabSheet
      ExplicitWidth = 901
      inherited PanelGrid: TPanel
        Width = 950
        Height = 439
        ExplicitWidth = 901
        ExplicitHeight = 439
        inherited Grid: TJvDBUltimGrid
          Width = 950
          Height = 387
          OnCellClick = GridCellClick
          OnDrawColumnCell = GridDrawColumnCell
        end
        inherited PanelFiltroRapido: TPanel
          Top = 387
          Width = 950
          ExplicitTop = 387
          ExplicitWidth = 901
          inherited BotaoConsultar: TSpeedButton
            Left = 818
            ExplicitLeft = 825
          end
          inherited EditCriterioRapido: TLabeledMaskEdit
            Width = 438
            ExplicitWidth = 438
          end
          object GroupBox1: TGroupBox
            Left = 602
            Top = 8
            Width = 210
            Height = 40
            Anchors = [akTop, akRight]
            Caption = 'Vencimento entre:'
            TabOrder = 2
            object Label1: TLabel
              Left = 104
              Top = 20
              Width = 6
              Height = 13
              Caption = 'e'
            end
            object EditDataInicio: TLabeledDateEdit
              Left = 8
              Top = 15
              Width = 90
              Height = 21
              TabOrder = 0
              DateEditLabel.Width = 3
              DateEditLabel.Height = 13
              DateEditLabel.Caption = ' '
            end
            object EditDataFim: TLabeledDateEdit
              Left = 115
              Top = 15
              Width = 90
              Height = 21
              TabOrder = 1
              DateEditLabel.Width = 3
              DateEditLabel.Height = 13
              DateEditLabel.Caption = ' '
            end
          end
        end
      end
    end
    inherited PaginaEdits: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 24
      ExplicitWidth = 950
      ExplicitHeight = 407
      inherited PanelEdits: TPanel
        Width = 950
        Height = 439
        ExplicitWidth = 950
        ExplicitHeight = 439
        object BevelEdits: TBevel
          Left = 9
          Top = 12
          Width = 926
          Height = 418
          Anchors = [akLeft, akTop, akRight, akBottom]
          Constraints.MinWidth = 753
          ExplicitHeight = 386
        end
        object PanelEditsInterno: TPanel
          Left = 18
          Top = 21
          Width = 907
          Height = 180
          Anchors = [akLeft, akTop, akRight]
          BevelOuter = bvLowered
          TabOrder = 0
          DesignSize = (
            907
            180)
          object EditDataRecebimento: TLabeledDateEdit
            Left = 119
            Top = 70
            Width = 100
            Height = 21
            TabOrder = 7
            DateEditLabel.Width = 66
            DateEditLabel.Height = 13
            DateEditLabel.Caption = 'Recebimento:'
          end
          object EditTaxaJuro: TLabeledCalcEdit
            Left = 331
            Top = 70
            Width = 50
            Height = 21
            DisplayFormat = '0.00'
            ShowButton = False
            TabOrder = 9
            DecimalPlacesAlwaysShown = True
            OnExit = CalcularTotalPago
            CalcEditLabel.Width = 30
            CalcEditLabel.Height = 13
            CalcEditLabel.Caption = 'Juros:'
          end
          object EditValorJuro: TLabeledCalcEdit
            Left = 381
            Top = 70
            Width = 100
            Height = 21
            DisplayFormat = '0.00'
            ShowButton = False
            TabOrder = 10
            DecimalPlacesAlwaysShown = True
            OnExit = CalcularTotalPago
            CalcEditLabel.Width = 3
            CalcEditLabel.Height = 13
            CalcEditLabel.Caption = ' '
          end
          object EditValorMulta: TLabeledCalcEdit
            Left = 537
            Top = 70
            Width = 100
            Height = 21
            DisplayFormat = '0.00'
            ShowButton = False
            TabOrder = 12
            DecimalPlacesAlwaysShown = False
            OnExit = CalcularTotalPago
            CalcEditLabel.Width = 3
            CalcEditLabel.Height = 13
            CalcEditLabel.Caption = ' '
          end
          object EditValorDesconto: TLabeledCalcEdit
            Left = 693
            Top = 70
            Width = 100
            Height = 21
            DisplayFormat = '0.00'
            ShowButton = False
            TabOrder = 14
            DecimalPlacesAlwaysShown = False
            OnExit = CalcularTotalPago
            CalcEditLabel.Width = 3
            CalcEditLabel.Height = 13
            CalcEditLabel.Caption = ' '
          end
          object EditTaxaDesconto: TLabeledCalcEdit
            Left = 643
            Top = 70
            Width = 50
            Height = 21
            DisplayFormat = '0.00'
            ShowButton = False
            TabOrder = 13
            DecimalPlacesAlwaysShown = False
            OnExit = CalcularTotalPago
            CalcEditLabel.Width = 49
            CalcEditLabel.Height = 13
            CalcEditLabel.Caption = 'Desconto:'
          end
          object EditTaxaMulta: TLabeledCalcEdit
            Left = 487
            Top = 70
            Width = 50
            Height = 21
            DisplayFormat = '0.00'
            ShowButton = False
            TabOrder = 11
            DecimalPlacesAlwaysShown = False
            OnExit = CalcularTotalPago
            CalcEditLabel.Width = 30
            CalcEditLabel.Height = 13
            CalcEditLabel.Caption = 'Multa:'
          end
          object MemoHistorico: TLabeledMemo
            Left = 9
            Top = 115
            Width = 890
            Height = 54
            Anchors = [akLeft, akTop, akRight]
            ScrollBars = ssVertical
            TabOrder = 16
            MemoLabel.Width = 45
            MemoLabel.Height = 13
            MemoLabel.Caption = 'Hist'#243'rico:'
          end
          object EditIdTipoRecebimento: TLabeledCalcEdit
            Left = 86
            Top = 24
            Width = 61
            Height = 21
            DisplayFormat = '#'
            ShowButton = False
            TabOrder = 1
            DecimalPlacesAlwaysShown = False
            OnExit = EditIdTipoRecebimentoExit
            OnKeyDown = EditIdTipoRecebimentoKeyDown
            OnKeyPress = EditIdTipoRecebimentoKeyPress
            CalcEditLabel.Width = 112
            CalcEditLabel.Height = 13
            CalcEditLabel.Caption = 'Tipo Recebimento [F1]:'
          end
          object EditCodigoTipoRecebimento: TLabeledEdit
            Left = 147
            Top = 24
            Width = 60
            Height = 21
            TabStop = False
            Color = clInfoBk
            EditLabel.Width = 6
            EditLabel.Height = 13
            EditLabel.Caption = '  '
            ReadOnly = True
            TabOrder = 2
          end
          object EditTipoRecebimento: TLabeledEdit
            Left = 207
            Top = 24
            Width = 270
            Height = 21
            TabStop = False
            Color = clInfoBk
            EditLabel.Width = 6
            EditLabel.Height = 13
            EditLabel.Caption = '  '
            ReadOnly = True
            TabOrder = 3
          end
          object EditIdContaCaixa: TLabeledCalcEdit
            Left = 483
            Top = 24
            Width = 61
            Height = 21
            DisplayFormat = '#'
            ShowButton = False
            TabOrder = 4
            DecimalPlacesAlwaysShown = False
            OnExit = EditIdContaCaixaExit
            OnKeyDown = EditIdContaCaixaKeyDown
            OnKeyPress = EditIdContaCaixaKeyPress
            CalcEditLabel.Width = 86
            CalcEditLabel.Height = 13
            CalcEditLabel.Caption = 'Conta Caixa [F1]:'
          end
          object EditContaCaixa: TLabeledEdit
            Left = 544
            Top = 24
            Width = 355
            Height = 21
            TabStop = False
            Anchors = [akLeft, akTop, akRight]
            Color = clInfoBk
            EditLabel.Width = 6
            EditLabel.Height = 13
            EditLabel.Caption = '  '
            ReadOnly = True
            TabOrder = 5
          end
          object EditValorRecebido: TLabeledCalcEdit
            Left = 799
            Top = 70
            Width = 100
            Height = 21
            DisplayFormat = '0.00'
            ShowButton = False
            TabOrder = 15
            DecimalPlacesAlwaysShown = False
            CalcEditLabel.Width = 75
            CalcEditLabel.Height = 13
            CalcEditLabel.Caption = 'Valor Recebido:'
          end
          object EditValorAReceber: TLabeledCalcEdit
            Left = 225
            Top = 70
            Width = 100
            Height = 21
            DisplayFormat = '0.00'
            ReadOnly = True
            ShowButton = False
            TabOrder = 8
            DecimalPlacesAlwaysShown = False
            OnExit = CalcularTotalPago
            CalcEditLabel.Width = 80
            CalcEditLabel.Height = 13
            CalcEditLabel.Caption = 'Valor a Receber:'
          end
          object EditDataVencimento: TLabeledDateEdit
            Left = 9
            Top = 70
            Width = 104
            Height = 21
            TabOrder = 6
            DateEditLabel.Width = 59
            DateEditLabel.Height = 13
            DateEditLabel.Caption = 'Vencimento:'
          end
          object ComboBoxTipoBaixa: TLabeledComboBox
            Left = 9
            Top = 24
            Width = 71
            Height = 21
            Style = csDropDownList
            ItemIndex = 0
            TabOrder = 0
            Text = 'Total'
            Items.Strings = (
              'Total'
              'Parcial')
            ComboBoxLabel.Width = 53
            ComboBoxLabel.Height = 13
            ComboBoxLabel.Caption = 'Tipo Baixa:'
          end
        end
        object PanelParcelaPaga: TPanel
          Left = 18
          Top = 211
          Width = 907
          Height = 210
          Anchors = [akLeft, akTop, akRight, akBottom]
          BevelOuter = bvLowered
          TabOrder = 1
          object GridRecebimentos: TJvDBUltimGrid
            Left = 1
            Top = 25
            Width = 905
            Height = 158
            Align = alClient
            DataSource = DSParcelaRecebimento
            PopupMenu = PopupMenuExluiParcela
            ReadOnly = True
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'Tahoma'
            TitleFont.Style = []
            TitleButtons = True
            AlternateRowColor = 15593713
            TitleArrow = True
            SelectColumnsDialogStrings.Caption = 'Select columns'
            SelectColumnsDialogStrings.OK = '&OK'
            SelectColumnsDialogStrings.NoSelectionWarning = 'At least one column must be visible!'
            CanDelete = False
            EditControls = <>
            RowsHeight = 17
            TitleRowHeight = 17
            SortWith = swFields
            Columns = <
              item
                Expanded = False
                FieldName = 'CHEQUE.NUMERO'
                Title.Caption = 'N'#250'mero do Cheque'
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'CONTA_CAIXA.NOME'
                Title.Caption = 'Conta Caixa'
                Width = 300
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'TIPO_RECEBIMENTO.DESCRICAO'
                Title.Caption = 'Tipo Recebimento'
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'DATA_RECEBIMENTO'
                Title.Caption = 'Data Recebimento'
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'TAXA_JURO'
                Title.Caption = 'Taxa Juros'
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'VALOR_JURO'
                Title.Caption = 'Valor Juros'
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'TAXA_MULTA'
                Title.Caption = 'Taxa Multa'
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'VALOR_MULTA'
                Title.Caption = 'Valor Multa'
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'TAXA_DESCONTO'
                Title.Caption = 'Taxa Desconto'
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'VALOR_DESCONTO'
                Title.Caption = 'Valor Desconto'
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'VALOR_RECEBIDO'
                Title.Caption = 'Valor Pago'
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'HISTORICO'
                Title.Caption = 'Hist'#243'rico'
                Width = 300
                Visible = True
              end>
          end
          object ActionToolBar1: TActionToolBar
            Left = 1
            Top = 1
            Width = 905
            Height = 24
            ActionManager = ActionManager
            Caption = 'ActionToolBar1'
            ColorMap.BtnSelectedColor = clBtnFace
            ColorMap.UnusedColor = 15660791
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            Orientation = boRightToLeft
            ParentFont = False
            Spacing = 0
          end
          object PanelTotaisPagos: TPanel
            Left = 1
            Top = 183
            Width = 905
            Height = 26
            Align = alBottom
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 2
          end
        end
      end
    end
  end
  inherited PanelToolBar: TPanel
    Width = 958
    ExplicitWidth = 909
    inherited BotaoSair: TSpeedButton
      Left = 854
      ExplicitLeft = 889
    end
    inherited BotaoExportar: TSpeedButton
      Left = 754
      ExplicitLeft = 799
    end
    inherited BotaoImprimir: TSpeedButton
      Left = 644
      ExplicitLeft = 719
    end
    inherited BotaoSeparador1: TSpeedButton
      Left = 744
      ExplicitLeft = 895
      ExplicitTop = -4
    end
    inherited BotaoInserir: TSpeedButton
      ExplicitLeft = 337
    end
    inherited BotaoAlterar: TSpeedButton
      ExplicitLeft = 437
    end
    inherited BotaoExcluir: TSpeedButton
      ExplicitLeft = 537
    end
    inherited BotaoCancelar: TSpeedButton
      ExplicitLeft = 637
    end
    inherited BotaoSalvar: TSpeedButton
      ExplicitLeft = 737
    end
    inherited BotaoFiltrar: TSpeedButton
      Left = 544
      ExplicitLeft = 639
    end
  end
  inherited PopupMenuExportar: TPopupMenu
    Left = 424
  end
  inherited PopupMenuAtalhosBotoesTela: TPopupMenu
    Left = 556
  end
  inherited PopupMenuAtalhosBotoesTelaCadastro: TPopupMenu
    Left = 272
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
      end
      item
        Items = <
          item
            Action = ActionBaixarParcela
            Caption = '&Baixar Parcela'
            ImageIndex = 30
          end>
        ActionBar = ActionToolBar1
      end>
    DisabledImages = FDataModule.ImagensCadastrosD
    Images = FDataModule.ImagensCadastros
    Left = 728
    Top = 328
    StyleName = 'Ribbon - Silver'
    object ActionBaixarParcela: TAction
      Category = 'Recebimentos'
      Caption = 'Baixar Parcela'
      ImageIndex = 30
      OnExecute = ActionBaixarParcelaExecute
    end
  end
  object DSParcelaRecebimento: TDataSource
    DataSet = CDSParcelaRecebimento
    Left = 304
    Top = 312
  end
  object CDSParcelaRecebimento: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'ID'
        DataType = ftInteger
      end
      item
        Name = 'ID_FIN_PARCELA_RECEBER'
        DataType = ftInteger
      end
      item
        Name = 'ID_FIN_CHEQUE_RECEBIDO'
        DataType = ftInteger
      end
      item
        Name = 'ID_FIN_TIPO_RECEBIMENTO'
        DataType = ftInteger
      end
      item
        Name = 'ID_CONTA_CAIXA'
        DataType = ftInteger
      end
      item
        Name = 'DATA_RECEBIMENTO'
        DataType = ftDate
      end
      item
        Name = 'TAXA_JURO'
        DataType = ftFMTBcd
        Precision = 15
        Size = 6
      end
      item
        Name = 'TAXA_MULTA'
        DataType = ftFMTBcd
        Precision = 15
        Size = 6
      end
      item
        Name = 'TAXA_DESCONTO'
        DataType = ftFMTBcd
        Precision = 15
        Size = 6
      end
      item
        Name = 'VALOR_JURO'
        DataType = ftFMTBcd
        Precision = 15
        Size = 6
      end
      item
        Name = 'VALOR_MULTA'
        DataType = ftFMTBcd
        Precision = 15
        Size = 6
      end
      item
        Name = 'VALOR_DESCONTO'
        DataType = ftFMTBcd
        Precision = 15
        Size = 6
      end
      item
        Name = 'VALOR_RECEBIDO'
        DataType = ftFMTBcd
        Precision = 15
        Size = 6
      end
      item
        Name = 'CONTA_CAIXA.NOME'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'TIPO_RECEBIMENTO.DESCRICAO'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'CHEQUE.NUMERO'
        DataType = ftInteger
      end
      item
        Name = 'HISTORICO'
        DataType = ftString
        Size = 250
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 304
    Top = 360
    Data = {
      880200009619E0BD020000001800000011000000000003000000880202494404
      000100000000001649445F46494E5F50415243454C415F524543454245520400
      0100000000001649445F46494E5F4348455155455F524543454249444F040001
      00000000001749445F46494E5F5449504F5F5245434542494D454E544F040001
      00000000000E49445F434F4E54415F4341495841040001000000000010444154
      415F5245434542494D454E544F040006000000000009544158415F4A55524F0A
      0012000000020008444543494D414C5302000200060005574944544802000200
      0F000A544158415F4D554C54410A0012000000020008444543494D414C530200
      02000600055749445448020002000F000D544158415F444553434F4E544F0A00
      12000000020008444543494D414C53020002000600055749445448020002000F
      000A56414C4F525F4A55524F0A0012000000020008444543494D414C53020002
      000600055749445448020002000F000B56414C4F525F4D554C54410A00120000
      00020008444543494D414C53020002000600055749445448020002000F000E56
      414C4F525F444553434F4E544F0A0012000000020008444543494D414C530200
      02000600055749445448020002000F000E56414C4F525F524543454249444F0A
      0012000000020008444543494D414C5302000200060005574944544802000200
      0F0010434F4E54415F43414958412E4E4F4D4501004900000001000557494454
      480200020064001A5449504F5F5245434542494D454E544F2E44455343524943
      414F0100490000000100055749445448020002001E000D4348455155452E4E55
      4D45524F040001000000000009484953544F5249434F01004900000001000557
      4944544802000200FA000000}
    object CDSParcelaRecebimentoID: TIntegerField
      FieldName = 'ID'
    end
    object CDSParcelaRecebimentoID_FIN_PARCELA_RECEBER: TIntegerField
      FieldName = 'ID_FIN_PARCELA_RECEBER'
    end
    object CDSParcelaRecebimentoID_FIN_CHEQUE_RECEBIDO: TIntegerField
      FieldName = 'ID_FIN_CHEQUE_RECEBIDO'
    end
    object CDSParcelaRecebimentoID_FIN_TIPO_RECEBIMENTO: TIntegerField
      FieldName = 'ID_FIN_TIPO_RECEBIMENTO'
    end
    object CDSParcelaRecebimentoID_CONTA_CAIXA: TIntegerField
      FieldName = 'ID_CONTA_CAIXA'
    end
    object CDSParcelaRecebimentoDATA_RECEBIMENTO: TDateField
      FieldName = 'DATA_RECEBIMENTO'
    end
    object CDSParcelaRecebimentoTAXA_JURO: TFMTBCDField
      FieldName = 'TAXA_JURO'
      Precision = 15
      Size = 6
    end
    object CDSParcelaRecebimentoTAXA_MULTA: TFMTBCDField
      FieldName = 'TAXA_MULTA'
      Precision = 15
      Size = 6
    end
    object CDSParcelaRecebimentoTAXA_DESCONTO: TFMTBCDField
      FieldName = 'TAXA_DESCONTO'
      Precision = 15
      Size = 6
    end
    object CDSParcelaRecebimentoVALOR_JURO: TFMTBCDField
      FieldName = 'VALOR_JURO'
      Precision = 15
      Size = 6
    end
    object CDSParcelaRecebimentoVALOR_MULTA: TFMTBCDField
      FieldName = 'VALOR_MULTA'
      Precision = 15
      Size = 6
    end
    object CDSParcelaRecebimentoVALOR_DESCONTO: TFMTBCDField
      FieldName = 'VALOR_DESCONTO'
      Precision = 15
      Size = 6
    end
    object CDSParcelaRecebimentoVALOR_RECEBIDO: TFMTBCDField
      FieldName = 'VALOR_RECEBIDO'
      Precision = 15
      Size = 6
    end
    object CDSParcelaRecebimentoCONTA_CAIXANOME: TStringField
      FieldName = 'CONTA_CAIXA.NOME'
      Size = 100
    end
    object CDSParcelaRecebimentoTIPO_RECEBIMENTODESCRICAO: TStringField
      FieldName = 'TIPO_RECEBIMENTO.DESCRICAO'
      Size = 30
    end
    object CDSParcelaRecebimentoCHEQUENUMERO: TIntegerField
      FieldName = 'CHEQUE.NUMERO'
    end
    object CDSParcelaRecebimentoHISTORICO: TStringField
      FieldName = 'HISTORICO'
      Size = 250
    end
  end
  object PopupMenuExluiParcela: TPopupMenu
    Images = FDataModule.ImagensCadastros
    Left = 838
    Top = 346
    object ExcluirParcelaPaga1: TMenuItem
      Caption = 'Excluir Parcela Paga'
      ImageIndex = 10
      OnClick = ExcluirParcelaPaga1Click
    end
  end
end
