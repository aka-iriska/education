unit howmuchbuy;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm3 }

  TForm3 = class(TForm)
    prb: TButton;
    putb: TButton;
    nextb: TButton;
    exitb: TButton;
    sume: TEdit;
    namee: TEdit;
    prove: TEdit;
    edit1: TEdit;
    mase: TEdit;
    suml: TLabel;
    namel: TLabel;
    provl: TLabel;
    Label1: TLabel;
    masl: TLabel;
    procedure exitbClick(Sender: TObject);
    procedure nextbClick(Sender: TObject);
    procedure prbClick(Sender: TObject);
    procedure putbClick(Sender: TObject);
  private

  public

  end;

var
  Form3: TForm3;

implementation
uses main;
{$R *.lfm}

{ TForm3 }

procedure TForm3.exitbClick(Sender: TObject);
begin
   closefile(f);
   self.hide;
end;

procedure TForm3.nextbClick(Sender: TObject);
begin
   j:=j+1;
  prb.enabled:=true;
  Putbclick(sender);
end;

procedure TForm3.prbClick(Sender: TObject);
begin
  j:=j-1;
  Putbclick(sender);
end;

procedure TForm3.putbClick(Sender: TObject);
var summa, h, k:integer; s:string[10];
begin
  seek(f, j);
  nextb.enabled:=true;
  namee.enabled:=true;
  prove.enabled:=true;
  mase.enabled:=true;
  edit1.enabled:=true;
  summa:=strtoint(sume.Text);
  read(f, b);
  namee.text:=b.name;
  prove.text:=b.provider;
  edit1.text:=b.price;
  h:=summa div strtoint(b.price);
  if h<=strtoint(b.amount) then begin str(h, s); mase.text:=s; end
    else mase.text:=b.amount;
  k:=j+1;
  seek(f, k);
  if eof(f) then nextb.enabled:=false;
  k:=j-1;
  if k<0 then prb.enabled:=false;
end;

end.

