import 'package:flutter/material.dart';
import 'package:shopbiz_app/screens/crud_screens/add_product_screen.dart';
import 'package:shopbiz_app/screens/crud_screens/delete_product_screen.dart';
import 'package:shopbiz_app/screens/crud_screens/update_product_screen.dart';
import 'package:shopbiz_app/screens/crud_screens/view_product_screen.dart';

class GridViewModel {
  ///var
  final String? title;

  ///const
  GridViewModel({this.title});
}

///gid model
final List<GridViewModel> gridModel = [
  GridViewModel(title: 'Add Screen'),
  GridViewModel(title: 'Update Screen'),
  GridViewModel(title: 'Delete Screen'),
  GridViewModel(title: 'View Screen'),
];

// list of colors
List<Color> gridViewModelCardColors = [
  Colors.red,
  Colors.blue,
  Colors.pink,
  Colors.yellow,
];

// navigating through out
navigateToScreen(BuildContext context, String screenTitle) {
  if (screenTitle == 'Add Screen') {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const AddProductScreen()));
  } else if (screenTitle == 'Update Screen') {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const UpdateProductScreen()));
  } else if (screenTitle == 'Delete Screen') {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const DeleteProductScreen()));
  } else {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const ViewProductScreen()));
  }
}


/*
void _navigateToScreen(BuildContext context, String screenTitle) {
    // You can replace the following switch statement with your own logic
    // to navigate to the desired screens based on the screen title.
    switch (screenTitle) {
      case 'Add Screen':
        Navigator.push(context, MaterialPageRoute(builder: (context) => AddScreen()));
        break;
      case 'Update Screen':
        Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateScreen()));
        break;
      case 'Delete Screen':
        Navigator.push(context, MaterialPageRoute(builder: (context) => DeleteScreen()));
        break;
      case 'View Screen':
        Navigator.push(context, MaterialPageRoute(builder: (context) => ViewScreen()));
        break;
      default:
        // Handle other cases if needed
        break;
    }
  }
}
 */