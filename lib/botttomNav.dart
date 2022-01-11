import 'package:flutter/material.dart';


import 'home.dart';
import 'profile.dart';

class BotNav extends StatefulWidget {
  @override
  _BotNavState createState() => _BotNavState();
}

class _BotNavState extends State<BotNav> {
  PageController? pageController;
  int page = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[Home(), Profile()],
        controller: pageController,
        onPageChanged: onPageChanged,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange,
        onPressed: (){},
        child: Icon(
          Icons.search,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.deepOrange,
        shape: CircularNotchedRectangle(),
        child: Container(
          height: kBottomNavigationBarHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              GestureDetector(
                  onTap: () {
                    onTap(0);
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(Icons.home, color: getColor(0)),
                     
                    ],
                  )),
              GestureDetector(
                  onTap: () {
                  
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(Icons.widgets_outlined, color: Colors.grey[300]),
                     
                    ],
                  )),
              GestureDetector(
                  onTap: () {
                    
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(Icons.shopping_cart,color: Colors.grey[300])
                     
                    ],
                  )),
              
              GestureDetector(
                  onTap: () {
                    onTap(1);
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.person, color: getColor(1)),
                  
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Color getColor(int value) {
    return this.page == value
        ? Theme.of(context).primaryColor
        : Color(0XFFBBBBBB);
  }

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: this.page);
  }

  @override
  void dispose() {
    pageController!.dispose();
    super.dispose();
  }

  void onTap(int index) {
    pageController!.jumpToPage(index);
  }

  void onPageChanged(int page) {
    setState(() {
      this.page = page;
    });
  }
}