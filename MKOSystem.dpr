program MKOSystem;

uses
  Vcl.Forms,
  Vcl.Graphics,
  uMain in 'Source\uMain.pas' {Main},
  uTaskApi in 'Source\Core\uTaskApi.pas',
  uFrameTask in 'Source\uFrameTask.pas' {FrameTask: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;

  {$IFDEF DEBUG}
  ReportMemoryLeaksOnShutdown := True;
  {$ENDIF}

  Application.DefaultFont.Name := 'Segoe UI';
  Application.DefaultFont.Size := 10;

  Application.CreateForm(TMain, Main);
  Application.Run;
end.
