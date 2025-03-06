import 'package:farmly_mobile/repositories/crop_repository.dart';
import 'package:farmly_mobile/repositories/farm_type_repository.dart';
import 'package:farmly_mobile/screens/home_screen.dart';
import 'package:farmly_mobile/utils/background.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'orm.init.dart';
import 'services/auth_service.dart';
import 'services/data_sync_service.dart';
import 'repositories/farmer_repository.dart';
import 'screens/login_screen.dart';
import 'constants/constants.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialise orm before application
  initOrm();
  // Initialise background services
  await FarmlySynchronizer().initialise();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthService>(create: (_) => AuthService()),
        ChangeNotifierProvider<DataSyncService>(create: (_) => DataSyncService()),
        ChangeNotifierProvider<CropRepository>(create: (_) => CropRepository()),
        ChangeNotifierProvider<FarmTypeRepository>(create: (_) => FarmTypeRepository()),
        ChangeNotifierProvider<FarmerRepository>(create: (_) => FarmerRepository()),
      ],
      child: MaterialApp(
        title: APP_TITLE,
        theme: ThemeData(primarySwatch: Colors.green),
        home: Consumer<AuthService>(
          builder: (context, auth, _) {
            if (!auth.isAuthenticated) {
              return LoginScreen();
            }
            return HomeScreen();
          },
        ),
      ),
    );
  }
}
