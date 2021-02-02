import 'dart:convert';

YtsFetch welcomeFromJson(String str) => YtsFetch.fromJson(json.decode(str));

String welcomeToJson(YtsFetch data) => json.encode(data.toJson());

class YtsFetch {
  YtsFetch({
    this.status,
    this.statusMessage,
    this.data,
    this.meta,
  });

  String status;
  String statusMessage;
  Data data;
  Meta meta;

  factory YtsFetch.fromJson(Map<String, dynamic> json) => YtsFetch(
        status: json["status"] == null ? null : json["status"],
        statusMessage:
            json["status_message"] == null ? null : json["status_message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        meta: json["@meta"] == null ? null : Meta.fromJson(json["@meta"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "status_message": statusMessage == null ? null : statusMessage,
        "data": data == null ? null : data.toJson(),
        "@meta": meta == null ? null : meta.toJson(),
      };
}

class Data {
  Data({
    this.movieCount,
    this.limit,
    this.pageNumber,
    this.movies,
  });

  int movieCount;
  int limit;
  int pageNumber;
  List<Movie> movies;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        movieCount: json["movie_count"] == null ? null : json["movie_count"],
        limit: json["limit"] == null ? null : json["limit"],
        pageNumber: json["page_number"] == null ? null : json["page_number"],
        movies: json["movies"] == null
            ? null
            : List<Movie>.from(json["movies"].map((x) => Movie.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "movie_count": movieCount == null ? null : movieCount,
        "limit": limit == null ? null : limit,
        "page_number": pageNumber == null ? null : pageNumber,
        "movies": movies == null
            ? null
            : List<dynamic>.from(movies.map((x) => x.toJson())),
      };
}

class Movie {
  Movie({
    this.id,
    this.url,
    this.imdbCode,
    this.title,
    this.titleEnglish,
    this.titleLong,
    this.slug,
    this.year,
    this.rating,
    this.runtime,
    this.genres,
    this.summary,
    this.descriptionFull,
    this.synopsis,
    this.ytTrailerCode,
    this.language,
    this.mpaRating,
    this.backgroundImage,
    this.backgroundImageOriginal,
    this.smallCoverImage,
    this.mediumCoverImage,
    this.largeCoverImage,
    this.state,
    this.torrents,
    this.dateUploaded,
    this.dateUploadedUnix,
  });

  int id;
  String url;
  String imdbCode;
  String title;
  String titleEnglish;
  String titleLong;
  String slug;
  int year;
  var rating;
  int runtime;
  List<String> genres;
  String summary;
  String descriptionFull;
  String synopsis;
  String ytTrailerCode;
  String language;
  String mpaRating;
  String backgroundImage;
  String backgroundImageOriginal;
  String smallCoverImage;
  String mediumCoverImage;
  String largeCoverImage;
  String state;
  List<Torrent> torrents;
  DateTime dateUploaded;
  int dateUploadedUnix;

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        id: json["id"] == null ? null : json["id"],
        url: json["url"] == null ? null : json["url"],
        imdbCode: json["imdb_code"] == null ? null : json["imdb_code"],
        title: json["title"] == null ? null : json["title"],
        titleEnglish:
            json["title_english"] == null ? null : json["title_english"],
        titleLong: json["title_long"] == null ? null : json["title_long"],
        slug: json["slug"] == null ? null : json["slug"],
        year: json["year"] == null ? null : json["year"],
        rating: json["rating"] == null ? null : json["rating"],
        runtime: json["runtime"] == null ? null : json["runtime"],
        genres: json["genres"] == null
            ? null
            : List<String>.from(json["genres"].map((x) => x)),
        summary: json["summary"] == null ? null : json["summary"],
        descriptionFull:
            json["description_full"] == null ? null : json["description_full"],
        synopsis: json["synopsis"] == null ? null : json["synopsis"],
        ytTrailerCode:
            json["yt_trailer_code"] == null ? null : json["yt_trailer_code"],
        language: json["language"] == null ? null : json["language"],
        mpaRating: json["mpa_rating"] == null ? null : json["mpa_rating"],
        backgroundImage:
            json["background_image"] == null ? null : json["background_image"],
        backgroundImageOriginal: json["background_image_original"] == null
            ? null
            : json["background_image_original"],
        smallCoverImage: json["small_cover_image"] == null
            ? null
            : json["small_cover_image"],
        mediumCoverImage: json["medium_cover_image"] == null
            ? null
            : json["medium_cover_image"],
        largeCoverImage: json["large_cover_image"] == null
            ? null
            : json["large_cover_image"],
        state: json["state"] == null ? null : json["state"],
        torrents: json["torrents"] == null
            ? null
            : List<Torrent>.from(
                json["torrents"].map((x) => Torrent.fromJson(x))),
        dateUploaded: json["date_uploaded"] == null
            ? null
            : DateTime.parse(json["date_uploaded"]),
        dateUploadedUnix: json["date_uploaded_unix"] == null
            ? null
            : json["date_uploaded_unix"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "url": url == null ? null : url,
        "imdb_code": imdbCode == null ? null : imdbCode,
        "title": title == null ? null : title,
        "title_english": titleEnglish == null ? null : titleEnglish,
        "title_long": titleLong == null ? null : titleLong,
        "slug": slug == null ? null : slug,
        "year": year == null ? null : year,
        "rating": rating == null ? null : rating,
        "runtime": runtime == null ? null : runtime,
        "genres":
            genres == null ? null : List<dynamic>.from(genres.map((x) => x)),
        "summary": summary == null ? null : summary,
        "description_full": descriptionFull == null ? null : descriptionFull,
        "synopsis": synopsis == null ? null : synopsis,
        "yt_trailer_code": ytTrailerCode == null ? null : ytTrailerCode,
        "language": language == null ? null : language,
        "mpa_rating": mpaRating == null ? null : mpaRating,
        "background_image": backgroundImage == null ? null : backgroundImage,
        "background_image_original":
            backgroundImageOriginal == null ? null : backgroundImageOriginal,
        "small_cover_image": smallCoverImage == null ? null : smallCoverImage,
        "medium_cover_image":
            mediumCoverImage == null ? null : mediumCoverImage,
        "large_cover_image": largeCoverImage == null ? null : largeCoverImage,
        "state": state == null ? null : state,
        "torrents": torrents == null
            ? null
            : List<dynamic>.from(torrents.map((x) => x.toJson())),
        "date_uploaded":
            dateUploaded == null ? null : dateUploaded.toIso8601String(),
        "date_uploaded_unix":
            dateUploadedUnix == null ? null : dateUploadedUnix,
      };
}

class Torrent {
  Torrent({
    this.url,
    this.hash,
    this.quality,
    this.type,
    this.seeds,
    this.peers,
    this.size,
    this.sizeBytes,
    this.dateUploaded,
    this.dateUploadedUnix,
  });

