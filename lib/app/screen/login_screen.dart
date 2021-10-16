import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/app/entity/user.dart';
import 'package:weather_app/app/network/auth.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 50.0),
          ),
          Image.asset(
            'cat.jpeg',
            width: 600,
            height: 240,
            fit: BoxFit.cover,
          ),
          const LoginForm(),
          RichText(
            text: TextSpan(
                text: "Didn't have account? Register!",
                style: const TextStyle(
                  color: Colors.black,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.pushNamed(context, '/register');
                  }),
          ),
        ]),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}

class LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
            ),
            TextFormField(
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(), labelText: 'Email'),
              // The validator receives the text that the user has entered.
              controller: emailController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email required';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(), labelText: 'Password'),
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              controller: passController,
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Password required';
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  // Validate returns true if the form is valid, or false otherwise.
                  if (_formKey.currentState!.validate()) {
                    AuthNetwork authNet = GetIt.instance<AuthNetwork>();
                    authNet.login(emailController.text, passController.text,
                        (User user) async {
                      // context.read<UserStateCubit>().setUser(user); todo
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Login successfully!')),
                      );
                      Navigator.pushNamed(context, '/weather');
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setString('token', user.token);
                    }, () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Wrong email or password!')),
                      );
                    });
                  }
                },
                child: const Center(child: Text('Login')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
