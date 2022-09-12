import 'package:flutter/material.dart';
import 'package:movies/Home/TopRated/top_rated_item.dart';
import 'package:movies/Model/Movies%20and%20Results.dart';

class TopRatedWidget extends StatelessWidget {
  Movies? topMovies;
  TopRatedWidget(this.topMovies);

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
          const Text(
            'Recommended and Top Rated Movies',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white,),),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              shrinkWrap: false,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) =>  TopRatedItem(topMovies, index),
              itemCount: topMovies?.results?.length ?? 0,
            ),
          ),
        ],
      ),
    );
  }
}