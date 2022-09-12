import 'package:flutter/material.dart';
import 'package:movies/Home/details/Details_Screnn.dart';
import 'package:movies/Model/Movies%20and%20Results.dart';
import 'package:movies/Srevices/Provider.dart';
import 'package:provider/provider.dart';
/////                                                                               small container take data from popular widget

class PopularItem extends StatelessWidget {
  Results? resultResponse;
  PopularItem(this.resultResponse);
//-----------------------------------------------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppProvider>(context);
    return Container(
      width: 150,
      height: 300,
      child: Stack(
        children: [
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => DetailsScreen(resultResponse!),),);
            },
            child: Image.network('https://image.tmdb.org/t/p/w500' + '${resultResponse!.posterPath}', fit: BoxFit.cover, width: 130, height: 200,),
          ),
          InkWell(
            onTap: () {
              provider.selectMovie(resultResponse!);
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: provider.idList.contains(resultResponse!.id)
                  ? Image.asset('assets/images/ic_check.png')
                  : Image.asset('assets/images/ic_bookmark.png'),
            ),
          ),
        ],
      ),
    );
  }
}
// done