inherited FCompraRequisicao: TFCompraRequisicao
  Left = 342
  Top = 220
  Caption = 'Requisi'#231#227'o'
  ClientWidth = 933
  ExplicitLeft = 342
  ExplicitTop = 220
  ExplicitWidth = 941
  ExplicitHeight = 488
  PixelsPerInch = 96
  TextHeight = 13
  inherited PageControl: TPageControl
    Width = 933
    ActivePage = PaginaEdits
    ExplicitWidth = 933
    inherited PaginaGrid: TTabSheet
      ExplicitWidth = 925
      inherited PanelGrid: TPanel
        Width = 925
        ExplicitWidth = 925
        inherited Grid: TJvDBUltimGrid
          Width = 925
        end
        inherited PanelFiltroRapido: TPanel
          Width = 925
          ExplicitWidth = 925
          inherited BotaoConsultar: TSpeedButton
            Left = 793
            ExplicitLeft = 790
          end
          inherited EditCriterioRapido: TLabeledMaskEdit
            Width = 624
            ExplicitWidth = 624
          end
        end
      end
    end
    inherited PaginaEdits: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 24
      ExplicitWidth = 925
      ExplicitHeight = 395
      inherited PanelEdits: TPanel
        Width = 925
        ExplicitWidth = 925
        object BevelEdits: TBevel
          Left = 10
          Top = 12
          Width = 905
          Height = 97
          Anchors = [akLeft, akTop, akRight]
          Constraints.MinWidth = 753
        end
        object GroupBoxCompraRequisicaoDetalhe: TGroupBox
          Left = 10
          Top = 119
          Width = 905
          Height = 265
          Anchors = [akLeft, akTop, akRight, akBottom]
          Caption = 'Itens da Requisi'#231#227'o'
          TabOrder = 5
          object GridCompraRequisicaoDetalhe: TJvDBUltimGrid
            Left = 2
            Top = 15
            Width = 901
            Height = 248
            Align = alClient
            DataSource = DSCompraRequisicaoDetalhe
            PopupMenu = PopupMenuCompraRequisicaoDetalhe
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'Tahoma'
            TitleFont.Style = []
            OnKeyDown = GridCompraRequisicaoDetalheKeyDown
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
            OnUserSort = GridCompraRequisicaoDetalheUserSort
            Columns = <
              item
                Expanded = False
                FieldName = 'ID'
                Title.Alignment = taCenter
                Visible = False
              end
              item
                Expanded = False
                FieldName = 'ID_PRODUTO'
                Title.Alignment = taCenter
                Title.Caption = 'Id Produto'
                Visible = True
              end
              item
                Color = clInfoBk
                Expanded = False
                FieldName = 'ProdutoNome'
                ReadOnly = True
                Title.Alignment = taCenter
                Title.Caption = 'Nome Produto'
                Width = 500
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'QUANTIDADE'
                Title.Alignment = taCenter
                Title.Caption = 'Quantidade'
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'QUANTIDADE_COTADA'
                ReadOnly = True
                Title.Alignment = taCenter
                Title.Caption = 'Quantidade J'#225' Cotada'
                Width = 120
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'ITEM_COTADO'
                ReadOnly = True
                Title.Alignment = taCenter
                Title.Caption = 'Item Cotado'
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'ID_COMPRA_REQUISICAO'
                Visible = False
              end>
          end
        end
        object EditIdCompraTipoRequisicao: TLabeledCalcEdit
          Left = 145
          Top = 35
          Width = 61
          Height = 21
          DisplayFormat = '#'
          ShowButton = False
          TabOrder = 1
          DecimalPlacesAlwaysShown = False
          OnExit = EditIdCompraTipoRequisicaoExit
          OnKeyDown = EditIdCompraTipoRequisicaoKeyDown
          OnKeyPress = EditIdCompraTipoRequisicaoKeyPress
          CalcEditLabel.Width = 116
          CalcEditLabel.Height = 13
          CalcEditLabel.Caption = 'Tipo de Requisi'#231#227'o [F1]:'
        end
        object EditIdColaborador: TLabeledCalcEdit
          Left = 18
          Top = 77
          Width = 61
          Height = 21
          DisplayFormat = '#'
          ParentShowHint = False
          ShowButton = False
          ShowHint = False
          TabOrder = 3
          DecimalPlacesAlwaysShown = False
          OnExit = EditIdColaboradorExit
          OnKeyDown = EditIdColaboradorKeyDown
          OnKeyPress = EditIdColaboradorKeyPress
          CalcEditLabel.Width = 87
          CalcEditLabel.Height = 13
          CalcEditLabel.Caption = 'Requisitante [F1]:'
        end
        object EditColaborador: TLabeledEdit
          Left = 79
          Top = 77
          Width = 827
          Height = 21
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          Color = clInfoBk
          EditLabel.Width = 6
          EditLabel.Height = 13
          EditLabel.Caption = '  '
          ReadOnly = True
          TabOrder = 4
        end
        object EditCompraTipoRequisicao: TLabeledEdit
          Left = 206
          Top = 35
          Width = 700
          Height = 21
          TabStop = False
          Anchors = [akLeft, akTop, akRight]
          Color = clInfoBk
          EditLabel.Width = 6
          EditLabel.Height = 13
          EditLabel.Caption = '  '
          ReadOnly = True
          TabOrder = 2
        end
        object EditDataRequisicao: TLabeledDateEdit
          Left = 18
          Top = 35
          Width = 121
          Height = 21
          TabOrder = 0
          DateEditLabel.Width = 23
          DateEditLabel.Height = 13
          DateEditLabel.Caption = 'Data'
        end
      end
    end
  end
  inherited PanelToolBar: TPanel
    Width = 933
    ExplicitWidth = 933
    inherited BotaoSair: TSpeedButton
      Left = 829
      ExplicitLeft = 826
    end
    inherited BotaoExportar: TSpeedButton
      Left = 729
      ExplicitLeft = 726
    end
    inherited BotaoImprimir: TSpeedButton
      Left = 629
      ExplicitLeft = 626
    end
    inherited BotaoSeparador1: TSpeedButton
      Left = 519
      ExplicitLeft = 516
    end
    inherited BotaoFiltrar: TSpeedButton
      Left = 529
      ExplicitLeft = 526
    end
  end
  object CDSCompraRequisicaoDetalhe: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'ID'
        DataType = ftInteger
      end
      item
        Name = 'ID_PRODUTO'
        DataType = ftInteger
      end
      item
        Name = 'ProdutoNome'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'ID_COMPRA_REQUISICAO'
        DataType = ftInteger
      end
      item
        Name = 'QUANTIDADE'
        DataType = ftFMTBcd
        Precision = 15
        Size = 6
      end
      item
        Name = 'QUANTIDADE_COTADA'
        DataType = ftFMTBcd
        Precision = 15
        Size = 6
      end
      item
        Name = 'ITEM_COTADO'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'PERSISTE'
        DataType = ftString
        Size = 1
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    AfterEdit = CDSCompraRequisicaoDetalheAfterEdit
    Left = 712
    Top = 264
    Data = {
      150100009619E0BD020000001800000008000000000003000000150102494404
      000100000000000A49445F50524F4455544F04000100000000000B50726F6475
      746F4E6F6D6501004900000001000557494454480200020064001449445F434F
      4D5052415F5245515549534943414F04000100000000000A5155414E54494441
      44450A0012000000020008444543494D414C5302000200060005574944544802
      0002000F00115155414E5449444144455F434F544144410A0012000000020008
      444543494D414C53020002000600055749445448020002000F000B4954454D5F
      434F5441444F0100490000000100055749445448020002000100085045525349
      53544501004900000001000557494454480200020001000000}
    object CDSCompraRequisicaoDetalheID: TIntegerField
      FieldName = 'ID'
    end
    object CDSCompraRequisicaoDetalheID_PRODUTO: TIntegerField
      FieldName = 'ID_PRODUTO'
    end
    object CDSCompraRequisicaoDetalheProdutoNome: TStringField
      FieldName = 'ProdutoNome'
      Size = 100
    end
    object CDSCompraRequisicaoDetalheID_COMPRA_REQUISICAO: TIntegerField
      FieldName = 'ID_COMPRA_REQUISICAO'
    end
    object CDSCompraRequisicaoDetalheQUANTIDADE: TFMTBCDField
      FieldName = 'QUANTIDADE'
      DisplayFormat = '###,###,##0.00'
      Precision = 15
      Size = 6
    end
    object CDSCompraRequisicaoDetalheQUANTIDADE_COTADA: TFMTBCDField
      FieldName = 'QUANTIDADE_COTADA'
      DisplayFormat = '###,###,##0.00'
      Precision = 15
      Size = 6
    end
    object CDSCompraRequisicaoDetalhePERSISTE: TStringField
      FieldName = 'PERSISTE'
      Size = 1
    end
    object CDSCompraRequisicaoDetalheITEM_COTADO: TStringField
      FieldName = 'ITEM_COTADO'
      Size = 1
    end
  end
  object DSCompraRequisicaoDetalhe: TDataSource
    DataSet = CDSCompraRequisicaoDetalhe
    Left = 720
    Top = 312
  end
  object PopupMenuCompraRequisicaoDetalhe: TPopupMenu
    Left = 246
    Top = 262
    object Excluir1: TMenuItem
      Bitmap.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FFFFFF00FFFF
        FF0025B6FF6025B6FFCF25B6FFFF25B6FFFF25B6FFFF25B6FFFF25B6FFFF25B6
        FFFF25B6FFFF25B6FFFF25B6FFCF25B6FF60FFFFFF00FFFFFF00FFFFFF00FFFF
        FF0025B6FFEF21B3FFFB33BCFFFF63D4FFFF76DCFFFF6DDCFFFF60DDFFFF66E1
        FFFF63DFFFFF43CFFFFF2EC0FFFB25B6FFEFFFFFFF00FFFFFF00FFFFFF00FFFF
        FF0025B6FFFF4DC8FFFF63D4FFFF9DE8FFFFB7F0FFFFA4EEFFFF8BECFFFF8FEE
        FFFF8CEDFFFF6FE1FFFF32C1FFFF25B6FFFFFFFFFF00FFFFFF00FFFFFF00FFFF
        FF0025B6FFFF72D6FFFF60D3FFFF99E6FFFFB4EFFFFF9DEBFFFF1F33AAFF0202
        92FF020292FF020292FF020292FF020292FF020292FF020292CFFFFFFF00FFFF
        FF0025B6FFFF8BDEFFFF5DD3FFFF95E5FFFFAFEDFFFF96E8FFFF0A0A97FF7171
        F3FF7474F4FF6B6BF4FF3D3DE3FF1515C4FF0303A9FF020292FFFFFFFF00FFFF
        FF0025B6FFFFA4E5FFFF58D2FFFF90E4FFFFAAEAFFFF8DE4FFFF1B31AAFF0A0A
        97FF0A0A97FF0A0A97FF0A0A97FF0A0A97FF0A0A97FF020292CFFFFFFF00FFFF
        FF0025B6FFFFBDECFFFF5DD4FFFF8BE3FFFFA5EAFFFF84E1FFFF58D7FFFF57D6
        FFFF55D6FFFF45CDFFFF4BC8FFFF25B6FFFFFFFFFF00FFFFFF00FFFFFF00FFFF
        FF0025B6FFF594DEFFFCC1EDFFFFD2F4FFFFD5F5FFFFD4F5FFFFD2F4FFFFD2F4
        FFFFD2F4FFFFCEF1FFFF90DDFFFD25B6FFF4FFFFFF00FFFFFF00FFFFFF00FFFF
        FF0025B6FFF41FB2FFFD2EBCFFFF49CBFFFF57D3FFFF55D5FFFF50D8FFFF56DC
        FFFF53DAFFFF41CEFFFF2ABEFFFD25B6FFF5FFFFFF00FFFFFF00FFFFFF00FFFF
        FF0025B6FFFF46C3FFFF61D3FFFF9CE8FFFFB8F0FFFFA5EEFFFF8DECFFFF91EF
        FFFF8EEDFFFF70E2FFFF32C2FFFF26BAFFFFFFFFFF00FFFFFF00FFFFFF00FFFF
        FF0025B6FFFF6FD5FFFF5FD3FFFF99E6FFFFB5EFFFFF9FECFFFF82E7FFFF84E9
        FFFF81E8FFFF67DEFFFF31C0FFFF26BAFFFFFFFFFF00FFFFFF00FFFFFF00FFFF
        FF0025B6FFFF87DCFFFF5CD2FFFF95E5FFFFB0EDFFFF98E9FFFF76E2FFFF75E3
        FFFF73E2FFFF5DD9FFFF2DBDFFFF26BAFFFFFFFFFF00FFFFFF00FFFFFF00FFFF
        FF0025B6FFFFA0E4FFFF58D2FFFF90E3FFFFABEBFFFF8FE5FFFF68DDFFFF67DD
        FFFF66DDFFFF52D3FFFF28B9FFFF26BAFFFFFFFFFF00FFFFFF00FFFFFF00FFFF
        FF0025B6FFFFB9EBFFFF53D2FFFF8BE3FFFFA6E9FFFF87E2FFFF5BD7FFFF59D7
        FFFF57D7FFFF47CEFFFF38BFFFFF26BAFFFFFFFFFF00FFFFFF00FFFFFF00FFFF
        FF0025B6FFEFA9E5FFFBC5F0FFFFC0F0FFFFCBF3FFFFC0F0FFFFB2ECFFFFB1EC
        FFFFB0ECFFFFBCEEFFFF9EE4FFFC2AB9FFF0FFFFFF00FFFFFF00FFFFFF00FFFF
        FF0025B6FF6025B6FFCF25B6FFFF25B6FFFF25B6FFFF25B6FFFF25B6FFFF25B6
        FFFF25B6FFFF25B6FFFF25B6FFDF25B6FF60FFFFFF00FFFFFF00}
      Caption = 'Excluir'
      ShortCut = 16430
      OnClick = Excluir1Click
    end
  end
end
