import 'package:flutter/material.dart';
import 'package:movies/Browse/browse_widget.dart';
import 'package:movies/Model/Geners.dart';
import 'package:movies/Srevices/API/Api%20repository.dart';

class BrowseScreen extends StatelessWidget {
  const BrowseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Browse Category',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.redAccent,
              ),
            ),
            FutureBuilder<GenersModel>(
              future: ApiRepository.fetchGeners(),
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
                      color: Colors.blue,
                    ),
                  );
                }
                return Expanded(
                  child: GridView.builder(
                    padding: EdgeInsets.all(17),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 3 / 2,
                    ),
                    itemBuilder: (context, index) {
                      return BrowesWidget(
                          snapshot.data!.genres!.elementAt(index));
                    },
                    itemCount: snapshot.data?.genres?.length ?? 0,
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}