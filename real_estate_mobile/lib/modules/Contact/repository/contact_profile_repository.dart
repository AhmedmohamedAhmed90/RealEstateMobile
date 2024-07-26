import '../models/contact_profile_model.dart';

class ContactProfileRepository {
  // Mock data for demonstration
  Future<ContactProfile> fetchContactProfile() async {
    return ContactProfile(
      userName: 'John Doe',
      compoundName: 'Green Valley',
      unitName: 'Unit 101',
      unitCost: 1200.0,
      nextInstallmentDueDate: DateTime.now().add(Duration(days: 30)),
      nextInstallmentAmount: 400.0,
    );
  }
}
