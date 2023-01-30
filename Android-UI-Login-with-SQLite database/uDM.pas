unit uDM;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, System.IOUtils,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.FMXUI.Wait, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Data.DBXMySql, Data.SqlExpr;

type
  Tdm = class(TDataModule)
    dbShopping: TFDConnection;
    QTemp: TFDQuery;
    SQLConnection1: TSQLConnection;
    procedure dbShoppingBeforeConnect(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dm: Tdm;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

procedure Tdm.dbShoppingBeforeConnect(Sender: TObject);
begin
  // set the database file for each devices
  {$IF DEFINED (ANDROID)}
    dbshopping.Params.Values['Database'] := TPath.GetDocumentsPath + PathDelim + 'myshopdb.db3';
  {$ELSEIF DEFINED (MSWINDOWS)}
  {$ENDIF}

end;

end.
