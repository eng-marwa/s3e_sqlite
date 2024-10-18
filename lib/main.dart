import 'package:flutter/material.dart';
import 'package:s3e_sqlite/data/db_helper.dart';
import 'package:s3e_sqlite/user.dart';
import 'package:s3e_sqlite/utils/date_time_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:s3e_sqlite/view_notes_screen.dart';
import 'home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  print(DateTimeManager.toTimeAgo(DateTimeManager.getCurrentDateTime()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(414, 1100),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) => MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
              home: const ViewNotesScreen(),
            ));
  }
}
