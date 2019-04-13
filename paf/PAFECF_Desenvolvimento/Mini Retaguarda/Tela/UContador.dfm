object FContador: TFContador
  Tag = 1
  Left = 260
  Top = 83
  Caption = 'Contador'
  ClientHeight = 204
  ClientWidth = 663
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
  object PanelEdits: TPanel
    Left = 0
    Top = 0
    Width = 663
    Height = 204
    Align = alClient
    BevelInner = bvLowered
    BevelWidth = 2
    TabOrder = 0
    DesignSize = (
      663
      204)
    object Label5: TLabel
      Left = 288
      Top = 48
      Width = 23
      Height = 13
      Anchors = [akTop, akRight]
      Caption = 'CPF:'
    end
    object Label6: TLabel
      Left = 390
      Top = 48
      Width = 29
      Height = 13
      Anchors = [akTop, akRight]
      Caption = 'CNPJ:'
      Color = clBtnFace
      ParentColor = False
    end
    object Label2: TLabel
      Left = 558
      Top = 95
      Width = 22
      Height = 13
      Anchors = [akTop, akRight]
      Caption = 'Fax:'
      Color = clBtnFace
      ParentColor = False
    end
    object Label3: TLabel
      Left = 341
      Top = 95
      Width = 41
      Height = 13
      Anchors = [akTop, akRight]
      Caption = 'N'#250'mero:'
    end
    object Label1: TLabel
      Left = 467
      Top = 95
      Width = 46
      Height = 13
      Anchors = [akTop, akRight]
      Caption = 'Telefone:'
      Color = clBtnFace
      ParentColor = False
    end
    object Label4: TLabel
      Left = 330
      Top = 139
      Width = 23
      Height = 13
      Caption = 'CEP:'
      Color = clBtnFace
      ParentColor = False
    end
    object Label7: TLabel
      Left = 193
      Top = 139
      Width = 73
      Height = 13
      Caption = 'C'#243'd. Munic'#237'pio:'
    end
    object ActionToolBarEdits: TActionToolBar
      AlignWithMargins = True
      Left = 7
      Top = 7
      Width = 649
      Height = 24
      ActionManager = ActionManager
      BiDiMode = bdRightToLeft
      Caption = 'ActionToolBarEdits'
      ColorMap.BtnSelectedColor = clBtnFace
      ColorMap.UnusedColor = 15660791
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Orientation = boRightToLeft
      ParentBiDiMode = False
      ParentFont = False
      Spacing = 0
      ExplicitHeight = 26
    end
    object editCNPJ: TMaskEdit
      Left = 390
      Top = 64
      Width = 121
      Height = 21
      Anchors = [akTop, akRight]
      EditMask = '###.###.###/####-##;0;_'
      MaxLength = 19
      TabOrder = 1
    end
    object editTelefone: TMaskEdit
      Left = 467
      Top = 112
      Width = 85
      Height = 21
      Anchors = [akTop, akRight]
      EditMask = '(##) ####-####;0;_'
      MaxLength = 14
      TabOrder = 2
    end
    object editFax: TMaskEdit
      Left = 558
      Top = 112
      Width = 85
      Height = 21
      Anchors = [akTop, akRight]
      EditMask = '(##) ####-####;0;_'
      MaxLength = 14
      TabOrder = 3
    end
    object editCPF: TMaskEdit
      Left = 288
      Top = 64
      Width = 96
      Height = 21
      Anchors = [akTop, akRight]
      EditMask = '###.###.###-##;0;_'
      MaxLength = 14
      TabOrder = 4
    end
    object editNome: TLabeledEdit
      Left = 24
      Top = 64
      Width = 257
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      EditLabel.Width = 31
      EditLabel.Height = 13
      EditLabel.Caption = 'Nome:'
      TabOrder = 5
    end
    object editInscricaoCRC: TLabeledEdit
      Left = 517
      Top = 64
      Width = 126
      Height = 21
      Anchors = [akTop, akRight]
      EditLabel.Width = 71
      EditLabel.Height = 13
      EditLabel.Caption = 'Inscri'#231#227'o CRC:'
      TabOrder = 6
    end
    object editLogradouro: TLabeledEdit
      Left = 24
      Top = 112
      Width = 310
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      EditLabel.Width = 59
      EditLabel.Height = 13
      EditLabel.Caption = 'Logradouro:'
      TabOrder = 7
    end
    object editNumero: TJvValidateEdit
      Left = 341
      Top = 112
      Width = 40
      Height = 21
      Anchors = [akTop, akRight]
      CriticalPoints.MaxValueIncluded = False
      CriticalPoints.MinValueIncluded = False
      TabOrder = 8
    end
    object editBairro: TLabeledEdit
      Left = 24
      Top = 155
      Width = 163
      Height = 21
      EditLabel.Width = 32
      EditLabel.Height = 13
      EditLabel.Caption = 'Bairro:'
      TabOrder = 9
    end
    object editUF: TLabeledEdit
      Left = 287
      Top = 155
      Width = 37
      Height = 21
      EditLabel.Width = 17
      EditLabel.Height = 13
      EditLabel.Caption = 'UF:'
      TabOrder = 10
    end
    object editComplemento: TLabeledEdit
      Left = 388
      Top = 112
      Width = 73
      Height = 21
      Anchors = [akTop, akRight]
      EditLabel.Width = 69
      EditLabel.Height = 13
      EditLabel.Caption = 'Complemento:'
      TabOrder = 11
    end
    object editEmail: TLabeledEdit
      Left = 407
      Top = 155
      Width = 236
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      EditLabel.Width = 28
      EditLabel.Height = 13
      EditLabel.Caption = 'Email:'
      TabOrder = 12
    end
    object editCEP: TMaskEdit
      Left = 330
      Top = 155
      Width = 71
      Height = 21
      EditMask = '#####-###;0;_'
      MaxLength = 9
      TabOrder = 13
    end
    object editMunicipio: TJvValidateEdit
      Left = 193
      Top = 155
      Width = 88
      Height = 21
      CriticalPoints.MaxValueIncluded = False
      CriticalPoints.MinValueIncluded = False
      TabOrder = 14
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
          end>
        ActionBar = ActionToolBarEdits
      end>
    DisabledImages = FDataModule.ImagensCadastrosD
    Images = FDataModule.ImagensCadastros
    Left = 328
    Top = 296
    StyleName = 'Ribbon - Silver'
    object ActionInserir: TAction
      Category = 'Cadastro'
      Caption = 'Inserir [F2]'
      ImageIndex = 0
      ShortCut = 113
    end
    object ActionAlterar: TAction
      Category = 'Cadastro'
      Caption = 'Alterar [F3]'
      ImageIndex = 1
      ShortCut = 114
    end
    object ActionExcluir: TAction
      Category = 'Cadastro'
      Caption = 'Excluir [F4]'
      ImageIndex = 2
      ShortCut = 115
    end
    object ActionFiltroRapido: TAction
      Category = 'Cadastro'
      Caption = 'Filtro R'#225'pido [F9]'
      ImageIndex = 3
      ShortCut = 120
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
    end
    object ActionPrimeiro: TAction
      Category = 'Navegacao'
      Caption = 'Primeiro Registro'
      ImageIndex = 20
    end
    object ActionUltimo: TAction
      Category = 'Navegacao'
      Caption = #218'ltimo Registro'
      ImageIndex = 21
    end
    object ActionAnterior: TAction
      Category = 'Navegacao'
      Caption = 'Registro Anterior'
      ImageIndex = 19
    end
    object ActionProximo: TAction
      Category = 'Navegacao'
      Caption = 'Pr'#243'ximo Registro'
      ImageIndex = 22
    end
    object ActionSair: TAction
      Category = 'Cadastro'
      Caption = 'Sair [F8]'
      ImageIndex = 12
      ShortCut = 119
    end
    object ActionExportar: TAction
      Category = 'Cadastro'
      Caption = 'Exportar [F6]'
      ImageIndex = 13
      ShortCut = 117
    end
    object ActionFiltrar: TAction
      Category = 'Cadastro'
      Caption = 'Filtrar [F5]'
      ImageIndex = 11
      ShortCut = 116
    end
    object ActionExportarWord: TAction
      Category = 'Exportacao'
      Caption = 'para &Word'
      ImageIndex = 17
    end
    object ActionExportarExcel: TAction
      Category = 'Exportacao'
      Caption = 'para &Excel'
      ImageIndex = 14
    end
    object ActionExportarXML: TAction
      Category = 'Exportacao'
      Caption = 'para &XML'
      ImageIndex = 18
    end
    object ActionExportarCSV: TAction
      Category = 'Exportacao'
      Caption = 'para &CSV'
      ImageIndex = 16
    end
    object ActionExportarHTML: TAction
      Category = 'Exportacao'
      Caption = 'para &HTML'
      ImageIndex = 15
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
    object ActionConsultar: TAction
      Category = 'Cadastro'
      Caption = 'Consultar'
      ImageIndex = 28
    end
    object ActionGerarCheques: TAction
      Category = 'Movimento'
      Caption = 'Gerar Cheques'
      ImageIndex = 31
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
    Left = 440
    Top = 275
  end
end
