unit Zona.API.Person;

interface

uses
  Rest.Json, Rest.Json.Types, Zona.API.Base;

type
  TZonaPerson = class
  private
    [JsonNameAttribute('o')]
    FO: Integer;
    [JsonNameAttribute('r')]
    FRole: Integer;
    [JsonNameAttribute('i')]
    FId: Int64;
    [JsonNameAttribute('name')]
    FName: string;
    [JsonNameAttribute('name_eng')]
    FNameEng: string;
  public
    property O: Integer read FO write FO;
    property Role: Integer read FRole write FRole;
    property Id: Int64 read FId write FId;
    property Name: string read FName write FName;
    property NameEng: string read FNameEng write FNameEng;
  end;

  TZonaPersons = class
  private
    [JsonNameAttribute('items')]
    FItems: TArray<TZonaPerson>;
  public
    property Items: TArray<TZonaPerson> read FItems write FItems;
    destructor Destroy; override;
  end;

implementation

{ TZonaPersons }

destructor TZonaPersons.Destroy;
begin
  for var Item in FItems do
    Item.Free;
  inherited;
end;

end.

