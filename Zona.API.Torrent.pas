unit Zona.API.Torrent;

interface

uses
  Rest.Json, Rest.Json.Types, Zona.API.Base;

type
  TZonaTorrent = class(TZonaObject)
  private
    [JsonNameAttribute('torrent_download_link')]
    FTorrentDownloadLink: string;
    [JsonNameAttribute('private')]
    FPrivate: Boolean;
    [JsonNameAttribute('size_bytes')]
    FSizeBytes: Int64;
    [JsonNameAttribute('peers')]
    FPeers: Int64;
    [JsonNameAttribute('language')]
    FLanguage: string;
    [JsonNameAttribute('playable_count')]
    FPlayableCount: Int64;
    [JsonNameAttribute('translate_info')]
    FTranslateInfo: string;
    [JsonNameAttribute('resolution')]
    FResolution: string;
    [JsonNameAttribute('playable')]
    FPlayable: Boolean;
    [JsonNameAttribute('trailer')]
    FTrailer: Boolean;
    [JsonNameAttribute('subtitles_parser')]
    FSubtitlesParser: string;
    [JsonNameAttribute('loading_time_sum')]
    FLoadingTimeSum: Int64;
    [JsonNameAttribute('last_update')]
    FLastUpdate: string;
    [JsonNameAttribute('advertisement')]
    FAdvertisement: Boolean;
    [JsonNameAttribute('filenames')]
    FFilenames: string;
    [JsonNameAttribute('audio_quality_id')]
    FAudioQualityId: Integer;
    [JsonNameAttribute('languages_parser')]
    FLanguagesParser: string;
    [JsonNameAttribute('loading_success_total')]
    FLoadingSuccessTotal: Int64;
    [JsonNameAttribute('subtitles')]
    FSubtitles: string;
    [JsonNameAttribute('languages')]
    FLanguages: string;
    [JsonNameAttribute('kinopoisk_id')]
    FKinopoiskId: Int64;
    [JsonNameAttribute('indexed')]
    FIndexed: Int64;
    [JsonNameAttribute('seeds')]
    FSeeds: Int64;
    [JsonNameAttribute('loading_fail_count')]
    FLoadingFailCount: Int64;
    [JsonNameAttribute('magnet')]
    FMagnet: Boolean;
    [JsonNameAttribute('quality_id')]
    FQualityId: Integer;
    [JsonNameAttribute('files')]
    FFiles: string;
    [JsonNameAttribute('loading_success_count')]
    FLoadingSuccessCount: Int64;
    [JsonNameAttribute('adult')]
    FAdult: Boolean;
    [JsonNameAttribute('hash')]
    FHash: string;
  public
    property TorrentDownloadLink: string read FTorrentDownloadLink write FTorrentDownloadLink;
    property &Private: Boolean read FPrivate write FPrivate;
    property SizeBytes: Int64 read FSizeBytes write FSizeBytes;
    property Peers: Int64 read FPeers write FPeers;
    property Language: string read FLanguage write FLanguage;
    property PlayableCount: Int64 read FPlayableCount write FPlayableCount;
    property TranslateInfo: string read FTranslateInfo write FTranslateInfo;
    property Resolution: string read FResolution write FResolution;
    property Playable: Boolean read FPlayable write FPlayable;
    property Trailer: Boolean read FTrailer write FTrailer;
    property SubtitlesParser: string read FSubtitlesParser write FSubtitlesParser;
    property LoadingTimeSum: Int64 read FLoadingTimeSum write FLoadingTimeSum;
    property LastUpdate: string read FLastUpdate write FLastUpdate;
    property Advertisement: Boolean read FAdvertisement write FAdvertisement;
    property Filenames: string read FFilenames write FFilenames;
    property AudioQualityId: Integer read FAudioQualityId write FAudioQualityId;
    property LanguagesParser: string read FLanguagesParser write FLanguagesParser;
    property LoadingSuccessTotal: Int64 read FLoadingSuccessTotal write FLoadingSuccessTotal;
    property Subtitles: string read FSubtitles write FSubtitles;
    property Languages: string read FLanguages write FLanguages;
    property KinopoiskId: Int64 read FKinopoiskId write FKinopoiskId;
    property Indexed: Int64 read FIndexed write FIndexed;
    property Seeds: Int64 read FSeeds write FSeeds;
    property LoadingFailCount: Int64 read FLoadingFailCount write FLoadingFailCount;
    property Magnet: Boolean read FMagnet write FMagnet;
    property QualityId: Integer read FQualityId write FQualityId;
    property Files: string read FFiles write FFiles;
    property LoadingSuccessCount: Int64 read FLoadingSuccessCount write FLoadingSuccessCount;
    property Adult: Boolean read FAdult write FAdult;
    property Hash: string read FHash write FHash;
  end;

implementation

end.

