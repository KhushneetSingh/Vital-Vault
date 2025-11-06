import 'package:flutter/material.dart';

class customAppbar extends StatelessWidget {
  const customAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      actions: [
        SizedBox(width: 20),
        InkWell(
          onTap: () {},
          child: ClipOval(
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/icons/avatar.png"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ),
        Spacer(),
      ],
    );
  }
}
