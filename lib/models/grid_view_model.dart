class GridViewModel {
  ///var
  final String? title;

  ///const
  GridViewModel({this.title});
}

final List<GridViewModel> gridModel = [
  GridViewModel(title: 'Add Screen'),
  GridViewModel(title: 'Update Screen'),
  GridViewModel(title: 'Delete Screen'),
  GridViewModel(title: 'View Screen'),
];
