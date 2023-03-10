import 'package:boratok/constants.dart';
import 'package:boratok/views/widgets/text_input_field.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Boratok",
              style: TextStyle(
                  fontSize: 35,
                  color: buttonColor,
                  fontWeight: FontWeight.w900)),
          const Text(
            'Login',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
          ),
          const SizedBox(
            height: 25,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: TextInputField(
              controller: _emailController,
              labelText: 'Email',
              icon: Icons.email,
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: TextInputField(
              controller: _passwordController,
              labelText: 'Password',
              icon: Icons.lock,
              isObscure: true,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            width: MediaQuery.of(context).size.width - 40,
            height: 50,
            decoration: BoxDecoration(
                color: buttonColor,
                borderRadius: const BorderRadius.all(Radius.circular(5))),
            child: InkWell(
              onTap: () {
                authController.loginUser(_emailController.text, _passwordController.text);
              },
              child: const Center(
                  child: Text(
                "Login",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              )),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Don\'t have an account?",
                style: TextStyle(fontSize: 20),
              ),
              InkWell(
                  onTap: () {
                    print("navigating user");
                  },
                  child: Text(
                    "Register",
                    style: TextStyle(fontSize: 20, color: buttonColor),
                  ))
            ],
          )
        ],
      ),
    ));
  }
}
