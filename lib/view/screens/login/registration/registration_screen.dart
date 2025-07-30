import 'package:flutter/material.dart';

class RegistrationScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text("Register", style: TextStyle(color: Colors.black)),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField(label: "Full Name"),
              _buildTextField(label: "Email Address", keyboard: TextInputType.emailAddress),
              _buildTextField(label: "Phone Number", keyboard: TextInputType.phone),
              _buildTextField(label: "Password", obscureText: true),
              _buildTextField(label: "Confirm Password", obscureText: true),
              _buildDropdownField(label: "Designation", items: ['Admin', 'Manager', 'Sales Executive']),
              _buildDropdownField(label: "Department", items: ['Marketing', 'Sales', 'Support']),
              _buildTextField(label: "Location"),
              SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFF3B30), // red from dashboard
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Submit logic
                  }
                },
                child: Text("Register", style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({required String label, TextInputType keyboard = TextInputType.text, bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        keyboardType: keyboard,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        validator: (value) => value == null || value.isEmpty ? 'Please enter $label' : null,
      ),
    );
  }

  Widget _buildDropdownField({required String label, required List<String> items}) {
    String? selectedValue;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: DropdownButtonFormField<String>(
        value: selectedValue,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
        onChanged: (val) => selectedValue = val,
        validator: (value) => value == null ? 'Please select $label' : null,
      ),
    );
  }
}
