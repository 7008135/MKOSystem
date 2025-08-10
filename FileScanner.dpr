{***********************************************
*  Unit Name   : FileScannenr.dll
*  Description : Поиска файлов по маске в указанной директории.
                 Поиска бинарных вхождений строки в файле.
*  Author      : Грицук Д.
*  Date        : Август 2025
*  Tasks       :
1. Функционал поиска списка файлов по маске и стартовой папке поиска.
  Ожидаемый результат - количество найденных файлов, например, входные
  параметры: (“*.txt”, “P:\Documents\”).
  Дополнительно:
    - возврат списка полных путей найденных файлов.
    - возможность запустить одну задачу поиска передавая несколько масок или
    - возможность добавить дополнительные параметры поиска на усмотрение
      исполнителя.
2. Функционал поиска вхождений последовательности символов в файле (в этой-же
  .dll).
  Ожидаемый результат - количество найденных вхождений. Например, (“libsec”,
  “p:\Dumps\BigFile.bin”). Здесь “libsec”- однобайтовые символы, поиск в бинарном
  файле.
  Дополнительно:
    - возможность поиска одновременно нескольких последовательностей
      символов (“libsec”, “binsec”).
    - возврат списка позиций найденных вхождений для каждого из искомых слов.
************************************************}

library FileScanner;

uses
  System.SysUtils,
  System.Classes,
  System.Generics.Collections,
  uTaskApi in 'Source\Core\uTaskApi.pas',
  uDocParser in 'Source\dll\uDocParser.pas',
  uBinaryPatternParser in 'Source\dll\uBinaryPatternParser.pas';

{$R *.res}

type
  TFileScanner = class(TInterfacedObject, IPluginModule)
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

{ TFileScanner }

constructor TFileScanner.Create;
begin
  FNameModule := 'Сканер файлов';

  FTasks := TList<ITaskDefinition>.Create;
  FTasks.Add(TDocParser.Create);
  FTasks.Add(TBinaryPatternParser.Create);
end;

destructor TFileScanner.Destroy;
begin
  Finalize;
  inherited;
end;

procedure TFileScanner.Finalize;
begin
  FreeAndNil(FTasks);
end;

function TFileScanner.GetClassType: TClass;
begin
  Result := ClassType;
end;

function TFileScanner.GetNameModule: String;
begin
  Result := FNameModule;
end;

function TFileScanner.GetTasks: TList<ITaskDefinition>;
begin
  Result := FTasks;
end;

function TFileScanner.Initialize: Boolean;
begin
  Result := True;
end;

function CreatePluginModule: IPluginModule; stdcall;
begin
  Result := TFileScanner.Create;
end;

exports
  CreatePluginModule;

begin
end.
