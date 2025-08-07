{***********************************************
*  Unit Name   : uDocParser.pas
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

constructor TBinaryPatternParser.Create;
begin
  FName := 'Поиска вхождений последовательности символов в файле';
  FDescription := 'Количество найденных вхождений. Например, (“libsec”, '+
    '“p:\Dumps\BigFile.bin”). Здесь “libsec”- однобайтовые символы, поиск в бинарном '+
    'файле.';
end;

destructor TBinaryPatternParser.Destroy;
begin

  inherited;
end;

function TBinaryPatternParser.Execute(const AParams: TTaskDefinitionParam): Boolean;
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
    MakeParam('FileMasks', 'Маски файлов', 'Одна или несколько масок через запятую, пример: *.txt,*.doc'),
    MakeParam('SearchPath', 'Путь для поиска', 'Корневая папка для поиска файлов')
  ];
end;

end.
