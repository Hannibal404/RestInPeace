import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Login/components/background.dart';
import 'package:flutter_auth/Screens/Signup/signup_screen.dart';
import 'package:flutter_auth/components/already_have_an_account_acheck.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/components/rounded_input_field.dart';
import 'package:flutter_auth/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:flutter_auth/Screens/Homepage.dart';

enum AuthMethod {
  SIGN_IN,
}

class AuthResponse {
  AuthResponse({this.user, this.error});

  final FirebaseUser user;

  final dynamic error;
}

class AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _db = Firestore.instance;

  /// Firebase user one-time fetch
  Future<FirebaseUser> get getUser => _auth.currentUser();

  /// Firebase user a realtime stream
  Stream<FirebaseUser> get user => _auth.onAuthStateChanged;

  /// Check the database to see if the user has entered VALORANT info like their Riot ID and their "main", if not, we open a form for them to enter that data.
  ///
  /// Returns a future that will resolve when the user has entered their data and the database has been updated.
  /// The future will resolve instantly if the user has already entered data.
  Future<void> openUserDataEntryFormIfNoData(
    String uid,
    BuildContext context,
  ) async {
    final userData = await _db.collection("users").document(uid).get();

    if (!userData.exists) {
      // Push them to the user info entry form where they will update the DB with their info
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => SignUpScreen(),
        ),
      );
    }
  }

  /// Sign in with Google.
  Future<AuthResponse> googleSignIn(BuildContext context) async {
    try {
      final GoogleSignInAccount googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final result = await _auth.signInWithCredential(credential);
      final user = result.user;

      await openUserDataEntryFormIfNoData(user.uid, context);

      return AuthResponse(user: user);
    } on NoSuchMethodError {
      // If the Google popup was closed, don't return an error, return null.
      return null;
    } catch (error) {
      return AuthResponse(error: error);
    }
  }

  Future<AuthResponse> emailSignIn(BuildContext context, userMap) async {
    try {
      if (userMap == null) {
        return null;
      } else {
        final email = userMap['email'];
        final password = userMap['password'];

        if (userMap['method'] == AuthMethod.SIGN_IN) {
          final AuthResult authResult = await _auth.signInWithEmailAndPassword(
              email: email, password: password);

          final user = authResult.user;

          return AuthResponse(user: user);
        } else {
          final AuthResult authResult = await _auth
              .createUserWithEmailAndPassword(email: email, password: password);

          final user = authResult.user;

          await openUserDataEntryFormIfNoData(user.uid, context);

          return AuthResponse(user: user);
        }
      }
    } catch (error) {
      print(error);
      return AuthResponse(error: error);
    }
  }

  /// Sign out
  Future<void> signOut() => _auth.signOut();
}

class LoginBody extends StatefulWidget {
  LoginBody({
    Key key,
  }) : super(key: key);

  @override
  _LoginBodyState createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  String _controllerEmail, _controllerPassword;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: "Your Email",
              onChanged: (value) {
                _controllerEmail = value;
              },
            ),
            RoundedPasswordField(
              onChanged: (value) {
                _controllerPassword = value;
              },
            ),
            RoundedButton(
              text: "LOGIN",
              color: Colors.deepPurple,
              press: () {
                Navigator.pop(context, {
                  "email": _controllerEmail,
                  "password": _controllerPassword,
                  "method": AuthMethod.SIGN_IN,
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return HomeScreen();
                    },
                  ),
                );
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // Future<FirebaseUser> _handleSignIn() async {
  //   final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
  //   final GoogleSignInAuthentication googleAuth =
  //       await googleUser.authentication;

  //   final AuthCredential credential = GoogleAuthProvider.getCredential(
  //     accessToken: googleAuth.accessToken,
  //     idToken: googleAuth.idToken,
  //   );

  //   final FirebaseUser user =
  //       (await _auth.signInWithCredential(credential)).user;
  //   print("signed in " + user.displayName);
  //   return user;
  // }
}
