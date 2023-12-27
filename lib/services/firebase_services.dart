import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FireBaseServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> handleLogInWithPhoneNumber(String phoneNumber) async {
    try {
      // Add the default country code for Pakistan (+92)
      String fullPhoneNumber = '+92$phoneNumber';

      await _auth.verifyPhoneNumber(
        phoneNumber: fullPhoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Automatically sign in if the code is sent by Firebase
          await _auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            Fluttertoast.showToast(
                msg: 'The provided phone number is not valid.');
          } else {
            Fluttertoast.showToast(msg: 'Verification failed: ${e.message}');
          }
        },
        codeSent: (String verificationId, int? resendToken) async {
          // Store the verification ID for later use
          // You can save it to the local storage or pass it to the next screen
          Fluttertoast.showToast(msg: 'Code sent to $fullPhoneNumber');
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Called when the auto-retrieval timer has timed out (e.g., 60 seconds)
          // You can handle this case if needed
        },
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-phone-number') {
        Fluttertoast.showToast(msg: 'The provided phone number is not valid.');
      } else {
        Fluttertoast.showToast(
            msg: 'Error during phone number verification: ${e.message}');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Unexpected error: $e');
    }
  }
}
