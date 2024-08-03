class Project {
  final String id;
  final String name;
  final String description;
  final List<String> properties;
  final DateTime startDate;
  final DateTime endDate;
  final String status;
  final String createBy;
  final bool deleted;
  final DateTime createdDate;
  final DateTime updatedDate;
  final String? projectPhoto;

  Project({
    required this.id,
    required this.name,
    required this.description,
    required this.properties,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.createBy,
    required this.deleted,
    required this.createdDate,
    required this.updatedDate,
    this.projectPhoto,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      properties: List<String>.from(json['properties']),
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      status: json['status'],
      createBy: json['createBy'],
      deleted: json['deleted'],
      createdDate: DateTime.parse(json['createdDate']),
      updatedDate: DateTime.parse(json['updatedDate']),
      projectPhoto: json['projectPhoto'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'description': description,
      'properties': properties,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'status': status,
      'createBy': createBy,
      'deleted': deleted,
      'createdDate': createdDate.toIso8601String(),
      'updatedDate': updatedDate.toIso8601String(),
      'projectPhoto': projectPhoto,
    };
  }
}
