import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopbiz_app/core/constants/app_colors.dart';
import 'package:shopbiz_app/data/repositories/auth_repository.dart';

class SignUpMobileView extends StatefulWidget {
  @override
  _SignUpMobileViewState createState() => _SignUpMobileViewState();
}

class _SignUpMobileViewState extends State<SignUpMobileView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController1 = TextEditingController();
  final TextEditingController passwordController2 = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  File? _image;
  bool _isLoading = false;
  bool _isObscurePassword1 = true;
  bool _isObscurePassword2 = true;
  int _selectedOption = 2;

  @override
  void dispose() {
    emailController.dispose();
    passwordController1.dispose();
    passwordController2.dispose();
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  bool get isAdmin => _selectedOption == 1;

  Future<void> _getImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    } else {
      Fluttertoast.showToast(msg: 'Image Not Picked');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign Up")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: "Name"),
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: "Email"),
                keyboardType: TextInputType.emailAddress,
              ),
              TextField(
                controller: passwordController1,
                decoration: InputDecoration(
                  labelText: "Password",
                  suffixIcon: IconButton(
                    icon: Icon(_isObscurePassword1
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _isObscurePassword1 = !_isObscurePassword1;
                      });
                    },
                  ),
                ),
                obscureText: _isObscurePassword1,
              ),
              TextField(
                controller: passwordController2,
                decoration: InputDecoration(
                  labelText: "Confirm Password",
                  suffixIcon: IconButton(
                    icon: Icon(_isObscurePassword2
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _isObscurePassword2 = !_isObscurePassword2;
                      });
                    },
                  ),
                ),
                obscureText: _isObscurePassword2,
              ),
              Row(
                children: [
                  Column(
                    children: [
                      Radio<int>(
                        activeColor: AppColors.kPrimaryColor,
                        value: 1,
                        groupValue: _selectedOption,
                        onChanged: (int? value) {
                          setState(() {
                            _selectedOption = value!;
                          });
                        },
                      ),
                      Text('Admin'),
                    ],
                  ),
                  SizedBox(width: 20),
                  Column(
                    children: [
                      Radio<int>(
                        activeColor: AppColors.kPrimaryColor,
                        value: 2,
                        groupValue: _selectedOption,
                        onChanged: (int? value) {
                          setState(() {
                            _selectedOption = value!;
                          });
                        },
                      ),
                      Text('User'),
                    ],
                  ),
                ],
              ),
              TextField(
                controller: phoneController,
                decoration: InputDecoration(labelText: "Phone Number"),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  bool isAdmin = _selectedOption == 1;

                  AuthRepository(
                    emailEditingController: emailController,
                    passwordEditingController: passwordController1,
                    rePassEditingController: passwordController2,
                    phonEditingController: phoneController,
                    nameEditingController: nameController,
                  ).signUpCredentials(
                    context,
                    isAdmin: isAdmin,
                  );
                },
                child:
                    _isLoading ? CircularProgressIndicator() : Text("Sign Up"),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _getImage,
                child: Text("Pick Profile Picture"),
              ),
              if (_image != null) ...[
                SizedBox(height: 20),
                Image.file(_image!, height: 100),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
