import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pokemon/app.dart';
import 'package:pokemon/config/routes/app_routes.dart';
import 'package:pokemon/providers/auth_view_provider.dart';
import 'package:pokemon/styles/colors.dart';
import 'package:pokemon/utils/string_utils.dart';
import 'package:provider/provider.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return ChangeNotifierProvider<AuthViewProvider>(
      create: (context) => GetIt.I.get<AuthViewProvider>(),
      builder: (context, child) {
        final authViewProvider = Provider.of<AuthViewProvider>(context);
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.black),
            title: const Text(
              'Sign In',
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
                      Consumer<AuthViewProvider>(
                        builder: (context, authViewProvider, child) {
                          return TextFormField(
                            controller: emailController,
                            decoration:
                                const InputDecoration(labelText: 'Email'),
                            onChanged: (newEmail) {
                              authViewProvider.email = newEmail;
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
                      Consumer<AuthViewProvider>(
                        builder: (context, authViewProvider, child) {
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
                              authViewProvider.password = newPassword;
                            },
                          );
                        },
                      ),
                      Visibility(
                        visible: authViewProvider.warningMessage.isNotEmpty,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Text(
                            authViewProvider.warningMessage,
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
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              authViewProvider
                                  .getUserFromDatabase()
                                  .then((existingUser) {
                                final String password =
                                    authViewProvider.password;

                                if (existingUser != null &&
                                    existingUser.password == password) {
                                  _navigateToHome(
                                    context: context,
                                    authViewProvider: authViewProvider,
                                  );
                                } else {
                                  authViewProvider.warningMessage =
                                      'Wrong Email/Password, please retry';
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
                          child: const Text('Sign In'),
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
    required AuthViewProvider authViewProvider,
  }) {
    authViewProvider.saveUserDummyToken();
    App().router.navigateTo(
          context,
          homeViewRoute.name,
          clearStack: true,
        );
  }
}
