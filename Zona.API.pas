unit Zona.API;

interface

uses
  System.SysUtils, System.Classes, REST.Client, REST.Types, Zona.API.Response,
  Zona.API.QBuilder, Zona.API.Base, Zona.API.Genre, Zona.API.Movie,
  Zona.API.Country, Zona.API.Torrent, Zona.API.Radio;

type
  TZonaQueryBuilder = Zona.API.QBuilder.TZonaQueryBuilder;

type
  TZonaAPI = class(TComponent)
  private
    FVersion: string;
    FBaseURL: string;
    FOnLog: TProc<string>;
    procedure SetVersion(const Value: string);
    procedure SetBaseURL(const Value: string);
    procedure SetOnLog(const Value: TProc<string>);
  protected
    function GetClient: TRESTClient;
    procedure Log(const Text: string);
  public
    property Version: string read FVersion write SetVersion;
    property BaseURL: string read FBaseURL write SetBaseURL;
    property OnLog: TProc<string> read FOnLog write SetOnLog;
    constructor Create(AOwner: TComponent); override;
  public
    function GetGenres: TZonaResponse<TZonaGenre>;
    function GetCountries: TZonaResponse<TZonaCountry>;
    function GetMovies(const Q: string; Offset, Count: Integer; const Sort: string = ''): TZonaResponse<TZonaMovie>;
    function GetTorrents(const Q: string; Offset, Count: Integer; const Sort: string = ''): TZonaResponse<TZonaTorrent>;
    function GetRadios: TArray<TZonaRadio>;
    class function BuildImageUrlV1(const Id: string): string;
    class function BuildImageUrlV2(const Id: string): string;
  end;

  TRESTClientHelper = class helper for TRESTClient
    procedure AddQueryParam(const AName, AValue: string);
  end;

implementation

uses
  System.DateUtils, System.StrUtils;

{ TRESTClientHelper }

procedure TRESTClientHelper.AddQueryParam(const AName, AValue: string);
begin
  AddParameter(AName, AValue, TRESTRequestParameterKind.pkQUERY);
end;

{ TZonaAPI }

class function TZonaAPI.BuildImageUrlV1(const Id: string): string;
begin
  Result := 'https://img2.zonapic.com/images/film_240/' + Id.Substring(0, 4) + '/' + Id + '.jpg';
end;

class function TZonaAPI.BuildImageUrlV2(const Id: string): string;
begin
  Result := 'https://img2.zonapic.com/images/film_240/' + Id.Substring(0, 3) + '/' + Id + '.jpg';
end;

constructor TZonaAPI.Create(AOwner: TComponent);
begin
  inherited;
  FVersion := '2.2';
  FBaseURL := 'http://zsolr3.zonasearch.com/solr/';
end;

function TZonaAPI.GetClient: TRESTClient;
begin
  Result := TRESTClient.Create(Self);
  Result.BaseURL := FBaseURL;
  Result.AddQueryParam('wt', 'json');
  Result.AddQueryParam('version', FVersion);
  Result.UserAgent := 'Zona app for fun';
end;

function TZonaAPI.GetCountries: TZonaResponse<TZonaCountry>;
begin
  var Client := GetClient;
  try
    Client.AddQueryParam('q', '*:*');
    Client.AddQueryParam('fl', 'id,name');
    Client.AddQueryParam('start', '0');
    Client.AddQueryParam('rows', '2147483647');
    Client.AddQueryParam('sort', 'name asc');

    Result := Client.GetEntity<TZonaResponse<TZonaCountry>>('country/select');
  finally
    Client.Free;
  end;
end;

function TZonaAPI.GetGenres: TZonaResponse<TZonaGenre>;
begin
  var Client := GetClient;
  try
    Client.AddQueryParam('q', '*:*');
    Client.AddQueryParam('fl', 'id,name,ord,adult,fictional,custom');
    Client.AddQueryParam('start', '0');
    Client.AddQueryParam('rows', '2147483647');
    Client.AddQueryParam('sort', 'ord asc');

    Result := Client.GetEntity<TZonaResponse<TZonaGenre>>('genre2/select');
  finally
    Client.Free;
  end;
end;

function TZonaAPI.GetMovies(const Q: string; Offset, Count: Integer; const Sort: string): TZonaResponse<TZonaMovie>;
begin
  var Client := GetClient;
  try
    Client.AddQueryParam('q', '(' + Q + ')');
    //Client.AddQueryParam('fl', 'id,year,playable,trailer,adult,rating_kinopoisk,rating_imdb,country,quality,audio_quality,type3d,serial,languages_imdb,rating,genre2,runtime,episodes,tor_count,serial_end_year,serial_ended,abuse,release_date_int,release_date_rus,indexed,geo_rules,partner_entity_id,partner_type,name_rus,name_ukr,name_eng,name_original');
    Client.AddQueryParam('start', Offset.ToString);
    Client.AddQueryParam('rows', Count.ToString);
    if not Sort.IsEmpty then
      Client.AddQueryParam('sort', Sort);
    Result := Client.GetEntity<TZonaResponse<TZonaMovie>>('movie/select');
  finally
    Client.Free;
  end;
end;

function TZonaAPI.GetRadios: TArray<TZonaRadio>;
begin
  var Client := GetClient;
  try
    Client.BaseURL := 'http://radio.zonasearch.com';
    Result := Client.GetEntityArray<TZonaRadio>('radio2.json');
  finally
    Client.Free;
  end;
end;

function TZonaAPI.GetTorrents(const Q: string; Offset, Count: Integer; const Sort: string): TZonaResponse<TZonaTorrent>;
begin
  var Client := GetClient;
  try
    Client.AddQueryParam('q', '(' + Q + ')');
    Client.AddQueryParam('start', Offset.ToString);
    Client.AddQueryParam('rows', Count.ToString);
    if not Sort.IsEmpty then
      Client.AddQueryParam('sort', Sort);
    Result := Client.GetEntity<TZonaResponse<TZonaTorrent>>('torrent/select');
  finally
    Client.Free;
  end;
end;

procedure TZonaAPI.Log(const Text: string);
begin
  if Assigned(FOnLog) then
    FOnLog(Text);
end;

procedure TZonaAPI.SetBaseURL(const Value: string);
begin
  FBaseURL := Value;
end;

procedure TZonaAPI.SetOnLog(const Value: TProc<string>);
begin
  FOnLog := Value;
end;

procedure TZonaAPI.SetVersion(const Value: string);
begin
  FVersion := Value;
end;

end.

