program myshop;

uses
  System.StartUpCopy,
  FMX.Forms,
  loginsrc in 'src\loginsrc.pas' {LoginForm},
  mainsrc in 'src\mainsrc.pas' {FrmMain},
  dbmsrc in 'src\dbmsrc.pas' {DBModule: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDBModule, DBModule);
  Application.CreateForm(TLoginForm, LoginForm);
  Application.Run;
end.
