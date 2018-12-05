import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget {
  @override
    Widget build(BuildContext context) {
      return Column(
        children: <Widget>[
          ListTile(
            title: ,
            subtitle: ,
          ),
          Divider(height: 2.0, color: Colors.grey)
        ],
      );
    }

  Widget greyBox() {
    return Container(
      color: Colors.grey[200],
      width: 150.0,
      height: 24.0,
      margin: EdgeInsets.all(),
    );
  }

}