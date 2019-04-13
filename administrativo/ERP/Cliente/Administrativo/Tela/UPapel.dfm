inherited FPapel: TFPapel
  Tag = 1
  Left = 303
  Top = 180
  Caption = 'Papel - Controle de Acessos'
  ExplicitLeft = 303
  ExplicitTop = 180
  ExplicitWidth = 1000
  ExplicitHeight = 500
  PixelsPerInch = 96
  TextHeight = 13
  inherited PageControl: TPageControl
    ActivePage = PaginaEdits
    inherited PaginaEdits: TTabSheet
      inherited PanelEdits: TPanel
        object BevelEdits: TBevel
          Left = 11
          Top = 12
          Width = 966
          Height = 341
          Anchors = [akLeft, akTop, akRight, akBottom]
          Constraints.MinWidth = 753
        end
        object Label1: TLabel
          Left = 24
          Top = 64
          Width = 50
          Height = 13
          Caption = 'Descri'#231#227'o:'
        end
        object Label2: TLabel
          Left = 23
          Top = 145
          Width = 57
          Height = 13
          Caption = 'Permiss'#245'es:'
        end
        object EditNome: TLabeledEdit
          Left = 20
          Top = 37
          Width = 837
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          EditLabel.Width = 31
          EditLabel.Height = 13
          EditLabel.Caption = 'Nome:'
          TabOrder = 0
        end
        object MemoDescricao: TMemo
          Left = 20
          Top = 80
          Width = 949
          Height = 57
          Anchors = [akLeft, akTop, akRight]
          ScrollBars = ssVertical
          TabOrder = 2
        end
        object TreeView: TTreeView
          Left = 20
          Top = 161
          Width = 949
          Height = 184
          Anchors = [akLeft, akTop, akRight, akBottom]
          Images = FDataModule.ImagensCadastros
          Indent = 19
          TabOrder = 3
          OnDblClick = TreeViewDblClick
        end
        object ComboBoxAcessoCompleto: TLabeledComboBox
          Left = 863
          Top = 37
          Width = 106
          Height = 21
          Style = csDropDownList
          Anchors = [akTop, akRight]
          ItemIndex = 1
          TabOrder = 1
          Text = 'N'#227'o'
          Items.Strings = (
            'Sim'
            'N'#227'o')
          ComboBoxLabel.Width = 86
          ComboBoxLabel.Height = 13
          ComboBoxLabel.Caption = 'Acesso Completo:'
        end
      end
    end
  end
end
