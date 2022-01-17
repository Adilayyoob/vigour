// ignore_for_file: file_names, non_constant_identifier_names

import 'package:firebase_storage/firebase_storage.dart';

class NetworkImageFetch{
  String? image_id = "";
  NetworkImageFetch({required this.image_id});
  Future<String> downloadURLExample() async {
    String downloadURL =
        await FirebaseStorage.instance.ref("users/$image_id").getDownloadURL();
    print(downloadURL);
    return downloadURL;
  }
}