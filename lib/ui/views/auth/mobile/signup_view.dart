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
                          nameEditingController: nameController,)
                      .signUpCredentials(
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

/*
import 'dart:io';
import 'package:blood_token_app/constants/constants.dart';
import 'package:blood_token_app/models/services_model/user_model.dart';
import 'package:blood_token_app/screens/credientals/login_screen.dart';
import 'package:blood_token_app/widgets/custom_text_form_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rePasswordController = TextEditingController();
  final TextEditingController _bloodGroupController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isObscurePassword1 = true;
  bool _isObscurePassword2 = true;
  bool _isLoading = false;
  File? _image;

  _signUpCredentials() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      String? photoUrl;
      if (_image != null) {
        photoUrl = await _uploadImage();
      }

      // Create a UserModel instance
      UserModel userModel = UserModel(
        uid: userCredential.user!.uid,
        email: _emailController.text,
        displayName: _nameController.text,
        bloodGroup: _bloodGroupController.text,
        phoneNumber: int.parse(_phoneNumberController.text),
        age: int.parse(_ageController.text),
        photoUrl: photoUrl,
      );

      // Convert the UserModel instance to a map and save it to Firestore
      await FirebaseFirestore.instance
          .collection("users")
          .doc(userCredential.user!.uid)
          .set(userModel.toJson());

      // Save user email to shared preferences for autofill in login screen
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('lastUserEmail', _emailController.text);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Sign-up successful!"),
        ),
      );

      Navigator.push(context, MaterialPageRoute(builder: (_) {
        return LogInScreen();
      }));
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: ${e.message}"),
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<String?> _uploadImage() async {
    try {
      // Create a reference to the location where the image will be uploaded
      Reference ref = FirebaseStorage.instance
          .ref()
          .child('user_profile_pictures')
          .child('${_emailController.text}_profile_picture.jpg');

      // Upload the file to Firebase Storage
      UploadTask uploadTask = ref.putFile(_image!);

      // Wait until the upload completes
      await uploadTask.whenComplete(() => null);

      // Get the download URL of the uploaded file
      String downloadUrl = await ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      // Handle any errors during upload
      print("Error uploading image: $e");
      return null;
    }
  }

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
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: size.height,
          width: size.width,
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Container(
              height: size.height,
              width: size.width,
              color: AppUtils.redColor,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: 10),
                              Container(
                                child: Text(
                                  'Welcome to Blood Token\nPlease SignUp to Your Account',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 20.0),
                                ),
                              ),
                              SizedBox(height: 10),
                              GestureDetector(
                                onTap: _getImage,
                                child: CircleAvatar(
                                  radius: 80,
                                  backgroundColor: _image == null
                                      ? AppUtils.redColor
                                      : AppUtils.blueColor,
                                  child: _image == null
                                      ? Center(
                                          child: Icon(Icons.camera_alt_outlined,
                                              color: AppUtils.whiteColor))
                                      : null,
                                  backgroundImage: _image != null
                                      ? FileImage(_image!)
                                      : null,
                                ),
                              ),
                              CustomTextFormField(
                                controller: _nameController,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.name,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your name';
                                  }
                                  return null;
                                },
                                prefixIcon: Icons.person_outline,
                                labelText: 'Name',
                              ),

                              CustomTextFormField(
                                controller: _emailController,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your email';
                                  } else if (!value.contains('@')) {
                                    return 'Please enter a valid email';
                                  }
                                  return null;
                                },
                                prefixIcon: Icons.email_outlined,
                                labelText: 'Email',
                              ),
                              CustomTextFormField(
                                controller: _ageController,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.phone,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your age';
                                  } else if (int.tryParse(value) == null) {
                                    return 'Please enter a valid age';
                                  }
                                  return null;
                                },
                                prefixIcon: Icons.numbers_outlined,
                                labelText: 'Age',
                              ),
                              CustomTextFormField(
                                controller: _phoneNumberController,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.phone,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your phone number';
                                  } else if (value.length != 10) {
                                    return 'Please enter a valid phone number with 11 digits';
                                  }
                                  return null;
                                },
                                prefixIcon: Icons.phone_android_outlined,
                                prefixText: '+92',
                                labelText: 'Phone Number',
                              ),

                              CustomTextFormField(
                                controller: _bloodGroupController,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.name,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your blood group';
                                  } else if (!_isValidBloodGroup(value)) {
                                    return 'Please enter a valid blood group';
                                  }
                                  return null;
                                },
                                prefixIcon: Icons.bloodtype_outlined,
                                labelText: 'Blood Group',
                              ),

                              ///password fields
                              CustomTextFormField(
                                controller: _passwordController,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: _isObscurePassword1,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter a password';
                                  } else if (value.length < 6) {
                                    return 'Password must be at least 6 characters';
                                  }
                                  return null;
                                },
                                prefixIcon: Icons.password,
                                labelText: 'Password',
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _isObscurePassword1 =
                                          !_isObscurePassword1;
                                    });
                                  },
                                  icon: Icon(
                                    _isObscurePassword1
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                ),
                              ),
                              CustomTextFormField(
                                controller: _rePasswordController,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: _isObscurePassword2,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please re-enter your password';
                                  } else if (value !=
                                      _passwordController.text) {
                                    return 'Passwords do not match';
                                  }
                                  return null;
                                },
                                prefixIcon: Icons.password,
                                labelText: 'Re-enter Password',
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _isObscurePassword2 =
                                          !_isObscurePassword2;
                                    });
                                  },
                                  icon: Icon(
                                    _isObscurePassword2
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          AppUtils.redColor),
                                ),
                                onPressed: _isLoading
                                    ? null
                                    : () {
                                        // Check if an image is selected before proceeding with sign-up
                                        if (_image == null) {
                                          Fluttertoast.showToast(
                                              msg: 'Please Select Image');
                                        } else {
                                          _signUpCredentials();
                                        }
                                      },
                                child: _isLoading
                                    ? const Text('Signing Up...')
                                    : const Text(
                                        'Sign Up',
                                        style: TextStyle(
                                            color: AppUtils.whiteColor),
                                      ),
                              ),

                              ///route selection
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Already have account?"),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: AppUtils.whiteColor
                                                .withOpacity(0.2),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text("Sign In"),
                                        ),
                                      ),
                                    ),
                                  ]),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Function to validate blood group
  bool _isValidBloodGroup(String value) {
    List<String> validBloodGroups = [
      'A+',
      'A-',
      'B+',
      'B-',
      'AB+',
      'AB-',
      'O+',
      'O-',
    ];
    String uppercaseValue = value.toUpperCase();
    return validBloodGroups.contains(uppercaseValue);
  }
}
*/
