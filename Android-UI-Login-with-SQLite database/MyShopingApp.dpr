program MyShopingApp;

uses
  System.StartUpCopy,
  FMX.Forms,
  uLogin in 'uLogin.pas' {FrmLogin},
  uMain in 'uMain.pas' {FrmMain},
  uDM in 'uDM.pas' {dm: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(TFrmLogin, FrmLogin);
  Application.Run;
end.
