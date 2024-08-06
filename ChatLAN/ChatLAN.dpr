program ChatLAN;

uses
  System.StartUpCopy,
  FMX.Forms,
  MainSource in 'src\MainSource.pas' {LANChatFrm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TLANChatFrm, LANChatFrm);
  Application.Run;
end.
