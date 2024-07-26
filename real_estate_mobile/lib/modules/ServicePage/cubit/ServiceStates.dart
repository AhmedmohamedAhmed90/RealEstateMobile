part of 'ServiceCubit.dart';

//@immutable
abstract class ServiceState {}

class ServiceInitial extends ServiceState {}

class ServiceLoading extends ServiceState {}

class ServiceSuccess extends ServiceState {
  final List<dynamic> tickets;

  ServiceSuccess({required this.tickets});
}

class ServiceFailure extends ServiceState {
  final String errorMessage;

  ServiceFailure({required this.errorMessage});
}
