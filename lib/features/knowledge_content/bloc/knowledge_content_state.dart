part of 'knowledge_content_bloc.dart';

sealed class KnowledgeContentState extends Equatable {
  const KnowledgeContentState();

  @override
  List<Object> get props => [];
}

sealed class KnowledgeContentActionState extends KnowledgeContentState {
  const KnowledgeContentActionState();

  @override
  List<Object> get props => [];
}

final class KnowledgeContentInitial extends KnowledgeContentState {}

final class KnowledgeContentLoading extends KnowledgeContentState {}

final class KnowledgeContentLoaded extends KnowledgeContentState {
  final List<KnowledgeContentModel> kcontents;
  final bool hasMore; // To indicate if more pages are available

  const KnowledgeContentLoaded({required this.kcontents, this.hasMore = true});

  @override
  List<Object> get props => [kcontents, hasMore];
}

final class KnowledgeContentLoadError extends KnowledgeContentState {
  final String err;

  const KnowledgeContentLoadError({required this.err});
}
