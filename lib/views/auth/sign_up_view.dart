import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pokemon/app.dart';
import 'package:pokemon/config/routes/app_routes.dart';
import 'package:pokemon/providers/auth_provider.dart';
import 'package:pokemon/styles/colors.dart';
import 'package:pokemon/utils/string_utils.dart';
import 'package:provider/provider.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return ChangeNotifierProvider<AuthProvider>(
      create: (context) => GetIt.I.get<AuthProvider>(),
      builder: (context, child) {
        final authProvider = Provider.of<AuthProvider>(context);
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.black),
            title: const Text(
              'Sign Up',
              style: TextStyle(
                color: Color(0xFF333333),
                fontSize: 18,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            shape: const Border(
              bottom: BorderSide(color: Color(0xFFF2F2F2), width: 1),
            ),
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        'assets/images/logo.png',
                        fit: BoxFit.contain,
                        width: MediaQuery.of(context).size.width * 0.4,
                      ),
                      const SizedBox(height: 24),
                      Consumer<AuthProvider>(
                        builder: (context, authProvider, child) {
                          return TextFormField(
                            controller: nameController,
                            decoration:
                                const InputDecoration(labelText: 'Name'),
                            onChanged: (newName) {
                              authProvider.name = newName;
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a name.';
                              }
                              if (!StringUtil.isValidName(value)) {
                                return 'Please enter a valid email address.';
                              }
                              return null;
                            },
                          );
                        },
                      ),
                      Consumer<AuthProvider>(
                        builder: (context, authProvider, child) {
                          return TextFormField(
                            controller: emailController,
                            decoration:
                                const InputDecoration(labelText: 'Email'),
                            onChanged: (newEmail) {
                              authProvider.email = newEmail;
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter an email address.';
                              }
                              if (!StringUtil.isValidEmail(value)) {
                                return 'Please enter a valid email address.';
                              }
                              return null;
                            },
                          );
                        },
                      ),
                      Consumer<AuthProvider>(
                        builder: (context, authProvider, child) {
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
                              return null;
                            },
                            onChanged: (newPassword) {
                              authProvider.password = newPassword;
                            },
                          );
                        },
                      ),
                      Visibility(
                        visible: authProvider.warningMessage.isNotEmpty,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Text(
                            authProvider.warningMessage,
                            style: const TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              authProvider
                                  .getUserFromDatabase()
                                  .then((existingUser) {
                                final String password = authProvider.password;

                                if (existingUser != null &&
                                    existingUser.password == password) {
                                  _navigateToHome(
                                    context: context,
                                    authProvider: authProvider,
                                  );
                                } else {
                                  authProvider
                                      .saveUserToDatabase()
                                      .then((value) {
                                    _navigateToHome(
                                      context: context,
                                      authProvider: authProvider,
                                    );
                                  });
                                }
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: AppColors.darkBlue,
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Text('Sign Up'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _navigateToHome({
    required BuildContext context,
    required AuthProvider authProvider,
  }) {
    authProvider.saveUserDummyToken();
    App().router.navigateTo(
          context,
          homeViewRoute.name,
          clearStack: true,
        );
  }
}
