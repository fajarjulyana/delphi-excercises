unit ScannerSrc;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.ListBox, IdUDPServer, IdBaseComponent, IdComponent, IdUDPBase, IdUDPClient,
  IdGlobal, IdSocketHandle, FMX.Controls.Presentation, FMX.StdCtrls,
  FMX.Memo.Types, FMX.ScrollBox, FMX.Memo;

type
  TForm1 = class(TForm)
    IdUDPClient1: TIdUDPClient;
    IdUDPServer1: TIdUDPServer;
    ListBox1: TListBox;
    Button1: TButton;
    procedure IdUDPServer1UDPRead(AThread: TIdUDPListenerThread;
      const AData: TIdBytes; ABinding: TIdSocketHandle);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    procedure ScanLAN;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.Button1Click(Sender: TObject);
begin
ScanLAN;
end;

procedure TForm1.IdUDPServer1UDPRead(AThread: TIdUDPListenerThread;
  const AData: TIdBytes; ABinding: TIdSocketHandle);
begin
ListBox1.Items.Add(ABinding.PeerIP);
end;

procedure TForm1.ScanLAN;
var
  i: Integer;
  Subnet: string;
begin
  // Misalkan subnetnya 192.168.43.x
  Subnet := '192.168.43.';
  IdUDPClient1.BroadcastEnabled := True;
  IdUDPServer1.Active := True;
  for i := 1 to 254 do
  begin
    IdUDPClient1.Host := Subnet + IntToStr(i);
    IdUDPClient1.Port := 12345;
    IdUDPClient1.Send('Ping');
    Sleep(10); // Tambahkan jeda waktu untuk menghindari pengiriman terlalu cepat
  end;
end;
end.
