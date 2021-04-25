import 'package:flutter/material.dart';

class Model {
  String link, name;
  Model({this.link, this.name});
}

// Class CategoryTwo{
//   String name
// }

class Category {
  String name;
  Color color;
  List<String> list;
  Category(
      {this.name,
      this.list,
      // this.description,
      this.color});
}
