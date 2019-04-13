inherited FParametrizacao: TFParametrizacao
  Left = 318
  Top = 139
  Caption = 'Parametriza'#231#227'o'
  ClientHeight = 525
  ExplicitLeft = 318
  ExplicitTop = 139
  ExplicitWidth = 1000
  ExplicitHeight = 559
  PixelsPerInch = 96
  TextHeight = 13
  inherited PageControl: TPageControl
    Height = 494
    ActivePage = PaginaEdits
    ExplicitWidth = 997
    ExplicitHeight = 475
    inherited PaginaGrid: TTabSheet
      ExplicitWidth = 989
      ExplicitHeight = 447
      inherited PanelGrid: TPanel
        Height = 466
        ExplicitWidth = 989
        ExplicitHeight = 447
        inherited Grid: TJvDBUltimGrid
          Height = 414
        end
        inherited PanelFiltroRapido: TPanel
          Top = 414
          ExplicitTop = 395
          ExplicitWidth = 989
          inherited BotaoConsultar: TSpeedButton
            Left = 852
            ExplicitLeft = 857
          end
          inherited EditCriterioRapido: TLabeledMaskEdit
            Width = 683
            ExplicitWidth = 688
          end
        end
      end
    end
    inherited PaginaEdits: TTabSheet
      ExplicitWidth = 989
      ExplicitHeight = 447
      inherited PanelEdits: TPanel
        Height = 466
        ExplicitWidth = 989
        ExplicitHeight = 447
        object ScrollBox: TScrollBox
          Left = 4
          Top = 4
          Width = 976
          Height = 458
          Align = alClient
          BevelInner = bvNone
          BevelOuter = bvNone
          BorderStyle = bsNone
          TabOrder = 0
          ExplicitWidth = 844
          ExplicitHeight = 481
          DesignSize = (
            976
            458)
          object BevelEdits: TBevel
            Left = 7
            Top = 11
            Width = 959
            Height = 54
            Anchors = [akLeft, akTop, akRight]
            Constraints.MinWidth = 753
          end
          object PageControlDadosParametrizacao: TPageControl
            Left = 7
            Top = 80
            Width = 959
            Height = 369
            ActivePage = tsCompras
            Anchors = [akLeft, akTop, akRight, akBottom]
            TabOrder = 2
            object tsFinanceiro: TTabSheet
              Caption = 'Financeiro'
              ImageIndex = 2
              object PanelFinanceiro: TPanel
                Left = 0
                Top = 0
                Width = 951
                Height = 341
                Align = alClient
                BevelOuter = bvNone
                TabOrder = 0
                object EditIdFinParcelaAberto: TLabeledCalcEdit
                  Left = 5
                  Top = 28
                  Width = 200
                  Height = 21
                  ShowButton = False
                  TabOrder = 0
                  DecimalPlacesAlwaysShown = False
                  OnExit = EditIdFinParcelaAbertoExit
                  OnKeyDown = EditIdFinParcelaAbertoKeyDown
                  CalcEditLabel.Width = 149
                  CalcEditLabel.Height = 13
                  CalcEditLabel.Caption = 'Status Parcela em Aberto [F1]:'
                end
                object EditIdFinParcelaQuitado: TLabeledCalcEdit
                  Left = 211
                  Top = 28
                  Width = 200
                  Height = 21
                  ShowButton = False
                  TabOrder = 1
                  DecimalPlacesAlwaysShown = False
                  OnExit = EditIdFinParcelaQuitadoExit
                  OnKeyDown = EditIdFinParcelaQuitadoKeyDown
                  CalcEditLabel.Width = 137
                  CalcEditLabel.Height = 13
                  CalcEditLabel.Caption = 'Status Parcela Quitado [F1]:'
                end
                object EditIdFinParcelaQuitadoParcial: TLabeledCalcEdit
                  Left = 417
                  Top = 28
                  Width = 200
                  Height = 21
                  ShowButton = False
                  TabOrder = 2
                  DecimalPlacesAlwaysShown = False
                  OnExit = EditIdFinParcelaQuitadoParcialExit
                  OnKeyDown = EditIdFinParcelaQuitadoParcialKeyDown
                  CalcEditLabel.Width = 171
                  CalcEditLabel.Height = 13
                  CalcEditLabel.Caption = 'Status Parcela Quitado Parcial [F1]:'
                end
                object EditIdFinTipoRecebimentoEdi: TLabeledCalcEdit
                  Left = 623
                  Top = 28
                  Width = 200
                  Height = 21
                  ShowButton = False
                  TabOrder = 3
                  DecimalPlacesAlwaysShown = False
                  OnExit = EditIdFinTipoRecebimentoEdiExit
                  OnKeyDown = EditIdFinTipoRecebimentoEdiKeyDown
                  CalcEditLabel.Width = 132
                  CalcEditLabel.Height = 13
                  CalcEditLabel.Caption = 'Tipo Recebimento EDI [F1]:'
                end
              end
            end
            object tsCompras: TTabSheet
              Caption = 'Compras'
              object PanelCompras: TPanel
                Left = 0
                Top = 0
                Width = 951
                Height = 341
                Align = alClient
                BevelOuter = bvNone
                TabOrder = 0
                object EditIdCompraFinDocOrigem: TLabeledCalcEdit
                  Left = 5
                  Top = 28
                  Width = 400
                  Height = 21
                  ShowButton = False
                  TabOrder = 0
                  DecimalPlacesAlwaysShown = False
                  OnExit = EditIdCompraFinDocOrigemExit
                  OnKeyDown = EditIdCompraFinDocOrigemKeyDown
                  CalcEditLabel.Width = 317
                  CalcEditLabel.Height = 13
                  CalcEditLabel.Caption = 'Documento Origem Lan'#231'amento a Pagar (Pedido de Compra) [F1]:'
                end
                object EditIdCompraContaCaixa: TLabeledCalcEdit
                  Left = 411
                  Top = 28
                  Width = 400
                  Height = 21
                  ShowButton = False
                  TabOrder = 1
                  DecimalPlacesAlwaysShown = False
                  OnExit = EditIdCompraContaCaixaExit
                  OnKeyDown = EditIdCompraContaCaixaKeyDown
                  CalcEditLabel.Width = 285
                  CalcEditLabel.Height = 13
                  CalcEditLabel.Caption = 'Conta Caixa Lan'#231'amento a Pagar (Pedido de Compra) [F1]:'
                end
              end
            end
          end
          object EditIdEmpresa: TLabeledCalcEdit
            Left = 16
            Top = 33
            Width = 61
            Height = 21
            ShowButton = False
            TabOrder = 0
            DecimalPlacesAlwaysShown = False
            OnExit = EditIdEmpresaExit
            OnKeyDown = EditIdEmpresaKeyDown
            OnKeyPress = EditIdEmpresaKeyPress
            CalcEditLabel.Width = 68
            CalcEditLabel.Height = 13
            CalcEditLabel.Caption = 'Empresa [F1]:'
          end
          object EditEmpresa: TLabeledEdit
            Left = 77
            Top = 33
            Width = 878
            Height = 21
            TabStop = False
            Anchors = [akLeft, akTop, akRight]
            Color = clInfoBk
            EditLabel.Width = 6
            EditLabel.Height = 13
            EditLabel.Caption = '  '
            ReadOnly = True
            TabOrder = 1
          end
        end
      end
    end
  end
  inherited PanelToolBar: TPanel
    ExplicitWidth = 997
    inherited BotaoSair: TSpeedButton
      ExplicitLeft = 913
    end
    inherited BotaoExportar: TSpeedButton
      ExplicitLeft = 823
    end
    inherited BotaoImprimir: TSpeedButton
      Left = 678
      ExplicitLeft = 743
    end
    inherited BotaoSeparador1: TSpeedButton
      Left = 778
      ExplicitLeft = 903
    end
    inherited BotaoFiltrar: TSpeedButton
      Left = 578
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
end
