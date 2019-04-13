inherited FCompraCotacao: TFCompraCotacao
  Tag = 1
  Left = 326
  Top = 94
  Caption = 'Cota'#231#227'o'
  ClientHeight = 566
  ClientWidth = 992
  ExplicitLeft = 326
  ExplicitTop = 94
  ExplicitWidth = 1000
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 13
  inherited PageControl: TPageControl
    Width = 992
    Height = 535
    ActivePage = PaginaEdits
    ExplicitWidth = 892
    ExplicitHeight = 535
    inherited PaginaGrid: TTabSheet
      ExplicitWidth = 884
      inherited PanelGrid: TPanel
        Width = 984
        Height = 507
        ExplicitWidth = 884
        ExplicitHeight = 507
        inherited Grid: TJvDBUltimGrid
          Width = 984
          Height = 455
        end
        inherited PanelFiltroRapido: TPanel
          Top = 455
          Width = 984
          ExplicitTop = 455
          ExplicitWidth = 884
          inherited BotaoConsultar: TSpeedButton
            Left = 852
            ExplicitLeft = 825
          end
          inherited EditCriterioRapido: TLabeledMaskEdit
            Width = 683
            ExplicitWidth = 583
          end
        end
      end
    end
    inherited PaginaEdits: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 24
      ExplicitWidth = 884
      ExplicitHeight = 395
      inherited PanelEdits: TPanel
        Width = 984
        Height = 507
        ExplicitWidth = 884
        ExplicitHeight = 507
        object BevelEdits: TBevel
          Left = 11
          Top = 12
          Width = 963
          Height = 51
          Anchors = [akLeft, akTop, akRight]
          Constraints.MinWidth = 753
          ExplicitWidth = 863
        end
        object EditDescricao: TLabeledEdit
          Left = 150
          Top = 33
          Width = 815
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          EditLabel.Width = 50
          EditLabel.Height = 13
          EditLabel.Caption = 'Descri'#231#227'o:'
          TabOrder = 1
        end
        object EditDataCotacao: TLabeledDateEdit
          Left = 23
          Top = 33
          Width = 121
          Height = 21
          TabOrder = 0
          DateEditLabel.Width = 70
          DateEditLabel.Height = 13
          DateEditLabel.Caption = 'Data Cota'#231#227'o:'
        end
        object GroupBoxItensCotacao: TGroupBox
          Left = 696
          Top = 240
          Width = 278
          Height = 249
          Anchors = [akLeft, akTop, akRight, akBottom]
          Caption = 'Itens da Cota'#231#227'o:'
          TabOrder = 3
          object GridCompraCotacaoDetalhe: TJvDBUltimGrid
            Left = 2
            Top = 15
            Width = 274
            Height = 232
            Align = alClient
            DataSource = DSCompraCotacaoDetalhe
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
            OnUserSort = GridCompraCotacaoDetalheUserSort
            Columns = <
              item
                Expanded = False
                FieldName = 'ID'
                ReadOnly = True
                Title.Alignment = taCenter
                Visible = False
              end
              item
                Expanded = False
                FieldName = 'ID_COMPRA_FORNECEDOR_COTACAO'
                ReadOnly = True
                Title.Alignment = taCenter
                Visible = False
              end
              item
                Expanded = False
                FieldName = 'ID_PRODUTO'
                ReadOnly = True
                Title.Alignment = taCenter
                Width = 60
                Visible = True
              end
              item
                Color = clInfoBk
                Expanded = False
                FieldName = 'PRODUTO.NOME'
                ReadOnly = True
                Title.Alignment = taCenter
                Title.Caption = 'Nome Produto'
                Width = 200
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'QUANTIDADE'
                ReadOnly = True
                Title.Alignment = taCenter
                Width = 80
                Visible = True
              end>
          end
        end
        object GroupBoxFornecedores: TGroupBox
          Left = 11
          Top = 67
          Width = 963
          Height = 166
          Anchors = [akLeft, akTop, akRight]
          Caption = 'Fornecedores:'
          TabOrder = 2
          object GridCompraFornecedorCotacao: TJvDBUltimGrid
            Left = 2
            Top = 15
            Width = 959
            Height = 149
            Align = alClient
            DataSource = DSCompraFornecedorCotacao
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'Tahoma'
            TitleFont.Style = []
            OnKeyDown = GridCompraFornecedorCotacaoKeyDown
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
            OnUserSort = GridCompraFornecedorCotacaoUserSort
            Columns = <
              item
                Expanded = False
                FieldName = 'ID'
                ReadOnly = True
                Title.Alignment = taCenter
                Visible = False
              end
              item
                Expanded = False
                FieldName = 'ID_COMPRA_COTACAO'
                ReadOnly = True
                Title.Alignment = taCenter
                Visible = False
              end
              item
                Expanded = False
                FieldName = 'ID_FORNECEDOR'
                ReadOnly = True
                Title.Alignment = taCenter
                Width = 77
                Visible = True
              end
              item
                Color = clInfoBk
                Expanded = False
                FieldName = 'FORNECEDOR.PESSOA.NOME'
                ReadOnly = True
                Title.Alignment = taCenter
                Title.Caption = 'Nome Fornecedor'
                Width = 470
                Visible = True
              end>
          end
        end
        object GroupBoxCompraRequisicaoDetalhe: TGroupBox
          Left = 11
          Top = 240
          Width = 544
          Height = 249
          Anchors = [akLeft, akTop, akBottom]
          Caption = 'Itens de requisi'#231#245'es ainda n'#227'o cotados:'
          TabOrder = 4
          object GridCompraRequisicaoDetalhe: TJvDBUltimGrid
            Left = 2
            Top = 15
            Width = 540
            Height = 232
            Align = alClient
            DataSource = DSCompraRequisicaoDetalhe
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
                FieldName = 'ID_COMPRA_REQUISICAO'
                Title.Caption = 'Requisi'#231#227'o'
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'ID_PRODUTO'
                Title.Alignment = taCenter
                Title.Caption = 'Id Produto'
                Width = 60
                Visible = True
              end
              item
                Color = clInfoBk
                Expanded = False
                FieldName = 'PRODUTO.NOME'
                Title.Alignment = taCenter
                Title.Caption = 'Nome Produto'
                Width = 200
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'QUANTIDADE'
                Title.Alignment = taCenter
                Title.Caption = 'Quantidade'
                Width = 80
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'QUANTIDADE_COTADA'
                Title.Alignment = taCenter
                Title.Caption = 'Qtde. j'#225' Cotada'
                Width = 90
                Visible = True
              end>
          end
        end
        object PanelActions: TPanel
          Left = 559
          Top = 255
          Width = 131
          Height = 234
          Anchors = [akLeft, akTop, akBottom]
          TabOrder = 5
          object SpinEditQuantidade: TJvSpinEdit
            Left = 8
            Top = 44
            Width = 115
            Height = 21
            CheckMinValue = True
            CheckMaxValue = True
            ValueType = vtFloat
            TabOrder = 0
          end
          object ActionToolBar1: TActionToolBar
            Left = 1
            Top = 1
            Width = 129
            Height = 26
            ActionManager = ActionManager1
            Caption = 'ActionToolBar1'
            ColorMap.HighlightColor = 15660791
            ColorMap.BtnSelectedColor = clBtnFace
            ColorMap.UnusedColor = 15660791
            Spacing = 0
          end
          object ActionToolBar2: TActionToolBar
            Left = 1
            Top = 207
            Width = 129
            Height = 26
            ActionManager = ActionManager1
            Align = alBottom
            Caption = 'ActionToolBar2'
            ColorMap.HighlightColor = 15660791
            ColorMap.BtnSelectedColor = clBtnFace
            ColorMap.UnusedColor = 15660791
            Spacing = 0
          end
        end
      end
    end
  end
  inherited PanelToolBar: TPanel
    Width = 992
    ExplicitWidth = 892
    inherited BotaoSair: TSpeedButton
      Left = 888
      ExplicitLeft = 889
    end
    inherited BotaoExportar: TSpeedButton
      Left = 788
      ExplicitLeft = 799
    end
    inherited BotaoImprimir: TSpeedButton
      Left = 678
      ExplicitLeft = 719
    end
    inherited BotaoSeparador1: TSpeedButton
      Left = 778
      ExplicitLeft = 895
      ExplicitTop = -4
    end
    inherited BotaoFiltrar: TSpeedButton
      Left = 578
      ExplicitLeft = 639
    end
  end
  object DSCompraFornecedorCotacao: TDataSource
    DataSet = CDSCompraFornecedorCotacao
    Left = 736
    Top = 200
  end
  object DSCompraCotacaoDetalhe: TDataSource
    DataSet = CDSCompraCotacaoDetalhe
    Left = 760
    Top = 424
  end
  object CDSCompraFornecedorCotacao: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'ID'
        DataType = ftInteger
      end
      item
        Name = 'ID_FORNECEDOR'
        DataType = ftInteger
      end
      item
        Name = 'FORNECEDOR.PESSOA.NOME'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'ID_COMPRA_COTACAO'
        DataType = ftInteger
      end
      item
        Name = 'PRAZO_ENTREGA'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'CONDICOES_PAGAMENTO'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'VALOR_SUBTOTAL'
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
        Name = 'VALOR_DESCONTO'
        DataType = ftFMTBcd
        Precision = 15
        Size = 6
      end
      item
        Name = 'TOTAL'
        DataType = ftFMTBcd
        Precision = 15
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
    AfterEdit = CDSCompraFornecedorCotacaoAfterEdit
    Left = 736
    Top = 152
    Data = {
      A50100009619E0BD02000000180000000B000000000003000000A50102494404
      000100000000000D49445F464F524E454345444F52040001000000000016464F
      524E454345444F522E504553534F412E4E4F4D45010049000000010005574944
      54480200020064001149445F434F4D5052415F434F544143414F040001000000
      00000D5052415A4F5F454E545245474101004900000001000557494454480200
      02001E0013434F4E4449434F45535F504147414D454E544F0100490000000100
      055749445448020002001E000E56414C4F525F535542544F54414C0A00120000
      00020008444543494D414C53020002000600055749445448020002000F000D54
      4158415F444553434F4E544F0A0012000000020008444543494D414C53020002
      000600055749445448020002000F000E56414C4F525F444553434F4E544F0A00
      12000000020008444543494D414C53020002000600055749445448020002000F
      0005544F54414C0A0012000000020008444543494D414C530200020006000557
      49445448020002000F0008504552534953544501004900000001000557494454
      480200020001000000}
    object CDSCompraFornecedorCotacaoID: TIntegerField
      FieldName = 'ID'
    end
    object CDSCompraFornecedorCotacaoID_FORNECEDOR: TIntegerField
      DisplayLabel = 'Id Fornecedor'
      FieldName = 'ID_FORNECEDOR'
    end
    object CDSCompraFornecedorCotacaoID_COMPRA_COTACAO: TIntegerField
      DisplayLabel = 'Id Cota'#231#227'o'
      FieldName = 'ID_COMPRA_COTACAO'
    end
    object CDSCompraFornecedorCotacaoPRAZO_ENTREGA: TStringField
      DisplayLabel = 'Prazo de Entrega'
      FieldName = 'PRAZO_ENTREGA'
      Size = 30
    end
    object CDSCompraFornecedorCotacaoCONDICOES_PAGAMENTO: TStringField
      DisplayLabel = 'Condi'#231#245'es de Pagamento'
      FieldName = 'CONDICOES_PAGAMENTO'
      Size = 30
    end
    object CDSCompraFornecedorCotacaoVALOR_SUBTOTAL: TFMTBCDField
      DisplayLabel = 'Valor Subtotal'
      FieldName = 'VALOR_SUBTOTAL'
      DisplayFormat = '###,###,##0.00'
      Precision = 15
      Size = 6
    end
    object CDSCompraFornecedorCotacaoTAXA_DESCONTO: TFMTBCDField
      DisplayLabel = 'Taxa Desconto'
      FieldName = 'TAXA_DESCONTO'
      DisplayFormat = '###,###,##0.00'
      Precision = 15
      Size = 6
    end
    object CDSCompraFornecedorCotacaoVALOR_DESCONTO: TFMTBCDField
      DisplayLabel = 'Valor Desconto'
      FieldName = 'VALOR_DESCONTO'
      DisplayFormat = '###,###,##0.00'
      Precision = 15
      Size = 6
    end
    object CDSCompraFornecedorCotacaoTOTAL: TFMTBCDField
      DisplayLabel = 'Total'
      FieldName = 'TOTAL'
      DisplayFormat = '###,###,##0.00'
      Precision = 15
      Size = 6
    end
    object CDSCompraFornecedorCotacaoPERSISTE: TStringField
      FieldName = 'PERSISTE'
      Size = 1
    end
    object CDSCompraFornecedorCotacaoFORNECEDORPESSOANOME: TStringField
      FieldName = 'FORNECEDOR.PESSOA.NOME'
      Size = 100
    end
  end
  object CDSCompraCotacaoDetalhe: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'ID'
        DataType = ftInteger
      end
      item
        Name = 'ID_COMPRA_FORNECEDOR_COTACAO'
        DataType = ftInteger
      end
      item
        Name = 'ID_PRODUTO'
        DataType = ftInteger
      end
      item
        Name = 'PRODUTO.NOME'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'QUANTIDADE'
        DataType = ftFMTBcd
        Precision = 15
        Size = 6
      end
      item
        Name = 'QUANTIDADE_PEDIDA'
        DataType = ftFMTBcd
        Precision = 15
        Size = 6
      end
      item
        Name = 'VALOR_UNITARIO'
        DataType = ftFMTBcd
        Precision = 15
        Size = 6
      end
      item
        Name = 'VALOR_SUBTOTAL'
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
        Name = 'VALOR_DESCONTO'
        DataType = ftFMTBcd
        Precision = 15
        Size = 6
      end
      item
        Name = 'VALOR_TOTAL'
        DataType = ftFMTBcd
        Precision = 15
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
    AfterEdit = CDSCompraCotacaoDetalheAfterEdit
    Left = 760
    Top = 368
    Data = {
      F40100009619E0BD02000000180000000C000000000003000000F40102494404
      000100000000001C49445F434F4D5052415F464F524E454345444F525F434F54
      4143414F04000100000000000A49445F50524F4455544F04000100000000000C
      50524F4455544F2E4E4F4D450100490000000100055749445448020002006400
      0A5155414E5449444144450A0012000000020008444543494D414C5302000200
      0600055749445448020002000F00115155414E5449444144455F504544494441
      0A0012000000020008444543494D414C53020002000600055749445448020002
      000F000E56414C4F525F554E49544152494F0A0012000000020008444543494D
      414C53020002000600055749445448020002000F000E56414C4F525F53554254
      4F54414C0A0012000000020008444543494D414C530200020006000557494454
      48020002000F000D544158415F444553434F4E544F0A00120000000200084445
      43494D414C53020002000600055749445448020002000F000E56414C4F525F44
      4553434F4E544F0A0012000000020008444543494D414C530200020006000557
      49445448020002000F000B56414C4F525F544F54414C0A001200000002000844
      4543494D414C53020002000600055749445448020002000F0008504552534953
      544501004900000001000557494454480200020001000000}
    object CDSCompraCotacaoDetalheID: TIntegerField
      FieldName = 'ID'
    end
    object CDSCompraCotacaoDetalheID_COMPRA_FORNECEDOR_COTACAO: TIntegerField
      DisplayLabel = 'Id Fornecedor'
      FieldName = 'ID_COMPRA_FORNECEDOR_COTACAO'
    end
    object CDSCompraCotacaoDetalheID_PRODUTO: TIntegerField
      DisplayLabel = 'Id Produto'
      FieldName = 'ID_PRODUTO'
    end
    object CDSCompraCotacaoDetalheQUANTIDADE: TFMTBCDField
      DisplayLabel = 'Quantidade'
      FieldName = 'QUANTIDADE'
      DisplayFormat = '###,###,##0.00'
      Precision = 15
      Size = 6
    end
    object CDSCompraCotacaoDetalheQUANTIDADE_PEDIDA: TFMTBCDField
      FieldName = 'QUANTIDADE_PEDIDA'
      DisplayFormat = '###,###,##0.00'
      Precision = 15
      Size = 6
    end
    object CDSCompraCotacaoDetalheVALOR_UNITARIO: TFMTBCDField
      DisplayLabel = 'Valor Unit'#225'rio'
      FieldName = 'VALOR_UNITARIO'
      DisplayFormat = '###,###,##0.00'
      Precision = 15
      Size = 6
    end
    object CDSCompraCotacaoDetalheVALOR_SUBTOTAL: TFMTBCDField
      DisplayLabel = 'Valor Subtotal'
      FieldName = 'VALOR_SUBTOTAL'
      DisplayFormat = '###,###,##0.00'
      Precision = 15
      Size = 6
    end
    object CDSCompraCotacaoDetalheTAXA_DESCONTO: TFMTBCDField
      DisplayLabel = 'Taxa Desconto'
      FieldName = 'TAXA_DESCONTO'
      DisplayFormat = '###,###,##0.00'
      Precision = 15
      Size = 6
    end
    object CDSCompraCotacaoDetalheVALOR_DESCONTO: TFMTBCDField
      DisplayLabel = 'Valor Desconto'
      FieldName = 'VALOR_DESCONTO'
      DisplayFormat = '###,###,##0.00'
      Precision = 15
      Size = 6
    end
    object CDSCompraCotacaoDetalheVALOR_TOTAL: TFMTBCDField
      DisplayLabel = 'Valor Total'
      FieldName = 'VALOR_TOTAL'
      DisplayFormat = '###,###,##0.00'
      Precision = 15
      Size = 6
    end
    object CDSCompraCotacaoDetalhePERSISTE: TStringField
      FieldName = 'PERSISTE'
      Size = 1
    end
    object CDSCompraCotacaoDetalhePRODUTONOME: TStringField
      FieldName = 'PRODUTO.NOME'
      Size = 100
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
        Name = 'PRODUTO.NOME'
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
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    AfterScroll = CDSCompraRequisicaoDetalheAfterScroll
    Left = 152
    Top = 368
    Data = {
      F90000009619E0BD020000001800000007000000000003000000F90002494404
      000100000000000A49445F50524F4455544F04000100000000000C50524F4455
      544F2E4E4F4D4501004900000001000557494454480200020064001449445F43
      4F4D5052415F5245515549534943414F04000100000000000A5155414E544944
      4144450A0012000000020008444543494D414C53020002000600055749445448
      020002000F00115155414E5449444144455F434F544144410A00120000000200
      08444543494D414C53020002000600055749445448020002000F000B4954454D
      5F434F5441444F01004900000001000557494454480200020001000000}
    object CDSCompraRequisicaoDetalheID: TIntegerField
      FieldName = 'ID'
    end
    object CDSCompraRequisicaoDetalheID_PRODUTO: TIntegerField
      FieldName = 'ID_PRODUTO'
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
    object CDSCompraRequisicaoDetalhePRODUTONOME: TStringField
      FieldName = 'PRODUTO.NOME'
      Size = 100
    end
    object CDSCompraRequisicaoDetalheITEM_COTADO: TStringField
      FieldName = 'ITEM_COTADO'
      Size = 1
    end
  end
  object DSCompraRequisicaoDetalhe: TDataSource
    DataSet = CDSCompraRequisicaoDetalhe
    Left = 152
    Top = 416
  end
  object ActionManager1: TActionManager
    ActionBars = <
      item
        Items = <
          item
            Action = ActionInserirCotacao
            Caption = '&Inserir na Cota'#231#227'o'
            ImageIndex = 38
          end>
        ActionBar = ActionToolBar1
      end
      item
        Items = <
          item
            Action = ActionRetirarCotacao
            Caption = '&Retirar da Cota'#231#227'o'
            ImageIndex = 39
          end>
        ActionBar = ActionToolBar2
      end
      item
      end>
    DisabledImages = FDataModule.ImagensCadastrosD
    Images = FDataModule.ImagensCadastros
    Left = 871
    Top = 186
    StyleName = 'Platform Default'
    object ActionInserirCotacao: TAction
      Caption = 'Inserir na Cota'#231#227'o'
      ImageIndex = 38
      OnExecute = ActionInserirCotacaoExecute
    end
    object ActionRetirarCotacao: TAction
      Caption = 'Retirar da Cota'#231#227'o'
      ImageIndex = 39
      OnExecute = ActionRetirarCotacaoExecute
    end
  end
end
