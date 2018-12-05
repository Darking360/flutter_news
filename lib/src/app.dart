import 'package:flutter/material.dart';
import 'screens/news_list.dart';
import 'blocs/stories.provider.dart';

class App extends StatelessWidget {
  @override
    Widget build(BuildContext context) {
      return MaterialApp(
        title: 'News!',
        home: StoriesProvider(
          child: NewsList(),
        ),
      );
    }
}