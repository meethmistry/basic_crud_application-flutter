import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class StudentController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<Uint8List?> pickProfileImage(ImageSource source) async {
    try {
      final ImagePicker imagePicker = ImagePicker();
      XFile? file = await imagePicker.pickImage(source: source);
      if (file != null) {
        return await file.readAsBytes();
      }
    } catch (e) {
      print('Error picking image: $e');
    }
    return null;
  }

  Future<String?> uploadProfileImageToStorage(Uint8List? image) async {
    if (image == null) {
      return null;
    }
    try {
      Reference ref = _firebaseStorage
          .ref()
          .child('StudentImages')
          .child(_auth.currentUser!.uid);
      UploadTask uploadTask = ref.putData(image);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  Future<String> addNewStudent(String fullName, String email, String number,
      String age, String address, Uint8List? image) async {
    String res = "";
    try {
      if (fullName.isNotEmpty &&
          email.isNotEmpty &&
          number.isNotEmpty &&
          age.isNotEmpty &&
          address.isNotEmpty &&
          image != null) {
        String? storeImage = await uploadProfileImageToStorage(image);
        final studentId = Uuid().v4();
        await _fireStore
            .collection('students')
            .doc(studentId)
            .set({
          'mentorId': FirebaseAuth.instance.currentUser!.uid,
          'studentId': studentId,
          'studentName': fullName,
          'studentEmail': email,
          'studentNumber': number,
          'studentAge': age,
          'studentAddress': address,
          'studentImageUrl': storeImage,
        });
        res = "suceess";
      } else {
        res = "All fields must be filled.";
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
