import 'package:bloc/bloc.dart';
import 'package:foodozzz/bloc/foodjoint/event.dart';
import 'package:foodozzz/bloc/foodjoint/satets.dart';
import 'package:foodozzz/bloc/foodjoint/services.dart';


class FJBloc extends Bloc<FJEvent, FJStates> {
  final FJServices joints;

  FJBloc(this.joints) : super(FJInitial()) {
    on<FetchFJ>((event, emit) async {
      emit(FJLoadingState());
      try {
        final fj = await joints.getRestaurants();
        emit(FJSuccess(fj));
      } catch (e) {
        emit(FJError(e.toString()));
      }
    });
  }
}
