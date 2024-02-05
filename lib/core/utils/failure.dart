import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  Failure([List properties = const <dynamic>[]]) : super();
}

class ServerFailure extends Failure with EquatableMixin {
  final String message;
  ServerFailure({this.message = "Something bad happedned!"}) : super([message]);

  @override
  List<Object?> get props => [message];
}
