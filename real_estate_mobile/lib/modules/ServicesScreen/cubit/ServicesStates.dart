part of 'ServicesCubit.dart';

//@immutable
abstract class ServicesState {}

class ServicesInitial extends ServicesState {}

class ServicesLoading extends ServicesState {}

class ServicesSuccess extends ServicesState {
  final List<Services> services;

  ServicesSuccess({required this.services});
}

class ServicesFailure extends ServicesState {
  final String errorMessage;

  ServicesFailure({required this.errorMessage});
}
