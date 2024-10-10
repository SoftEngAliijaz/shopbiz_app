import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shopbiz_app/core/constants/app_colors.dart';
import 'package:shopbiz_app/core/constants/app_constants.dart';
import 'package:shopbiz_app/data/data_source/user_table_data_source.dart';
import 'package:shopbiz_app/data/models/user_ui_model.dart';
import 'package:http/http.dart' as http;

class ViewAllUsersScreen extends StatefulWidget {
  const ViewAllUsersScreen({super.key});

  @override
  _ViewAllUsersScreenState createState() => _ViewAllUsersScreenState();
}

class _ViewAllUsersScreenState extends State<ViewAllUsersScreen> {
  List<UserUIModel> users = [];
  int rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    final response =
        await http.get(Uri.parse('${AppConstants.baseUrl}/getAllUsers'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      setState(() {
        users = jsonData.map((json) => UserUIModel.fromJson(json)).toList();
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load users');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: PaginatedDataTable(
                header: const Text('View All Users'),
                actions: [
                  ElevatedButton(
                      style: ButtonStyle(
                          shape: WidgetStateProperty.all(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0))),
                          backgroundColor:
                              WidgetStateProperty.all(AppColors.kPrimaryColor)),
                      onPressed: () {},
                      child: Text("+ Add New User",
                          style: TextStyle(color: AppColors.kWhiteColor))),
                ],
                columns: const [
                  DataColumn(label: Text('ID')),
                  DataColumn(label: Text('Avatar')),
                  DataColumn(label: Text('Name')),
                  DataColumn(label: Text('Email')),
                  DataColumn(label: Text('City')),
                  DataColumn(label: Text('Employement Status')),
                  DataColumn(label: Text('Phone Number')),
                ],
                source: UsersDataTableSource(users, context),
                rowsPerPage: 20,
                showFirstLastButtons: true,
                showEmptyRows: false,
                showCheckboxColumn: true,
                onRowsPerPageChanged: (value) {
                  setState(() {
                    rowsPerPage = value!;
                  });
                },
              ),
            ),
    );
  }
}
