import 'package:farmly_mobile/entities/crop/crop.entity.dart';
import 'package:farmly_mobile/entities/farmtype/farmtype.entity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';

class AdminConfigScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Two tabs: Farm Types and Crops
      child: Scaffold(
        appBar: AppBar(
          title: Text("Admin Configuration"),
          bottom: TabBar(
            tabs: [
              Tab(text: "Farm Types"),
              Tab(text: "Crops"),
            ],
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                Provider.of<AuthService>(context, listen: false).logout();
                Navigator.pushReplacementNamed(context, '/login');
              },
            )
          ],
        ),
        body: TabBarView(
          children: [
            FarmTypeTab(),
            CropTab(),
          ],
        ),
      ),
    );
  }
}

class FarmTypeTab extends StatefulWidget {
  @override
  _FarmTypeTabState createState() => _FarmTypeTabState();
}

class _FarmTypeTabState extends State<FarmTypeTab> {
  final _formKey = GlobalKey<FormState>();
  final _farmTypeController = TextEditingController();
  bool _isSubmitting = false;
  List<FarmTypeEntity> _farmTypes = [];

  @override
  void initState() {
    super.initState();
    _loadFarmTypes();
  }

  Future<void> _loadFarmTypes() async {
    // Replace with real repository call
    // For now, simulate delay and dummy data.
    await Future.delayed(Duration(milliseconds: 500));
    setState(() {
      _farmTypes = [
        FarmTypeEntity(id: "1", name: "Irrigated"),
        FarmTypeEntity(id: "2", name: "Rainfed"),
      ];
    });
  }

  Future<void> _submitFarmType() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _isSubmitting = true;
    });
    // Create new FarmType using the input
    FarmTypeEntity newType = FarmTypeEntity(name: _farmTypeController.text);
    // Save using repository - replace with actual call:
    // await Provider.of<FarmTypeRepository>(context, listen: false).addFarmType(newType);
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      _farmTypes.add(newType);
      _farmTypeController.clear();
      _isSubmitting = false;
    });
  }

  @override
  void dispose() {
    _farmTypeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Form(
            key: _formKey,
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _farmTypeController,
                    decoration:
                    InputDecoration(labelText: "Enter Farm Type Name"),
                    validator: (value) =>
                    value == null || value.isEmpty ? "Required" : null,
                  ),
                ),
                SizedBox(width: 8),
                _isSubmitting
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                  onPressed: _submitFarmType,
                  child: Text("Add"),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: _farmTypes.isEmpty
                ? Center(child: Text("No farm types added yet."))
                : ListView.builder(
              itemCount: _farmTypes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_farmTypes[index].name!),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CropTab extends StatefulWidget {
  @override
  _CropTabState createState() => _CropTabState();
}

class _CropTabState extends State<CropTab> {
  final _formKey = GlobalKey<FormState>();
  final _cropController = TextEditingController();
  bool _isSubmitting = false;
  List<CropEntity> _crops = [];

  @override
  void initState() {
    super.initState();
    _loadCrops();
  }

  Future<void> _loadCrops() async {
    // Replace with actual repository call.
    await Future.delayed(Duration(milliseconds: 500));
    setState(() {
      _crops = [
        CropEntity(id: "1", name: "Wheat"),
        CropEntity(id: "2", name: "Corn"),
      ];
    });
  }

  Future<void> _submitCrop() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _isSubmitting = true;
    });
    CropEntity newCrop = CropEntity(name: _cropController.text);
    // Save using repository - replace with actual call:
    // await Provider.of<CropRepository>(context, listen: false).addCrop(newCrop);
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      _crops.add(newCrop);
      _cropController.clear();
      _isSubmitting = false;
    });
  }

  @override
  void dispose() {
    _cropController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Form(
            key: _formKey,
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _cropController,
                    decoration: InputDecoration(labelText: "Enter Crop Name"),
                    validator: (value) =>
                    value == null || value.isEmpty ? "Required" : null,
                  ),
                ),
                SizedBox(width: 8),
                _isSubmitting
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                  onPressed: _submitCrop,
                  child: Text("Add"),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: _crops.isEmpty
                ? Center(child: Text("No crops added yet."))
                : ListView.builder(
              itemCount: _crops.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_crops[index].name!),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
