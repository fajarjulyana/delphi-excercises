unit MainSrc;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Media;

type
  TForm1 = class(TForm)
    CameraComponent1: TCameraComponent;
    Button1: TButton;
    Button2: TButton;
    Image1: TImage;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure CameraComponent1SampleBufferReady(Sender: TObject;
      const ATime: TMediaTime);
    procedure GetImage;
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
begin
CameraComponent1.Active := True;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
CameraComponent1.Active := False;
end;

procedure TForm1.CameraComponent1SampleBufferReady(Sender: TObject;
  const ATime: TMediaTime);
begin
TThread.Synchronize(TThread.CurrentThread, GetImage);
end;

procedure TForm1.GetImage;
begin
CameraComponent1.SampleBufferToBitmap(Image1.Bitmap, True);
end;

end.
