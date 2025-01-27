unit MainSource;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Edit, FMX.Layouts, FMX.ListBox, FMX.Controls.Presentation,
  IdCustomTCPServer, IdTCPServer, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdContext, IdStack,IdStackConsts, IdGlobal, IdIPWatch;

type
  TLANChatFrm = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    ListBox1: TListBox;
    Panel2: TPanel;
    Edit1: TEdit;
    Button1: TButton;
    IdTCPClient1: TIdTCPClient;
    IdTCPServer1: TIdTCPServer;
    IdIPWatch1: TIdIPWatch;
    Edit2: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure IdTCPServer1Execute(AContext: TIdContext);
    procedure GetLocalIP;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  LANChatFrm: TLANChatFrm;

implementation

{$R *.fmx}
{$R *.LgXhdpiPh.fmx ANDROID}
procedure TLANChatFrm.GetLocalIP;
var
  IdIPWatch: TIdIPWatch;
  IPAddress: string;
begin
  IdIPWatch := TIdIPWatch.Create(nil);
  try
    IdIPWatch.Active := True;
    IPAddress := IdIPWatch.LocalIP;
    ShowMessage('Local IP Address: ' + IPAddress);
  finally
    IdIPWatch.Free;
  end;
end;
procedure TLANChatFrm.Button1Click(Sender: TObject);
begin
if Edit1.Text <> '' then
   begin
 //  IdTCPClient1.Host := IdIPWatch1.LocalIP;
   IdTCPClient1.Host := Edit2.Text;
   IdTCPClient1.Connect;
   IdTCPClient1.Socket.WriteLn(Edit1.Text);

   ListBox1.Items.Add(IdIPWatch1.LocalIP+':'+ Edit1.Text);
   Edit1.Text := '';

   IdTCPClient1.Disconnect;
   end;
end;

procedure TLANChatFrm.IdTCPServer1Execute(AContext: TIdContext);
var
ReceivedText: string;
begin
  ReceivedText := AContext.Connection.Socket.ReadLn;
  TThread.Synchronize(nil,
    procedure
    begin
      ListBox1.Items.Add(IdIPWatch1.LocalIP+':'+ReceivedText)
    end);
end;

end.
