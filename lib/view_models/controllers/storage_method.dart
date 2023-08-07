import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
class StorageMethod{
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadImageToStorage(String userID, Uint8List file, String imgID) async {

    Reference ref = _storage.ref().child(userID).child(imgID);
     
    UploadTask uploadTask = ref.putData(file);

    TaskSnapshot snap = await uploadTask;
    String downloadURL = await snap.ref.getDownloadURL();
    return downloadURL;
  }
}