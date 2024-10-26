class Comment {
  late String userId;
  late String postId;
  String comment;

  Comment({required this.userId, required this.postId, required this.comment});

  Comment.fromJson(Map<String, dynamic> json)
      : userId = json['user_id'],
        postId = json['post_id'],
        comment = json['comment'];

  Map<String, dynamic> toJson() => {
        'user_id': userId,
        "post_id": postId,
        'comment': comment,
      };
}
