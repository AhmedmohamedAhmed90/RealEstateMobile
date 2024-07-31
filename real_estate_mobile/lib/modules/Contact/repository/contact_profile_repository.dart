import '../../../models/contact_profile_model.dart';

class ContactProfileRepository {
  // Mock data for demonstration
  Future<ContactProfile> fetchContactProfile() async {
    return ContactProfile(
      userName: 'Ahmed Mamdouh',
      compoundName: 'Regents Square',
      unitName: 'Unit 101',
      unitCost: 1200.0,
      nextInstallmentDueDate: DateTime.now().add(Duration(days: 30)),
      nextInstallmentAmount: 400.0,
      avatarUrl: 'https://st3.depositphotos.com/15648834/17930/v/450/depositphotos_179308454-stock-illustration-unknown-person-silhouette-glasses-profile.jpg', // Added dummy avatar URL
    );
  }
}
