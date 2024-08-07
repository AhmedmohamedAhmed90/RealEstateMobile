import '../../../models/CustomerModel.dart';

class CustomerService {
  static final CustomerService _instance = CustomerService._internal();

  factory CustomerService() {
    return _instance;
  }

  CustomerService._internal();

  Customer? _customer;

  Customer? get customer => _customer;

  void setCustomer(Customer customer) {
    _customer = customer;
  }
}