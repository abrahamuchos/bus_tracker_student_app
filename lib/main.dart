import 'package:bus_tracker/core/di/injection_container.dart';
import 'package:bus_tracker/features/trip_tracking/presentation/pages/trip_tracking_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  //DI
  await init();

  runApp(const StudentApp());
}

class StudentApp extends StatelessWidget {
  const StudentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student App',
      home: TripTrackingPage(),
    );
  }
}
