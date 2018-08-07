object Form3: TForm3
  Left = 0
  Top = 0
  Caption = 'Form3'
  ClientHeight = 775
  ClientWidth = 1088
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    1088
    775)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 312
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
    Top = 44
    Width = 1089
    Height = 41
    Anchors = [akLeft, akRight]
    BorderStyle = bsSingle
    TabOrder = 0
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
end
