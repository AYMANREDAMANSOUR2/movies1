class Movies {
  // what will u take from Movies class ?
  int? page;
  List<Results>? results;
//from json
  Movies.fromJson(Map<String, dynamic> json) {
    page = json["page"];
    if (json["results"] != null) {
      results = [];
      json["results"].forEach((v) {
        results?.add(Results.fromJson(v));
      });
    }
  }
}
//----------------------------------------------------------------------------------------------------------------------------------------------
class Results {
  //what will u take from  results class  ?
  String? backdropPath;
  List<int>? genreIds;
  int? id;
  String? overview;
  String? posterPath;
  String? releaseDate;
  String? title;
  bool? video;
  String? voteAverage;
  //-------------------------------------------------------------------------------------------------------------------
// from json
  Results.fromJson(Map<String, dynamic> json) {
    backdropPath = json["backdrop_path"];
    genreIds = json["genre_ids"] != null ? json["genre_ids"].cast<int>() : [];
    id = json["id"];
    overview = json["overview"];
    posterPath = json["poster_path"];
    releaseDate = json["release_date"];
    title = json["title"];
    video = json["video"];
    voteAverage = json["vote_average"].toString();
  }
}