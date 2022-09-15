import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:movies/Model_From_API/Movies%20and%20Results.dart';
import 'package:movies/drawer%20contents/new%20released%202.dart';
//                                                              we will show it in  second row

class NewRelaseWidget2 extends StatelessWidget {
  Movies? topMovies;

  NewRelaseWidget2(this.topMovies);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      width: double.infinity,
      height: 180,
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      color: Color.fromRGBO(40, 42, 60, 1.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //-----------------------------------------------------
          Center(
            child: Text(
              'enjoy  ',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 15),
          Expanded(
            child: ListView.builder(
              dragStartBehavior: DragStartBehavior.down,
              controller: ScrollController(keepScrollOffset: false),
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, int index) =>
                  NewRelaseItemdrawer(topMovies, index),
              itemCount: topMovies!.results!.length,
            ),
          ),
        ],
      ),
    );
  }
}
