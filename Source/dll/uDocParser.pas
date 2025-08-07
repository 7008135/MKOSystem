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
  uTaskApi;

type
  TDocParser = class(TInterfacedObject, ITaskDefinition)
  private
    FName: String;
    FDescription: String;

  public
    constructor Create;
    destructor Destroy; override;

    {BEGIN - Реализация интерфейса}
    function GetName: string;
    function GetDescription: string;
    function GetRequiredParams: TArray<TTaskDefinitionParam>;
    function Execute(const AParams: TTaskDefinitionParam): Boolean;
    {FINISH - Реализация интерфейса}
  end;

implementation

{ TDocParser }

constructor TDocParser.Create;
begin
  FName := 'Поиска файлов по маске в указанной директории';
  FDescription := 'Функционал поиска списка файлов по маске и стартовой папке поиска. '+
    'Ожидаемый результат - количество найденных файлов, например, входные '+
    'параметры: (“*.txt”, “P:\Documents\”)';
end;

destructor TDocParser.Destroy;
begin

  inherited;
end;

function TDocParser.Execute(const AParams: TTaskDefinitionParam): Boolean;
begin

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
    MakeParam('FileMasks', 'Маски файлов', 'Одна или несколько масок через запятую, пример: *.txt,*.doc'),
    MakeParam('SearchPath', 'Путь для поиска', 'Корневая папка для поиска файлов')
  ];
end;

end.
