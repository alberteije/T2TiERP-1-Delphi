inherited FPatrimBem: TFPatrimBem
  Left = 313
  Top = 96
  Caption = 'Bem'
  ClientHeight = 581
  ExplicitLeft = 313
  ExplicitTop = 96
  ExplicitWidth = 1000
  ExplicitHeight = 615
  PixelsPerInch = 96
  TextHeight = 13
  inherited PageControl: TPageControl
    Height = 550
    ActivePage = PaginaEdits
    ExplicitWidth = 997
    ExplicitHeight = 475
    inherited PaginaGrid: TTabSheet
      ExplicitWidth = 989
      ExplicitHeight = 447
      inherited PanelGrid: TPanel
        Height = 522
        ExplicitWidth = 989
        ExplicitHeight = 447
        inherited Grid: TJvDBUltimGrid
          Height = 470
        end
        inherited PanelFiltroRapido: TPanel
          Top = 470
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
        Height = 522
        ExplicitWidth = 989
        ExplicitHeight = 447
        object ScrollBox: TScrollBox
          Left = 4
          Top = 4
          Width = 976
          Height = 514
          Align = alClient
          BevelInner = bvNone
          BevelOuter = bvNone
          BorderStyle = bsNone
          TabOrder = 0
          ExplicitWidth = 844
          ExplicitHeight = 481
          DesignSize = (
            976
            514)
          object BevelEdits: TBevel
            Left = 7
            Top = 8
            Width = 959
            Height = 136
            Anchors = [akLeft, akTop, akRight]
            Constraints.MinWidth = 753
          end
          object EditNome: TLabeledEdit
            Left = 384
            Top = 115
            Width = 571
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            EditLabel.Width = 31
            EditLabel.Height = 13
            EditLabel.Caption = 'Nome:'
            MaxLength = 100
            TabOrder = 14
          end
          object EditNumero: TLabeledEdit
            Left = 16
            Top = 115
            Width = 141
            Height = 21
            EditLabel.Width = 65
            EditLabel.Height = 13
            EditLabel.Caption = 'N'#250'mero (NB):'
            MaxLength = 20
            TabOrder = 12
          end
          object PageControlDadosPatrimBem: TPageControl
            Left = 7
            Top = 153
            Width = 959
            Height = 353
            ActivePage = tsDadosComplementares
            Anchors = [akLeft, akTop, akRight, akBottom]
            TabOrder = 15
            object tsDadosComplementares: TTabSheet
              Caption = 'Dados Complementares'
              ExplicitLeft = 0
              ExplicitTop = 0
              ExplicitWidth = 0
              ExplicitHeight = 288
              object PanelDadosComplementares: TPanel
                Left = 0
                Top = 0
                Width = 951
                Height = 325
                Align = alClient
                BevelOuter = bvNone
                TabOrder = 0
                ExplicitWidth = 799
                ExplicitHeight = 288
                DesignSize = (
                  951
                  325)
                object EditDataAquisicao: TLabeledDateEdit
                  Left = 5
                  Top = 79
                  Width = 90
                  Height = 21
                  TabOrder = 1
                  DateEditLabel.Width = 75
                  DateEditLabel.Height = 13
                  DateEditLabel.Caption = 'Data Aquisi'#231#227'o:'
                end
                object MemoDescricao: TLabeledMemo
                  Left = 5
                  Top = 17
                  Width = 940
                  Height = 41
                  Anchors = [akLeft, akTop, akRight]
                  TabOrder = 0
                  MemoLabel.Width = 50
                  MemoLabel.Height = 13
                  MemoLabel.Caption = 'Descri'#231#227'o:'
                end
                object EditDataAceite: TLabeledDateEdit
                  Left = 101
                  Top = 79
                  Width = 90
                  Height = 21
                  TabOrder = 2
                  DateEditLabel.Width = 60
                  DateEditLabel.Height = 13
                  DateEditLabel.Caption = 'Data Aceite:'
                end
                object EditDataCadastro: TLabeledDateEdit
                  Left = 197
                  Top = 79
                  Width = 90
                  Height = 21
                  TabOrder = 3
                  DateEditLabel.Width = 74
                  DateEditLabel.Height = 13
                  DateEditLabel.Caption = 'Data Cadastro:'
                end
                object EditValorOriginal: TLabeledCalcEdit
                  Left = 293
                  Top = 122
                  Width = 121
                  Height = 21
                  DisplayFormat = '###,###,##0.00'
                  TabOrder = 11
                  DecimalPlacesAlwaysShown = False
                  CalcEditLabel.Width = 67
                  CalcEditLabel.Height = 13
                  CalcEditLabel.Caption = 'Valor Original:'
                end
                object MemoFuncao: TLabeledMemo
                  Left = 5
                  Top = 279
                  Width = 940
                  Height = 38
                  Anchors = [akLeft, akTop, akRight, akBottom]
                  TabOrder = 16
                  MemoLabel.Width = 39
                  MemoLabel.Height = 13
                  MemoLabel.Caption = 'Fun'#231#227'o:'
                end
                object EditDataContabilizado: TLabeledDateEdit
                  Left = 293
                  Top = 79
                  Width = 90
                  Height = 21
                  TabOrder = 4
                  DateEditLabel.Width = 94
                  DateEditLabel.Height = 13
                  DateEditLabel.Caption = 'Data Contabilizado:'
                end
                object EditDataVistoria: TLabeledDateEdit
                  Left = 389
                  Top = 79
                  Width = 90
                  Height = 21
                  TabOrder = 5
                  DateEditLabel.Width = 65
                  DateEditLabel.Height = 13
                  DateEditLabel.Caption = 'Data Vistoria:'
                end
                object EditDataMarcacao: TLabeledDateEdit
                  Left = 485
                  Top = 79
                  Width = 90
                  Height = 21
                  TabOrder = 6
                  DateEditLabel.Width = 76
                  DateEditLabel.Height = 13
                  DateEditLabel.Caption = 'Data Marca'#231#227'o:'
                end
                object EditDataBaixa: TLabeledDateEdit
                  Left = 581
                  Top = 79
                  Width = 90
                  Height = 21
                  TabOrder = 7
                  DateEditLabel.Width = 56
                  DateEditLabel.Height = 13
                  DateEditLabel.Caption = 'Data Baixa:'
                end
                object EditDataVencimentoGarantia: TLabeledDateEdit
                  Left = 677
                  Top = 79
                  Width = 116
                  Height = 21
                  TabOrder = 8
                  DateEditLabel.Width = 104
                  DateEditLabel.Height = 13
                  DateEditLabel.Caption = 'Vencimento/Garantia:'
                end
                object EditNumeroNF: TLabeledEdit
                  Left = 5
                  Top = 122
                  Width = 100
                  Height = 21
                  EditLabel.Width = 57
                  EditLabel.Height = 13
                  EditLabel.Caption = 'N'#250'mero NF:'
                  MaxLength = 50
                  TabOrder = 9
                end
                object EditChaveNFe: TLabeledEdit
                  Left = 111
                  Top = 122
                  Width = 176
                  Height = 21
                  EditLabel.Width = 61
                  EditLabel.Height = 13
                  EditLabel.Caption = 'Chave NF-e:'
                  MaxLength = 44
                  TabOrder = 10
                end
                object EditValorCompra: TLabeledCalcEdit
                  Left = 420
                  Top = 122
                  Width = 121
                  Height = 21
                  DisplayFormat = '###,###,##0.00'
                  TabOrder = 12
                  DecimalPlacesAlwaysShown = False
                  CalcEditLabel.Width = 68
                  CalcEditLabel.Height = 13
                  CalcEditLabel.Caption = 'Valor Compra:'
                end
                object EditValorAtualizado: TLabeledCalcEdit
                  Left = 547
                  Top = 122
                  Width = 121
                  Height = 21
                  DisplayFormat = '###,###,##0.00'
                  TabOrder = 13
                  DecimalPlacesAlwaysShown = False
                  CalcEditLabel.Width = 81
                  CalcEditLabel.Height = 13
                  CalcEditLabel.Caption = 'Valor Atualizado:'
                end
                object GroupBoxDepreciacao: TGroupBox
                  Left = 5
                  Top = 150
                  Width = 940
                  Height = 103
                  Anchors = [akLeft, akTop, akRight]
                  Caption = 'Deprecia'#231#227'o:'
                  TabOrder = 15
                  ExplicitWidth = 788
                  object ComboDeprecia: TLabeledComboBox
                    Left = 8
                    Top = 31
                    Width = 61
                    Height = 21
                    Style = csDropDownList
                    ItemIndex = 0
                    TabOrder = 0
                    Text = 'Sim'
                    Items.Strings = (
                      'Sim'
                      'N'#227'o')
                    ComboBoxLabel.Width = 47
                    ComboBoxLabel.Height = 13
                    ComboBoxLabel.Caption = 'Deprecia?'
                  end
                  object ComboMetodoDepreciacao: TLabeledComboBox
                    Left = 75
                    Top = 31
                    Width = 189
                    Height = 21
                    Style = csDropDownList
                    ItemIndex = 0
                    TabOrder = 1
                    Text = '1 - Linear'
                    Items.Strings = (
                      '1 - Linear'
                      '2 - Soma dos Algarismos dos Anos'
                      '3 - Horas de Trabalho'
                      '4 - Unidades Produzidas')
                    ComboBoxLabel.Width = 40
                    ComboBoxLabel.Height = 13
                    ComboBoxLabel.Caption = 'M'#233'todo:'
                  end
                  object ComboTipoDepreciacao: TLabeledComboBox
                    Left = 270
                    Top = 31
                    Width = 147
                    Height = 21
                    Style = csDropDownList
                    ItemIndex = 0
                    TabOrder = 2
                    Text = 'N - Normal'
                    Items.Strings = (
                      'N - Normal'
                      'A - Acelerada'
                      'I - Incentivada')
                    ComboBoxLabel.Width = 24
                    ComboBoxLabel.Height = 13
                    ComboBoxLabel.Caption = 'Tipo:'
                  end
                  object EditInicioDepreciacao: TLabeledDateEdit
                    Left = 423
                    Top = 31
                    Width = 121
                    Height = 21
                    TabOrder = 3
                    DateEditLabel.Width = 91
                    DateEditLabel.Height = 13
                    DateEditLabel.Caption = 'In'#237'cio Deprecia'#231#227'o:'
                  end
                  object EditUltimaDepreciacao: TLabeledDateEdit
                    Left = 550
                    Top = 31
                    Width = 121
                    Height = 21
                    TabOrder = 4
                    DateEditLabel.Width = 95
                    DateEditLabel.Height = 13
                    DateEditLabel.Caption = #218'ltima Deprecia'#231#227'o:'
                  end
                  object EditTaxaAnualDepreciacao: TLabeledCalcEdit
                    Left = 8
                    Top = 73
                    Width = 121
                    Height = 21
                    DisplayFormat = '###,###,##0.00'
                    TabOrder = 5
                    DecimalPlacesAlwaysShown = False
                    CalcEditLabel.Width = 58
                    CalcEditLabel.Height = 13
                    CalcEditLabel.Caption = 'Taxa Anual:'
                  end
                  object EditTaxaMensalDepreciacao: TLabeledCalcEdit
                    Left = 135
                    Top = 73
                    Width = 121
                    Height = 21
                    DisplayFormat = '###,###,##0.00'
                    TabOrder = 6
                    DecimalPlacesAlwaysShown = False
                    CalcEditLabel.Width = 64
                    CalcEditLabel.Height = 13
                    CalcEditLabel.Caption = 'Taxa Mensal:'
                  end
                  object EditTaxaDepreciacaoAcelerada: TLabeledCalcEdit
                    Left = 262
                    Top = 73
                    Width = 121
                    Height = 21
                    DisplayFormat = '###,###,##0.00'
                    TabOrder = 7
                    DecimalPlacesAlwaysShown = False
                    CalcEditLabel.Width = 79
                    CalcEditLabel.Height = 13
                    CalcEditLabel.Caption = 'Taxa Acelerada:'
                  end
                  object EditTaxaDepreciacaoIncentivada: TLabeledCalcEdit
                    Left = 389
                    Top = 73
                    Width = 121
                    Height = 21
                    DisplayFormat = '###,###,##0.00'
                    TabOrder = 8
                    DecimalPlacesAlwaysShown = False
                    CalcEditLabel.Width = 88
                    CalcEditLabel.Height = 13
                    CalcEditLabel.Caption = 'Taxa Incentivada:'
                  end
                end
                object EditValorBaixa: TLabeledCalcEdit
                  Left = 674
                  Top = 122
                  Width = 119
                  Height = 21
                  DisplayFormat = '###,###,##0.00'
                  TabOrder = 14
                  DecimalPlacesAlwaysShown = False
                  CalcEditLabel.Width = 57
                  CalcEditLabel.Height = 13
                  CalcEditLabel.Caption = 'Valor Baixa:'
                end
              end
            end
            object tsDocumentoBem: TTabSheet
              Caption = 'Documenta'#231#227'o'
              ImageIndex = 2
              object PanelDocumentacao: TPanel
                Left = 0
                Top = 0
                Width = 951
                Height = 325
                Align = alClient
                BevelOuter = bvNone
                TabOrder = 0
                object GridDocumentacao: TJvDBUltimGrid
                  Left = 0
                  Top = 26
                  Width = 951
                  Height = 299
                  Align = alClient
                  DataSource = DSPatrimDocumentoBem
                  TabOrder = 0
                  TitleFont.Charset = DEFAULT_CHARSET
                  TitleFont.Color = clWindowText
                  TitleFont.Height = -11
                  TitleFont.Name = 'Tahoma'
                  TitleFont.Style = []
                  OnKeyDown = GridDocumentacaoKeyDown
                  AlternateRowColor = 15593713
                  SelectColumnsDialogStrings.Caption = 'Select columns'
                  SelectColumnsDialogStrings.OK = '&OK'
                  SelectColumnsDialogStrings.NoSelectionWarning = 'At least one column must be visible!'
                  EditControls = <>
                  RowsHeight = 17
                  TitleRowHeight = 17
                  OnUserSort = GridDocumentacaoUserSort
                  Columns = <
                    item
                      Expanded = False
                      FieldName = 'NOME'
                      Title.Caption = 'Nome'
                      Width = 200
                      Visible = True
                    end
                    item
                      Expanded = False
                      FieldName = 'DESCRICAO'
                      Title.Caption = 'Descri'#231#227'o'
                      Width = 300
                      Visible = True
                    end
                    item
                      Expanded = False
                      FieldName = 'IMAGEM'
                      ReadOnly = True
                      Title.Caption = 'Imagem'
                      Width = 300
                      Visible = True
                    end>
                end
                object ActionToolBar1: TActionToolBar
                  Left = 0
                  Top = 0
                  Width = 951
                  Height = 26
                  ActionManager = ActionManagerBem
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
            object tsDepreciacaoBem: TTabSheet
              Caption = 'Deprecia'#231#227'o'
              ImageIndex = 2
              object PanelDepreciacao: TPanel
                Left = 0
                Top = 0
                Width = 951
                Height = 325
                Align = alClient
                BevelOuter = bvNone
                TabOrder = 0
                object GridDepreciacao: TJvDBUltimGrid
                  Left = 0
                  Top = 26
                  Width = 951
                  Height = 299
                  Align = alClient
                  DataSource = DSPatrimDepreciacaoBem
                  TabOrder = 0
                  TitleFont.Charset = DEFAULT_CHARSET
                  TitleFont.Color = clWindowText
                  TitleFont.Height = -11
                  TitleFont.Name = 'Tahoma'
                  TitleFont.Style = []
                  OnKeyDown = GridDepreciacaoKeyDown
                  AlternateRowColor = 15593713
                  SelectColumnsDialogStrings.Caption = 'Select columns'
                  SelectColumnsDialogStrings.OK = '&OK'
                  SelectColumnsDialogStrings.NoSelectionWarning = 'At least one column must be visible!'
                  EditControls = <>
                  RowsHeight = 17
                  TitleRowHeight = 17
                  OnUserSort = GridDepreciacaoUserSort
                  Columns = <
                    item
                      Expanded = False
                      FieldName = 'DATA_DEPRECIACAO'
                      Title.Caption = 'Data Deprecia'#231#227'o'
                      Visible = True
                    end
                    item
                      Expanded = False
                      FieldName = 'DIAS'
                      Title.Caption = 'Dias'
                      Visible = True
                    end
                    item
                      Expanded = False
                      FieldName = 'TAXA'
                      Title.Caption = 'Taxa'
                      Visible = True
                    end
                    item
                      Expanded = False
                      FieldName = 'INDICE'
                      Title.Caption = #205'ndice'
                      Visible = True
                    end
                    item
                      Expanded = False
                      FieldName = 'VALOR'
                      Title.Caption = 'Valor'
                      Visible = True
                    end
                    item
                      Expanded = False
                      FieldName = 'DEPRECIACAO_ACUMULADA'
                      Title.Caption = 'Deprecia'#231#227'o Acumulada'
                      Visible = True
                    end>
                end
                object ActionToolBarDepreciacao: TActionToolBar
                  Left = 0
                  Top = 0
                  Width = 951
                  Height = 26
                  ActionManager = ActionManagerBem
                  BiDiMode = bdRightToLeft
                  ColorMap.HighlightColor = 15660791
                  ColorMap.BtnSelectedColor = clBtnFace
                  ColorMap.UnusedColor = 15660791
                  Orientation = boRightToLeft
                  ParentBiDiMode = False
                  Spacing = 0
                  ExplicitHeight = 23
                end
              end
            end
            object tsMovimentacaoBem: TTabSheet
              Caption = 'Movimenta'#231#227'o'
              ImageIndex = 3
              object PanelMovimentacao: TPanel
                Left = 0
                Top = 0
                Width = 951
                Height = 325
                Align = alClient
                BevelOuter = bvNone
                TabOrder = 0
                object GridMovimentacao: TJvDBUltimGrid
                  Left = 0
                  Top = 0
                  Width = 951
                  Height = 325
                  Align = alClient
                  DataSource = DSPatrimMovimentacaoBem
                  TabOrder = 0
                  TitleFont.Charset = DEFAULT_CHARSET
                  TitleFont.Color = clWindowText
                  TitleFont.Height = -11
                  TitleFont.Name = 'Tahoma'
                  TitleFont.Style = []
                  OnKeyDown = GridMovimentacaoKeyDown
                  AlternateRowColor = 15593713
                  SelectColumnsDialogStrings.Caption = 'Select columns'
                  SelectColumnsDialogStrings.OK = '&OK'
                  SelectColumnsDialogStrings.NoSelectionWarning = 'At least one column must be visible!'
                  EditControls = <>
                  RowsHeight = 17
                  TitleRowHeight = 17
                  OnUserSort = GridMovimentacaoUserSort
                  Columns = <
                    item
                      Expanded = False
                      FieldName = 'ID_PATRIM_TIPO_MOVIMENTACAO'
                      Title.Caption = 'Id Tipo Movimenta'#231#227'o'
                      Visible = True
                    end
                    item
                      Expanded = False
                      FieldName = 'PATRIM_TIPO_MOVIMENTACAO.NOME'
                      ReadOnly = True
                      Title.Caption = 'Tipo de Movimenta'#231#227'o'
                      Visible = True
                    end
                    item
                      Expanded = False
                      FieldName = 'DATA_MOVIMENTACAO'
                      Title.Caption = 'Data Movimenta'#231#227'o'
                      Visible = True
                    end
                    item
                      Expanded = False
                      FieldName = 'RESPONSAVEL'
                      Title.Caption = 'Respons'#225'vel'
                      Visible = True
                    end>
                end
              end
            end
          end
          object EditIdTipoAquisicao: TLabeledCalcEdit
            Left = 295
            Top = 73
            Width = 61
            Height = 21
            ShowButton = False
            TabOrder = 8
            DecimalPlacesAlwaysShown = False
            OnExit = EditIdTipoAquisicaoExit
            OnKeyDown = EditIdTipoAquisicaoKeyDown
            OnKeyPress = EditIdTipoAquisicaoKeyPress
            CalcEditLabel.Width = 95
            CalcEditLabel.Height = 13
            CalcEditLabel.Caption = 'Tipo Aquisi'#231#227'o [F1]:'
          end
          object EditTipoAquisicaoNome: TLabeledEdit
            Left = 356
            Top = 73
            Width = 218
            Height = 21
            TabStop = False
            Color = clInfoBk
            EditLabel.Width = 6
            EditLabel.Height = 13
            EditLabel.Caption = '  '
            ReadOnly = True
            TabOrder = 9
          end
          object EditIdSetor: TLabeledCalcEdit
            Left = 16
            Top = 30
            Width = 61
            Height = 21
            ShowButton = False
            TabOrder = 0
            DecimalPlacesAlwaysShown = False
            OnExit = EditIdSetorExit
            OnKeyDown = EditIdSetorKeyDown
            OnKeyPress = EditIdSetorKeyPress
            CalcEditLabel.Width = 53
            CalcEditLabel.Height = 13
            CalcEditLabel.Caption = 'Setor [F1]:'
          end
          object EditSetorNome: TLabeledEdit
            Left = 77
            Top = 30
            Width = 212
            Height = 21
            TabStop = False
            Color = clInfoBk
            EditLabel.Width = 6
            EditLabel.Height = 13
            EditLabel.Caption = '  '
            ReadOnly = True
            TabOrder = 1
          end
          object EditGrupoBemNome: TLabeledEdit
            Left = 77
            Top = 73
            Width = 212
            Height = 21
            TabStop = False
            Color = clInfoBk
            EditLabel.Width = 6
            EditLabel.Height = 13
            EditLabel.Caption = '  '
            ReadOnly = True
            TabOrder = 7
          end
          object EditIdGrupoBem: TLabeledCalcEdit
            Left = 16
            Top = 73
            Width = 61
            Height = 21
            ShowButton = False
            TabOrder = 6
            DecimalPlacesAlwaysShown = False
            OnExit = EditIdGrupoBemExit
            OnKeyDown = EditIdGrupoBemKeyDown
            OnKeyPress = EditIdGrupoBemKeyPress
            CalcEditLabel.Width = 56
            CalcEditLabel.Height = 13
            CalcEditLabel.Caption = 'Grupo [F1]:'
          end
          object EditIdColaborador: TLabeledCalcEdit
            Left = 295
            Top = 30
            Width = 61
            Height = 21
            ShowButton = False
            TabOrder = 2
            DecimalPlacesAlwaysShown = False
            OnExit = EditIdColaboradorExit
            OnKeyDown = EditIdColaboradorKeyDown
            OnKeyPress = EditIdColaboradorKeyPress
            CalcEditLabel.Width = 86
            CalcEditLabel.Height = 13
            CalcEditLabel.Caption = 'Colaborador [F1]:'
          end
          object EditColaboradorNome: TLabeledEdit
            Left = 356
            Top = 30
            Width = 218
            Height = 21
            TabStop = False
            Color = clInfoBk
            EditLabel.Width = 6
            EditLabel.Height = 13
            EditLabel.Caption = '  '
            ReadOnly = True
            TabOrder = 3
          end
          object EditIdFornecedor: TLabeledCalcEdit
            Left = 580
            Top = 30
            Width = 61
            Height = 21
            ShowButton = False
            TabOrder = 4
            DecimalPlacesAlwaysShown = False
            OnExit = EditIdFornecedorExit
            OnKeyDown = EditIdFornecedorKeyDown
            OnKeyPress = EditIdFornecedorKeyPress
            CalcEditLabel.Width = 82
            CalcEditLabel.Height = 13
            CalcEditLabel.Caption = 'Fornecedor [F1]:'
          end
          object EditFornecedorNome: TLabeledEdit
            Left = 641
            Top = 30
            Width = 314
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
          object EditIdEstadoConservacao: TLabeledCalcEdit
            Left = 580
            Top = 73
            Width = 61
            Height = 21
            ShowButton = False
            TabOrder = 10
            DecimalPlacesAlwaysShown = False
            OnExit = EditIdEstadoConservacaoExit
            OnKeyDown = EditIdEstadoConservacaoKeyDown
            OnKeyPress = EditIdEstadoConservacaoKeyPress
            CalcEditLabel.Width = 141
            CalcEditLabel.Height = 13
            CalcEditLabel.Caption = 'Estado de Conserva'#231#227'o [F1]:'
          end
          object EditEstadoConservacaoNome: TLabeledEdit
            Left = 641
            Top = 73
            Width = 314
            Height = 21
            TabStop = False
            Anchors = [akLeft, akTop, akRight]
            Color = clInfoBk
            EditLabel.Width = 6
            EditLabel.Height = 13
            EditLabel.Caption = '  '
            ReadOnly = True
            TabOrder = 11
          end
          object EditNumeroSerie: TLabeledEdit
            Left = 163
            Top = 115
            Width = 215
            Height = 21
            EditLabel.Width = 107
            EditLabel.Height = 13
            EditLabel.Caption = 'N'#250'mero de S'#233'rie (NS):'
            MaxLength = 50
            TabOrder = 13
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
  object CDSPatrimDocumentoBem: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'ID'
        DataType = ftInteger
      end
      item
        Name = 'ID_PATRIM_BEM'
        DataType = ftInteger
      end
      item
        Name = 'NOME'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'DESCRICAO'
        DataType = ftString
        Size = 500
      end
      item
        Name = 'IMAGEM'
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
    AfterEdit = CDSPatrimDocumentoBemAfterEdit
    Left = 96
    Top = 507
    Data = {
      AA0000009619E0BD010000001800000006000000000003000000AA0002494404
      000100000000000D49445F50415452494D5F42454D0400010000000000044E4F
      4D4501004900000001000557494454480200020032000944455343524943414F
      020049000000010005574944544802000200F40106494D4147454D0100490000
      00010005574944544802000200FA000850455253495354450100490000000100
      0557494454480200020001000000}
    object CDSPatrimDocumentoBemID: TIntegerField
      FieldName = 'ID'
    end
    object CDSPatrimDocumentoBemID_PATRIM_BEM: TIntegerField
      FieldName = 'ID_PATRIM_BEM'
    end
    object CDSPatrimDocumentoBemNOME: TStringField
      FieldName = 'NOME'
      Size = 50
    end
    object CDSPatrimDocumentoBemDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Size = 500
    end
    object CDSPatrimDocumentoBemIMAGEM: TStringField
      FieldName = 'IMAGEM'
      Size = 250
    end
    object CDSPatrimDocumentoBemPERSISTE: TStringField
      FieldName = 'PERSISTE'
      Size = 1
    end
  end
  object DSPatrimDocumentoBem: TDataSource
    DataSet = CDSPatrimDocumentoBem
    Left = 93
    Top = 464
  end
  object CDSPatrimDepreciacaoBem: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'ID'
        DataType = ftInteger
      end
      item
        Name = 'ID_PATRIM_BEM'
        DataType = ftInteger
      end
      item
        Name = 'DATA_DEPRECIACAO'
        DataType = ftDate
      end
      item
        Name = 'DIAS'
        DataType = ftInteger
      end
      item
        Name = 'TAXA'
        DataType = ftFMTBcd
        Precision = 18
        Size = 6
      end
      item
        Name = 'INDICE'
        DataType = ftFMTBcd
        Precision = 18
        Size = 6
      end
      item
        Name = 'VALOR'
        DataType = ftFMTBcd
        Precision = 18
        Size = 6
      end
      item
        Name = 'DEPRECIACAO_ACUMULADA'
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
    AfterEdit = CDSPatrimDepreciacaoBemAfterEdit
    Left = 224
    Top = 507
    Data = {
      320100009619E0BD020000001800000009000000000003000000320102494404
      000100000000000D49445F50415452494D5F42454D0400010000000000104441
      54415F444550524543494143414F040006000000000004444941530400010000
      00000004544158410B0012000000020008444543494D414C5302000200060005
      574944544802000200120006494E444943450B0012000000020008444543494D
      414C530200020006000557494454480200020012000556414C4F520B00120000
      00020008444543494D414C530200020006000557494454480200020012001544
      4550524543494143414F5F4143554D554C4144410B0012000000020008444543
      494D414C53020002000600055749445448020002001200085045525349535445
      01004900000001000557494454480200020001000000}
    object CDSPatrimDepreciacaoBemID: TIntegerField
      FieldName = 'ID'
    end
    object CDSPatrimDepreciacaoBemID_PATRIM_BEM: TIntegerField
      FieldName = 'ID_PATRIM_BEM'
    end
    object CDSPatrimDepreciacaoBemDATA_DEPRECIACAO: TDateField
      FieldName = 'DATA_DEPRECIACAO'
      EditMask = '##/##/####;1;_'
    end
    object CDSPatrimDepreciacaoBemDIAS: TIntegerField
      FieldName = 'DIAS'
    end
    object CDSPatrimDepreciacaoBemTAXA: TFMTBCDField
      FieldName = 'TAXA'
      DisplayFormat = '###,###,##0.00'
      Precision = 20
      Size = 6
    end
    object CDSPatrimDepreciacaoBemINDICE: TFMTBCDField
      FieldName = 'INDICE'
      DisplayFormat = '###,###,##0.00'
      Precision = 20
      Size = 6
    end
    object CDSPatrimDepreciacaoBemVALOR: TFMTBCDField
      FieldName = 'VALOR'
      DisplayFormat = '###,###,##0.00'
      Precision = 20
      Size = 6
    end
    object CDSPatrimDepreciacaoBemDEPRECIACAO_ACUMULADA: TFMTBCDField
      FieldName = 'DEPRECIACAO_ACUMULADA'
      DisplayFormat = '###,###,##0.00'
      Precision = 20
      Size = 6
    end
    object CDSPatrimDepreciacaoBemPERSISTE: TStringField
      FieldName = 'PERSISTE'
      Size = 1
    end
  end
  object DSPatrimDepreciacaoBem: TDataSource
    DataSet = CDSPatrimDepreciacaoBem
    Left = 221
    Top = 464
  end
  object CDSPatrimMovimentacaoBem: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'ID'
        DataType = ftInteger
      end
      item
        Name = 'ID_PATRIM_BEM'
        DataType = ftInteger
      end
      item
        Name = 'ID_PATRIM_TIPO_MOVIMENTACAO'
        DataType = ftInteger
      end
      item
        Name = 'PATRIM_TIPO_MOVIMENTACAO.NOME'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'DATA_MOVIMENTACAO'
        DataType = ftDate
      end
      item
        Name = 'RESPONSAVEL'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'PERSISTE'
        DataType = ftString
        Size = 1
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    AfterEdit = CDSPatrimMovimentacaoBemAfterEdit
    Left = 360
    Top = 507
    Data = {
      E80000009619E0BD010000001800000007000000000003000000E80002494404
      000100000000000D49445F50415452494D5F42454D04000100000000001B4944
      5F50415452494D5F5449504F5F4D4F56494D454E544143414F04000100000000
      001D50415452494D5F5449504F5F4D4F56494D454E544143414F2E4E4F4D4501
      0049000000010005574944544802000200320011444154415F4D4F56494D454E
      544143414F04000600000000000B524553504F4E534156454C01004900000001
      0005574944544802000200320008504552534953544501004900000001000557
      494454480200020001000000}
    object CDSPatrimMovimentacaoBemID: TIntegerField
      FieldName = 'ID'
    end
    object CDSPatrimMovimentacaoBemID_PATRIM_BEM: TIntegerField
      FieldName = 'ID_PATRIM_BEM'
    end
    object CDSPatrimMovimentacaoBemID_PATRIM_TIPO_MOVIMENTACAO: TIntegerField
      FieldName = 'ID_PATRIM_TIPO_MOVIMENTACAO'
    end
    object CDSPatrimMovimentacaoBemDATA_MOVIMENTACAO: TDateField
      FieldName = 'DATA_MOVIMENTACAO'
      EditMask = '##/##/####;1;_'
    end
    object CDSPatrimMovimentacaoBemRESPONSAVEL: TStringField
      FieldName = 'RESPONSAVEL'
      Size = 50
    end
    object CDSPatrimMovimentacaoBemPATRIM_TIPO_MOVIMENTACAONOME: TStringField
      FieldName = 'PATRIM_TIPO_MOVIMENTACAO.NOME'
      Size = 50
    end
    object CDSPatrimMovimentacaoBemPERSISTE: TStringField
      FieldName = 'PERSISTE'
      Size = 1
    end
  end
  object DSPatrimMovimentacaoBem: TDataSource
    DataSet = CDSPatrimMovimentacaoBem
    Left = 357
    Top = 464
  end
  object ActionManagerBem: TActionManager
    ActionBars = <
      item
        Items = <
          item
            Action = ActionCalcularDepreciacao
            Caption = '&Calcular Deprecia'#231#227'o'
            ImageIndex = 29
          end>
        ActionBar = ActionToolBarDepreciacao
      end
      item
        Items = <
          item
            Action = ActionAcionarGed
            Caption = '&Acionar GED'
            ImageIndex = 26
          end>
        ActionBar = ActionToolBar1
      end>
    DisabledImages = FDataModule.ImagensCadastrosD
    Images = FDataModule.ImagensCadastros
    Left = 740
    Top = 489
    StyleName = 'Platform Default'
    object ActionCalcularDepreciacao: TAction
      Category = 'Depreciacao'
      Caption = 'Calcular Deprecia'#231#227'o'
      ImageIndex = 29
      OnExecute = ActionCalcularDepreciacaoExecute
    end
    object ActionAcionarGed: TAction
      Category = 'Documentacao'
      Caption = 'Acionar GED'
      ImageIndex = 26
      OnExecute = ActionAcionarGedExecute
    end
  end
end
