unit Zone.API.Genre;

interface

uses
  Rest.Json, Rest.Json.Types, Zone.API.Base;

type
  TZoneGenre = class(TZoneObject)
  private
    [JsonNameAttribute('ord')]
    FOrd: Integer;
    [JsonNameAttribute('custom')]
    FCustom: Boolean;
    [JsonNameAttribute('name')]
    FName: string;
    [JsonNameAttribute('fictional')]
    FFictional: Boolean;
    [JsonNameAttribute('id')]
    FId: string;
    [JsonNameAttribute('adult')]
    FAdult: Boolean;
  public
    property Ord: Integer read FOrd write FOrd;
    property Custom: Boolean read FCustom write FCustom;
    property Name: string read FName write FName;
    property Fictional: Boolean read FFictional write FFictional;
    property Id: string read FId write FId;
    property Adult: Boolean read FAdult write FAdult;
  end;

implementation

end.
