import 'package:farmly_mobile/entities/farmtype/farmtype.entity.dart';
import 'package:farmly_mobile/forms/farm_type_form.dart';
import 'package:farmly_mobile/repositories/farm_type_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/auth_service.dart';

class FarmTypeScreen extends StatefulWidget {
  @override
  _FarmTypeScreenState createState() => _FarmTypeScreenState();
}

class _FarmTypeScreenState extends State<FarmTypeScreen> {
  List<FarmTypeEntity> FarmTypeEntitysList = [];


  @override
  void initState() {
    super.initState();
    loadFarmerData();
  }

  void loadFarmerData() async {
    var repo = Provider.of<FarmTypeRepository>(context, listen: false);
    List<FarmTypeEntity> data = await repo.getAllFarmtypes();
    setState(() {
      FarmTypeEntitysList = data;
    });
  }


  void _openFarmTypeEntityForm() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FarmTypeFormScreen()),
    ).then((value) {
      // Reload data after form submission
      loadFarmerData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FarmType Management"),
        actions: [
          Consumer<AuthService>(
            builder: (context, authService, child) {
              return Visibility(
                visible: authService.isAdmin, // Use auth state to determine visibility
                child: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _openFarmTypeEntityForm,
                  tooltip: "Add new FarmTypeEntity dataop data",
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
          itemCount: FarmTypeEntitysList.length,
          itemBuilder: (context, index) {
            FarmTypeEntity data = FarmTypeEntitysList[index];
            return Card(
              margin: EdgeInsets.all(8),
              child: ListTile(title: Text(data.name!)),
            );
          },
        ),
    );
  }
}
