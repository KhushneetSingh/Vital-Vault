import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vitalvaultbeta/constants/appColors.dart';
import 'package:vitalvaultbeta/profileSelectionScreen.dart';

class customAppbar extends StatelessWidget {
  const customAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,

      scrolledUnderElevation: 0,
      actions: [
        SizedBox(width: 20),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfileSelectionScreen()),
            );
          },
          child: ClipOval(
            child: StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                final user = snapshot.data;
                final photoUrl = user?.photoURL;

                if (photoUrl != null) {
                  return CircleAvatar(backgroundImage: NetworkImage(photoUrl));
                } else {
                  return CircleAvatar(child: Icon(Icons.person));
                }
              },
            ),
          ),
        ),
        Spacer(),
        Text(
          "VitalVault",
          style: GoogleFonts.poppins(
            color: Appcolors.white,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        Spacer(),
        Icon(Icons.notifications, color: Appcolors.white),
        SizedBox(width: 20),
      ],
    );
  }
}
