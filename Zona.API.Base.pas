unit Zona.API.Base;

interface

uses
  Rest.Json, Rest.Json.Types;

type
  TZonaObject = class
  private
    [JsonName('id')]
    FId: string;
  public
    property Id: string read FId write FId;
  end;

implementation

end.

