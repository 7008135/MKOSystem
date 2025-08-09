unit uFrameTask;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.Threading,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  uTaskApi, Vcl.ExtCtrls, Vcl.Grids,
  Vcl.ValEdit, Vcl.Buttons, System.Actions,
  Vcl.ActnList, System.ImageList,
  Vcl.ImgList, Vcl.VirtualImageList,
  Vcl.BaseImageCollection,
  Vcl.ImageCollection, Vcl.ComCtrls, Vcl.StdCtrls;

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
    prbrProcessTask: TProgressBar;
    ListBox1: TListBox;
    Splitter1: TSplitter;
    SpeedButton1: TSpeedButton;
    procedure vleParamsTaskMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure actStartExecute(Sender: TObject);
    procedure actStopExecute(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    FTaskExecute: TTask;
    FTask: ITaskDefinition;
    FTaskParam: TArray<TTaskDefinitionParam>;
    FTaskAnonymousThread: TThread;
    procedure StopTaskThread;
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
  function AreAllKeysFilled: Boolean;
  var
    KeyValue: String;
  begin
    Result := True;
    for var Index := 0 to vleParamsTask.Strings.Count - 1 do
    begin
      KeyValue := vleParamsTask.Values[vleParamsTask.Keys[Index + 1]];
      if Trim(KeyValue) = '' then
        Exit(False)
      else
        FTaskParam[Index].Value := KeyValue;
    end;
  end;
var
  ResultMsg: String;
begin
  if not AreAllKeysFilled then
    raise Exception.Create('Заполните все свойства значениями!');

  actStop.Enabled := True;
  actStart.Enabled := False;

  prbrProcessTask.State := pbsNormal;
  FTaskAnonymousThread := TThread.CreateAnonymousThread(
  procedure
  var
    ExcResult: Boolean;
  begin
    ExcResult := FTask.Execute(FTaskParam, ResultMsg);

    TThread.Synchronize(nil,
      procedure
      begin
        {Остановим прогресс}
        prbrProcessTask.State := pbsPaused;

        {Обновим состояние кнопокй}
        actStop.Enabled := False;
        actStart.Enabled := True;

        {Выведем ответ если он есть}
        if ResultMsg <> '' then
          if ExcResult then
            MessageBox(Handle, PChar(ResultMsg),
              'Уведомление', MB_OK + MB_ICONINFORMATION)
          else
            MessageBox(Handle, PChar(ResultMsg),
              'Внимание!', MB_OK + MB_ICONWARNING)
      end);
  end);
  FTaskAnonymousThread.Start;
end;

procedure TFrameTask.SpeedButton1Click(Sender: TObject);
begin
  {Тестовые данные}
  vleParamsTask.Values[vleParamsTask.Keys[1]] := '*.txt,*.doc';
  vleParamsTask.Values[vleParamsTask.Keys[2]] := 'G:\_Загрузки';
end;

procedure TFrameTask.StopTaskThread;
begin
  if Assigned(FTaskAnonymousThread) then
  begin
    FTask.StopExecute;
    FTaskAnonymousThread.Resume;
    FreeAndNil(FTaskAnonymousThread);
  end;
end;

procedure TFrameTask.actStopExecute(Sender: TObject);
begin
  StopTaskThread
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
  FTaskAnonymousThread := nil;

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
  StopTaskThread;
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
