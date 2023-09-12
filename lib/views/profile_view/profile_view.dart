import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pokemon/app.dart';
import 'package:pokemon/config/routes/app_routes.dart';
import 'package:pokemon/providers/profile_provider.dart';
import 'package:pokemon/styles/colors.dart';
import 'package:pokemon/widgets/loading_widget.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatelessWidget {
  final String title;

  const ProfileView({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProfileProvider>(
      create: (context) =>
          GetIt.I.get<ProfileProvider>()..getUserFromDatabase(),
      builder: (context, child) {
        final profileProvider = Provider.of<ProfileProvider>(context);
        if (profileProvider.userModel == null) {
          return const Center(child: LoadingWidget());
        }

        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Column(
              children: [
                AppBar(
                  title: Consumer<ProfileProvider>(
                    builder: (context, authProvider, child) {
                      return Text(
                        profileProvider.userModel?.name ?? '',
                        style: const TextStyle(
                          color: Color(0xFF333333),
                          fontSize: 18,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      );
                    },
                  ),
                  leading: InkWell(
                    onTap: () async {
                      _showImagePickerModal(
                        context: context,
                        profileProvider: profileProvider,
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: profileProvider.userModel!.avatar.isNotEmpty
                          ? Image.memory(
                              base64Decode(profileProvider.userModel!.avatar),
                            )
                          : Image.asset('assets/images/default.png'),
                    ),
                  ),
                  backgroundColor: Colors.white,
                  elevation: 0,
                  shape: const Border(
                    bottom: BorderSide(color: Color(0xFFF2F2F2), width: 1),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      vertical: 24,
                      horizontal: 16,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'Profile Information',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        InkWell(
                          onTap: () async {
                            await App()
                                .router
                                .navigateTo(
                                  context,
                                  editProfileRoute.name,
                                )
                                .then((value) {
                              profileProvider.getUserFromDatabase();
                            });
                          },
                          child: profileItem(
                            title: 'Name',
                            value: profileProvider.userModel?.name ?? '',
                            withIcon: true,
                          ),
                        ),
                        profileItem(
                          title: 'Email',
                          value: profileProvider.userModel?.email ?? '',
                        ),
                        profileItem(
                          title: 'Password',
                          value: '**************',
                        ),
                        const Spacer(),
                        ElevatedButton(
                          onPressed: () async {
                            profileProvider.deleteUserDummyToken();
                            App().router.navigateTo(
                                  context,
                                  authViewRoute.name,
                                  clearStack: true,
                                );
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: AppColors.red,
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Text('Logout'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget profileItem({
    required String title,
    required String value,
    bool withIcon = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF333333),
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  height: 0,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  color: Color(0xFF4D4D4D),
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ],
          ),
          Visibility(
            visible: withIcon,
            child: const Icon(Icons.chevron_right),
          ),
        ],
      ),
    );
  }

  void _pickImage({
    required ImageSource source,
    required ProfileProvider profileProvider,
  }) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source, maxHeight: 200);
    if (pickedFile != null) {
      var image = File(pickedFile.path);
      final bytes = await image.readAsBytes();
      final avatarString = base64Encode(bytes);
      profileProvider.updateUserAvatar(avatar: avatarString);
    } else {
      log('No image selected.');
    }
  }

  void _showImagePickerModal({
    required BuildContext context,
    required ProfileProvider profileProvider,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Pick from Gallery'),
              onTap: () {
                _pickImage(
                  source: ImageSource.gallery,
                  profileProvider: profileProvider,
                );
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Take a Photo'),
              onTap: () {
                _pickImage(
                  source: ImageSource.camera,
                  profileProvider: profileProvider,
                );
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
