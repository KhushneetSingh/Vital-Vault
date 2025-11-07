import 'dart:developer';

import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vitalvaultbeta/components/appBody.dart';
import 'package:vitalvaultbeta/constants/appColors.dart';
import 'package:vitalvaultbeta/constants/screensSizes.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

final List<Map<String, dynamic>> healthMetrics = [
  {
    "title": "Heart Rate",
    "value": "80 bpm",
    "trend": "+6%",
    "color": Colors.redAccent,
    "data": heartdata,
  },
  {
    "title": "Blood Pressure",
    "value": "120/80",
    "trend": "+2%",
    "color": Colors.blueAccent,
    "data": bpdata,
  },
  {
    "title": "Sleep",
    "value": "7.5 hrs",
    "trend": "+4%",
    "color": Colors.purpleAccent,
    "data": sleepdata,
  },
  {
    "title": "Stress",
    "value": "Low",
    "trend": "-3%",
    "color": Colors.orangeAccent,
    "data": stressdata,
  },
];

var heartdata = [1.0, 1.0, 1.2, 1.2, 1.3, 1.4, 1.3, 1.4, 1.3, 1.2, 1.2];
var bpdata = [0.0, 1.0, 1.5, 2.0, 0.0, 0.0, -0.5, -1.0, -0.5, 0.0, 0.0];
var sleepdata = [1.0, 1.0, 1.2, 1.2, 1.3, 1.4, 1.3, 1.4, 1.3, 1.2, 1.2];
var stressdata = [0.0, 1.0, 1.5, 2.0, 0.0, 0.0, -0.5, -1.0, -0.5, 0.0, 0.0];

bool isTaken = false;

Widget _buildHealthMetrices({
  required String title,
  required String value,
  required String trend,
  required Color color,
  required List<double> data,
}) {
  return Expanded(
    child: Container(
      margin: EdgeInsets.all(12),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Appcolors.fg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.3),
          width: 0.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 5),
          Text(
            title,
            style: GoogleFonts.poppins(
              color: Appcolors.white.withValues(alpha: 0.8),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 10),
          Text(
            value,
            style: GoogleFonts.poppins(
              color: Appcolors.white.withValues(alpha: 0.8),
              fontSize: 28,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Text(
                trend,
                style: GoogleFonts.poppins(
                  color: Appcolors.white.withValues(alpha: 0.6),
                  fontSize: 16,
                ),
              ),
              Text(
                "+6%",
                style: GoogleFonts.poppins(
                  color: Colors.greenAccent.withValues(alpha: 0.6),
                  fontSize: 16,
                ),
              ),
            ],
          ),
          SizedBox(height: 25),
          Container(
            child: Sparkline(data: data, lineColor: color),
          ),
        ],
      ),
    ),
  );
}

List<bool> isTakenList = [false, false, false, false];

class _HomescreenState extends State<Homescreen> {
  Widget medicineRow({
    required String medName,
    required String duration,
    required int mg,
    required bool isdue,
    required int index, // ✅ add index to know which one changed
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                medName,
                style: GoogleFonts.poppins(
                  color: isdue
                      ? Colors.yellow
                      : Appcolors.white.withValues(alpha: 0.8),

                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "$mg mg, $duration",
                style: GoogleFonts.poppins(
                  color: Appcolors.white2,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          Checkbox(
            activeColor: Colors.blue,
            side: BorderSide(color: Colors.blue),
            value: isTakenList[index],
            onChanged: (bool? value) {
              if (value != null) {
                setState(() {
                  isTakenList[index] = value;
                });
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Appbody(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 10),
                //top title
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: StreamBuilder<User?>(
                    stream: FirebaseAuth.instance.authStateChanges(),
                    builder: (context, snapshot) {
                      final User = snapshot.data;
                      final name = User?.displayName ?? 'user';

                      return Text(
                        "Hello,\n$name!",
                        style: GoogleFonts.poppins(
                          color: Appcolors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 25),

                //recent health metrics
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    "Recent Health Metrics",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: Appcolors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                SizedBox(
                  height: Screensizes.height(context) * 0.33,

                  child: ListView.builder(
                    itemCount: 4,
                    scrollDirection: Axis.horizontal,

                    itemBuilder: (context, index) {
                      final metric = healthMetrics[index];
                      return _buildHealthMetrices(
                        title: metric["title"],
                        value: metric["value"],
                        trend: metric["trend"],
                        color: metric["color"],
                        data: metric["data"],
                      );
                    },
                  ),
                ),
                SizedBox(height: 25),
                //today's medicines
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    "Today's medicines",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: Appcolors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Appcolors.fg,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.3),
                        width: 0.5,
                      ),
                    ),
                    child: Column(
                      children: [
                        medicineRow(
                          medName: "Mefronin",
                          duration: "9:00 AM",
                          mg: 500,
                          isdue: false,
                          index: 0,
                        ),
                        Divider(thickness: 0.2),
                        medicineRow(
                          medName: "amiways",
                          duration: "12:00 AM",
                          mg: 500,
                          isdue: false,
                          index: 1,
                        ),
                        Divider(thickness: 0.2),
                        medicineRow(
                          medName: "cufermencin",
                          duration: "2:00 AM",
                          mg: 250,
                          isdue: false,
                          index: 2,
                        ),
                        Divider(thickness: 0.2),
                        medicineRow(
                          medName: "oraflora",
                          duration: "5:00 PM",
                          mg: 100,
                          isdue: true,
                          index: 3,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    "Upcoming",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: Appcolors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Appcolors.fg,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.3),
                        width: 0.5,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          child: Icon(Icons.vaccines, color: Colors.blueAccent),
                          backgroundColor: Colors.blueAccent.withValues(
                            alpha: 0.2,
                          ),
                        ),

                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Next Vaccination \n:Flu shot",
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  color: Appcolors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "10 Oct, 10 AM",
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Appcolors.white2,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),

                        Text(
                          "view details",
                          style: GoogleFonts.poppins(color: Colors.blueAccent),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
