import 'package:flutter/material.dart';
import 'package:movies/Model_From_API/Movies%20and%20Results.dart';
import 'package:movies/Srevices/Provider.dart';
import 'package:movies/details/Details_Screnn.dart';
import 'package:provider/provider.dart';

class ItemPhotoWidgetdrawer extends StatelessWidget {
  Movies? movies;
  int index;

  ItemPhotoWidgetdrawer(this.movies, this.index);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppProvider>(context);
    return Stack(
      children: [
        // image from API
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) =>
                    DetailsScreen(movies!.results!.elementAt(index)),
              ),
            );
            // Navigator.pushNamed(
            //   context,
            //   DetailsScreen.routeName,
            //   arguments: topMovies,
            // );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.network(
              'https://image.tmdb.org/t/p/w500' +
                  '${movies!.results!.elementAt(index).posterPath}',
              fit: BoxFit.cover,
              width: 250,
              height: 160,
            ),
          ),
        ),
        //ADD to watchList by provider
        InkWell(
          onTap: () {
            provider.selectMovie(movies!.results!.elementAt(index));
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child:
                provider.idList.contains(movies!.results!.elementAt(index).id)
                    ? Image.asset('assets/images/ic_check.png')
                    : Icon(
                        Icons.watch_later,
                        size: 30,
                        color: Colors.greenAccent,
                        shadows: [Shadow(color: Colors.purple, blurRadius: 10)],
                      ),
          ),
        ),
      ],
    );
  }
}
