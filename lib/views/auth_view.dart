import 'package:flutter/material.dart';
import 'package:pokemon/providers/auth_view_provider.dart';
import 'package:provider/provider.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return ChangeNotifierProvider<AuthViewProvider>(
        create: (context) => AuthViewProvider(),
        builder: (context, child) {
          return Scaffold(
            appBar: AppBar(title: const Text('Authentication')),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Consumer<AuthViewProvider>(
                        builder: (context, authModel, child) {
                          return TextFormField(
                            controller: emailController,
                            decoration:
                                const InputDecoration(labelText: 'Email'),
                            onChanged: (newEmail) {
                              authModel.email = newEmail;
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter an email address.';
                              }
                              if (!isValidEmail(value)) {
                                return 'Please enter a valid email address.';
                              }
                              return null;
                            },
                          );
                        },
                      ),
                      Consumer<AuthViewProvider>(
                        builder: (context, authModel, child) {
                          return TextFormField(
                            controller: passwordController,
                            decoration:
                                const InputDecoration(labelText: 'Password'),
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a password.';
                              }
                              if (value.length < 8) {
                                return 'Password must be at least 8 characters long.';
                              }
                              if (!containsDigit(value)) {
                                return 'Password must contain at least one digit.';
                              }
                              return null;
                            },
                            onChanged: (newPassword) {},
                          );
                        },
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            await Provider.of<AuthViewProvider>(context,
                                    listen: false)
                                .saveUserData()
                                .then((value) {
                              Navigator.of(context).pushNamed('/home');
                            });
                          }
                        },
                        child: const Text('Sign In'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  bool isValidEmail(String value) {
    return RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
        .hasMatch(value);
  }

  bool containsDigit(String value) {
    return value.contains(RegExp(r'\d'));
  }
}
