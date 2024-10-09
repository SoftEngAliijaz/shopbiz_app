import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopbiz_app/core/constants/app_colors.dart';
import 'package:shopbiz_app/data/models/auth_model.dart';
import 'package:shopbiz_app/ui/screens/app_main/home/home_screen.dart';
import 'package:shopbiz_app/ui/widgets/app/text_form_field.dart';
import 'package:shopbiz_app/ui/widgets/auth/auth_circle_div.dart';
import 'package:shopbiz_app/ui/widgets/auth/custom_button.dart';

class SignUpMobileView extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController rePasswordController;
  final TextEditingController phoneNumberController;
  final GlobalKey<FormState> formKey;

  SignUpMobileView({
    Key? key,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.rePasswordController,
    required this.phoneNumberController,
    required this.formKey,
  }) : super(key: key);

  @override
  State<SignUpMobileView> createState() => _SignUpMobileViewState();
}

class _SignUpMobileViewState extends State<SignUpMobileView> {
  bool _isObscurePassword1 = true;
  bool _isObscurePassword2 = true;
  bool _isLoading = false;
  File? _image;

  _signUpCredentials() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: widget.emailController.text,
        password: widget.passwordController.text,
      );

      String? photoUrl;
      if (_image != null) {
        photoUrl = await _uploadImage();
      }

      AuthModel userModel = AuthModel(
        uid: userCredential.user!.uid,
        email: widget.emailController.text,
        displayName: widget.nameController.text,
        phoneNumber: int.parse(widget.phoneNumberController.text),
        photoUrl: photoUrl,
      );

      await FirebaseFirestore.instance
          .collection("users")
          .doc(userCredential.user!.uid)
          .set(userModel.toJson());

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Sign-up successful!"),
        ),
      );

      Navigator.push(context, MaterialPageRoute(builder: (_) {
        return HomeScreen();
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
      Reference ref = FirebaseStorage.instance
          .ref()
          .child('user_profile_pictures')
          .child('${widget.emailController.text}_profile_picture.jpg');

      UploadTask uploadTask = ref.putFile(_image!);

      await uploadTask.whenComplete(() => null);

      String downloadUrl = await ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
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
      body: Stack(
        children: [
          AuthCircleDiv(size: size),
          Container(
            height: size.height,
            width: size.width,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Container(
                height: size.height,
                width: size.width,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    color: AppColors.kPrimaryColor.withOpacity(0.2),
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Column(
                          children: [
                            Form(
                              key: widget.formKey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(height: 10),
                                  Container(
                                    child: Text(
                                      'Welcome to shopbiz\nPlease Sign up to Your Account',
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
                                          ? AppColors.kPrimaryColor
                                          : AppColors.kBlueColor,
                                      child: _image == null
                                          ? Center(
                                              child: Icon(
                                                  Icons.camera_alt_outlined,
                                                  color: AppColors.kWhiteColor))
                                          : null,
                                      backgroundImage: _image != null
                                          ? FileImage(_image!)
                                          : null,
                                    ),
                                  ),
                                  CustomTextField(
                                    textEditingController:
                                        widget.nameController,
                                    keyboardType: TextInputType.name,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter your name';
                                      }
                                      return null;
                                    },
                                    prefixIcon: Icons.person_outline,
                                    hintText: 'Name',
                                  ),

                                  CustomTextField(
                                    textEditingController:
                                        widget.emailController,
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
                                    hintText: 'Email',
                                  ),

                                  CustomTextField(
                                    textEditingController:
                                        widget.phoneNumberController,
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
                                    // prefixText: '+92',
                                    hintText: 'Phone Number',
                                  ),

                                  ///password fields
                                  CustomTextField(
                                    textEditingController:
                                        widget.passwordController,
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
                                    hintText: 'Password',
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
                                  CustomTextField(
                                    textEditingController:
                                        widget.rePasswordController,
                                    keyboardType: TextInputType.visiblePassword,
                                    obscureText: _isObscurePassword2,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please re-enter your password';
                                      } else if (value !=
                                          widget.passwordController.text) {
                                        return 'Passwords do not match';
                                      }
                                      return null;
                                    },
                                    prefixIcon: Icons.password,
                                    hintText: 'Re-enter Password',
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
                                  CustomButton(
                                    title: _isLoading
                                        ? 'Signing Up...'
                                        : 'Sign Up',
                                    onPressed: _isLoading
                                        ? null
                                        : () {
                                            if (_image == null) {
                                              Fluttertoast.showToast(
                                                  msg: 'Please Select Image');
                                            } else {
                                              _signUpCredentials();
                                            }
                                          },
                                  ),

                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("Already have account?"),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: AppColors.kWhiteColor
                                                    .withOpacity(0.2),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
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
        ],
      ),
    );
  }
}


//import 'package:flutter/material.dart';
// import 'package:shopbiz_app/core/constants/app_colors.dart';
// import 'package:shopbiz_app/data/repositories/auth_repository.dart';
// import 'package:shopbiz_app/ui/screens/authentication/credientals_screens/log_in_screen.dart';
// import 'package:shopbiz_app/ui/widgets/app/error_dialog.dart';
// import 'package:shopbiz_app/ui/widgets/app/text_form_field.dart';
// import 'package:shopbiz_app/ui/widgets/auth/auth_circle_div.dart';
// import 'package:shopbiz_app/ui/widgets/auth/custom_button.dart';

// class SignUpMobileView extends StatefulWidget {
//   const SignUpMobileView({
//     super.key,
//     required this.emailEditingController,
//     required this.nameEditingController,
//     required this.lastNameEditingController,
//     required this.passwordEditingController,
//     required this.rePassEditingController,
//     required this.phoneEditingController,
//     required this.formKey,
//   });

//   final TextEditingController emailEditingController;
//   final GlobalKey<FormState> formKey;
//   final TextEditingController lastNameEditingController;
//   final TextEditingController nameEditingController;
//   final TextEditingController passwordEditingController;
//   final TextEditingController phoneEditingController;
//   final TextEditingController rePassEditingController;

//   @override
//   State<SignUpMobileView> createState() => _SignUpMobileViewState();
// }

// class _SignUpMobileViewState extends State<SignUpMobileView> {
//   bool _isPasswordObscured = true;
//   bool _rePasswordObscured = true;

//   @override
//   Widget build(BuildContext context) {
//     final Size size = MediaQuery.of(context).size;
//     return Stack(
//       children: [
//         // Background shape for aesthetics (optional)
//         AuthCircleDiv(size: size),
//         SingleChildScrollView(
//           child: Container(
//             padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
//             child: Container(
//               decoration: BoxDecoration(
//                   color: AppColors.kPrimaryColor.withOpacity(0.2)),
//               child: Form(
//                 key: widget.formKey,
//                 child: Padding(
//                   padding: const EdgeInsets.only(right: 10.0, left: 10.0),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       SizedBox(
//                           height:
//                               size.height * 0.15), // Adjust to fit under shape
//                       Container(
//                         height: size.height * 0.15,
//                         width: size.width * 0.15,
//                         decoration: const BoxDecoration(
//                           image: DecorationImage(
//                             image: AssetImage('assets/logos/main_logo.png'),
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: size.height * 0.02),
//                       Text(
//                         'Create New Account',
//                         style: TextStyle(
//                             color: AppColors.kBlackColor,
//                             fontSize: size.width * 0.06),
//                       ),
//                       Text(
//                         'Set up your user name and password\nYou can always change it later',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                             color: AppColors.kGreyColor,
//                             fontSize: size.width * 0.035),
//                       ),
//                       SizedBox(height: size.height * 0.05),

//                       // Name TextField
//                       CustomTextField(
//                         validator: (v) {
//                           if (v!.isEmpty) {
//                             return 'Field should not be empty ';
//                           }
//                           return null;
//                         },
//                         hintText: 'First Name',
//                         textEditingController: widget.nameEditingController,
//                         prefixIcon: Icons.person_outline,
//                       ),
//                       SizedBox(height: size.height * 0.02),

//                       // Last Name TextField
//                       CustomTextField(
//                         validator: (v) {
//                           if (v!.isEmpty) {
//                             return 'Field should not be empty ';
//                           }
//                           return null;
//                         },
//                         hintText: 'Last Name',
//                         textEditingController: widget.lastNameEditingController,
//                         prefixIcon: Icons.person_outline,
//                       ),
//                       SizedBox(height: size.height * 0.02),

//                       // Phone TextField
//                       CustomTextField(
//                         validator: (v) {
//                           if (v!.isEmpty) {
//                             return 'Field should not be empty ';
//                           }
//                           return null;
//                         },
//                         hintText: 'Phone Number',
//                         textEditingController: widget.phoneEditingController,
//                         prefixIcon: Icons.phone_outlined,
//                       ),
//                       SizedBox(height: size.height * 0.02),

//                       // Email TextField
//                       CustomTextField(
//                         validator: (v) {
//                           if (v!.isEmpty) {
//                             return 'Field should not be empty ';
//                           } else if (!isValidEmail(v)) {
//                             return 'Enter a valid email';
//                           }
//                           return null;
//                         },
//                         hintText: 'Email',
//                         textEditingController: widget.emailEditingController,
//                         prefixIcon: Icons.email_outlined,
//                       ),
//                       SizedBox(height: size.height * 0.02),

//                       // Password TextField
//                       CustomTextField(
//                         validator: (v) {
//                           if (v!.isEmpty) {
//                             return 'Field should not be empty ';
//                           } else if (v.length < 6) {
//                             return '  password should contain 6 digits ';
//                           }
//                           return null;
//                         },
//                         obscureText: _isPasswordObscured,
//                         hintText: 'Password',
//                         textEditingController: widget.passwordEditingController,
//                         prefixIcon: Icons.lock_outline,
//                         suffixIcon: IconButton(
//                           onPressed: () {
//                             setState(() {
//                               _isPasswordObscured = !_isPasswordObscured;
//                             });
//                           },
//                           icon: Icon(_isPasswordObscured
//                               ? Icons.visibility_off
//                               : Icons.visibility),
//                         ),
//                       ),
//                       SizedBox(height: size.height * 0.02),

//                       // Re-enter Password TextField
//                       CustomTextField(
//                         validator: (v) {
//                           if (v!.isEmpty) {
//                             return 'Field should not be empty ';
//                           } else if (v.length < 6) {
//                             return '  password should contain 6 digits ';
//                           }
//                           return null;
//                         },
//                         obscureText: _rePasswordObscured,
//                         hintText: 'Re-enter Password',
//                         textEditingController: widget.rePassEditingController,
//                         prefixIcon: Icons.lock_outline,
//                         suffixIcon: IconButton(
//                           onPressed: () {
//                             setState(() {
//                               _rePasswordObscured = !_rePasswordObscured;
//                             });
//                           },
//                           icon: Icon(_rePasswordObscured
//                               ? Icons.visibility_off
//                               : Icons.visibility),
//                         ),
//                       ),
//                       SizedBox(height: size.height * 0.05),

//                       // Sign Up Button
//                       CustomButton(
//                         title: 'Sign Up',
//                         onPressed: () async {
//                           await AuthRepository().signUpFormSubmission();
//                         },
//                       ),
//                       SizedBox(height: size.height * 0.01),

//                       // Log In Text Button
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             'Already have an account?',
//                             style: TextStyle(
//                                 color: AppColors.kBlackColor,
//                                 fontSize: size.width * 0.03),
//                           ),
//                           TextButton(
//                             onPressed: () {
//                               Navigator.push(context,
//                                   MaterialPageRoute(builder: (_) {
//                                 return const LogInScreen();
//                               }));
//                             },
//                             child: Text(
//                               'Log In',
//                               style: TextStyle(
//                                   color: AppColors.kPrimaryColor,
//                                   fontSize: size.width * 0.03),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
