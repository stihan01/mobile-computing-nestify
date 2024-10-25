import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:nestify/models/blueprint_post.dart';
import 'dart:io';

class FirestoreDb {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  //static final FirebaseAuth auth = FirebaseAuth.instance;
  static final _storageRef = FirebaseStorage.instance.ref();

  // static final userID = auth.currentUser!.uid;

  // collections
  static const blueprintPosts = "blueprints";
  static String _userId() {
    try {
      String user = FirebaseAuth.instance.currentUser!.uid;
      debugPrint(user);
      return user;
    } catch (error) {
      debugPrint("Something went wrong getting userId: $error");
    }
    return '';
  }

  static Future<List<BlueprintPost>> fetchBlueprints() async {
    List<BlueprintPost> posts = [];

    try {
      posts = await _db.collection(blueprintPosts).get().then((query) {
        return query.docs.map((docSnapShot) {
          debugPrint(docSnapShot.data().toString());
          return BlueprintPost.fromJson(docSnapShot.data());
        }).toList();
      });
    } catch (error) {
      debugPrint("Error fetching user blueprints: Error: $error");
    }
    return posts;
  }

  static Future<List<BlueprintPost>> getCurrentUserBlueprints() async {
    List<BlueprintPost> posts = [];
    String user = _userId();

    try {
      posts = await _db
          .collection(blueprintPosts)
          .where('user_id', isEqualTo: user)
          .get()
          .then((query) {
        return query.docs.map((docSnapShot) {
          return BlueprintPost.fromJson(docSnapShot.data());
        }).toList();
      });
    } catch (error) {
      debugPrint("Error fetching user blueprints: Error: $error");
    }
    return posts;
  }

  static Future<void> uploadBlueprint(
    BlueprintPost post,
  ) async {
    await _db.collection(blueprintPosts).doc(post.id).set(post.toJson());
  }

  static Future<Map<String, String>> uploadImage(
      File file, String postID) async {
    String user = _userId();
    String filePath = "$user()/$blueprintPosts/$postID/${DateTime.now()}.png";
    await _storageRef.child(filePath).putFile(file);
    String downloadURL = await _storageRef.child(filePath).getDownloadURL();
    return {downloadURL: filePath};
  }

  static Future<void> deleteImage(String filePath) async {
    try {
      await _storageRef.child(filePath).delete();
    } catch (error) {
      debugPrint("Image deletion failed: $error");
    }
  }
}
