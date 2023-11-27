unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    beginbutton: TButton;
    exitbutton: TButton;
    Image1: TImage;
    Timer1: TTimer;
    procedure FormActivate(Sender: TObject);
    procedure beginbuttonClick(Sender: TObject);
    procedure exitbuttonClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  end;
var
  Form1: TForm1;
implementation
uses Figure;
{$R *.lfm}
Var
    t:single=0.0;
    R:Tromb;
    S:TSquare;
    RR:Trromb;
{ TForm1 }
procedure TForm1.FormActivate(Sender: TObject);
begin
   Image1.Canvas.Brush.Color:=clWhite;
   Image1.Canvas.FillRect(Rect(0,0,Width,Height));
end;
procedure TForm1.Timer1Timer(Sender: TObject);
begin
        R.Move(5*t, 5);
        S.Move(3*t, 3);
        RR.Move(10*t, 10);
        t:=t+0.5;
end;
procedure TForm1.BeginButtonClick(Sender: TObject);
begin
   Image1.Canvas.FillRect(Rect(0,0,Width,Height));
   S:=TSquare.Create(90,60,50,Image1);
   R:=Tromb.Create(200,197,40,Image1);
   RR:=Trromb.Create(100,350,100,Image1);
   Timer1.Enabled:=true;
end;
procedure TForm1.ExitButtonClick(Sender: TObject);
begin
   Close;
end;
initialization
finalization
   R.Free;
   S.Free;
   RR.Free;
end.

