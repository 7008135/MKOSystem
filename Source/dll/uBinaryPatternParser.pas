{***********************************************
*  Unit Name   : uDocParser.pas
*  Description : ������ 2. ���������� ������ ��������� ������������������ �������� � ����� (� ����-��.dll).
*  Author      : ������ �.
*  Date        : ������ 2025
*  Task       :
2. ���������� ������ ��������� ������������������ �������� � ����� (� ����-��
  .dll).
  ��������� ��������� - ���������� ��������� ���������. ��������, (�libsec�,
  �p:\Dumps\BigFile.bin�). ����� �libsec�- ������������ �������, ����� � ��������
  �����.
  �������������:
    - ����������� ������ ������������ ���������� �������������������
      �������� (�libsec�, �binsec�).
    - ������� ������ ������� ��������� ��������� ��� ������� �� ������� ����.
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

    {BEGIN - ���������� ����������}
    function GetName: string;
    function GetDescription: string;
    function GetRequiredParams: TArray<TTaskDefinitionParam>;
    function Execute(const AParams: TTaskDefinitionParam): Boolean;
    {FINISH - ���������� ����������}
  end;

implementation

{ TDocParser }

constructor TBinaryPatternParser.Create;
begin
  FName := '������ ��������� ������������������ �������� � �����';
  FDescription := '���������� ��������� ���������. ��������, (�libsec�, '+
    '�p:\Dumps\BigFile.bin�). ����� �libsec�- ������������ �������, ����� � �������� '+
    '�����.';
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
    MakeParam('FileMasks', '����� ������', '���� ��� ��������� ����� ����� �������, ������: *.txt,*.doc'),
    MakeParam('SearchPath', '���� ��� ������', '�������� ����� ��� ������ ������')
  ];
end;

end.
