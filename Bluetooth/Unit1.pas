unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.ListBox, FMX.Controls.Presentation, FMX.StdCtrls, System.Bluetooth,
  System.Bluetooth.Components;

type
  TForm1 = class(TForm)
    Button1: TButton;
    ListBox1: TListBox;
    Bluetooth1: TBluetooth;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}
{$R *.LgXhdpiPh.fmx ANDROID}
{$R *.iPhone55in.fmx IOS}
{$R *.NmXhdpiPh.fmx ANDROID}

procedure TForm1.Button1Click(Sender: TObject);
var
  BluetoothManager: TBluetoothManager;
  DiscoveredDevices: TBluetoothDeviceList;
  I: Integer;
begin
  BluetoothManager.StartDiscovery(10000); // Scanning for 10 seconds
  DiscoveredDevices := BluetoothManager.LastDiscoveredDevices;
  ListBox1.Items.Clear;
  for I := 0 to DiscoveredDevices.Count - 1 do
  begin
    ListBox1.Items.Add(DiscoveredDevices[I].DeviceName);
  end;
  BluetoothManager := TBluetoothManager.Current;
  if BluetoothManager.ConnectionState = TBluetoothConnectionState.Connected then
  begin
    ShowMessage('Bluetooth already connected');
    Exit;
  end;

end;

procedure TForm1.Button2Click(Sender: TObject);
var
  BluetoothManager: TBluetoothManager;
  Device: TBluetoothDevice;
  Socket: TBluetoothSocket;
begin
  if ListBox1.ItemIndex > -1 then
  begin
    BluetoothManager := TBluetoothManager.Current;
    Device := BluetoothManager.LastDiscoveredDevices[ListBox1.ItemIndex];
    Socket := Device.CreateClientSocket(TBluetoothUUID.Create('{00001101-0000-1000-8000-00805F9B34FB}'), False);
    if Assigned(Socket) then
    begin
      try
        Socket.Connect;
        ShowMessage('Connection successful');
      except
        on E: Exception do
          ShowMessage('Connection failed: ' + E.Message);
      end;
    end
    else
    begin
      ShowMessage('Socket not assigned');
    end;
  end
  else
    ShowMessage('Select a device first');
end;
end.
