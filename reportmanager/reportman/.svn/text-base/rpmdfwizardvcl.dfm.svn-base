object FRpWizardVCL: TFRpWizardVCL
  Left = 193
  Top = 114
  AutoScroll = False
  Caption = 'New Report Wizard'
  ClientHeight = 495
  ClientWidth = 612
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PControl: TPageControl
    Left = 0
    Top = 0
    Width = 612
    Height = 458
    ActivePage = TabInstructions
    Align = alClient
    TabOrder = 0
    OnChange = PControlChange
    OnChanging = PControlChanging
    object TabInstructions: TTabSheet
      Caption = 'Instructions'
      object LDesign: TLabel
        Left = 4
        Top = 12
        Width = 282
        Height = 13
        Caption = 'To design a report with this wizard you must follow this steps'
      end
      object LPass1: TLabel
        Left = 4
        Top = 36
        Width = 347
        Height = 13
        Caption = 
          '1. Open database connections, follow the instuctions in Connecti' +
          'os page.'
      end
      object LPass2: TLabel
        Left = 4
        Top = 56
        Width = 267
        Height = 13
        Caption = '2. Open datasets, follow the instuctions at datasets page'
      end
      object LPass3: TLabel
        Left = 4
        Top = 76
        Width = 328
        Height = 13
        Caption = 
          '3. Select dataset fields to print, follow instructions at select' +
          ' fields page'
      end
      object LBegin: TLabel
        Left = 4
        Top = 120
        Width = 176
        Height = 13
        Caption = 'To begin the wizard click Next button'
      end
      object BPageSetup: TButton
        Left = 8
        Top = 140
        Width = 93
        Height = 33
        Caption = 'Configure page'
        TabOrder = 0
        OnClick = BPageSetupClick
      end
    end
    object TabConnections: TTabSheet
      Caption = 'Connections'
      ImageIndex = 1
    end
    object TabDatasets: TTabSheet
      Caption = 'Datasets'
      ImageIndex = 2
    end
    object TabFields: TTabSheet
      Caption = 'Fields'
      ImageIndex = 3
    end
  end
  object PBottom3: TPanel
    Left = 0
    Top = 458
    Width = 612
    Height = 37
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object BCancel: TButton
      Left = 4
      Top = 4
      Width = 97
      Height = 29
      Anchors = [akRight, akBottom]
      Caption = 'Cancel'
      TabOrder = 0
      OnClick = BCancelClick
    end
    object BNext: TButton
      Left = 404
      Top = 4
      Width = 97
      Height = 29
      Anchors = [akRight, akBottom]
      Caption = 'Next'
      TabOrder = 1
      OnClick = BNext1Click
    end
    object BFinish: TButton
      Left = 508
      Top = 4
      Width = 97
      Height = 29
      Anchors = [akRight, akBottom]
      Caption = 'Finish'
      TabOrder = 2
      OnClick = BFinishClick
    end
    object BBack: TButton
      Left = 300
      Top = 4
      Width = 97
      Height = 29
      Anchors = [akRight, akBottom]
      Caption = 'Back'
      TabOrder = 3
      OnClick = BBackClick
    end
  end
end
