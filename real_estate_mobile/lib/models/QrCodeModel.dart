class QRCode {
  final String code;
  final DateTime createdAt;
  final bool used;

  QRCode({
    required this.code,
    required this.createdAt,
    required this.used,
  });

  factory QRCode.fromJson(Map<String, dynamic> json) {
    return QRCode(
      code: json['code'],
      createdAt: DateTime.parse(json['createdAt']),
      used: json['used'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'createdAt': createdAt.toIso8601String(),
      'used': used,
    };
  }
}
