program MKOSystem;

uses
  Vcl.Forms,
  Vcl.Graphics,
  uMain in 'Source\uMain.pas' {Main},
  uTaskApi in 'Source\Core\uTaskApi.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;

  Application.DefaultFont.Name := 'Segoe UI';
  Application.DefaultFont.Size := 10;
  Application.DefaultFont.Color := clBtnHighlight;

  Application.CreateForm(TMain, Main);
  Application.Run;
end.
