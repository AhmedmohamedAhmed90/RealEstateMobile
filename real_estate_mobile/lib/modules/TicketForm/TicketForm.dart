import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import "package:file_picker/file_picker.dart";
import 'package:flutter/foundation.dart' show kDebugMode, kIsWeb;
import 'package:real_estate_mobile/models/projectModel.dart';
import '../../models/CustomerModel.dart';
import '../../utils/app_constants.dart';
import '../../models/OwnedPropertyModel.dart';
import '../../shared/appcubit/ThemeCubit.dart';
import '../../shared/components/CustomAppBar.dart';
import '../../shared/components/CustomBottomNavBar.dart';
import 'package:flutter_toastr/flutter_toastr.dart';

import '../Home/cubit/customer_service.dart';

class TicketForm extends StatefulWidget {
  final String serviceId;
  final VoidCallback onSuccess;

  TicketForm({required this.serviceId, required this.onSuccess});

  @override
  _TicketFormState createState() => _TicketFormState();
}

class _TicketFormState extends State<TicketForm> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedPropertyId;
  String? _selectedProjectId;
  String? _description;
  List<OwnedProperty> _properties = [];
  List<XFile> _images = [];
  List<PlatformFile> _webFiles = [];
  final ImagePicker _picker = ImagePicker();
  final storage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    _fetchUserProperties();
  }

  Future<void> _fetchUserProperties() async {
    try {
      final String? userId = await storage.read(key: 'userid');
      if (userId == null) {
        throw Exception('User ID not found in storage');
      }
      
      final response = await http.get(
        Uri.parse('http://127.0.0.1:5001/api/customers/customerdata/$userId'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final ownedProperties = data['customer']['ownedProperties'] as List<dynamic>;

        setState(() {
          _properties = ownedProperties.map<OwnedProperty>((propertyData) {
            return OwnedProperty.fromJson(propertyData);
          }).toList();
        });
      } else {
        throw Exception('Failed to load properties');
      }
    } catch (e) {
      print('Error fetching user properties: $e');
    }
  }

  void _handlePropertySelection(String propertyId , String projectId) {
    setState(() {
      _selectedPropertyId = propertyId;
      _selectedProjectId = projectId;
    });
  }

  Future<void> _pickImage() async {
    if (kIsWeb) {
      final result = await FilePicker.platform.pickFiles(allowMultiple: true);
      if (result != null) {
        setState(() {
          _webFiles.addAll(result.files);
        });
      }
    } else {
      final pickedImages = await _picker.pickMultiImage();
      if (pickedImages != null) {
        setState(() {
          _images.addAll(pickedImages);
        });
      }
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        Customer? customer = CustomerService().customer;

        final String? customerId = customer?.id;
        final String? token = await storage.read(key: 'auth_token'); // Read the token from storage
        if (customerId == null || token == null) {
          throw Exception('customer ID or token not found in storage');
        }

        final dio = Dio();
        dio.options.headers['Authorization'] = '$token'; // Add the token to the headers
        FormData formData = FormData.fromMap({
          
          'customer': customerId,
          'project': _selectedProjectId,
          'apartmentNo': _selectedPropertyId,
          'service': widget.serviceId,
          'description': _description,
          // "type":
          // "category":
          // "subCategory":
          // "assignedTo":
          // "taskOwner":
          // "caller":
          // "salesProject":""
          // "status":"Pending"

        });

        if (kIsWeb) {
          for (var file in _webFiles) {
            formData.files.add(MapEntry(
              'files',
              MultipartFile.fromBytes(file.bytes!, filename: file.name),
            ));
          }
        } else {
          for (var image in _images) {
            formData.files.add(MapEntry(
              'files',
              await MultipartFile.fromFile(image.path),
            ));
          }
        }

        final response = await dio.post('${baseURL}/ticket/mobileAdd', data: formData);
        if (response.statusCode == 200) {
          widget.onSuccess();
          // Navigator.of(context).pop();
          FlutterToastr.show("Ticket Submitted", context);

        } else {
          final String error = response.data['message'] ?? 'An unknown error occurred';
          // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
          FlutterToastr.show(error, context);
        }
      } catch (e) {
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('An error occurred: $e')));
        FlutterToastr.show("error", context);

      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select Property',
                  style: GoogleFonts.lato(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                SizedBox(height: 16),
                if (_properties.isNotEmpty)
                  ..._properties.map((ownedProperty) {
                    final property = ownedProperty.property;
                    final projects = property.projects;

                    return GestureDetector(
                      onTap: () {
                        _handlePropertySelection(property.id, projects[0].id);
                      },
                      child: Card(
                        margin: const EdgeInsets.only(bottom: 16),
                        color: _selectedPropertyId == property.id
                            ? Theme.of(context).primaryColor.withOpacity(0.2)
                            : null,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              // Property Photo
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: SizedBox(
                                  width: 80,
                                  height: 80,
                                  child: property.propertyPhotos.isNotEmpty
                                      ? Image.network(
                                          property.propertyPhotos[0],
                                          fit: BoxFit.cover,
                                        )
                                      : Image.network(
                                          'https://butterflymx.com/wp-content/uploads/2022/07/asset-management-vs-property-management.jpg',
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                              SizedBox(width: 16),
                              // Property and Project Names
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      property.name,
                                      style: GoogleFonts.lato(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: isDarkMode ? Colors.white : Colors.black,
                                      ),
                                    ),
                                    if (projects != null && projects.isNotEmpty)
                                      ...projects.map((project) {
                                        return Text(
                                          project.name,
                                          style: GoogleFonts.lato(
                                            fontSize: 16,
                                            color: isDarkMode ? Colors.white70 : Colors.grey[700],
                                          ),
                                        );
                                      }).toList()
                                    else
                                      Text(
                                        'No projects available.',
                                        style: GoogleFonts.lato(
                                          fontSize: 16,
                                          color: isDarkMode ? Colors.white70 : Colors.grey[700],
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                SizedBox(height: 24),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                  onSaved: (value) => _description = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _pickImage,
                  child: Text('Pick Images'),
                ),
                SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: kIsWeb
                      ? _webFiles.map((file) {
                          return Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.memory(
                                  file.bytes!,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _webFiles.remove(file);
                                    });
                                  },
                                  child: Container(
                                    color: Colors.red,
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }).toList()
                      : _images.map((image) {
                          return Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.file(
                                  File(image.path),
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _images.remove(image);
                                    });
                                  },
                                  child: Container(
                                    color: Colors.red,
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.check),
        label: Text('Submit'),
        onPressed: _submitForm,
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: 1, // Adjust based on your navigation
        onTap: (index) {
          // Handle bottom navigation
        },
      ),
    );
  }
}
