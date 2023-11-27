unit table;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, TAGraph,
  TASeries, TAChartUtils, TASources;

type

  { TForm5 }

  TForm5 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    BarSeries1: TBarSeries;
    Chart1: TChart;
    Chart1BarSeries1: TBarSeries;
    Label1: TLabel;
    Label2: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  end;

var
  Form5: TForm5;

implementation
uses main;
{$R *.lfm}

{ TForm5 }

procedure TForm5.Button2Click(Sender: TObject);
var i, j:byte; n:string[22]; fl:boolean;
  aa:array [1..4,1..20] of string[22]; ls : TListChartSource;
begin
   i:=0;
   seek(f, 0);
   while not(eof(f)) do begin
    read(f, b);
    n:=b.name;
    fl:=false;
    for j:=1 to 20 do
        if aa[1, j]=n then begin
          str(strtoint(aa[3, j])+strtoint(b.price), aa[3, j]);
          str(strtoint(aa[2, j])+1,  aa[2, j]);
          str(strtoint(aa[3, j]) div strtoint(aa[2, j]), aa[4, j]);
          fl:=true;
          break;
        end;
    if fl=false then begin
      i:=i+1;
      aa[1, i]:=n;
      aa[2, i]:='1';
      aa[3, i]:=b.price;
      aa[4, i]:=b.price; end;
  end;
   {Chart1BarSeries1.AddXY(1, 60, 'apple', clred);
   Chart1BarSeries1.AddXY(2, 40, 'orange', clred); }
   Chart1BarSeries1.clear;
   ls := TListChartSource.Create(Chart1);
  Chart1.BottomAxis.Marks.Source := ls;
  for j:=1 to i do begin
      ls.Add(j, strtoint(aa[4, j]), aa[1, j], clred);
      Chart1BarSeries1.AddXY(j, strtoint(aa[4, j]), aa[4, j], clred);
  end;
end;

procedure TForm5.Button1Click(Sender: TObject);
begin
  closefile(f);
  self.hide;
end;
end.

