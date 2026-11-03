import 'package:flutter/material.dart';
import 'package:learning_course2/core/constants/colors_constants.dart';
import 'package:learning_course2/providers/authentication_provider.dart';
import 'package:learning_course2/providers/profile_screen_provider.dart';
import 'package:provider/provider.dart';

class ScreenProfileUpdate extends StatelessWidget {
  const ScreenProfileUpdate({super.key});

  InputDecoration _fieldDecoration(String hint, IconData icon) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: const BorderSide(color: Colors.black12),
    );
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 14),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(vertical: 16),
      prefixIcon: Icon(icon, size: 20, color: Colors.grey.shade500),
      enabledBorder: border,
      disabledBorder: border,
      focusedBorder: border.copyWith(
        borderSide: BorderSide(color: Colors.yellow.shade700, width: 1.5),
      ),
    );
  }

  Widget _sheetOption({
    required String label,
    required IconData icon,
    required VoidCallback onTap,
    Color? color,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 2),
      leading: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: (color ?? Colors.yellow.shade700).withValues(alpha: 0.12),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color ?? Colors.yellow.shade700, size: 22),
      ),
      title: Text(
        label,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: color ?? Colors.black87,
        ),
      ),
      onTap: onTap,
    );
  }

  void _openBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: ColorsConstants.background,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetContext) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 12),

          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Profile photo',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              _sheetOption(
                label: 'Take Photo',
                icon: Icons.photo_camera_outlined,
                onTap: () {
                  Navigator.pop(sheetContext);
                  context.read<ProfileScreenProvider>().pickFromCamera();
                },
              ),
              _sheetOption(
                label: 'Choose from gallery',
                icon: Icons.photo_library_outlined,
                onTap: () {
                  Navigator.pop(sheetContext);
                  context.read<ProfileScreenProvider>().pickFromGallery();
                },
              ),
              _sheetOption(
                label: 'Remove photo',
                icon: Icons.delete_forever_outlined,
                color: Colors.red.shade700,
                onTap: () {
                  Navigator.pop(sheetContext);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> sumbit(BuildContext context) async {
    final provider = context.read<ProfileScreenProvider>();
    final auth = context.read<AuthenticationProvider>();
    final updated = await provider.updateProfile(auth);
    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          updated != null
              ? 'Profile updated'
              : provider.errorMessage ?? 'Error ',
        ),
      ),
    );
    if (updated != null) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProfileScreenProvider>();
    final isLoading = provider.isLoading;

    final profileImage = provider.userProfileModel?.profilePicture;

    final hasProfileImage = profileImage != null && profileImage.isNotEmpty;
    return Scaffold(
      backgroundColor: ColorsConstants.background,
      appBar: AppBar(
        backgroundColor: ColorsConstants.background,
        title: const Text(
          'Profile Update',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: GestureDetector(
                onTap: () => _openBottomSheet(context),
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.grey.shade200,
                      backgroundImage: provider.image != null
                          ? FileImage(provider.image!)
                          : hasProfileImage
                          ? NetworkImage(profileImage) as ImageProvider
                          : null,
                      child: provider.image == null && !hasProfileImage
                          ? Icon(
                              Icons.person,
                              size: 50,
                              color: Colors.grey.shade500,
                            )
                          : null,
                    ),
                    Positioned(
                      bottom: 3,
                      right: 5,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 5,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.12),
                              spreadRadius: 0.2,
                              blurRadius: 7,
                              offset: const Offset(1, 3),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.edit_outlined,
                          size: 20,
                          color: Colors.yellow.shade700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 15, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('First Name', style: TextStyle(fontSize: 14)),
                  SizedBox(height: 10),
                  TextField(
                    controller: provider.firstNameController,
                    textInputAction: TextInputAction.next,
                    decoration: _fieldDecoration(
                      'Enter your name',
                      Icons.person_2_outlined,
                    ),
                  ),
                  SizedBox(height: 15),
                  Text('Last Name', style: TextStyle(fontSize: 14)),
                  SizedBox(height: 10),
                  TextField(
                    controller: provider.lastNameController,
                    decoration: _fieldDecoration(
                      'Enter your last name',
                      Icons.person_2_outlined,
                    ),
                  ),
                  SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.yellow.shade500,
                      ),
                      onPressed: isLoading ? null : () => sumbit(context),
                      label: isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.black87,
                              ),
                            )
                          : const Text(
                              'Update your profile',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                                fontSize: 13,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
