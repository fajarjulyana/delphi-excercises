unit dbmsrc;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, System.IOUtils,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.FMXUI.Wait, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TDBModule = class(TDataModule)
    dblibrary: TFDConnection;
    QTemp: TFDQuery;
    procedure dblibraryBeforeConnect(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DBModule: TDBModule;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

procedure TDBModule.dblibraryBeforeConnect(Sender: TObject);
begin
  {$IF DEFINED (ANDROID)}
  dblibrary.Params.Values['Database'] := TPath.GetDocumentsPath + PathDelim + 'myshop.db3';
  {$ELSEIF DEFINED (MSWINDOWS)}
  {$ENDIF}
end;

end.
