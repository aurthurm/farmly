import 'package:farmly_mobile/entities/farmdata/farmdata.entity.dart';
import 'package:farmly_mobile/entities/farmtype/farmtype.entity.dart';
import 'package:farmly_mobile/entities/crop/crop.entity.dart';
import 'package:farmly_mobile/repositories/crop_repository.dart';
import 'package:farmly_mobile/repositories/farm_type_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../repositories/farmer_repository.dart';

class ClerkFormScreen extends StatefulWidget {
  @override
  _ClerkFormScreenState createState() => _ClerkFormScreenState();
}

class _ClerkFormScreenState extends State<ClerkFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _farmerNameController = TextEditingController();
  final _nationalIdController = TextEditingController();
  final _locationController = TextEditingController();

  String? _selectedFarmTypeId;
  String? _selectedCropId;
  List<FarmTypeEntity> _farmTypes = [];
  List<CropEntity> _crops = [];

  bool _isSubmitting = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    setState(() {
      _isLoading = true;
    });

    // Load farm types
    final farmTypeRepo = Provider.of<FarmTypeRepository>(context, listen: false);
    final farmTypes = await farmTypeRepo.getAllFarmtypes();

    // Load crops
    final cropRepo = Provider.of<CropRepository>(context, listen: false);
    final crops = await cropRepo.getAllCrops();

    setState(() {
      _farmTypes = farmTypes;
      _crops = crops;
      _isLoading = false;
    });
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate() &&
        _selectedFarmTypeId != null &&
        _selectedCropId != null) {
      setState(() {
        _isSubmitting = true;
      });

      FarmDataEntity data = FarmDataEntity(
        farmerName: _farmerNameController.text,
        nationalId: _nationalIdController.text,
        farmTypeId: _selectedFarmTypeId,
        cropId: _selectedCropId,
        location: _locationController.text,
      );

      await Provider.of<FarmerRepository>(context, listen: false)
          .addFarmData(data);

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
      appBar: AppBar(title: Text("Clerk Data Collection")),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _farmerNameController,
                  decoration: InputDecoration(labelText: "Farmer's Name"),
                  validator: (value) =>
                  value!.isEmpty ? "Required" : null,
                ),
                TextFormField(
                  controller: _nationalIdController,
                  decoration: InputDecoration(labelText: "National ID"),
                  validator: (value) =>
                  value!.isEmpty ? "Required" : null,
                ),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(labelText: "Farm Type"),
                  value: _selectedFarmTypeId,
                  items: _farmTypes.map((farmType) => DropdownMenuItem(
                    child: Text(farmType.name!),
                    value: farmType.id,
                  )).toList(),
                  onChanged: (val) => setState(() => _selectedFarmTypeId = val),
                  validator: (value) =>
                  value == null ? "Select Farm Type" : null,
                ),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(labelText: "Crop"),
                  value: _selectedCropId,
                  items: _crops.map((crop) => DropdownMenuItem(
                    child: Text(crop.name!),
                    value: crop.id,
                  )).toList(),
                  onChanged: (val) => setState(() => _selectedCropId = val),
                  validator: (value) =>
                  value == null ? "Select Crop" : null,
                ),
                TextFormField(
                  controller: _locationController,
                  decoration: InputDecoration(labelText: "Location"),
                  validator: (value) =>
                  value!.isEmpty ? "Required" : null,
                ),
                SizedBox(height: 20),
                _isSubmitting
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                    onPressed: _submitForm,
                    child: Text("Submit")
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}