import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:boost_e_skills/features/knowledge_content/model/knowledge_content.dart';
import 'package:boost_e_skills/features/knowledge_content/repo/knowledge_content_repository.dart';
import 'package:equatable/equatable.dart';

part 'knowledge_content_event.dart';
part 'knowledge_content_state.dart';

class KnowledgeContentBloc
    extends Bloc<KnowledgeContentEvent, KnowledgeContentState> {
  final KnowledgeContentRepository repository;
  static const int pageSize = 5;
  StreamSubscription? _streamSubscription;
  KnowledgeContentBloc(this.repository) : super(KnowledgeContentInitial()) {
    on<FetchKnowledgeContents>(_onFetchKnowledgeContents);
    on<FetchNextKnowledgeContents>(_fetchNextKnowledgeContents);
    on<FetchContentsByCategory>(_fetchContentsByCategory);
    on<FetchNextContentsByCategory>(_fetchNextContentsByCategory);
    on<LikeContent>(_onLikeContent);
  }

  @override
  Future<void> close() {
    _streamSubscription!.cancel();
    return super.close();
  }

  Future<void> _onFetchKnowledgeContents(
      FetchKnowledgeContents event, Emitter<KnowledgeContentState> emit) async {
    emit(KnowledgeContentLoading());
    repository.resetPagination();

    final stream = repository.streamAllContents(pageSize);
    await emit.forEach(
      stream,
      onData: (List<KnowledgeContentModel> data) => KnowledgeContentLoaded(
          kcontents: data, hasMore: data.length == pageSize),
      onError: (error, stackTrace) =>
          KnowledgeContentLoadError(err: error.toString()),
    );
  }

  Future<void> _fetchNextKnowledgeContents(FetchNextKnowledgeContents event,
      Emitter<KnowledgeContentState> emit) async {
    final currentState = state;
    if (currentState is KnowledgeContentLoaded && currentState.hasMore) {
      try {
        final newContents = await repository.fetchAllContents(pageSize);
        final allContents =
            List<KnowledgeContentModel>.from(currentState.kcontents)
              ..addAll(newContents);
        emit(KnowledgeContentLoaded(
            kcontents: allContents, hasMore: newContents.length == pageSize));
      } catch (e) {
        emit(KnowledgeContentLoadError(err: e.toString()));
      }
    }
  }

  Future<void> _fetchContentsByCategory(FetchContentsByCategory event,
      Emitter<KnowledgeContentState> emit) async {
    emit(KnowledgeContentLoading());
    repository.resetPagination(isCategory: true);

    final stream =
        repository.streamByCategoryWithPagination(event.category, pageSize);
    await emit.forEach(
      stream,
      onData: (List<KnowledgeContentModel> data) => KnowledgeContentLoaded(
          kcontents: data, hasMore: data.length == pageSize),
      onError: (error, stackTrace) =>
          KnowledgeContentLoadError(err: error.toString()),
    );
  }

  Future<void> _fetchNextContentsByCategory(FetchNextContentsByCategory event,
      Emitter<KnowledgeContentState> emit) async {
    final currentState = state;
    if (currentState is KnowledgeContentLoaded && currentState.hasMore) {
      try {
        final newContents = await repository.fetchByCategoryWithPagination(
            event.category, pageSize);
        final allContents =
            List<KnowledgeContentModel>.from(currentState.kcontents)
              ..addAll(newContents);
        emit(KnowledgeContentLoaded(
            kcontents: allContents, hasMore: newContents.length == pageSize));
      } catch (e) {
        emit(KnowledgeContentLoadError(err: e.toString()));
      }
    }
  }

  Future<void> _onLikeContent(
      LikeContent event, Emitter<KnowledgeContentState> emit) async {
    try {
      // Update the like state in Firestore
      await repository.likeContent(event.contentId, event.userId);

      // Check if the current state is `KnowledgeContentLoaded`
      if (state is KnowledgeContentLoaded) {
        final currentState = state as KnowledgeContentLoaded;

        // Clone the current list to retain all loaded pages
        final List<KnowledgeContentModel> updatedContents =
            List.from(currentState.kcontents);

        // Find the index of the content to be updated
        final index = updatedContents
            .indexWhere((content) => content.id == event.contentId);

        if (index != -1) {
          // Create a new list of liked users
          final updatedLikedByUsers =
              List<String>.from(updatedContents[index].likedByUsers);

          // Toggle the like status for the user
          if (updatedLikedByUsers.contains(event.userId)) {
            updatedLikedByUsers.remove(event.userId);
          } else {
            updatedLikedByUsers.add(event.userId);
          }

          // Create a new instance of the content model with the updated like status
          final updatedContent = updatedContents[index].copyWith(
            likedByUsers: updatedLikedByUsers,
          );
          updatedContents[index] = updatedContent;

          // Emit the updated state with all loaded data intact
          emit(KnowledgeContentLoaded(
            kcontents: updatedContents,
            hasMore: currentState.hasMore,
          ));
        }
      }
    } catch (e) {
      emit(KnowledgeContentLoadError(err: e.toString()));
    }
  }
}
