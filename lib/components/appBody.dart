import 'package:flutter/material.dart';
import 'package:vitalvaultbeta/components/Appbar.dart';
import 'package:vitalvaultbeta/constants/appColors.dart';

class Appbody extends StatelessWidget {
  final Widget child;
  const Appbody({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(color: Appcolors.bg),
      child: SafeArea(
        child: Column(
          children: [
            customAppbar(),
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}
