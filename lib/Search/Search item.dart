import 'package:flutter/material.dart';
import 'package:movies/Model/Movies and Results.dart';
import 'package:movies/Srevices/Provider.dart';
import 'package:provider/provider.dart';

class SearchItem extends StatelessWidget {
  Results? movieResponse;
  int index;

  SearchItem(this.movieResponse, this.index);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppProvider>(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      width: double.infinity,
      height: 100,
      child: Row(
        children: [
          Flexible(
            child: Stack(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            DetailsScreen(movieResponse),),);
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.network(
                      'https://image.tmdb.org/t/p/w500' +
                          '${movieResponse!.posterPath}',
                      fit: BoxFit.cover,
                      width: 150,
                      height: 100,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    provider.selectMovie(movieResponse!);
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: provider.idList.contains(movieResponse!.id)
                        ? Image.asset('assets/images/ic_check.png')
                        : Image.asset('assets/images/ic_bookmark.png'),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 10),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  movieResponse!.title ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
                SizedBox(height: 5),
                Text(
                  movieResponse!.releaseDate ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13,
                    color: Color.fromRGBO(181, 180, 180, 1.0),
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  movieResponse!.overview ?? '',
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