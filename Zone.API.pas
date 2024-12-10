unit Zone.API;

interface

uses
  System.SysUtils, System.Classes, REST.Client, REST.Types, Zone.API.Response,
  Zone.API.Genre, Zone.API.Movie;

type
  TZoneAPI = class(TComponent)
  private
    FVersion: string;
    FBaseURL: string;
    procedure SetVersion(const Value: string);
    procedure SetBaseURL(const Value: string);
  protected
    function GetClient: TRESTClient;
  public
    property Version: string read FVersion write SetVersion;
    property BaseURL: string read FBaseURL write SetBaseURL;
    constructor Create(AOwner: TComponent); override;
  public
    function GetGenres: TZoneResponse<TZoneGenre>;
    function GetMovies(const Q: string; Offset, Count: Integer; const Sort: string = ''): TZoneResponse<TZoneMovie>;
  end;

  TZoneQueryBuilder = record
  private
    FItems: TArray<string>;
    procedure Expr(const Contdition: string; const Name, Value: string); overload;
    procedure Expr(const Contdition: string; const Name: string; const Value: Boolean); overload;
    procedure Expr(const Contdition: string; const Name: string; const From, &To: Integer); overload;
    procedure Expr(const Contdition: string; const Name: string; const From, &To: TDateTime); overload;
    procedure Expr(const Contdition: string; const Name: string; const Values: TArray<string>); overload;
  public
    function Query: string;
    procedure IfAnd(const Name, Value: string); overload;
    procedure IfAnd(const Name: string; const Value: Boolean); overload;
    procedure IfAnd(const Name: string; const From, &To: Integer); overload;
    procedure IfAnd(const Name: string; const From, &To: TDateTime); overload;
    procedure IfAnd(const Name: string; const Values: TArray<string>); overload;

    procedure IfNot(const Name, Value: string); overload;
    procedure IfNot(const Name: string; const Value: Boolean); overload;
    procedure IfNot(const Name: string; const From, &To: Integer); overload;
    procedure IfNot(const Name: string; const From, &To: TDateTime); overload;
    procedure IfNot(const Name: string; const Values: TArray<string>); overload;
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

{ TZoneQueryBuilder }

procedure TZoneQueryBuilder.Expr(const Contdition: string; const Name, Value: string);
begin
  FItems := FItems + [Format('%s (%s:%s)', [Contdition, Name, Value])];
end;

procedure TZoneQueryBuilder.Expr(const Contdition: string; const Name: string; const From, &To: Integer);
begin
  FItems := FItems + [Format('%s (%s:[%s TO %s])', [Contdition, Name, From.ToString, &To.ToString])];
end;

procedure TZoneQueryBuilder.Expr(const Contdition: string; const Name: string; const From, &To: TDateTime);
begin
  FItems := FItems + [Format('%s (%s:[%s TO %s])', [Contdition, Name, DateToISO8601(From), DateToISO8601(&To)])];
end;

procedure TZoneQueryBuilder.Expr(const Contdition: string; const Name: string; const Values: TArray<string>);
begin
  FItems := FItems + [Format('%s (%s:(%s))', [Contdition, Name, string.Join(' OR ', Values)])];
end;

procedure TZoneQueryBuilder.Expr(const Contdition: string; const Name: string; const Value: Boolean);
begin
  FItems := FItems + [Format('%s (%s:%s)', [Contdition, Name, IfThen(Value, 'true', 'false')])];
end;

procedure TZoneQueryBuilder.IfAnd(const Name: string; const Values: TArray<string>);
begin
  Expr('AND', Name, Values);
end;

procedure TZoneQueryBuilder.IfAnd(const Name, Value: string);
begin
  Expr('AND', Name, Value);
end;

procedure TZoneQueryBuilder.IfAnd(const Name: string; const Value: Boolean);
begin
  Expr('AND', Name, Value);
end;

procedure TZoneQueryBuilder.IfAnd(const Name: string; const From, &To: TDateTime);
begin
  Expr('AND', Name, From, &To);
end;

procedure TZoneQueryBuilder.IfAnd(const Name: string; const From, &To: Integer);
begin
  Expr('AND', Name, From, &To);
end;

procedure TZoneQueryBuilder.IfNot(const Name: string; const Value: Boolean);
begin
  Expr('NOT', Name, Value);
end;

procedure TZoneQueryBuilder.IfNot(const Name, Value: string);
begin
  Expr('NOT', Name, Value);
end;

procedure TZoneQueryBuilder.IfNot(const Name: string; const From, &To: Integer);
begin
  Expr('NOT', Name, From, &To);
end;

procedure TZoneQueryBuilder.IfNot(const Name: string; const From, &To: TDateTime);
begin
  Expr('NOT', Name, From, &To);
end;

procedure TZoneQueryBuilder.IfNot(const Name: string; const Values: TArray<string>);
begin
  Expr('NOT', Name, Values);
end;

function TZoneQueryBuilder.Query: string;
begin
  Result := string.Join(' ', FItems);
end;

{ TZoneAPI }

constructor TZoneAPI.Create(AOwner: TComponent);
begin
  inherited;
  FVersion := '2.2';
  FBaseURL := 'http://zsolr3.zonasearch.com/solr/';
end;

function TZoneAPI.GetClient: TRESTClient;
begin
  Result := TRESTClient.Create(Self);
  Result.BaseURL := FBaseURL;
  Result.AddQueryParam('wt', 'json');
  Result.AddQueryParam('version', FVersion);
end;

function TZoneAPI.GetGenres: TZoneResponse<TZoneGenre>;
begin
  var Client := GetClient;
  try
    Client.AddQueryParam('q', '*:*');
    Client.AddQueryParam('fl', 'id,name,ord,adult,fictional,custom');
    Client.AddQueryParam('start', '0');
    Client.AddQueryParam('rows', '2147483647');
    Client.AddQueryParam('sort', 'ord asc');

    Result := Client.GetEntity<TZoneResponse<TZoneGenre>>('genre2/select');
  finally
    Client.Free;
  end;
end;

function TZoneAPI.GetMovies(const Q: string; Offset, Count: Integer; const Sort: string): TZoneResponse<TZoneMovie>;
begin
  var Client := GetClient;
  try
    Client.AddQueryParam('q', '(' + Q + ')');
    Client.AddQueryParam('fl', 'id,year,playable,trailer,quality,audio_quality,type3d,serial,languages_imdb,rating,genre2,runtime,episodes,tor_count,serial_end_year,serial_ended,abuse,release_date_int,release_date_rus,indexed,geo_rules,partner_entity_id,partner_type,name_rus,name_ukr,name_eng,name_original');
    Client.AddQueryParam('start', Offset.ToString);
    Client.AddQueryParam('rows', Count.ToString);
    if not Sort.IsEmpty then
      Client.AddQueryParam('sort', Sort);
    Result := Client.GetEntity<TZoneResponse<TZoneMovie>>('movie/select');
  finally
    Client.Free;
  end;
end;

procedure TZoneAPI.SetBaseURL(const Value: string);
begin
  FBaseURL := Value;
end;

procedure TZoneAPI.SetVersion(const Value: string);
begin
  FVersion := Value;
end;

end.

