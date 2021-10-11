object Form2: TForm2
  Left = 927
  Top = 272
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Info'
  ClientHeight = 616
  ClientWidth = 545
  Color = clBtnFace
  TransparentColorValue = clYellow
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 120
  TextHeight = 17
  object Label1: TLabel
    Left = 10
    Top = 10
    Width = 244
    Height = 21
    Caption = #1054#1082#1085#1086' '#1087#1088#1080#1085#1072#1076#1083#1077#1078#1080#1090' '#1092#1072#1081#1083#1091' :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -17
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 10
    Top = 114
    Width = 323
    Height = 21
    Caption = #1055#1086#1076#1082#1083#1102#1095#1077#1085#1085#1099#1077' '#1082' '#1087#1088#1086#1094#1077#1089#1089#1091' '#1084#1086#1076#1091#1083#1080' :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -17
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Memo1: TMemo
    Left = 10
    Top = 139
    Width = 525
    Height = 426
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 0
  end
  object Memo2: TMemo
    Left = 10
    Top = 35
    Width = 525
    Height = 71
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssHorizontal
    TabOrder = 1
  end
  object Button1: TButton
    Left = 437
    Top = 573
    Width = 98
    Height = 32
    Caption = #1042#1099#1093#1086#1076
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = Button1Click
  end
end
