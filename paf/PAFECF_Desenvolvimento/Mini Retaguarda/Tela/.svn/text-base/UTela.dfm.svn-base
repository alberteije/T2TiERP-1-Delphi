inherited FTela: TFTela
  Left = 212
  Top = 213
  Caption = 'FTela'
  ClientHeight = 454
  ClientWidth = 954
  KeyPreview = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  ExplicitLeft = 212
  ExplicitTop = 213
  ExplicitWidth = 962
  ExplicitHeight = 488
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl: TPageControl
    Left = 0
    Top = 0
    Width = 954
    Height = 454
    ActivePage = PaginaGrid
    Align = alClient
    TabOrder = 0
    Visible = False
    object PaginaGrid: TTabSheet
      Caption = 'PaginaGrid'
      object PanelGrid: TPanel
        Left = 0
        Top = 0
        Width = 946
        Height = 426
        Align = alClient
        BevelInner = bvLowered
        BevelWidth = 2
        TabOrder = 0
        object Grid: TJvDBUltimGrid
          Left = 4
          Top = 31
          Width = 938
          Height = 339
          Align = alClient
          DataSource = DSGrid
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
          OnUserSort = GridUserSort
        end
        object PanelFiltroRapido: TPanel
          Left = 4
          Top = 370
          Width = 938
          Height = 52
          Align = alBottom
          Color = 14537936
          ParentBackground = False
          TabOrder = 1
          DesignSize = (
            938
            52)
          object BotaoConsultar: TSpeedButton
            Left = 806
            Top = 24
            Width = 125
            Height = 22
            Anchors = [akTop, akRight]
            Constraints.MaxWidth = 125
            Constraints.MinWidth = 125
            Caption = 'Consultar [F9]'
            Flat = True
            OnClick = BotaoConsultarClick
            ExplicitLeft = 643
          end
          object LabelCampoFiltro: TLabel
            Left = 9
            Top = 8
            Width = 37
            Height = 13
            Caption = 'Campo:'
          end
          object EditCriterioRapido: TLabeledEdit
            Left = 163
            Top = 24
            Width = 637
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            Constraints.MinWidth = 145
            EditLabel.Width = 107
            EditLabel.Height = 13
            EditLabel.Caption = 'Crit'#233'rio para consulta:'
            TabOrder = 0
          end
          object ComboBoxCampos: TComboBox
            Left = 7
            Top = 24
            Width = 145
            Height = 22
            Style = csOwnerDrawFixed
            TabOrder = 1
          end
        end
        object PanelToolBarGrid: TPanel
          Left = 4
          Top = 4
          Width = 938
          Height = 27
          Align = alTop
          Color = clWhite
          ParentBackground = False
          TabOrder = 2
          object BotaoPaginaAnterior: TSpeedButton
            Left = 1
            Top = 1
            Width = 25
            Height = 25
            Align = alLeft
            ParentShowHint = False
            ShowHint = True
            OnClick = BotaoPaginaAnteriorClick
          end
          object BotaoPrimeiroRegistro: TSpeedButton
            Left = 26
            Top = 1
            Width = 25
            Height = 25
            Align = alLeft
            ParentShowHint = False
            ShowHint = True
            OnClick = BotaoPrimeiroRegistroClick
            ExplicitLeft = 57
            ExplicitTop = -4
          end
          object BotaoRegistroAnterior: TSpeedButton
            Left = 51
            Top = 1
            Width = 25
            Height = 25
            Align = alLeft
            ParentShowHint = False
            ShowHint = True
            OnClick = BotaoRegistroAnteriorClick
            ExplicitLeft = 74
            ExplicitTop = 0
          end
          object BotaoProximoRegistro: TSpeedButton
            Left = 76
            Top = 1
            Width = 25
            Height = 25
            Align = alLeft
            ParentShowHint = False
            ShowHint = True
            OnClick = BotaoProximoRegistroClick
            ExplicitLeft = 99
            ExplicitTop = 0
          end
          object BotaoUltimoRegistro: TSpeedButton
            Left = 101
            Top = 1
            Width = 25
            Height = 25
            Align = alLeft
            ParentShowHint = False
            ShowHint = True
            OnClick = BotaoUltimoRegistroClick
            ExplicitLeft = 148
            ExplicitTop = 0
          end
          object BotaoProximaPagina: TSpeedButton
            Left = 126
            Top = 1
            Width = 25
            Height = 25
            Align = alLeft
            ParentShowHint = False
            ShowHint = True
            OnClick = BotaoProximaPaginaClick
            ExplicitLeft = 157
            ExplicitTop = 0
          end
          object BotaoSeparador1: TSpeedButton
            Left = 151
            Top = 1
            Width = 10
            Height = 25
            Align = alLeft
            Caption = '|'
            Flat = True
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            ExplicitTop = -4
          end
          object BotaoFiltrar: TSpeedButton
            Left = 171
            Top = 1
            Width = 104
            Height = 25
            Align = alLeft
            Caption = 'Filtrar [F5]'
            ParentShowHint = False
            ShowHint = True
            OnClick = BotaoFiltrarClick
            ExplicitLeft = 161
          end
          object BotaoExportar: TSpeedButton
            Left = 275
            Top = 1
            Width = 104
            Height = 25
            Align = alLeft
            Caption = 'Exportar [F6]'
            ParentShowHint = False
            ShowHint = True
            OnClick = BotaoExportarClick
            ExplicitLeft = 369
            ExplicitTop = 2
          end
          object BotaoImprimir: TSpeedButton
            Left = 389
            Top = 1
            Width = 104
            Height = 25
            Align = alLeft
            Caption = 'Imprimir [F7]'
            ParentShowHint = False
            ShowHint = True
            OnClick = BotaoImprimirClick
            ExplicitLeft = 489
            ExplicitTop = 0
          end
          object BotaoSair: TSpeedButton
            Left = 503
            Top = 1
            Width = 104
            Height = 25
            Align = alLeft
            Caption = 'Sair [F8]'
            ParentShowHint = False
            ShowHint = True
            OnClick = BotaoSairClick
            ExplicitLeft = 609
            ExplicitTop = 0
          end
          object BotaoSeparador2: TSpeedButton
            Left = 379
            Top = 1
            Width = 10
            Height = 25
            Align = alLeft
            Caption = '|'
            Flat = True
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            ExplicitTop = -4
          end
          object BotaoSeparador3: TSpeedButton
            Left = 161
            Top = 1
            Width = 10
            Height = 25
            Align = alLeft
            Caption = '|'
            Flat = True
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            ExplicitLeft = 157
            ExplicitTop = -4
          end
          object BotaoSeparador4: TSpeedButton
            Left = 493
            Top = 1
            Width = 10
            Height = 25
            Align = alLeft
            Caption = '|'
            Flat = True
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            ExplicitLeft = 683
            ExplicitTop = -4
          end
        end
      end
    end
    object PaginaEdits: TTabSheet
      Caption = 'PaginaEdits'
      ImageIndex = 1
      object PanelEdits: TPanel
        Left = 0
        Top = 0
        Width = 946
        Height = 426
        Align = alClient
        BevelInner = bvLowered
        BevelWidth = 2
        TabOrder = 0
        object PanelToolBarEdits: TPanel
          Left = 4
          Top = 4
          Width = 938
          Height = 27
          Align = alTop
          Color = clWhite
          ParentBackground = False
          TabOrder = 0
        end
      end
    end
  end
  object PopupMenuExportar: TPopupMenu
    TrackButton = tbLeftButton
    Left = 760
    object menuParaWord: TMenuItem
      Caption = 'Para Word'
      ImageIndex = 17
      OnClick = menuParaWordClick
    end
    object menuParaExcel: TMenuItem
      Caption = 'Para Excel'
      ImageIndex = 14
      OnClick = menuParaExcelClick
    end
    object menuParaXML: TMenuItem
      Caption = 'Para XML'
      ImageIndex = 18
      OnClick = menuParaXMLClick
    end
    object menuParaCSV: TMenuItem
      Caption = 'Para CSV'
      ImageIndex = 16
      OnClick = menuParaCSVClick
    end
    object menuParaHTML: TMenuItem
      Caption = 'Para HTML'
      ImageIndex = 15
      OnClick = menuParaHTMLClick
    end
  end
  object CDSGrid: TClientDataSet
    Aggregates = <>
    Params = <>
    AfterScroll = CDSGridAfterScroll
    Left = 696
  end
  object DSGrid: TDataSource
    AutoEdit = False
    DataSet = CDSGrid
    Left = 720
  end
end
