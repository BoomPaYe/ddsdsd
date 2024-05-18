import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lkw1fbase1/helpers/auth_helper.dart';
import 'package:lkw1fbase1/screens/home_screen.dart';
import 'package:lkw1fbase1/screens/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
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
      'all_assets/logos/login2.jpg', // Replace with the path to your image asset
      width: 300,
      height: 200,
    );
  }

  Widget _buildTitle() {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Text(
        "Login",
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
            if (text == null) return null;
            if (EmailValidator.validate(text) == false) {
              return "Email format is not valid";
            } else {
              return null;
            }
          },
        ),
        SizedBox(height: 16), // Add spacing between email and password
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
                Icon(Icons.lock_sharp, color: Color.fromARGB(255, 237, 26, 86)),
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
          obscureText: true,
          validator: (text) {
            if (text == null) return null;
            if (text.length < 6) {
              return "Password length must be at least 6";
            } else {
              return null;
            }
          },
        ),
        SizedBox(
          height: 16,
        )
      ],
    );
  }

  Widget _buildButton() {
    return ElevatedButton(
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          User? user = await AuthHelper.login(
            _emailCtrl.text.trim(),
            _passCtrl.text.trim(),
          );

          debugPrint(user.toString());

          if (user == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Login Failed"),
              ),
            );
          } else {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
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
      child: Text("Login"),
    );
  }

  Widget _buildText() {
    return TextButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => SignUpPage(),
          ),
        );
      },
      style: TextButton.styleFrom(
        primary: Color.fromARGB(255, 237, 26, 86),
        padding: EdgeInsets.symmetric(vertical: 10),
      ),
      child: Text(
        "Sign up?",
        style: TextStyle(
          fontSize: 16,
          color: Colors.black54,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
