import 'package:flutter/material.dart';
import 'package:shopbiz_app/data/models/ui_models/user_ui_model.dart';
import 'package:shopbiz_app/ui/widgets/auth/custom_button.dart';

class UserDetailsScreen extends StatefulWidget {
  final UserUIModel user;

  const UserDetailsScreen({super.key, required this.user});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${widget.user.name} Details')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            children: [
              if (widget.user.avatar != null)
                CircleAvatar(
                  radius: 80,
                  backgroundImage: NetworkImage(widget.user.avatar!),
                  backgroundColor: Colors.grey[200],
                ),
              const SizedBox(height: 20),
              Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildUserInfo('ID', widget.user.id),
                      _buildUserInfo('Name', widget.user.name),
                      _buildUserInfo('Email', widget.user.email),
                      _buildUserInfo('City', widget.user.city),
                      _buildUserInfo('Phone Number', widget.user.phone),
                      _buildUserInfo('Employment Status', widget.user.job),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Center(child: CustomButton(title: 'Save', onPressed: () {})),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserInfo(String title, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$title:',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(
              value ?? 'N/A',
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
