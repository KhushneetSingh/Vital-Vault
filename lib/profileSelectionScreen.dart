import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vitalvaultbeta/constants/appColors.dart';
import 'package:vitalvaultbeta/constants/screensSizes.dart';
import 'package:vitalvaultbeta/homeScreen.dart';

// Profile Model
class FamilyProfile {
  final String id;
  final String name;
  final String relationship;
  final String bloodType;
  final String dateOfBirth;
  final String avatarUrl;

  FamilyProfile({
    required this.id,
    required this.name,
    required this.relationship,
    required this.bloodType,
    required this.dateOfBirth,
    required this.avatarUrl,
  });
}

class ProfileSelectionScreen extends StatefulWidget {
  const ProfileSelectionScreen({super.key});

  @override
  State<ProfileSelectionScreen> createState() => _ProfileSelectionScreenState();
}

class _ProfileSelectionScreenState extends State<ProfileSelectionScreen> {
  String? selectedProfileId;
  late List<FamilyProfile> profiles;

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;

    profiles = [
      FamilyProfile(
        id: '1',
        name: user?.displayName ?? 'User',
        relationship: 'You',
        bloodType: 'O+', // You can fetch from Firestore later if needed
        dateOfBirth: 'Not specified',
        avatarUrl:
            user?.photoURL ??
            'https://i.pravatar.cc/150?u=${user?.uid}', // fallback
      ),
      FamilyProfile(
        id: '2',
        name: 'Dustin Henderson',
        relationship: 'Brother',
        bloodType: 'O-',
        dateOfBirth: 'Jan 22, 1988',
        avatarUrl:
            'https://strangerthingsttu.weebly.com/uploads/1/1/4/5/114552629/dustin-2_orig.jpg',
      ),
      FamilyProfile(
        id: '3',
        name: 'Nancy Wheeler',
        relationship: 'Spouse',
        bloodType: 'O+',
        dateOfBirth: 'June 22, 1982',
        avatarUrl:
            'https://i.pinimg.com/736x/e7/d1/0f/e7d10f09dad5f257440d23881b3f7491.jpg',
      ),
      FamilyProfile(
        id: '3',
        name: 'Max Mayfield',
        relationship: 'Friend',
        bloodType: 'O+',
        dateOfBirth: 'June 22, 1989',
        avatarUrl:
            'https://i.pinimg.com/1200x/40/af/e7/40afe7298ae5d2fcbfc0bdf16983eed8.jpg',
      ),
    ];

    selectedProfileId = profiles.first.id;
  }

  void _showAddProfileDialog() {
    final nameController = TextEditingController();
    final relationshipController = TextEditingController();
    final bloodTypeController = TextEditingController();
    final dobController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Appcolors.fg,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Add Family Member',
                style: GoogleFonts.poppins(
                  color: Appcolors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 24),
              _buildTextField(nameController, 'Name', Icons.person),
              SizedBox(height: 16),
              _buildTextField(
                relationshipController,
                'Relationship',
                Icons.family_restroom,
              ),
              SizedBox(height: 16),
              _buildTextField(
                bloodTypeController,
                'Blood Type',
                Icons.bloodtype,
              ),
              SizedBox(height: 16),
              _buildTextField(
                dobController,
                'Date of Birth',
                Icons.calendar_today,
              ),
              SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          Colors.grey.withOpacity(0.2),
                        ),
                        padding: WidgetStatePropertyAll(
                          EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                      child: Text(
                        'Cancel',
                        style: GoogleFonts.poppins(
                          color: Appcolors.white.withOpacity(0.7),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        if (nameController.text.isNotEmpty) {
                          setState(() {
                            profiles.add(
                              FamilyProfile(
                                id: DateTime.now().toString(),
                                name: nameController.text,
                                relationship:
                                    relationshipController.text.isEmpty
                                    ? 'Family Member'
                                    : relationshipController.text,
                                bloodType: bloodTypeController.text.isEmpty
                                    ? 'N/A'
                                    : bloodTypeController.text,
                                dateOfBirth: dobController.text.isEmpty
                                    ? 'Not specified'
                                    : dobController.text,
                                avatarUrl:
                                    'https://i.pravatar.cc/150?img=${profiles.length + 5}',
                              ),
                            );
                          });
                          Navigator.pop(context);
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          Colors.blueAccent,
                        ),
                        padding: WidgetStatePropertyAll(
                          EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                      child: Text(
                        'Add',
                        style: GoogleFonts.poppins(
                          color: Appcolors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label,
    IconData icon,
  ) {
    return TextField(
      controller: controller,
      style: GoogleFonts.poppins(color: Appcolors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.poppins(
          color: Appcolors.white.withOpacity(0.6),
        ),
        prefixIcon: Icon(icon, color: Colors.blueAccent, size: 20),
        filled: true,
        fillColor: Colors.white.withOpacity(0.05),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.2)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.2)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.blueAccent),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.bg,
      body: Column(
        children: [
          AppBar(
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            scrolledUnderElevation: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Homescreen()),
                );
              },
              icon: Icon(Icons.home, color: Appcolors.white),
            ),
            title: Text(
              "Family Profiles",
              style: GoogleFonts.poppins(
                color: Appcolors.white,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.settings, color: Appcolors.white),
              ),
            ],
          ),
          SizedBox(height: 25),

          // Add New Profile Button
          Container(
            width: Screensizes.width(context) * 0.9,
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.blueAccent),
                padding: WidgetStatePropertyAll(
                  EdgeInsets.symmetric(vertical: 16),
                ),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              onPressed: _showAddProfileDialog,
              child: Text(
                "+ Add a Family Member",
                style: GoogleFonts.poppins(
                  color: Appcolors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          SizedBox(height: 25),

          // Profile List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(
                horizontal: Screensizes.width(context) * 0.05,
              ),
              itemCount: profiles.length,
              itemBuilder: (context, index) {
                final profile = profiles[index];
                final isSelected = selectedProfileId == profile.id;

                return Container(
                  margin: EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Appcolors.fg,
                    border: Border.all(
                      color: isSelected
                          ? Colors.blueAccent
                          : Colors.white.withOpacity(0.2),
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        setState(() {
                          selectedProfileId = profile.id;
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Row(
                          children: [
                            // Avatar
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(profile.avatarUrl),
                            ),
                            SizedBox(width: 16),

                            // Profile Info
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    profile.name,
                                    style: GoogleFonts.poppins(
                                      color: Appcolors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    profile.relationship,
                                    style: GoogleFonts.poppins(
                                      color: Colors.blueAccent,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 12),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.bloodtype,
                                        color: Appcolors.white.withOpacity(0.6),
                                        size: 16,
                                      ),
                                      SizedBox(width: 6),
                                      Text(
                                        profile.bloodType,
                                        style: GoogleFonts.poppins(
                                          color: Appcolors.white.withOpacity(
                                            0.8,
                                          ),
                                          fontSize: 13,
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      Icon(
                                        Icons.cake,
                                        color: Appcolors.white.withOpacity(0.6),
                                        size: 16,
                                      ),
                                      SizedBox(width: 6),
                                      Text(
                                        profile.dateOfBirth,
                                        style: GoogleFonts.poppins(
                                          color: Appcolors.white.withOpacity(
                                            0.8,
                                          ),
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            // Arrow Icon
                            Icon(
                              Icons.chevron_right,
                              color: isSelected
                                  ? Colors.blueAccent
                                  : Appcolors.white.withOpacity(0.4),
                              size: 28,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
