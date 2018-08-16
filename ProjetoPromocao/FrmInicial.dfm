object Form3: TForm3
  Left = 0
  Top = 0
  Caption = 'Form3'
  ClientHeight = 512
  ClientWidth = 612
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    612
    512)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 64
    Top = 8
    Width = 492
    Height = 33
    Caption = 'Sistema teste de vendas usando interface'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object pnlBotoes: TPanel
    Left = 0
    Top = 51
    Width = 613
    Height = 41
    Anchors = [akLeft, akTop, akRight]
    BorderStyle = bsSingle
    TabOrder = 0
    ExplicitWidth = 1089
    object btnCancelar: TButton
      Left = 190
      Top = 8
      Width = 99
      Height = 25
      Caption = 'Desistir da venda'
      TabOrder = 0
    end
    object btnNovaVenda: TButton
      Left = 16
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Nova Venda'
      TabOrder = 1
    end
    object btnFinalizaVenda: TButton
      Left = 97
      Top = 8
      Width = 87
      Height = 25
      Caption = 'Finalizar Venda'
      TabOrder = 2
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 92
    Width = 1077
    Height = 544
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 1
    ExplicitWidth = 1088
    ExplicitHeight = 692
    object GroupBox1: TGroupBox
      Left = 17
      Top = 16
      Width = 584
      Height = 385
      TabOrder = 0
      object Label2: TLabel
        Left = 16
        Top = 16
        Width = 74
        Height = 13
        Caption = 'Codigo Produto'
      end
      object Label3: TLabel
        Left = 143
        Top = 16
        Width = 56
        Height = 13
        Caption = 'Quantidade'
      end
      object Label4: TLabel
        Left = 16
        Top = 346
        Width = 147
        Height = 33
        Caption = 'Valor Total: '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -27
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object edtCodigoProduto: TEdit
        Left = 16
        Top = 32
        Width = 121
        Height = 21
        TabOrder = 0
      end
      object edtValor: TEdit
        Left = 143
        Top = 32
        Width = 121
        Height = 21
        TabOrder = 1
      end
      object btnAdicionarProduto: TButton
        Left = 360
        Top = 28
        Width = 98
        Height = 25
        Caption = 'Adicionar Produto'
        TabOrder = 2
      end
      object btnRemoverProduto: TButton
        Left = 464
        Top = 28
        Width = 97
        Height = 25
        Caption = 'Remover Produto'
        TabOrder = 3
      end
    end
  end
  object Memo1: TMemo
    Left = 33
    Top = 167
    Width = 545
    Height = 281
    Lines.Strings = (
      'Memo1')
    TabOrder = 2
  end
end
