import 'package:real_estate_mobile/models/PaymentPlanModel.dart';
import 'package:real_estate_mobile/models/PropertyModel.dart';

class OwnedProperty {
  final PaymentPlan paymentPlan;
  final Property property;
  final String id;

  OwnedProperty({
    required this.paymentPlan,
    required this.property,
    required this.id,
  });

  factory OwnedProperty.fromJson(Map<String, dynamic> json) {
    return OwnedProperty(
      paymentPlan: PaymentPlan.fromJson(json['paymentPlan']),
      property: Property.fromJson(json['property']),
      id: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'paymentPlan': paymentPlan.toJson(),
      'property': property.toJson(),
      '_id': id,
    };
  }
}
