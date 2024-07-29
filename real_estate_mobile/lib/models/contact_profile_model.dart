class ContactProfile {
  final String userName;
  final String compoundName;
  final String unitName;
  final double unitCost;
  final DateTime nextInstallmentDueDate;
  final double nextInstallmentAmount;

  ContactProfile({
    required this.userName,
    required this.compoundName,
    required this.unitName,
    required this.unitCost,
    required this.nextInstallmentDueDate,
    required this.nextInstallmentAmount,
  });
}
