unit Zone.API.Movie;

interface

uses
  Rest.Json, Rest.Json.Types, Zone.API.Base;

type
  TZoneMovie = class(TZoneObject)
  private
    [JsonNameAttribute('type3d')]
    FType3d: Integer;
    [JsonNameAttribute('year')]
    FYear: Integer;
    [JsonNameAttribute('name_original')]
    FNameOriginal: string;
    [JsonNameAttribute('rating')]
    FRating: Extended;
    [JsonNameAttribute('genre2')]
    FGenre2: string;
    [JsonNameAttribute('playable')]
    FPlayable: Boolean;
    [JsonNameAttribute('id')]
    FId: string;
    [JsonNameAttribute('episodes')]
    FEpisodes: string;
    [JsonNameAttribute('indexed')]
    FIndexed: Integer;
    [JsonNameAttribute('serial_end_year')]
    FSerialEndYear: Integer;
    [JsonNameAttribute('runtime')]
    FRuntime: Integer;
    [JsonNameAttribute('quality')]
    FQuality: Integer;
    [JsonNameAttribute('serial_ended')]
    FSerialEnded: Boolean;
    [JsonNameAttribute('audio_quality')]
    FAudioQuality: Integer;
    [JsonNameAttribute('abuse')]
    FAbuse: string;
    [JsonNameAttribute('tor_count')]
    FTorCount: Integer;
    [JsonNameAttribute('trailer')]
    FTrailer: Boolean;
    [JsonNameAttribute('name_rus')]
    FNameRus: string;
    [JsonNameAttribute('serial')]
    FSerial: Boolean;
    [JsonNameAttribute('name_eng')]
    FNameEng: string;
    [JsonNameAttribute('release_date_rus')]
    FReleaseDateRus: TDateTime;
    [JsonNameAttribute('release_date_int')]
    FReleaseDateInt: TDateTime;
  public
    property Type3d: Integer read FType3d write FType3d;
    property Year: Integer read FYear write FYear;
    property NameOriginal: string read FNameOriginal write FNameOriginal;
    property Rating: Extended read FRating write FRating;
    property Genre2: string read FGenre2 write FGenre2;
    property Playable: Boolean read FPlayable write FPlayable;
    property Id: string read FId write FId;
    property Episodes: string read FEpisodes write FEpisodes;
    property Indexed: Integer read FIndexed write FIndexed;
    property SerialEndYear: Integer read FSerialEndYear write FSerialEndYear;
    property Runtime: Integer read FRuntime write FRuntime;
    property Quality: Integer read FQuality write FQuality;
    property SerialEnded: Boolean read FSerialEnded write FSerialEnded;
    property AudioQuality: Integer read FAudioQuality write FAudioQuality;
    property Abuse: string read FAbuse write FAbuse;
    property TorCount: Integer read FTorCount write FTorCount;
    property Trailer: Boolean read FTrailer write FTrailer;
    property NameRus: string read FNameRus write FNameRus;
    property Serial: Boolean read FSerial write FSerial;
    property NameEng: string read FNameEng write FNameEng;
    property ReleaseDateRus: TDateTime read FReleaseDateRus write FReleaseDateRus;
    property ReleaseDateInt: TDateTime read FReleaseDateInt write FReleaseDateInt;
  end;

implementation

end.

