unit sourceMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.Edit, FMX.Controls.Presentation,
  FMX.ScrollBox, FMX.Memo, FMX.StdCtrls, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdTCPServer, IdContext, IdGlobal, FMX.Memo.Types,
  IdCustomTCPServer,Winapi.Windows;


type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Memo1: TMemo;
    Button1: TButton;
    Label1: TLabel;
    IdTCPClient1: TIdTCPClient;
    IdTCPServer1: TIdTCPServer;
    Button2: TButton;
    Edit2: TEdit;
    Button3: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure IdTCPServer1Execute(AContext: TIdContext);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
   ComputerName: string;
implementation

{$R *.fmx}
  procedure TForm1.FormCreate(Sender: TObject);
var
  computerName: array[0..MAX_COMPUTERNAME_LENGTH + 1] of Char;
  size: DWORD;
begin
  size := MAX_COMPUTERNAME_LENGTH + 1;
  if GetComputerName(computerName, size) then
    Label1.Text :=  string(computerName)
  else
    Label1.Text := 'Tidak dapat ditemukan';
end;
  procedure TForm1.Button1Click(Sender: TObject);
begin
  if idTCPClient1.Connected then
  begin
    idTCPClient1.IOHandler.WriteLn(Label1.Text + ': ' + Edit1.Text, IndyTextEncoding_UTF8);
    Memo1.Lines.Add( Label1.Text+': ' + Edit1.Text);
    Edit1.Text := '';
  end;
end;
procedure TForm1.Button2Click(Sender: TObject);
begin
idTCPServer1.DefaultPort := 6000;
  idTCPServer1.Active := True;
  Memo1.Lines.Add('Server started on port 6000');
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
idTCPClient1.Host := Edit2.Text;
  idTCPClient1.Port := 6000;
  idTCPClient1.Connect;
  Memo1.Lines.Add('Connected to server ' + Edit2.Text);
end;



procedure TForm1.IdTCPServer1Execute(AContext: TIdContext);
var
  receivedMessage: string;
begin
  receivedMessage := AContext.Connection.IOHandler.ReadLn(IndyTextEncoding_UTF8);
  TThread.Synchronize(nil,
    procedure
    begin
      Memo1.Lines.Add(receivedMessage);
    end);
end;


end.
