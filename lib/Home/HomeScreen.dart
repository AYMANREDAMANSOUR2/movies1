import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies/Home/New_Relase_Movies/new_relase_widget.dart';
import 'package:movies/Home/TopRated/Top_rated_widget.dart';
import 'package:movies/Home/popular/popular_widget.dart';
import 'package:movies/Model/Movies%20and%20Results.dart';
import 'package:movies/Srevices/API/Api%20repository.dart';

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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
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
                    height: size.height * 0.30,
                    initialPage: 0,
                    viewportFraction: 1.0,
                    enableInfiniteScroll: true,
                    autoPlay: true,
                    reverse: false,
                    autoPlayInterval: Duration(seconds: 8),
                    autoPlayAnimationDuration: Duration(milliseconds: 400),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    scrollDirection: Axis.horizontal,
                  ),
                );
              },
            ),
            FutureBuilder<Movies>(
              future: ApiRepository.fetchPopular(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return NewRelaseWidget(snapshot.data);
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
    );
  }
}