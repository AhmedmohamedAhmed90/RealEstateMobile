import 'package:real_estate_mobile/models/ProjectModel.dart';

class Property {
  final String id;
  final String name;
  final List<String> propertyPhotos;
  final List<String> virtualToursOrVideos;
  final List<String> floorPlans;
  final List<String> propertyDocuments;
  final bool deleted;
  final List<Project> projects; // Update to List<Project>

  Property({
    required this.id,
    required this.name,
    required this.propertyPhotos,
    required this.virtualToursOrVideos,
    required this.floorPlans,
    required this.propertyDocuments,
    required this.deleted,
    required this.projects,
  });

  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(
      id: json['_id'],
      name: json['name'],
      propertyPhotos: List<String>.from(json['propertyPhotos']),
      virtualToursOrVideos: List<String>.from(json['virtualToursOrVideos']),
      floorPlans: List<String>.from(json['floorPlans']),
      propertyDocuments: List<String>.from(json['propertyDocuments']),
      deleted: json['deleted'],
      projects: (json['projects'] as List) // Map to List<Project>
          .map((projectJson) => Project.fromJson(projectJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'propertyPhotos': propertyPhotos,
      'virtualToursOrVideos': virtualToursOrVideos,
      'floorPlans': floorPlans,
      'propertyDocuments': propertyDocuments,
      'deleted': deleted,
      'projects': projects.map((project) => project.toJson()).toList(), // Convert List<Project> to List<Map<String, dynamic>>
    };
  }
}
