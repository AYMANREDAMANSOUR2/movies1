import 'package:flutter/material.dart';
import 'package:movies/Model/Movies%20and%20Results.dart';
import 'package:movies/Srevices/Provider.dart';
import 'package:movies/watch/watch_item.dart';
import 'package:provider/provider.dart';

class WatchListScreen extends StatefulWidget {
  @override
  State<WatchListScreen> createState() => _WatchListScreenState();
}

class _WatchListScreenState extends State<WatchListScreen> {
  Movies? movies;
  late AppProvider provider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AppProvider>(context);
    return SafeArea(
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(left: 10, right: 10, top: 30),
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                'Watchlist',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 20),
            provider.idList.isNotEmpty
                ? Expanded(
              child: ListView.separated(
                itemBuilder: (buildContext, index) {
                  return WatchItem(provider.watchList.elementAt(index));
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
                itemCount: provider.watchList.length,
              ),
            )
                : Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.local_movies,
                    color: Color.fromRGBO(181, 180, 180, 1.0),
                    size: 150,
                  ),
                  Text(
                    'No movies select yet.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color.fromRGBO(181, 180, 180, 1.0),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}