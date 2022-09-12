import 'package:flutter/material.dart';
import 'package:movies/Home/ItemPhotoWidget.dart';
import 'package:movies/Model/Movies%20and%20Results.dart';
//                                                                                              Movies in second row
//                                    new_release_widget ==> news_release_item ==> item_Photo_widget
class NewRelaseItem extends StatelessWidget {
  Movies? topMovies;
  int index;
  NewRelaseItem(this.topMovies, this.index);
//--------------------------------------------------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 122,
      height: 140,
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(color: Colors.blue, blurRadius: 2),
        ],
        borderRadius: BorderRadius.circular(15),
      ),
      child: ItemPhotoWidget(topMovies, index),
    );
  }
}