import 'package:farmly_mobile/entities/farmdata/farmdata.entity.dart';
import 'package:farmly_mobile/entities/farmtype/farmtype.entity.dart';
import 'package:farmly_mobile/forms/clerk_form.dart';
import 'package:farmly_mobile/repositories/crop_repository.dart';
import 'package:farmly_mobile/repositories/farm_type_repository.dart';
import 'package:farmly_mobile/screens/crop_screen.dart';
import 'package:farmly_mobile/screens/farm_type_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import '../entities/crop/crop.entity.dart';
import '../repositories/farmer_repository.dart';
import '../services/auth_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<FarmDataEntity> farmerDataList = [];
  List<FarmDataEntity> filteredData = [];
  List<CropEntity> cropsList = [];
  List<FarmTypeEntity> farmTypeList = [];
  String filterLocation = '';
  String? selectedFarmTypeId;
  String? selectedCropId;

  @override
  void initState() {
    super.initState();
    loadCrops();
    loadFarmTypes();
    loadFarmerData();
  }

  void loadCrops() async {
    var repo = Provider.of<CropRepository>(context, listen: false);
    List<CropEntity> data = await repo.getAllCrops();
    setState(() {
      cropsList = data;
    });
  }

  void loadFarmTypes() async {
    var repo = Provider.of<FarmTypeRepository>(context, listen: false);
    List<FarmTypeEntity> data = await repo.getAllFarmtypes();
    setState(() {
      farmTypeList = data;
    });
  }

  void loadFarmerData() async {
    var repo = Provider.of<FarmerRepository>(context, listen: false);
    List<FarmDataEntity> data = await repo.getAllFarmData();
    setState(() {
      farmerDataList = data;
      filteredData = data;
    });
  }

  void filterFarms() {
    setState(() {
      filteredData =  farmerDataList.where((data) {
        bool matches = true;
        if (filterLocation.isNotEmpty) {
          matches = matches &&
              data.location!.toLowerCase().contains(filterLocation.toLowerCase());
        }
        if (selectedFarmTypeId != null) {
          matches = matches && (data.farmTypeId == selectedFarmTypeId);
        }
        if (selectedCropId != null) {
          matches = matches && (data.cropId == selectedCropId);
        }
        return matches;
      }).toList();
    });
  }

  void _logout() {
    Provider.of<AuthService>(context, listen: false).logout();
  }

  void _openClerkForm() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ClerkFormScreen()),
    ).then((value) {
      // Reload data after form submission
      loadFarmerData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Farm Data"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _openClerkForm,
            tooltip: "Add new farmer data",
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.green),
              child: Text("Farmly Data", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white)),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16,0,0,0),
              child: Text("Configurations", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black)),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.agriculture),
              title: Text("Crops"),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CropScreen())),
            ),
            ListTile(
              leading: Icon(Icons.nature),
              title: Text("Farm Types"),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => FarmTypeScreen())),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.red),
              title: Text("Logout", style: TextStyle(color: Colors.red)),
              onTap: _logout,
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Filter Section
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                // Filter by Location
                Expanded(
                  child: TextField(
                    decoration:
                    InputDecoration(labelText: "Filter by location"),
                    onChanged: (val) {
                      setState(() {
                        filterLocation = val;
                      });
                      filterFarms();
                    },
                  ),
                ),
                SizedBox(width: 8),
                // Dummy dropdowns for Farm Type and Crop filtering
                DropdownButton<String>(
                  hint: Text("Farm Type"),
                  value: selectedFarmTypeId,
                  items: farmTypeList.map((ft) =>
                      DropdownMenuItem(value: ft.id, child: Text(ft.name!)))
                      .toList(),
                  onChanged: (val) {
                    setState(() {
                      selectedFarmTypeId = val;
                    });
                    filterFarms();
                  },
                ),
                SizedBox(width: 8),
                DropdownButton<String>(
                  hint: Text("Crop"),
                  value: selectedCropId,
                  items: cropsList
                      .map((cr) =>
                      DropdownMenuItem(value: cr.id, child: Text(cr.name!)))
                      .toList(),
                  onChanged: (val) {
                    setState(() {
                      selectedCropId = val;
                    });
                    filterFarms();
                  },
                ),
                IconButton(
                  icon: Icon(Icons.clear),
                  tooltip: "Clear",
                  onPressed: () {
                    setState(() {
                      filterLocation = '';
                      selectedFarmTypeId = null;
                      selectedCropId = null;
                      filteredData = farmerDataList;
                    });
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredData.length,
              itemBuilder: (context, index) {
                FarmDataEntity data = filteredData[index];

                // Find the farm type and crop names
                String farmTypeName = farmTypeList
                    .firstWhere((ft) => ft.id == data.farmTypeId,
                    orElse: () => FarmTypeEntity(id: '', name: 'Unknown'))
                    .name ?? 'Unknown';

                String cropName = cropsList
                    .firstWhere((c) => c.id == data.cropId,
                    orElse: () => CropEntity(id: '', name: 'Unknown'))
                    .name ?? 'Unknown';

                return Slidable(
                  key: Key(data.id ?? index.toString()),
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    extentRatio: 0.25, // Controls how much of the screen width is used by the action buttons
                    children: [
                      SlidableAction(
                        onPressed: (slidableContext) async {
                          bool confirm = await showDialog(
                            context: context,  // Using the original context
                            builder: (BuildContext dialogContext) {
                              return AlertDialog(
                                title: Text("Confirm Delete"),
                                content: Text("Are you sure you want to delete ${data.farmerName}'s farm data?"),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.of(dialogContext).pop(false),
                                    child: Text("Cancel"),
                                  ),
                                  TextButton(
                                    onPressed: () => Navigator.of(dialogContext).pop(true),
                                    child: Text("Delete", style: TextStyle(color: Colors.red)),
                                  ),
                                ],
                              );
                            },
                          ) ?? false;

                          if (confirm) {
                            // Get the repository reference before any widget changes
                            final repo = Provider.of<FarmerRepository>(context, listen: false);

                            try {
                              // Delete the item from the database
                              //await repo.deleteFarmData(data.id!);

                              // Check if the widget is still mounted before updating state
                              if (mounted) {
                                setState(() {
                                  farmerDataList.removeWhere((item) => item.id == data.id);
                                  filteredData.removeWhere((item) => item.id == data.id);
                                });

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("${data.farmerName}'s data deleted")),
                                );
                              }
                            } catch (e) {
                              if (mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Error deleting: $e")),
                                );
                              }
                            }
                          }
                        },
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                      ),
                    ],
                  ),
                  child: Card(
                    margin: EdgeInsets.all(8),
                    child: ListTile(
                      title: Text(data.farmerName ?? ""),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Location: ${data.location}"),
                          SizedBox(height: 4),
                          Wrap(
                            spacing: 8,
                            children: [
                              Chip(
                                label: Text(farmTypeName),
                                backgroundColor: Colors.green.shade100,
                                avatar: Icon(Icons.nature, size: 16, color: Colors.green),
                                labelStyle: TextStyle(fontSize: 12),
                                padding: EdgeInsets.all(0),
                              ),
                              Chip(
                                label: Text(cropName),
                                backgroundColor: Colors.amber.shade100,
                                avatar: Icon(Icons.agriculture, size: 16, color: Colors.amber.shade800),
                                labelStyle: TextStyle(fontSize: 12),
                                padding: EdgeInsets.all(0),
                              ),
                            ],
                          ),
                        ],
                      ),
                      isThreeLine: true,
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
