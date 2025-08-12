{***********************************************
*  Unit Name   : uShellExecutingCommand.pas
*  Description : Задача 1.
*  Author      : Грицук Д.
*  Date        : Август 2025
*  Task       :
  1. Функционал выполнения Shell-команды с отслеживанием процесса выполнения и
    завершения запуска (например, CLI архивирования файлов/папки). Вызывающая
    программа не должна зависать, при запуске продолжительной по времени выполнения
    команды.
************************************************}

unit uShellExecutingCommand;

interface

uses
  Windows,
  System.SysUtils,
  System.Classes,
  uTaskApi;

type
  TShellExecutingCommand = class(TTaskDefinition, ITaskDefinition)
  public
    constructor Create;
    destructor Destroy; override;

    {BEGIN - Реализация интерфейса}
    function GetName: string;
    function GetDescription: string;
    function GetRequiredParams: TArray<TTaskDefinitionParam>;
    function Execute(const AParams: TArray<TTaskDefinitionParam>;
      var AResultMsg: String;
      const PResultStrings: PStrings): Boolean;
    {FINISH - Реализация интерфейса}
  end;

implementation

const
  NAME_PARAM_COMMAND = 'Command';

{ TShellExecutingCommand }

constructor TShellExecutingCommand.Create;
begin
  FName := 'Выполнения Shell-команды';
  FDescription := '';
end;

destructor TShellExecutingCommand.Destroy;
begin

  inherited;
end;

function TShellExecutingCommand.Execute(
  const AParams: TArray<TTaskDefinitionParam>; var AResultMsg: String;
  const PResultStrings: PStrings): Boolean;

  function ExecuteCmdAndGetOutput(const Command: string): string;
  const
    BUFSIZE = 4096;
  var
    Security: TSecurityAttributes;
    ReadPipe, WritePipe: THandle;
    StartupInfo: TStartupInfo;
    ProcessInfo: TProcessInformation;
    Buffer: array[0..BUFSIZE] of AnsiChar;
    BytesRead: DWORD;
    TotalBytes: string;
  begin
    Result := '';

    // Настраиваем каналы (pipes) для чтения вывода
    Security.nLength := SizeOf(TSecurityAttributes);
    Security.bInheritHandle := True;
    Security.lpSecurityDescriptor := nil;

    if not CreatePipe(ReadPipe, WritePipe, @Security, 0) then
      Exit;

    try
      // Настраиваем процесс
      ZeroMemory(@StartupInfo, SizeOf(StartupInfo));
      StartupInfo.cb := SizeOf(StartupInfo);
      StartupInfo.dwFlags := STARTF_USESHOWWINDOW or STARTF_USESTDHANDLES;
      StartupInfo.wShowWindow := SW_HIDE;
      StartupInfo.hStdOutput := WritePipe;
      StartupInfo.hStdError := WritePipe;

      // Запускаем cmd.exe с командой
      if CreateProcess(
        nil,
        PChar('cmd.exe /c ' + Command),
        nil,
        nil,
        True,
        0,
        nil,
        nil,
        StartupInfo,
        ProcessInfo
      ) then
      begin
        CloseHandle(WritePipe);  // Закрываем записывающий конец канала

        // Читаем вывод
        while ReadFile(ReadPipe, Buffer, BUFSIZE, BytesRead, nil) and (BytesRead > 0) do
        begin
          SetString(TotalBytes, Buffer, BytesRead);
          Result := Result + TotalBytes;
        end;

        // Ждём завершения процесса
        WaitForSingleObject(ProcessInfo.hProcess, INFINITE);
        CloseHandle(ProcessInfo.hProcess);
        CloseHandle(ProcessInfo.hThread);
      end;
    finally
      CloseHandle(ReadPipe);
    end;
  end;

  function CheckParams: Boolean;
  begin
    Result := True;
    for var Index := Low(AParams) to High(AParams) do
      if Trim(AParams[Index].Value) = '' then
        Exit(False);
  end;

  procedure FillData(var ACommand: String);
  begin
    for var Index := Low(AParams) to High(AParams) do
      if AParams[Index].Param = NAME_PARAM_COMMAND then
        ACommand := AParams[Index].Value
  end;
const
  MSG_NOT_ACCESS = 'Отказано в действии. ';
var
  Command: String;
begin
  Result := False;
  AResultMsg := '';
  try
    if not Assigned(PResultStrings) then
    begin
      AResultMsg := MSG_NOT_ACCESS + 'Не указан ресурс результата!';
      Exit;
    end;

    if not CheckParams then
    begin
      AResultMsg := MSG_NOT_ACCESS + 'Заполните все свойства значениями!';
      Exit;
    end;

    FillData(Command);

    PResultStrings.Add(Format('CMD: %s - %s', [DateTimeToStr(Now), Command]));
    PResultStrings.Add(
     Format('RESULT: %s - %s', [DateTimeToStr(Now),
       ExecuteCmdAndGetOutput(Command)]))
  finally
    FStopExecute := False;
  end;
end;

function TShellExecutingCommand.GetDescription: string;
begin
  Result := FDescription;
end;

function TShellExecutingCommand.GetName: string;
begin
  Result := FName;
end;

function TShellExecutingCommand.GetRequiredParams: TArray<TTaskDefinitionParam>;
begin
  Result := [
    MakeParam(NAME_PARAM_COMMAND, 'Shell команда', 'Shell команды: cp file1.txt ./backups/; rmdir -p Projects/my_first_project и многие другие')
  ];
end;

end.
