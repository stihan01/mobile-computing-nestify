class Comment {
  late String userId;
  late String postId;
  late String username;
  String comment;

  Comment(
      {required this.userId,
      required this.postId,
      required this.comment,
      this.username = ""});

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
