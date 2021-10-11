unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    Label3: TLabel;
    ComboBox1: TComboBox;
    Label4: TLabel;
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
   MInWord;

const
  LngFiles: array[0..2] of String =
    ('Ruble.lng', 'Ukr.lng', 'Euro.lng');

var
  IW: TInWord;

procedure TForm1.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
 if Ord(Key)<32
 then Exit;
 if Key in ['0'..'9', DecimalSeparator]
 then
  begin
   if Key in ['.', ',']
   then Key := DecimalSeparator;
   if (Key = DecimalSeparator) and
             (Pos(DecimalSeparator, Edit1.Text) > 0)
   then Key := #0;
  end
 else Key := #0;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
 ComboBox1.ItemIndex := 0;
 IW := TInWord.Create(Self);
 IW.Target := Label3;
 Edit1Change(Sender);
 // IW.SaveToFile('Long.lng');
end;

procedure TForm1.Edit1Change(Sender: TObject);
begin
 try
  IW.Value := StrToFloat(Edit1.Text);
 except
  IW.Value := 0.00;
 end;
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
begin
 IW.LoadFromFile(LngFiles[ComboBox1.ItemIndex]);
end;

end.
