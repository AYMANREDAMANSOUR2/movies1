import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies/Model_From_API/Geners.dart';
import 'package:movies/Model_From_API/Movies%20and%20Results.dart';

//
class ApiRepository {
  static const String apiKey = 'ad89d469278b2085d421274a9589870d';

//-----------------------------------------------------------------------------------------------------------------
  static Future<Movies> fetchSearch(String queryParameters) async {
    Uri url = Uri.https(
      'api.themoviedb.org',
      '/3/search/movie',
      {
        'api_key': apiKey,
        'query': queryParameters,
      },
    );
    final response = await http.get(url); //get data
    var searchResponse =
        Movies.fromJson(jsonDecode(response.body)); // convert data
    if (response.statusCode == 200) {
      //check data
      return searchResponse; // return data
    } else {
      //error
      throw Exception('Failed to load album');
    }
  }
//---------------------------------------------------------------------------------------------------------------------------------------
                                                                                                      // recommend movies
  static Future<Movies> fetchMoviesData() async {     //get movies data
    // change randomly => recommended
    var response = await http.get(
      Uri.parse(
          'https://api.themoviedb.org/3/movie/top_rated?api_key=${apiKey}&language=en-US&page=8 '),
    );
    var movieResponse = Movies.fromJson(jsonDecode(response.body)); //convert
    if (response.statusCode == 200) {
      // success
      return movieResponse;
    } else {
      //failed
      throw Exception('Failed to load album');
    }
  }
//---------------------------------------------------------New release , show --------------------------------------------------------
  static Future<Movies> fetchPopular() async {
    //get popular
    final response = await http.get(
      Uri.parse(
          'https://api.themoviedb.org/3/movie/popular?api_key=${apiKey}&language=en-US&page=3'),
    );
    var popularResponse = Movies.fromJson(jsonDecode(response.body));

    ///====================================================================
    if (response.statusCode == 200) {
      // success
      return popularResponse;
    } else {
      // false
      throw Exception('Failed to load album');
    }
  }

  static Future<Movies> fetchPopular2() async {
    //get popular
    final response = await http.get(
      Uri.parse(
          'https://api.themoviedb.org/3/movie/popular?api_key=${apiKey}&language=en-US&page=7'),
    );
    var popularResponse = Movies.fromJson(jsonDecode(response.body));

    ///====================================================================
    if (response.statusCode == 200) {
      // success
      return popularResponse;
    } else {
      // false
      throw Exception('Failed to load album');
    }
  }

//---------------------------------------------------------------------- -- -------------------------------------------------------------
  static Future<Movies> fetchSimilar(int movieId) async {
    var header = '/3/movie/$movieId/similar';
    Uri url = Uri.https(
      'api.themoviedb.org',
      header,
      {
        'api_key': apiKey,
      },
    ); //data link
    final response = await http.get(
      url,
      headers: {
        'movie_id': '',
      },
    ); // get data
    var similarResponse = Movies.fromJson(jsonDecode(response.body)); //convert
    ///------------------------------------------------------------------------------------------------------------
    if (response.statusCode == 200) {
      return similarResponse;
    } else {
      throw Exception('Failed to load album');
    }
  }
//-------------------------------------------------    -------------------------------------------------------------------------------
  static Future<GenersModel> fetchGeners() async {
    final response = await http.get(Uri.parse('https://api.themoviedb.org/3/genre/movie/list?api_key=${apiKey}&language=en-US'),);
    var genrsResponse = GenersModel.fromJson(jsonDecode(response.body)); // convert
    /// -------------------------------------------------------success and fails----------------------------------------
    if (response.statusCode == 200) {
      return genrsResponse;
    } else {
      throw Exception('Faild to load album');
    }
  }
//--------------------------------------------------  ---------------------------------------------------------------
  static Future<Movies> fetchMoviesList(String catName) async {
    Uri url = Uri.https('api.themoviedb.org', '/3/discover/movie', {'api_key': apiKey, 'with_genres': catName,});
    final response = await http.get(url);  // get data
    var listResponse = Movies.fromJson(jsonDecode(response.body)); // convert
    ///-------------------------------------------------- - ---------------------------------------------------------------

    if (response.statusCode == 200) {
      return listResponse;
    } else {
      throw Exception('Faild to load album');
    }
  }
}