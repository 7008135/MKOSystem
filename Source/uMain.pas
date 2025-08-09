{***********************************************
*  Unit Name   : uMain.pas
*  Description : Окно выполнения ассинхронных задач
*  Author      : Грицук Д.
*  Date        : Август 2025
************************************************}

unit uMain;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.Generics.Collections,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  uTaskApi, Vcl.ComCtrls,
  Vcl.ExtCtrls, Vcl.BaseImageCollection,
  Vcl.ImageCollection, System.ImageList, Vcl.ImgList, Vcl.VirtualImageList,
  Vcl.Buttons, System.Actions,
  Vcl.ActnList, Vcl.StdCtrls, Vcl.Menus, Vcl.Tabs,
  uFrameTask;

type
  TMain = class(TForm)
    tvPlugins: TTreeView;
    Panel1: TPanel;
    sbtnAddDll: TSpeedButton;
    VirtualImageList1: TVirtualImageList;
    ImageCollection1: TImageCollection;
    ActionList1: TActionList;
    actAddDll: TAction;
    sbtnRefreshList: TSpeedButton;
    actFindDllNextExecutableFile: TAction;
    Splitter1: TSplitter;
    StatusBar1: TStatusBar;
    Panel2: TPanel;
    pupTreeView: TPopupMenu;
    tsTasks: TTabSet;
    pnlTasks: TPanel;
    pupTabSet: TPopupMenu;
    miCloseTab: TMenuItem;
    procedure actAddDllExecute(Sender: TObject);
    procedure actFindDllNextExecutableFileExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tvPluginsDblClick(Sender: TObject);
    procedure miCloseTabClick(Sender: TObject);
    procedure tsTasksChange(Sender: TObject; NewTab: Integer;
      var AllowChange: Boolean);
    procedure actCloseTabExecute(Sender: TObject);
    procedure tsTasksMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    FPlugins: TList<IPluginModule>;
    FDLLHandles: TList<THandle>;
    FslListOfAddedPathDLL: TStringList;
    FTasksFrameCreated: Integer;
    procedure LoadPlugin(const ADllPath: String);
    procedure FindDllNextExecutableFile;
    procedure RefreshTree;
    procedure CreateTaskTab(const ATask: ITaskDefinition);
    procedure CloseTab(const X, Y: Integer);
  public
    { Public declarations }
  end;

var
  Main: TMain;

implementation

{$R *.dfm}

const
  DLL_EXT = '.dll';

procedure TMain.actAddDllExecute(Sender: TObject);
begin
  ;
end;

procedure TMain.actCloseTabExecute(Sender: TObject);
begin
  ;
end;

procedure TMain.actFindDllNextExecutableFileExecute(Sender: TObject);
begin
  FindDllNextExecutableFile;
  RefreshTree
end;

procedure TMain.RefreshTree;
const
  IMG_INDEX_DLL = 0;
  IMG_INDEX_FIRST_NODE = 2;
  IMG_INDEX_TASK = 3;

  NAME_FIRST_NODE = 'Список доступных функций';

  function AddParentNode(const AParent: TTreeNode;
    const ANameNode: String;
    const AImageIndex: Integer;
    const ATast: ITaskDefinition = nil): TTreeNode;
  begin
    Result := tvPlugins.Items.AddChild(AParent, ANameNode);
    Result.ImageIndex := AImageIndex;
    Result.SelectedIndex := AImageIndex;
    Result.Data := ATast;
  end;
var
  FirstNode: TTreeNode;
  PluginNode: TTreeNode;
begin
  tvPlugins.Items.Clear;
  try
    FirstNode := AddParentNode(nil, NAME_FIRST_NODE, IMG_INDEX_FIRST_NODE);

    for var Plugin in FPlugins do
    begin
      PluginNode := AddParentNode(FirstNode, Plugin.GetNameModule, IMG_INDEX_DLL);

      for var Task in Plugin.GetTasks do
        AddParentNode(PluginNode, Task.GetName, IMG_INDEX_TASK, Task);
    end;
  finally
    tvPlugins.FullExpand;
  end;
end;

procedure TMain.tsTasksChange(Sender: TObject; NewTab: Integer;
  var AllowChange: Boolean);
var
  ObjTab: TObject;
