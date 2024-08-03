import 'package:real_estate_mobile/models/OwnedPropertyModel.dart';
import 'package:real_estate_mobile/models/UserModel.dart';

class Customer {
  final String id;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String email;
  final String address;
  final User user;
  final bool deleted;
  final List<OwnedProperty> ownedProperties;
  final DateTime updatedDate;
  final DateTime createdDate;

  Customer({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
    required this.address,
    required this.user,
    required this.deleted,
    required this.ownedProperties,
    required this.updatedDate,
    required this.createdDate,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['_id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      address: json['address'],
      user: User.fromJson(json['user']),
      deleted: json['deleted'],
      ownedProperties: (json['ownedProperties'] as List)
          .map((opJson) => OwnedProperty.fromJson(opJson))
          .toList(),
      updatedDate: DateTime.parse(json['updatedDate']),
      createdDate: DateTime.parse(json['createdDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'email': email,
      'address': address,
      'user': user.toJson(),
      'deleted': deleted,
      'ownedProperties': ownedProperties.map((op) => op.toJson()).toList(),
      'updatedDate': updatedDate.toIso8601String(),
      'createdDate': createdDate.toIso8601String(),
    };
  }
}
