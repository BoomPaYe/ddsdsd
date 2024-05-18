import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lkw1fbase1/screens/login_screen.dart';
import 'package:flutter/cupertino.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  bool isRegistered = false; // Add the isRegistered variable here

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(),
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildImage(),
              _buildTitle(),
              _buildEmail(),
              _buildPassword(),
              _buildButton(),
              _buildText(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    return Image.asset(
      'all_assets/logos/signup.jpg', // Replace with the path to your image asset
      width: 300,
      height: 200,
    );
  }

  Widget _buildTitle() {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Text(
        "Sign Up",
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 237, 26, 86),
        ),
      ),
    );
  }

  var _emailCtrl = TextEditingController();

  Widget _buildEmail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: _emailCtrl,
          decoration: InputDecoration(
            hintText: "Enter Email",
            prefixIcon:
                Icon(Icons.email, color: Color.fromARGB(255, 237, 26, 86)),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Color.fromARGB(255, 237, 26, 86)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Color.fromARGB(255, 237, 26, 86)),
            ),
          ),
          validator: (text) {
            if (text == null || text.isEmpty) {
              return "Email is required";
            } else if (EmailValidator.validate(text) == false) {
              return "Email format is not valid";
            } else {
              return null;
            }
          },
        ),
        SizedBox(height: 16),
      ],
    );
  }

  var _passCtrl = TextEditingController();

  Widget _buildPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: _passCtrl,
          decoration: InputDecoration(
            hintText: "Enter Password",
            prefixIcon:
                Icon(Icons.lock, color: Color.fromARGB(255, 237, 26, 86)),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Color.fromARGB(255, 237, 26, 86)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Color.fromARGB(255, 237, 26, 86)),
            ),
          ),
          obscureText: true, // hides the entered password
          validator: (text) {
            if (text == null || text.isEmpty) {
              return "Password is required";
            } else if (text.length < 6) {
              return "Password length must be at least 6";
            } else {
              return null;
            }
          },
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildButton() {
    return ElevatedButton(
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          String email = _emailCtrl.text.trim();
          String password = _passCtrl.text.trim();

          try {
            UserCredential userCredential =
                await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: email,
              password: password,
            );

            setState(() {
              isRegistered = true;
            });

            print('User registered: ${userCredential.user!.email}');

            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => LoginScreen(),
              ),
            );
          } catch (e) {
            print('Registration failed: $e');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Registration Failed: $e"),
              ),
            );
          }
        }
      },
      style: ElevatedButton.styleFrom(
        primary: Color.fromARGB(255, 237, 26, 86),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 25),
      ),
      child: Text("Sign Up"),
    );
  }

  Widget _buildText() {
    return TextButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
        );
      },
      style: TextButton.styleFrom(
        primary: Color.fromARGB(255, 237, 26, 86),
        padding: EdgeInsets.symmetric(vertical: 10),
      ),
      child: Text(
        "Have an account?",
        style: TextStyle(
          fontSize: 16,
          color: Colors.black54,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
