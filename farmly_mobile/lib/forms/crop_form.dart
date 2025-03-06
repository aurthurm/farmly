import 'package:farmly_mobile/entities/farmdata/farmdata.entity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../entities/crop/crop.entity.dart';
import '../repositories/crop_repository.dart';
import '../repositories/farmer_repository.dart';

class CropFormScreen extends StatefulWidget {
  @override
  _CropFormScreenState createState() => _CropFormScreenState();
}

class _CropFormScreenState extends State<CropFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _farmerNameController = TextEditingController();

  bool _isSubmitting = false;

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSubmitting = true;
      });

      CropEntity data = CropEntity(
        name: _farmerNameController.text,
      );

      await Provider.of<CropRepository>(context, listen: false)
          .addCrop(data);

      setState(() {
        _isSubmitting = false;
      });

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Data submitted")));
      _formKey.currentState!.reset();

      Navigator.pop(context, 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Crop Form")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _farmerNameController,
                  decoration: InputDecoration(labelText: "Crop's Name"),
                  validator: (value) =>
                  value!.isEmpty ? "Required" : null,
                ),
                SizedBox(height: 20),
                _isSubmitting
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                    onPressed: _submitForm, child: Text("Submit"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
