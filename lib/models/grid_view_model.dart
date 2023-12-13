import 'package:flutter/material.dart';

class GridViewModel {
  final String? title;
  final Color? cardColor;
  GridViewModel({this.title, this.cardColor});
}

final List<GridViewModel> gridModel = [
  GridViewModel(
    cardColor: Colors.red,
    title: 'Add Screen',
  ),
  GridViewModel(
    cardColor: Colors.blue,
    title: 'Update Screen',
  ),
  GridViewModel(
    cardColor: Colors.pink,
    title: 'Delete Screen',
  ),
  GridViewModel(
    cardColor: Colors.yellow,
    title: 'View Screen',
  ),
];
