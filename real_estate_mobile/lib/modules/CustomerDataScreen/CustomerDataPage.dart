import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:real_estate_mobile/modules/CustomerDataScreen/cubit/CustomerDataCubit.dart';
import '../../shared/components/CustomAppBar.dart'; 

class CustomerDataPage extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String phone;
  final String address;
  final String customerid;

  CustomerDataPage({
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.address,
    required this.customerid,
  });

  @override
  _CustomerDataPageState createState() => _CustomerDataPageState();
}

class _CustomerDataPageState extends State<CustomerDataPage> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.firstName);
    _lastNameController = TextEditingController(text: widget.lastName);
    _phoneController = TextEditingController(text: widget.phone);
    _addressController = TextEditingController(text: widget.address);
    _passwordController = TextEditingController(); 
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'My Info',
        onToggleTheme: () {
          // Implement the theme toggle logic if needed
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildTextField('First Name', _firstNameController),
            SizedBox(height: 16),
            _buildTextField('Last Name', _lastNameController),
            SizedBox(height: 16),
            _buildTextField('Phone', _phoneController, keyboardType: TextInputType.phone),
            SizedBox(height: 16),
            _buildTextField('Address', _addressController),
            SizedBox(height: 16),
            _buildTextField('Password', _passwordController, isPassword: true),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: _onUpdatePressed,
              child: Text(
                'Update My Data',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 232, 161, 46),
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onUpdatePressed() {
   
    String updatedFirstName = _firstNameController.text;
    String updatedLastName = _lastNameController.text;
    String updatedPhone = _phoneController.text;
    String updatedAddress = _addressController.text;
    String updatedPassword = _passwordController.text;

    
    context.read<CustomerDataCubit>().updateCustomerData(
      firstName: updatedFirstName,
      lastName: updatedLastName,
      phoneNumber: updatedPhone,
      address: updatedAddress,
      password: updatedPassword,
      customerid: widget.customerid,
    );

    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Customer data updated successfully')),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text, bool isPassword = false}) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.lato(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      style: GoogleFonts.lato(fontSize: 16),
    );
  }
}

