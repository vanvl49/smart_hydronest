import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class CloudinaryService {
  final picker = ImagePicker();

  Future<String?> uploadImageToCloudinary() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return null;

    final file = File(pickedFile.path);
    final url = Uri.parse(
      'https://api.cloudinary.com/v1_1/dtr7unytl/image/upload',
    );

    final request =
        http.MultipartRequest('POST', url)
          ..fields['upload_preset'] = 'flutter_preset'
          ..files.add(await http.MultipartFile.fromPath('file', file.path));

    final response = await request.send();
    final resStr = await response.stream.bytesToString();
    final jsonResp = jsonDecode(resStr);

    if (response.statusCode == 200) {
      return jsonResp['secure_url']; // <- ini bisa kamu simpan ke Firestore
    } else {
      print("Upload failed: $jsonResp");
      return null;
    }
  }
}
