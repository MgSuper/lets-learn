class CommentModel {
  final String id;
  final String contentId;
  final String userId;
  final String text;
  final DateTime timestamp;

  CommentModel({
    required this.id,
    required this.contentId,
    required this.userId,
    required this.text,
    required this.timestamp,
  });

  factory CommentModel.fromFirestore(Map<String, dynamic> data, String id) {
    return CommentModel(
      id: id,
      contentId: data['contentId'] as String,
      userId: data['userId'] as String,
      text: data['text'] as String,
      timestamp: DateTime.parse(data['timestamp'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'contentId': contentId,
      'userId': userId,
      'text': text,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
