object dm: Tdm
  OldCreateOrder = False
  Height = 332
  Width = 308
  object dbShopping: TFDConnection
    Params.Strings = (
      'DriverID=SQLite'
      
        'Database=D:\PROJECT\DELPHI_104\yttutorial\myshopApp\assets\datab' +
        'ase\myshopdb.db3')
    LoginPrompt = False
    BeforeConnect = dbShoppingBeforeConnect
    Left = 80
    Top = 64
  end
  object QTemp: TFDQuery
    Connection = dbShopping
    SQL.Strings = (
      'Select * from users')
    Left = 80
    Top = 120
  end
  object SQLConnection1: TSQLConnection
    DriverName = 'MySQL'
    LoginPrompt = False
    Params.Strings = (
      'DriverUnit=Data.DBXMySql'
      
        'DriverPackageLoader=TDBXDynalinkDriverLoader,DBXMySQLDriver200.b' +
        'pl'
      
        'DriverAssemblyLoader=Borland.Data.TDBXDynalinkDriverLoader,Borla' +
        'nd.Data.DbxCommonDriver,Version=20.0.0.0,Culture=neutral,PublicK' +
        'eyToken=91d62ebb5b0d1b1b'
      
        'MetaDataPackageLoader=TDBXMySqlMetaDataCommandFactory,DbxMySQLDr' +
        'iver200.bpl'
      
        'MetaDataAssemblyLoader=Borland.Data.TDBXMySqlMetaDataCommandFact' +
        'ory,Borland.Data.DbxMySQLDriver,Version=20.0.0.0,Culture=neutral' +
        ',PublicKeyToken=91d62ebb5b0d1b1b'
      'GetDriverFunc=getSQLDriverMYSQL'
      'LibraryName=dbxmys.dll'
      'LibraryNameOsx=libsqlmys.dylib'
      'VendorLib=libmysql.dll'
      'VendorLibWin64=libmysql.dll'
      'VendorLibOsx=libmysqlclient.dylib'
      'HostName=sql6.freemysqlhosting.net'
      'Database=sql6590728'
      'User_Name=sql6590728'
      'Password=Stp6g41Bgl'
      'MaxBlobSize=-1'
      'LocaleCode=0000'
      'Compressed=False'
      'Encrypted=False')
    Left = 184
    Top = 64
  end
end
