unit ipscansrc;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Memo.Types,
  IdUDPServer, IdBaseComponent, IdComponent, IdUDPBase, IdUDPClient,
  FMX.StdCtrls, FMX.ScrollBox, FMX.Memo, FMX.Controls.Presentation;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    ProgressBar1: TProgressBar;
    IdUDPClient1: TIdUDPClient;
    IdUDPServer1: TIdUDPServer;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    procedure ScanNetwork;
    procedure Ping(const AIP: string);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.Button1Click(Sender: TObject);
begin
ScanNetwork;
end;

procedure TForm1.Ping(const AIP: string);
begin
  try
    IdUDPClient1.Host := AIP;
    IdUDPClient1.Port := 7; // Echo protocol
    IdUDPClient1.Send('Ping');
    Memo1.Lines.Add('Ping sent to ' + AIP);
    // Tambahkan logika untuk menangkap respon dan menambahkannya ke Memo1 jika diperlukan
  except
    on E: Exception do
      Memo1.Lines.Add('Error pinging ' + AIP + ': ' + E.Message);
  end;
end;

procedure TForm1.ScanNetwork;
var
  i: Integer;
  BaseIP: string;
begin
  Memo1.Lines.Clear;
  ProgressBar1.value := 0;
  ProgressBar1.Max := 254; // Untuk rentang IP dari 1 ke 254

  BaseIP := '192.168.1.'; // Ganti dengan subnet jaringan Anda

  for i := 1 to 254 do
  begin
    Ping(BaseIP + IntToStr(i));
    ProgressBar1.Value := i;
  end;
end;

end.
