import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:weather_app/app/network/auth.dart';
import 'package:weather_app/app/network/auth_v2.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: const Center(
        child: RegisterForm(),
      ),
    );
  }
}

// Create a Form widget.
class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  RegisterFormState createState() {
    return RegisterFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class RegisterFormState extends State<RegisterForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<RegisterFormState>.
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const Padding(
            //   padding: EdgeInsets.symmetric(vertical: 16.0),
            // ),
            // const Text("Fullname"),
            // TextFormField(
            //   // The validator receives the text that the user has entered.
            //   validator: (value) {
            //     if (value == null || value.isEmpty) {
            //       return 'Fullname required';
            //     }
            //     return null;
            //   },
            // ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
            ),
            TextFormField(
              // The validator receives the text that the user has entered.
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(), labelText: 'Email'),
              controller: emailController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email required';
                }
                return null;
              },
            ),
            TextFormField(
              // The validator receives the text that the user has entered.
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(), labelText: 'Password'),
              obscureText: true,
              enableSuggestions: false,
              controller: passController,
              autocorrect: false,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Password required';
                }
                return null;
              },
            ),
            TextFormField(
              // The validator receives the text that the user has entered.
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Confirm Password'),
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Confirm Password required';
                }
                if (value != passController.text) {
                  return "Password doesn't match";
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    UserClient userClient = GetIt.instance<UserClient>();
                    userClient
                        .createUser(User(
                            email: emailController.text,
                            password: passController.text,
                            token: ""))
                        .then((user) {
                      print("registed");
                      Navigator.pushNamed(context, '/login');
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Registered successfully!')),
                      );
                    }).catchError((Object obj) {
                      switch (obj.runtimeType) {
                        case DioError:
                          // Here's the sample to get the failed response error code and message
                          final res = (obj as DioError).response;
                          print(
                              "Got error : ${res!.statusCode} -> ${res.statusMessage}");
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    'Registered failed, try another email, longer password, this is a lazy noti!')),
                          );
                          break;
                        default:
                      }
                    });
                  }
                },
                child: const Center(child: Text('Register')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
