import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pokemon/app.dart';
import 'package:pokemon/providers/profile_provider.dart';
import 'package:pokemon/styles/colors.dart';
import 'package:pokemon/utils/string_utils.dart';
import 'package:provider/provider.dart';

class EditProfileView extends StatelessWidget {
  EditProfileView({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProfileProvider>(
      create: (context) =>
          GetIt.I.get<ProfileProvider>()..getUserFromDatabase(),
      builder: (context, child) {
        final profileProvider = Provider.of<ProfileProvider>(context);
        nameController.text = profileProvider.userModel?.name ?? '';
        emailController.text = profileProvider.userModel?.email ?? '';

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.black),
            title: const Text(
              'Edit Profile',
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
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  Consumer<ProfileProvider>(
                    builder: (context, profileProvider, child) {
                      return TextFormField(
                        controller: nameController,
                        decoration: const InputDecoration(labelText: 'Name'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a name.';
                          }
                          if (!StringUtil.isValidName(value)) {
                            return 'Please enter a valid.';
                          }
                          return null;
                        },
                      );
                    },
                  ),
                  Consumer<ProfileProvider>(
                    builder: (context, profileProvider, child) {
                      return TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(labelText: 'Email'),
                        enabled: false,
                      );
                    },
                  ),
                  Consumer<ProfileProvider>(
                    builder: (context, profileProvider, child) {
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
                      );
                    },
                  ),
                  Visibility(
                    visible: profileProvider.warningMessage.isNotEmpty,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text(
                        profileProvider.warningMessage,
                        style: const TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          if (passwordController.text !=
                              profileProvider.userModel!.password) {
                            profileProvider.setWarningMessage();
                          } else {
                            await profileProvider
                                .updateUserName(
                              newName: nameController.text,
                            )
                                .then((value) {
                              App().router.pop(context);
                            });
                          }
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
                      child: const Text('Save'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
