inherited FTributacao: TFTributacao
  Left = 318
  Top = 139
  Caption = 'Tributa'#231#227'o'
  ClientHeight = 525
  ExplicitLeft = 318
  ExplicitTop = 139
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
            Top = 11
            Width = 959
            Height = 98
            Anchors = [akLeft, akTop, akRight]
            Constraints.MinWidth = 753
          end
          object PageControlDadosTributacao: TPageControl
            Left = 7
            Top = 128
            Width = 959
            Height = 321
            ActivePage = tsIcms
            Anchors = [akLeft, akTop, akRight, akBottom]
            TabOrder = 4
            object tsIcms: TTabSheet
              Caption = 'ICMS'
              ImageIndex = 2
              object PanelIcms: TPanel
                Left = 0
                Top = 0
                Width = 951
                Height = 293
                Align = alClient
                BevelOuter = bvNone
                TabOrder = 0
                object GridIcms: TJvDBUltimGrid
                  Left = 0
                  Top = 23
                  Width = 951
                  Height = 270
                  Align = alClient
                  DataSource = DSIcms
                  TabOrder = 0
                  TitleFont.Charset = DEFAULT_CHARSET
                  TitleFont.Color = clWindowText
                  TitleFont.Height = -11
                  TitleFont.Name = 'Tahoma'
                  TitleFont.Style = []
                  OnKeyDown = GridIcmsKeyDown
                  AlternateRowColor = 15593713
                  SelectColumnsDialogStrings.Caption = 'Select columns'
                  SelectColumnsDialogStrings.OK = '&OK'
                  SelectColumnsDialogStrings.NoSelectionWarning = 'At least one column must be visible!'
                  CanDelete = False
                  EditControls = <>
                  RowsHeight = 17
                  TitleRowHeight = 17
                  Columns = <
                    item
                      Alignment = taCenter
                      Expanded = False
                      FieldName = 'UF_DESTINO'
                      Title.Caption = 'UF Destino [F1]'
                      Width = 100
                      Visible = True
                    end
                    item
                      Alignment = taCenter
                      Expanded = False
                      FieldName = 'CFOP'
                      Title.Caption = 'CFOP [F1]'
                      Width = 100
                      Visible = True
                    end
                    item
                      Alignment = taCenter
                      Expanded = False
                      FieldName = 'CSOSN_B'
                      Title.Caption = 'CSOSN_B [F1]'
                      Width = 100
                      Visible = True
                    end
                    item
                      Alignment = taCenter
                      Expanded = False
                      FieldName = 'CST_B'
                      Title.Caption = 'CST_B [F1]'
                      Width = 100
                      Visible = True
                    end
                    item
                      Expanded = False
                      FieldName = 'MODALIDADE_BC'
                      PickList.Strings = (
                        '0-Margem Valor Agregado'
                        '1-Valor Pauta'
                        '2-Valor Pre'#231'o M'#225'ximo'
                        '3-Valor da Opera'#231#227'o')
                      Title.Caption = 'Modalidade BC ICMS'
                      Visible = True
                    end
                    item
                      Expanded = False
                      FieldName = 'ALIQUOTA'
                      Title.Caption = 'Al'#237'quota'
                      Visible = True
                    end
                    item
                      Expanded = False
                      FieldName = 'VALOR_PAUTA'
                      Title.Caption = 'Valor Pauta'
                      Visible = True
                    end
                    item
                      Expanded = False
                      FieldName = 'VALOR_PRECO_MAXIMO'
                      Title.Caption = 'Valor Pre'#231'o M'#225'ximo'
                      Visible = True
                    end
                    item
                      Expanded = False
                      FieldName = 'PORCENTO_BC'
                      Title.Caption = 'Percentual BC'
                      Visible = True
                    end
                    item
                      Expanded = False
                      FieldName = 'MVA'
                      Visible = True
                    end
                    item
                      Expanded = False
                      FieldName = 'MODALIDADE_BC_ST'
                      PickList.Strings = (
                        '0-Valor Pre'#231'o M'#225'ximo '
                        '1-Valor Lista Negativa'
                        '2-Valor Lista Positiva'
                        '3-valor Lista Neutra'
                        '4-Margem Valor Agregado'
                        '5-Valor Pauta')
                      Title.Caption = 'Modalidade BC ST'
                      Visible = True
                    end
                    item
                      Expanded = False
                      FieldName = 'ALIQUOTA_ICMS_ST'
                      Title.Caption = 'Al'#237'quota ST'
                      Visible = True
                    end
                    item
                      Expanded = False
                      FieldName = 'ALIQUOTA_INTERNA_ST'
                      Title.Caption = 'Al'#237'quota Interna ST'
                      Visible = True
                    end
                    item
                      Expanded = False
                      FieldName = 'ALIQUOTA_INTERESTADUAL_ST'
                      Title.Caption = 'Al'#237'quota Interestadual ST'
                      Visible = True
                    end
                    item
                      Expanded = False
                      FieldName = 'VALOR_PAUTA_ST'
                      Title.Caption = 'Valor Pauta ST'
                      Visible = True
                    end
                    item
                      Expanded = False
                      FieldName = 'VALOR_PRECO_MAXIMO_ST'
                      Title.Caption = 'Valor Pre'#231'o M'#225'ximo ST'
                      Visible = True
                    end
                    item
                      Expanded = False
                      FieldName = 'PORCENTO_BC_ST'
                      Title.Caption = 'Percentual BC ST'
                      Visible = True
                    end>
                end
                object ActionToolBar3: TActionToolBar
                  Left = 0
                  Top = 0
                  Width = 951
                  Height = 23
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
            object tsPis: TTabSheet
              Caption = 'PIS'
              ExplicitLeft = 0
              ExplicitTop = 0
              ExplicitWidth = 0
              ExplicitHeight = 235
              object PanelPis: TPanel
                Left = 0
                Top = 0
                Width = 951
                Height = 293
                Align = alClient
                BevelOuter = bvNone
                TabOrder = 0
                ExplicitHeight = 235
                DesignSize = (
                  951
                  293)
                object EditPorcentoBaseCalculoPis: TLabeledCalcEdit
                  Left = 188
                  Top = 121
                  Width = 121
                  Height = 21
                  DisplayFormat = '###,###,##0.00'
                  TabOrder = 5
                  DecimalPlacesAlwaysShown = False
                  CalcEditLabel.Width = 110
                  CalcEditLabel.Height = 13
                  CalcEditLabel.Caption = 'Porcento Base C'#225'lculo:'
                end
                object EditCodigoCstPis: TLabeledCalcEdit
                  Left = 5
                  Top = 26
                  Width = 61
                  Height = 21
                  DecimalPlaces = 0
                  DisplayFormat = '00'
                  ShowButton = False
                  TabOrder = 0
                  DecimalPlacesAlwaysShown = False
                  OnExit = EditCodigoCstPisExit
                  OnKeyDown = EditCodigoCstPisKeyDown
                  OnKeyPress = EditCodigoCstPisKeyPress
                  CalcEditLabel.Width = 23
                  CalcEditLabel.Height = 13
                  CalcEditLabel.Caption = 'CST:'
                end
                object EditCstPis: TLabeledEdit
                  Left = 66
                  Top = 26
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
                object EditCodigoApuracaoEfdPis: TLabeledCalcEdit
                  Left = 5
                  Top = 71
                  Width = 61
                  Height = 21
                  DecimalPlaces = 0
                  DisplayFormat = '00'
                  ShowButton = False
                  TabOrder = 2
                  DecimalPlacesAlwaysShown = False
                  OnExit = EditCodigoApuracaoEfdPisExit
                  OnKeyDown = EditCodigoApuracaoEfdPisKeyDown
                  OnKeyPress = EditCodigoApuracaoEfdPisKeyPress
                  CalcEditLabel.Width = 108
                  CalcEditLabel.Height = 13
                  CalcEditLabel.Caption = 'C'#243'digo Apura'#231#227'o EFD:'
                end
                object EditDescricaoCodigoApuracaoEfdPis: TLabeledEdit
                  Left = 66
                  Top = 71
                  Width = 878
                  Height = 21
                  TabStop = False
                  Anchors = [akLeft, akTop, akRight]
                  Color = clInfoBk
                  EditLabel.Width = 6
                  EditLabel.Height = 13
                  EditLabel.Caption = '  '
                  ReadOnly = True
                  TabOrder = 3
                end
                object ComboboxModalidadeBcPis: TLabeledComboBox
                  Left = 5
                  Top = 121
                  Width = 177
                  Height = 21
                  Style = csDropDownList
                  ItemIndex = 0
                  TabOrder = 4
                  Text = '0-Percentual'
                  Items.Strings = (
                    '0-Percentual'
                    '1-Unidade')
                  ComboBoxLabel.Width = 151
                  ComboBoxLabel.Height = 13
                  ComboBoxLabel.Caption = 'Modalidade da Base de C'#225'lculo:'
                end
                object EditAliquotaPorcentoPis: TLabeledCalcEdit
                  Left = 315
                  Top = 121
                  Width = 121
                  Height = 21
                  DisplayFormat = '###,###,##0.00'
                  TabOrder = 6
                  DecimalPlacesAlwaysShown = False
                  CalcEditLabel.Width = 89
                  CalcEditLabel.Height = 13
                  CalcEditLabel.Caption = 'Al'#237'quota Porcento:'
                end
                object EditAliquotaUnidadePis: TLabeledCalcEdit
                  Left = 442
                  Top = 121
                  Width = 121
                  Height = 21
                  DisplayFormat = '###,###,##0.00'
                  TabOrder = 7
                  DecimalPlacesAlwaysShown = False
                  CalcEditLabel.Width = 85
                  CalcEditLabel.Height = 13
                  CalcEditLabel.Caption = 'Al'#237'quota Unidade:'
                end
                object EditValorPrecoMaximoPis: TLabeledCalcEdit
                  Left = 569
                  Top = 121
                  Width = 121
                  Height = 21
                  DisplayFormat = '###,###,##0.00'
                  TabOrder = 8
                  DecimalPlacesAlwaysShown = False
                  CalcEditLabel.Width = 97
                  CalcEditLabel.Height = 13
                  CalcEditLabel.Caption = 'Valor Pre'#231'o M'#225'ximo:'
                end
                object EditValorPautaFiscalPis: TLabeledCalcEdit
                  Left = 696
                  Top = 121
                  Width = 121
                  Height = 21
                  DisplayFormat = '###,###,##0.00'
                  TabOrder = 9
                  DecimalPlacesAlwaysShown = False
                  CalcEditLabel.Width = 88
                  CalcEditLabel.Height = 13
                  CalcEditLabel.Caption = 'Valor Pauta Fiscal:'
                end
              end
            end
            object tsCofins: TTabSheet
              Caption = 'COFINS'
              ImageIndex = 2
              ExplicitLeft = 0
              ExplicitTop = 0
              ExplicitWidth = 0
              ExplicitHeight = 235
              object PanelCofins: TPanel
                Left = 0
                Top = 0
                Width = 951
                Height = 293
                Align = alClient
                BevelOuter = bvNone
                TabOrder = 0
                ExplicitHeight = 235
                DesignSize = (
                  951
                  293)
                object EditPorcentoBaseCalculoCofins: TLabeledCalcEdit
                  Left = 188
                  Top = 121
                  Width = 121
                  Height = 21
                  DisplayFormat = '###,###,##0.00'
                  TabOrder = 5
                  DecimalPlacesAlwaysShown = False
                  CalcEditLabel.Width = 110
                  CalcEditLabel.Height = 13
                  CalcEditLabel.Caption = 'Porcento Base C'#225'lculo:'
                end
                object EditCodigoCstCofins: TLabeledCalcEdit
                  Left = 5
                  Top = 26
                  Width = 61
                  Height = 21
                  DecimalPlaces = 0
                  DisplayFormat = '00'
                  ShowButton = False
                  TabOrder = 0
                  DecimalPlacesAlwaysShown = False
                  OnExit = EditCodigoCstCofinsExit
                  OnKeyDown = EditCodigoCstCofinsKeyDown
                  OnKeyPress = EditCodigoCstCofinsKeyPress
                  CalcEditLabel.Width = 23
                  CalcEditLabel.Height = 13
                  CalcEditLabel.Caption = 'CST:'
                end
                object EditCstCofins: TLabeledEdit
                  Left = 66
                  Top = 26
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
                object EditCodigoApuracaoEfdCofins: TLabeledCalcEdit
                  Left = 5
                  Top = 71
                  Width = 61
                  Height = 21
                  DecimalPlaces = 0
                  DisplayFormat = '00'
                  ShowButton = False
                  TabOrder = 2
                  DecimalPlacesAlwaysShown = False
                  OnExit = EditCodigoApuracaoEfdCofinsExit
                  OnKeyDown = EditCodigoApuracaoEfdCofinsKeyDown
                  OnKeyPress = EditCodigoApuracaoEfdCofinsKeyPress
                  CalcEditLabel.Width = 108
                  CalcEditLabel.Height = 13
                  CalcEditLabel.Caption = 'C'#243'digo Apura'#231#227'o EFD:'
                end
                object EditDescricaoCodigoApuracaoEfdCofins: TLabeledEdit
                  Left = 66
                  Top = 71
                  Width = 878
                  Height = 21
                  TabStop = False
                  Anchors = [akLeft, akTop, akRight]
                  Color = clInfoBk
                  EditLabel.Width = 6
                  EditLabel.Height = 13
                  EditLabel.Caption = '  '
                  ReadOnly = True
                  TabOrder = 3
                end
                object ComboboxModalidadeBcCofins: TLabeledComboBox
                  Left = 5
                  Top = 121
                  Width = 177
                  Height = 21
                  Style = csDropDownList
                  ItemIndex = 0
                  TabOrder = 4
                  Text = '0-Percentual'
                  Items.Strings = (
                    '0-Percentual'
                    '1-Unidade')
                  ComboBoxLabel.Width = 151
                  ComboBoxLabel.Height = 13
                  ComboBoxLabel.Caption = 'Modalidade da Base de C'#225'lculo:'
                end
                object EditAliquotaPorcentoCofins: TLabeledCalcEdit
                  Left = 315
                  Top = 121
                  Width = 121
                  Height = 21
                  DisplayFormat = '###,###,##0.00'
                  TabOrder = 6
                  DecimalPlacesAlwaysShown = False
                  CalcEditLabel.Width = 89
                  CalcEditLabel.Height = 13
                  CalcEditLabel.Caption = 'Al'#237'quota Porcento:'
                end
                object EditAliquotaUnidadeCofins: TLabeledCalcEdit
                  Left = 442
                  Top = 121
                  Width = 121
                  Height = 21
                  DisplayFormat = '###,###,##0.00'
                  TabOrder = 7
                  DecimalPlacesAlwaysShown = False
                  CalcEditLabel.Width = 85
                  CalcEditLabel.Height = 13
                  CalcEditLabel.Caption = 'Al'#237'quota Unidade:'
                end
                object EditValorPrecoMaximoCofins: TLabeledCalcEdit
                  Left = 569
                  Top = 121
                  Width = 121
                  Height = 21
                  DisplayFormat = '###,###,##0.00'
                  TabOrder = 8
                  DecimalPlacesAlwaysShown = False
                  CalcEditLabel.Width = 97
                  CalcEditLabel.Height = 13
                  CalcEditLabel.Caption = 'Valor Pre'#231'o M'#225'ximo:'
                end
                object EditValorPautaFiscalCofins: TLabeledCalcEdit
                  Left = 696
                  Top = 121
                  Width = 121
                  Height = 21
                  DisplayFormat = '###,###,##0.00'
                  TabOrder = 9
                  DecimalPlacesAlwaysShown = False
                  CalcEditLabel.Width = 88
                  CalcEditLabel.Height = 13
                  CalcEditLabel.Caption = 'Valor Pauta Fiscal:'
                end
              end
            end
            object tsIpi: TTabSheet
              Caption = 'IPI'
              ImageIndex = 3
              ExplicitLeft = 0
              ExplicitTop = 0
              ExplicitWidth = 0
              ExplicitHeight = 235
              object PanelIpi: TPanel
                Left = 0
                Top = 0
                Width = 951
                Height = 293
                Align = alClient
                BevelOuter = bvNone
                TabOrder = 0
                ExplicitHeight = 235
                DesignSize = (
                  951
                  293)
                object EditPorcentoBaseCalculoIpi: TLabeledCalcEdit
                  Left = 188
                  Top = 121
                  Width = 121
                  Height = 21
                  DisplayFormat = '###,###,##0.00'
                  TabOrder = 5
                  DecimalPlacesAlwaysShown = False
                  CalcEditLabel.Width = 110
                  CalcEditLabel.Height = 13
                  CalcEditLabel.Caption = 'Porcento Base C'#225'lculo:'
                end
                object EditCodigoCstIpi: TLabeledCalcEdit
                  Left = 5
                  Top = 26
                  Width = 61
                  Height = 21
                  DecimalPlaces = 0
                  DisplayFormat = '00'
                  MaxLength = 2
                  ShowButton = False
                  TabOrder = 0
                  DecimalPlacesAlwaysShown = False
                  OnExit = EditCodigoCstIpiExit
                  OnKeyDown = EditCodigoCstIpiKeyDown
                  OnKeyPress = EditCodigoCstIpiKeyPress
                  CalcEditLabel.Width = 23
                  CalcEditLabel.Height = 13
                  CalcEditLabel.Caption = 'CST:'
                end
                object EditCstIpi: TLabeledEdit
                  Left = 66
                  Top = 26
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
                object EditIdTipoReceitaDipi: TLabeledCalcEdit
                  Left = 5
                  Top = 71
                  Width = 61
                  Height = 21
                  DecimalPlaces = 0
                  DisplayFormat = '0'
                  ShowButton = False
                  TabOrder = 2
                  DecimalPlacesAlwaysShown = False
                  OnExit = EditIdTipoReceitaDipiExit
                  OnKeyDown = EditIdTipoReceitaDipiKeyDown
                  OnKeyPress = EditIdTipoReceitaDipiKeyPress
                  CalcEditLabel.Width = 87
                  CalcEditLabel.Height = 13
                  CalcEditLabel.Caption = 'Tipo Receita DIPI:'
                end
                object EditTipoReceitaDipi: TLabeledEdit
                  Left = 66
                  Top = 71
                  Width = 878
                  Height = 21
                  TabStop = False
                  Anchors = [akLeft, akTop, akRight]
                  Color = clInfoBk
                  EditLabel.Width = 6
                  EditLabel.Height = 13
                  EditLabel.Caption = '  '
                  ReadOnly = True
                  TabOrder = 3
                end
                object ComboboxModalidadeBcIpi: TLabeledComboBox
                  Left = 5
                  Top = 121
                  Width = 177
                  Height = 21
                  Style = csDropDownList
                  ItemIndex = 0
                  TabOrder = 4
                  Text = '0-Percentual'
                  Items.Strings = (
                    '0-Percentual'
                    '1-Unidade')
                  ComboBoxLabel.Width = 151
                  ComboBoxLabel.Height = 13
                  ComboBoxLabel.Caption = 'Modalidade da Base de C'#225'lculo:'
                end
                object EditAliquotaPorcentoIpi: TLabeledCalcEdit
                  Left = 315
                  Top = 121
                  Width = 121
                  Height = 21
                  DisplayFormat = '###,###,##0.00'
                  TabOrder = 6
                  DecimalPlacesAlwaysShown = False
                  CalcEditLabel.Width = 89
                  CalcEditLabel.Height = 13
                  CalcEditLabel.Caption = 'Al'#237'quota Porcento:'
                end
                object EditAliquotaUnidadeIpi: TLabeledCalcEdit
                  Left = 442
                  Top = 121
                  Width = 121
                  Height = 21
                  DisplayFormat = '###,###,##0.00'
                  TabOrder = 7
                  DecimalPlacesAlwaysShown = False
                  CalcEditLabel.Width = 85
                  CalcEditLabel.Height = 13
                  CalcEditLabel.Caption = 'Al'#237'quota Unidade:'
                end
                object EditValorPrecoMaximoIpi: TLabeledCalcEdit
                  Left = 569
                  Top = 121
                  Width = 121
                  Height = 21
                  DisplayFormat = '###,###,##0.00'
                  TabOrder = 8
                  DecimalPlacesAlwaysShown = False
                  CalcEditLabel.Width = 97
                  CalcEditLabel.Height = 13
                  CalcEditLabel.Caption = 'Valor Pre'#231'o M'#225'ximo:'
                end
                object EditValorPautaFiscalIpi: TLabeledCalcEdit
                  Left = 696
                  Top = 121
                  Width = 121
                  Height = 21
                  DisplayFormat = '###,###,##0.00'
                  TabOrder = 9
                  DecimalPlacesAlwaysShown = False
                  CalcEditLabel.Width = 88
                  CalcEditLabel.Height = 13
                  CalcEditLabel.Caption = 'Valor Pauta Fiscal:'
                end
              end
            end
          end
          object EditIdOperacaoFiscal: TLabeledCalcEdit
            Left = 16
            Top = 33
            Width = 61
            Height = 21
            ShowButton = False
            TabOrder = 0
            DecimalPlacesAlwaysShown = False
            OnExit = EditIdOperacaoFiscalExit
            OnKeyDown = EditIdOperacaoFiscalKeyDown
            OnKeyPress = EditIdOperacaoFiscalKeyPress
            CalcEditLabel.Width = 103
            CalcEditLabel.Height = 13
            CalcEditLabel.Caption = 'Opera'#231#227'o Fiscal [F1]:'
          end
          object EditOperacaoFiscal: TLabeledEdit
            Left = 77
            Top = 33
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
          object EditIdGrupoTributario: TLabeledCalcEdit
            Left = 16
            Top = 76
            Width = 61
            Height = 21
            ShowButton = False
            TabOrder = 2
            DecimalPlacesAlwaysShown = False
            OnExit = EditIdGrupoTributarioExit
            OnKeyDown = EditIdGrupoTributarioKeyDown
            OnKeyPress = EditIdGrupoTributarioKeyPress
            CalcEditLabel.Width = 105
            CalcEditLabel.Height = 13
            CalcEditLabel.Caption = 'Grupo Tribut'#225'rio [F1]:'
          end
          object EditGrupoTributario: TLabeledEdit
            Left = 77
            Top = 76
            Width = 878
            Height = 21
            TabStop = False
            Anchors = [akLeft, akTop, akRight]
            Color = clInfoBk
            EditLabel.Width = 6
            EditLabel.Height = 13
            EditLabel.Caption = '  '
            ReadOnly = True
            TabOrder = 3
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
  object CDSIcms: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'ID'
        DataType = ftInteger
      end
      item
        Name = 'ID_TRIBUT_CONFIGURA_OF_GT'
        DataType = ftInteger
      end
      item
        Name = 'UF_DESTINO'
        Attributes = [faFixed]
        DataType = ftString
        Size = 2
      end
      item
        Name = 'CFOP'
        DataType = ftInteger
      end
      item
        Name = 'CSOSN_B'
        Attributes = [faFixed]
        DataType = ftString
        Size = 3
      end
      item
        Name = 'CST_B'
        Attributes = [faFixed]
        DataType = ftString
        Size = 2
      end
      item
        Name = 'MODALIDADE_BC'
        Attributes = [faFixed]
        DataType = ftString
        Size = 1
      end
      item
        Name = 'ALIQUOTA'
        DataType = ftFMTBcd
        Precision = 20
        Size = 6
      end
      item
        Name = 'VALOR_PAUTA'
        DataType = ftFMTBcd
        Precision = 20
        Size = 6
      end
      item
        Name = 'VALOR_PRECO_MAXIMO'
        DataType = ftFMTBcd
        Precision = 20
        Size = 6
      end
      item
        Name = 'MVA'
        DataType = ftFMTBcd
        Precision = 20
        Size = 6
      end
      item
        Name = 'PORCENTO_BC'
        DataType = ftFMTBcd
        Precision = 20
        Size = 6
      end
      item
        Name = 'MODALIDADE_BC_ST'
        Attributes = [faFixed]
        DataType = ftString
        Size = 1
      end
      item
        Name = 'ALIQUOTA_INTERNA_ST'
        DataType = ftFMTBcd
        Precision = 20
        Size = 6
      end
      item
        Name = 'ALIQUOTA_INTERESTADUAL_ST'
        DataType = ftFMTBcd
        Precision = 20
        Size = 6
      end
      item
        Name = 'PORCENTO_BC_ST'
        DataType = ftFMTBcd
        Precision = 20
        Size = 6
      end
      item
        Name = 'ALIQUOTA_ICMS_ST'
        DataType = ftFMTBcd
        Precision = 20
        Size = 6
      end
      item
        Name = 'VALOR_PAUTA_ST'
        DataType = ftFMTBcd
        Precision = 20
        Size = 6
      end
      item
        Name = 'VALOR_PRECO_MAXIMO_ST'
        DataType = ftFMTBcd
        Precision = 20
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
    AfterEdit = CDSIcmsAfterEdit
    Left = 96
    Top = 387
    Data = {
      390300009619E0BD020000001800000014000000000003000000390302494404
      000100000000001949445F5452494255545F434F4E4649475552415F4F465F47
      5404000100000000000A55465F44455354494E4F010049002000010005574944
      54480200020002000443464F5004000100000000000743534F534E5F42010049
      0020000100055749445448020002000300054353545F42010049002000010005
      57494454480200020002000D4D4F44414C49444144455F424301004900200001
      0005574944544802000200010008414C4951554F54410C001200000002000844
      4543494D414C530200020006000557494454480200020014000B56414C4F525F
      50415554410C0012000000020008444543494D414C5302000200060005574944
      54480200020014001256414C4F525F505245434F5F4D4158494D4F0C00120000
      00020008444543494D414C53020002000600055749445448020002001400034D
      56410C0012000000020008444543494D414C5302000200060005574944544802
      00020014000B504F5243454E544F5F42430C0012000000020008444543494D41
      4C53020002000600055749445448020002001400104D4F44414C49444144455F
      42435F5354010049002000010005574944544802000200010013414C4951554F
      54415F494E5445524E415F53540C0012000000020008444543494D414C530200
      0200060005574944544802000200140019414C4951554F54415F494E54455245
      5354414455414C5F53540C0012000000020008444543494D414C530200020006
      000557494454480200020014000E504F5243454E544F5F42435F53540C001200
      0000020008444543494D414C5302000200060005574944544802000200140010
      414C4951554F54415F49434D535F53540C0012000000020008444543494D414C
      530200020006000557494454480200020014000E56414C4F525F50415554415F
      53540C0012000000020008444543494D414C5302000200060005574944544802
      00020014001556414C4F525F505245434F5F4D4158494D4F5F53540C00120000
      00020008444543494D414C530200020006000557494454480200020014000850
      4552534953544501004900000001000557494454480200020001000000}
    object CDSIcmsID: TIntegerField
      FieldName = 'ID'
    end
    object CDSIcmsID_TRIBUT_CONFIGURA_OF_GT: TIntegerField
      FieldName = 'ID_TRIBUT_CONFIGURA_OF_GT'
    end
    object CDSIcmsUF_DESTINO: TStringField
      FieldName = 'UF_DESTINO'
      FixedChar = True
      Size = 2
    end
    object CDSIcmsCFOP: TIntegerField
      FieldName = 'CFOP'
    end
    object CDSIcmsCSOSN_B: TStringField
      FieldName = 'CSOSN_B'
      FixedChar = True
      Size = 3
    end
    object CDSIcmsCST_B: TStringField
      FieldName = 'CST_B'
      FixedChar = True
      Size = 2
    end
    object CDSIcmsMVA: TFMTBCDField
      FieldName = 'MVA'
      DisplayFormat = '###,###,##0.00'
      Precision = 20
      Size = 6
    end
    object CDSIcmsPERSISTE: TStringField
      FieldName = 'PERSISTE'
      Size = 1
    end
    object CDSIcmsMODALIDADE_BC: TStringField
      FieldName = 'MODALIDADE_BC'
      FixedChar = True
      Size = 1
    end
    object CDSIcmsALIQUOTA: TFMTBCDField
      FieldName = 'ALIQUOTA'
      DisplayFormat = '###,###,##0.00'
      Precision = 20
      Size = 6
    end
    object CDSIcmsVALOR_PAUTA: TFMTBCDField
      FieldName = 'VALOR_PAUTA'
      DisplayFormat = '###,###,##0.00'
      Precision = 20
      Size = 6
    end
    object CDSIcmsVALOR_PRECO_MAXIMO: TFMTBCDField
      FieldName = 'VALOR_PRECO_MAXIMO'
      DisplayFormat = '###,###,##0.00'
      Precision = 20
      Size = 6
    end
    object CDSIcmsPORCENTO_BC: TFMTBCDField
      FieldName = 'PORCENTO_BC'
      DisplayFormat = '###,###,##0.00'
      Precision = 20
      Size = 6
    end
    object CDSIcmsMODALIDADE_BC_ST: TStringField
      FieldName = 'MODALIDADE_BC_ST'
      FixedChar = True
      Size = 1
    end
    object CDSIcmsALIQUOTA_INTERNA_ST: TFMTBCDField
      FieldName = 'ALIQUOTA_INTERNA_ST'
      DisplayFormat = '###,###,##0.00'
      Precision = 20
      Size = 6
    end
    object CDSIcmsALIQUOTA_INTERESTADUAL_ST: TFMTBCDField
      FieldName = 'ALIQUOTA_INTERESTADUAL_ST'
      DisplayFormat = '###,###,##0.00'
      Precision = 20
      Size = 6
    end
    object CDSIcmsPORCENTO_BC_ST: TFMTBCDField
      FieldName = 'PORCENTO_BC_ST'
      DisplayFormat = '###,###,##0.00'
      Precision = 20
      Size = 6
    end
    object CDSIcmsALIQUOTA_ICMS_ST: TFMTBCDField
      FieldName = 'ALIQUOTA_ICMS_ST'
      DisplayFormat = '###,###,##0.00'
      Precision = 20
      Size = 6
    end
    object CDSIcmsVALOR_PAUTA_ST: TFMTBCDField
      FieldName = 'VALOR_PAUTA_ST'
      DisplayFormat = '###,###,##0.00'
      Precision = 20
      Size = 6
    end
    object CDSIcmsVALOR_PRECO_MAXIMO_ST: TFMTBCDField
      FieldName = 'VALOR_PRECO_MAXIMO_ST'
      DisplayFormat = '###,###,##0.00'
      Precision = 20
      Size = 6
    end
  end
  object DSIcms: TDataSource
    DataSet = CDSIcms
    Left = 93
    Top = 440
  end
  object ActionManager1: TActionManager
    ActionBars = <
      item
      end
      item
      end
      item
        Items = <
          item
            Action = ActionExcluirItem
            Caption = '&Excluir Item'
            ImageIndex = 34
          end
          item
            Action = ActionUf
            Caption = '&Importar UFs'
            ImageIndex = 26
          end>
        ActionBar = ActionToolBar3
      end>
    DisabledImages = FDataModule.ImagensCadastrosD
    Images = FDataModule.ImagensCadastros
    Left = 924
    Top = 168
    StyleName = 'Platform Default'
    object ActionUf: TAction
      Caption = 'Importar UFs'
      ImageIndex = 26
      OnExecute = ActionUfExecute
    end
    object ActionExcluirItem: TAction
      Caption = 'Excluir Item'
      ImageIndex = 34
      OnExecute = ActionExcluirItemExecute
    end
  end
end
