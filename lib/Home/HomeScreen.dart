import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies/Home_Contents/New_Relase_Movies/new_relase_widget.dart';
import 'package:movies/Model_From_API/Movies%20and%20Results.dart';
import 'package:movies/Srevices/API/Api%20repository.dart';
import 'package:movies/drawerscreen/drawer.dart';

import '../Home_Contents/TopRated/Top_rated_widget.dart';
import '../Home_Contents/popular/popular_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CarouselController carouselController = CarouselController();

  @override
  void initState() {
    super.initState();
  }

  ////-----------------------------------------------------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      drawer: Drawer(child: drawerScreen()),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FutureBuilder<Movies>(
                future: ApiRepository.fetchPopular(),
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
                  return CarouselSlider(
                    items: snapshot.data!.results!.map((element) {
                      return PopularWidget(element);
                    }).toList(),
                    options: CarouselOptions(
                      height: size.height * 0.40,
                      initialPage: 0,
                      viewportFraction: 1.0,
                      enableInfiniteScroll: true,
                      autoPlay: true,
                      reverse: true,
                      autoPlayInterval: Duration(seconds: 5),
                      autoPlayAnimationDuration: Duration(milliseconds: 700),
                      autoPlayCurve: Curves.linear,
                      scrollDirection: Axis.vertical,
                    ),
                  );
                },
              ),
              ////-----------------------------------------------------------------------------------------------------------------------
              FutureBuilder<Movies>(
                future: ApiRepository.fetchPopular(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    //           get data
                    return NewRelaseWidget(snapshot.data);
                    //------------------------------------------------------------------------------------
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
                  ));
                },
              ),
              ////-----------------------------------------------------------------------------------------------------------------------
              FutureBuilder<Movies>(
                future: ApiRepository.fetchMoviesData(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return TopRatedWidget(snapshot.data);
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
                  ));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}