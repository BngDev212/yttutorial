unit uMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.StdCtrls, FMX.Controls.Presentation;

type
  TFrmMain = class(TForm)
    Layout1: TLayout;
    Layout2: TLayout;
    GridPanelLayout1: TGridPanelLayout;
    Label1: TLabel;
    lUsr: TLabel;
    btClose: TCornerButton;
    btMaster: TCornerButton;
    btCashier: TCornerButton;
    btSetup: TCornerButton;
    procedure btMasterClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.fmx}

procedure TFrmMain.btMasterClick(Sender: TObject);
begin
    showmessage('master menu');
end;

end.
