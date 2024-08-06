// // import 'dart:convert';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:google_fonts/google_fonts.dart';
// // import 'cubit/qr_code_cubit.dart';

// // class QRCodePage extends StatelessWidget {
// //   QRCodePage({Key? key}) : super(key: key);

// //   final TextEditingController visitorNameController = TextEditingController();

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Generate QR Code', style: TextStyle(fontWeight: FontWeight.bold , color: Color.fromARGB(255, 232, 161, 46),)),
// //         backgroundColor: Color.fromARGB(165, 0, 0, 0),
// //         elevation: 0,
// //         shape: RoundedRectangleBorder(
// //           borderRadius: BorderRadius.vertical(
// //             bottom: Radius.circular(30),
// //           ),
// //         ),
// //       ),
// //       body: BlocListener<QRCodeCubit, QRCodeState>(
// //         listener: (context, state) {
// //           if (state is QRCodeError) {
// //             ScaffoldMessenger.of(context).showSnackBar(
// //               SnackBar(content: Text(state.error)),
// //             );
// //           }
// //         },
// //         child: Padding(
// //           padding: const EdgeInsets.all(16.0),
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               Text(
// //                 'Enter visitor name to generate QR code:',
// //                 style: GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF004F8B)),
// //               ),
// //               const SizedBox(height: 10),
// //               TextField(
// //                 controller: visitorNameController,
// //                 decoration: InputDecoration(
// //                   labelText: 'Visitor Name',
// //                   labelStyle: GoogleFonts.lato(color: Color(0xFF004F8B)),
// //                   enabledBorder: OutlineInputBorder(
// //                     borderRadius: BorderRadius.circular(10),
// //                     borderSide: BorderSide(color: Color(0xFF004F8B)),
// //                   ),
// //                   focusedBorder: OutlineInputBorder(
// //                     borderRadius: BorderRadius.circular(10),
// //                     borderSide: BorderSide(color: Color(0xFF004F8B)),
// //                   ),
// //                 ),
// //               ),
// //               const SizedBox(height: 20),
// //               Center(
// //                 child: ElevatedButton(
// //                   onPressed: () {
// //                     final visitorName = visitorNameController.text;
// //                     context.read<QRCodeCubit>().generateQRCode(visitorName);
// //                   },
// //                   style: ElevatedButton.styleFrom(
// //                     backgroundColor: Color(0xFF004F8B),
// //                     shape: RoundedRectangleBorder(
// //                       borderRadius: BorderRadius.circular(10),
// //                     ),
// //                     padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
// //                   ),
// //                   child: Text(
// //                     'Generate QR Code',
// //                     style: GoogleFonts.lato(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
// //                   ),
// //                 ),
// //               ),
// //               const SizedBox(height: 20),
// //               BlocBuilder<QRCodeCubit, QRCodeState>(
// //                 builder: (context, state) {
// //                   if (state is QRCodeLoading) {
// //                     return const Center(child: CircularProgressIndicator());
// //                   } else if (state is QRCodeGenerated) {
// //                     return Center(
// //                       child: Column(
// //                         children: [
// //                           Image.memory(
// //                             base64Decode(state.qrCode.split(',')[1]),
// //                             height: 200,
// //                             width: 200,
// //                           ),
// //                           const SizedBox(height: 10),
// //                           Text(
// //                             'QR Code Generated!',
// //                             style: GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF004F8B)),
// //                           ),
// //                         ],
// //                       ),
// //                     );
// //                   } else {
// //                     return Container();
// //                   }
// //                 },
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'cubit/qr_code_cubit.dart';

// class QRCodePage extends StatelessWidget {
//   QRCodePage({Key? key}) : super(key: key);

//   final TextEditingController visitorNameController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => QRCodeCubit(),
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text(
//             'Generate QR Code',
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               color: Color.fromARGB(255, 232, 161, 46),
//             ),
//           ),
//           backgroundColor: Color.fromARGB(165, 0, 0, 0),
//         ),
//         body: BlocListener<QRCodeCubit, QRCodeState>(
//           listener: (context, state) {
//             if (state is QRCodeGenerated) {
//               _showQRCodeDialog(context, state.qrCode);
//             } else if (state is QRCodeError) {
//               _showErrorDialog(context, state.error);
//             }
//           },
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 TextField(
//                   controller: visitorNameController,
//                   decoration: const InputDecoration(labelText: 'Visitor Name'),
//                 ),
//                 const SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: () {
//                     final visitorName = visitorNameController.text;
//                     context.read<QRCodeCubit>().generateQRCode(visitorName);
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Color.fromARGB(255, 232, 161, 46),
//                   ),
//                   child: const Text('Generate QR Code'),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   void _showQRCodeDialog(BuildContext context, String qrCode) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Your QR Code'),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Image.memory(
//               base64Decode(qrCode),
//               fit: BoxFit.contain,
//             ),
//             const SizedBox(height: 10),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: const Text('Close'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _showErrorDialog(BuildContext context, String error) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Error'),
//         content: Text(error),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             child: const Text('OK'),
//           ),
//         ],
//       ),
//     );
//   }
// }



import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Contact/ContactPage.dart';
import '../Home/home_page.dart';
import '../ServicesScreen/ServicesScreen.dart';
import 'cubit/qr_code_cubit.dart';
import '../../shared/components/CustomBottomNavBar.dart'; // Import CustomBottomNavBar
import '../../shared/components/CustomAppBar.dart'; // Import CustomAppBar
import '../../shared/appcubit/ThemeCubit.dart'; // Import ThemeCubit
import 'package:share_plus/share_plus.dart';

class QRCodePage extends StatefulWidget {
  QRCodePage({Key? key}) : super(key: key);

  @override
  _QRCodePageState createState() => _QRCodePageState();
}

class _QRCodePageState extends State<QRCodePage> {
  final TextEditingController visitorNameController = TextEditingController();
  final TextEditingController dateController = TextEditingController(); // Controller for date

  @override
  void dispose() {
    visitorNameController.dispose();
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QRCodeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, themeState) {
          final isDarkMode = themeState is DarkThemeState;

          return Scaffold(
            appBar: CustomAppBar(
              title: 'Generate QR Code',
              onToggleTheme: () {
                context.read<ThemeCubit>().toggleTheme();
              },
            ),
            body: BlocListener<QRCodeCubit, QRCodeState>(
              listener: (context, state) {
                if (state is QRCodeGenerated) {
                  _showQRCodeDialog(context, state.qrCode);
                } else if (state is QRCodeError) {
                  _showErrorDialog(context, state.error);
                }
              },
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTextField('Visitor Name', visitorNameController),
                        const SizedBox(height: 16),
                        _buildTextField(
                          'Date',
                          dateController,
                          isReadOnly: true,
                          suffixIcon: IconButton(
                            icon: Icon(Icons.calendar_today, color: Color.fromARGB(255, 232, 161, 46)),
                            onPressed: () => _selectDate(context),
                          ),
                        ),
                        const SizedBox(height: 32),
                        BlocBuilder<QRCodeCubit, QRCodeState>(
                          builder: (context, state) {
                            if (state is QRCodeLoading) {
                              return const Center(child: CircularProgressIndicator());
                            } else if (state is QRCodeGenerated) {
                              return Center(
                                child: Column(
                                  children: [
                                    Image.memory(
                                      base64Decode(state.qrCode),
                                      height: 200,
                                      width: 200,
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      'QR Code Generated!',
                                      style: GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 232, 161, 46)),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              return Container();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ElevatedButton(
                        onPressed: () {
                          final visitorName = visitorNameController.text;
                          final selectedDate = dateController.text;
                          context.read<QRCodeCubit>().generateQRCode(visitorName);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[600],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          minimumSize: Size(double.infinity, 50),
                        ),
                        child: Text(
                          'Generate QR Code',
                          style: GoogleFonts.lato(fontSize: 16, color: Color.fromARGB(255, 232, 161, 46), fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: CustomBottomNavBar(
              selectedIndex: 2, // Set initial index to 2
              onTap: (index) {
                final pages = [
                  HomePage(),
                  ServicesScreen(),
                  QRCodePage(),
                  ContactProfilePage(),
                ];

                if (index >= 0 && index < pages.length) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => pages[index]),
                  );
                }
              },
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

    if (pickedDate != null && pickedDate != DateTime.now()) {
      setState(() {
        dateController.text = '${pickedDate.toLocal()}'.split(' ')[0]; // Format date as yyyy-mm-dd
      });
    }
  }

  // void _showQRCodeDialog(BuildContext context, String qrCode) {
  //   showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       title: const Text('Your QR Code'),
  //       content: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           Image.memory(
  //             base64Decode(qrCode),
  //             fit: BoxFit.contain,
  //           ),
  //           const SizedBox(height: 10),
  //           ElevatedButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //             child: const Text('Close'),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

 void _showQRCodeDialog(BuildContext context, String qrCode) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Your QR Code'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.memory(
            base64Decode(qrCode),
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Close'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => QRCodeCubit.shareQRCode(qrCode),
            child: const Text('Share QR Code'),
          ),
        ],
      ),
    ),
  );
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

  

  Widget _buildTextField(String label, TextEditingController controller,
      {bool isReadOnly = false, Widget? suffixIcon, bool isPassword = false}) {
    return TextFormField(
      controller: controller,
      readOnly: isReadOnly,
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
        suffixIcon: suffixIcon,
      ),
      style: GoogleFonts.lato(fontSize: 16),
    );
  }
}

