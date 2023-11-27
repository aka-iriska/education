unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    maxbutton: TButton;
    muchbutton: TButton;
    benefitbutton: TButton;
    tablebutton: TButton;
    exitbutton: TButton;
    addbutton: TButton;
    delbutton: TButton;
    Button8: TButton;
    nedit: TEdit;
    proedit: TEdit;
    amedit: TEdit;
    predit: TEdit;
    nlabel: TLabel;
    prolabel: TLabel;
    amlabel: TLabel;
    prlabel: TLabel;
    procedure addbuttonClick(Sender: TObject);
    procedure benefitbuttonClick(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure delbuttonClick(Sender: TObject);
    procedure exitbuttonClick(Sender: TObject);
    procedure maxbuttonClick(Sender: TObject);
    procedure muchbuttonClick(Sender: TObject);
    procedure tablebuttonClick(Sender: TObject);
  end;
type zap = record
     name: string[22];
     provider: string[22];
     amount: string[22];
     price: string[22];
     end;
var
  Form1: TForm1;
  f:file of zap;
  b:zap;
implementation
uses maxproduct, howmuchbuy, ben, table, base;
{$R *.lfm}

{ TForm1 }

procedure TForm1.maxbuttonClick(Sender: TObject);
begin
  assignfile(f, 'vegbase.dat');
  reset(f);
  form2.show;
end;

procedure TForm1.muchbuttonClick(Sender: TObject);
begin
  assignfile(f, 'vegbase.dat');
  Reset(F);
  form3.show;
end;
procedure TForm1.benefitbuttonClick(Sender: TObject);
begin
  assignfile(f, 'vegbase.dat');
  Reset(F);
  form4.show;
end;
procedure TForm1.tablebuttonClick(Sender: TObject);
begin
  assignfile(f, 'vegbase.dat');
  Reset(F);
  form5.show;
end;
procedure TForm1.Button8Click(Sender: TObject);
begin
  form6.show;
end;
procedure TForm1.addbuttonClick(Sender: TObject);
begin
  AssignFile(f,'vegbase.dat');
  {$I-} Reset(F); {$I+}
   if ioresult=0 then seek(f,FileSize(f))
   else rewrite(f);
  b.name:=nedit.text;
  b.provider:=proedit.text;
  b.amount:=amedit.text;
  b.price:=predit.text;
  nedit.clear;
  proedit.clear;
  amedit.clear;
  predit.clear;
  write(f, b);
  nedit.setfocus;
  closefile(f);
end;
procedure TForm1.delbuttonClick(Sender: TObject);
begin
  AssignFile(f,'vegbase.dat');
  assignfile(f1, 'trash.dat');
  Reset(F);
  rewrite(f1);
  b.name:=nedit.text;
  b.provider:=proedit.text;
  b.amount:=amedit.text;
  b.price:=predit.text;
  while not(EOF(f)) do begin
        read(f, c);
        if (b.name<>c.name) or (b.provider<>c.provider) then write(f1, c);
  end;
  reset(f1);
  rewrite(f);
  while not(EOF(f1)) do begin read(f1, c); write(f, c); end;
  nedit.clear;
  proedit.clear;
  amedit.clear;
  predit.clear;
  nedit.setfocus;
  closefile(f);
  closefile(f1);
end;

procedure TForm1.exitbuttonClick(Sender: TObject);
begin
  close;
end;

end.

