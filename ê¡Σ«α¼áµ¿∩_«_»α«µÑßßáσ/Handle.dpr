program Handle;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '�����';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
