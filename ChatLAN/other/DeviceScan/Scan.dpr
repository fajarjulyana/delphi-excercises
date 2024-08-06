program Scan;

uses
  System.StartUpCopy,
  FMX.Forms,
  MainSrc in 'src\MainSrc.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
