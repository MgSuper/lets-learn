import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'noti_event.dart';
part 'noti_state.dart';

class NotiBloc extends Bloc<NotiEvent, NotiState> {
  NotiBloc() : super(NotiInitial()) {
    on<NotiEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
