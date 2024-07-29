class Services {
  final String id;
  final dynamic name;
  final dynamic createdDate;
  final dynamic updatedDate;
  final dynamic deleted;
  final dynamic photo;

  Services({
    required this.id,
    required this.name,
    required this.createdDate,
    required this.updatedDate,
    required this.deleted,
    required this.photo,
  });

  factory Services.fromJson(Map<String, dynamic> json) {
    return Services(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      createdDate: DateTime.parse(json['createdDate']),
      updatedDate: DateTime.parse(json['updatedDate']),
      deleted: json['deleted'] ?? false,
      photo: json['photo'] ?? '',
    );
  }
}
