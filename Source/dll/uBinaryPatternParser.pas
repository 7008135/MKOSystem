{***********************************************
*  Unit Name   : uBinaryPatternParser.pas
*  Description : Задача 2. Функционал поиска вхождений последовательности символов в файле (в этой-же.dll).
*  Author      : Грицук Д.
*  Date        : Август 2025
*  Task       :
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

unit uBinaryPatternParser;

interface

uses
  System.SysUtils,
  System.Classes,
  uTaskApi;

type
  TBinaryPatternParser = class(TInterfacedObject, ITaskDefinition)
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

constructor TBinaryPatternParser.Create;
begin
  FName := 'Поиска вхождений последовательности символов в файле';
  FDescription := 'Количество найденных вхождений. Например, (“libsec”, '+
    '“p:\Dumps\BigFile.bin”). Здесь “libsec”- однобайтовые символы, поиск в бинарном '+
    'файле.';
  FStopExecute := False;
end;

destructor TBinaryPatternParser.Destroy;
begin

  inherited;
end;

function TBinaryPatternParser.Execute(const AParams: TArray<TTaskDefinitionParam>; var AResultMsg: String): Boolean;
begin

end;

function TBinaryPatternParser.GetDescription: string;
begin
  Result := FDescription;
end;

function TBinaryPatternParser.GetName: string;
begin
  Result := FName;
end;

function TBinaryPatternParser.GetRequiredParams: TArray<TTaskDefinitionParam>;
begin
  Result := [
    MakeParam('Characters', 'Последовательность символов', 'Последовательность символов через запятую: libsec,f,a'),
    MakeParam('ScanFilePath', 'Путь к BIN', 'Путь к бинарному файлу: G:\_Загрузки\Test.bin')
  ];
end;

procedure TBinaryPatternParser.StopExecute;
begin
  FStopExecute := True;
end;

end.
