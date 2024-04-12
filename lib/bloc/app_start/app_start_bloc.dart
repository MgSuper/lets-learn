import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'app_start_event.dart';
part 'app_start_state.dart';

class AppStartBloc extends Bloc<AppStartEvent, AppStartState> {
  AppStartBloc() : super(AppStartInitial()) {
    on<AppStartEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
