{***********************************************
*  Unit Name   : uDocParser.pas
*  Description : ������ 1. ������ ������ �� ����� � ��������� ����������.
*  Author      : ������ �.
*  Date        : ������ 2025
*  Task       :
1. ���������� ������ ������ ������ �� ����� � ��������� ����� ������.
  ��������� ��������� - ���������� ��������� ������, ��������, �������
  ���������: (�*.txt�, �P:\Documents\�).
  �������������:
    - ������� ������ ������ ����� ��������� ������.
    - ����������� ��������� ���� ������ ������ ��������� ��������� ����� ���
      ����������� �������� �������������� ��������� ������ �� ����������
      �����������.
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

    {BEGIN - ���������� ����������}
    function GetName: string;
    function GetDescription: string;
    function GetRequiredParams: TArray<TTaskDefinitionParam>;
    function Execute(const AParams: TTaskDefinitionParam): Boolean;
    {FINISH - ���������� ����������}
  end;

implementation

{ TDocParser }

constructor TDocParser.Create;
begin
  FName := '������ ������ �� ����� � ��������� ����������';
  FDescription := '���������� ������ ������ ������ �� ����� � ��������� ����� ������. '+
    '��������� ��������� - ���������� ��������� ������, ��������, ������� '+
    '���������: (�*.txt�, �P:\Documents\�)';
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
    MakeParam('FileMasks', '����� ������', '���� ��� ��������� ����� ����� �������, ������: *.txt,*.doc'),
    MakeParam('SearchPath', '���� ��� ������', '�������� ����� ��� ������ ������')
  ];
end;

end.
