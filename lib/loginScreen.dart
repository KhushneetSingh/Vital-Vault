import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vitalvaultbeta/components/agreementText.dart';
import 'package:vitalvaultbeta/components/appBody.dart';
import 'package:vitalvaultbeta/components/googlesignin.dart';
import 'package:vitalvaultbeta/constants/appColors.dart';
import 'package:vitalvaultbeta/constants/screensSizes.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121826),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              SizedBox(height: Screensizes.height(context) * 0.25),
              Text(
                "VitalVault",

                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 58,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                " Your Health, Secured.",

                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 27,
                  fontWeight: FontWeight.w700,
                  height: 0.8,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Access your personal and family health \nrecord with a single tap , enhanced with AI",
                style: GoogleFonts.poppins(
                  color: Appcolors.white2,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 50),
              GoogleLogInButton(),
              SizedBox(height: 10),
              Text(
                "Or Sign in with email",
                style: GoogleFonts.poppins(
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              Spacer(),
              AgreementsText(),
            ],
          ),
        ),
      ),
    );
  }
}
