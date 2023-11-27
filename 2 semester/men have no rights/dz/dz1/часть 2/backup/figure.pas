unit figure;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, graphics,ExtCtrls;
Type
     TFigure=Class
      private
        x,y,halflen, dx:integer; t2, tt:single; f, k:smallint;
        Image:TImage;
        procedure Draw;virtual;abstract;
        procedure Rel(t:real);virtual;
      public
        constructor Create(ax,ay,ah:integer;aImage:TImage);
        procedure Move(t:single; n:byte);
     end;
Tromb=Class(TFigure)
private procedure Draw;override;
end;
TSquare=Class(TFigure)
private procedure Draw;override;
end;
TRRomb=Class(TFigure)
private procedure Draw;override;
end;
implementation

Constructor TFigure.Create(ax,ay,ah:integer;aImage:TImage);
Begin
       inherited Create;
       x:=ax; y:=ay; halflen:=ah; Image:=aImage; f:=1; k:=1; tt:=0;
End;
Procedure TFigure.Rel(t:real);
Begin
  dx:=round(10*t);
End;
Procedure TFigure.Move(t:single; n:byte);
Begin
       if (x+dx+halflen>image.width-5*n) and (f=1) //0.5*10*3(n)
          or (x+dx-halflen<5*n) and (f=-1) then
          begin
            if k=1 then begin t2:=t-t2; k:=2; end;
            if f=1 then tt:=t2;
            f:=-f;
          end;
       if (f=1) then tt:=tt+0.5*n
       else begin tt:=tt-0.5*n; end;
       Image.Canvas.Pen.Color:=clWhite;
       Draw;
       Image.Canvas.Pen.Color:=clBlack;
       Rel(tt);
       Draw;
End;
Procedure Tromb.Draw;
Begin
      image.canvas.MoveTo(x+dx+halflen, y);
      Image.Canvas.LineTo(x+dx,y+2*halflen);
      Image.Canvas.LineTo(x+dx-halflen,y);
      Image.Canvas.LineTo(x+dx,y-2*halflen);
      Image.Canvas.LineTo(x+dx+halflen,y);
End;
Procedure TSquare.Draw;
Begin
      image.canvas.MoveTo(x+dx+halflen, y+halflen);
      Image.Canvas.LineTo(x+dx-halflen,y+halflen);
      Image.Canvas.LineTo(x+dx-halflen,y-halflen);
      Image.Canvas.LineTo(x+dx+halflen,y-halflen);
      Image.Canvas.LineTo(x+dx+halflen,y+halflen);
End;
Procedure Trromb.Draw;
var a, b:byte;
Begin
      a:=halflen div 3;
      image.canvas.MoveTo(x+dx+a, y);
      Image.Canvas.LineTo(x+dx,y+2*a);
      Image.Canvas.LineTo(x+dx-a,y);
      Image.Canvas.LineTo(x+dx,y-2*a);
      Image.Canvas.LineTo(x+dx+a,y);
      b:=halflen div 2;
      image.canvas.MoveTo(x+dx+halflen, y);
      Image.Canvas.LineTo(x+dx,y+b);
      Image.Canvas.LineTo(x+dx-halflen,y);
      Image.Canvas.LineTo(x+dx,y-b);
      Image.Canvas.LineTo(x+dx+halflen,y);
End;
end.


