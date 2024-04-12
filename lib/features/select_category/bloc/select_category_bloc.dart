import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'select_category_event.dart';
part 'select_category_state.dart';

// Define an enum for categories
enum Category { grammar, vocabulary, reading }

class SelectCategoryBloc
    extends Bloc<SelectCategoryEvent, SelectCategoryState> {
  SelectCategoryBloc() : super(SelectCategoryInitial()) {
    on<UserLoadedEvent>(_userLoadedEvent);

    on<ChooseAndConfirmCategoryEvent>(_chooseAndConfirmCategoryEvent);
  }

  FutureOr<void> _userLoadedEvent(
      UserLoadedEvent event, Emitter<SelectCategoryState> emit) {}

  FutureOr<void> _chooseAndConfirmCategoryEvent(
      ChooseAndConfirmCategoryEvent event, Emitter<SelectCategoryState> emit) {}
}
