import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:song_lyrics_app/controllers/auth_controller.dart';
import 'package:song_lyrics_app/views/edit_password_screen.dart';
import 'package:song_lyrics_app/views/edit_username_screen.dart';
import 'package:song_lyrics_app/views/verification_screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? _username;
  AuthController authController = AuthController();

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  Future<void> _loadUsername() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('admin_username') ?? 'Error get username';
    });
  }

  void _verifyAndNavigate(VoidCallback onVerified) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => VerifyScreen(onVerified: onVerified)),
    );
  }

  void _editPassword() {
    _verifyAndNavigate(() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => EditPasswordScreen()),
      );
    });
  }

  void _editUsername() {
    print('edit username');
    _verifyAndNavigate(() {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EditUsernameScreen(
                  username: _username!,
                )),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFe7c197),
      appBar: AppBar(
        backgroundColor: Color(0xFFb2855d),
        centerTitle: true,
        title: Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 50),
              Image.asset(
                'assets/profile-illustration.png',
                width: 180,
                height: 180,
              ),
              Text(
                "Hello, ${_username ?? ''}",
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _editUsername,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                      side: BorderSide.none,
                    ),
                    backgroundColor: Color(0xFFe7c197),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 12, 0, 12),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Edit Username',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // garis
              SizedBox(
                width: double.infinity,
                child: Container(
                  height: 2.0,
                  color: Color(0xFFb2855d),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _editPassword,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                      side: BorderSide.none,
                    ),
                    backgroundColor: Color(0xFFe7c197),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 12, 0, 12),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Edit Password',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // garis
              SizedBox(
                width: double.infinity,
                child: Container(
                  height: 2.0,
                  color: Color(0xFFb2855d),
                ),
              ),
              SizedBox(height: 200),
              Positioned(
                left: 0,
                right: 0,
                bottom: 20,
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => authController.logout(context),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      backgroundColor: Colors.red,
                    ),
                    child: Text(
                      'Logout',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
