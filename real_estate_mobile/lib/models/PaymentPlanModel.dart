class PaymentPlan {
  final double totalAmount;
  final int numberOfPayments;
  final int paymentFrequencyMonths;
  final double paymentAmount;
  final DateTime nextPaymentDate;

  PaymentPlan({
    required this.totalAmount,
    required this.numberOfPayments,
    required this.paymentFrequencyMonths,
    required this.paymentAmount,
    required this.nextPaymentDate,
  });

  factory PaymentPlan.fromJson(Map<String, dynamic> json) {
    return PaymentPlan(
      totalAmount: json['totalAmount'].toDouble(),
      numberOfPayments: json['numberOfPayments'],
      paymentFrequencyMonths: json['paymentFrequencyMonths'],
      paymentAmount: json['paymentAmount'].toDouble(),
      nextPaymentDate: DateTime.parse(json['nextPaymentDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalAmount': totalAmount,
      'numberOfPayments': numberOfPayments,
      'paymentFrequencyMonths': paymentFrequencyMonths,
      'paymentAmount': paymentAmount,
      'nextPaymentDate': nextPaymentDate.toIso8601String(),
    };
  }
}
