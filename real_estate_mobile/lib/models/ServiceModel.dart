class Ticket {
  final dynamic apartmentNo;
  final dynamic description;
  final dynamic serviceDetails;
  final dynamic categoryDetails;
  final dynamic subCategoryDetails;
  final dynamic status;
  final String id;

  Ticket({
    required this.id,
    required this.apartmentNo,
    required this.description,
    required this.serviceDetails,
    required this.categoryDetails,
    required this.subCategoryDetails,
    required this.status,
    
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      id:json['_id']??'',
      apartmentNo: json['apartmentNo'],
      description: json['description'],
      serviceDetails: json['serviceDetails']['name'],
      categoryDetails: json['categoryDetails']['name'],
      subCategoryDetails: json['subCategoryDetails']['name'],
      status: json['status'] ?? 'N/A',
      
    );
  }
}
