import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'cubit/qr_code_cubit.dart';
import '../../shared/components/CustomBottomNavBar.dart';
import '../../shared/components/CustomAppBar.dart';
import '../../shared/appcubit/ThemeCubit.dart';

class QRCodePage extends StatefulWidget {
  QRCodePage({Key? key}) : super(key: key);

  @override
  _QRCodePageState createState() => _QRCodePageState();
}

class _QRCodePageState extends State<QRCodePage> {
  final TextEditingController visitorNameController = TextEditingController();
  final TextEditingController dateController = TextEditingController(); // Controller for date
  int _selectedNavIndex = 2; // Set initial index to 2
  String? _generatedQRCode; // Store generated QR code
  String? _visitorName; // Store visitor name

  @override
  void dispose() {
    visitorNameController.dispose();
    dateController.dispose();
    super.dispose();
  }

  void _onNavItemTapped(int index) {
    setState(() {
      _selectedNavIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => QRCodeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, themeState) {
          final isDarkMode = themeState is DarkThemeState;

          return Scaffold(
            body: BlocListener<QRCodeCubit, QRCodeState>(
              listener: (context, state) {
                if (state is QRCodeGenerated) {
                  setState(() {
                    _generatedQRCode = state.qrCode;
                    _visitorName = visitorNameController.text;
                  });
                } else if (state is QRCodeError) {
                  _showErrorDialog(context, state.error);
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTextField(
                      'Visitor Name',
                      visitorNameController,
                      prefixIcon: Icons.person,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      'Date',
                      dateController,
                      isReadOnly: true,
                      prefixIcon: Icons.calendar_today,
                      suffixIcon: IconButton(
                        icon: Icon(Icons.calendar_today, color: Color.fromARGB(255, 165, 128, 91)),
                        onPressed: () => _selectDate(context),
                      ),
                    ),
                    const SizedBox(height: 32),
                    if (_generatedQRCode != null) ...[
                      Center(
                        child: Column(
                          children: [
                            Image.memory(
                              base64Decode(_generatedQRCode!),
                              height: 200,
                              width: 200,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'QR Code Generated!',
                              style: GoogleFonts.lato(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 165, 128, 91),
                              ),
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton.icon(
                              onPressed: () => _shareQRCodeImage(_generatedQRCode!),
                              icon: Icon(Icons.share),
                              label: Text('Share QR Code'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color.fromARGB(255, 165, 128, 91),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        final visitorName = visitorNameController.text;
                        final selectedDate = dateController.text;
                        context.read<QRCodeCubit>().generateQRCode(visitorName);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 165, 128, 91),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        minimumSize: Size(double.infinity, 50),
                      ),
                      child: Text(
                        'Generate QR Code',
                        style: GoogleFonts.lato(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      setState(() {
        dateController.text = '${pickedDate.toLocal()}'.split(' ')[0]; // Format date as yyyy-mm-dd
      });
    }
  }

  Future<void> _shareQRCodeImage(String base64Image) async {
    try {
      // Decode the base64 image
      final bytes = base64Decode(base64Image);

      // Get the temporary directory
      final directory = await getTemporaryDirectory();

      // Create an image file
      final imagePath = '${directory.path}/qrcode.png';
      final imageFile = File(imagePath);

      // Write the image bytes to the file
      await imageFile.writeAsBytes(bytes);

      // Share the image file
      await Share.shareFiles([imagePath], text: 'Here is my QR code');
    } catch (e) {
      print('Error sharing QR code image: $e');
    }
  }

  void _showErrorDialog(BuildContext context, String error) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(error),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    bool isReadOnly = false,
    Widget? suffixIcon,
    IconData? prefixIcon,
    bool isPassword = false,
  }) {
    return TextFormField(
      controller: controller,
      readOnly: isReadOnly,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.lato(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 165, 128, 91),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: Color.fromARGB(255, 165, 128, 91)) : null,
        suffixIcon: suffixIcon,
      ),
      style: GoogleFonts.lato(fontSize: 16),
    );
  }
}
