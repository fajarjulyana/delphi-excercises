unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Rtti,
  FMX.Grid.Style, FMX.Grid, FMX.Controls.Presentation, FMX.ScrollBox;

type
  TStringGrid = class(FMX.Grid.TStringGrid)
   protected
    procedure ApplyStyle; override;
   end;

  TForm1 = class(TForm)
    StringGrid1: TStringGrid;
    StringColumn1: TStringColumn;
    StringColumn2: TStringColumn;
    procedure FormCreate(Sender: TObject);
    procedure StringGrid1DrawColumnHeader(Sender: TObject;
      const Canvas: TCanvas; const Column: TColumn; const Bounds: TRectF);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.FormCreate(Sender: TObject);
begin

end;

{ TStringGrid }

procedure TStringGrid.ApplyStyle;
var LLineFill: TBrushObject;
begin
if FindStyleResource<TBrushObject>('LineFill',LLineFill) then
LLineFill.Brush.Color := TAlphaColorRec.Orange;
  inherited;

end;

procedure TForm1.StringGrid1DrawColumnHeader(Sender: TObject;
  const Canvas: TCanvas; const Column: TColumn; const Bounds: TRectF);
var
  ABrush: TStrokeBrush;
  ARectF: TRectF;
begin
  // fill
  Canvas.Fill.Color := TAlphaColorRec.Lavender;
  Canvas.FillRect(Bounds, 0, 0, [], 1);

  // draw rect, actually only bottom and right side of current header cell
  ABrush := TStrokeBrush.Create( TBrushKind.Solid , TAlphaColorRec.Red);
  try
    Canvas.DrawRectSides(Bounds, 0, 0, [], 1, [TSide.Bottom, TSide.Right], ABrush, TCornerType.Round);

    // Draw header text
    ARectF := Bounds;
    ARectF.Left := ARectF.Left + 4;
    Canvas.Font.Size := 15;
    Canvas.Fill.Color := TAlphaColorRec.Black;
    Canvas.FillText(ARectF, Column.Header , False, 1, [] , TTextAlign.Leading);
  finally
    ABrush.Free;
  end;
end;

end.
