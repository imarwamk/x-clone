import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

Future<XFile?> pickImage() async {
  try {
    final XFile? pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 20,
    );
    if (pickedImage == null) {
      return null;
    }
    return pickedImage;
  } catch (e) {
    return null;
  }
}





Future<String> uploadImageFromBytes(Uint8List data, String originalName) async {
  final supabase = Supabase.instance.client;

  final String uniqueId = const Uuid().v4();

  final String fileName = '$uniqueId.png';

  await supabase.storage.from('images').uploadBinary(
        fileName,
        data,
        fileOptions: const FileOptions(upsert: true),
      );

  final path =  supabase.storage.from('images').getPublicUrl(fileName);
  return path;
}
