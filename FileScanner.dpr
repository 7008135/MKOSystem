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
    FTasks: TArray<ITaskDefinition>;
  public
    constructor Create;
    destructor Destroy; override;

    function Initialize: Boolean;
    procedure Finalize;
    function GetTasks: TList<ITaskDefinition>;
  end;


{ TFileScanner }

constructor TFileScanner.Create;
begin

end;

destructor TFileScanner.Destroy;
begin

  inherited;
end;

procedure TFileScanner.Finalize;
begin

end;

function TFileScanner.GetTasks: TList<ITaskDefinition>;
begin

end;

function TFileScanner.Initialize: Boolean;
begin

end;

begin
end.
