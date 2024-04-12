part of 'select_category_bloc.dart';

@immutable
sealed class SelectCategoryEvent {}

class UserLoadedEvent extends SelectCategoryEvent {}

class ChooseAndConfirmCategoryEvent extends SelectCategoryEvent {
  final String category;
  ChooseAndConfirmCategoryEvent({required this.category});
}
