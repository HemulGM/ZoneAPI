unit Zona.API.QBuilder;

interface

uses
  System.SysUtils;

type
  TZonaQueryBuilder = record
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

implementation

uses
  System.DateUtils, System.StrUtils;

{ TZonaQueryBuilder }

procedure TZonaQueryBuilder.Expr(const Contdition: string; const Name, Value: string);
begin
  FItems := FItems + [Format('%s (%s:%s)', [Contdition, Name, Value])];
end;

procedure TZonaQueryBuilder.Expr(const Contdition: string; const Name: string; const From, &To: Integer);
begin
  FItems := FItems + [Format('%s (%s:[%s TO %s])', [Contdition, Name, From.ToString, &To.ToString])];
end;

procedure TZonaQueryBuilder.Expr(const Contdition: string; const Name: string; const From, &To: TDateTime);
begin
  FItems := FItems + [Format('%s (%s:[%s TO %s])', [Contdition, Name, DateToISO8601(From), DateToISO8601(&To)])];
end;

procedure TZonaQueryBuilder.Expr(const Contdition: string; const Name: string; const Values: TArray<string>);
begin
  FItems := FItems + [Format('%s (%s:(%s))', [Contdition, Name, string.Join(' OR ', Values)])];
end;

procedure TZonaQueryBuilder.Expr(const Contdition: string; const Name: string; const Value: Boolean);
begin
  FItems := FItems + [Format('%s (%s:%s)', [Contdition, Name, IfThen(Value, 'true', 'false')])];
end;

procedure TZonaQueryBuilder.IfAnd(const Name: string; const Values: TArray<string>);
begin
  Expr('AND', Name, Values);
end;

procedure TZonaQueryBuilder.IfAnd(const Name, Value: string);
begin
  Expr('AND', Name, Value);
end;

procedure TZonaQueryBuilder.IfAnd(const Name: string; const Value: Boolean);
begin
  Expr('AND', Name, Value);
end;

procedure TZonaQueryBuilder.IfAnd(const Name: string; const From, &To: TDateTime);
begin
  Expr('AND', Name, From, &To);
end;

procedure TZonaQueryBuilder.IfAnd(const Name: string; const From, &To: Integer);
begin
  Expr('AND', Name, From, &To);
end;

procedure TZonaQueryBuilder.IfNot(const Name: string; const Value: Boolean);
begin
  Expr('NOT', Name, Value);
end;

procedure TZonaQueryBuilder.IfNot(const Name, Value: string);
begin
  Expr('NOT', Name, Value);
end;

procedure TZonaQueryBuilder.IfNot(const Name: string; const From, &To: Integer);
begin
  Expr('NOT', Name, From, &To);
end;

procedure TZonaQueryBuilder.IfNot(const Name: string; const From, &To: TDateTime);
begin
  Expr('NOT', Name, From, &To);
end;

procedure TZonaQueryBuilder.IfNot(const Name: string; const Values: TArray<string>);
begin
  Expr('NOT', Name, Values);
end;

function TZonaQueryBuilder.Query: string;
begin
  Result := string.Join(' ', FItems);
end;

end.

