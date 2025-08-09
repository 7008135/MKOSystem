{***********************************************
*  Unit Name   : uDocParser.pas
*  Description : Задача 1. Поиска файлов по маске в указанной директории.
*  Author      : Грицук Д.
*  Date        : Август 2025
*  Task       :
1. Функционал поиска списка файлов по маске и стартовой папке поиска.
  Ожидаемый результат - количество найденных файлов, например, входные
  параметры: (“*.txt”, “P:\Documents\”).
  Дополнительно:
    - возврат списка полных путей найденных файлов.
    - возможность запустить одну задачу поиска передавая несколько масок или
      возможность добавить дополнительные параметры поиска на усмотрение
      исполнителя.
************************************************}

unit uDocParser;

interface

uses
  System.SysUtils,
  System.Classes,
  System.IOUtils, 
  System.Types,
  System.Masks,
  uTaskApi;

type
  TDocParser = class(TInterfacedObject, ITaskDefinition)
  private
    FName: String;
    FDescription: String;
    FStopExecute: Boolean;
  public
    constructor Create;
    destructor Destroy; override;

    {BEGIN - Реализация интерфейса}
    function GetName: string;
    function GetDescription: string;
    function GetRequiredParams: TArray<TTaskDefinitionParam>;
    function Execute(const AParams: TArray<TTaskDefinitionParam>; var AResultMsg: String): Boolean;
    procedure StopExecute;
    {FINISH - Реализация интерфейса}
  end;

implementation

{ TDocParser }

const
  NAME_PARAM_MASKS = 'FileMasks';
  NAME_PARAM_PATH = 'SearchPath';

constructor TDocParser.Create;
begin
  FName := 'Поиска файлов по маске в указанной директории';
  FDescription := 'Функционал поиска списка файлов по маске и стартовой папке поиска. '+
    'Ожидаемый результат - количество найденных файлов, например, входные '+
    'параметры: (“*.txt”, “P:\Documents\”)';
  FStopExecute := False;
end;

destructor TDocParser.Destroy;
begin

  inherited;
end;

function TDocParser.Execute(const AParams: TArray<TTaskDefinitionParam>; var AResultMsg: String): Boolean;
  function CheckParams: Boolean;
  begin
    Result := True;
    for var Index := Low(AParams) to High(AParams) do
      if Trim(AParams[Index].Value) = '' then
        Exit(False);
  end;

  procedure FillData(var AFileMask, ASearchPath: String);
  begin
    for var Index := Low(AParams) to High(AParams) do
      if AParams[Index].Param = NAME_PARAM_MASKS then
        AFileMask := AParams[Index].Value
      else if AParams[Index].Param = NAME_PARAM_PATH then
        ASearchPath := AParams[Index].Value
  end;

  procedure FindFilesByMasks(const ARootFolder, 
    AFileMasks: string; AListFoundFiles: TStringList);
  var
    Masks: TStringList;
    Mask: string;
    Files: TStringDynArray;
  begin
    AListFoundFiles.BeginUpdate;
    try
      AListFoundFiles.Clear;
      Masks := TStringList.Create;
      try
        Masks.Delimiter := ',';
        Masks.StrictDelimiter := True; 
        Masks.DelimitedText := AFileMasks;

        for Mask in Masks do
        begin
          Files := TDirectory.GetFiles(ARootFolder, Trim(Mask), TSearchOption.soAllDirectories);
          AListFoundFiles.AddStrings(Files);
        end;
      finally
        Masks.Free;
      end;

      AListFoundFiles.Duplicates := dupIgnore;
      AListFoundFiles.Sort;
    finally
      AListFoundFiles.EndUpdate;
    end;
  end;

const
  MSG_NOT_ACCESS = 'Отказано в действии. ';
var
  FileMasks, SearchPath: String;
  ListFoundFiles: TStringList;
begin
  Result := False;
  AResultMsg := '';

  if not CheckParams then
  begin
    AResultMsg := MSG_NOT_ACCESS + 'Заполните все свойства значениями!';
    Exit;
  end;

  FillData(FileMasks, SearchPath);
  if not DirectoryExists(SearchPath) then
  begin
    AResultMsg := MSG_NOT_ACCESS + 'Указанного путя поиска не существует!';
    Exit;
  end;
  
  ListFoundFiles := TStringList.Create;
  FindFilesByMasks(SearchPath, FileMasks, ListFoundFiles); 


end;

function TDocParser.GetDescription: string;
begin
  Result := FDescription;
end;

function TDocParser.GetName: string;
begin
  Result := FName;
end;

function TDocParser.GetRequiredParams: TArray<TTaskDefinitionParam>;
begin
  Result := [
    MakeParam(NAME_PARAM_MASKS, 'Маски файлов', 'Одна или несколько масок через запятую, пример: *.txt,*.doc'),
    MakeParam(NAME_PARAM_PATH, 'Путь для поиска', 'Корневая папка для поиска файлов')
  ];
end;

procedure TDocParser.StopExecute;
begin
  FStopExecute := True;
end;

end.
