{***********************************************
*  Unit Name   : uTaskApi.pas
*  Description : ��������� ������ � dll
*  Author      : ������ �.
*  Date        : ������ 2025
************************************************}

unit uTaskApi;

interface

uses
  SysUtils,
  Classes;

type
  TTaskDefinitionParam = record
    Param: String;
    NameParam: string;
    DescriptionParam: string;
  end;

  ITaskDefinition = interface
    ['{70363433-EFD4-4560-916D-FBA3BF75BAA5}']

    function GetName: String;
    function GetDescription: String;
    function GetRequiredParams: TArray<TTaskDefinitionParam>;
    function Execute(const AParams: TTaskDefinitionParam): Boolean;
  end;

  IPluginModule = interface
    ['{F10C4C58-A16B-4955-A45C-B3BC7E2B6432}']

    function Initialize: Boolean;
    procedure Finalize;
    function GetTasks: TArray<ITaskDefinition>;
  end;

/// <summary>
/// ��������� ������ TTaskDefinitionParam ��������� ����������
/// </summary>
/// <param name="AParam">
///   ���������� ������������� ��������� (��������, 'SearchPath')
/// </param>
/// <param name="ANameParam">
///   ������������ ��� ��������� (��������, '���� ��� ������')
/// </param>
/// <param name="ADescriptionParam">
///   ��������� �������� ���������� ���������
/// </param>
/// <returns>
///   ������� ������ TTaskDefinitionParam � ������������ ������
/// </returns>
/// <remarks>
/// ��������������� ������� ��� ��������� �������� ���������� �����.
/// </remarks>
function MakeParam(const AParam, ANameParam,
  ADescriptionParam: string): TTaskDefinitionParam;

implementation

function MakeParam(const AParam, ANameParam,
  ADescriptionParam: string): TTaskDefinitionParam;
begin
  Result.Param := AParam;
  Result.NameParam := ANameParam;
  Result.DescriptionParam := ADescriptionParam;
end;

end.
