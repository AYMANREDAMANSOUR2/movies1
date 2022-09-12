import 'package:flutter/material.dart';
import 'package:movies/Model/Movies and Results.dart';
import 'package:movies/Search/Search%20item.dart';
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

              onChanged: (String? value) {
                searchKey = value ?? '';
                setState(() {});
              },
              style: TextStyle(
                color: Colors.white,
              ),
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                filled: true,
                fillColor: Color.fromRGBO(81, 79, 79, 1.0),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                enabled: true,
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 24,
                ),
                hintText: 'search',
                hintStyle: TextStyle(
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
                    loadSearchData().elementAt(index), index);
              },
              separatorBuilder: (BuildContext context, index) {
                return Container(
                  margin: EdgeInsets.only(
                      left: 2, right: 2, top: 18, bottom: 18),
                  width: double.infinity,
                  height: 1,
                  color: Color.fromRGBO(181, 180, 180, 1.0),
                );
              },
              itemCount: loadSearchData().length,
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
                  'No movies found',
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
    );
  }
//------------------------------------------------------------------------------------------
  List loadSearchData() {
    ApiRepository.fetchSearch(searchKey).then((value) {
      result = value.results ?? [];
    }).onError((error, stackTrace) {
      print('error => ${error.toString()}');
    });
    return result;
  }
}