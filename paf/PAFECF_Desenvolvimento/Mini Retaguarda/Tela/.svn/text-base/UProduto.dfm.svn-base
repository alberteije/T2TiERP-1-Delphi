object FProduto: TFProduto
  Tag = 1
  Left = 369
  Top = 155
  Caption = 'Produto'
  ClientHeight = 517
  ClientWidth = 920
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
    Width = 920
    Height = 482
    Align = alClient
    BevelInner = bvLowered
    BevelWidth = 2
    TabOrder = 1
    object PanelFiltroRapido: TPanel
      Left = 4
      Top = 426
      Width = 912
      Height = 52
      Align = alBottom
      Color = 14537936
      ParentBackground = False
      TabOrder = 1
      DesignSize = (
        912
        52)
      object SpeedButton1: TSpeedButton
        Left = 774
        Top = 19
        Width = 125
        Height = 22
        Action = ActionFiltroRapido
        Anchors = [akTop, akRight]
        Constraints.MaxWidth = 125
        Constraints.MinWidth = 125
        Flat = True
        ExplicitLeft = 787
      end
      object Label1: TLabel
        Left = 6
        Top = 6
        Width = 37
        Height = 13
        Caption = 'Campo:'
      end
      object EditCriterioRapido: TLabeledEdit
        Left = 157
        Top = 24
        Width = 611
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        Constraints.MinWidth = 145
        EditLabel.Width = 107
        EditLabel.Height = 13
        EditLabel.Caption = 'Crit'#233'rio para consulta:'
        TabOrder = 0
      end
      object ComboBoxCampos: TComboBox
        Left = 6
        Top = 24
        Width = 145
        Height = 22
        Style = csOwnerDrawFixed
        TabOrder = 1
      end
    end
    object Grid: TJvDBUltimGrid
      Left = 4
      Top = 4
      Width = 912
      Height = 422
      Align = alClient
      DataSource = FDataModule.DSProduto
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnDblClick = ActionAlterarExecute
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
  end
  object PanelEdits: TPanel
    Left = 0
    Top = 35
    Width = 920
    Height = 482
    Align = alClient
    BevelEdges = []
    BevelInner = bvLowered
    BevelWidth = 2
    TabOrder = 2
    object Panel1: TPanel
      Left = 4
      Top = 34
      Width = 912
      Height = 444
      Align = alClient
      BevelInner = bvLowered
      BevelOuter = bvNone
      BiDiMode = bdLeftToRight
      Ctl3D = True
      UseDockManager = False
      DoubleBuffered = False
      FullRepaint = False
      ParentBiDiMode = False
      ParentBackground = False
      ParentCtl3D = False
      ParentDoubleBuffered = False
      ShowCaption = False
      TabOrder = 1
      ExplicitTop = 36
      ExplicitHeight = 442
      object Label9: TLabel
        Left = 279
        Top = 48
        Width = 88
        Height = 13
        Caption = 'C'#243'digo da Balan'#231'a'
      end
      object Label4: TLabel
        Left = 589
        Top = 48
        Width = 91
        Height = 13
        Caption = 'Unidade de Medida'
      end
      object Label14: TLabel
        Left = 6
        Top = 48
        Width = 68
        Height = 13
        Caption = 'Descri'#231#227'o PDV'
      end
      object Label15: TLabel
        Left = 449
        Top = 48
        Width = 72
        Height = 13
        Caption = 'C'#243'digo Interno'
      end
      object Label24: TLabel
        Left = 378
        Top = 48
        Width = 40
        Height = 13
        Caption = 'Validade'
      end
      object Label17: TLabel
        Left = 811
        Top = 48
        Width = 91
        Height = 13
        Caption = ' para Localizar - F1'
      end
      object EditNome: TLabeledEdit
        Left = 148
        Top = 20
        Width = 761
        Height = 21
        EditLabel.Width = 31
        EditLabel.Height = 13
        EditLabel.Caption = 'Nome:'
        MaxLength = 100
        TabOrder = 1
        Text = 'EditNome'
        OnKeyUp = EditNomeKeyUp
      end
      object EditGtin: TLabeledEdit
        Left = 6
        Top = 20
        Width = 136
        Height = 21
        EditLabel.Width = 82
        EditLabel.Height = 13
        EditLabel.Caption = 'C'#243'digo de Barras'
        MaxLength = 14
        TabOrder = 0
        Text = 'EditGtin'
      end
      object EditNCM: TLabeledEdit
        Left = 776
        Top = 65
        Width = 133
        Height = 21
        EditLabel.Width = 22
        EditLabel.Height = 13
        EditLabel.Caption = 'NCM'
        MaxLength = 8
        TabOrder = 7
        OnKeyDown = EditNCMKeyDown
      end
      object MeDescricao: TMemo
        Left = 7
        Top = 312
        Width = 266
        Height = 122
        TabOrder = 11
      end
      object edtUnidadeMedida: TDBLookupComboBox
        Left = 589
        Top = 65
        Width = 181
        Height = 21
        ListSource = FDataModule.DSUnidadeProduto
        TabOrder = 6
      end
      object EditCodigoBalanca: TJvCalcEdit
        Left = 280
        Top = 65
        Width = 93
        Height = 21
        DecimalPlaces = 0
        DisplayFormat = '0'
        MaxValue = 9999.000000000000000000
        ShowButton = False
        TabOrder = 3
        DecimalPlacesAlwaysShown = False
      end
      object editCodigoInterno: TEdit
        Left = 449
        Top = 65
        Width = 127
        Height = 21
        MaxLength = 20
        TabOrder = 5
        Text = 'editCodigoInterno'
      end
      object EditDescricaoPDV: TEdit
        Left = 6
        Top = 65
        Width = 263
        Height = 21
        TabOrder = 2
        Text = 'EditDescricaoPDV'
      end
      object GpBoxEst: TGroupBox
        Left = 8
        Top = 198
        Width = 345
        Height = 108
        Caption = 'Estoque'
        TabOrder = 9
        object Label3: TLabel
          Left = 17
          Top = 19
          Width = 74
          Height = 13
          Caption = 'Estoque Minimo'
        end
        object Label6: TLabel
          Left = 123
          Top = 19
          Width = 78
          Height = 13
          Caption = 'Estoque M'#225'ximo'
        end
        object Label5: TLabel
          Left = 229
          Top = 19
          Width = 69
          Height = 13
          Caption = 'Qtde Estoque '
        end
        object Label22: TLabel
          Left = 17
          Top = 61
          Width = 72
          Height = 13
          Caption = 'Data Altera'#231#227'o'
        end
        object Label8: TLabel
          Left = 192
          Top = 61
          Width = 80
          Height = 13
          Caption = 'Data do Estoque'
        end
        object EditEstoqueMinimo: TJvCalcEdit
          Left = 17
          Top = 38
          Width = 90
          Height = 21
          DecimalPlaceRound = True
          DecimalPlaces = 3
          DisplayFormat = '0.000'
          ShowButton = False
          TabOrder = 0
          DecimalPlacesAlwaysShown = True
        end
        object EditEstoqueMaximo: TJvCalcEdit
          Left = 123
          Top = 38
          Width = 90
          Height = 21
          DecimalPlaceRound = True
          DecimalPlaces = 3
          DisplayFormat = '0.000'
          ShowButton = False
          TabOrder = 1
          DecimalPlacesAlwaysShown = True
        end
        object EditQtde_estoque: TJvCalcEdit
          Left = 229
          Top = 38
          Width = 90
          Height = 21
          DecimalPlaceRound = True
          DecimalPlaces = 3
          DisplayFormat = '0.000'
          ShowButton = False
          TabOrder = 2
          DecimalPlacesAlwaysShown = True
        end
        object editDataAlteracao: TJvDateEdit
          Left = 17
          Top = 80
          Width = 121
          Height = 21
          TabStop = False
          DirectInput = False
          ReadOnly = True
          TabOrder = 3
        end
        object EditDataEstoque: TJvDateEdit
          Left = 192
          Top = 80
          Width = 127
          Height = 21
          DialogTitle = 'Selecione a Data'
          TabOrder = 4
        end
      end
      object GpBoxMov: TGroupBox
        Left = 279
        Top = 312
        Width = 498
        Height = 122
        Caption = 'Movimenta'#231#227'o da '#218'ltima entrada'
        Enabled = False
        TabOrder = 12
        object Label13: TLabel
          Left = 367
          Top = 24
          Width = 69
          Height = 13
          Caption = 'Ultima Compra'
        end
        object Label19: TLabel
          Left = 19
          Top = 75
          Width = 91
          Height = 13
          Caption = 'Unidade de Medida'
        end
        object Label20: TLabel
          Left = 147
          Top = 24
          Width = 68
          Height = 13
          Caption = 'N'#250'mero da NF'
        end
        object Label21: TLabel
          Left = 134
          Top = 75
          Width = 55
          Height = 13
          Caption = 'Fornecedor'
        end
        object Label16: TLabel
          Left = 15
          Top = 24
          Width = 39
          Height = 13
          Caption = 'Data NF'
        end
        object Label23: TLabel
          Left = 240
          Top = 24
          Width = 25
          Height = 13
          Caption = 'CNPJ'
        end
        object editValorUnNF: TJvCalcEdit
          Left = 367
          Top = 42
          Width = 120
          Height = 21
          DecimalPlaceRound = True
          DisplayFormat = '0.00'
          ShowButton = False
          TabOrder = 4
          DecimalPlacesAlwaysShown = True
        end
        object EditNumNF: TEdit
          Left = 147
          Top = 42
          Width = 75
          Height = 21
          MaxLength = 20
          TabOrder = 1
        end
        object EditFornecedor: TEdit
          Left = 134
          Top = 94
          Width = 355
          Height = 21
          MaxLength = 20
          TabOrder = 3
        end
        object EditCNPJ: TEdit
          Left = 240
          Top = 42
          Width = 113
          Height = 21
          MaxLength = 20
          TabOrder = 2
        end
        object EditDataNF: TJvDateEdit
          Left = 15
          Top = 42
          Width = 121
          Height = 21
          TabStop = False
          DirectInput = False
          TabOrder = 0
        end
        object EditUnidadeCompra: TEdit
          Left = 21
          Top = 94
          Width = 94
          Height = 21
          MaxLength = 20
          TabOrder = 5
        end
      end
      object EditValidade: TJvCalcEdit
        Left = 379
        Top = 65
        Width = 60
        Height = 21
        DecimalPlaces = 0
        DisplayFormat = '0'
        MaxValue = 9999.000000000000000000
        ShowButton = False
        TabOrder = 4
        DecimalPlacesAlwaysShown = False
      end
      object GpBoxPrecificacao: TGroupBox
        Left = 8
        Top = 92
        Width = 345
        Height = 105
        Caption = 'Precifica'#231#227'o'
        TabOrder = 8
        object Label29: TLabel
          Left = 229
          Top = 57
          Width = 59
          Height = 13
          Caption = '% Comiss'#227'o'
        end
        object Label28: TLabel
          Left = 123
          Top = 57
          Width = 59
          Height = 13
          Caption = '% Desconto'
        end
        object Label2: TLabel
          Left = 17
          Top = 57
          Width = 72
          Height = 13
          Caption = 'Valor de Venda'
        end
        object Label27: TLabel
          Left = 229
          Top = 17
          Width = 69
          Height = 13
          Caption = '% Lucro Bruto'
        end
        object Label26: TLabel
          Left = 123
          Top = 17
          Width = 58
          Height = 13
          Caption = 'Pre'#231'o Custo'
        end
        object Label25: TLabel
          Left = 17
          Top = 17
          Width = 59
          Height = 13
          Caption = 'Custo Medio'
        end
        object EditPerComissao: TJvCalcEdit
          Left = 229
          Top = 73
          Width = 90
          Height = 21
          DecimalPlaceRound = True
          DisplayFormat = '0.00'
          ShowButton = False
          TabOrder = 5
          DecimalPlacesAlwaysShown = True
        end
        object EditPerDesconto: TJvCalcEdit
          Left = 123
          Top = 73
          Width = 90
          Height = 21
          DecimalPlaceRound = True
          DisplayFormat = '0.00'
          ShowButton = False
          TabOrder = 4
          DecimalPlacesAlwaysShown = True
        end
        object EditValor_venda: TJvCalcEdit
          Left = 17
          Top = 73
          Width = 90
          Height = 21
          DecimalPlaceRound = True
          DisplayFormat = '0.00'
          ShowButton = False
          TabOrder = 3
          DecimalPlacesAlwaysShown = True
          OnChange = EditValor_vendaChange
        end
        object EditPrecoCusto: TJvCalcEdit
          Left = 123
          Top = 33
          Width = 90
          Height = 21
          DecimalPlaceRound = True
          DisplayFormat = '0.00'
          ShowButton = False
          TabOrder = 1
          DecimalPlacesAlwaysShown = True
          OnExit = EditPrecoCustoExit
        end
        object EditCustoMedio: TJvCalcEdit
          Left = 17
          Top = 33
          Width = 90
          Height = 21
          DecimalPlaceRound = True
          DisplayFormat = '0.00'
          ReadOnly = True
          ShowButton = False
          TabOrder = 0
          DecimalPlacesAlwaysShown = True
        end
        object EditPercLucroBruto: TJvCalcEdit
          Left = 229
          Top = 33
          Width = 90
          Height = 21
          DisplayFormat = '0.00'
          ShowButton = False
          TabOrder = 2
          DecimalPlacesAlwaysShown = True
          OnExit = EditPercLucroBrutoExit
        end
      end
      object GpBoxInfo: TGroupBox
        Left = 359
        Top = 92
        Width = 550
        Height = 214
        Caption = 'Informa'#231#245'es Adicionais'
        TabOrder = 10
        object Label12: TLabel
          Left = 63
          Top = 17
          Width = 39
          Height = 13
          Caption = 'Aliquota'
        end
        object Label11: TLabel
          Left = 228
          Top = 17
          Width = 52
          Height = 13
          Caption = 'Taxa ICMS'
        end
        object Label10: TLabel
          Left = 327
          Top = 17
          Width = 40
          Height = 13
          Caption = 'Paf P ST'
        end
        object Label7: TLabel
          Left = 150
          Top = 17
          Width = 62
          Height = 13
          Caption = 'ICMS ST ECF'
        end
        object Label30: TLabel
          Left = 285
          Top = 54
          Width = 70
          Height = 13
          Caption = 'Tipo item Sped'
        end
        object Label31: TLabel
          Left = 8
          Top = 55
          Width = 90
          Height = 13
          Caption = 'Origem do Produto'
        end
        object Label32: TLabel
          Left = 8
          Top = 125
          Width = 122
          Height = 13
          Caption = 'CST-ICMS Regime Normal'
        end
        object EditIDImposto: TJvCalcEdit
          Left = 11
          Top = 33
          Width = 38
          Height = 21
          DecimalPlaces = 0
          DirectInput = False
          DisplayFormat = '0'
          ShowButton = False
          TabOrder = 0
          DecimalPlacesAlwaysShown = False
          OnKeyDown = EditIDImpostoKeyDown
        end
        object edtImpostoICMS: TDBLookupComboBox
          Left = 63
          Top = 33
          Width = 76
          Height = 21
          ListSource = FDataModule.DSImpostoIcms
          TabOrder = 1
          OnCloseUp = edtImpostoICMSCloseUp
          OnEnter = edtImpostoICMSEnter
          OnKeyUp = edtImpostoICMSKeyUp
        end
        object EditECF_ICMS_ST: TEdit
          Left = 150
          Top = 33
          Width = 64
          Height = 21
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 2
          Text = 'EditECF_ICMS_ST'
        end
        object editPAF_P_ST: TEdit
          Left = 327
          Top = 33
          Width = 42
          Height = 21
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 4
          Text = 'editPAF_P_ST'
        end
        object editTAXA_ICMS: TJvCalcEdit
          Left = 228
          Top = 33
          Width = 85
          Height = 21
          DecimalPlaceRound = True
          DisplayFormat = '0.00'
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          ShowButton = False
          TabOrder = 3
          DecimalPlacesAlwaysShown = True
        end
        object EditIAT: TLabeledEdit
          Left = 475
          Top = 33
          Width = 63
          Height = 21
          EditLabel.Width = 17
          EditLabel.Height = 13
          EditLabel.Caption = 'IAT'
          MaxLength = 1
          TabOrder = 6
        end
        object EditIPPT: TLabeledEdit
          Left = 389
          Top = 33
          Width = 63
          Height = 21
          EditLabel.Width = 22
          EditLabel.Height = 13
          EditLabel.Caption = 'IPPT'
          MaxLength = 1
          TabOrder = 5
        end
        object cmbCSTOrigem: TComboBox
          Left = 8
          Top = 73
          Width = 255
          Height = 21
          Style = csDropDownList
          TabOrder = 7
          Items.Strings = (
            '0 : Nacional'
            '1 : Estrangeira - Importa'#231#227'o direta'
            '2 : Estrangeira - Adquirida no mercado interno')
        end
        object cmbCSTTratamentoTrubutario: TComboBox
          Left = 8
          Top = 144
          Width = 443
          Height = 21
          Style = csDropDownList
          DropDownCount = 11
          TabOrder = 9
          Items.Strings = (
            '00 : Tributada integralmente'
            
              '10 : Tributada e com cobran'#231'a do ICMS por substitui'#231#227'o tribut'#225'ri' +
              'a'
            '20 : Com redu'#231#227'o de base de c'#225'lculo'
            
              '30 : Isenta ou n'#227'o tributada e com cobran'#231'a do ICMS por substitu' +
              'i'#231#227'o tribut'#225'ria'
            '40 : Isenta'
            '41 : N'#227'o Tributada'
            '50 : Suspens'#227'o'
            '51 : Diferimento'
            '60 : ICMS cobrado anteriormente por substitui'#231#227'o tribut'#225'ria'
            
              '70 : Com redu'#231#227'o de base de c'#225'lculo e cobran'#231'a do ICMS por subst' +
              'itui'#231#227'o tribut'#225'ria'
            '90 : Outras')
        end
        object cmbItemSped: TComboBox
          Left = 285
          Top = 73
          Width = 253
          Height = 21
          Style = csDropDownList
          TabOrder = 8
          Items.Strings = (
            '00 : Mercadoria para Revenda'
            '01 : Mat'#233'ria-Prima'
            '02 : Embalagem'
            '03 : Produto em Processo'
            '04 : Produto Acabado'
            '05 : Subproduto'
            '06 : Produto Intermedi'#225'rio'
            '07 : Material de Uso e Consumo'
            '08 : Ativo Imobilizado'
            '09 : Servi'#231'os'
            '10 : Outros insumos'
            '99 : Outras')
        end
      end
      object GroupBox1: TGroupBox
        Left = 783
        Top = 312
        Width = 126
        Height = 121
        Caption = 'Exporta para PDV'
        TabOrder = 13
        object btnTotal: TSpeedButton
          Left = 6
          Top = 41
          Width = 110
          Height = 22
          Caption = 'Total'
          OnClick = btnTotalClick
        end
        object btnParcial: TSpeedButton
          Left = 6
          Top = 93
          Width = 110
          Height = 22
          Caption = 'Parcial'
          OnClick = btnParcialClick
        end
      end
    end
    object ActionToolBarEdits: TActionToolBar
      AlignWithMargins = True
      Left = 7
      Top = 7
      Width = 906
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
    end
  end
  object PanelToolBar: TPanel
    Left = 0
    Top = 0
    Width = 920
    Height = 35
    Align = alTop
    Color = 14537936
    ParentBackground = False
    TabOrder = 0
    object ActionToolBarGrid: TActionToolBar
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 912
      Height = 27
      ActionManager = ActionManager
      Align = alClient
      BiDiMode = bdLeftToRight
      Caption = 'ActionToolBarGrid'
      ColorMap.BtnSelectedColor = clBtnFace
      ColorMap.UnusedColor = 15660791
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
          end>
        ActionBar = ActionToolBarEdits
      end
      item
        Items = <
          item
            Caption = '&ActionClientItem0'
          end>
      end
      item
        Items = <
          item
            Caption = '&ActionClientItem0'
          end>
      end
      item
        Items = <
          item
            Caption = '&ActionClientItem0'
          end>
      end>
    DisabledImages = FDataModule.ImagensCadastrosD
    Images = FDataModule.ImagensCadastros
    Left = 459
    Top = 40
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
    Left = 335
    Top = 43
  end
end
