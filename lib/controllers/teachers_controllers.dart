import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class AuthController {
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
          .child('ProfileImages')
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

  Future<String> signUpUser(String fullName, String email, String number,
      String password, Uint8List? image) async {
    String res = "";

    if (fullName.isNotEmpty &&
        email.isNotEmpty &&
        number.isNotEmpty &&
        password.isNotEmpty) {
      try {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        String? profileImageUrl = await uploadProfileImageToStorage(image);
        await _fireStore.collection('teachers').doc(cred.user!.uid).set({
          'teacherId': cred.user!.uid,
          'fullName': fullName,
          'email': email,
          'number': number,
          'profileImage': profileImageUrl ?? '',
        });
        res = "success";
      } on FirebaseAuthException catch (e) {
        res = e.message ?? "An error occurred";
      } catch (e) {
        res = "An unexpected error occurred: $e";
      }
    } else {
      res = "All fields must be filled";
    }
    return res;
  }

  loginUsers(String email, String password) async {
    String res = "";
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "Success";
      } else {
        res = "Fileds must be filled.";
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> updateTeacher(
      String fullName, String email, String number, String teacherId) async {
    String res = "";
    try {
      if (fullName.isNotEmpty && email.isNotEmpty && number.isNotEmpty) {
        await _fireStore.collection('teachers').doc(teacherId).update({
          'fullName': fullName,
          'email': email,
          'number': number,
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
