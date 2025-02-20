import 'package:contact/model/movie_model.dart';
import 'package:flutter/material.dart';

class CircleSlider extends StatelessWidget {
  final List<Movie> movies;
  CircleSlider({super.key, required this.movies}); // movies 초기화

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('미리보기'),
          SizedBox(
            height: 120,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: makeCircleImages(movies),
            ),
          )
        ],
      ),
    );
  }
}

List<Widget> makeCircleImages(List<Movie> movies) {
  List<Widget> results = [];

  for(var i = 0; i < movies.length; i++) {
    results.add(
      InkWell(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.only(right: 10),
          child: Align(
            alignment: Alignment.centerLeft,
            child: CircleAvatar(
              backgroundImage: AssetImage('images/' + movies[i].poster),
              radius: 48,
            ),
          ),
        ),
      )
    );
  }

  return results;
}