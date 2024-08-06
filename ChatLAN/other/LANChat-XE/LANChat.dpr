program LANChat;

uses
  System.StartUpCopy,
  FMX.Forms,
  sourceMain in 'src\sourceMain.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
