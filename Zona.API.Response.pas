unit Zona.API.Response;

interface

uses
  Rest.Json, Rest.Json.Types, Zona.API.Base;

type
  TResponse = class
  private
    [JsonNameAttribute('numFound')]
    FNumFound: Int64;
    [JsonNameAttribute('start')]
    FStart: Int64;
  public
    property NumFound: Int64 read FNumFound write FNumFound;
    property Start: Int64 read FStart write FStart;
  end;

  TResponse<T: TZonaObject> = class(TResponse)
  private
    [JsonNameAttribute('docs')]
    FDocs: TArray<T>;
  public
    property Items: TArray<T> read FDocs write FDocs;
    destructor Destroy; override;
  end;

  TParams = class
  private
    [JsonNameAttribute('q')]
    FQ: string;
    [JsonNameAttribute('fl')]
    FFl: string;
    [JsonNameAttribute('start')]
    FStart: string;
    [JsonNameAttribute('rows')]
    FRows: string;
    [JsonNameAttribute('version')]
    FVersion: string;
    [JsonNameAttribute('wt')]
    FWt: string;
  public
    property Q: string read FQ write FQ;
    property Fl: string read FFl write FFl;
    property Start: string read FStart write FStart;
    property Rows: string read FRows write FRows;
    property Version: string read FVersion write FVersion;
    property Wt: string read FWt write FWt;
  end;

  TResponseHeader = class
  private
    [JsonNameAttribute('status')]
    FStatus: Int64;
    [JsonNameAttribute('QTime')]
    FQTime: Int64;
    [JsonNameAttribute('params')]
    FParams: TParams;
  public
    property Status: Int64 read FStatus write FStatus;
    property QTime: Int64 read FQTime write FQTime;
    property Params: TParams read FParams write FParams;
    destructor Destroy; override;
  end;

  TZonaResponseBase = class
  private
    [JsonNameAttribute('responseHeader')]
    FResponseHeader: TResponseHeader;
  public
    property ResponseHeader: TResponseHeader read FResponseHeader write FResponseHeader;
    destructor Destroy; override;
  end;

  TZonaResponse<T: TZonaObject> = class(TZonaResponseBase)
  private
    [JsonNameAttribute('response')]
    FResponse: TResponse<T>;
  public
    property Response: TResponse<T> read FResponse write FResponse;
    destructor Destroy; override;
  end;

implementation

{ TResponse }

destructor TResponse<T>.Destroy;
begin
  for var Item in FDocs do
    Item.Free;
  inherited;
end;

{ TResponseHeader }

destructor TResponseHeader.Destroy;
begin
  FParams.Free;
  inherited;
end;

{ TZonaResponseBase }

destructor TZonaResponseBase.Destroy;
begin
  FResponseHeader.Free;
  inherited;
end;

{ TZonaResponse<T> }

destructor TZonaResponse<T>.Destroy;
begin
  FResponse.Free;
  inherited;
end;

end.

