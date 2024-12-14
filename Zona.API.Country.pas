unit Zona.API.Country;

interface

uses
  Rest.Json, Rest.Json.Types, Zona.API.Base;

type
  TZonaCountry = class(TZonaObject)
  private
    [JsonName('name')]
    FName: string;
  public
    property Name: string read FName write FName;
  end;

implementation

end.

