program pFinance;

uses
  System.StartUpCopy,
  FMX.Forms,
  uMaster in 'uMaster.pas' {FrmMaster},
  BFA.Helper.MemTable in 'source\BFA.Helper.MemTable.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmMaster, FrmMaster);
  Application.Run;
end.
