unit TelaAtualizacao;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.Layouts, REST.Types,
  REST.Client, Data.Bind.Components, Data.Bind.ObjectScope, System.JSON;

type
  TForm4 = class(TForm)
    Layout1: TLayout;
    Text1: TText;
    Text2: TText;
    Image1: TImage;
    btnAtualizar: TButton;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    procedure btnAtualizarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure OnFinishUpdate(Sender: TObject);
    { Private declarations }
  public
    { Public declarations }
     versao_app:string;
     versao_server:string;
  end;

var
  Form4: TForm4;

implementation

{$R *.fmx}

uses TelaInicial, TelaLogin, TelaRegistro, uFormat, uOpenURL;

procedure TForm4.FormCreate(Sender: Tobject);
begin
  versao_app := '1.0';
  versao_server := '0.0';
end;

procedure TForm4.FormShow(Sender: TObject);
  var
  t:TThread;
  begin
    t := TThread.CreateAnonymousThread(
    procedure
    var
      JsonObj: TJSONObject;
      begin
        sleep(2000);
        try
          RESTRequest1.Execute;
        except
          on ex: Exception do
          begin
            raise Exception.Create('Erro ao acessar o servidor' + ex.Message);
            exit
          end;
        end;
        try
          JsonObj := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes
            (RESTRequest1.Response.JSONValue.ToString), 0) as TJSONObject;

          versao_server := TJSONObject(JsonObj).GetValue('Versao').Value;
        finally
        JsonObj.disposeof;
        end;
      end);
    t.OnTerminate := OnFinishUpdate;
    t.Start;
  end;


  procedure TForm4.OnFinishUpdate(Sender: TObject);
  begin

    if Assigned(TThread(Sender).FatalException) then
      begin
        showmessage(Exception(TThread(Sender).FatalException).Message);
        exit;
      end;

     if versao_app < versao_server then
     begin
       Layout1.Visible := false
     end;

  end;



procedure TForm4.btnAtualizarClick(Sender: TObject);
begin
  var
    url: string;
  begin
    {$IFDEF ANDROID}
      url :='';
    {$ELSE}
      url := '';
    {$ENDIF}
      OpenURL(url, False);
      Application.Terminate;
  end;
end;

end.
