import 'package:contact/model/movie_model.dart';
import 'package:contact/widget/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../widget/top_bar.dart';

class HomeScreen extends StatefulWidget {
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Movie> movies = [
    Movie.fromMap(
        {
          'title': '사랑의 불시착',
          'keyword': '사랑/로맨스/판타지',
          'poster': 'test_movie_1.png',
          'like': false
        }
    )
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        TopBar(),
        CarouselImage(movies: movies)
      ],
    );
  }
}