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
  Math,
  uTaskApi;

type
  TBinaryPatternParser = class(TTaskDefinition, ITaskDefinition)
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

{ TDocParser }

const
  NAME_PARAM_CHARACTERS = 'Characters';
  NAME_PARAM_PATH = 'ScanFilePath';

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

function TBinaryPatternParser.Execute(const AParams: TArray<TTaskDefinitionParam>;
  var AResultMsg: String;
  const PResultStrings: PStrings): Boolean;

  procedure FindSequencesInFile(const ACharacters, AScanFilePath: string;
    Results: PStrings);
  var
    F: TFileStream;
    Buffer: array of Byte;
    BufferSize, BytesRead: Integer;
    i, k, seqIdx: Integer;
    FilePos: Int64;
    MaxSeqLen: Integer;
    Matched: Boolean;
    Sequences, TempResults: TStringList;
    CurrentSeq: string;
  begin
    if not Assigned(Results) then
      Exit;

    Results.Clear;

    Sequences := TStringList.Create;
    TempResults := TStringList.Create;
    try
      if FStopExecute then
        Exit;
      Sequences.Delimiter := ' ';
      Sequences.StrictDelimiter := True;
      Sequences.DelimitedText := Trim(ACharacters);

      if Sequences.Count = 0 then
        Exit;

      if FStopExecute then
        Exit;

      MaxSeqLen := 0;
      for i := 0 to Sequences.Count - 1 do
        if Length(Sequences[i]) > MaxSeqLen then
          MaxSeqLen := Length(Sequences[i]);

      if FStopExecute then
        Exit;

      if MaxSeqLen = 0 then
        Exit;

      if FStopExecute then
        Exit;

      for i := 0 to Sequences.Count - 1 do
        TempResults.AddObject(Sequences[i], TStringList.Create);

      BufferSize := Max(1024 * 1024, MaxSeqLen * 10);
      SetLength(Buffer, BufferSize + MaxSeqLen - 1);

      F := TFileStream.Create(AScanFilePath, fmOpenRead or fmShareDenyNone);
      try
        FilePos := 0;
        while FilePos < F.Size do
        begin
          if FStopExecute then
            Exit;
          BytesRead := F.Read(Buffer[0], BufferSize);

          for i := 0 to BytesRead - 1 do
          begin
            if FStopExecute then
              Exit;
            for seqIdx := 0 to Sequences.Count - 1 do
            begin
              if FStopExecute then
                Exit;
              CurrentSeq := Sequences[seqIdx];

              if (i + Length(CurrentSeq)) > (BytesRead + MaxSeqLen - 1) then
                Continue;

              Matched := True;
              for k := 1 to Length(CurrentSeq) do
              begin
                if FStopExecute then
                  Exit;
                if Buffer[i + k - 1] <> Byte(CurrentSeq[k]) then
                begin
                  Matched := False;
                  Break;
                end;
              end;

              if Matched then
                (TempResults.Objects[seqIdx] as TStringList).Add(IntToStr(FilePos + i));
            end;
          end;

          FilePos := FilePos + BytesRead - MaxSeqLen + 1;
          if FilePos < F.Size then
            F.Position := FilePos;
        end;
      finally
        F.Free;
      end;

      if FStopExecute then
        Exit;
      for i := 0 to TempResults.Count - 1 do
      begin
        if FStopExecute then
          Exit;
        Results.Add(Format('%s: found %d times', [TempResults[i],
          (TempResults.Objects[i] as TStringList).Count]));

        if (TempResults.Objects[i] as TStringList).Count > 0 then
        begin
          Results.Add('  Positions: ' + (TempResults.Objects[i] as TStringList).CommaText);
        end;
      end;
    finally
      for i := 0 to TempResults.Count - 1 do
        TempResults.Objects[i].Free;
      TempResults.Free;
      Sequences.Free;
    end;
  end;

  function CheckParams: Boolean;
  begin
    Result := True;
    for var Index := Low(AParams) to High(AParams) do
      if Trim(AParams[Index].Value) = '' then
        Exit(False);
  end;

  procedure FillData(var ACharacters, AScanFilePath: String);
  begin
    for var Index := Low(AParams) to High(AParams) do
      if AParams[Index].Param = NAME_PARAM_CHARACTERS then
        ACharacters := AParams[Index].Value
      else if AParams[Index].Param = NAME_PARAM_PATH then
        AScanFilePath := AParams[Index].Value
  end;
const
  MSG_NOT_ACCESS = 'Отказано в действии. ';
var
  Characters, ScanFilePath: String;
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

    FillData(Characters, ScanFilePath);
    if not FileExists(ScanFilePath) then
    begin
      AResultMsg := MSG_NOT_ACCESS + 'По указанному пути файл отсутствует!';
      Exit;
    end;

    FindSequencesInFile(Characters, ScanFilePath, PResultStrings);
  finally
    FStopExecute := False;
  end;
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
    MakeParam('Characters', 'Последовательность символов', 'Последовательность символов через пробел: libsec binsec'),
    MakeParam('ScanFilePath', 'Путь к BIN', 'Путь к бинарному файлу: G:\_Загрузки\Test.bin')
  ];
end;

end.
