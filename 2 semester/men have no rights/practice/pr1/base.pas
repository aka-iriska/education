unit base;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Grids;

type

  { TForm6 }

  TForm6 = class(TForm)
    Button1: TButton;
    StringGrid1: TStringGrid;
    procedure Button1Click(Sender: TObject);
  end;
var
  Form6: TForm6;

implementation
uses main;
{$R *.lfm}

{ TForm6 }

procedure TForm6.Button1Click(Sender: TObject);
var k:byte=0; j:byte; s:string[22];
begin
  assignfile(f, 'vegbase.dat');
  Reset(F);
  stringgrid1.rowcount:=filesize(f)+1;
  stringgrid1.cells[1, 0]:='имя';
  stringgrid1.cells[2, 0]:='производитель';
  stringgrid1.cells[3, 0]:='наличие';
  stringgrid1.cells[4, 0]:='цена за 1 кг';
  for j:=1 to filesize(f) do begin
    seek(f, k);
    read(f, b);
    str(j, s);
    stringgrid1.cells[0, j]:=s;
    stringgrid1.cells[1, j]:=b.name;
    stringgrid1.cells[2, j]:=b.provider;
    stringgrid1.cells[3, j]:=b.amount;
    stringgrid1.cells[4, j]:=b.price;
    inc(k);
  end;
  closefile(f);
end;
end.

