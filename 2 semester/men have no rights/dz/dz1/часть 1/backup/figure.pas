unit figure;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, variants, graphics, controls,
  forms, dialogs, comctrls, stdctrls, extctrls;
type tmyfigure=class
  public
    x, y, radius, degr: word;
    image:TImage;
    constructor create(aimage:TImage; ax, ay, ar, ad: word);
    procedure draw; virtual; abstract;
  end;
tmycircle = class (tmyfigure)
  public procedure draw; override; end;
tmyline = class (tmyfigure)
  public procedure draw; override; end;
implementation
//var f:byte=1;
constructor tmyfigure.create(aimage:TImage; ax, ay, ar, ad: word);
begin
  inherited create;
  image:=aimage;
  x:=ax;
  y:=ay;
  radius:=ar;
  degr:=ad;
  draw;
end;
procedure tmycircle.draw;
begin
  image.canvas.pen.color:=clblue;
  image.canvas.ellipse(x-radius, y-radius, x+radius, y+radius);
end;
procedure tmyline.draw;
var p:real;
begin
  image.canvas.pen.color:=clblue;
  image.canvas.MoveTo(x, y);
  p:=degr*pi/180;
  image.canvas.lineto(x+trunc(radius*cos(p)), y-trunc(radius*sin(p)));
end;
end.

