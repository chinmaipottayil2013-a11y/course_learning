import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learning_course2/models/profile/user_profile_model.dart';

import 'package:learning_course2/providers/authentication_provider.dart';
import 'package:learning_course2/services/profile_update_service.dart';

class ProfileScreenProvider extends ChangeNotifier {
  final ImagePicker _imagePicker = ImagePicker();
  final ProfileUpdateService _profileUpdateService = ProfileUpdateService();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  UserProfileModel? userProfileModel;

  File? image;
  bool isLoading = false;
  String? errorMessage;

  Future<void> getProfile() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      userProfileModel = await _profileUpdateService.getProfileData();

      final nameParts = userProfileModel!.name.trim().split(RegExp(r'\s+'));
      firstNameController.text = nameParts.first;
      lastNameController.text = nameParts.length > 1
          ? nameParts.sublist(1).join('')
          : '';
    } catch (e, stack) {
      log('Failed to fetch profile data : $e', stackTrace: stack);
      errorMessage = 'Could not load profile';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? pickedImage = await _imagePicker.pickImage(
        source: source,
        imageQuality: 80,
      );
      if (pickedImage != null) {
        image = File(pickedImage.path);
        notifyListeners();
      }
    } catch (e, stackTrace) {
      log('Failed to pick image: $e', stackTrace: stackTrace);
      errorMessage = 'Could not select the image';
      notifyListeners();
    }
  }

  Future<void> pickFromGallery() async {
    await pickImage(ImageSource.gallery);
  }

  Future<void> pickFromCamera() async {
    await pickImage(ImageSource.camera);
  }

  Future<UserProfileModel?> updateProfile(AuthenticationProvider auth) async {
    final name =
        '${firstNameController.text.trim()} ${lastNameController.text.trim()}'
            .trim();

    if (name.isEmpty) {
      errorMessage = 'Enter a valid name';
      notifyListeners();
      return null;
    }

    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final result = await _profileUpdateService.updateProfile(
        image: image,
        name: name,
      );
      userProfileModel = result;
      if (result == null) {
        errorMessage = 'Server returned no profile';
        return null;
      }

      await auth.updatedUser(
        name: result.name,
        profilePicture: result.profilePicture,
      );
      image = null;
      return result;
    } catch (e, stackTrace) {
      log('Profile update failed: $e', stackTrace: stackTrace);
      errorMessage = 'Could not update profile. Try again.';
      return null;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }
}
