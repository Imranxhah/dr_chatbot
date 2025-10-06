import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../config/app_colors.dart';
import '../services/image_service.dart';
import 'chat_diagnosis_screen.dart';

class ImageUploadScreen extends StatefulWidget {
  const ImageUploadScreen({super.key});

  @override
  State<ImageUploadScreen> createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
  File? _selectedImage;
  bool _isProcessing = false;

  Future<void> _pickImage(ImageSource source) async {
    try {
      setState(() => _isProcessing = true);

      final pickedImage = await ImageService.pickImage(source);

      if (pickedImage != null) {
        setState(() => _selectedImage = pickedImage);
      }
    } catch (e) {
      _showError('Failed to pick image: $e');
    } finally {
      setState(() => _isProcessing = false);
    }
  }

  Future<void> _compressAndProceed() async {
    if (_selectedImage == null) return;

    try {
      setState(() => _isProcessing = true);

      // Compress the image
      final compressedImage = await ImageService.compressImage(_selectedImage!);

      // Convert to base64
      final base64Image = await ImageService.imageToBase64(compressedImage);

      // Navigate to chat diagnosis with image
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ChatDiagnosisScreen(
              initialSymptom: 'Image uploaded',
              imageBase64: base64Image,
            ),
          ),
        );
      }

      // Clean up compressed file
      await compressedImage.delete();
    } catch (e) {
      _showError('Failed to process image: $e');
    } finally {
      if (mounted) {
        setState(() => _isProcessing = false);
      }
    }
  }

  void _showError(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  void _showImageSourceDialog() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(AppColors.spacingLarge),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt, color: AppColors.primary),
              title: const Text('Take Photo'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading:
                  const Icon(Icons.photo_library, color: AppColors.primary),
              title: const Text('Choose from Gallery'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Skin Image'),
        centerTitle: true,
      ),
      body: _isProcessing
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: AppColors.primary),
                  SizedBox(height: AppColors.spacingMedium),
                  Text('Processing image...'),
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(AppColors.spacingLarge),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildInstructionCard(),
                  const SizedBox(height: AppColors.spacingXLarge),
                  if (_selectedImage == null) _buildUploadArea(),
                  if (_selectedImage != null) _buildImagePreview(),
                  const Spacer(),
                  if (_selectedImage != null) _buildProceedButton(),
                ],
              ),
            ),
    );
  }

  Widget _buildInstructionCard() {
    return Container(
      padding: const EdgeInsets.all(AppColors.spacingMedium),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppColors.borderRadiusMedium),
      ),
      child: const Row(
        children: [
          Icon(Icons.info_outline, color: AppColors.primary),
          SizedBox(width: AppColors.spacingMedium),
          Expanded(
            child: Text(
              'Take a clear photo of the affected skin area',
              style: TextStyle(
                fontSize: 15,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUploadArea() {
    return Expanded(
      child: InkWell(
        onTap: _showImageSourceDialog,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppColors.borderRadiusLarge),
            border: Border.all(
              color: AppColors.border,
              width: 2,
              style: BorderStyle.solid,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(AppColors.spacingLarge),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.add_photo_alternate,
                  size: 64,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: AppColors.spacingLarge),
              Text(
                'Upload Skin Image',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: AppColors.spacingSmall),
              const Text(
                'Tap to take photo or choose from gallery',
                style: TextStyle(color: AppColors.textSecondary),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImagePreview() {
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppColors.borderRadiusLarge),
              child: Image.file(
                _selectedImage!,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: AppColors.spacingMedium),
          ElevatedButton.icon(
            onPressed: _showImageSourceDialog,
            icon: const Icon(Icons.refresh),
            label: const Text('Change Image'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.secondary,
              foregroundColor: AppColors.textLight,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProceedButton() {
    return ElevatedButton(
      onPressed: _compressAndProceed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        padding: const EdgeInsets.symmetric(vertical: AppColors.spacingMedium),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppColors.borderRadiusMedium),
        ),
        minimumSize: const Size(double.infinity, 50),
      ),
      child: const Text(
        'Analyze Image',
        style: TextStyle(
          color: AppColors.textLight,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