begin
  ObjTab := tsTasks.Tabs.Objects[NewTab];
  if Assigned(ObjTab) and (ObjTab is TFrame) then
    TFrame(ObjTab).BringToFront;
end;

procedure TMain.CloseTab(const X, Y: Integer);
var
  TabIndex: Integer;
  ObjTab: TObject;
begin
  TabIndex := tsTasks.ItemAtPos(Point(X, Y));
  if TabIndex >= 0 then
  try
    ObjTab := tsTasks.Tabs.Objects[TabIndex];
    if Assigned(ObjTab) then
      FreeAndNil(ObjTab);

    tsTasks.Tabs.Delete(TabIndex);
    if tsTasks.TabIndex >= tsTasks.Tabs.Count then
      tsTasks.TabIndex := tsTasks.Tabs.Count - 1;
  finally
    tsTasks.Refresh;
  end;
end;

procedure TMain.tsTasksMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbMiddle then
    CloseTab(X, Y);
end;

procedure TMain.tvPluginsDblClick(Sender: TObject);
var
  SelectedNode: TTreeNode;
  NodeData: Pointer;
  Task: ITaskDefinition;
begin
  if tvPlugins.Selected = nil then
    Exit;

  SelectedNode := tvPlugins.Selected;

  if SelectedNode.Data = nil then
    Exit;


  NodeData := SelectedNode.Data;
  if Supports(ITaskDefinition(NodeData), ITaskDefinition, Task) then
    CreateTaskTab(Task);
end;

procedure TMain.CreateTaskTab(const ATask: ITaskDefinition);
var
  TaskName: String;
  FrameTask: TFrameTask;
begin
  if Assigned(ATask) then
  try
    TaskName := ATask.GetName;
    FrameTask := TFrameTask.Create(Application,
      ATask, FTasksFrameCreated);
    FrameTask.Parent := pnlTasks;

    tsTasks.Tabs.AddObject(TaskName, FrameTask);
  finally
    tsTasks.TabIndex := tsTasks.Tabs.Count - 1;
    tsTasks.Refresh;
    inc(FTasksFrameCreated);
  end;
end;

procedure TMain.FindDllNextExecutableFile;
var
  SearchRec: TSearchRec;
  DirectoryExe: String;
begin
  DirectoryExe := ExtractFilePath(ParamStr(0));
  if FindFirst(DirectoryExe + '*' + DLL_EXT, faAnyFile, SearchRec) = 0 then
  try
    repeat
      LoadPlugin(DirectoryExe + SearchRec.Name)
    until FindNext(SearchRec) <> 0;
  finally
    FindClose(SearchRec);
  end;
end;

procedure TMain.FormCreate(Sender: TObject);
begin
  FPlugins := TList<IPluginModule>.Create;
  FDLLHandles := TList<THandle>.Create;
  FslListOfAddedPathDLL := TStringList.Create;
  FTasksFrameCreated := 0;

  {убрать}
  FindDllNextExecutableFile;
  RefreshTree
end;

procedure TMain.FormDestroy(Sender: TObject);
begin
  FPlugins.Free;
  FDLLHandles.Free;
end;


procedure TMain.FormShow(Sender: TObject);
begin
  tvPlugins.FullExpand
end;

procedure TMain.LoadPlugin(const ADllPath: String);
var
  hDLL: THandle;
  CreatePluginFunc: function: IPluginModule; stdcall;
  Plugin: IPluginModule;
begin
  if FileExists(ADllPath)
    and (ExtractFileExt(ADllPath) = DLL_EXT)
  then
  begin
    hDLL := LoadLibrary(PChar(ADllPath));
    if hDLL = 0 then
      Exit;

    @CreatePluginFunc := GetProcAddress(hDLL, CREATE_PLUGIN_MODULE_NAME);
    if not Assigned(CreatePluginFunc) then
    begin
      FreeLibrary(hDLL);
      Exit;
    end;

    Plugin := CreatePluginFunc();
    if not Assigned(Plugin) or not Plugin.Initialize then
    begin
      FreeLibrary(hDLL);
      Exit;
    end;

    FPlugins.Add(Plugin);
    FDLLHandles.Add(hDLL);
  end;
end;

procedure TMain.miCloseTabClick(Sender: TObject);
begin
  ;
end;

end.
