inherited FUsuario: TFUsuario
  Tag = 1
  Left = 325
  Top = 210
  Caption = 'Usu'#225'rio'
  ExplicitLeft = 325
  ExplicitTop = 210
  PixelsPerInch = 96
  TextHeight = 13
  inherited PageControl: TPageControl
    ActivePage = PaginaEdits
    inherited PaginaEdits: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 24
      ExplicitWidth = 991
      ExplicitHeight = 395
      inherited PanelEdits: TPanel
        object Label1: TLabel
          Left = 20
          Top = 21
          Width = 59
          Height = 13
          Caption = 'Colaborador'
        end
        object BevelEdits: TBevel
          Left = 10
          Top = 12
          Width = 967
          Height = 151
          Anchors = [akLeft, akTop, akRight]
          Constraints.MinWidth = 753
        end
        object Label2: TLabel
          Left = 20
          Top = 63
          Width = 26
          Height = 13
          Caption = 'Papel'
        end
        object ComboBoxColaborador: TDBLookupComboBox
          Left = 20
          Top = 36
          Width = 944
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          ListSource = dsColaborador
          TabOrder = 0
        end
        object ComboBoxPapel: TDBLookupComboBox
          Left = 20
          Top = 78
          Width = 944
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          ListSource = dsPapel
          TabOrder = 1
        end
        object EditSenha: TLabeledEdit
          Left = 268
          Top = 118
          Width = 235
          Height = 21
          EditLabel.Width = 30
          EditLabel.Height = 13
          EditLabel.Caption = 'Senha'
          MaxLength = 20
          PasswordChar = '*'
          TabOrder = 3
        end
        object EditLogin: TLabeledEdit
          Left = 20
          Top = 118
          Width = 235
          Height = 21
          EditLabel.Width = 25
          EditLabel.Height = 13
          EditLabel.Caption = 'Login'
          MaxLength = 20
          TabOrder = 2
        end
      end
    end
  end
  object cdsColaborador: TClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 496
    Top = 32
  end
  object dsColaborador: TDataSource
    AutoEdit = False
    DataSet = cdsColaborador
    Left = 528
    Top = 32
  end
  object cdsPapel: TClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 568
    Top = 32
  end
  object dsPapel: TDataSource
    AutoEdit = False
    DataSet = cdsPapel
    Left = 600
    Top = 32
  end
end