  String url;
  String hash;
  String quality;
  String type;
  int seeds;
  int peers;
  String size;
  int sizeBytes;
  DateTime dateUploaded;
  int dateUploadedUnix;

  factory Torrent.fromJson(Map<String, dynamic> json) => Torrent(
        url: json["url"] == null ? null : json["url"],
        hash: json["hash"] == null ? null : json["hash"],
        quality: json["quality"] == null ? null : json["quality"],
        type: json["type"] == null ? null : json["type"],
        seeds: json["seeds"] == null ? null : json["seeds"],
        peers: json["peers"] == null ? null : json["peers"],
        size: json["size"] == null ? null : json["size"],
        sizeBytes: json["size_bytes"] == null ? null : json["size_bytes"],
        dateUploaded: json["date_uploaded"] == null
            ? null
            : DateTime.parse(json["date_uploaded"]),
        dateUploadedUnix: json["date_uploaded_unix"] == null
            ? null
            : json["date_uploaded_unix"],
      );

  Map<String, dynamic> toJson() => {
        "url": url == null ? null : url,
        "hash": hash == null ? null : hash,
        "quality": quality == null ? null : quality,
        "type": type == null ? null : type,
        "seeds": seeds == null ? null : seeds,
        "peers": peers == null ? null : peers,
        "size": size == null ? null : size,
        "size_bytes": sizeBytes == null ? null : sizeBytes,
        "date_uploaded":
            dateUploaded == null ? null : dateUploaded.toIso8601String(),
        "date_uploaded_unix":
            dateUploadedUnix == null ? null : dateUploadedUnix,
      };
}

class Meta {
  Meta({
    this.serverTime,
    this.serverTimezone,
    this.apiVersion,
    this.executionTime,
  });

  int serverTime;
  String serverTimezone;
  int apiVersion;
  String executionTime;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        serverTime: json["server_time"] == null ? null : json["server_time"],
        serverTimezone:
            json["server_timezone"] == null ? null : json["server_timezone"],
        apiVersion: json["api_version"] == null ? null : json["api_version"],
        executionTime:
            json["execution_time"] == null ? null : json["execution_time"],
      );

  Map<String, dynamic> toJson() => {
        "server_time": serverTime == null ? null : serverTime,
        "server_timezone": serverTimezone == null ? null : serverTimezone,
        "api_version": apiVersion == null ? null : apiVersion,
        "execution_time": executionTime == null ? null : executionTime,
      };
}
