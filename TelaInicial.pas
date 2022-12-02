unit TelaInicial;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Menus, FMX.TabControl,
  System.Actions, FMX.ActnList, FMX.Objects, FMX.Edit, FMX.Layouts, FMX.ListBox,
  FMX.DateTimeCtrls, FMX.Gestures, FMX.Maps, System.Sensors, System.Permissions,
  System.Sensors.Components, REST.Types, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope;

type
  TForm3 = class(TForm)
    Te: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    TabItem3: TTabItem;
    Layout1: TLayout;
    Text1: TText;
    EditPlaca: TEdit;
    EditDescricao: TEdit;
    EditTanque: TEdit;
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    Rectangle3: TRectangle;
    Text2: TText;
    Text3: TText;
    Text4: TText;
    EditGasolina: TEdit;
    EditDiesel: TEdit;
    EditEtanol: TEdit;
    Text5: TText;
    Text6: TText;
    Text7: TText;
    Image1: TImage;
    Text8: TText;
    Text9: TText;
    Text10: TText;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Layout2: TLayout;
    Text11: TText;
    ComboBoxVeiculo: TComboBox;
    Text12: TText;
    Text13: TText;
    Text14: TText;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Text16: TText;
    Text17: TText;
    Text15: TText;
    Rectangle4: TRectangle;
    Text18: TText;
    Text19: TText;
    Text20: TText;
    Text21: TText;
    Text22: TText;
    Text23: TText;
    textDistancia: TText;
    DateEdit1: TDateEdit;
    DateEdit2: TDateEdit;
    TimeEdit1: TTimeEdit;
    TimeEdit2: TTimeEdit;
    GestureManager1: TGestureManager;
    ActionList1: TActionList;
    ChangeTabAction1: TChangeTabAction;
    ChangeTabAction2: TChangeTabAction;
    ChangeTabAction3: TChangeTabAction;
    RoundRect1: TRoundRect;
    RoundRect2: TRoundRect;
    RoundRect3: TRoundRect;
    MapView1: TMapView;
    LocationSensor1: TLocationSensor;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    editOrigem: TEdit;
    editDestino: TEdit;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    btnCalcula: TButton;
    textTempo: TText;
    procedure Edit1Typing(Sender: TObject);
    procedure Edit2Typing(Sender: TObject);
    procedure Edit3Typing(Sender: TObject);
    procedure EditTanqueTyping(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure LocationSensor1LocationChanged(Sender: TObject; const OldLocation,
      NewLocation: TLocationCoord2D);
    procedure btnCalculaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.fmx}

uses TelaLogin, TelaRegistro, uFormat, TelaAtualizacao, UDM, uOpenURL, json
{$IFDEF ANDROID}
      , Androidapi.Helpers, Androidapi.JNI.JavaTypes, Androidapi.JNI.Os
{$ENDIF}
      ;



procedure TForm3.btnCalculaClick(Sender: TObject);
var
  retorno: TJSONObject;
  prows: TJSONPair;
  arrayr: TJSONArray;
  orows: TJSONObject;
  arraye: TJSONArray;
  oelementos: TJSONObject;
  oduracao, odistancia: TJSONObject;

  distancia_str, duracao_str: string;
  distancia_int, duracao_int: integer;
begin
  RESTRequest1.Resource :=
    'json?origins={origem}&destinations={destino}&mode=driving&language=pt-BR&key=AIzaSyAwjnJzF57fQddVy_dL8yTC01Zw7ufVuY8';
  RESTRequest1.Params.AddUrlSegment('origem', editOrigem.Text);
  RESTRequest1.Params.AddUrlSegment('destino', editDestino.Text);
  RESTRequest1.Execute;

  retorno := RESTRequest1.Response.JSONValue as TJSONObject;

  if retorno.GetValue('status').Value <> 'OK' then
  begin
    showmessage('Ocorreu um erro ao calcular a viagem.');
    exit;
  end;

  prows := retorno.Get('rows');
  arrayr := prows.JSONValue as TJSONArray;
  orows := arrayr.Items[0] as TJSONObject;
  arraye := orows.GetValue('elements') as TJSONArray;
  oelementos := arraye.Items[0] as TJSONObject;

  odistancia := oelementos.GetValue('distance') as TJSONObject;
  oduracao := oelementos.GetValue('duration') as TJSONObject;

  distancia_str := odistancia.GetValue('text').Value;
  distancia_int := odistancia.GetValue('value').Value.ToInteger;

  duracao_str := oduracao.GetValue('text').Value;
  duracao_int := oduracao.GetValue('value').Value.ToInteger;

  textDistancia.Text := distancia_str;
  textTempo.Text := duracao_str;

end;



procedure TForm3.Edit1Typing(Sender: TObject);
begin
  Formatar(Edit1, TFormato.Money);
end;

procedure TForm3.Edit2Typing(Sender: TObject);
begin
  Formatar(Edit2, TFormato.Money);
end;

procedure TForm3.Edit3Typing(Sender: TObject);
begin
  Formatar(Edit3, TFormato.Money);
end;

procedure TForm3.EditTanqueTyping(Sender: TObject);
begin
  Formatar(EditTanque, TFormato.Personalizado, '##,##')
end;

procedure TForm3.FormCreate(Sender: TObject);
  begin
    MapView1.MapType := TMapType.Normal;

    {$IFDEF ANDROID}
    var
      APermissaoGPS: string;
    {$ENDIF}
    begin
      {$IFDEF ANDROID}
        APermissaoGPS := JStringToString
          (TJManifest_permission.JavaClass.ACCESS_FINE_LOCATION);

      PermissionsService.RequestPermissions([APermissaoGPS],
        Procedure(const APermissions: TArray<string>;
          const AGrantResults: TArray<TPermissionStatus>)
          begin
            if (Length(AGrantResults) = 1) and
              (AGrantResults[0] = TPermissionStatus.Granted) then
              LocationSensor1.Active := True
            else
              LocationSensor1.Active := False
        end);
     {$ENDIF}
     end;
end;




procedure TForm3.LocationSensor1LocationChanged(Sender: TObject;
  const OldLocation, NewLocation: TLocationCoord2D);
var
  MyMarker: TMapMarkerDescriptor;
  posicao: TMapCoordinate;

  begin
    MapView1.Location := TMapCoordinate.Create(NewLocation.Latitude,
      NewLocation.Longitude);
    posicao.Latitude := NewLocation.Latitude;
    posicao.Longitude := NewLocation.Longitude;
    MyMarker := TMapMarkerDescriptor.Create(posicao, 'Estou aqui!');
    MyMarker.Draggable := true;
    MyMarker.Visible := true;
    MyMarker.Snippet := 'Eu';
    MapView1.AddMarker(MyMarker);
    Label3.Text := NewLocation.Latitude.ToString().Replace(',', '.');
    Label4.Text := NewLocation.Longitude.ToString().Replace(',', '.');

  end;

end.
