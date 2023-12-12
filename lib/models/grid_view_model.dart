import 'package:flutter/material.dart';

class GridViewModel {
  final String? title;
  final Color? cardColor;
  GridViewModel({this.title, this.cardColor});
}

final List<GridViewModel> gridModel = [
  GridViewModel(
    cardColor: Colors.amberAccent,
    title: 'HOME SCREEN',
  ),
  GridViewModel(
    cardColor: Colors.red,
    title: 'Add SCREEN',
  ),
  GridViewModel(
    cardColor: Colors.blue,
    title: 'Update SCREEN',
  ),
  GridViewModel(
    cardColor: Colors.pink,
    title: 'Delete SCREEN',
  ),
  GridViewModel(
    cardColor: Colors.yellow,
    title: 'View SCREEN',
  ),
];
