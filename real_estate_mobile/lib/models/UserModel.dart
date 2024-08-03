class User {
  final String id;
  final String username;
  final String password;
  final String role;
  final int emailsent;
  final int textsent;
  final int outboundcall;
  final String phoneNumber;
  final String firstName;
  final String lastName;
  final List<String> roles;
  final DateTime createdDate;
  final bool deleted;
  final List<String> qrCodes;
  final DateTime updatedDate;

  User({
    required this.id,
    required this.username,
    required this.password,
    required this.role,
    required this.emailsent,
    required this.textsent,
    required this.outboundcall,
    required this.phoneNumber,
    required this.firstName,
    required this.lastName,
    required this.roles,
    required this.createdDate,
    required this.deleted,
    required this.qrCodes,
    required this.updatedDate,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      username: json['username'],
      password: json['password'],
      role: json['role'],
      emailsent: json['emailsent'],
      textsent: json['textsent'],
      outboundcall: json['outboundcall'],
      phoneNumber: json['phoneNumber'].toString(),
      firstName: json['firstName'],
      lastName: json['lastName'],
      roles: List<String>.from(json['roles']),
      createdDate: DateTime.parse(json['createdDate']),
      deleted: json['deleted'],
      qrCodes: List<String>.from(json['qrCodes']),
      updatedDate: DateTime.parse(json['updatedDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'username': username,
      'password': password,
      'role': role,
      'emailsent': emailsent,
      'textsent': textsent,
      'outboundcall': outboundcall,
      'phoneNumber': phoneNumber,
      'firstName': firstName,
      'lastName': lastName,
      'roles': roles,
      'createdDate': createdDate.toIso8601String(),
      'deleted': deleted,
      'qrCodes': qrCodes,
      'updatedDate': updatedDate.toIso8601String(),
    };
  }
}
