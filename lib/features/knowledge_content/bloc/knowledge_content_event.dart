// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'knowledge_content_bloc.dart';

sealed class KnowledgeContentEvent extends Equatable {
  const KnowledgeContentEvent();

  @override
  List<Object> get props => [];
}

class FetchKnowledgeContents extends KnowledgeContentEvent {
  const FetchKnowledgeContents();

  @override
  List<Object> get props => [];
}

class FetchNextKnowledgeContents extends KnowledgeContentEvent {}

class FetchContentsByCategory extends KnowledgeContentEvent {
  final String category;
  const FetchContentsByCategory(this.category);

  @override
  List<Object> get props => [category];
}

class FetchNextContentsByCategory extends KnowledgeContentEvent {
  final String category;
  const FetchNextContentsByCategory(this.category);
  @override
  List<Object> get props => [category];
}

class LikeContent extends KnowledgeContentEvent {
  final String contentId;
  final String userId;
  const LikeContent({
    required this.contentId,
    required this.userId,
  });

  @override
  List<Object> get props => [contentId, userId];
}

class AddComment extends KnowledgeContentEvent {
  const AddComment();

  @override
  List<Object> get props => [];
}
