import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate_mobile/models/OwnedPropertyModel.dart';


class MyPropertiesCubit extends Cubit<List<OwnedProperty>> {
  MyPropertiesCubit() : super([]);

  void loadProperties(List<OwnedProperty> properties) {
    emit(properties);
  }
}
