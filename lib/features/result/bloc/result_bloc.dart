import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'result_event.dart';
part 'result_state.dart';

class ResultBloc extends Bloc<ResultEvent, ResultState> {
  ResultBloc() : super(ResultInitial()) {
    on<ResultEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
