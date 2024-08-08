class Ticket {
  final String id;
  final String type;
  final String customer;
  final String project;
  final String apartmentNo;
  final String service;
  final String category;
  final String status;

  Ticket({
    required this.id,
    required this.type,
    required this.customer,
    required this.project,
    required this.apartmentNo,
    required this.service,
    required this.category,
    required this.status,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      id: json['_id'],
      type: json['type'],
      customer: json['customer'],
      project: json['project'],
      apartmentNo: json['apartmentNo'],
      service: json['service'],
      category: json['category'],
      status: json['status'],
    );
  }
}