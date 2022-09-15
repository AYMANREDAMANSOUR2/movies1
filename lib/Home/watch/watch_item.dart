import 'package:flutter/material.dart';
import 'package:movies/Model_From_API/Movies%20and%20Results.dart';
import 'package:movies/Srevices/Provider.dart';
import 'package:movies/details/Details_Screnn.dart';
import 'package:provider/provider.dart';

class WatchItem extends StatelessWidget {
  Results? movieResult;

  WatchItem(this.movieResult);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppProvider>(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      width: double.infinity,
      height: 100,
      child: Row(
        children: [
          Stack(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          DetailsScreen(movieResult!),
                    ),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.network(
                    'https://image.tmdb.org/t/p/w500' +
                        '${movieResult!.posterPath}',
                    fit: BoxFit.cover,
                    width: 150,
                    height: 100,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  provider.selectMovie(movieResult!);
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: provider.idList.contains(movieResult!.id)
                      ? Image.asset('assets/images/ic_check.png')
                      : Image.asset('assets/images/ic_bookmark.png'),
                ),
              ),
            ],
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  movieResult!.title ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  movieResult!.releaseDate ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13,
                    color: Color.fromRGBO(181, 180, 180, 1.0),
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  movieResult!.overview ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13,
                    color: Color.fromRGBO(181, 180, 180, 1.0),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}