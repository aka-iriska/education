unit main;
{$mode objfpc}{$H+}
interface
uses
  windows, Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls;
type
  { TForm1 }
  TForm1 = class(TForm)
    exitbutton: TButton;
    redit: TEdit;
    dedit: TEdit;
    Image1: TImage;
    rlabel: TLabel;
    dlabel: TLabel;
    procedure exitbuttonClick(Sender: TObject);
    procedure formactivate(sender: tobject);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  end;
var
  Form1: TForm1;
implementation
uses figure;
{$R *.lfm}
{ TForm1 }
var f:byte=1;
procedure TForm1.formactivate(sender: tobject);
begin
   image1.canvas.brush.color:=clwhite;
end;
procedure TForm1.exitbuttonClick(Sender: TObject);
begin close; end;
procedure TForm1.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
   if f=1 then begin
     Image1.Canvas.FillRect(Rect(0,0,Width,Height));
     f:=2; end;
   if button=mbleft then
    tmycircle.create(image1, x, y, strtoint(redit.text), strtoint(dedit.text));
   if button=mbright then
    tmyline.create(image1, x, y, strtoint(redit.text), strtoint(dedit.text));
end;
end.

