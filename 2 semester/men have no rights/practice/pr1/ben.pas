unit ben;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm4 }

  TForm4 = class(TForm)
    exitb: TButton;
    putb: TButton;
    namee: TEdit;
    prove: TEdit;
    namel: TLabel;
    provel: TLabel;
    procedure exitbClick(Sender: TObject);
    procedure putbClick(Sender: TObject);
  private

  public

  end;

var
  Form4: TForm4;

implementation
uses main;
{$R *.lfm}

{ TForm4 }

procedure TForm4.exitbClick(Sender: TObject);
begin
  closefile(f);
  self.hide;
end;

procedure TForm4.putbClick(Sender: TObject);
var n, p: string[22]; j, be:word;
begin
   n:=namee.text;
   j:=0;
   seek(f, j);
   be:=10000;
   while not(eof(f)) do begin
    read(f, b);
    if b.name<>n then begin j:=j+1; seek(f, j); end
    else
         if strtoint(b.price)<be then begin
           be:=strtoint(b.price);
           p:=b.provider;
         end;
    end;
    if be=10000 then prove.text:='Ошибка'
    else prove.text:=p;
end;
end.

