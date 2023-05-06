import 'package:image_picker/image_picker.dart';

class CaptureImageFromCamera {
  CaptureImageFromCamera();

  Future<String?> call() async {
    final ImagePicker picker = ImagePicker();

    final XFile? image = await picker.pickImage(source: ImageSource.camera, imageQuality: 40);

    return image?.path;
  }
}
