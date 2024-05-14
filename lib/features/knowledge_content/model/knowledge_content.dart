// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timeago/timeago.dart' as timeago;

class KnowledgeContentModel {
  final String id;
  final String imageUrl;
  final String title;
  final String description;
  bool isLikedByUser;
  final List<String> likedByUsers;
  final DateTime timestamp;
  final String category;
  // List<String> Comment;

  KnowledgeContentModel({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.isLikedByUser,
    required this.likedByUsers,
    required this.timestamp,
    required this.category,
  });

  factory KnowledgeContentModel.fromFirestore(
      Map<String, dynamic> data, String id) {
    return KnowledgeContentModel(
      id: id,
      imageUrl: data['imageUrl'] as String,
      title: data['title'] as String,
      description: data['description'] as String,
      isLikedByUser: data['isLikedByUser'] as bool,
      likedByUsers: List<String>.from(data['likedByUsers'] as List<dynamic>),
      timestamp: (data['timestamp'] as Timestamp).toDate(),
      category: data['category'] as String,
      // comments: List<String>.from(data['comments'] as List<dynamic>),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'imageUrl': imageUrl,
      'title': title,
      'description': description,
      'isLikedByUser': isLikedByUser,
      'likedByUsers': likedByUsers,
      'timestamp': Timestamp.fromDate(timestamp),
      'category': category,
      // 'comments': comments,
    };
  }

  // Add the `copyWith` method to return an updated instance
  KnowledgeContentModel copyWith({
    String? id,
    String? imageUrl,
    String? title,
    String? description,
    bool? isLikedByUser,
    List<String>? likedByUsers,
    DateTime? timestamp,
    String? category,
  }) {
    return KnowledgeContentModel(
        id: id ?? this.id,
        imageUrl: imageUrl ?? this.imageUrl,
        title: title ?? this.title,
        description: description ?? this.description,
        isLikedByUser: isLikedByUser ?? this.isLikedByUser,
        likedByUsers: likedByUsers ?? this.likedByUsers,
        timestamp: timestamp ?? this.timestamp,
        category: category ?? this.category);
  }

  // void addComment(String comment) {
  //   comments.add(comment);
  // }

  /// Calculate the relative time for the timestamp
  String getRelativeTime() {
    return timeago.format(timestamp);
  }

  void toggleLike(String userId) {
    if (isLikedByUser) {
      isLikedByUser = false;
    } else {
      isLikedByUser = true;
    }
  }
}
