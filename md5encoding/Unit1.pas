unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,IdGlobal, IdHash, IdHashMessageDigest,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Edit;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    procedure Button1Click(Sender: TObject);
  private
  function MD5Hash(const AInput: string): string;
  function BytesToHex(const ABytes: TIdBytes): string;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
var
  InputString: string;
  MD5Result: string;
begin
  // Input string to be hashed
  InputString := 'user';

  // Calculate MD5 hash
  MD5Result := MD5Hash(InputString);

  // Display the hash result
  Edit1.Text:= MD5Result;
end;

function TForm1.BytesToHex(const ABytes: TIdBytes): string;
var
  I: Integer;
begin
  Result := '';
  for I := 0 to Length(ABytes) - 1 do
  begin
    Result := Result + IntToHex(ABytes[I], 2);
  end;
end;

function TForm1.MD5Hash(const AInput: string): string;
var
  MD5: TIdHashMessageDigest5;
  HashBytes: TIdBytes;
begin
  MD5 := TIdHashMessageDigest5.Create;
  try
    // Convert TEncoding to IIdTextEncoding
    HashBytes := MD5.HashString(AInput, IndyTextEncoding_UTF8);

    // Convert hash result to hexadecimal string
    Result := BytesToHex(HashBytes);
  finally
    MD5.Free;
  end;
end;

end.
