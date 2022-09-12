import 'package:flutter/material.dart';
import 'package:movies/Home/details/more_movies_item.dart';
import 'package:movies/Model/Movies%20and%20Results.dart';
// belong to details screen
class MoreMoviesWidget extends StatelessWidget {
  Movies? topMovies;

  MoreMoviesWidget(this.topMovies);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 250,
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 10),
      color: Color.fromRGBO(40, 42, 40, 1.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'More Like This',
            style: TextStyle(
            decoration: TextDecoration.overline,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) => MoreMovieItem(topMovies, index),
              itemCount: topMovies?.results?.length ?? 0,
            ),
          ),
        ],
      ),
    );
  }
}