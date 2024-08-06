object DBModule: TDBModule
  Height = 201
  Width = 389
  PixelsPerInch = 96
  object dblibrary: TFDConnection
    Params.Strings = (
      'DriverID=SQLite'
      
        'Database=C:\Users\Dena Gustiana\Downloads\delphi src\myshopApp\d' +
        'b\myshop.db3')
    LoginPrompt = False
    BeforeConnect = dblibraryBeforeConnect
    Left = 64
    Top = 48
  end
  object QTemp: TFDQuery
    Connection = dblibrary
    SQL.Strings = (
      'select * from users')
    Left = 64
    Top = 112
  end
end
