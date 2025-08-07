{***********************************************
*  Unit Name   : uDocParser.pas
*  Description : «адача 2. ‘ункционал поиска вхождений последовательности символов в файле (в этой-же.dll).
*  Author      : √рицук ƒ.
*  Date        : јвгуст 2025
*  Task       :
2. ‘ункционал поиска вхождений последовательности символов в файле (в этой-же
  .dll).
  ќжидаемый результат - количество найденных вхождений. Ќапример, (УlibsecФ,
  Уp:\Dumps\BigFile.binФ). «десь УlibsecФ- однобайтовые символы, поиск в бинарном
  файле.
  ƒополнительно:
    - возможность поиска одновременно нескольких последовательностей
      символов (УlibsecФ, УbinsecФ).
    - возврат списка позиций найденных вхождений дл€ каждого из искомых слов.
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

    {BEGIN - –еализаци€ интерфейса}
    function GetName: string;
    function GetDescription: string;
    function GetRequiredParams: TArray<TTaskDefinitionParam>;
    function Execute(const AParams: TTaskDefinitionParam): Boolean;
    {FINISH - –еализаци€ интерфейса}
  end;

implementation

{ TDocParser }

constructor TBinaryPatternParser.Create;
begin
  FName := 'ѕоиска вхождений последовательности символов в файле';
  FDescription := ' оличество найденных вхождений. Ќапример, (УlibsecФ, '+
    'Уp:\Dumps\BigFile.binФ). «десь УlibsecФ- однобайтовые символы, поиск в бинарном '+
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
    MakeParam('FileMasks', 'ћаски файлов', 'ќдна или несколько масок через зап€тую, пример: *.txt,*.doc'),
    MakeParam('SearchPath', 'ѕуть дл€ поиска', ' орнева€ папка дл€ поиска файлов')
  ];
end;

end.
