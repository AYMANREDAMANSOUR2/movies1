import 'package:flutter/material.dart';
import 'package:movies/Model_From_API/Movies%20and%20Results.dart';
import 'package:movies/drawer%20contents/photo.dart';

//                                                                                              Movies in second row
//                                    new_release_widget ==> news_release_item ==> item_Photo_widget
class NewRelaseItemdrawer extends StatelessWidget {
  Movies? topMovies;
  int index;

  NewRelaseItemdrawer(this.topMovies, this.index);

//--------------------------------------------------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 180,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: ItemPhotoWidgetdrawer(topMovies, index),
    );
  }
}
