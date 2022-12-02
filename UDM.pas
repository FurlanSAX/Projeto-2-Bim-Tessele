unit UDM;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Phys, FireDAC.Comp.Client,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.FMXUI.Wait, Data.DB,
  FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TForm5 = class(TForm)
    FDConnection1: TFDConnection;
    FDQueryVeiculo: TFDQuery;
    FDQueryCombustivel: TFDQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form5: TForm5;

implementation

{$R *.fmx}

end.
