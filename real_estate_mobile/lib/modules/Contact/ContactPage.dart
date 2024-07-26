import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './cubit/contact_profile_cubit.dart';
import './cubit/contact_profile_state.dart';
import './repository/contact_profile_repository.dart';

class ContactProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Profile'),
      ),
      body: BlocProvider(
        create: (context) => ContactProfileCubit(ContactProfileRepository())..fetchProfile(),
        child: BlocBuilder<ContactProfileCubit, ContactProfileState>(
          builder: (context, state) {
            if (state is ContactProfileLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is ContactProfileLoaded) {
              final profile = state.profile;
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('User Name: ${profile.userName}', style: TextStyle(fontSize: 20)),
                    SizedBox(height: 10),
                    Text('Compound Name: ${profile.compoundName}', style: TextStyle(fontSize: 20)),
                    SizedBox(height: 10),
                    Text('Unit Name: ${profile.unitName}', style: TextStyle(fontSize: 20)),
                    SizedBox(height: 10),
                    Text('Unit Cost: \$${profile.unitCost}', style: TextStyle(fontSize: 20)),
                    SizedBox(height: 10),
                    Text('Next Installment Due Date: ${profile.nextInstallmentDueDate}', style: TextStyle(fontSize: 20)),
                    SizedBox(height: 10),
                    Text('Next Installment Amount: \$${profile.nextInstallmentAmount}', style: TextStyle(fontSize: 20)),
                  ],
                ),
              );
            } else if (state is ContactProfileError) {
              return Center(child: Text(state.message));
            }
            return Center(child: Text('Press the button to fetch profile'));
          },
        ),
      ),
    );
  }
}
