import 'package:flutter/material.dart';
import 'package:movies/Home/details/more%20movies%20widget.dart';
import 'package:movies/Model/Movies%20and%20Results.dart';
import 'package:movies/Srevices/API/Api%20repository.dart';
import 'package:movies/Srevices/Provider.dart';
import 'package:provider/provider.dart';

class DetailsScreen extends StatelessWidget {
  Results? movieResult;

  DetailsScreen(this.movieResult);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppProvider>(context);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(movieResult!.title ?? ''),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: size.height * 0.22,
                    child: Stack(
                      children: [
                        Image.network(
                          'https://image.tmdb.org/t/p/w500' +
                              '${movieResult?.backdropPath ?? ''}',
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                        Positioned(
                          left: size.width * 0.40,
                          top: size.height * 0.08,
                          child: Icon(
                            Icons.play_circle_filled,
                            size: 70,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Text(
                      movieResult?.title ?? '',
                      overflow: TextOverflow.visible,
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      movieResult?.releaseDate ?? '',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color.fromRGBO(181, 180, 180, 1.0),
                      ),
                    ),
                    // PopularItem(movies),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 190,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    width: 130,
                    height: 300,
                    child: Stack(
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Image.network(
                            'https://image.tmdb.org/t/p/w500' +
                                '${movieResult!.posterPath}',
                            fit: BoxFit.cover,
                            width: 130,
                            height: 200,
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
                  ),
                  // PopularItem(movies),
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Padding(
                          // No attribute in the API refers to movie Type !!!!!!!!!!!!!!!!
                          // No attribute in the API refers to movie Type !!!!!!!!!!!!!!!!
                          // No attribute in the API refers to movie Type !!!!!!!!!!!!!!!!
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            'Action',
                            style: TextStyle(color: Colors.grey, fontSize: 18),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          movieResult!.overview ?? '',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 20,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '${movieResult!.voteAverage}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            FutureBuilder<Movies>(
              future: ApiRepository.fetchSimilar(
                movieResult?.id ?? 0,
              ),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return MoreMoviesWidget(snapshot.data);
                } else if (snapshot.hasError) {
                  return Center(
                      child: Text(
                        '${snapshot.error}',
                        style: TextStyle(color: Colors.white),
                      ));
                }
                return Center(
                  child: const CircularProgressIndicator(
                    color: Color.fromRGBO(255, 187, 59, 1.0),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}