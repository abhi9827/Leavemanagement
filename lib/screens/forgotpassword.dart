import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class forgotpasswordpage extends StatefulWidget {
  const forgotpasswordpage({super.key});

  @override
  State<forgotpasswordpage> createState() => _forgotpasswordState();
}

class _forgotpasswordState extends State<forgotpasswordpage> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text("Password reset link sent Check your email"),
            );
          });
    } on FirebaseAuthException catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Forget Password")),
      ),
      body: Column(
        children: [
          Text(
            "Enter Your Email we'll send you a link",
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: TextField(
              controller: _emailController,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: "Email",
                  fillColor: Colors.grey,
                  filled: true),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          MaterialButton(
              onPressed: passwordReset,
              child: Text("Reset Password"),
              color: Colors.blue)
        ],
      ),
    );
  }
}
