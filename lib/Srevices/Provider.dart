import 'package:flutter/material.dart';
import 'package:movies/Model_From_API/Movies%20and%20Results.dart';

class AppProvider extends ChangeNotifier {
  List<Results> watchList = [ ];
  List<int> idList = [ ];
  Map<int, Results> list = {};

  void selectMovie(Results resultsMovie) {
    if (!idList.contains(resultsMovie.id)) { // if watch list don't contain this id add it
      watchList.add(resultsMovie);
      idList.add(resultsMovie.id!);
    } else if (idList.contains(resultsMovie.id)) { // id
      idList.remove(resultsMovie.id);
      watchList.removeWhere((element) => element.id == resultsMovie.id);
    }
    notifyListeners();
  }

  void createList(int movieId) {}
}