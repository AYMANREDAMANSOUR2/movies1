import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies/Model/Movies and Results.dart';

import '../../Model/Geners.dart';

class ApiRepository {
  static const String apiKey = 'ad89d469278b2085d421274a9589870d';
//-----------------------------------------------------------------------------------------------------------------
  static Future<Movies> fetchSearch(String queryParameters) async {
    Uri url = Uri.https('api.themoviedb.org', '/3/search/movie', {'api_key': apiKey, 'query': queryParameters,},);
    final response = await http.get(url);     //get data
    var searchResponse = Movies.fromJson(jsonDecode(response.body));
    if (response.statusCode == 200) {
      return searchResponse;
    } else {
      throw Exception('Failed to load album');
    }
  }
//---------------------------------------------------------------------------------------------------------------------------------------
  static Future<Movies> fetchMoviesData() async {
    var response = await http.get(Uri.parse(
          'https://api.themoviedb.org/3/movie/top_rated?api_key=ad89d469278b2085d421274a9589870d&language=en-US&page=1'),
    );
    var movieResponse = Movies.fromJson(jsonDecode(response.body));
    if (response.statusCode == 200) { // success
      return movieResponse;
    } else { //failed
      throw Exception('Failed to load album');
    }
  }
//-----------------------------------------------------------------------------------------------------------------
  static Future<Movies> fetchPopular() async {
    final response = await http.get(Uri.parse(
          'https://api.themoviedb.org/3/movie/popular?api_key=${apiKey}&language=en-US&page=1'),);
    var popularResponse = Movies.fromJson(jsonDecode(response.body));
    if (response.statusCode == 200) {
      return popularResponse;
    } else {
      throw Exception('Failed to load album');
    }
  }
//-------------------------------------------------    -------------------------------------------------------------
  static Future<Movies> fetchSimilar(int movieId) async {
    var header = '/3/movie/$movieId/similar';
    Uri url = Uri.https('api.themoviedb.org', header, {'api_key': apiKey,},);
    final response = await http.get(url, headers: {'movie_id': '',},);
    var similarResponse = Movies.fromJson(jsonDecode(response.body));
    //------------------------------------------------------------------------------------------------------------
    if (response.statusCode == 200) {
      return similarResponse;
    } else {
      throw Exception('Failed to load album');
    }
  }
//-------------------------------------------------    -------------------------------------------------------------------------------
  static Future<GenersModel> fetchGeners() async {
    final response = await http.get(
      Uri.parse(
          'https://api.themoviedb.org/3/genre/movie/list?api_key=${apiKey}&language=en-US'),);
    var genrsResponse = GenersModel.fromJson(jsonDecode(response.body));
    if (response.statusCode == 200) {
      return genrsResponse;
    } else {
      throw Exception('Faild to load album');
    }
  }
//--------------------------------------------------  ---------------------------------------------------------------
  static Future<Movies> fetchMoviesList(String catName) async {
    Uri url = Uri.https('api.themoviedb.org', '/3/discover/movie', {'api_key': apiKey, 'with_genres': catName,});
    final response = await http.get(url);
    var listResponse = Movies.fromJson(jsonDecode(response.body));
    if (response.statusCode == 200) {
      return listResponse;
    } else {
      throw Exception('Faild to load album');
    }
  }
}