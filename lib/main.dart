

import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:flutter_application_1/view/home_screen.dart';

import 'constants/bindings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // location permission
  await requestPermissions();

 /* await Permission.location.isGranted; // Check Permission
  await Permission.location.request(); // Ask
// Android 12+
  await Permission.nearbyWifiDevices.request();

// Check Location Status
  await Permission.location.serviceStatus.isEnabled;

// location enable dialog
  await Location.instance.requestService();

// external storage permission
  await Permission.storage.isGranted; // Check Permission
  await Permission.storage.request(); // Ask
// Check Bluetooth Status
  await Permission.bluetooth.serviceStatus.isEnabled;
// Bluetooth permissions
  bool granted = !(await Future.wait([
    // Check Permissions
    Permission.bluetooth.isGranted,
    Permission.bluetoothAdvertise.isGranted,
    Permission.bluetoothConnect.isGranted,
    Permission.bluetoothScan.isGranted,
  ]))
      .any((element) => false);
  [
    // Ask Permissions
    Permission.bluetooth,
    Permission.bluetoothAdvertise,
    Permission.bluetoothConnect,
    Permission.bluetoothScan
  ].request();

*/

  runApp(MyApp());
}

Future<void> requestPermissions() async {
  // Request location permissions
  if (!await Permission.location.isGranted) {
    await Permission.location.request();
  }

  // Request nearby WiFi devices permission (Android 12+)
  if (!await Permission.nearbyWifiDevices.isGranted) {
    await Permission.nearbyWifiDevices.request();
  }

  // Ensure location services are enabled
  if (!await Permission.location.serviceStatus.isEnabled) {
    await Location.instance.requestService();
  }

  // Request external storage permissions
  if (!await Permission.storage.isGranted) {
    await Permission.storage.request();
  }

  // Request Bluetooth permissions
  if (!await Permission.bluetooth.isGranted) {
    await Permission.bluetooth.request();
  }
  if (!await Permission.bluetoothAdvertise.isGranted) {
    await Permission.bluetoothAdvertise.request();
  }
  if (!await Permission.bluetoothConnect.isGranted) {
    await Permission.bluetoothConnect.request();
  }
  if (!await Permission.bluetoothScan.isGranted) {
    await Permission.bluetoothScan.request();
  }
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      locale: const Locale('fa', 'IR'),
      localizationsDelegates: const [
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale("fa", "IR"),
        ],
      initialBinding: MyBindings(),
      home: const HomeScreen(),
    );
  }
}



