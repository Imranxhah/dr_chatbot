import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;

class ImageService {
  static final ImagePicker _picker = ImagePicker();

  /// Pick image from camera or gallery
  static Future<File?> pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        return File(pickedFile.path);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to pick image: $e');
    }
  }

  /// Compress image to reduce size
  static Future<File> compressImage(File imageFile) async {
    try {
      // Read the image
      final bytes = await imageFile.readAsBytes();
      img.Image? image = img.decodeImage(bytes);

      if (image == null) {
        throw Exception('Failed to decode image');
      }

      // Resize if too large
      if (image.width > 800 || image.height > 800) {
        image = img.copyResize(
          image,
          width: image.width > image.height ? 800 : null,
          height: image.height > image.width ? 800 : null,
        );
      }

      // Compress to JPEG with quality 85
      final compressedBytes = img.encodeJpg(image, quality: 85);

      // Save compressed image
      final compressedFile = File('${imageFile.path}_compressed.jpg');
      await compressedFile.writeAsBytes(compressedBytes);

      return compressedFile;
    } catch (e) {
      throw Exception('Failed to compress image: $e');
    }
  }

  /// Convert image to base64 for API
  static Future<String> imageToBase64(File imageFile) async {
    try {
      final bytes = await imageFile.readAsBytes();
      return base64Encode(bytes);
    } catch (e) {
      throw Exception('Failed to convert image to base64: $e');
    }
  }
}
