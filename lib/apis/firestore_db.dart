import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:nestify/models/blueprint_post.dart';
import 'dart:io';

import 'package:nestify/models/comment.dart';
import 'dart:developer' as dev;

class FirestoreDb {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  //static final FirebaseAuth auth = FirebaseAuth.instance;
  static final _storageRef = FirebaseStorage.instance.ref();

  // static final userID = auth.currentUser!.uid;

  // collections
  static const blueprintCollection = "blueprints";
  static const commentCollection = "comments";

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

  // Below comment collection queries

  static Future<List<Comment>> getBlueprintComments(String postId) async {
    List<Comment> comments = [];

    try {
      comments = await _db.collection(commentCollection).get().then((query) {
        return query.docs.map((docSnapShot) {
          return Comment.fromJson(docSnapShot.data());
        }).toList();
      });
    } catch (error) {
      debugPrint(
          "Error fetching comments for blueprintId $postId | Error: $error");
    }
    return comments;
  }

  static Future<void> uploadComment(Comment comment) async {
    try {
      await _db
          .collection(commentCollection)
          .doc(DateTime.now().toString())
          .set(comment.toJson());
    } catch (error) {
      debugPrint("Failed to upload comment: $error");
    }
  }

  // Below blueprint collection queries
  static Future<List<BlueprintPost>> fetchBlueprints() async {
    List<BlueprintPost> posts = [];

    try {
      posts = await _db.collection(blueprintCollection).get().then((query) {
        return query.docs.map((docSnapShot) {
          return BlueprintPost.fromJson(docSnapShot.data());
        }).toList();
      });
    } catch (error) {
      debugPrint("Error fetching user blueprints: Error: $error");
    }
    return posts;
  }

  static Future<List<BlueprintPost>> getMyFavoriteBlueprints() async {
    List<BlueprintPost> posts = [];
    String user = _userId();

    try {
      posts = await _db
          .collection(blueprintCollection)
          .where('user_id', isEqualTo: user)
          .where('isFavorite', isEqualTo: true)
          .get()
          .then((query) {
        return query.docs.map((docSnapShot) {
          return BlueprintPost.fromJson(docSnapShot.data());
        }).toList();
      });
    } catch (error) {
      debugPrint("Error fetching user's favorite blueprints: Error: $error");
    }
    return posts;
  }

  static Future<List<BlueprintPost>> getCurrentUserBlueprints() async {
    List<BlueprintPost> posts = [];
    String user = _userId();

    try {
      posts = await _db
          .collection(blueprintCollection)
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
    await _db.collection(blueprintCollection).doc(post.id).set(post.toJson());
  }

  static Future<Map<String, String>> uploadImage(
      File file, String postID) async {
    String user = _userId();
    String filePath =
        "$user()/$blueprintCollection/$postID/${DateTime.now()}.png";
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
