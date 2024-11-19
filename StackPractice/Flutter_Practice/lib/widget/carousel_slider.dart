import 'package:carousel_slider/carousel_slider.dart';
import 'package:contact/model/movie_model.dart';
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
            )
          ],
        )
      ],
    );
  }
}
