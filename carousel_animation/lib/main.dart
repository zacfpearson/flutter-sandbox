import 'package:flutter/material.dart';

class CarouselAnimationApp extends StatefulWidget {
  @override
  _CarouselAnimationState createState() => _CarouselAnimationState();
}

class _CarouselAnimationState extends State<CarouselAnimationApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CarouselAnimation',
      home: new SnapCarousel(),
    );
  }
}

class SnapCarousel extends StatefulWidget{
  @override
  SnapCarouselState createState() => new SnapCarouselState();
}

class SnapCarouselState extends State<SnapCarousel> with SingleTickerProviderStateMixin
{
  AnimationController _controller;
  ScrollController _scrollController = new ScrollController();
  Animation<Offset> _animRtoLTop;
  Animation<Offset> _animRtoLBottom;
  Animation<Offset> _animLtoRTop;
  Animation<Offset> _animLtoRBottom;
  bool _swipeRightToLeft = true;
  int _currentIndex = 0;
  double _cardWidth = 300.0;
  double _cardMargin = 10.0;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _animRtoLTop = Tween(begin: Offset(0.0, 0.0), end: Offset(50.0, 0.0))
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut))
          ..addListener(() {
            setState(() {});
          });

    _animRtoLBottom = Tween(begin: Offset(0.0, 0.0), end: Offset(100.0, 0.0))
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _animLtoRTop = Tween(begin: Offset(0.0, 0.0), end: Offset(25.0, 0.0))
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _animLtoRBottom = Tween(begin: Offset(0.0, 0.0), end: Offset(-20.0, 0.0))
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text('CarouselAnimation'),
        ),
        body: GestureDetector(
          onHorizontalDragEnd: _onHorizontalDragEnd,
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 20.0),
            height: 200.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              physics: NeverScrollableScrollPhysics(),
              controller: _scrollController,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200.0,
                  child: GridView.count(
                      mainAxisSpacing: 0.0,
                      crossAxisSpacing: 0.0,
                      crossAxisCount: 7,
                      children: List.generate(15, (index) {
                        return Card(child: Text('1: $index'),);
                      }),
                    ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200.0,
                  child: GridView.count(
                      mainAxisSpacing: 0.0,
                      crossAxisSpacing: 0.0,
                      crossAxisCount: 7,
                      children: List.generate(15, (index) {
                        return Card(child: Text('2: $index'),);
                      }),
                    ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200.0,
                  child: GridView.count(
                      mainAxisSpacing: 0.0,
                      crossAxisSpacing: 0.0,
                      crossAxisCount: 7,
                      children: List.generate(15, (index) {
                        return Card(child: Text('3: $index'),);
                      }),
                    ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200.0,
                  child: GridView.count(
                      mainAxisSpacing: 0.0,
                      crossAxisSpacing: 0.0,
                      crossAxisCount: 7,
                      children: List.generate(15, (index) {
                        return Card(child: Text('4: $index'),);
                      }),
                    ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200.0,
                  child: GridView.count(
                      mainAxisSpacing: 0.0,
                      crossAxisSpacing: 0.0,
                      crossAxisCount: 7,
                      children: List.generate(15, (index) {
                        return Card(child: Text('5: $index'),);
                      }),
                    ),
                ),
              ],
            ),
          ),
        ),
      );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    if (details.primaryVelocity < 0) {
      //SWIPED Right to Left!!

      if (_currentIndex < (5) - 1) {
        setState(() {
          _swipeRightToLeft = true;
          _currentIndex += 1;
        });
        double offset = MediaQuery.of(context).size.width;
        _scrollController.animateTo(offset * _currentIndex,
            duration: Duration(milliseconds: 400), curve: Curves.easeOut);

        _controller.forward().then((s) {
          _controller.reverse();
        });
      }
    } else if (details.primaryVelocity > 0) {
      //SWIPED Left to Right!
      if (_currentIndex > 0) {
        setState(() {
          _swipeRightToLeft = false;
          _currentIndex -= 1;
        });
        double offset = MediaQuery.of(context).size.width;
        _scrollController.animateTo(offset * _currentIndex,
            duration: Duration(milliseconds: 400), curve: Curves.easeOut);

        _controller.forward().then((s) {
          _controller.reverse();
        });
      }
    }
  }
}

void main() => runApp(CarouselAnimationApp());