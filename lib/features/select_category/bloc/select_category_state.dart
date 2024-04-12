part of 'select_category_bloc.dart';

@immutable
sealed class SelectCategoryState {}

@immutable
sealed class SelectCategoryActionState extends SelectCategoryState {}

final class SelectCategoryInitial extends SelectCategoryState {}

final class SelectedCategory extends SelectCategoryActionState {}

final class UserLoaded extends SelectCategoryState {}
