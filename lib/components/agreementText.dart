import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AgreementsText extends StatefulWidget {
  const AgreementsText({Key? key}) : super(key: key);

  @override
  State<AgreementsText> createState() => _AgreementsTextState();
}

class _AgreementsTextState extends State<AgreementsText> {
  // separate recognizers
  late TapGestureRecognizer _termsRecognizer;
  late TapGestureRecognizer _privacyRecognizer;

  @override
  void initState() {
    super.initState();
    _termsRecognizer = TapGestureRecognizer()..onTap = _launchTermsUrl;
    _privacyRecognizer = TapGestureRecognizer()..onTap = _launchPrivacyUrl;
  }

  @override
  void dispose() {
    // Dispose of the recognizers to prevent memory leaks.
    _termsRecognizer.dispose();
    _privacyRecognizer.dispose();
    super.dispose();
  }

  // Function to launch the terms URL.
  void _launchTermsUrl() async {
    const url = '';
    try {
      final Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        // Fallback - try launching in webview mode
        await launchUrl(uri, mode: LaunchMode.inAppWebView);
      }
    } catch (e) {
      print('Could not launch $url: $e');
      // Show user-friendly error message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not open link. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  // Function to launch the privacy policy URL.
  void _launchPrivacyUrl() async {
    const url = '';
    try {
      final Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        // Fallback - try launching in webview mode
        await launchUrl(uri, mode: LaunchMode.inAppWebView);
      }
    } catch (e) {
      print('Could not launch $url: $e');
      // Show user-friendly error message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not open link. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: DefaultTextStyle.of(context).style.copyWith(
          fontSize: 13,
          color: Colors.white,
          fontWeight: FontWeight.w400,
        ),
        children: <TextSpan>[
          const TextSpan(text: 'By continuing you agree to our '),
          TextSpan(
            text: 'terms',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
            recognizer: _termsRecognizer,
          ),
          const TextSpan(text: ' and '),
          TextSpan(
            text: 'privacy policies',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
            recognizer: _privacyRecognizer,
          ),
        ],
      ),
    );
  }
}
