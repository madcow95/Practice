import 'package:contact/model/movie_model.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

class DetailScreen extends StatefulWidget {
  final Movie movie;

  DetailScreen({required this.movie});

  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool like = false;

  @override
  void initState() {
    super.initState();
    like = widget.movie.like;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: ListView(
      children: [
        Stack(
          children: [
            Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/${widget.movie.poster}'),
                      fit: BoxFit.cover)),
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    alignment: Alignment.center,
                    color: Colors.black.withOpacity(0.1),
                    child: Column(
                      children: [
                        Container(
                            padding: EdgeInsets.fromLTRB(0, 45, 0, 10),
                            height: 300,
                            child:
                                Image.asset('images/${widget.movie.poster}')),
                        Container(
                          padding: EdgeInsets.all(7),
                          child: Text('99% 일치 2019 15+ 시즌 1개',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 13)),
                        ),
                        Container(
                          padding: EdgeInsets.all(7),
                          child: Text(widget.movie.title,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                        ),
                        Container(
                          padding: EdgeInsets.all(3),
                          child: TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.zero),
                                  textStyle: TextStyle(color: Colors.white)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.play_arrow,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    '재생',
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              )),
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          child: Text(widget.movie.toString()),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.all(5),
                          child: Text(
                            '출연: 현빈, 손예진, 서지혜\n제작자: 이정효, 박지은',
                            style: TextStyle(color: Colors.grey),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
            ))
          ],
        )
      ],
    )));
  }
}
