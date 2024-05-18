import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lkw1fbase1/screens/about_us_screen.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  void _logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
      );
    } catch (e) {
      print('Error logging out: $e');
      // Show an error dialog or toast message if logout fails
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('An error occurred while logging out.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  void _navigateToAboutUs(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AboutUsScreen(),
      ),
    );
  }

  Widget _buildButtonWithBorder(Widget child) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Color.fromARGB(255, 237, 26, 86),
        ), // Set the background color to grey
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 237, 26, 86),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Transform.translate(
              offset: Offset(0, 50), // Adjust the vertical offset as needed
              child: CircleAvatar(
                radius: 80,
                backgroundImage: AssetImage(
                    'all_assets/logos/6b9645857f96652ed3abc29c5ddeec0e.jpg'),
              ),
            ),
            SizedBox(height: 90),
            _buildButtonWithBorder(
              ListTile(
                leading: Icon(
                  Icons.settings,
                  color: Color.fromARGB(255, 237, 26, 86),
                ),
                title: Text(
                  'Settings',
                  style: TextStyle(fontFamily: 'Montserrat'),
                ),
                onTap: () {
                  // Add settings functionality here
                },
              ),
            ),
            SizedBox(height: 16),
            _buildButtonWithBorder(
              ListTile(
                leading: Icon(
                  Icons.people,
                  color: Color.fromARGB(255, 237, 26, 86),
                ),
                title: Text('About Us',
                    style: TextStyle(fontFamily: 'Montserrat')),
                onTap: () => _navigateToAboutUs(context),
              ),
            ),
            SizedBox(height: 16),
            _buildButtonWithBorder(
              ListTile(
                leading: Icon(
                  Icons.privacy_tip,
                  color: Color.fromARGB(255, 237, 26, 86),
                ),
                title:
                    Text('Privacy', style: TextStyle(fontFamily: 'Montserrat')),
                onTap: () {
                  // Add privacy functionality here
                },
              ),
            ),
            SizedBox(height: 16),
            _buildButtonWithBorder(
              ListTile(
                leading: Icon(
                  Icons.logout,
                  color: Color.fromARGB(255, 237, 26, 86),
                ),
                title:
                    Text('Logout', style: TextStyle(fontFamily: 'Montserrat')),
                onTap: () => _logout(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
