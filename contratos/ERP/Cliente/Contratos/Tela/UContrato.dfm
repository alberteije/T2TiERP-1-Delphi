inherited FContrato: TFContrato
  Left = 318
  Top = 152
  Caption = 'Contrato'
  ClientHeight = 525
  ExplicitLeft = 318
  ExplicitTop = 152
  ExplicitWidth = 1000
  ExplicitHeight = 559
  PixelsPerInch = 96
  TextHeight = 13
  inherited PageControl: TPageControl
    Height = 494
    ActivePage = PaginaEdits
    ExplicitWidth = 997
    ExplicitHeight = 475
    inherited PaginaGrid: TTabSheet
      ExplicitWidth = 989
      ExplicitHeight = 447
      inherited PanelGrid: TPanel
        Height = 466
        ExplicitWidth = 989
        ExplicitHeight = 447
        inherited Grid: TJvDBUltimGrid
          Height = 414
        end
        inherited PanelFiltroRapido: TPanel
          Top = 414
          ExplicitTop = 395
          ExplicitWidth = 989
          inherited BotaoConsultar: TSpeedButton
            Left = 852
            ExplicitLeft = 857
          end
          inherited EditCriterioRapido: TLabeledMaskEdit
            Width = 683
            ExplicitWidth = 688
          end
        end
      end
    end
    inherited PaginaEdits: TTabSheet
      ExplicitWidth = 989
      ExplicitHeight = 447
      inherited PanelEdits: TPanel
        Height = 466
        ExplicitWidth = 989
        ExplicitHeight = 447
        object ScrollBox: TScrollBox
          Left = 4
          Top = 4
          Width = 976
          Height = 458
          Align = alClient
          BevelInner = bvNone
          BevelOuter = bvNone
          BorderStyle = bsNone
          TabOrder = 0
          ExplicitWidth = 844
          ExplicitHeight = 481
          DesignSize = (
            976
            458)
          object BevelEdits: TBevel
            Left = 7
            Top = 39
            Width = 959
            Height = 137
            Anchors = [akLeft, akTop, akRight, akBottom]
            Constraints.MinWidth = 753
          end
          object EditNome: TLabeledEdit
            Left = 316
            Top = 147
            Width = 639
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            EditLabel.Width = 31
            EditLabel.Height = 13
            EditLabel.Caption = 'Nome:'
            MaxLength = 100
            TabOrder = 7
          end
          object EditNumero: TLabeledEdit
            Left = 16
            Top = 147
            Width = 294
            Height = 21
            EditLabel.Width = 41
            EditLabel.Height = 13
            EditLabel.Caption = 'N'#250'mero:'
            MaxLength = 50
            TabOrder = 6
          end
          object PageControlDadosContrato: TPageControl
            Left = 7
            Top = 186
            Width = 959
            Height = 263
            ActivePage = tsPrevisaoFaturamento
            Anchors = [akLeft, akTop, akRight, akBottom]
            TabOrder = 8
            object tsDadosComplementares: TTabSheet
              Caption = 'Dados Complementares'
              object PanelDadosComplementares: TPanel
                Left = 0
                Top = 0
                Width = 951
                Height = 235
                Align = alClient
                BevelOuter = bvNone
                TabOrder = 0
                DesignSize = (
                  951
                  235)
                object EditDataCadastro: TLabeledDateEdit
                  Left = 5
                  Top = 26
                  Width = 100
                  Height = 21
                  TabOrder = 0
                  DateEditLabel.Width = 74
                  DateEditLabel.Height = 13
                  DateEditLabel.Caption = 'Data Cadastro:'
                end
                object MemoDescricao: TLabeledMemo
                  Left = 5
                  Top = 73
                  Width = 940
                  Height = 65
                  Anchors = [akLeft, akTop, akRight]
                  TabOrder = 7
                  MemoLabel.Width = 50
                  MemoLabel.Height = 13
                  MemoLabel.Caption = 'Descri'#231#227'o:'
                end
                object EditDataInicioVigencia: TLabeledDateEdit
                  Left = 111
                  Top = 26
                  Width = 100
                  Height = 21
                  TabOrder = 1
                  DateEditLabel.Width = 71
                  DateEditLabel.Height = 13
                  DateEditLabel.Caption = 'In'#237'cio Vig'#234'ncia:'
                end
                object EditDataFimVigencia: TLabeledDateEdit
                  Left = 217
                  Top = 26
                  Width = 100
                  Height = 21
                  TabOrder = 2
                  DateEditLabel.Width = 62
                  DateEditLabel.Height = 13
                  DateEditLabel.Caption = 'Fim Vig'#234'ncia:'
                end
                object EditDiaFaturamento: TLabeledMaskEdit
                  Left = 323
                  Top = 26
                  Width = 86
                  Height = 21
                  Alignment = taCenter
                  EditLabel.Width = 84
                  EditLabel.Height = 13
                  EditLabel.Caption = 'Dia Faturamento:'
                  MaxLength = 2
                  TabOrder = 3
                  Text = '__'
                  Required = False
                  EditMask = '##;1;_'
                  MaskState = [msMasked]
                end
                object EditValor: TLabeledCalcEdit
                  Left = 415
                  Top = 26
                  Width = 121
                  Height = 21
                  DisplayFormat = '###,###,##0.00'
                  TabOrder = 4
                  DecimalPlacesAlwaysShown = False
                  CalcEditLabel.Width = 28
                  CalcEditLabel.Height = 13
                  CalcEditLabel.Caption = 'Valor:'
                end
                object EditQuantidadeParcelas: TLabeledCalcEdit
                  Left = 542
                  Top = 26
                  Width = 105
                  Height = 21
                  ShowButton = False
                  TabOrder = 5
                  DecimalPlacesAlwaysShown = False
                  CalcEditLabel.Width = 103
                  CalcEditLabel.Height = 13
                  CalcEditLabel.Caption = 'Quantidade Parcelas:'
                end
                object EditIntervaloEntreParcelas: TLabeledCalcEdit
                  Left = 653
                  Top = 26
                  Width = 105
                  Height = 21
                  ShowButton = False
                  TabOrder = 6
                  DecimalPlacesAlwaysShown = False
                  CalcEditLabel.Width = 91
                  CalcEditLabel.Height = 13
                  CalcEditLabel.Caption = 'Intervalo Parcelas:'
                end
                object MemoObservacao: TLabeledMemo
                  Left = 5
                  Top = 161
                  Width = 940
                  Height = 65
                  Anchors = [akLeft, akTop, akRight]
                  TabOrder = 8
                  MemoLabel.Width = 62
                  MemoLabel.Height = 13
                  MemoLabel.Caption = 'Observa'#231#227'o:'
                end
              end
            end
            object tsHistoricoFaturamento: TTabSheet
              Caption = 'Hist'#243'rico Faturamento'
              ImageIndex = 2
              ExplicitLeft = 0
              ExplicitTop = 0
              ExplicitWidth = 0
              ExplicitHeight = 0
              object PanelHistoricoFaturamento: TPanel
                Left = 0
                Top = 0
                Width = 951
                Height = 235
                Align = alClient
                BevelOuter = bvNone
                TabOrder = 0
                object GridHistoricoFaturamento: TJvDBUltimGrid
                  Left = 0
                  Top = 0
                  Width = 951
                  Height = 235
                  Align = alClient
                  DataSource = DSHistoricoFaturamento
                  TabOrder = 0
                  TitleFont.Charset = DEFAULT_CHARSET
                  TitleFont.Color = clWindowText
                  TitleFont.Height = -11
                  TitleFont.Name = 'Tahoma'
                  TitleFont.Style = []
                  OnKeyDown = GridHistoricoFaturamentoKeyDown
                  AlternateRowColor = 15593713
                  SelectColumnsDialogStrings.Caption = 'Select columns'
                  SelectColumnsDialogStrings.OK = '&OK'
                  SelectColumnsDialogStrings.NoSelectionWarning = 'At least one column must be visible!'
                  EditControls = <>
                  RowsHeight = 17
                  TitleRowHeight = 17
                  Columns = <
                    item
                      Expanded = False
                      FieldName = 'DATA_FATURA'
                      Title.Caption = 'Data Fatura'
                      Visible = True
                    end
                    item
                      Expanded = False
                      FieldName = 'VALOR'
                      Title.Caption = 'Valor'
                      Visible = True
                    end>
                end
              end
            end
            object tsHistoricoReajuste: TTabSheet
              Caption = 'Hist'#243'rico Reajuste'
              ImageIndex = 2
              ExplicitLeft = 0
              ExplicitTop = 0
              ExplicitWidth = 0
              ExplicitHeight = 0
              object PanelHistoricoReajuste: TPanel
                Left = 0
                Top = 0
                Width = 951
                Height = 235
                Align = alClient
                BevelOuter = bvNone
                TabOrder = 0
                object GridHistoricoReajuste: TJvDBUltimGrid
                  Left = 0
                  Top = 0
                  Width = 951
                  Height = 235
                  Align = alClient
                  DataSource = DSHistoricoReajuste
                  TabOrder = 0
                  TitleFont.Charset = DEFAULT_CHARSET
                  TitleFont.Color = clWindowText
                  TitleFont.Height = -11
                  TitleFont.Name = 'Tahoma'
                  TitleFont.Style = []
                  OnKeyDown = GridHistoricoReajusteKeyDown
                  AlternateRowColor = 15593713
                  SelectColumnsDialogStrings.Caption = 'Select columns'
                  SelectColumnsDialogStrings.OK = '&OK'
                  SelectColumnsDialogStrings.NoSelectionWarning = 'At least one column must be visible!'
                  EditControls = <>
                  RowsHeight = 17
                  TitleRowHeight = 17
                  Columns = <
                    item
                      Expanded = False
                      FieldName = 'INDICE'
                      Title.Caption = #205'ndice'
                      Visible = True
                    end
                    item
                      Expanded = False
                      FieldName = 'VALOR_ANTERIOR'
                      Title.Caption = 'Valor Anterior'
                      Visible = True
                    end
                    item
                      Expanded = False
                      FieldName = 'VALOR_ATUAL'
                      Title.Caption = 'Valor Atual'
                      Visible = True
                    end
                    item
                      Expanded = False
                      FieldName = 'DATA_REAJUSTE'
                      Title.Caption = 'Data Reajuste'
                      Visible = True
                    end
                    item
                      Expanded = False
                      FieldName = 'OBSERVACAO'
                      Title.Caption = 'Observa'#231#227'o'
                      Width = 400
                      Visible = True
                    end>
                end
              end
            end
            object tsPrevisaoFaturamento: TTabSheet
              Caption = 'Previs'#227'o de Faturamento'
              ImageIndex = 3
              object PanelPrevisaoFaturamento: TPanel
                Left = 0
                Top = 0
                Width = 951
                Height = 235
                Align = alClient
                BevelOuter = bvNone
                TabOrder = 0
                object GridPrevisaoFaturamento: TJvDBUltimGrid
                  Left = 0
                  Top = 26
                  Width = 951
                  Height = 209
                  Align = alClient
                  DataSource = DSPrevisaoFaturamento
                  TabOrder = 0
                  TitleFont.Charset = DEFAULT_CHARSET
                  TitleFont.Color = clWindowText
                  TitleFont.Height = -11
                  TitleFont.Name = 'Tahoma'
                  TitleFont.Style = []
                  OnKeyDown = GridPrevisaoFaturamentoKeyDown
                  AlternateRowColor = 15593713
                  SelectColumnsDialogStrings.Caption = 'Select columns'
                  SelectColumnsDialogStrings.OK = '&OK'
                  SelectColumnsDialogStrings.NoSelectionWarning = 'At least one column must be visible!'
                  EditControls = <>
                  RowsHeight = 17
                  TitleRowHeight = 17
                  Columns = <
                    item
                      Expanded = False
                      FieldName = 'DATA_PREVISTA'
                      Title.Caption = 'Data Prevista'
                      Visible = True
                    end
                    item
                      Expanded = False
                      FieldName = 'VALOR'
                      Title.Caption = 'Valor'
                      Visible = True
                    end>
                end
                object ActionToolBar1: TActionToolBar
                  Left = 0
                  Top = 0
                  Width = 951
                  Height = 26
                  ActionManager = ActionManager1
                  Caption = 'ActionToolBar1'
                  ColorMap.HighlightColor = 15660791
                  ColorMap.BtnSelectedColor = clBtnFace
                  ColorMap.UnusedColor = 15660791
                  Orientation = boRightToLeft
                  Spacing = 0
                  ExplicitHeight = 23
                end
              end
            end
          end
          object EditIdTipoContrato: TLabeledCalcEdit
            Left = 16
            Top = 61
            Width = 61
            Height = 21
            ShowButton = False
            TabOrder = 0
            DecimalPlacesAlwaysShown = False
            OnExit = EditIdTipoContratoExit
            OnKeyDown = EditIdTipoContratoKeyDown
            OnKeyPress = EditIdTipoContratoKeyPress
            CalcEditLabel.Width = 93
            CalcEditLabel.Height = 13
            CalcEditLabel.Caption = 'Tipo Contrato [F1]:'
          end
          object EditTipoContrato: TLabeledEdit
            Left = 77
            Top = 61
            Width = 878
            Height = 21
            TabStop = False
            Anchors = [akLeft, akTop, akRight]
            Color = clInfoBk
            EditLabel.Width = 6
            EditLabel.Height = 13
            EditLabel.Caption = '  '
            ReadOnly = True
            TabOrder = 1
          end
          object EditIdContaContabil: TLabeledCalcEdit
            Left = 16
            Top = 104
            Width = 61
            Height = 21
            ShowButton = False
            TabOrder = 2
            DecimalPlacesAlwaysShown = False
            OnExit = EditIdContaContabilExit
            OnKeyDown = EditIdContaContabilKeyDown
            OnKeyPress = EditIdContaContabilKeyPress
            CalcEditLabel.Width = 98
            CalcEditLabel.Height = 13
            CalcEditLabel.Caption = 'Conta Cont'#225'bil [F1]:'
          end
          object EditContaContabil: TLabeledEdit
            Left = 77
            Top = 104
            Width = 300
            Height = 21
            TabStop = False
            Color = clInfoBk
            EditLabel.Width = 6
            EditLabel.Height = 13
            EditLabel.Caption = '  '
            ReadOnly = True
            TabOrder = 3
          end
          object EditIdSolicitacaoServico: TLabeledCalcEdit
            Left = 383
            Top = 104
            Width = 61
            Height = 21
            ShowButton = False
            TabOrder = 4
            DecimalPlacesAlwaysShown = False
            OnExit = EditIdSolicitacaoServicoExit
            OnKeyDown = EditIdSolicitacaoServicoKeyDown
            OnKeyPress = EditIdSolicitacaoServicoKeyPress
            CalcEditLabel.Width = 77
            CalcEditLabel.Height = 13
            CalcEditLabel.Caption = 'Solicita'#231#227'o [F1]:'
          end
          object EditDescricaoSolicitacao: TLabeledEdit
            Left = 444
            Top = 104
            Width = 511
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
          object ActionToolBar2: TActionToolBar
            Left = 0
            Top = 0
            Width = 976
            Height = 26
            ActionManager = ActionManager1
            Caption = 'ActionToolBar2'
            ColorMap.HighlightColor = 15660791
            ColorMap.BtnSelectedColor = clBtnFace
            ColorMap.UnusedColor = 15660791
            Orientation = boRightToLeft
            Spacing = 0
          end
        end
      end
    end
  end
  inherited PanelToolBar: TPanel
    ExplicitWidth = 997
    inherited BotaoSair: TSpeedButton
      ExplicitLeft = 913
    end
    inherited BotaoExportar: TSpeedButton
      ExplicitLeft = 823
    end
    inherited BotaoImprimir: TSpeedButton
      Left = 678
      ExplicitLeft = 743
    end
    inherited BotaoSeparador1: TSpeedButton
      Left = 778
      ExplicitLeft = 903
    end
    inherited BotaoFiltrar: TSpeedButton
      Left = 578
      ExplicitLeft = 663
    end
  end
  inherited PopupMenuAtalhosBotoesTela: TPopupMenu
    Top = 23
  end
  inherited PopupMenuAtalhosBotoesTelaCadastro: TPopupMenu
    Left = 720
    Top = 24
  end
  object CDSHistoricoFaturamento: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'ID'
        DataType = ftInteger
      end
      item
        Name = 'ID_CONTRATO'
        DataType = ftInteger
      end
      item
        Name = 'DATA_FATURA'
        DataType = ftDate
      end
      item
        Name = 'VALOR'
        DataType = ftFMTBcd
        Precision = 18
        Size = 6
      end
      item
        Name = 'PERSISTE'
        DataType = ftString
        Size = 1
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    AfterEdit = CDSHistoricoFaturamentoAfterEdit
    Left = 96
    Top = 411
    Data = {
      930000009619E0BD020000001800000005000000000003000000930002494404
      000100000000000B49445F434F4E545241544F04000100000000000B44415441
      5F46415455524104000600000000000556414C4F520B00120000000200084445
      43494D414C530200020006000557494454480200020012000850455253495354
      4501004900000001000557494454480200020001000000}
    object CDSHistoricoFaturamentoID: TIntegerField
      FieldName = 'ID'
    end
    object CDSHistoricoFaturamentoID_CONTRATO: TIntegerField
      FieldName = 'ID_CONTRATO'
    end
    object CDSHistoricoFaturamentoDATA_FATURA: TDateField
      FieldName = 'DATA_FATURA'
      EditMask = '##/##/####'
    end
    object CDSHistoricoFaturamentoVALOR: TFMTBCDField
      FieldName = 'VALOR'
      DisplayFormat = '###,###,##0.00'
      Precision = 18
      Size = 6
    end
    object CDSHistoricoFaturamentoPERSISTE: TStringField
      FieldName = 'PERSISTE'
      Size = 1
    end
  end
  object DSHistoricoFaturamento: TDataSource
    DataSet = CDSHistoricoFaturamento
    Left = 93
    Top = 464
  end
  object CDSHistoricoReajuste: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'ID'
        DataType = ftInteger
      end
      item
        Name = 'ID_CONTRATO'
        DataType = ftInteger
      end
      item
        Name = 'INDICE'
        DataType = ftFMTBcd
        Precision = 18
        Size = 6
      end
      item
        Name = 'VALOR_ANTERIOR'
        DataType = ftFMTBcd
        Precision = 18
        Size = 6
      end
      item
        Name = 'VALOR_ATUAL'
        DataType = ftFMTBcd
        Precision = 18
        Size = 6
      end
      item
        Name = 'DATA_REAJUSTE'
        DataType = ftDate
      end
      item
        Name = 'OBSERVACAO'
        DataType = ftString
        Size = 250
      end
      item
        Name = 'PERSISTE'
        DataType = ftString
        Size = 1
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    AfterEdit = CDSHistoricoReajusteAfterEdit
    Left = 224
    Top = 411
    Data = {
      160100009619E0BD020000001800000008000000000003000000160102494404
      000100000000000B49445F434F4E545241544F040001000000000006494E4449
      43450B0012000000020008444543494D414C5302000200060005574944544802
      00020012000E56414C4F525F414E544552494F520B0012000000020008444543
      494D414C530200020006000557494454480200020012000B56414C4F525F4154
      55414C0B0012000000020008444543494D414C53020002000600055749445448
      0200020012000D444154415F5245414A5553544504000600000000000A4F4253
      4552564143414F010049000000010005574944544802000200FA000850455253
      4953544501004900000001000557494454480200020001000000}
    object CDSHistoricoReajusteID: TIntegerField
      FieldName = 'ID'
    end
    object CDSHistoricoReajusteID_CONTRATO: TIntegerField
      FieldName = 'ID_CONTRATO'
    end
    object CDSHistoricoReajusteINDICE: TFMTBCDField
      FieldName = 'INDICE'
      DisplayFormat = '###,###,##0.00'
      Precision = 18
      Size = 6
    end
    object CDSHistoricoReajusteVALOR_ANTERIOR: TFMTBCDField
      FieldName = 'VALOR_ANTERIOR'
      DisplayFormat = '###,###,##0.00'
      Precision = 18
      Size = 6
    end
    object CDSHistoricoReajusteVALOR_ATUAL: TFMTBCDField
      FieldName = 'VALOR_ATUAL'
      DisplayFormat = '###,###,##0.00'
      Precision = 18
      Size = 6
    end
    object CDSHistoricoReajusteDATA_REAJUSTE: TDateField
      FieldName = 'DATA_REAJUSTE'
      EditMask = '##/##/####'
    end
    object CDSHistoricoReajustePERSISTE: TStringField
      FieldName = 'PERSISTE'
      Size = 1
    end
    object CDSHistoricoReajusteOBSERVACAO: TStringField
      FieldName = 'OBSERVACAO'
      Size = 250
    end
  end
  object DSHistoricoReajuste: TDataSource
    DataSet = CDSHistoricoReajuste
    Left = 221
    Top = 464
  end
  object CDSPrevisaoFaturamento: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'ID'
        DataType = ftInteger
      end
      item
        Name = 'ID_CONTRATO'
        DataType = ftInteger
      end
      item
        Name = 'DATA_PREVISTA'
        DataType = ftDate
      end
      item
        Name = 'VALOR'
        DataType = ftFMTBcd
        Precision = 18
        Size = 6
      end
      item
        Name = 'PERSISTE'
        DataType = ftString
        Size = 1
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    AfterEdit = CDSPrevisaoFaturamentoAfterEdit
    Left = 360
    Top = 411
    Data = {
      950000009619E0BD020000001800000005000000000003000000950002494404
      000100000000000B49445F434F4E545241544F04000100000000000D44415441
      5F505245564953544104000600000000000556414C4F520B0012000000020008
      444543494D414C53020002000600055749445448020002001200085045525349
      53544501004900000001000557494454480200020001000000}
    object CDSPrevisaoFaturamentoID: TIntegerField
      FieldName = 'ID'
    end
    object CDSPrevisaoFaturamentoID_CONTRATO: TIntegerField
      FieldName = 'ID_CONTRATO'
    end
    object CDSPrevisaoFaturamentoDATA_PREVISTA: TDateField
      FieldName = 'DATA_PREVISTA'
      EditMask = '##/##/####'
    end
    object CDSPrevisaoFaturamentoVALOR: TFMTBCDField
      FieldName = 'VALOR'
      DisplayFormat = '###,###,##0.00'
      Precision = 18
      Size = 6
    end
    object CDSPrevisaoFaturamentoPERSISTE: TStringField
      FieldName = 'PERSISTE'
      Size = 1
    end
  end
  object DSPrevisaoFaturamento: TDataSource
    DataSet = CDSPrevisaoFaturamento
    Left = 357
    Top = 464
  end
  object ActionManager1: TActionManager
    ActionBars = <
      item
        Items = <
          item
            Action = ActionGerarPrevisaoFaturamento
            Caption = '&Gerar Previs'#227'o Faturamento'
            ImageIndex = 30
          end>
        ActionBar = ActionToolBar1
      end
      item
        Items = <
          item
            Action = ActionGed
            Caption = '&Acionar GED'
            ImageIndex = 26
          end
          item
            Action = ActionContratoDoTemplate
            Caption = '&Contrato Gerado do Template'
            ImageIndex = 17
          end>
        ActionBar = ActionToolBar2
      end>
    DisabledImages = FDataModule.ImagensCadastrosD
    Images = FDataModule.ImagensCadastros
    Left = 788
    Top = 280
    StyleName = 'Platform Default'
    object ActionGerarPrevisaoFaturamento: TAction
      Caption = 'Gerar Previs'#227'o Faturamento'
      ImageIndex = 30
      OnExecute = ActionGerarPrevisaoFaturamentoExecute
    end
    object ActionContratoDoTemplate: TAction
      Caption = 'Contrato Gerado do Template'
      ImageIndex = 17
      OnExecute = ActionContratoDoTemplateExecute
    end
    object ActionGed: TAction
      Caption = 'Acionar GED'
      ImageIndex = 26
      OnExecute = ActionGedExecute
    end
  end
end
