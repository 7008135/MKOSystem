{***********************************************
*  Unit Name   : ShellPerfomer.dll
*  Description : Поиска файлов по маске в указанной директории.
                 Поиска бинарных вхождений строки в файле.
*  Author      : Грицук Д.
*  Date        : Август 2025
*  Task       :
1. Функционал выполнения Shell-команды с отслеживанием процесса выполнения и
    завершения запуска (например, CLI архивирования файлов/папки). Вызывающая
    программа не должна зависать, при запуске продолжительной по времени выполнения
    команды.
************************************************}

library ShellPerfomer;

uses
  System.SysUtils,
  System.Classes,
  System.Generics.Collections,
  uTaskApi in 'Source\Core\uTaskApi.pas',
  uShellExecutingCommand in 'uShellExecutingCommand.pas';

type
  TShellPerfomer = class(TInterfacedObject, IPluginModule)
  private
    FTasks: TList<ITaskDefinition>;
    FNameModule: String;
  public
    constructor Create;
    destructor Destroy; override;

    function Initialize: Boolean;
    procedure Finalize;
    function GetTasks: TList<ITaskDefinition>;
    function GetNameModule: String;
    function GetClassType: TClass;
  end;

{$R *.res}

{ TShellPerfomer }

constructor TShellPerfomer.Create;
begin
  FNameModule := 'Shell утилиты';

  FTasks := TList<ITaskDefinition>.Create;
  FTasks.Add(TShellExecutingCommand.Create);
end;

destructor TShellPerfomer.Destroy;
begin
  Finalize;
  inherited;
end;

procedure TShellPerfomer.Finalize;
begin
  FreeAndNil(FTasks);
end;

function TShellPerfomer.GetClassType: TClass;
begin
  Result := ClassType;
end;

function TShellPerfomer.GetNameModule: String;
begin
  Result := FNameModule;
end;

function TShellPerfomer.GetTasks: TList<ITaskDefinition>;
begin
  Result := FTasks;
end;

function TShellPerfomer.Initialize: Boolean;
begin
  Result := True;
end;

function CreatePluginModule: IPluginModule; stdcall;
begin
  Result := TShellPerfomer.Create;
end;

exports
  CreatePluginModule;

begin
end.
