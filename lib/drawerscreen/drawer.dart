import 'package:flutter/material.dart';
import 'package:movies/Home/ItemPhotoWidget.dart';
import 'package:movies/Home_Contents/New_Relase_Movies/new_relase_widget.dart';
import 'package:movies/Model_From_API/Movies%20and%20Results.dart';
import 'package:movies/Srevices/API/Api%20repository.dart';
import 'package:movies/drawer%20contents/Released%20movies.dart';
import 'package:movies/video.dart';

class drawerScreen extends StatefulWidget {
  const drawerScreen({Key? key}) : super(key: key);

  @override
  _Drawer4DrawerPageState createState() => _Drawer4DrawerPageState();
}

class _Drawer4DrawerPageState extends State<drawerScreen>
    with TickerProviderStateMixin {
  bool menuShown = false;
  double appbarHeight = 80.0;
  double menuHeight = 0.0;
  late Animation<double> openAnimation, closeAnimation;
  late AnimationController openController, closeController;

  @override
  void initState() {
    super.initState();
    openController = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    closeController = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    openAnimation = Tween(begin: 0.0, end: 1.0).animate(openController)
      ..addListener(() {
        setState(() {
          menuHeight = openAnimation.value;
        });
      });
    closeAnimation = Tween(begin: 1.0, end: 0.0).animate(closeController)
      ..addListener(() {
        setState(() {
          menuHeight = closeAnimation.value;
        });
      });
  }

  _handleMenuPress() {
    setState(() {
      openController.reset();
      closeController.reset();
      menuShown = !menuShown;
      menuShown ? openController.forward() : closeController.forward();
    });
  }

  @override
  void dispose() {
    openController.dispose();
    closeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              color: Color.fromRGBO(26, 26, 26, 1.0),
              height: menuHeight,
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          menuShown ? Icons.cancel : Icons.menu,
                        ),
                        color: Colors.white,
                        onPressed: _handleMenuPress,
                      ),
                      Text(menuShown ? "Menu" : "Movies you may like  ",
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 25.0))
                    ],
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                  Expanded(
                    child: ListView(
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, VideoScreen.routeName);
                          },
                          child: Container(
                              decoration: BoxDecoration(color: Colors.black),
                              padding: const EdgeInsets.all(10),
                              alignment: Alignment.center,
                              child: const Text("Home",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 28.0,
                                  ))),
                        ),
                        SizedBox(
                          height: 10,
                          child: Container(
                            color: Colors.white,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, Logo.routeName);
                          },
                          child: Container(
                              decoration: BoxDecoration(color: Colors.black),
                              padding: const EdgeInsets.all(10.0),
                              alignment: Alignment.center,
                              child: const Text("Profile",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 28.0,
                                  ))),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            LayoutBuilder(
              builder: (context, constraints) {
                return Container(
                  margin: EdgeInsets.only(
                      top: menuHeight * (constraints.maxHeight - 90) + 90),
                  color: Colors.transparent,
                  child: Material(
                    elevation: 20.0,
                    shape: const BeveledRectangleBorder(
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(46.0)),
                    ),
                    child: FutureBuilder<Movies>(
                      future: ApiRepository.fetchPopular2(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          //           get data
                          return NewRelaseWidget2(snapshot.data);
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

class Logo extends StatefulWidget {
  const Logo({Key? key}) : super(key: key);
  static const String routeName = "logo";

  @override
  State<Logo> createState() => _LogoState();
}

class _LogoState extends State<Logo> {
  bool _isInitialValue = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SingleChildScrollView(
          child: AnimatedContainer(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.black38,
            ),
            duration: const Duration(seconds: 4),
            width: 400,
            height: 400,
            padding: EdgeInsets.all(_isInitialValue ? 0 : 40),
            child: Image.asset(
              'assets/images/Background2.jpg',
              fit: BoxFit.cover,
            ),
          ),
        ),
        Center(
          child: OutlinedButton(
            child: const Text(
              'logo',
              style: TextStyle(color: Colors.white, fontSize: 35),
            ),
            onPressed: () {
              setState(() {
                _isInitialValue = !_isInitialValue;
              });
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .38,
              ),
              Text(
                ' ayman reda ',
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
              Text(
                ' ahmed nemr ',
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
