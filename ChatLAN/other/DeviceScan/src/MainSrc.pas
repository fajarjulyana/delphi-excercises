unit MainSrc;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Memo.Types,
  FMX.ScrollBox, FMX.Memo, FMX.Controls.Presentation, FMX.StdCtrls, IdUDPServer,
  IdBaseComponent, IdComponent, IdUDPBase, IdUDPClient, IdGlobal, IdSocketHandle;

type
  TForm1 = class(TForm)
    IdUDPClient1: TIdUDPClient;
    IdUDPServer1: TIdUDPServer;
    Button1: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure IdUDPServer1UDPRead(AThread: TIdUDPListenerThread;
      const AData: TIdBytes; ABinding: TIdSocketHandle);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.Button1Click(Sender: TObject);
var
  BroadcastMessage: string;
begin
  BroadcastMessage := 'Device Discovery';
  IdUDPClient1.Broadcast(BroadcastMessage, 8888);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
IdUDPServer1.DefaultPort := 8888;
  IdUDPServer1.Active := True;
end;

procedure TForm1.IdUDPServer1UDPRead(AThread: TIdUDPListenerThread;
  const AData: TIdBytes; ABinding: TIdSocketHandle);
var
  Response: string;
begin
  Response := TEncoding.UTF8.GetString(AData);
  Memo1.Lines.Add(Format('Device found: %s (%s)', [Response, ABinding.PeerIP]));
end;
end.
