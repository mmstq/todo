import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/view/see_todo.dart';

import 'controller/todo_controller.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(TodoController(), permanent: true);
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To Do',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(brightness:Brightness.light, seedColor: Colors.lightGreen),
        useMaterial3: true,
        fontFamily: GoogleFonts.rajdhani().fontFamily,
        appBarTheme: AppBarTheme(
          scrolledUnderElevation: 4,
          titleTextStyle: const TextStyle(fontWeight: FontWeight.w700, color: Colors.white, fontSize: 24),
          color: Colors.lightGreen,
          elevation: 4,
            shadowColor: Colors.black.withOpacity(.5),
        )
      ),
      home: See(),
    );
  }
}

