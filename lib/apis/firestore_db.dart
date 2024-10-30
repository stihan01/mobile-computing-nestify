import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:nestify/models/blueprint_post.dart';
import 'dart:io';
import 'package:nestify/models/comment.dart';

class FirestoreDb {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static final _storageRef = FirebaseStorage.instance.ref();
  static final userID = userId();
  // collections
  static const blueprintCollection = "blueprints";
  static const commentCollection = "comments";

  static String userId() {
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
          BlueprintPost post = BlueprintPost.fromJson(docSnapShot.data());
          if (post.favoritedBy!.contains(userID)) {
            post.isFavorite = true;
          }
          return post;
        }).toList();
      });
    } catch (error) {
      debugPrint("Error fetching user blueprints: Error: $error");
    }
    return posts;
  }

  static Future<List<BlueprintPost>> getMyFavoriteBlueprints() async {
    List<BlueprintPost> posts = [];

    try {
      posts = await _db
          .collection(blueprintCollection)
          .where('favorited', arrayContains: userID)
          .get()
          .then((query) {
        return query.docs.map((docSnapShot) {
          BlueprintPost post = BlueprintPost.fromJson(docSnapShot.data());
          post.isFavorite = true;
          return post;
        }).toList();
      });
    } catch (error) {
      debugPrint("Error fetching user's favorite blueprints: Error: $error");
    }
    return posts;
  }

  static Future<List<BlueprintPost>> getCurrentUserBlueprints() async {
    List<BlueprintPost> posts = [];
    String user = userID;

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

  static Future<bool> deleteUserBlueprint(BlueprintPost post) async {
    try {
      await _db
          .collection(blueprintCollection)
          .where('user_id', isEqualTo: userID)
          .where('post_id', isEqualTo: post.id)
          .get()
          .then((query) {
        return query.docs.map((docSnapShot) {
          docSnapShot.reference.delete();
          // debugPrint("My post: ${docSnapShot.data()}");
        }).toList();
      });
      return true;
    } catch (error) {
      debugPrint("Failed to delete post: $error");
      return false;
    }
  }

  static Future<void> updateFavoritePosts(BlueprintPost post) async {
    try {
      if (post.isFavorite) {
        await _db.collection(blueprintCollection).doc(post.id).update({
          "favorited": FieldValue.arrayUnion([userID])
        });

        return;
      }
      await _db.collection(blueprintCollection).doc(post.id).update({
        "favorited": FieldValue.arrayRemove([userID])
      });
    } catch (error) {
      debugPrint("Error updating favorites: $error");
    }
  }

  static Future<void> uploadBlueprint(
    BlueprintPost post,
  ) async {
    try {
      await _db.collection(blueprintCollection).doc(post.id).set(post.toJson());
    } catch (error) {
      debugPrint("Error uploading bluperint: $error");
    }
  }

  static Future<Map<String, String>> uploadImage(
      File file, String postID) async {
    String user = userID;
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
