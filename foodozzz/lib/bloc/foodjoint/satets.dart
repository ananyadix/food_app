import 'model.dart';

abstract class FJStates {}

class FJInitial extends FJStates {}

class FJLoadingState extends FJStates {}

class FJSuccess extends FJStates {
  final List<FJModel> fj;
  FJSuccess(this.fj);
}

class FJError extends FJStates {
  final String message;
  FJError(this.message);
}
