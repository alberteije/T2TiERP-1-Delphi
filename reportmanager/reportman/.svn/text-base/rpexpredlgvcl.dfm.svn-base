object FRpExpredialogVCL: TFRpExpredialogVCL
  Left = 320
  Top = 101
  Width = 533
  Height = 491
  Caption = 'Dialog'
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  Position = poScreenCenter
  ShowHint = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object PBottom: TPanel
    Left = 0
    Top = 172
    Width = 525
    Height = 285
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object LabelCategory: TLabel
      Left = 4
      Top = 4
      Width = 42
      Height = 13
      Caption = 'Category'
    end
    object LOperation: TLabel
      Left = 120
      Top = 4
      Width = 46
      Height = 13
      Caption = 'Operation'
    end
    object LModel: TLabel
      Left = 4
      Top = 140
      Width = 493
      Height = 49
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Caption = 'LModel'
      WordWrap = True
    end
    object LHelp: TLabel
      Left = 4
      Top = 116
      Width = 22
      Height = 13
      Caption = 'Help'
    end
    object LParams: TLabel
      Left = 4
      Top = 196
      Width = 497
      Height = 49
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Caption = 'Params'
      WordWrap = True
    end
    object LItems: TListBox
      Left = 120
      Top = 20
      Width = 381
      Height = 89
      Anchors = [akLeft, akTop, akRight]
      ItemHeight = 13
      TabOrder = 0
      OnClick = LItemsClick
      OnDblClick = LItemsDblClick
    end
    object BCancel: TButton
      Left = 100
      Top = 252
      Width = 85
      Height = 25
      Caption = '&Cancel'
      ModalResult = 2
      TabOrder = 1
    end
    object BOK: TButton
      Left = 4
      Top = 252
      Width = 85
      Height = 25
      Caption = '&OK'
      Default = True
      TabOrder = 2
      OnClick = BOKClick
    end
    object LCategory: TListBox
      Left = 4
      Top = 20
      Width = 109
      Height = 89
      ItemHeight = 13
      Items.Strings = (
        'Database fields'
        'Functions'
        'Variables'
        'Constants'
        'Operators')
      TabOrder = 3
      OnClick = LCategoryClick
    end
  end
  object PAlClient: TPanel
    Left = 0
    Top = 0
    Width = 525
    Height = 172
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object MemoExpre: TMemo
      Left = 0
      Top = 0
      Width = 525
      Height = 139
      Align = alClient
      Lines.Strings = (
        'MemoExpre')
      ScrollBars = ssBoth
      TabOrder = 0
      WordWrap = False
    end
    object Panel1: TPanel
      Left = 0
      Top = 139
      Width = 525
      Height = 33
      Align = alBottom
      TabOrder = 1
      object BShowResult: TButton
        Left = 312
        Top = 4
        Width = 149
        Height = 25
        Hint = 'Evaluates the expresion and shows the result'
        Caption = 'Show Result'
        TabOrder = 0
        OnClick = BShowResultClick
      end
      object BCheckSyn: TButton
        Left = 148
        Top = 4
        Width = 145
        Height = 25
        Hint = 'Syntax check the expresion'
        Caption = 'Syntax check'
        TabOrder = 1
        OnClick = BCheckSynClick
      end
      object BAdd: TButton
        Left = 4
        Top = 4
        Width = 129
        Height = 25
        Caption = 'Add selection'
        TabOrder = 2
        OnClick = BitBtn1Click
      end
    end
  end
end
