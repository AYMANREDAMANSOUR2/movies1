import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:movies/Home/Search/Search%20item.dart';
import 'package:movies/Model_From_API/Movies%20and%20Results.dart';
import 'package:movies/Srevices/API/Api%20repository.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController textController = TextEditingController();
  List<Results> result = [];
  String searchKey = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 35, vertical: 12),
            height: 48,
            child: TextFormField(
              // controller: textController,
              onChanged: (String? value) {searchKey = value ?? '';setState(() {});},
              style: TextStyle(
                color: Colors.orangeAccent,
              ),
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.orangeAccent, width: 2,),
                  borderRadius: BorderRadius.circular(30),
                ),
                filled: false,
                // fillColor: Color.fromRGBO(81, 79, 79, 1.0),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.greenAccent,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(35),
                ),
                enabled: true,
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.blueAccent,
                  size: 24,
                ),
                hintText: 'search',
                hintStyle: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          searchKey.isNotEmpty
              ? Expanded(
            child: ListView.separated(
              itemBuilder: (BuildContext context, index) {
                return SearchItem(
                    loadSearchData().elementAt(index), index); // load search from Api
              },
              separatorBuilder: (BuildContext context, index) {return Container(
                  margin: EdgeInsets.only(left: 2, right: 2, top: 18, bottom: 18),
                  width: double.infinity,
                  height: 1,
                  color: Color.fromRGBO(181, 180, 180, 1.0),
                );},
              itemCount: loadSearchData().length,
            ),
          )
              : Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset("assets/images/1961-movie-loading.json") ,
                Lottie.asset("assets/images/60901-no-search-results-animation.json", width: 50,height: 50)
              ],
            ),
          ),
        ],
      ),
    );
  }
//-------------------------------------------------------------------------------------------------------------------
  List loadSearchData() {
    ApiRepository.fetchSearch(searchKey).then((value) {
      result = value.results ?? [];
    }).onError((error, stackTrace) {
      print('error => ${error.toString()}');
    });
    return result;
  }
}