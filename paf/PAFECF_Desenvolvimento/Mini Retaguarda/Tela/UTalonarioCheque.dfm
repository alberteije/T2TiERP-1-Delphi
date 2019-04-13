object FTalonarioCheque: TFTalonarioCheque
  Tag = 1
  Left = 349
  Top = 249
  Caption = 'Talon'#225'rios de Cheque'
  ClientHeight = 468
  ClientWidth = 900
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
  PixelsPerInch = 96
  TextHeight = 13
  object PanelGrid: TPanel
    Left = 0
    Top = 35
    Width = 900
    Height = 433
    Align = alClient
    BevelInner = bvLowered
    BevelWidth = 2
    TabOrder = 1
    object Grid: TJvDBUltimGrid
      Left = 4
      Top = 4
      Width = 892
      Height = 373
      Align = alClient
      DataSource = FDataModule.DSTalonarioCheque
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnDblClick = ActionConsultarExecute
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
      Width = 892
      Height = 52
      Align = alBottom
      Color = 14537936
      ParentBackground = False
      TabOrder = 1
      DesignSize = (
        892
        52)
      object SpeedButton1: TSpeedButton
        Left = 760
        Top = 24
        Width = 125
        Height = 22
        Action = ActionFiltroRapido
        Anchors = [akTop, akRight]
        Constraints.MaxWidth = 125
        Constraints.MinWidth = 125
        Flat = True
        ExplicitLeft = 643
      end
      object Label1: TLabel
        Left = 9
        Top = 8
        Width = 37
        Height = 13
        Caption = 'Campo:'
      end
      object EditCriterioRapido: TLabeledEdit
        Left = 163
        Top = 24
        Width = 591
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
  end
  object PanelEdits: TPanel
    Left = 0
    Top = 35
    Width = 900
    Height = 433
    Align = alClient
    BevelInner = bvLowered
    BevelWidth = 2
    TabOrder = 2
    DesignSize = (
      900
      433)
    object BevelEdits: TBevel
      Left = 10
      Top = 41
      Width = 879
      Height = 101
      Anchors = [akLeft, akTop, akRight]
      Constraints.MinWidth = 753
    end
    object Label6: TLabel
      Left = 18
      Top = 47
      Width = 33
      Height = 13
      Caption = 'Conta:'
    end
    object Label2: TLabel
      Left = 18
      Top = 91
      Width = 41
      Height = 13
      Caption = 'N'#250'mero:'
    end
    object Label3: TLabel
      Left = 242
      Top = 91
      Width = 82
      Height = 13
      Caption = 'Primeiro Cheque:'
    end
    object Label4: TLabel
      Left = 359
      Top = 91
      Width = 73
      Height = 13
      Caption = #218'ltimo Cheque:'
    end
    object ActionToolBarEdits: TActionToolBar
      AlignWithMargins = True
      Left = 7
      Top = 7
      Width = 886
      Height = 24
      ActionManager = ActionManager
      BiDiMode = bdRightToLeft
      Caption = 'ActionToolBarEdits'
      ColorMap.BtnSelectedColor = clBtnFace
      ColorMap.UnusedColor = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Orientation = boRightToLeft
      ParentBiDiMode = False
      ParentFont = False
      Spacing = 0
    end
    object EditNomeConta: TLabeledEdit
      Left = 89
      Top = 64
      Width = 792
      Height = 21
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      CharCase = ecUpperCase
      Color = 14680063
      EditLabel.Width = 3
      EditLabel.Height = 13
      EditLabel.Caption = ' '
      EditLabel.Color = clBtnFace
      EditLabel.ParentColor = False
      MaxLength = 30
      ReadOnly = True
      TabOrder = 1
    end
    object GridCheques: TJvDBUltimGrid
      Left = 10
      Top = 156
      Width = 879
      Height = 264
      Anchors = [akLeft, akTop, akRight, akBottom]
      DataSource = FDataModule.DSCheque
      ReadOnly = True
      TabOrder = 6
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
    end
    object EditIdConta: TJvValidateEdit
      Left = 18
      Top = 64
      Width = 71
      Height = 21
      CriticalPoints.MaxValueIncluded = False
      CriticalPoints.MinValueIncluded = False
      TabOrder = 0
      OnKeyDown = EditIdContaKeyDown
    end
    object EditNumero: TJvValidateEdit
      Left = 18
      Top = 108
      Width = 71
      Height = 21
      CriticalPoints.MaxValueIncluded = False
      CriticalPoints.MinValueIncluded = False
      TabOrder = 2
      OnKeyDown = EditIdContaKeyDown
    end
    object EditTalao: TLabeledEdit
      Left = 104
      Top = 108
      Width = 121
      Height = 21
      EditLabel.Width = 30
      EditLabel.Height = 13
      EditLabel.Caption = 'Tal'#227'o:'
      MaxLength = 10
      TabOrder = 3
    end
    object EditPrimeiroCheque: TJvValidateEdit
      Left = 242
      Top = 108
      Width = 100
      Height = 21
      CriticalPoints.MaxValueIncluded = False
      CriticalPoints.MinValueIncluded = False
      TabOrder = 4
      OnKeyDown = EditIdContaKeyDown
    end
    object EditUltimoCheque: TJvValidateEdit
      Left = 359
      Top = 108
      Width = 100
      Height = 21
      CriticalPoints.MaxValueIncluded = False
      CriticalPoints.MinValueIncluded = False
      TabOrder = 5
      OnKeyDown = EditIdContaKeyDown
    end
  end
  object PanelToolBar: TPanel
    Left = 0
    Top = 0
    Width = 900
    Height = 35
    Align = alTop
    Color = 14537936
    ParentBackground = False
    TabOrder = 0
    object ActionToolBarGrid: TActionToolBar
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 892
      Height = 27
      ActionManager = ActionManager
      Align = alClient
      BiDiMode = bdLeftToRight
      Caption = 'ActionToolBarGrid'
      ColorMap.BtnSelectedColor = clBtnFace
      ColorMap.UnusedColor = clWhite
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
        Items = <
          item
            Action = ActionAlterar
            Caption = '&Alterar [F3]'
            ImageIndex = 1
            ShortCut = 114
          end
          item
            Action = ActionExcluir
            Caption = '&Excluir [F4]'
            ImageIndex = 3
            ShortCut = 115
          end
          item
            Action = ActionFiltroRapido
            Caption = '&Filtro R'#225'pido [F9]'
            ImageIndex = 5
            ShortCut = 120
          end
          item
            Action = ActionInserir
            Caption = '&Inserir [F2]'
            ImageIndex = 0
            ShortCut = 113
          end>
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
            Action = ActionInserir
            Caption = 'I&nserir [F2]'
            ImageIndex = 0
            ShowShortCut = False
            ShortCut = 113
          end
          item
            Action = ActionAlterar
            Caption = '&Alterar [F3]'
            ImageIndex = 1
            ShowShortCut = False
            ShortCut = 114
          end
          item
            Action = ActionExcluir
            Caption = 'Ex&cluir [F4]'
            ImageIndex = 2
            ShortCut = 115
          end
          item
            Caption = '-'
          end
          item
            Action = ActionFiltrar
            Caption = '&Filtrar [F5]'
            ImageIndex = 11
            ShortCut = 116
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
          end>
        ActionBar = ActionToolBarGrid
      end
      item
      end
      item
        Items = <
          item
            Action = ActionSalvar
            Caption = '&Salvar [F12]'
            ImageIndex = 9
            ShortCut = 123
          end
          item
            Action = ActionCancelar
            Caption = '&Cancelar [F11]'
            ImageIndex = 10
            ShortCut = 122
          end
          item
            Action = ActionGerarCheques
            Caption = '&Gerar Cheques'
            ImageIndex = 31
          end>
        ActionBar = ActionToolBarEdits
      end>
    DisabledImages = FDataModule.ImagensCadastrosD
    Images = FDataModule.ImagensCadastros
    Left = 792
    Top = 352
    StyleName = 'Ribbon - Silver'
    object ActionInserir: TAction
      Category = 'Cadastro'
      Caption = 'Inserir [F2]'
      ImageIndex = 0
      ShortCut = 113
      OnExecute = ActionInserirExecute
    end
    object ActionAlterar: TAction
      Category = 'Cadastro'
      Caption = 'Alterar [F3]'
      ImageIndex = 1
      ShortCut = 114
      OnExecute = ActionAlterarExecute
    end
    object ActionExcluir: TAction
      Category = 'Cadastro'
      Caption = 'Excluir [F4]'
      ImageIndex = 2
      ShortCut = 115
      OnExecute = ActionExcluirExecute
    end
    object ActionFiltroRapido: TAction
      Category = 'Cadastro'
      Caption = 'Filtro R'#225'pido [F9]'
      ImageIndex = 3
      ShortCut = 120
      OnExecute = ActionFiltroRapidoExecute
    end
    object ActionCancelar: TAction
      Category = 'Cadastro'
      Caption = 'Cancelar [F11]'
      ImageIndex = 10
      ShortCut = 122
      OnExecute = ActionCancelarExecute
    end
    object ActionSalvar: TAction
      Category = 'Cadastro'
      Caption = 'Salvar [F12]'
      ImageIndex = 9
      ShortCut = 123
      OnExecute = ActionSalvarExecute
    end
    object ActionImprimir: TAction
      Category = 'Cadastro'
      Caption = 'Imprimir [F7]'
      ImageIndex = 4
      ShortCut = 118
      OnExecute = ActionImprimirExecute
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
    object ActionFiltrar: TAction
      Category = 'Cadastro'
      Caption = 'Filtrar [F5]'
      ImageIndex = 11
      ShortCut = 116
      OnExecute = ActionFiltrarExecute
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
      OnExecute = ActionPaginaAnteriorExecute
    end
    object ActionPaginaProxima: TAction
      Category = 'Navegacao'
      Caption = 'Pr'#243'xima P'#225'gina'
      ImageIndex = 23
      ShortCut = 16423
      OnExecute = ActionPaginaProximaExecute
    end
    object ActionConsultar: TAction
      Category = 'Cadastro'
      Caption = 'Consultar'
      ImageIndex = 28
      OnExecute = ActionConsultarExecute
    end
    object ActionGerarCheques: TAction
      Category = 'Movimento'
      Caption = 'Gerar Cheques'
      ImageIndex = 31
      OnExecute = ActionGerarChequesExecute
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
        Action = ActionInserir
        Description.Strings = (
          'Utilize este bot'#227'o para inserir um novo registro.')
        Header = 'Inserir [F2]'
        ShowFooter = False
      end
      item
        Action = ActionAlterar
        Description.Strings = (
          'Utilize este bot'#227'o para alterar o registro selecionado.')
        Header = 'Alterar [F3]'
        ShowFooter = False
      end
      item
        Action = ActionExcluir
        Description.Strings = (
          'Utilize este bot'#227'o para excluir o registro selecionado.')
        Header = 'Excluir [F4]'
        ShowFooter = False
      end
      item
        Action = ActionFiltroRapido
        Description.Strings = (
          
            'Utilize este bot'#227'o para executar um filtro r'#225'pido. Para um filtr' +
            'o mais rebuscado utilize o bot'#227'o [Filtrar].')
        Header = 'Consultar'
        ShowFooter = False
      end
      item
        Action = ActionCancelar
        Description.Strings = (
          'Utilize este bot'#227'o para cancelar a transa'#231#227'o.')
        Header = 'Cancelar [F11]'
        ShowFooter = False
      end
      item
        Action = ActionSalvar
        Description.Strings = (
          'Utilize este bot'#227'o para salvar a transa'#231#227'o.')
        Header = 'Salvar [F12]'
        ShowFooter = False
      end
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
        Action = ActionFiltrar
        Description.Strings = (
          'Utilize este bot'#227'o para acessar a janela de filtros.')
        Header = 'Filtrar [F5]'
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
      end
      item
        Action = ActionConsultar
        Header = 'Consultar'
      end>
    Left = 792
    Top = 299
  end
end
