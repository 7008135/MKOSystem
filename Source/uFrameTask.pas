unit uFrameTask;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  uTaskApi, Vcl.ExtCtrls, Vcl.Grids, Vcl.ValEdit, Vcl.Buttons, System.Actions,
  Vcl.ActnList, System.ImageList, Vcl.ImgList, Vcl.VirtualImageList,
  Vcl.BaseImageCollection, Vcl.ImageCollection, Vcl.ComCtrls, Vcl.StdCtrls;

type
  TFrameTask = class(TFrame)
    vleParamsTask: TValueListEditor;
    Panel1: TPanel;
    sbtnStart: TSpeedButton;
    alMain: TActionList;
    spbtnStop: TSpeedButton;
    actStart: TAction;
    actStop: TAction;
    ImageCollection1: TImageCollection;
    VirtualImageList1: TVirtualImageList;
    Panel2: TPanel;
    ProgressBar1: TProgressBar;
    ListBox1: TListBox;
    Splitter1: TSplitter;
    procedure vleParamsTaskMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure actStartExecute(Sender: TObject);
    procedure actStopExecute(Sender: TObject);
  private
    FTask: ITaskDefinition;
    FTaskParam: TArray<TTaskDefinitionParam>;
  public
    constructor Create(AOwner: TComponent;
      const ATask: ITaskDefinition;
      const ATabIndex: Integer);
    destructor Destroy; override;
  end;

implementation

{$R *.dfm}

{ TFrameTask }

procedure TFrameTask.actStartExecute(Sender: TObject);
begin
  ;
end;

procedure TFrameTask.actStopExecute(Sender: TObject);
begin
  ;
end;

constructor TFrameTask.Create(AOwner: TComponent;
  const ATask: ITaskDefinition;
  const ATabIndex: Integer);

  procedure FillParam;
  begin
    vleParamsTask.Strings.Clear;
    for var Index := Low(FTaskParam) to High(FTaskParam) do
      vleParamsTask.Strings.Add(Format('%s=', [FTaskParam[Index].NameParam]))
  end;
begin
  inherited Create(AOwner);
  actStop.Enabled := False;

  Name := Name + '_' + ATabIndex.ToString;
  FTask := ATask;

  if not Assigned(FTask) then
    Enabled := False
  else
    FTaskParam := FTask.GetRequiredParams;

  FillParam;
end;

destructor TFrameTask.Destroy;
begin

  inherited;
end;

procedure TFrameTask.vleParamsTaskMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var
  Row: Integer;
begin
  Row := vleParamsTask.MouseCoord(X, Y).Y - 1;

  if (Row >= 0) and (Row < Length(FTaskParam)) then
    vleParamsTask.Hint := FTaskParam[Row].DescriptionParam
  else
    vleParamsTask.Hint := '';

  Application.ActivateHint(vleParamsTask.ClientToScreen(Point(X, Y)));
end;

end.
