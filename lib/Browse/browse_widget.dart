import 'package:flutter/material.dart';
import 'package:movies/Browse/browse_list.dart';
import 'package:movies/Model/Geners.dart';

class BrowesWidget extends StatelessWidget {
  Genres? generResponse;

  BrowesWidget(this.generResponse);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => BrowseList(generResponse!),
          ),
        );
      },
      child: Container(
        width: 160.0,
        height: 90.0,
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            ClipRRect(
              child: Image.asset('assets/images/image_cat.png'),
              borderRadius: BorderRadius.circular(10),
            ),
            Text(
              generResponse?.name ?? '',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}