import 'package:image_picker/image_picker.dart';

class PickImageFromGallery {
  Future<String?> call() async {
    final ImagePicker picker = ImagePicker();

    final XFile? image = await picker.pickImage(source: ImageSource.gallery, imageQuality: 10);

    return image?.path;
  }
}
