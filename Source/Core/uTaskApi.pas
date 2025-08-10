{***********************************************
*  Unit Name   : uTaskApi.pas
*  Description : Интерфейс задачи и dll
*  Author      : Грицук Д.
*  Date        : Август 2025
************************************************}

unit uTaskApi;

interface

uses
  SysUtils,
  Classes,
  System.Generics.Collections;

const
  CREATE_PLUGIN_MODULE_NAME = 'CreatePluginModule';

type
  PStrings = ^TStrings;

  TTaskDefinitionParam = record
    Param: String;
    NameParam: string;
    DescriptionParam: string;
    Value: Variant;
  end;

  ITaskDefinition = interface
    ['{70363433-EFD4-4560-916D-FBA3BF75BAA5}']
    function GetName: String;
    function GetDescription: String;
    function GetRequiredParams: TArray<TTaskDefinitionParam>;
    function Execute(const AParams: TArray<TTaskDefinitionParam>;
      var AResultMsg: String;
      const PResultStrings: PStrings): Boolean;
    procedure StopExecute;
  end;

  IPluginModule = interface
    ['{F10C4C58-A16B-4955-A45C-B3BC7E2B6432}']

    function Initialize: Boolean;
    procedure Finalize;
    function GetTasks: TList<ITaskDefinition>;
    function GetNameModule: String;
  end;

type
  TTaskDefinition = class(TInterfacedObject)
  protected
    FStopExecute: Boolean;
    FName: String;
    FDescription: String;
  public
    procedure StopExecute;
    constructor Create;
  end;

/// <summary>
/// Заполняет запись TTaskDefinitionParam заданными значениями
/// </summary>
/// <param name="AParam">
///   Уникальный идентификатор параметра (например, 'SearchPath')
/// </param>
/// <param name="ANameParam">
///   Отображаемое имя параметра (например, 'Путь для поиска')
/// </param>
/// <param name="ADescriptionParam">
///   Подробное описание назначения параметра
/// </param>
/// <returns>
///   Готовая запись TTaskDefinitionParam с заполненными полями
/// </returns>
/// <remarks>
/// Вспомогательная функция для упрощения создания параметров задач.
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
  Result.Value := '';
end;

{ TTaskDefinition }

constructor TTaskDefinition.Create;
begin
  FStopExecute := False;
end;

procedure TTaskDefinition.StopExecute;
begin
  FStopExecute := True;
end;

end.
