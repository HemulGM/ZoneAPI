unit Zona.API.Radio;

interface

uses
  Rest.Json, Rest.Json.Types;

type
  TZonaRadioStream = class
  private
    [JsonNameAttribute('b')]
    FB: Int64;
    [JsonNameAttribute('u')]
    FU: string;
  public
    property B: Int64 read FB write FB;
    property U: string read FU write FU;
  end;

  TZonaRadio = class
  private
    [JsonNameAttribute('preview')]
    FPreview: string;
    [JsonNameAttribute('itemId')]
    FItemId: string;
    [JsonNameAttribute('country')]
    FCountry: string;
    [JsonNameAttribute('streams')]
    FStreams: TArray<TZonaRadioStream>;
    [JsonNameAttribute('description')]
    FDescription: string;
    [JsonNameAttribute('title')]
    FTitle: string;
    [JsonNameAttribute('class')]
    FClass: string;
    [JsonNameAttribute('frequency')]
    FFrequency: string;
  public
    property Preview: string read FPreview write FPreview;
    property ItemId: string read FItemId write FItemId;
    property Country: string read FCountry write FCountry;
    property Streams: TArray<TZonaRadioStream> read FStreams write FStreams;
    property Description: string read FDescription write FDescription;
    property Title: string read FTitle write FTitle;
    property &Class: string read FClass write FClass;
    property Frequency: string read FFrequency write FFrequency;
    destructor Destroy; override;
  end;

implementation

{ TZonaRadio }

destructor TZonaRadio.Destroy;
begin
  for var Item in FStreams do
    Item.Free;
  inherited;
end;

end.

