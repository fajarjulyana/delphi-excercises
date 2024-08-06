unit loginsrc;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Objects, FMX.Edit, FMX.Controls.Presentation, FMX.StdCtrls, mainsrc;

type
  TLoginForm = class(TForm)
    Layout1: TLayout;
    Layout2: TLayout;
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    Line1: TLine;
    Label1: TLabel;
    Edit1: TEdit;
    Layout3: TLayout;
    Layout4: TLayout;
    Line2: TLine;
    Label2: TLabel;
    Edit2: TEdit;
    Button1: TButton;
    CheckBox1: TCheckBox;
    procedure CheckBox1Change(Sender: TObject);
    procedure Edit1KeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure Edit2KeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  LoginForm: TLoginForm;

implementation

{$R *.fmx}

uses  dbmsrc;

procedure TLoginForm.Button1Click(Sender: TObject);
var pwd : string;
begin
if trim(Edit1.text)='' then
begin
   ShowMessage('Please enter username');
   edit1.SetFocus;
   FrmMain.show;
end
else
begin
  with DBModule do begin

  dblibrary.Open;
  qTemp.SQL.Clear;
  qTemp.SQL.Text:= 'Select * from users where username='+quotedstr(Edit1.Text);

  qTemp.Open;
  if qTemp.RecordCount > 0 then
      begin
        pwd := qTemp.FieldByName('password').AsString;
        if pwd=edit2.Text then
        begin
              loginForm.Hide;
              if not Assigned(FrmMain) then
              frmmain:= Tfrmmain.Create(self);
              frmmain.ShowModal(
              procedure(ModalResult: TModalResult)
              begin
                if ModalResult = mrClose then Application.Terminate;

              end
              );

        end
        else
        begin
        showmessage('password salah');
        end;
      end
      else
      begin
        showmessage('Username salah');
      end;
  end;
end;
end;

procedure TLoginForm.CheckBox1Change(Sender: TObject);
begin
Edit2.Password := not CheckBox1.IsChecked;
end;

procedure TLoginForm.Edit1KeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
if key=vkreturn then Edit2.SetFocus;

end;

procedure TLoginForm.Edit2KeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
if key=vkreturn then Button1.SetFocus;
end;

end.
