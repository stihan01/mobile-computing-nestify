import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:nestify/models/blueprint_post.dart';
import 'dart:io';

class FirestoreDb {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static final FirebaseAuth auth = FirebaseAuth.instance;
  //static final FirebaseStorage _storage = FirebaseStorage(storageBucket:"gs://nestify-cc1e3.appspot.com" );
  static final _storageRef = FirebaseStorage.instance.ref();

  static final userID = auth.currentUser!.uid;

  // collections
  static const blueprintPosts = "blueprints";

  static Future<void> uploadBlueprint(BlueprintPost post) async {
    final Map<String, dynamic> jsonData = post.toJson();
    List<String> downloadUrls = [];

    if (post.images.isNotEmpty) {
      for (File img in post.images) {
        await _uploadImage(img, post.id).then((String result) {
          downloadUrls.add(result);
        });
      }

      jsonData['images'] = downloadUrls;
    }

    debugPrint(jsonData.toString());

    await _db.collection(blueprintPosts).doc(post.id).set(jsonData);
  }

  static Future<String> _uploadImage(File file, String postID) async {
    String filePath = "$userID/$blueprintPosts/$postID/${file.path}.png";
    await _storageRef.child(filePath).putFile(file);

    String downloadURL = await _storageRef.child(filePath).getDownloadURL();
    return downloadURL;
  }
}
