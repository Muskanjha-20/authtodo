// import 'dart:math';

// import 'package:saaski_app/authentication/sign_up_screen.dart';

// class AuthServices {
//   final _auth = FirebaseAuth.instance;

//   Future<User?> createUserWithEmailAndPassword(
//       String email, String password) async {
//     try {
//       final cred = await _auth.createUserWithEmailAndPassword(
//           email: email, password: password);
//       return cred.user;
//     } catch (e) {
//       log("Something went wrong");
//     }
//     return null;
//   }

//   Future<User?> loginUserWithEmailAndPassword(
//       String email, String password) async {
//     try {
//       final cred = await _auth.createUserWithEmailAndPassword(
//           email: email, password: password);
//       return cred.user;
//     } catch (e) {
//       log("Something went wrong");
//     }
//     return null;
//   }

//   Future<void> signout() async {
//     try {
//       await _auth.signOut();
//     } catch (e) {
//       log("Something went wrong"); 
//     }
//   }
// }
