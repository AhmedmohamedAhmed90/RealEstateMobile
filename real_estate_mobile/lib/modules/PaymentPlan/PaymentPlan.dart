import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/PaymentPlanModel.dart'; // Import your PaymentPlan model
import '../../shared/appcubit/ThemeCubit.dart';
import '../../shared/components/CustomAppBar.dart'; // Import your custom AppBar

class PaymentPlanPage extends StatelessWidget {
  final PaymentPlan paymentPlan;

  PaymentPlanPage({required this.paymentPlan});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: CustomAppBar(
          title: 'My Properties',
          showBackButton: true, // Enable the back button
          onToggleTheme: () {
            context.read<ThemeCubit>().toggleTheme();
          },
        ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow('Total Amount:', paymentPlan.totalAmount.toString()),
            _buildDetailRow('Number of Payments:', paymentPlan.numberOfPayments.toString()),
            _buildDetailRow('Payment Frequency (Months):', paymentPlan.paymentFrequencyMonths.toString()),
            _buildDetailRow('Payment Amount:', paymentPlan.paymentAmount.toString()),
            _buildDetailRow('Next Payment Date:', _formatDate(paymentPlan.nextPaymentDate)),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey[700]),
          ),
          Text(
            value,
            style: GoogleFonts.lato(fontSize: 18, color: Color.fromARGB(255, 232, 161, 46)), // Custom color
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}"; // Format date as DD/MM/YYYY
  }
}
