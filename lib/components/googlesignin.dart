import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:vitalvaultbeta/constants/appColors.dart';
import 'dart:developer' as developer;

import 'package:vitalvaultbeta/homeScreen.dart';

class GoogleLogInButton extends StatefulWidget {
  const GoogleLogInButton({super.key});

  @override
  State<GoogleLogInButton> createState() => _GoogleLogInButtonState();
}

class _GoogleLogInButtonState extends State<GoogleLogInButton> {
  bool _isLoading = false;

  Future<void> _signInWithGoogle() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Check if Google Play Services is available
      final GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: ['email'], // Add required scopes
      );
      googleSignIn.signOut();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        // User cancelled the sign-in
        developer.log('Google Sign-In cancelled by user');
        setState(() {
          _isLoading = false;
        });
        return;
      }

      developer.log('Google user: ${googleUser.email}');

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Check if tokens are available
      if (googleAuth.accessToken == null || googleAuth.idToken == null) {
        throw Exception('Failed to get authentication tokens');
      }

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(credential);

      developer.log('Firebase user signed in: ${userCredential.user?.email}');
      developer.log('About to navigate to HomeScreen');

      setState(() {
        _isLoading = false;
      });

      await Future.delayed(Duration(milliseconds: 300));
      if (mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => Homescreen()),
          (Route<dynamic> route) => false,
        );
      }
    } on FirebaseAuthException catch (e) {
      developer.log('Firebase Auth Error: ${e.code} - ${e.message}');
      String errorMessage = 'Authentication failed. Please try again.';

      switch (e.code) {
        case 'account-exists-with-different-credential':
          errorMessage =
              'An account already exists with a different sign-in method.';
          break;
        case 'invalid-credential':
          errorMessage = 'The credential is invalid or expired.';
          break;
        case 'operation-not-allowed':
          errorMessage = 'Google sign-in is not enabled.';
          break;
        case 'user-disabled':
          errorMessage = 'This user account has been disabled.';
          break;
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage), backgroundColor: Colors.red),
        );
      }
    } on Exception catch (e) {
      developer.log('Google Sign-In Error: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Sign-in failed. Please check your internet connection and try again.',
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
      child: ElevatedButton(
        style: ButtonStyle(
          minimumSize: WidgetStateProperty.all<Size>(
            const Size(double.infinity, 50),
          ),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          ),
          backgroundColor: WidgetStateProperty.all<Color>(
            Appcolors.white2.withValues(alpha: 0.3),
          ),
          elevation: WidgetStateProperty.all<double>(0.0),
        ),
        onPressed: _isLoading ? null : _signInWithGoogle,
        child: _isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'continue with google',
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        color: Appcolors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
