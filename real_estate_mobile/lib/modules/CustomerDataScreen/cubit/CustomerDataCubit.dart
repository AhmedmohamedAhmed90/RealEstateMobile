import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'CustomerDataStates.dart';
import '../CustomerDataRepository/CustomerDataRepository.dart';

class CustomerDataCubit extends Cubit<CustomerDataState> {
  final CustomerDataRepository _repository;

  CustomerDataCubit(this._repository) : super(CustomerDataInitial());

  void loadCustomerData({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String address,
     required String password,
  }) {
    emit(CustomerDataLoaded(
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
      address: address,
      password: password,
    ));
  }

  Future<void> updateCustomerData({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String address,
    required String password,
    required String customerid,

  }) async {
    try {
      // Use the instance method of the repository
      await _repository.updateCustomerData(firstName, lastName, phoneNumber, address,password,customerid);
      emit(CustomerDataLoaded(
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phoneNumber,
        address: address,
        password:password,
      ));
    } catch (e) {
      emit(CustomerDataError('Failed to update customer data'));
    }
  }
}
