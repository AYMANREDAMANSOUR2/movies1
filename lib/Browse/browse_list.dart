import 'package:flutter/material.dart';
import 'package:movies/Model/Geners.dart';
import 'package:movies/Model/Movies%20and%20Results.dart';
import 'package:movies/Srevices/API/Api%20repository.dart';
import 'package:movies/watch/watch_item.dart';

class BrowseList extends StatelessWidget {
  Genres? generResponse;

  BrowseList(this.generResponse);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          '${generResponse!.name} List',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: FutureBuilder<Movies>(
                future: ApiRepository.fetchMoviesList(generResponse!.name!),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'error => ${snapshot.error}',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(
                      child: const CircularProgressIndicator(
                        color: Color.fromRGBO(255, 187, 59, 1.0),
                      ),
                    );
                  }
                  return ListView.separated(
                    itemBuilder: (buildContext, index) {
                      return WatchItem(
                          snapshot.data!.results!.elementAt(index));
                    },
                    separatorBuilder: (buildContext, index) => Container(
                      margin: EdgeInsets.only(
                        left: 2,
                        right: 2,
                        top: 18,
                        bottom: 18,
                      ),
                      width: double.infinity,
                      height: 1,
                      color: Colors.grey,
                    ),
                    itemCount: snapshot.data!.results!.length,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}