import 'dart:io';
import 'package:coffee_app/core/widgets/custom_rounded_images.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';
import '../../../../../../core/services/image_upload_service.dart';
import '../../../../../../core/widgets/custom_icon_button.dart';
import '../../../../../authentication/data/services/auth_service.dart';

class EditProfileImageSection extends StatefulWidget {
  const EditProfileImageSection({super.key, this.imageUrl});
  final String? imageUrl;

  @override
  State<EditProfileImageSection> createState() =>
      _EditProfileImageSectionState();
}

class _EditProfileImageSectionState extends State<EditProfileImageSection> {
  final picker = ImagePicker();
  final ImageUploadService _uploadService = ImageUploadService();
  final AuthService _authService = AuthService();

  File? _selectedImage;
  bool _uploading = false;
  String? _uploadedUrl;

  @override
  Widget build(BuildContext context) {
    final imageToShow = _uploadedUrl ?? widget.imageUrl;

    return Stack(
      alignment: Alignment.center,
      children: [
        imageToShow != null
            ? Hero(
                tag: imageToShow,
                child: CustomRoundedImage(
                  imageUrl: imageToShow,
                  aspectRatio: 1,
                  width: 170,
                ),
              )
            : const CustomRoundedImage(
                imageUrl: "assets/icons/user.png",
                isAsset: true,
                aspectRatio: 1,
                width: 170,
              ),

        // 📷 Camera button
        Positioned(
          bottom: 0,
          right: 0,
          child: CustomIconButton(
            padding: 4,
            width: 36,
            hight: 36,
            backgroundColor: context.colors.secondary.withValues(alpha: 0.65),
            onPressed: _uploading ? null : _pickAndUploadImage,
            child: _uploading
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 1.5),
                  )
                : Icon(
                    Ionicons.camera_outline,
                    color: context.colors.onSecondary,
                  ),
          ),
        ),
      ],
    );
  }

  /// 🧭 Step 1: Pick Image from Gallery
  Future<void> _pickAndUploadImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;

    setState(() {
      _uploading = true;
      _selectedImage = File(pickedFile.path);
    });

    try {
      // 🧭 Step 2: Upload to Supabase Storage
      final publicUrl = await _uploadService.uploadImage(
        _selectedImage!,
        ImageType.profile,
      );

      // 🧭 Step 3: Update user's profile_image_url in Supabase
      await _authService.updateUserProfile(profileImageUrl: publicUrl);

      // 🧭 Step 4: Update local UI
      setState(() => _uploadedUrl = publicUrl);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile image updated successfully')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Upload failed: $e')));
      }
    } finally {
      setState(() => _uploading = false);
    }
  }
}
