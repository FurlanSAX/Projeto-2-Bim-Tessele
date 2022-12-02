program Project1;

uses
  System.StartUpCopy,
  FMX.Forms,
  TelaLogin in 'TelaLogin.pas' {Form1},
  TelaRegistro in 'TelaRegistro.pas' {Form2},
  TelaInicial in 'TelaInicial.pas' {Form3},
  uFormat in 'uFormat.pas',
  TelaAtualizacao in 'TelaAtualizacao.pas' {Form4},
  uOpenURL in 'uOpenURL.pas',
  UDM in 'UDM.pas' {Form5};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
