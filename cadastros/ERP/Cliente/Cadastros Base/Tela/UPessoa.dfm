inherited FPessoa: TFPessoa
  Tag = 1
  Left = 381
  Top = 150
  Caption = 'Pessoa'
  ClientHeight = 548
  ClientWidth = 942
  ExplicitLeft = 381
  ExplicitTop = 150
  ExplicitWidth = 950
  ExplicitHeight = 582
  PixelsPerInch = 96
  TextHeight = 13
  inherited PageControl: TPageControl
    Width = 942
    Height = 517
    ActivePage = PaginaEdits
    ExplicitWidth = 860
    ExplicitHeight = 517
    inherited PaginaGrid: TTabSheet
      ExplicitWidth = 934
      ExplicitHeight = 489
      inherited PanelGrid: TPanel
        Width = 934
        Height = 489
        ExplicitWidth = 934
        ExplicitHeight = 489
        inherited Grid: TJvDBUltimGrid
          Width = 934
          Height = 437
        end
        inherited PanelFiltroRapido: TPanel
          Top = 437
          Width = 934
          ExplicitTop = 437
          ExplicitWidth = 934
          inherited BotaoConsultar: TSpeedButton
            Left = 802
            ExplicitLeft = 857
          end
          inherited EditCriterioRapido: TLabeledMaskEdit
            Width = 633
            ExplicitWidth = 551
          end
        end
      end
    end
    inherited PaginaEdits: TTabSheet
      ExplicitWidth = 852
      ExplicitHeight = 489
      inherited PanelEdits: TPanel
        Width = 934
        Height = 489
        ExplicitWidth = 852
        ExplicitHeight = 489
        object ScrollBox: TScrollBox
          Left = 4
          Top = 4
          Width = 926
          Height = 481
          Align = alClient
          BevelInner = bvNone
          BevelOuter = bvNone
          BorderStyle = bsNone
          TabOrder = 0
          ExplicitWidth = 844
          DesignSize = (
            926
            481)
          object PanelPessoaDadosBase: TPanel
            Left = 7
            Top = 8
            Width = 909
            Height = 107
            Anchors = [akLeft, akTop, akRight]
            BevelOuter = bvLowered
            TabOrder = 1
            DesignSize = (
              909
              107)
            object EditEmail: TLabeledEdit
              Left = 9
              Top = 76
              Width = 376
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              EditLabel.Width = 32
              EditLabel.Height = 13
              EditLabel.Caption = 'E-mail:'
              TabOrder = 3
            end
            object EditNome: TLabeledEdit
              Left = 9
              Top = 27
              Width = 616
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              EditLabel.Width = 31
              EditLabel.Height = 13
              EditLabel.Caption = 'Nome:'
              MaxLength = 150
              TabOrder = 0
            end
            object ComboboxTipoPessoa: TLabeledComboBox
              Left = 631
              Top = 27
              Width = 139
              Height = 21
              Style = csDropDownList
              Anchors = [akTop, akRight]
              ItemIndex = 0
              TabOrder = 1
              Text = 'F'#237'sica'
              OnChange = ComboboxTipoPessoaChange
              Items.Strings = (
                'F'#237'sica'
                'Jur'#237'dica')
              ComboBoxLabel.Width = 76
              ComboBoxLabel.Height = 13
              ComboBoxLabel.Caption = 'Tipo de Pessoa:'
            end
            object CheckListBoxPessoa: TJvCheckListBox
              Left = 784
              Top = 14
              Width = 113
              Height = 83
              Anchors = [akTop, akRight]
              DoubleBuffered = False
              ItemHeight = 13
              Items.Strings = (
                'Cliente'
                'Fornecedor'
                'Colaborador'
                'Conv'#234'nio'
                'Contador'
                'Transportadora')
              ParentDoubleBuffered = False
              ScrollWidth = 93
              TabOrder = 2
            end
            object EditSite: TLabeledEdit
              Left = 397
              Top = 76
              Width = 373
              Height = 21
              Anchors = [akTop, akRight]
              EditLabel.Width = 22
              EditLabel.Height = 13
              EditLabel.Caption = 'Site:'
              TabOrder = 4
            end
          end
          object PageControlDadosPessoa: TPageControl
            Left = 7
            Top = 130
            Width = 909
            Height = 343
            ActivePage = tsTipoPessoa
            Anchors = [akLeft, akTop, akRight, akBottom]
            TabOrder = 0
            object tsTipoPessoa: TTabSheet
              Caption = 'Informa'#231#245'es do Tipo de Pessoa'
              ExplicitLeft = 0
              ExplicitTop = 0
              ExplicitWidth = 0
              ExplicitHeight = 0
              object PanelDadosPessoa: TPanel
                Left = 0
                Top = 0
                Width = 901
                Height = 315
                Align = alClient
                TabOrder = 0
                ExplicitWidth = 798
                ExplicitHeight = 308
                DesignSize = (
                  901
                  315)
                object PageControlTipoPessoa: TPageControl
                  Left = 3
                  Top = 5
                  Width = 892
                  Height = 298
                  ActivePage = tsPessoaFisica
                  Anchors = [akLeft, akTop, akRight, akBottom]
                  TabOrder = 0
                  Visible = False
                  ExplicitWidth = 789
                  object tsPessoaFisica: TTabSheet
                    Caption = 'tsPessoaFisica'
                    ExplicitLeft = 0
                    ExplicitTop = 0
                    ExplicitWidth = 0
                    ExplicitHeight = 0
                    object PanelPessoaFisica: TPanel
                      Left = 0
                      Top = 0
                      Width = 884
                      Height = 270
                      Align = alClient
                      BevelOuter = bvNone
                      TabOrder = 0
                      Visible = False
                      ExplicitWidth = 781
                      DesignSize = (
                        884
                        270)
                      object EditCPF: TLabeledMaskEdit
                        Left = 8
                        Top = 18
                        Width = 111
                        Height = 21
                        Color = clWhite
                        EditLabel.Width = 23
                        EditLabel.Height = 13
                        EditLabel.Caption = 'CPF:'
                        MaxLength = 14
                        TabOrder = 0
                        Text = '   ........-. -. -. -. -  -'
                        Required = False
                        EditMask = '###.###.###-##;0;_'
                        MaskState = []
                      end
                      object GroupBoxRG: TGroupBox
                        Left = 8
                        Top = 136
                        Width = 449
                        Height = 57
                        Caption = 'RG'
                        TabOrder = 9
                        object EditRGNumero: TLabeledEdit
                          Left = 11
                          Top = 30
                          Width = 121
                          Height = 21
                          EditLabel.Width = 41
                          EditLabel.Height = 13
                          EditLabel.Caption = 'N'#250'mero:'
                          TabOrder = 0
                        end
                        object EditRGEmissao: TLabeledDateEdit
                          Left = 140
                          Top = 30
                          Width = 99
                          Height = 21
                          TabOrder = 1
                          DateEditLabel.Width = 42
                          DateEditLabel.Height = 13
                          DateEditLabel.Caption = 'Emiss'#227'o:'
                        end
                        object EditRGOrgaoEmissor: TLabeledEdit
                          Left = 247
                          Top = 30
                          Width = 193
                          Height = 21
                          EditLabel.Width = 73
                          EditLabel.Height = 13
                          EditLabel.Caption = 'Org'#227'o Emissor:'
                          TabOrder = 2
                        end
                      end
                      object EditNascimento: TLabeledDateEdit
                        Left = 131
                        Top = 18
                        Width = 99
                        Height = 21
                        TabOrder = 1
                        DateEditLabel.Width = 59
                        DateEditLabel.Height = 13
                        DateEditLabel.Caption = 'Nascimento:'
                      end
                      object RadioGroupSexo: TRadioGroup
                        Left = 679
                        Top = 136
                        Width = 93
                        Height = 57
                        Caption = 'Sexo: '
                        ItemIndex = 0
                        Items.Strings = (
                          'Feminino'
                          'Masculino')
                        TabOrder = 11
                      end
                      object LComboBoxEstadoCivil: TLabeledDBLookupComboBox
                        Left = 244
                        Top = 18
                        Width = 204
                        Height = 21
                        ListSource = DSEstadoCivil
                        TabOrder = 2
                        DBLookupComboBoxLabel.Width = 59
                        DBLookupComboBoxLabel.Height = 13
                        DBLookupComboBoxLabel.Caption = 'Estado Civil:'
                      end
                      object EditNomeMae: TLabeledEdit
                        Left = 456
                        Top = 106
                        Width = 419
                        Height = 21
                        Anchors = [akLeft, akTop, akRight]
                        EditLabel.Width = 69
                        EditLabel.Height = 13
                        EditLabel.Caption = 'Nome da M'#227'e:'
                        MaxLength = 100
                        TabOrder = 8
                      end
                      object EditNaturalidade: TLabeledEdit
                        Left = 8
                        Top = 62
                        Width = 440
                        Height = 21
                        EditLabel.Width = 65
                        EditLabel.Height = 13
                        EditLabel.Caption = 'Naturalidade:'
                        MaxLength = 100
                        TabOrder = 5
                      end
                      object EditNacionalidade: TLabeledEdit
                        Left = 456
                        Top = 62
                        Width = 419
                        Height = 21
                        Anchors = [akLeft, akTop, akRight]
                        EditLabel.Width = 70
                        EditLabel.Height = 13
                        EditLabel.Caption = 'Nacionalidade:'
                        MaxLength = 100
                        TabOrder = 6
                      end
                      object ComboBoxRaca: TLabeledComboBox
                        Left = 456
                        Top = 18
                        Width = 198
                        Height = 21
                        Style = csDropDownList
                        TabOrder = 3
                        Items.Strings = (
                          'B - Branco '
                          'N - Negro '
                          'P - Pardo'
                          'I - Indio')
                        ComboBoxLabel.Width = 28
                        ComboBoxLabel.Height = 13
                        ComboBoxLabel.Caption = 'Ra'#231'a:'
                      end
                      object ComboBoxTipoSangue: TLabeledComboBox
                        Left = 664
                        Top = 18
                        Width = 211
                        Height = 21
                        Style = csDropDownList
                        Anchors = [akLeft, akTop, akRight]
                        TabOrder = 4
                        Items.Strings = (
                          'A+'
                          'A-'
                          'B+'
                          'B-'
                          'O+'
                          'O-'
                          'AB+'
                          'AB-')
                        ComboBoxLabel.Width = 77
                        ComboBoxLabel.Height = 13
                        ComboBoxLabel.Caption = 'Tipo Sangu'#237'neo:'
                        ExplicitWidth = 108
                      end
                      object GroupBoxCNH: TGroupBox
                        Left = 8
                        Top = 202
                        Width = 389
                        Height = 57
                        Caption = 'CNH'
                        TabOrder = 12
                        object EditCNHNumero: TLabeledEdit
                          Left = 11
                          Top = 30
                          Width = 145
                          Height = 21
                          EditLabel.Width = 41
                          EditLabel.Height = 13
                          EditLabel.Caption = 'N'#250'mero:'
                          TabOrder = 0
                        end
                        object EditCNHVencimento: TLabeledDateEdit
                          Left = 164
                          Top = 30
                          Width = 99
                          Height = 21
                          TabOrder = 1
                          DateEditLabel.Width = 42
                          DateEditLabel.Height = 13
                          DateEditLabel.Caption = 'Emiss'#227'o:'
                        end
                        object ComboBoxCNHCategoria: TLabeledComboBox
                          Left = 272
                          Top = 30
                          Width = 108
                          Height = 21
                          Style = csDropDownList
                          TabOrder = 2
                          Items.Strings = (
                            'A'
                            'B'
                            'C'
                            'D'
                            'E')
                          ComboBoxLabel.Width = 51
                          ComboBoxLabel.Height = 13
                          ComboBoxLabel.Caption = 'Categoria:'
                        end
                      end
                      object GroupBoxTituloEleitoral: TGroupBox
                        Left = 403
                        Top = 202
                        Width = 369
                        Height = 57
                        Caption = 'T'#237'tulo Eleitoral'
                        TabOrder = 13
                        object EditTituloNumero: TLabeledEdit
                          Left = 11
                          Top = 30
                          Width = 166
                          Height = 21
                          EditLabel.Width = 41
                          EditLabel.Height = 13
                          EditLabel.Caption = 'N'#250'mero:'
                          TabOrder = 0
                        end
                        object EditTituloZona: TLabeledCalcEdit
                          Left = 188
                          Top = 30
                          Width = 80
                          Height = 21
                          ShowButton = False
                          TabOrder = 1
                          DecimalPlacesAlwaysShown = False
                          CalcEditLabel.Width = 28
                          CalcEditLabel.Height = 13
                          CalcEditLabel.Caption = 'Zona:'
                        end
                        object EditTituloSecao: TLabeledCalcEdit
                          Left = 279
                          Top = 30
                          Width = 80
                          Height = 21
                          ShowButton = False
                          TabOrder = 2
                          DecimalPlacesAlwaysShown = False
                          CalcEditLabel.Width = 33
                          CalcEditLabel.Height = 13
                          CalcEditLabel.Caption = 'Se'#231#227'o:'
                        end
                      end
                      object EditNomePai: TLabeledEdit
                        Left = 8
                        Top = 106
                        Width = 440
                        Height = 21
                        EditLabel.Width = 63
                        EditLabel.Height = 13
                        EditLabel.Caption = 'Nome do Pai:'
                        MaxLength = 100
                        TabOrder = 7
                      end
                      object GroupBoxReservista: TGroupBox
                        Left = 463
                        Top = 136
                        Width = 208
                        Height = 57
                        Caption = 'Reservista'
                        TabOrder = 10
                        object EditReservistaNumero: TLabeledEdit
                          Left = 11
                          Top = 30
                          Width = 121
                          Height = 21
                          EditLabel.Width = 41
                          EditLabel.Height = 13
                          EditLabel.Caption = 'N'#250'mero:'
                          TabOrder = 0
                        end
                        object ComboBoxReservistaCategoria: TLabeledComboBox
                          Left = 141
                          Top = 30
                          Width = 55
                          Height = 21
                          Style = csDropDownList
                          TabOrder = 1
                          Items.Strings = (
                            '1'
                            '2'
                            '3')
                          ComboBoxLabel.Width = 51
                          ComboBoxLabel.Height = 13
                          ComboBoxLabel.Caption = 'Categoria:'
                        end
                      end
                    end
                  end
                  object tsPessoaJuridica: TTabSheet
                    Caption = 'tsPessoaJuridica'
                    ImageIndex = 1
                    ExplicitLeft = 0
                    ExplicitTop = 0
                    ExplicitWidth = 0
                    ExplicitHeight = 0
                    object PanelPessoaJuridica: TPanel
                      Left = 0
                      Top = 0
                      Width = 884
                      Height = 270
                      Align = alClient
                      BevelOuter = bvNone
                      TabOrder = 0
                      Visible = False
                      ExplicitWidth = 781
                      DesignSize = (
                        884
                        270)
                      object EditFantasia: TLabeledEdit
                        Left = 7
                        Top = 24
                        Width = 866
                        Height = 21
                        Anchors = [akLeft, akTop, akRight]
                        EditLabel.Width = 90
                        EditLabel.Height = 13
                        EditLabel.Caption = 'Nome de Fantasia:'
                        MaxLength = 150
                        TabOrder = 0
                      end
                      object EditCNPJ: TLabeledMaskEdit
                        Left = 7
                        Top = 74
                        Width = 113
                        Height = 21
                        EditLabel.Width = 29
                        EditLabel.Height = 13
                        EditLabel.Caption = 'CNPJ:'
                        MaxLength = 18
                        TabOrder = 1
                        Text = '  ......../. /.- /.- /.- / - / -   -'
                        Required = False
                        EditMask = '##.###.###/####-##;0;_'
                        MaskState = []
                      end
                      object EditInscricaoMunicipal: TLabeledEdit
                        Left = 330
                        Top = 74
                        Width = 190
                        Height = 21
                        EditLabel.Width = 88
                        EditLabel.Height = 13
                        EditLabel.Caption = 'Incri'#231#227'o Municipal:'
                        MaxLength = 30
                        TabOrder = 3
                      end
                      object EditDataConstituicao: TLabeledDateEdit
                        Left = 532
                        Top = 74
                        Width = 104
                        Height = 21
                        TabOrder = 4
                        DateEditLabel.Width = 104
                        DateEditLabel.Height = 13
                        DateEditLabel.Caption = 'Data da Constitui'#231#227'o:'
                      end
                      object EditInscricaoEstadual: TLabeledEdit
                        Left = 130
                        Top = 74
                        Width = 190
                        Height = 21
                        EditLabel.Width = 86
                        EditLabel.Height = 13
                        EditLabel.Caption = 'Incri'#231#227'o Estadual:'
                        MaxLength = 30
                        TabOrder = 2
                      end
                      object EditSuframa: TLabeledEdit
                        Left = 644
                        Top = 74
                        Width = 229
                        Height = 21
                        Anchors = [akLeft, akTop, akRight]
                        EditLabel.Width = 44
                        EditLabel.Height = 13
                        EditLabel.Caption = 'Suframa:'
                        MaxLength = 9
                        TabOrder = 5
                      end
                      object ComboBoxTipoRegime: TLabeledComboBox
                        Left = 7
                        Top = 122
                        Width = 233
                        Height = 21
                        Style = csDropDownList
                        TabOrder = 6
                        Items.Strings = (
                          '1-Lucro Real'
                          '2-Lucro Presumido'
                          '3-Simples Nacional')
                        ComboBoxLabel.Width = 62
                        ComboBoxLabel.Height = 13
                        ComboBoxLabel.Caption = 'Tipo Regime:'
                      end
                      object ComboBoxCRT: TLabeledComboBox
                        Left = 249
                        Top = 122
                        Width = 624
                        Height = 21
                        Style = csDropDownList
                        Anchors = [akLeft, akTop, akRight]
                        TabOrder = 7
                        Items.Strings = (
                          '1-Simples Nacional'
                          '2-Simples Nacional - excesso de sublimite da receita bruta'
                          '3-Regime Normal ')
                        ComboBoxLabel.Width = 24
                        ComboBoxLabel.Height = 13
                        ComboBoxLabel.Caption = 'CRT:'
                        ExplicitWidth = 521
                      end
                    end
                  end
                end
              end
            end
            object TabSheetContatos: TTabSheet
              Caption = 'Contatos'
              ImageIndex = 2
              object PanelContatos: TPanel
                Left = 0
                Top = 0
                Width = 901
                Height = 315
                Align = alClient
                BevelOuter = bvNone
                TabOrder = 0
                object GridContato: TJvDBUltimGrid
                  Left = 0
                  Top = 0
                  Width = 901
                  Height = 315
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
            end
            object TabSheetEnderecos: TTabSheet
              Caption = 'Endere'#231'os'
              ImageIndex = 2
              object PanelEnderecos: TPanel
                Left = 0
                Top = 0
                Width = 901
                Height = 315
                Align = alClient
                BevelOuter = bvNone
                TabOrder = 0
                object GridEndereco: TJvDBUltimGrid
                  Left = 0
                  Top = 0
                  Width = 901
                  Height = 315
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
                      Title.Caption = 'C'#243'd. IBGE'
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
          end
        end
      end
    end
  end
  inherited PanelToolBar: TPanel
    Width = 942
    ExplicitWidth = 860
    inherited BotaoSair: TSpeedButton
      Left = 838
      ExplicitLeft = 913
    end
    inherited BotaoExportar: TSpeedButton
      Left = 738
      ExplicitLeft = 823
    end
    inherited BotaoImprimir: TSpeedButton
      Left = 628
      ExplicitLeft = 743
    end
    inherited BotaoSeparador1: TSpeedButton
      Left = 728
      ExplicitLeft = 903
    end
    inherited BotaoFiltrar: TSpeedButton
      Left = 528
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
    Top = 419
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
    Left = 861
    Top = 464
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
    Left = 784
    Top = 416
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
    Left = 781
    Top = 464
  end
  object CDSEstadoCivil: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 696
    Top = 416
  end
  object DSEstadoCivil: TDataSource
    AutoEdit = False
    DataSet = CDSEstadoCivil
    Left = 694
    Top = 464
  end
end
