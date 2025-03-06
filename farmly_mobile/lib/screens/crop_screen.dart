import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../entities/crop/crop.entity.dart';
import '../forms/crop_form.dart';
import '../repositories/crop_repository.dart';
import '../services/auth_service.dart';

class CropScreen extends StatefulWidget {
  @override
  _CropScreenState createState() => _CropScreenState();
}

class _CropScreenState extends State<CropScreen> {
  List<CropEntity> cropsList = [];

  @override
  void initState() {
    super.initState();
    loadFarmerData();
  }

  void loadFarmerData() async {
    var repo = Provider.of<CropRepository>(context, listen: false);
    List<CropEntity> data = await repo.getAllCrops();
    setState(() {
      cropsList = data;
    });
  }

  void _openCropForm() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CropFormScreen()),
    ).then((value) {
      // Reload data after form submission
      loadFarmerData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Crops Management"),
          actions: [
            Consumer<AuthService>(
              builder: (context, authService, child) {
                return Visibility(
                  visible: authService.isAdmin, // Use auth state to determine visibility
                  child: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: _openCropForm,
                    tooltip: "Add new crop data",
                  ),
                );
              },
            )
          ],
        ),
        body:ListView.builder(
          itemCount: cropsList.length,
          itemBuilder: (context, index) {
            CropEntity data = cropsList[index];
            return Card(
              margin: EdgeInsets.all(8),
              child: ListTile(title: Text(data.name!)),
            );
          },
        ),
    );
  }
}