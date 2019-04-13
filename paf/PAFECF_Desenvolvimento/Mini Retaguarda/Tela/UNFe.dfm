object FNFe: TFNFe
  Tag = 1
  Left = 163
  Top = 140
  Caption = 'Nota Fiscal Eletr'#244'nica'
  ClientHeight = 453
  ClientWidth = 921
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
    Top = 76
    Width = 921
    Height = 377
    Align = alClient
    BevelInner = bvLowered
    BevelWidth = 2
    TabOrder = 1
    object PanelFiltroRapido: TPanel
      Left = 4
      Top = 321
      Width = 913
      Height = 52
      Align = alBottom
      Color = 14537936
      ParentBackground = False
      TabOrder = 1
      DesignSize = (
        913
        52)
      object SpeedButton1: TSpeedButton
        Left = 775
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
        Width = 612
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
      Width = 913
      Height = 317
      Align = alClient
      DataSource = FDataModule.DSNFe
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
    Top = 76
    Width = 921
    Height = 377
    Align = alClient
    BevelEdges = []
    BevelInner = bvLowered
    BevelWidth = 2
    TabOrder = 2
    ExplicitLeft = 56
    ExplicitTop = 75
    ExplicitWidth = 922
    ExplicitHeight = 418
    object ActionToolBarEdits: TActionToolBar
      AlignWithMargins = True
      Left = 7
      Top = 7
      Width = 907
      Height = 26
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
      ExplicitHeight = 24
    end
    object pcEdits: TPageControl
      Left = 4
      Top = 36
      Width = 913
      Height = 252
      ActivePage = TabSheet2
      Align = alClient
      TabOrder = 1
      ExplicitTop = 88
      ExplicitHeight = 239
      object TabSheet1: TTabSheet
        Caption = 'Dados da NF-e'
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Panel1: TPanel
          Left = 0
          Top = 0
          Width = 905
          Height = 226
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
          TabOrder = 0
          ExplicitLeft = -1
          ExplicitTop = 2
          ExplicitHeight = 265
          DesignSize = (
            905
            226)
          object Label8: TLabel
            Left = 668
            Top = 5
            Width = 64
            Height = 13
            Anchors = [akTop, akRight]
            Caption = 'Data Emiss'#227'o'
          end
          object Label5: TLabel
            Left = 503
            Top = 46
            Width = 32
            Height = 13
            Caption = 'Pedido'
          end
          object Label6: TLabel
            Left = 582
            Top = 45
            Width = 30
            Height = 13
            Caption = 'Venda'
          end
          object Label7: TLabel
            Left = 668
            Top = 45
            Width = 94
            Height = 13
            Anchors = [akTop, akRight]
            Caption = 'Data Entrada/Sa'#237'da'
          end
          object Label26: TLabel
            Left = 6
            Top = 45
            Width = 70
            Height = 13
            Caption = 'Tipo Opera'#231#227'o'
          end
          object Label27: TLabel
            Left = 95
            Top = 45
            Width = 91
            Height = 13
            Caption = 'Forma Imp. DANFE'
          end
          object Label29: TLabel
            Left = 205
            Top = 45
            Width = 71
            Height = 13
            Caption = 'Forma Emiss'#227'o'
          end
          object Label30: TLabel
            Left = 354
            Top = 45
            Width = 104
            Height = 13
            Caption = 'Finalidade da Emiss'#227'o'
          end
          object editModelo: TLabeledEdit
            Left = 96
            Top = 20
            Width = 35
            Height = 21
            EditLabel.Width = 34
            EditLabel.Height = 13
            EditLabel.Caption = 'Modelo'
            TabOrder = 1
          end
          object editNumeroNFe: TLabeledEdit
            Left = 6
            Top = 20
            Width = 84
            Height = 21
            EditLabel.Width = 37
            EditLabel.Height = 13
            EditLabel.Caption = 'N'#250'mero'
            TabOrder = 0
          end
          object editSerie: TLabeledEdit
            Left = 137
            Top = 20
            Width = 62
            Height = 21
            EditLabel.Width = 24
            EditLabel.Height = 13
            EditLabel.Caption = 'Serie'
            TabOrder = 2
          end
          object editDataEmissao: TJvDateEdit
            Left = 668
            Top = 20
            Width = 110
            Height = 21
            DialogTitle = 'Selecione a Data'
            Anchors = [akTop, akRight]
            TabOrder = 4
          end
          object editNaturezaOp: TLabeledEdit
            Left = 205
            Top = 20
            Width = 457
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            EditLabel.Width = 94
            EditLabel.Height = 13
            EditLabel.Caption = 'Natureza Opera'#231#227'o'
            TabOrder = 3
          end
          object GroupBox1: TGroupBox
            Left = 8
            Top = 89
            Width = 885
            Height = 133
            Anchors = [akLeft, akTop, akRight]
            Caption = 'Destinat'#225'rio'
            TabOrder = 12
            DesignSize = (
              885
              133)
            object Label31: TLabel
              Left = 9
              Top = 12
              Width = 81
              Height = 13
              Alignment = taRightJustify
              Caption = 'ID (F1 - Pequisa)'
            end
            object Label32: TLabel
              Left = 267
              Top = 92
              Width = 49
              Height = 13
              Alignment = taRightJustify
              Caption = 'Cod. IBGE'
            end
            object editDestNome: TLabeledEdit
              Left = 101
              Top = 28
              Width = 377
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              EditLabel.Width = 27
              EditLabel.Height = 13
              EditLabel.Caption = 'Nome'
              MaxLength = 8
              TabOrder = 1
            end
            object editDestDocumento: TLabeledEdit
              Left = 484
              Top = 28
              Width = 140
              Height = 21
              Anchors = [akTop, akRight]
              EditLabel.Width = 54
              EditLabel.Height = 13
              EditLabel.Caption = 'Documento'
              MaxLength = 8
              TabOrder = 2
            end
            object editDestIE: TLabeledEdit
              Left = 630
              Top = 28
              Width = 124
              Height = 21
              Anchors = [akTop, akRight]
              EditLabel.Width = 87
              EditLabel.Height = 13
              EditLabel.Caption = 'Inscri'#231#227'o Estadual'
              MaxLength = 8
              TabOrder = 3
            end
            object editDestTelefone: TLabeledEdit
              Left = 760
              Top = 28
              Width = 117
              Height = 21
              Anchors = [akTop, akRight]
              EditLabel.Width = 42
              EditLabel.Height = 13
              EditLabel.Caption = 'Telefone'
              MaxLength = 8
              TabOrder = 4
            end
            object editDestLogradouro: TLabeledEdit
              Left = 129
              Top = 68
              Width = 472
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              EditLabel.Width = 55
              EditLabel.Height = 13
              EditLabel.Caption = 'Logradouro'
              MaxLength = 8
              TabOrder = 6
            end
            object editDestNumero: TLabeledEdit
              Left = 606
              Top = 68
              Width = 66
              Height = 21
              Anchors = [akTop, akRight]
              EditLabel.Width = 37
              EditLabel.Height = 13
              EditLabel.Caption = 'Numero'
              MaxLength = 8
              TabOrder = 7
            end
            object editDestBairro: TLabeledEdit
              Left = 678
              Top = 68
              Width = 198
              Height = 21
              Anchors = [akTop, akRight]
              EditLabel.Width = 28
              EditLabel.Height = 13
              EditLabel.Caption = 'Bairro'
              MaxLength = 8
              TabOrder = 8
            end
            object editDestCEP: TLabeledEdit
              Left = 10
              Top = 68
              Width = 113
              Height = 21
              EditLabel.Width = 19
              EditLabel.Height = 13
              EditLabel.Caption = 'CEP'
              MaxLength = 8
              TabOrder = 5
            end
            object editDestCidade: TLabeledEdit
              Left = 341
              Top = 108
              Width = 367
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              EditLabel.Width = 33
              EditLabel.Height = 13
              EditLabel.Caption = 'Cidade'
              MaxLength = 8
              TabOrder = 11
            end
            object editDestUF: TLabeledEdit
              Left = 714
              Top = 108
              Width = 39
              Height = 21
              Anchors = [akTop, akRight]
              EditLabel.Width = 13
              EditLabel.Height = 13
              EditLabel.Caption = 'UF'
              MaxLength = 8
              TabOrder = 12
            end
            object editDestComplemento: TLabeledEdit
              Left = 10
              Top = 108
              Width = 251
              Height = 21
              EditLabel.Width = 65
              EditLabel.Height = 13
              EditLabel.Caption = 'Complemento'
              MaxLength = 8
              TabOrder = 9
            end
            object editIDPessoa: TJvValidateEdit
              Left = 9
              Top = 28
              Width = 86
              Height = 21
              CriticalPoints.MaxValueIncluded = False
              CriticalPoints.MinValueIncluded = False
              DisplayFormat = dfFloat
              EditText = '0'
              TabOrder = 0
              ZeroEmpty = True
              OnExit = editIDPessoaExit
              OnKeyDown = editIDPessoaKeyDown
            end
            object editDestCodCidadeIBGE: TJvValidateEdit
              Left = 267
              Top = 108
              Width = 68
              Height = 21
              CriticalPoints.MaxValueIncluded = False
              CriticalPoints.MinValueIncluded = False
              DisplayFormat = dfFloat
              EditText = '0'
              TabOrder = 10
              ZeroEmpty = True
              OnExit = editIDPessoaExit
              OnKeyDown = editIDPessoaKeyDown
            end
          end
          object editVenda: TJvValidateEdit
            Left = 582
            Top = 60
            Width = 80
            Height = 21
            CriticalPoints.MaxValueIncluded = False
            CriticalPoints.MinValueIncluded = False
            DisplayFormat = dfFloat
            EditText = '0'
            TabOrder = 10
            ZeroEmpty = True
          end
          object editPedido: TJvValidateEdit
            Left = 503
            Top = 60
            Width = 73
            Height = 21
            CriticalPoints.MaxValueIncluded = False
            CriticalPoints.MinValueIncluded = False
            DisplayFormat = dfFloat
            EditText = '0'
            TabOrder = 9
            ZeroEmpty = True
          end
          object editDataEntradaSaida: TJvDateEdit
            Left = 668
            Top = 60
            Width = 110
            Height = 21
            DialogTitle = 'Selecione a Data'
            Anchors = [akTop, akRight]
            TabOrder = 11
          end
          object rgpFormaPagamento: TRadioGroup
            Left = 784
            Top = 5
            Width = 109
            Height = 76
            Anchors = [akTop, akRight]
            Caption = 'Forma de Pgto'
            ItemIndex = 0
            Items.Strings = (
              'Pag. a Vista'
              'Pag. a Prazo'
              'Outros')
            TabOrder = 13
          end
          object cbxTipoOperacao: TComboBox
            Left = 7
            Top = 60
            Width = 82
            Height = 22
            Style = csOwnerDrawFixed
            ItemIndex = 0
            TabOrder = 5
            Text = '0 - Sa'#237'da'
            Items.Strings = (
              '0 - Sa'#237'da'
              '1 - Entrada')
          end
          object cbxFormaImpDANFE: TComboBox
            Left = 95
            Top = 60
            Width = 104
            Height = 22
            Style = csOwnerDrawFixed
            ItemIndex = 0
            TabOrder = 6
            Text = '1 - Retrato'
            Items.Strings = (
              '1 - Retrato'
              '2 - Paisagem')
          end
          object cbxFormaEmissao: TComboBox
            Left = 205
            Top = 60
            Width = 143
            Height = 22
            Style = csOwnerDrawFixed
            ItemIndex = 0
            TabOrder = 7
            Text = '1 - Normal'
            Items.Strings = (
              '1 - Normal'
              '2 - Conting'#234'ncia'
              '3 - Conting'#234'ncia SCAN'
              '4 - Conting'#234'ncia DPEC'
              '5 - Conting'#234'ncia FS-DA')
          end
          object cbxFinalidadeEmissao: TComboBox
            Left = 354
            Top = 60
            Width = 143
            Height = 22
            Style = csOwnerDrawFixed
            ItemIndex = 0
            TabOrder = 8
            Text = '1 - Normal'
            Items.Strings = (
              '1 - Normal'
              '2 - Complementar'
              '3 - Ajuste')
          end
        end
      end
      object TabSheet2: TTabSheet
        Caption = 'Produtos'
        ImageIndex = 1
        OnEnter = TabSheet2Enter
        ExplicitHeight = 226
        object Panel2: TPanel
          Left = 0
          Top = 0
          Width = 905
          Height = 224
          Align = alClient
          BevelInner = bvLowered
          BevelOuter = bvNone
          ParentBackground = False
          TabOrder = 0
          ExplicitHeight = 226
          object GridItens: TDBGrid
            Left = 1
            Top = 95
            Width = 903
            Height = 128
            Align = alClient
            DataSource = FDataModule.DSNFeItens
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'Tahoma'
            TitleFont.Style = []
          end
          object Panel3: TPanel
            Left = 1
            Top = 1
            Width = 903
            Height = 94
            Align = alTop
            TabOrder = 1
            object Label2: TLabel
              Left = 9
              Top = 47
              Width = 56
              Height = 13
              Alignment = taRightJustify
              Caption = 'Quantidade'
            end
            object Label3: TLabel
              Left = 103
              Top = 47
              Width = 49
              Height = 13
              Caption = 'Valor Item'
            end
            object Label4: TLabel
              Left = 287
              Top = 47
              Width = 60
              Height = 13
              Caption = 'Total Item'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label24: TLabel
              Left = 377
              Top = 47
              Width = 36
              Height = 13
              Caption = 'IPI (%)'
            end
            object Label18: TLabel
              Left = 469
              Top = 47
              Width = 41
              Height = 13
              Caption = 'Valor IPI'
            end
            object Label22: TLabel
              Left = 563
              Top = 47
              Width = 63
              Height = 13
              Caption = 'BC  ICMS ST'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object Label23: TLabel
              Left = 654
              Top = 47
              Width = 73
              Height = 13
              Caption = 'Aliquota ST(%)'
            end
            object Label41: TLabel
              Left = 745
              Top = 47
              Width = 67
              Height = 13
              Caption = 'Valor ICMS ST'
            end
            object Label28: TLabel
              Left = 193
              Top = 47
              Width = 72
              Height = 13
              Caption = 'Valor Desconto'
            end
            object Label25: TLabel
              Left = 9
              Top = 4
              Width = 81
              Height = 13
              Alignment = taRightJustify
              Caption = 'ID (F1 - Pequisa)'
            end
            object Label33: TLabel
              Left = 832
              Top = 4
              Width = 27
              Height = 13
              Alignment = taRightJustify
              Caption = 'CFOP'
            end
            object editItemNCM: TLabeledEdit
              Left = 720
              Top = 20
              Width = 106
              Height = 21
              EditLabel.Width = 22
              EditLabel.Height = 13
              EditLabel.Caption = 'NCM'
              TabOrder = 4
            end
            object editItemDescricao: TLabeledEdit
              Left = 216
              Top = 20
              Width = 431
              Height = 21
              TabStop = False
              Color = clInfoBk
              EditLabel.Width = 46
              EditLabel.Height = 13
              EditLabel.Caption = 'Descri'#231#227'o'
              TabOrder = 2
            end
            object editItemQuantidade: TJvValidateEdit
              Left = 9
              Top = 63
              Width = 86
              Height = 21
              CriticalPoints.MaxValueIncluded = False
              CriticalPoints.MinValueIncluded = False
              DisplayFormat = dfFloat
              DecimalPlaces = 2
              EditText = ',00'
              TabOrder = 6
              OnExit = editItemQuantidadeExit
            end
            object editItemValorItem: TJvValidateEdit
              Left = 101
              Top = 63
              Width = 86
              Height = 21
              CriticalPoints.MaxValueIncluded = False
              CriticalPoints.MinValueIncluded = False
              DisplayFormat = dfFloat
              DecimalPlaces = 2
              EditText = ',00'
              TabOrder = 7
              OnExit = editItemQuantidadeExit
            end
            object editItemTotalItem: TJvValidateEdit
              Left = 285
              Top = 63
              Width = 86
              Height = 21
              CriticalPoints.MaxValueIncluded = False
              CriticalPoints.MinValueIncluded = False
              DisplayFormat = dfFloat
              DecimalPlaces = 2
              EditText = ',00'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 9
              OnExit = editItemQuantidadeExit
            end
            object editItemCodBarras: TLabeledEdit
              Left = 101
              Top = 20
              Width = 109
              Height = 21
              EditLabel.Width = 82
              EditLabel.Height = 13
              EditLabel.Caption = 'Codigo de Barras'
              TabOrder = 1
            end
            object editItemDesconto: TJvValidateEdit
              Left = 193
              Top = 63
              Width = 86
              Height = 21
              CriticalPoints.MaxValueIncluded = False
              CriticalPoints.MinValueIncluded = False
              DisplayFormat = dfFloat
              DecimalPlaces = 2
              EditText = ',00'
              TabOrder = 8
              OnExit = editItemQuantidadeExit
            end
            object editItemAliqIPI: TJvValidateEdit
              Left = 377
              Top = 63
              Width = 86
              Height = 21
              CriticalPoints.MaxValueIncluded = False
              CriticalPoints.MinValueIncluded = False
              DisplayFormat = dfFloat
              DecimalPlaces = 2
              EditText = ',00'
              TabOrder = 10
              OnExit = editItemAliqIPIExit
            end
            object editItemValorIPI: TJvValidateEdit
              Left = 469
              Top = 63
              Width = 86
              Height = 21
              CriticalPoints.MaxValueIncluded = False
              CriticalPoints.MinValueIncluded = False
              DisplayFormat = dfFloat
              DecimalPlaces = 2
              EditText = ',00'
              TabOrder = 11
            end
            object editItemBCIcmsST: TJvValidateEdit
              Left = 561
              Top = 63
              Width = 86
              Height = 21
              CriticalPoints.MaxValueIncluded = False
              CriticalPoints.MinValueIncluded = False
              DisplayFormat = dfFloat
              DecimalPlaces = 2
              EditText = ',00'
              TabOrder = 12
              OnExit = editItemQuantidadeExit
            end
            object editItemAliqICMSST: TJvValidateEdit
              Left = 653
              Top = 63
              Width = 86
              Height = 21
              CriticalPoints.MaxValueIncluded = False
              CriticalPoints.MinValueIncluded = False
              DisplayFormat = dfFloat
              DecimalPlaces = 2
              EditText = ',00'
              TabOrder = 13
              OnExit = editItemQuantidadeExit
            end
            object editItemICMSST: TJvValidateEdit
              Left = 745
              Top = 63
              Width = 86
              Height = 21
              CriticalPoints.MaxValueIncluded = False
              CriticalPoints.MinValueIncluded = False
              DisplayFormat = dfFloat
              DecimalPlaces = 2
              EditText = ',00'
              TabOrder = 14
              OnExit = editItemQuantidadeExit
            end
            object btInsereItem: TButton
              Left = 837
              Top = 61
              Width = 67
              Height = 27
              Caption = 'Insere Item'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 15
              OnClick = btInsereItemClick
            end
            object editItemIDProduto: TJvValidateEdit
              Left = 9
              Top = 20
              Width = 86
              Height = 21
              CriticalPoints.MaxValueIncluded = False
              CriticalPoints.MinValueIncluded = False
              DisplayFormat = dfFloat
              EditText = '0'
              TabOrder = 0
              ZeroEmpty = True
              OnExit = editItemIDProdutoExit
              OnKeyDown = editItemIDProdutoKeyDown
            end
            object editItemUnidade: TLabeledEdit
              Left = 653
              Top = 20
              Width = 61
              Height = 21
              EditLabel.Width = 39
              EditLabel.Height = 13
              EditLabel.Caption = 'Unidade'
              TabOrder = 3
            end
            object editItemCFOP: TJvValidateEdit
              Left = 832
              Top = 20
              Width = 64
              Height = 21
              CriticalPoints.MaxValueIncluded = False
              CriticalPoints.MinValueIncluded = False
              DisplayFormat = dfFloat
              EditText = '0'
              TabOrder = 5
              ZeroEmpty = True
            end
          end
        end
      end
      object TabSheet3: TTabSheet
        Caption = 'Transporte'
        ImageIndex = 2
      end
      object TabSheet4: TTabSheet
        Caption = 'Cobran'#231'a'
        ImageIndex = 3
      end
      object TabSheet5: TTabSheet
        Caption = 'Informa'#231#245'es Adicionais'
        ImageIndex = 4
        ExplicitLeft = 5
        ExplicitTop = 26
        ExplicitWidth = 0
        ExplicitHeight = 0
        object memoInfComplementar: TMemo
          Left = 0
          Top = 0
          Width = 905
          Height = 121
          Align = alTop
          Lines.Strings = (
            '')
          TabOrder = 0
        end
      end
    end
    object Panel5: TPanel
      Left = 4
      Top = 288
      Width = 913
      Height = 85
      Align = alBottom
      BevelInner = bvLowered
      BevelOuter = bvNone
      ParentBackground = False
      TabOrder = 2
      object Label9: TLabel
        Left = 4
        Top = 4
        Width = 118
        Height = 13
        Caption = 'Base de C'#225'lculo do ICMS'
      end
      object Label10: TLabel
        Left = 151
        Top = 4
        Width = 67
        Height = 13
        Caption = 'Valor do ICMS'
      end
      object Label11: TLabel
        Left = 298
        Top = 4
        Width = 122
        Height = 13
        Caption = 'Base C'#225'lculo ICMS Subst.'
      end
      object Label12: TLabel
        Left = 746
        Top = 4
        Width = 77
        Height = 13
        Caption = 'Total Produto'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label13: TLabel
        Left = 746
        Top = 41
        Width = 58
        Height = 13
        Caption = 'Total Nota'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label15: TLabel
        Left = 446
        Top = 4
        Width = 101
        Height = 13
        Caption = 'Valor do ICMS Subst.'
      end
      object Label16: TLabel
        Left = 4
        Top = 44
        Width = 68
        Height = 13
        Caption = 'Valor do Frete'
      end
      object Label17: TLabel
        Left = 151
        Top = 44
        Width = 76
        Height = 13
        Caption = 'Valor do Seguro'
      end
      object Label19: TLabel
        Left = 298
        Top = 44
        Width = 116
        Height = 13
        Caption = 'Outras desp. acessorias'
      end
      object Label20: TLabel
        Left = 444
        Top = 44
        Width = 68
        Height = 13
        Caption = 'Valor Total IPI'
      end
      object Label21: TLabel
        Left = 618
        Top = 44
        Width = 45
        Height = 13
        Caption = 'Desconto'
      end
      object editBC: TJvValidateEdit
        Left = 4
        Top = 20
        Width = 141
        Height = 21
        CriticalPoints.MaxValueIncluded = False
        CriticalPoints.MinValueIncluded = False
        DisplayFormat = dfFloat
        DecimalPlaces = 2
        EditText = ',00'
        TabOrder = 0
      end
      object editICMS: TJvValidateEdit
        Left = 151
        Top = 20
        Width = 141
        Height = 21
        CriticalPoints.MaxValueIncluded = False
        CriticalPoints.MinValueIncluded = False
        DisplayFormat = dfFloat
        DecimalPlaces = 2
        EditText = ',00'
        TabOrder = 1
      end
      object editBCSubst: TJvValidateEdit
        Left = 298
        Top = 20
        Width = 141
        Height = 21
        CriticalPoints.MaxValueIncluded = False
        CriticalPoints.MinValueIncluded = False
        DisplayFormat = dfFloat
        DecimalPlaces = 2
        EditText = ',00'
        TabOrder = 2
      end
      object editOutrasDespesas: TJvValidateEdit
        Left = 298
        Top = 60
        Width = 141
        Height = 21
        CriticalPoints.MaxValueIncluded = False
        CriticalPoints.MinValueIncluded = False
        DisplayFormat = dfFloat
        DecimalPlaces = 2
        EditText = ',00'
        TabOrder = 3
      end
      object editDesconto: TJvValidateEdit
        Left = 618
        Top = 60
        Width = 97
        Height = 21
        CriticalPoints.MaxValueIncluded = False
        CriticalPoints.MinValueIncluded = False
        DisplayFormat = dfFloat
        DecimalPlaces = 2
        EditText = ',00'
        TabOrder = 4
      end
      object editICMSSubst: TJvValidateEdit
        Left = 446
        Top = 20
        Width = 166
        Height = 21
        CriticalPoints.MaxValueIncluded = False
        CriticalPoints.MinValueIncluded = False
        DisplayFormat = dfFloat
        DecimalPlaces = 2
        EditText = ',00'
        TabOrder = 5
      end
      object editTotalProduto: TJvValidateEdit
        Left = 746
        Top = 17
        Width = 122
        Height = 21
        CriticalPoints.MaxValueIncluded = False
        CriticalPoints.MinValueIncluded = False
        DisplayFormat = dfFloat
        DecimalPlaces = 2
        EditText = ',00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 6
      end
      object editTotalNota: TJvValidateEdit
        Left = 746
        Top = 57
        Width = 122
        Height = 21
        CriticalPoints.MaxValueIncluded = False
        CriticalPoints.MinValueIncluded = False
        DisplayFormat = dfFloat
        DecimalPlaces = 2
        EditText = ',00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 7
      end
      object editFrete: TJvValidateEdit
        Left = 4
        Top = 60
        Width = 141
        Height = 21
        CriticalPoints.MaxValueIncluded = False
        CriticalPoints.MinValueIncluded = False
        DisplayFormat = dfFloat
        DecimalPlaces = 2
        EditText = ',00'
        TabOrder = 8
      end
      object editSeguro: TJvValidateEdit
        Left = 151
        Top = 60
        Width = 141
        Height = 21
        CriticalPoints.MaxValueIncluded = False
        CriticalPoints.MinValueIncluded = False
        DisplayFormat = dfFloat
        DecimalPlaces = 2
        EditText = ',00'
        TabOrder = 9
      end
      object editTotalIPI: TJvValidateEdit
        Left = 445
        Top = 60
        Width = 167
        Height = 21
        CriticalPoints.MaxValueIncluded = False
        CriticalPoints.MinValueIncluded = False
        DisplayFormat = dfFloat
        DecimalPlaces = 2
        EditText = ',00'
        TabOrder = 10
      end
    end
  end
  object PanelToolBar: TPanel
    Left = 0
    Top = 0
    Width = 921
    Height = 35
    Align = alTop
    Color = 14537936
    ParentBackground = False
    TabOrder = 0
    object ActionToolBarGrid: TActionToolBar
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 913
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
  object Panel4: TPanel
    Left = 0
    Top = 35
    Width = 921
    Height = 41
    Align = alTop
    BevelInner = bvLowered
    TabOrder = 3
    DesignSize = (
      921
      41)
    object btResumoInfo: TSpeedButton
      Left = 855
      Top = 14
      Width = 23
      Height = 22
      Anchors = [akTop, akRight]
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FF7A2D067A2D067A2D067A2D06FF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF7A2D06E9AD68
        E2751F7A2D06FF00FF0000000000000000000000000000000000000000000000
        00000000000000FF00FF7A2D0642C555F4CFA47A2D06FF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF7A2D067A2D06
        7A2D067A2D06FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF7A2D067A2D06
        7A2D067A2D06FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FF7A2D06E9AD68E2751F7A2D06FF00FF00000000000000
        0000000000000000000000000000000000000000000000FF00FF7A2D0642C555
        F4CFA47A2D06FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FF7A2D067A2D067A2D067A2D06FF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FF7A2D067A2D067A2D067A2D06FF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF7A2D06E9AD68
        E2751F7A2D06FF00FF0000000000000000000000000000000000000000000000
        00000000000000FF00FF7A2D0642C555F4CFA47A2D06FF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF7A2D067A2D06
        7A2D067A2D06FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      OnClick = btResumoInfoClick
      ExplicitLeft = 832
    end
    object Label34: TLabel
      Left = 197
      Top = 2
      Width = 83
      Height = 13
      Caption = 'Chave de Acesso'
    end
    object Label35: TLabel
      Left = 577
      Top = 2
      Width = 33
      Height = 13
      Anchors = [akTop, akRight]
      Caption = 'Vers'#227'o'
    end
    object Label14: TLabel
      Left = 491
      Top = 2
      Width = 37
      Height = 13
      Anchors = [akTop, akRight]
      Caption = 'N'#250'mero'
    end
    object editStatus: TLabeledEdit
      Left = 7
      Top = 16
      Width = 183
      Height = 22
      AutoSize = False
      EditLabel.Width = 31
      EditLabel.Height = 13
      EditLabel.Caption = 'Status'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object editProtocolo: TLabeledEdit
      Left = 641
      Top = 15
      Width = 205
      Height = 22
      Anchors = [akTop, akRight]
      AutoSize = False
      EditLabel.Width = 45
      EditLabel.Height = 13
      EditLabel.Caption = 'Protocolo'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
    end
    object editChaveAcesso: TDBEdit
      Left = 196
      Top = 16
      Width = 289
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      DataField = 'CHAVE_ACESSO'
      DataSource = FDataModule.DSNFe
      TabOrder = 2
    end
    object editVersao: TDBEdit
      Left = 576
      Top = 16
      Width = 59
      Height = 21
      Anchors = [akTop, akRight]
      DataField = 'VERSAO_PROCESSO_EMISSAO'
      DataSource = FDataModule.DSNFe
      TabOrder = 3
    end
    object editNumero: TDBEdit
      Left = 491
      Top = 15
      Width = 79
      Height = 21
      Anchors = [akTop, akRight]
      DataField = 'NUMERO'
      DataSource = FDataModule.DSNFe
      TabOrder = 4
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
            Action = Action1
          end
          item
            Action = ActionCancelarNFe
            Caption = 'Ca&ncelar NF-e'
          end
          item
            Action = ActionConsultaSEFAZ
            Caption = 'C&onsultar NF-e SEFAZ'
          end
          item
            Action = ActionImprimirDANFE
            Caption = 'I&mprimir DANFE'
          end
          item
            Action = ActionEnviar
            Caption = '&Enviar'
          end
          item
            Action = ActionAssinar
            Caption = '&Assinar'
          end
          item
            Action = ActionValidar
            Caption = '&Validar'
          end>
        ActionBar = ActionToolBarEdits
      end>
    DisabledImages = FDataModule.ImagensCadastrosD
    Images = FDataModule.ImagensCadastros
    Left = 507
    Top = 152
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
    object ActionValidar: TAction
      Category = 'NFe'
      Caption = 'Validar'
      OnExecute = ActionValidarExecute
    end
    object ActionAssinar: TAction
      Category = 'NFe'
      Caption = 'Assinar'
      OnExecute = ActionAssinarExecute
    end
    object ActionEnviar: TAction
      Category = 'NFe'
      Caption = 'Enviar'
      OnExecute = ActionEnviarExecute
    end
    object ActionCancelarNFe: TAction
      Category = 'NFe'
      Caption = 'Cancelar NF-e'
      OnExecute = ActionCancelarNFeExecute
    end
    object ActionImprimirDANFE: TAction
      Category = 'NFe'
      Caption = 'Imprimir DANFE'
      OnExecute = ActionImprimirDANFEExecute
    end
    object ActionConsultaSEFAZ: TAction
      Category = 'NFe'
      Caption = 'Consultar NF-e SEFAZ'
      OnExecute = ActionConsultaSEFAZExecute
    end
    object ActionVisualizaDetalhes: TAction
      Category = 'NFe'
      Caption = 'Resumo NF-e'
    end
    object Action1: TAction
      Caption = '|'
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
      end
      item
        Action = ActionVisualizaDetalhes
        Description.Strings = (
          'Resumo de informa'#231#245'es NF-e')
        Header = 'ActionVisualizaDetalhes'
      end
      item
        Action = ActionConsultaSEFAZ
        Header = 'Consultar NF-e SEFAZ'
      end
      item
        Action = ActionImprimirDANFE
        Header = 'Imprimir DANFE'
      end
      item
        Action = ActionCancelarNFe
        Header = 'Cancelar NF-e'
      end
      item
        Action = ActionEnviar
        Header = 'Enviar'
      end
      item
        Action = ActionAssinar
        Header = 'Assinar'
      end
      item
        Action = ActionValidar
        Header = 'Importar'
      end>
    Left = 471
    Top = 155
  end
end
