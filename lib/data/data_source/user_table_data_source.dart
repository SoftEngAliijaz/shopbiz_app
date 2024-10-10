import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shopbiz_app/admin/screens/users/user_details.dart';
import 'package:shopbiz_app/data/models/user_ui_model.dart';

class UsersDataTableSource extends DataTableSource {
  final List<UserUIModel> users;
  final BuildContext context;

  UsersDataTableSource(this.users, this.context);

  @override
  DataRow? getRow(int index) {
    if (index >= users.length) return null;

    final user = users[index];

    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(user.id ?? '')),
        DataCell(user.avatar != null
            ? CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(user.avatar!))
            : const Text('No Avatar')),
        DataCell(Text(user.name ?? '')),
        DataCell(Text(user.email ?? '')),
        DataCell(Text(user.city ?? '')),
        DataCell(Text(user.job ?? '')),
        DataCell(Text(user.phone ?? '')),
      ],
      onSelectChanged: (isSelected) {
        if (isSelected != null && isSelected) {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return UserDetailsScreen(user: user);
          }));
        }
      },
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => users.length;

  @override
  int get selectedRowCount => 0;
}
