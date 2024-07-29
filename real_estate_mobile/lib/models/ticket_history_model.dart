class TicketHistory {
  final String text;
  final DateTime createdDate;
  final String createdBy;
  final String status;
  final String id;

  TicketHistory({
    required this.text,
    required this.createdDate,
    required this.createdBy,
    required this.status,
    required this.id,
  });

  factory TicketHistory.fromJson(Map<String, dynamic> json) {
    return TicketHistory(
      text: json['text'],
      createdDate: DateTime.parse(json['createdDate']),
      createdBy: json['createdBy']['_id'],
      status: json['status'],
      id: json['_id'],
    );
  }
}
