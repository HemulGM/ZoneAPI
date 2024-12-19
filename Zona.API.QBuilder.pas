unit Zona.API.QBuilder;

interface

uses
  System.SysUtils;

type
  TZonaQueryBuilder = record
  private
    FItems: TArray<string>;
    function IfCon(const Condition: string): string;
    procedure Expr(const Condition: string; const Name, Value: string); overload;
    procedure Expr(const Condition: string; const Name: string; const Value: Boolean); overload;
    procedure Expr(const Condition: string; const Name: string; const From, &To: Integer); overload;
    procedure Expr(const Condition: string; const Name: string; const From, &To: TDateTime); overload;
    procedure Expr(const Condition: string; const Name: string; const Values: TArray<string>); overload;
  public
    function Query: string;

    procedure BeginParenthesisAnd; overload;
    procedure IfAnd(const Name, Value: string); overload;
    procedure IfAnd(const Name: string; const Value: Boolean); overload;
    procedure IfAnd(const Name: string; const From, &To: Integer); overload;
    procedure IfAnd(const Name: string; const From, &To: TDateTime); overload;
    procedure IfAnd(const Name: string; const Values: TArray<string>); overload;

    procedure BeginParenthesisOr; overload;
    procedure IfOr(const Name, Value: string); overload;
    procedure IfOr(const Name: string; const Value: Boolean); overload;
    procedure IfOr(const Name: string; const From, &To: Integer); overload;
    procedure IfOr(const Name: string; const From, &To: TDateTime); overload;
    procedure IfOr(const Name: string; const Values: TArray<string>); overload;

    procedure BeginParenthesisNot; overload;
    procedure IfNot(const Name, Value: string); overload;
    procedure IfNot(const Name: string; const Value: Boolean); overload;
    procedure IfNot(const Name: string; const From, &To: Integer); overload;
    procedure IfNot(const Name: string; const From, &To: TDateTime); overload;
    procedure IfNot(const Name: string; const Values: TArray<string>); overload;

    procedure EndParenthesis; overload;
  end;

implementation

uses
  System.DateUtils, System.StrUtils;

{ TZonaQueryBuilder }

procedure TZonaQueryBuilder.Expr(const Condition: string; const Name, Value: string);
begin
  FItems := FItems + [Format('%s (%s:%s)', [IfCon(Condition), Name, Value])]
end;

procedure TZonaQueryBuilder.Expr(const Condition: string; const Name: string; const From, &To: Integer);
begin
  FItems := FItems + [Format('%s (%s:[%s TO %s])', [IfCon(Condition), Name, From.ToString, &To.ToString])];
end;

procedure TZonaQueryBuilder.Expr(const Condition: string; const Name: string; const From, &To: TDateTime);
begin
  FItems := FItems + [Format('%s (%s:[%s TO %s])', [IfCon(Condition), Name, DateToISO8601(From), DateToISO8601(&To)])];
end;

procedure TZonaQueryBuilder.BeginParenthesisAnd;
begin
  FItems := FItems + [IfCon('AND') + ' ('];
end;

procedure TZonaQueryBuilder.BeginParenthesisNot;
begin
  FItems := FItems + [IfCon('NOT') + ' ('];
end;

procedure TZonaQueryBuilder.BeginParenthesisOr;
begin
  FItems := FItems + [IfCon('OR') + ' ('];
end;

procedure TZonaQueryBuilder.EndParenthesis;
begin
  FItems := FItems + [')'];
end;

procedure TZonaQueryBuilder.Expr(const Condition: string; const Name: string; const Values: TArray<string>);
begin
  FItems := FItems + [Format('%s (%s:(%s))', [IfCon(Condition), Name, string.Join(' OR ', Values)])];
end;

procedure TZonaQueryBuilder.Expr(const Condition: string; const Name: string; const Value: Boolean);
begin
  FItems := FItems + [Format('%s (%s:%s)', [IfCon(Condition), Name, IfThen(Value, 'true', 'false')])];
end;

function TZonaQueryBuilder.IfCon(const Condition: string): string;
begin
  if ((Length(FItems) > 0) and (not FItems[High(FItems)].EndsWith('('))) or (Condition.ToLower = 'not') then
    Result := Condition
  else
    Result := '';
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

procedure TZonaQueryBuilder.IfOr(const Name, Value: string);
begin
  Expr('OR', Name, Value);
end;

procedure TZonaQueryBuilder.IfOr(const Name: string; const Value: Boolean);
begin
  Expr('OR', Name, Value);
end;

procedure TZonaQueryBuilder.IfOr(const Name: string; const From, &To: Integer);
begin
  Expr('OR', Name, From, &To);
end;

procedure TZonaQueryBuilder.IfOr(const Name: string; const From, &To: TDateTime);
begin
  Expr('OR', Name, From, &To);
end;

procedure TZonaQueryBuilder.IfOr(const Name: string; const Values: TArray<string>);
begin
  Expr('OR', Name, Values);
end;

function TZonaQueryBuilder.Query: string;
begin
  Result := string.Join(' ', FItems);
end;

end.

