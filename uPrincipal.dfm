object Form33: TForm33
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Conex'#227'o FTP'
  ClientHeight = 381
  ClientWidth = 394
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 8
    Top = 8
    Width = 378
    Height = 113
  end
  object Shape_Conectado: TShape
    Left = 8
    Top = 41
    Width = 89
    Height = 41
    Brush.Color = clRed
    Pen.Color = clRed
    Shape = stCircle
  end
  object Label1: TLabel
    Left = 120
    Top = 12
    Width = 22
    Height = 13
    Caption = 'Host'
  end
  object Label2: TLabel
    Left = 120
    Top = 72
    Width = 36
    Height = 13
    Caption = 'Usu'#225'rio'
  end
  object Label3: TLabel
    Left = 264
    Top = 72
    Width = 30
    Height = 13
    Caption = 'Senha'
  end
  object Btn_Conectar: TButton
    Left = 203
    Top = 312
    Width = 75
    Height = 33
    Caption = 'Conectar'
    TabOrder = 0
    OnClick = Btn_ConectarClick
  end
  object Memo_Relatorio_FTP: TMemo
    Left = 16
    Top = 152
    Width = 353
    Height = 138
    ReadOnly = True
    TabOrder = 1
  end
  object Btn_Desconectar: TButton
    Left = 112
    Top = 312
    Width = 75
    Height = 33
    Caption = 'Desconectar'
    Enabled = False
    TabOrder = 2
    OnClick = Btn_DesconectarClick
  end
  object btn_Upload: TButton
    Left = 22
    Top = 312
    Width = 75
    Height = 33
    Caption = 'Upload'
    Enabled = False
    TabOrder = 3
    OnClick = btn_UploadClick
  end
  object Edit_Host: TEdit
    Left = 114
    Top = 27
    Width = 255
    Height = 21
    TabOrder = 4
  end
  object Edit_Name: TEdit
    Left = 112
    Top = 88
    Width = 146
    Height = 21
    TabOrder = 5
  end
  object Edit_Senha: TEdit
    Left = 264
    Top = 88
    Width = 105
    Height = 21
    PasswordChar = '*'
    TabOrder = 6
  end
  object btnSair: TButton
    Left = 294
    Top = 312
    Width = 75
    Height = 33
    Caption = 'Sair'
    TabOrder = 7
    OnClick = btnSairClick
  end
  object IdFTP1: TIdFTP
    Host = 'ftp.journalnews.com.br'
    ConnectTimeout = 0
    Password = 'japa0101'
    Username = 'mar@mar.japasoft.com.br'
    NATKeepAlive.UseKeepAlive = False
    NATKeepAlive.IdleTimeMS = 0
    NATKeepAlive.IntervalMS = 0
    ProxySettings.ProxyType = fpcmNone
    ProxySettings.Port = 0
    Left = 200
    Top = 200
  end
  object OpenDialog1: TOpenDialog
    Left = 96
    Top = 208
  end
end
