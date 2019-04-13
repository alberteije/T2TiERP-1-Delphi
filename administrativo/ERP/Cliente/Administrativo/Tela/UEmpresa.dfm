inherited FEmpresa: TFEmpresa
  Left = 318
  Top = 203
  Caption = 'Empresa'
  ClientHeight = 486
  ClientWidth = 990
  ExplicitLeft = 318
  ExplicitTop = 203
  ExplicitWidth = 998
  ExplicitHeight = 520
  PixelsPerInch = 96
  TextHeight = 13
  inherited PageControl: TPageControl
    Width = 990
    Height = 455
    ActivePage = PaginaEdits
    ExplicitWidth = 990
    ExplicitHeight = 455
    inherited PaginaGrid: TTabSheet
      ExplicitWidth = 982
      ExplicitHeight = 427
      inherited PanelGrid: TPanel
        Width = 982
        Height = 427
        ExplicitWidth = 982
        ExplicitHeight = 427
        inherited Grid: TJvDBUltimGrid
          Width = 982
          Height = 375
        end
        inherited PanelFiltroRapido: TPanel
          Top = 375
          Width = 982
          ExplicitTop = 375
          ExplicitWidth = 982
          inherited BotaoConsultar: TSpeedButton
            Left = 850
            ExplicitLeft = 825
          end
          inherited EditCriterioRapido: TLabeledMaskEdit
            Width = 681
            ExplicitWidth = 681
          end
        end
      end
    end
    inherited PaginaEdits: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 24
      ExplicitWidth = 982
      ExplicitHeight = 427
      inherited PanelEdits: TPanel
        Width = 982
        Height = 427
        ExplicitWidth = 982
        ExplicitHeight = 427
        object PageControlDadosEmpresa: TPageControl
          Left = 12
          Top = 167
          Width = 958
          Height = 250
          ActivePage = TabSheet1
          Anchors = [akLeft, akTop, akRight, akBottom]
          TabOrder = 1
          object TabSheet1: TTabSheet
            Caption = 'Dados gerais'
            ExplicitLeft = 0
            ExplicitTop = 0
            ExplicitWidth = 0
            ExplicitHeight = 0
            object PanelDadosGerais: TPanel
              Left = 0
              Top = 0
              Width = 950
              Height = 222
              Align = alClient
              BevelOuter = bvNone
              TabOrder = 0
              DesignSize = (
                950
                222)
              object ImagemLogotipo: TImage
                Left = 820
                Top = 95
                Width = 120
                Height = 120
                Hint = 'Logotipo da Empresa'
                Anchors = [akLeft, akTop, akRight, akBottom]
                Center = True
                ParentShowHint = False
                PopupMenu = PopupMenu1
                ShowHint = True
                Transparent = True
                OnClick = ImagemLogotipoClick
              end
              object EditInicioAtividade: TLabeledDateEdit
                Left = 5
                Top = 21
                Width = 99
                Height = 21
                TabOrder = 0
                DateEditLabel.Width = 82
                DateEditLabel.Height = 13
                DateEditLabel.Caption = 'Inicio Atividades:'
              end
              object EditCnpj: TLabeledMaskEdit
                Left = 110
                Top = 21
                Width = 123
                Height = 21
                Color = clWhite
                EditLabel.Width = 29
                EditLabel.Height = 13
                EditLabel.Caption = 'CNPJ:'
                MaxLength = 18
                TabOrder = 1
                Required = False
                EditMask = '##.###.###/####-##;0;_'
                MaskState = [msMasked]
              end
              object EditInscricaoEstadual: TLabeledMaskEdit
                Left = 239
                Top = 21
                Width = 113
                Height = 21
                Color = clWhite
                EditLabel.Width = 91
                EditLabel.Height = 13
                EditLabel.Caption = 'Inscri'#231#227'o Estadual:'
                TabOrder = 2
                Required = False
                MaskState = []
              end
              object EditInscricaoEstadualST: TLabeledMaskEdit
                Left = 358
                Top = 21
                Width = 123
                Height = 21
                Color = clWhite
                DoubleBuffered = False
                EditLabel.Width = 106
                EditLabel.Height = 13
                EditLabel.Caption = 'Inscri'#231#227'o Estadual ST:'
                ParentDoubleBuffered = False
                TabOrder = 3
                Required = False
                MaskState = []
              end
              object EditInscricaoMunicipal: TLabeledMaskEdit
                Left = 487
                Top = 21
                Width = 130
                Height = 21
                Color = clWhite
                EditLabel.Width = 93
                EditLabel.Height = 13
                EditLabel.Caption = 'Inscri'#231#227'o Municipal:'
                TabOrder = 4
                Required = False
                MaskState = []
              end
              object EditInscricaoJuntaComercial: TLabeledMaskEdit
                Left = 623
                Top = 21
                Width = 139
                Height = 21
                Color = clWhite
                EditLabel.Width = 126
                EditLabel.Height = 13
                EditLabel.Caption = 'Inscri'#231#227'o Junta Comercial:'
                TabOrder = 5
                Required = False
                MaskState = []
              end
              object EditDataInscricaoJuntaComercial: TLabeledDateEdit
                Left = 768
                Top = 21
                Width = 172
                Height = 21
                TabOrder = 6
                DateEditLabel.Width = 152
                DateEditLabel.Height = 13
                DateEditLabel.Caption = 'Data Inscri'#231#227'o Junta Comercial:'
              end
              object EditContato: TLabeledEdit
                Left = 662
                Top = 67
                Width = 278
                Height = 21
                Anchors = [akLeft, akTop, akRight]
                EditLabel.Width = 43
                EditLabel.Height = 13
                EditLabel.Caption = 'Contato:'
                MaxLength = 100
                TabOrder = 11
              end
              object ComboBoxCRT: TLabeledComboBox
                Left = 369
                Top = 67
                Width = 287
                Height = 21
                Style = csDropDownList
                ItemIndex = 2
                TabOrder = 10
                Text = '3 - Regime Normal'
                Items.Strings = (
                  '1 - Simples Nacional'
                  '2 - Simples Nacional excesso de sublimite da receita bruta'
                  '3 - Regime Normal')
                ComboBoxLabel.Width = 24
                ComboBoxLabel.Height = 13
                ComboBoxLabel.Caption = 'CRT:'
              end
              object EditSuframa: TLabeledEdit
                Left = 257
                Top = 67
                Width = 106
                Height = 21
                EditLabel.Width = 44
                EditLabel.Height = 13
                EditLabel.Caption = 'Suframa:'
                MaxLength = 100
                TabOrder = 9
              end
              object ComboBoxTipo: TLabeledComboBox
                Left = 5
                Top = 67
                Width = 116
                Height = 21
                Style = csDropDownList
                ItemIndex = 0
                TabOrder = 7
                Text = 'M - Matriz'
                Items.Strings = (
                  'M - Matriz'
                  'F - Filial'
                  'D - Dep'#243'sito')
                ComboBoxLabel.Width = 24
                ComboBoxLabel.Height = 13
                ComboBoxLabel.Caption = 'Tipo:'
              end
              object ComboBoxTipoRegime: TLabeledComboBox
                Left = 127
                Top = 67
                Width = 124
                Height = 21
                Style = csDropDownList
                ItemIndex = 0
                TabOrder = 8
                Text = '1 - Lucro Real'
                Items.Strings = (
                  '1 - Lucro Real'
                  '2 - Lucro Presumido'
                  '3 - Simples Nacional')
                ComboBoxLabel.Width = 62
                ComboBoxLabel.Height = 13
                ComboBoxLabel.Caption = 'Tipo Regime:'
              end
              object GroupBox1: TGroupBox
                Left = 663
                Top = 102
                Width = 152
                Height = 79
                Caption = 'C'#243'digo IBGE:'
                TabOrder = 20
                object EditCodigoIbgeCidade: TLabeledCalcEdit
                  Left = 11
                  Top = 43
                  Width = 78
                  Height = 21
                  ShowButton = False
                  TabOrder = 0
                  DecimalPlacesAlwaysShown = False
                  CalcEditLabel.Width = 47
                  CalcEditLabel.Height = 13
                  CalcEditLabel.Caption = 'Munic'#237'pio:'
                end
                object EditCodigoIbgeUf: TLabeledCalcEdit
                  Left = 95
                  Top = 43
                  Width = 42
                  Height = 21
                  ShowButton = False
                  TabOrder = 1
                  DecimalPlacesAlwaysShown = False
                  CalcEditLabel.Width = 17
                  CalcEditLabel.Height = 13
                  CalcEditLabel.Caption = 'UF:'
                end
              end
              object EditEmail: TLabeledEdit
                Left = 282
                Top = 160
                Width = 375
                Height = 21
                EditLabel.Width = 28
                EditLabel.Height = 13
                EditLabel.Caption = 'Email:'
                MaxLength = 100
                TabOrder = 19
              end
              object EditCei: TLabeledEdit
                Left = 114
                Top = 117
                Width = 162
                Height = 21
                EditLabel.Width = 21
                EditLabel.Height = 13
                EditLabel.Caption = 'CEI:'
                MaxLength = 100
                TabOrder = 13
              end
              object EditCodigoCnaePrincipal: TLabeledEdit
                Left = 114
                Top = 160
                Width = 162
                Height = 21
                EditLabel.Width = 73
                EditLabel.Height = 13
                EditLabel.Caption = 'CNAE Principal:'
                MaxLength = 100
                TabOrder = 18
              end
              object EditCodigoTerceiros: TLabeledCalcEdit
                Left = 5
                Top = 117
                Width = 103
                Height = 21
                ShowButton = False
                TabOrder = 12
                DecimalPlacesAlwaysShown = False
                CalcEditLabel.Width = 84
                CalcEditLabel.Height = 13
                CalcEditLabel.Caption = 'C'#243'digo Terceiros:'
              end
              object EditCodigoGps: TLabeledCalcEdit
                Left = 5
                Top = 160
                Width = 103
                Height = 21
                ShowButton = False
                TabOrder = 17
                DecimalPlacesAlwaysShown = False
                CalcEditLabel.Width = 59
                CalcEditLabel.Height = 13
                CalcEditLabel.Caption = 'C'#243'digo GPS:'
              end
              object EditAliquotaPis: TLabeledCalcEdit
                Left = 282
                Top = 117
                Width = 121
                Height = 21
                DisplayFormat = '###,###,##0.00'
                TabOrder = 14
                DecimalPlacesAlwaysShown = False
                CalcEditLabel.Width = 62
                CalcEditLabel.Height = 13
                CalcEditLabel.Caption = 'Al'#237'quota PIS:'
              end
              object EditAliquotaCofins: TLabeledCalcEdit
                Left = 409
                Top = 117
                Width = 121
                Height = 21
                DisplayFormat = '###,###,##0.00'
                TabOrder = 15
                DecimalPlacesAlwaysShown = False
                CalcEditLabel.Width = 84
                CalcEditLabel.Height = 13
                CalcEditLabel.Caption = 'Al'#237'quota COFINS:'
              end
              object EditAliquotaSat: TLabeledCalcEdit
                Left = 536
                Top = 117
                Width = 121
                Height = 21
                DisplayFormat = '###,###,##0.00'
                TabOrder = 16
                DecimalPlacesAlwaysShown = False
                CalcEditLabel.Width = 65
                CalcEditLabel.Height = 13
                CalcEditLabel.Caption = 'Al'#237'quota SAT:'
              end
            end
          end
          object TabSheetContato: TTabSheet
            Caption = 'Contatos'
            ImageIndex = 1
            object GridContato: TJvDBUltimGrid
              Left = 0
              Top = 0
              Width = 950
              Height = 222
              Align = alClient
              DataSource = DSContato
              TabOrder = 0
              TitleFont.Charset = DEFAULT_CHARSET
              TitleFont.Color = clWindowText
              TitleFont.Height = -11
              TitleFont.Name = 'Tahoma'
              TitleFont.Style = []
              OnKeyDown = GridContatoKeyDown
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
                  FieldName = 'NOME'
                  Title.Caption = 'Nome'
                  Width = 200
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'EMAIL'
                  Title.Caption = 'Email'
                  Width = 200
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'FONE_COMERCIAL'
                  Title.Caption = 'Fone Comercial'
                  Width = 100
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'FONE_RESIDENCIAL'
                  Title.Caption = 'Fone Residencial'
                  Width = 100
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'FONE_CELULAR'
                  Title.Caption = 'Celular'
                  Width = 100
                  Visible = True
                end>
            end
          end
          object TabSheetEndereco: TTabSheet
            Caption = 'Endere'#231'os'
            ImageIndex = 2
            object GridEndereco: TJvDBUltimGrid
              Left = 0
              Top = 0
              Width = 950
              Height = 222
              Align = alClient
              DataSource = DSEndereco
              TabOrder = 0
              TitleFont.Charset = DEFAULT_CHARSET
              TitleFont.Color = clWindowText
              TitleFont.Height = -11
              TitleFont.Name = 'Tahoma'
              TitleFont.Style = []
              OnKeyDown = GridEnderecoKeyDown
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
                  FieldName = 'LOGRADOURO'
                  Title.Caption = 'Logradouro'
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'NUMERO'
                  Title.Caption = 'N'#250'mero'
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'COMPLEMENTO'
                  Title.Caption = 'Complemento'
                  Width = 200
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'BAIRRO'
                  Title.Caption = 'Bairro'
                  Width = 200
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'CIDADE'
                  Title.Caption = 'Cidade'
                  Width = 200
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'CEP'
                  Width = 80
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'MUNICIPIO_IBGE'
                  Title.Caption = 'C'#243'd. IBGE [F1]'
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'UF'
                  Width = 25
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'FONE'
                  Title.Caption = 'Fone'
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'FAX'
                  Title.Caption = 'Fax'
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'PRINCIPAL'
                  Title.Caption = 'Principal'
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'ENTREGA'
                  Title.Caption = 'Entrega'
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'COBRANCA'
                  Title.Caption = 'Cobran'#231'a'
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'CORRESPONDENCIA'
                  Title.Caption = 'Correspond'#234'ncia'
                  Visible = True
                end>
            end
          end
        end
        object PanelPrincipal: TPanel
          Left = 12
          Top = 12
          Width = 958
          Height = 141
          Anchors = [akLeft, akTop, akRight]
          BevelOuter = bvLowered
          TabOrder = 0
          DesignSize = (
            958
            141)
          object EditRazaoSocial: TLabeledEdit
            Left = 8
            Top = 22
            Width = 462
            Height = 21
            EditLabel.Width = 64
            EditLabel.Height = 13
            EditLabel.Caption = 'Raz'#227'o Social:'
            MaxLength = 150
            TabOrder = 0
          end
          object EditNomeFantasia: TLabeledEdit
            Left = 476
            Top = 22
            Width = 473
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            EditLabel.Width = 90
            EditLabel.Height = 13
            EditLabel.Caption = 'Nome de Fantasia:'
            MaxLength = 150
            TabOrder = 1
          end
          object EditNomeMatriz: TLabeledEdit
            Left = 69
            Top = 67
            Width = 401
            Height = 21
            TabStop = False
            Color = clInfoBk
            EditLabel.Width = 6
            EditLabel.Height = 13
            EditLabel.Caption = '  '
            ReadOnly = True
            TabOrder = 3
          end
          object EditNomeContador: TLabeledEdit
            Left = 537
            Top = 67
            Width = 412
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
          object EditNomeSindicato: TLabeledEdit
            Left = 69
            Top = 111
            Width = 401
            Height = 21
            TabStop = False
            Color = clInfoBk
            EditLabel.Width = 6
            EditLabel.Height = 13
            EditLabel.Caption = '  '
            ReadOnly = True
            TabOrder = 7
          end
          object EditDescricaoFpas: TLabeledEdit
            Left = 537
            Top = 111
            Width = 412
            Height = 21
            TabStop = False
            Anchors = [akLeft, akTop, akRight]
            Color = clInfoBk
            EditLabel.Width = 6
            EditLabel.Height = 13
            EditLabel.Caption = '  '
            ReadOnly = True
            TabOrder = 9
          end
          object EditIdMatriz: TLabeledCalcEdit
            Left = 8
            Top = 67
            Width = 61
            Height = 21
            ShowButton = False
            TabOrder = 2
            DecimalPlacesAlwaysShown = False
            OnExit = EditIdMatrizExit
            OnKeyDown = EditIdMatrizKeyDown
            OnKeyPress = EditIdMatrizKeyPress
            CalcEditLabel.Width = 56
            CalcEditLabel.Height = 13
            CalcEditLabel.Caption = 'Matriz [F1]:'
          end
          object EditIdContador: TLabeledCalcEdit
            Left = 476
            Top = 67
            Width = 61
            Height = 21
            AutoSize = False
            ShowButton = False
            TabOrder = 4
            DecimalPlacesAlwaysShown = False
            OnExit = EditIdContadorExit
            OnKeyDown = EditIdContadorKeyDown
            OnKeyPress = EditIdContadorKeyPress
            CalcEditLabel.Width = 72
            CalcEditLabel.Height = 13
            CalcEditLabel.Caption = 'Contador [F1]:'
          end
          object EditIdSindicato: TLabeledCalcEdit
            Left = 8
            Top = 111
            Width = 61
            Height = 21
            ShowButton = False
            TabOrder = 6
            DecimalPlacesAlwaysShown = False
            OnExit = EditIdSindicatoExit
            OnKeyDown = EditIdSindicatoKeyDown
            OnKeyPress = EditIdSindicatoKeyPress
            CalcEditLabel.Width = 70
            CalcEditLabel.Height = 13
            CalcEditLabel.Caption = 'Sindicato [F1]:'
          end
          object EditIdFpas: TLabeledCalcEdit
            Left = 476
            Top = 111
            Width = 61
            Height = 21
            ShowButton = False
            TabOrder = 8
            DecimalPlacesAlwaysShown = False
            OnExit = EditIdFpasExit
            OnKeyDown = EditIdFpasKeyDown
            OnKeyPress = EditIdFpasKeyPress
            CalcEditLabel.Width = 50
            CalcEditLabel.Height = 13
            CalcEditLabel.Caption = 'FPas [F1]:'
          end
        end
      end
    end
  end
  inherited PanelToolBar: TPanel
    Width = 990
    ExplicitWidth = 990
    inherited BotaoSair: TSpeedButton
      Left = 886
      ExplicitLeft = 889
    end
    inherited BotaoExportar: TSpeedButton
      Left = 786
      ExplicitLeft = 799
    end
    inherited BotaoImprimir: TSpeedButton
      Left = 676
      ExplicitLeft = 719
    end
    inherited BotaoSeparador1: TSpeedButton
      Left = 776
      ExplicitLeft = 895
      ExplicitTop = -4
    end
    inherited BotaoFiltrar: TSpeedButton
      Left = 576
      ExplicitLeft = 639
    end
  end
  inherited PopupMenuExportar: TPopupMenu
    Top = 8
  end
  inherited PopupMenuAtalhosBotoesTela: TPopupMenu
    Top = 7
  end
  inherited PopupMenuAtalhosBotoesTelaCadastro: TPopupMenu
    Top = 8
  end
  object CDSContato: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'ID'
        DataType = ftInteger
      end
      item
        Name = 'ID_PESSOA'
        DataType = ftInteger
      end
      item
        Name = 'ID_EMPRESA '
        DataType = ftInteger
      end
      item
        Name = 'NOME'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'EMAIL'
        DataType = ftString
        Size = 250
      end
      item
        Name = 'FONE_COMERCIAL'
        DataType = ftString
        Size = 14
      end
      item
        Name = 'FONE_RESIDENCIAL'
        DataType = ftString
        Size = 14
      end
      item
        Name = 'FONE_CELULAR'
        DataType = ftString
        Size = 14
      end
      item
        Name = 'PERSISTE'
        DataType = ftString
        Size = 1
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    AfterEdit = CDSContatoAfterEdit
    BeforeDelete = CDSContatoBeforeDelete
    Left = 152
    Data = {
      040100009619E0BD010000001800000009000000000003000000040102494404
      000100000000000949445F504553534F4104000100000000000B49445F454D50
      52455341200400010000000000044E4F4D450100490000000100055749445448
      02000200640005454D41494C010049000000010005574944544802000200FA00
      0E464F4E455F434F4D45524349414C0100490000000100055749445448020002
      000E0010464F4E455F5245534944454E4349414C010049000000010005574944
      5448020002000E000C464F4E455F43454C554C41520100490000000100055749
      445448020002000E000850455253495354450100490000000100055749445448
      0200020001000000}
    object CDSContatoID: TIntegerField
      FieldName = 'ID'
    end
    object CDSContatoID_PESSOA: TIntegerField
      FieldName = 'ID_PESSOA'
    end
    object CDSContatoID_EMPRESA: TIntegerField
      FieldName = 'ID_EMPRESA '
    end
    object CDSContatoNOME: TStringField
      FieldName = 'NOME'
      Size = 100
    end
    object CDSContatoEMAIL: TStringField
      FieldName = 'EMAIL'
      Size = 250
    end
    object CDSContatoFONE_COMERCIAL: TStringField
      FieldName = 'FONE_COMERCIAL'
      EditMask = '(##)####.####;0;_'
      Size = 14
    end
    object CDSContatoFONE_RESIDENCIAL: TStringField
      FieldName = 'FONE_RESIDENCIAL'
      EditMask = '(##)####.####;0;_'
      Size = 14
    end
    object CDSContatoFONE_CELULAR: TStringField
      FieldName = 'FONE_CELULAR'
      EditMask = '(##)####.####;0;_'
      Size = 14
    end
    object CDSContatoPERSISTE: TStringField
      FieldName = 'PERSISTE'
      Size = 1
    end
  end
  object DSContato: TDataSource
    DataSet = CDSContato
    Left = 205
  end
  object CDSEndereco: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'ID'
        DataType = ftInteger
      end
      item
        Name = 'ID_EMPRESA'
        DataType = ftInteger
      end
      item
        Name = 'ID_PESSOA'
        DataType = ftInteger
      end
      item
        Name = 'LOGRADOURO'
        DataType = ftString
        Size = 60
      end
      item
        Name = 'NUMERO'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'COMPLEMENTO'
        DataType = ftString
        Size = 60
      end
      item
        Name = 'BAIRRO'
        DataType = ftString
        Size = 60
      end
      item
        Name = 'CIDADE'
        DataType = ftString
        Size = 60
      end
      item
        Name = 'CEP'
        DataType = ftString
        Size = 8
      end
      item
        Name = 'MUNICIPIO_IBGE'
        DataType = ftInteger
      end
      item
        Name = 'UF'
        Attributes = [faFixed]
        DataType = ftString
        Size = 2
      end
      item
        Name = 'FONE'
        DataType = ftString
        Size = 14
      end
      item
        Name = 'FAX'
        DataType = ftString
        Size = 14
      end
      item
        Name = 'PRINCIPAL'
        Attributes = [faFixed]
        DataType = ftString
        Size = 1
      end
      item
        Name = 'ENTREGA'
        Attributes = [faFixed]
        DataType = ftString
        Size = 1
      end
      item
        Name = 'COBRANCA'
        Attributes = [faFixed]
        DataType = ftString
        Size = 1
      end
      item
        Name = 'CORRESPONDENCIA'
        Attributes = [faFixed]
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
    AfterEdit = CDSEnderecoAfterEdit
    BeforeDelete = CDSEnderecoBeforeDelete
    Left = 864
    Top = 3
    Data = {
      E90100009619E0BD010000001800000012000000000003000000E90102494404
      000100000000000A49445F454D505245534104000100000000000949445F5045
      53534F4104000100000000000A4C4F475241444F55524F010049000000010005
      5749445448020002003C00064E554D45524F0100490000000100055749445448
      020002000A000B434F4D504C454D454E544F0100490000000100055749445448
      020002003C000642414952524F0100490000000100055749445448020002003C
      00064349444144450100490000000100055749445448020002003C0003434550
      01004900000001000557494454480200020008000E4D554E49434950494F5F49
      4247450400010000000000025546010049002000010005574944544802000200
      020004464F4E450100490000000100055749445448020002000E000346415801
      00490000000100055749445448020002000E00095052494E434950414C010049
      002000010005574944544802000200010007454E545245474101004900200001
      0005574944544802000200010008434F4252414E434101004900200001000557
      494454480200020001000F434F52524553504F4E44454E434941010049002000
      0100055749445448020002000100085045525349535445010049000000010005
      57494454480200020001000000}
    object CDSEnderecoID: TIntegerField
      FieldName = 'ID'
    end
    object CDSEnderecoID_EMPRESA: TIntegerField
      FieldName = 'ID_EMPRESA'
    end
    object CDSEnderecoID_PESSOA: TIntegerField
      FieldName = 'ID_PESSOA'
    end
    object CDSEnderecoLOGRADOURO: TStringField
      FieldName = 'LOGRADOURO'
      Size = 60
    end
    object CDSEnderecoNUMERO: TStringField
      FieldName = 'NUMERO'
      Size = 10
    end
    object CDSEnderecoCOMPLEMENTO: TStringField
      FieldName = 'COMPLEMENTO'
      Size = 60
    end
    object CDSEnderecoBAIRRO: TStringField
      FieldName = 'BAIRRO'
      Size = 60
    end
    object CDSEnderecoCIDADE: TStringField
      FieldName = 'CIDADE'
      Size = 60
    end
    object CDSEnderecoCEP: TStringField
      FieldName = 'CEP'
      EditMask = '#####-###;0;_'
      Size = 8
    end
    object CDSEnderecoMUNICIPIO_IBGE: TIntegerField
      FieldName = 'MUNICIPIO_IBGE'
    end
    object CDSEnderecoUF: TStringField
      FieldName = 'UF'
      FixedChar = True
      Size = 2
    end
    object CDSEnderecoFONE: TStringField
      FieldName = 'FONE'
      EditMask = '(##)####.####;0;_'
      Size = 14
    end
    object CDSEnderecoFAX: TStringField
      FieldName = 'FAX'
      EditMask = '(##)####.####;0;_'
      Size = 14
    end
    object CDSEnderecoPRINCIPAL: TStringField
      FieldName = 'PRINCIPAL'
      FixedChar = True
      Size = 1
    end
    object CDSEnderecoENTREGA: TStringField
      FieldName = 'ENTREGA'
      FixedChar = True
      Size = 1
    end
    object CDSEnderecoCOBRANCA: TStringField
      FieldName = 'COBRANCA'
      FixedChar = True
      Size = 1
    end
    object CDSEnderecoCORRESPONDENCIA: TStringField
      FieldName = 'CORRESPONDENCIA'
      FixedChar = True
      Size = 1
    end
    object CDSEnderecoPERSISTE: TStringField
      FieldName = 'PERSISTE'
      Size = 1
    end
  end
  object DSEndereco: TDataSource
    DataSet = CDSEndereco
    Left = 925
  end
  object PopupMenu1: TPopupMenu
    Images = FDataModule.ImagensCadastros
    Left = 888
    Top = 395
    object CarregarImaem1: TMenuItem
      Caption = 'Carregar Imagem'
      ImageIndex = 28
      OnClick = CarregarImaem1Click
    end
  end
end
