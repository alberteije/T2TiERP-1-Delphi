object FMovimentoCaixaBanco: TFMovimentoCaixaBanco
  Tag = 1
  Left = 197
  Top = 186
  Caption = 'Movimento Caixa / Banco'
  ClientHeight = 468
  ClientWidth = 1000
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnPaint = FormPaint
  PixelsPerInch = 96
  TextHeight = 13
  object PanelGrid: TPanel
    Left = 0
    Top = 35
    Width = 1000
    Height = 433
    Align = alClient
    BevelInner = bvLowered
    BevelWidth = 2
    TabOrder = 1
    object Grid: TJvDBUltimGrid
      Left = 4
      Top = 4
      Width = 992
      Height = 373
      Align = alClient
      DataSource = FDataModule.DSMovimentoCaixaBanco
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
      Top = 377
      Width = 992
      Height = 52
      Align = alBottom
      Color = 14537936
      ParentBackground = False
      TabOrder = 1
      DesignSize = (
        992
        52)
      object Bevel1: TBevel
        Left = 8
        Top = 7
        Width = 978
        Height = 40
        Anchors = [akLeft, akTop, akRight]
        ExplicitWidth = 873
      end
      object Label1: TLabel
        Left = 23
        Top = 10
        Width = 72
        Height = 13
        Caption = 'Saldo Anterior:'
      end
      object Label2: TLabel
        Left = 203
        Top = 10
        Width = 71
        Height = 13
        Caption = 'Recebimentos:'
      end
      object Label3: TLabel
        Left = 373
        Top = 10
        Width = 63
        Height = 13
        Caption = 'Pagamentos:'
      end
      object Label4: TLabel
        Left = 532
        Top = 10
        Width = 62
        Height = 13
        Caption = 'Saldo Conta:'
      end
      object Label5: TLabel
        Left = 703
        Top = 10
        Width = 88
        Height = 13
        Caption = 'N'#227'o Compensado:'
      end
      object Label6: TLabel
        Left = 891
        Top = 10
        Width = 81
        Height = 13
        Caption = 'Saldo Dispon'#237'vel:'
      end
      object LabelSaldoAnterior: TLabel
        Left = 11
        Top = 28
        Width = 84
        Height = 13
        Alignment = taRightJustify
        Caption = 'Saldo Anterior:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object LabelRecebimentos: TLabel
        Left = 190
        Top = 28
        Width = 84
        Height = 13
        Alignment = taRightJustify
        Caption = 'Recebimentos:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object LabelPagamentos: TLabel
        Left = 362
        Top = 28
        Width = 74
        Height = 13
        Alignment = taRightJustify
        Caption = 'Pagamentos:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object LabelSaldoConta: TLabel
        Left = 524
        Top = 28
        Width = 70
        Height = 13
        Alignment = taRightJustify
        Caption = 'Saldo Conta:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object LabelNaoCompensado: TLabel
        Left = 691
        Top = 28
        Width = 100
        Height = 13
        Alignment = taRightJustify
        Caption = 'N'#227'o Compensado:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object LabelSaldoDisponivel: TLabel
        Left = 877
        Top = 28
        Width = 95
        Height = 13
        Alignment = taRightJustify
        Caption = 'Saldo Dispon'#237'vel:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
  end
  object PanelToolBar: TPanel
    Left = 0
    Top = 0
    Width = 1000
    Height = 35
    Align = alTop
    Color = 14537936
    ParentBackground = False
    TabOrder = 0
    object ActionToolBarGrid: TActionToolBar
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 992
      Height = 27
      ActionManager = ActionManager
      Align = alClient
      BiDiMode = bdLeftToRight
      Caption = 'ActionToolBarGrid'
      ColorMap.BtnSelectedColor = clBtnFace
      ColorMap.UnusedColor = 14410210
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentBiDiMode = False
      ParentFont = False
      Spacing = 5
    end
  end
  object ActionManager: TActionManager
    ActionBars.ShowHints = False
    ActionBars = <
      item
      end
      item
        Items = <
          item
            Action = ActionPaginaAnterior
            Caption = '&P'#225'gina Anterior'
            ImageIndex = 24
            ShowCaption = False
            ShortCut = 16421
          end
          item
            Action = ActionPrimeiro
            Caption = 'P&rimeiro Registro'
            ImageIndex = 20
            ShowCaption = False
          end
          item
            Action = ActionAnterior
            Caption = 'R&egistro Anterior'
            ImageIndex = 19
            ShowCaption = False
          end
          item
            Action = ActionProximo
            Caption = 'Pr'#243'&ximo Registro'
            ImageIndex = 22
            ShowCaption = False
          end
          item
            Action = ActionUltimo
            Caption = #218'&ltimo Registro'
            ImageIndex = 21
            ShowCaption = False
          end
          item
            Action = ActionPaginaProxima
            Caption = 'Pr'#243'x&ima P'#225'gina'
            ImageIndex = 23
            ShowCaption = False
            ShortCut = 16423
          end
          item
            Caption = '-'
          end
          item
            Action = ActionFechamento
            Caption = '&Fechamento'
            ImageIndex = 32
          end
          item
            Items = <
              item
                Action = ActionExportarWord
                ImageIndex = 17
              end
              item
                Action = ActionExportarExcel
                ImageIndex = 14
              end
              item
                Action = ActionExportarHTML
                ImageIndex = 15
              end
              item
                Action = ActionExportarCSV
                ImageIndex = 16
              end
              item
                Action = ActionExportarXML
                ImageIndex = 18
              end>
            Action = ActionExportar
            Caption = 'Exp&ortar [F6]'
            CommandStyle = csComboBox
            ImageIndex = 13
            ShortCut = 117
            CommandProperties.Width = -1
          end
          item
            Items = <
              item
                Action = ActionExportarWord
                ImageIndex = 17
              end
              item
                Action = ActionExportarExcel
                ImageIndex = 14
              end
              item
                Action = ActionExportarHTML
                ImageIndex = 15
              end
              item
                Action = ActionExportarXML
                ImageIndex = 18
              end
              item
                Action = ActionExportarCSV
                ImageIndex = 16
              end>
            Action = ActionExportar
            Caption = 'Expor&tar [F6]'
            ImageIndex = 13
            ShortCut = 117
            CommandProperties.ButtonType = btDropDown
          end
          item
            Action = ActionImprimir
            Caption = 'I&mprimir [F7]'
            ImageIndex = 4
            ShortCut = 118
          end
          item
            Caption = '-'
          end
          item
            Action = ActionSair
            Caption = '&Sair [F8]'
            ImageIndex = 12
            ShortCut = 119
          end
          item
            Caption = '-'
          end
          item
            Action = ActionInformacoes
          end>
        ActionBar = ActionToolBarGrid
      end
      item
      end
      item
        Items = <
          item
            Action = ActionFechamento
            Caption = '&Fechamento'
            ImageIndex = 29
          end>
      end>
    DisabledImages = FDataModule.ImagensCadastrosD
    Images = FDataModule.ImagensCadastros
    Left = 792
    Top = 352
    StyleName = 'Ribbon - Silver'
    object ActionImprimir: TAction
      Category = 'Cadastro'
      Caption = 'Imprimir [F7]'
      ImageIndex = 4
      ShortCut = 118
    end
    object ActionPrimeiro: TAction
      Category = 'Navegacao'
      Caption = 'Primeiro Registro'
      ImageIndex = 20
      OnExecute = ActionPrimeiroExecute
    end
    object ActionUltimo: TAction
      Category = 'Navegacao'
      Caption = #218'ltimo Registro'
      ImageIndex = 21
      OnExecute = ActionUltimoExecute
    end
    object ActionAnterior: TAction
      Category = 'Navegacao'
      Caption = 'Registro Anterior'
      ImageIndex = 19
      OnExecute = ActionAnteriorExecute
    end
    object ActionProximo: TAction
      Category = 'Navegacao'
      Caption = 'Pr'#243'ximo Registro'
      ImageIndex = 22
      OnExecute = ActionProximoExecute
    end
    object ActionSair: TAction
      Category = 'Cadastro'
      Caption = 'Sair [F8]'
      ImageIndex = 12
      ShortCut = 119
      OnExecute = ActionSairExecute
    end
    object ActionExportar: TAction
      Category = 'Cadastro'
      Caption = 'Exportar [F6]'
      ImageIndex = 13
      ShortCut = 117
      OnExecute = ActionExportarExecute
    end
    object ActionExportarWord: TAction
      Category = 'Exportacao'
      Caption = 'para &Word'
      ImageIndex = 17
      OnExecute = ActionExportarWordExecute
    end
    object ActionExportarExcel: TAction
      Category = 'Exportacao'
      Caption = 'para &Excel'
      ImageIndex = 14
      OnExecute = ActionExportarExcelExecute
    end
    object ActionExportarXML: TAction
      Category = 'Exportacao'
      Caption = 'para &XML'
      ImageIndex = 18
      OnExecute = ActionExportarXMLExecute
    end
    object ActionExportarCSV: TAction
      Category = 'Exportacao'
      Caption = 'para &CSV'
      ImageIndex = 16
      OnExecute = ActionExportarCSVExecute
    end
    object ActionExportarHTML: TAction
      Category = 'Exportacao'
      Caption = 'para &HTML'
      ImageIndex = 15
      OnExecute = ActionExportarHTMLExecute
    end
    object ActionPaginaAnterior: TAction
      Category = 'Navegacao'
      Caption = 'P'#225'gina Anterior'
      ImageIndex = 24
      ShortCut = 16421
    end
    object ActionPaginaProxima: TAction
      Category = 'Navegacao'
      Caption = 'Pr'#243'xima P'#225'gina'
      ImageIndex = 23
      ShortCut = 16423
    end
    object ActionFechamento: TAction
      Category = 'Movimento'
      Caption = 'Fechamento'
      ImageIndex = 32
      OnExecute = ActionFechamentoExecute
    end
    object ActionInformacoes: TAction
      Category = 'Movimento'
      OnExecute = ActionInformacoesExecute
    end
  end
  object ScreenTipsManagerCadastro: TScreenTipsManager
    FooterImage.Data = {
      07544269746D61709E020000424D9E0200000000000036000000280000000E00
      00000E000000010018000000000068020000C40E0000C40E0000000000000000
      0000FF0099FF0099FF0099B8B8B8DADADABDAFAAC7ACA2C9AEA3C1B3ADE7E7E7
      CFCFCFFF0099FF0099FF00990000FF0099FF0099C7C7C7BDA49BA65336B85029
      BC532AC1572BC55A2CB86039CBB0A4D9D9D9FF0099FF00990000FF0099C7C7C7
      9D6B5CAE4927B24C28BC6241DCBCAFDDAF9CC2582BC5592CC4592BB37E68D9D9
      D9FF00990000C7C7C7B9A099A84426AC4727B14B28C18E7CCFCFCFE3E3E3BF55
      2AC0562BC0562BBE552AC8AEA4CFCFCF0000DCDCDCA4543AA84627AA4626AE49
      27B25231B5826FC4836BBA522ABB532ABB532ABA5229AA5636E7E7E70000BEB1
      ADB0502FB65631A84426AB4727AD5B3FA8A8A8AB9188B64F29B75029B64F29B5
      4E29B34D28BFB1AC0000C2ABA3B35633BD6138B85932A84426AB4727A2A2A2A7
      A7A7AE5C3FB24C28B24C28B14B28AF4A27C4ABA20000C8B2AAB55B37BD643BC2
      693CBE6338AF4E2CA66855A8A8A8A9A3A1B3684EAD4827AC4827AB4726C2A9A1
      0000CFC6C2B96744BC673EC06A3EC26B3EC46C3DBF6538BF907CC7C7C7CFC2BE
      AA4727AE4B29AC4929BCAFAB0000EBEBEBC89780BB6A42BE6C41C98B6ADCC1B2
      CF9474DBBAA9E8E8E8EEEEEEC06137BA5932A6553BDBDBDB0000B8B8B8EBE3E0
      C2805DBB6F45CA8F6FF4F4F4F5F5F5F5F5F5F6F6F6E5C9BCBB5E37B25230C0A7
      A0C7C7C70000FF0099CECECEDBCAC1C2835FBE7952D8AE96E9D1C4EEDACFD9AA
      93BF6C47B45936A37465C7C7C7FF00990000FF0099FF0099DCDCDCEBE4E1C9A0
      87BC7751B96F46BA6C44B96740B06B4DC1AAA2C7C7C7FF0099FF00990000FF00
      99FF0099FF0099D6D6D6ECECECD3CCC8D1BFB5CEBBB2C9BFBADEDEDEB8B8B8FF
      0099FF0099FF00990000}
    LinkedActionLists = <
      item
        ActionList = ActionManager
        Caption = 'ActionManager'
      end>
    Options = [soShowHeader]
    ScreenTips = <
      item
        Action = ActionImprimir
        Description.Strings = (
          'Utilize este bot'#227'o para gerar o relat'#243'rio.')
        Header = 'Imprimir [F7]'
        ShowFooter = False
      end
      item
        Action = ActionPrimeiro
        Description.Strings = (
          'Utilize este bot'#227'o para navegar para o primeiro registro.')
        Header = 'Primeiro Registro'
        ShowFooter = False
      end
      item
        Action = ActionUltimo
        Description.Strings = (
          'Utilize este bot'#227'o para navegar para o '#250'ltimo registro.')
        Header = #218'ltimo Registro'
        ShowFooter = False
      end
      item
        Action = ActionAnterior
        Description.Strings = (
          'Utilize este bot'#227'o para navegar para o registro anterior.')
        Header = 'Registro Anterior'
        ShowFooter = False
      end
      item
        Action = ActionProximo
        Description.Strings = (
          'Utilize este bot'#227'o para navegar para o pr'#243'ximo registro.')
        Header = 'Pr'#243'ximo Registro'
        ShowFooter = False
      end
      item
        Action = ActionSair
        Description.Strings = (
          'Utilize este bot'#227'o para fechar a janela atual.')
        Header = 'Sair [F8]'
        ShowFooter = False
      end
      item
        Action = ActionExportar
        Description.Strings = (
          'Utilize este bot'#227'o para acessar as op'#231#245'es de exporta'#231#227'o.')
        Header = 'Exportar [F6]'
        ShowFooter = False
      end
      item
        Action = ActionExportarWord
        Description.Strings = (
          
            'Utilize este bot'#227'o para exportar os dados vis'#237'veis para o format' +
            'o do Word.')
        Header = 'para Word'
        ShowFooter = False
      end
      item
        Action = ActionExportarExcel
        Description.Strings = (
          
            'Utilize este bot'#227'o para exportar os dados vis'#237'veis para o format' +
            'o do Excel.')
        Header = 'para Excel'
        ShowFooter = False
      end
      item
        Action = ActionExportarXML
        Description.Strings = (
          
            'Utilize este bot'#227'o para exportar os dados vis'#237'veis para o format' +
            'o XML.')
        Header = 'para XML'
        ShowFooter = False
      end
      item
        Action = ActionExportarCSV
        Description.Strings = (
          
            'Utilize este bot'#227'o para exportar os dados vis'#237'veis para o format' +
            'o CSV.')
        Header = 'para CSV'
        ShowFooter = False
      end
      item
        Action = ActionExportarHTML
        Description.Strings = (
          
            'Utilize este bot'#227'o para exportar os dados vis'#237'veis para o format' +
            'o HTML.')
        Header = 'para HTML'
        ShowFooter = False
      end
      item
        Action = ActionPaginaAnterior
        Description.Strings = (
          'Utilize este bot'#227'o para navegar para a p'#225'gina anterior.'
          ''
          'Atalho: Control + Seta a Esquerda')
        Header = 'P'#225'gina Anterior'
        ShowFooter = False
      end
      item
        Action = ActionPaginaProxima
        Description.Strings = (
          'Utilize este bot'#227'o para navegar para a pr'#243'xima p'#225'gina.'
          ''
          'Atalho: Control + Seta a Direita')
        Header = 'Pr'#243'xima P'#225'gina'
        ShowFooter = False
      end>
    Left = 792
    Top = 299
  end
end