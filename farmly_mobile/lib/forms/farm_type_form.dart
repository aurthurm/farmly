import 'package:farmly_mobile/entities/farmtype/farmtype.entity.dart';
import 'package:farmly_mobile/repositories/farm_type_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FarmTypeFormScreen extends StatefulWidget {
  @override
  _FarmTypeFormScreenState createState() => _FarmTypeFormScreenState();
}

class _FarmTypeFormScreenState extends State<FarmTypeFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _farmerNameController = TextEditingController();

  bool _isSubmitting = false;

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSubmitting = true;
      });

      FarmTypeEntity data = FarmTypeEntity(
        name: _farmerNameController.text,
      );

      await Provider.of<FarmTypeRepository>(context, listen: false)
          .addFarmtype(data);

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
      appBar: AppBar(title: Text("Farm Type Form")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _farmerNameController,
                  decoration: InputDecoration(labelText: "Farm Type"),
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
