unit TelaLogin;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Edit, FMX.Controls.Presentation, FMX.StdCtrls;

type
  TForm1 = class(TForm)
    BotaoCadastro: TButton;
    BotaoLogin: TButton;
    EditSenha: TEdit;
    Image2: TImage;
    EditUsuario: TEdit;
    Image1: TImage;
    Circle1: TCircle;
    Image4: TImage;
    Text1: TText;
    procedure BotaoCadastroClick(Sender: TObject);
    procedure BotaoLoginClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

uses TelaRegistro, TelaInicial, uFormat, UDM, TelaAtualizacao, uOpenURL;

procedure TForm1.BotaoCadastroClick(Sender: TObject);
begin
  if not Assigned(Form2) then
    Application.CreateForm(TForm2, Form2);
  Form2.Show;

  //TelaRegistro.Form2.show;
  //TelaLogin.Form1.hide;
end;

procedure TForm1.BotaoLoginClick(Sender: TObject);
begin

  if not Assigned(Form3) then
    Application.CreateForm(TForm3, Form3);
  Form3.Show;

  //TelaInicial.Form3.Show;
  //TelaLogin.Form1.Hide;



end;

end.
