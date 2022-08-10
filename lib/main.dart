import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:map_exam/controller/noteController.dart';
import 'package:map_exam/firebase_options.dart';
import 'package:map_exam/login_screen.dart';
import 'package:map_exam/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'myFirst',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialBinding: InitBinding(),
      home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Get.find<NoteController>().startStream(snapshot.data!.email!);
              return const HomeScreen();
            } else {
              return const LoginScreen();
            }
          }),
      // home: const HomeScreen(),
      // home: const EditScreen(),
    );
  }
}

class InitBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<NoteController>(NoteController());
  }
}
