import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TicketForm extends StatefulWidget {
  final String serviceId;
  final VoidCallback onSuccess;

  TicketForm({required this.serviceId, required this.onSuccess});

  @override
  _TicketFormState createState() => _TicketFormState();
}

class _TicketFormState extends State<TicketForm> {
  final _formKey = GlobalKey<FormState>();
  String? _type;
  String? _projectId;
  String? _apartmentNo;
  String? _description;
  List<Map<String, dynamic>> _projects = [];
  List<Map<String, dynamic>> _properties = [];
  final storage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    _fetchUserProperties();
  }

  Future<void> _fetchUserProperties() async {
    try {
      final String? ownedPropertiesJson = await storage.read(key: 'owned_properties');
      if (ownedPropertiesJson != null) {
        final List<dynamic> ownedProperties = jsonDecode(ownedPropertiesJson);
        final Map<String, List<Map<String, dynamic>>> projectsMap = {};
        for (var propertyData in ownedProperties) {
          var property = propertyData['property'];
          var project = property['projects'][0];
          if (!projectsMap.containsKey(project['_id'])) {
            projectsMap[project['_id']] = [];
          }
          projectsMap[project['_id']]!.add(property);
        }
        setState(() {
          _projects = projectsMap.entries.map((entry) {
            return {
              '_id': entry.key,
              'name': entry.value.first['projects'][0]['name'],
              'properties': entry.value,
            };
          }).toList();
        });
      }
    } catch (e) {
      print('Error fetching owned properties: $e');
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        final String? userId = await storage.read(key: 'user_id');
        if (userId == null) {
          throw Exception('User ID not found in storage');
        }

        final response = await http.post(
          Uri.parse('http://127.0.0.1:5001/api/ticket/add'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({
            'type': _type,
            'customer': userId,
            'project': _projectId,
            'apartmentNo': _apartmentNo,
            'service': widget.serviceId,
            'description': _description,
          }),
        );

        if (response.statusCode == 200) {
          widget.onSuccess();
          Navigator.of(context).pop();
        } else {
          final Map<String, dynamic> responseData = jsonDecode(response.body);
          final String error = responseData['message'] ?? 'An unknown error occurred';
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('An error occurred: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Create Ticket'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Type'),
                onSaved: (value) => _type = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a type';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Project'),
                value: _projectId,
                items: _projects.map((project) {
                  return DropdownMenuItem<String>(
                    value: project['_id'],
                    child: Text(project['name']),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _projectId = value;
                    _properties = _projects.firstWhere((project) => project['_id'] == value)['properties'];
                    _apartmentNo = null;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a project';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Apartment No'),
                value: _apartmentNo,
                items: _properties.map((property) {
                  return DropdownMenuItem<String>(
                    value: property['_id'],
                    child: Text(property['name']),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _apartmentNo = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select an apartment number';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                onSaved: (value) => _description = value,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          child: Text('Cancel'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        ElevatedButton(
          child: Text('Submit'),
          onPressed: _submitForm,
        ),
      ],
    );
  }
}
