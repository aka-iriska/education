unit maxproduct;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm2 }

  TForm2 = class(TForm)
    muchb: TButton;
    backb: TButton;
    muche: TEdit;
    procedure backbClick(Sender: TObject);
    procedure muchbClick(Sender: TObject);
  private

  public

  end;

var
  Form2: TForm2;

implementation
uses main;
{$R *.lfm}

{ TForm2 }

procedure TForm2.muchbClick(Sender: TObject);
var max:integer=0; fl:boolean; i, j:byte;
    aa: array [1..2, 1..20] of string[22]; ii, n:string[22];
begin
  i:=0;
  seek(f, 0);
  while not(eof(f)) do begin
    fl:=false;
    read(f, b);
    n:=b.name;
    for j:=1 to 20 do
        if aa[1, j]=n then begin
          str(strtoint(aa[2, j])+strtoint(b.amount), aa[2, j]);
          fl:=true;
          break;
        end;
    if fl=false then  begin i:=i+1; aa[1, i]:=n; aa[2, i]:=b.amount; end;
  end;
  for j:=1 to i do
       if strtoint(aa[2, j])>max then begin
         max:= strtoint(aa[2, j]);
         ii:=aa[1, j];
       end;
  muche.Enabled:=true;
  muche.text:=ii;
end;

procedure TForm2.backbClick(Sender: TObject);
begin
  closefile(f);
  self.hide;
end;

end.

