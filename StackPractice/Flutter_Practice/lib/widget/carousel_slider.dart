import 'dart:core';
import 'dart:core';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:contact/model/movie_model.dart';
import 'package:contact/screen/detail_screen.dart';
import 'package:flutter/material.dart';

class CarouselImage extends StatefulWidget {
  final List<Movie> movies;

  CarouselImage({required this.movies});

  _CarouselImageState createState() => _CarouselImageState();
}

class _CarouselImageState extends State<CarouselImage> {
  late List<Movie> movies;
  late List<Widget> images;
  late List<String> keywords;
  late List<bool> likes;
  late String _currentKeyword;
  late int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    movies = widget.movies;
    images =
        movies.map((movie) => Image.asset('./images/' + movie.poster)).toList();
    keywords = movies.map((movie) => movie.keyword).toList();
    likes = movies.map((movie) => movie.like).toList();
    _currentKeyword = keywords[0];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(20),
        ),
        CarouselSlider(
            options: CarouselOptions(
                height: 400,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentPage = index;
                    _currentKeyword = keywords[_currentPage];
                  });
                }),
            items: images),
        Container(
          padding: EdgeInsets.fromLTRB(0, 10, 0, 3),
          child: Text(
            _currentKeyword,
            style: TextStyle(fontSize: 11),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                likes[_currentPage]
                    ? IconButton(onPressed: () {}, icon: Icon(Icons.check))
                    : IconButton(onPressed: () {}, icon: Icon(Icons.add)),
                Text(
                  '내가 찜한 콘텐츠',
                  style: TextStyle(fontSize: 11),
                )
              ],
            ),
            Container(
              padding: EdgeInsets.only(right: 10),
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero)),
                child: Row(
                  children: const [
                    Icon(
                      Icons.play_arrow,
                      color: Colors.black,
                    ),
                    Padding(padding: EdgeInsets.all(3)),
                    Text(
                      '재생',
                      style: TextStyle(color: Colors.black),
                    )
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(right: 10),
              child: Column(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute<Null>(
                            fullscreenDialog: true,
                            builder: (BuildContext context) {
                              return DetailScreen(movie: movies[_currentPage]);
                            }));
                      },
                      icon: Icon(Icons.info)),
                  Text(
                    '정보',
                    style: TextStyle(fontSize: 11),
                  )
                ],
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: makeIndicator(likes, _currentPage),
        )
      ],
    );
  }
}

List<Widget> makeIndicator(List list, int currentPage) {
  List<Widget> results = [];

  for (var i = 0; i < list.length; i++) {
    results.add(Container(
      width: 8,
      height: 8,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 2),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: currentPage == i
              ? Color.fromRGBO(255, 255, 255, 0.9)
              : Color.fromRGBO(255, 255, 255, 0.4)),
    ));
  }

  return results;
}
