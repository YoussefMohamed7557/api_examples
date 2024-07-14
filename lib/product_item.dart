import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';

class ProductItem extends StatefulWidget {
  List<String> imagesLink = [
    "https://hips.hearstapps.com/hmg-prod/images/close-up-of-tulips-blooming-in-field-royalty-free-image-1584131603.jpg"
  ];

  String productName;
  String productDescription;
  String shopName;
  String shopEmail;

  ProductItem(
      {required this.imagesLink,
      required this.productName,
      required this.shopName,
      required this.shopEmail,
      required this.productDescription});

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  bool inWishList = false;
  int _currentIndex = 0;
  late Timer _timer;
  // getNextPosition(){
  //   print("position: $_currentIndex");
  //   _currentIndex++;
  //   if(_currentIndex ==3){
  //     _currentIndex =0;
  //   }
  //   setState(() {});
  // }
  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % widget.imagesLink.length;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      color: Color.fromRGBO(144, 205, 198, 0.16470588235294117),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(top: 8),
            height: MediaQuery.of(context).size.height*0.25,
            width: MediaQuery.of(context).size.width,

            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                AnimatedSwitcher(

                  duration: Duration(seconds: 1),
                  child: Image.network(
                    widget.imagesLink[_currentIndex],
                    key: ValueKey<String>(widget.imagesLink[_currentIndex]),
                  ),
                    transitionBuilder: (Widget child, Animation<double> animation) {
                      return SlideTransition(
                        position: Tween<Offset>(
                          begin: Offset(1.0, 0.0),
                          end: Offset(0.0, 0.0),
                        ).animate(animation),
                        child: child,
                      );
                    }
                ),
                DotsIndicator(
                  dotsCount: widget.imagesLink.length,
                  position: _currentIndex,
                  decorator: DotsDecorator(
                    size: const Size.square(9.0),
                    activeSize: const Size(18.0, 9.0),
                    activeShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    color: Colors.blue,
                  ),
                ),
                Positioned(
                    right: 40,
                    top: 20,
                    child: GestureDetector(
                        onTap: () {
                          if (inWishList) {
                            inWishList = false;
                          } else {
                            inWishList = true;
                          }
                          setState(() {});
                        },
                        child: inWishList
                            ? Icon(
                                Icons.favorite,
                                size: 45,
                                color: Colors.red,
                              )
                            : Icon(
                                Icons.favorite_border_outlined,
                                size: 45,
                                color: Colors.blueGrey,
                              )))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
            child: Text(
              '${widget.productName}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Text(
              '${widget.productDescription}',
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 16,
                  fontWeight: FontWeight.w300),
            ),
          ),
          ListTile(
            leading: SizedBox(
              height: 60,
              width: 60,
              child: Image.network(
                  'https://images.pexels.com/photos/5531004/pexels-photo-5531004.jpeg?auto=compress&cs=tinysrgb&w=1200'),
            ),
            title: Text("${widget.shopName}"),
            subtitle: Text("${widget.shopEmail}"),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _timer.cancel();
    super.dispose();
  }
}
