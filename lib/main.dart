import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instragram_flutter/providers/user_provider.dart';
import 'package:instragram_flutter/responsive/mobile_screen_layout.dart';
import 'package:instragram_flutter/responsive/responsive.dart';
import 'package:instragram_flutter/responsive/web_screen_layout.dart';
import 'package:instragram_flutter/screens/login_screen.dart';
import 'package:instragram_flutter/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyB7XU8YEO166A-XKVeVY5OND2FyGcBUhXo',
        appId: '1:317919074595:web:454407eae81b7bb7dbd496',
        messagingSenderId: '317919074595',
        projectId: 'instagram-clone-5ae98',
        storageBucket: 'instagram-clone-5ae98.appspot.com',
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Instragram clone',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: mobileBackgroundColor,
        ),
        home: Scaffold(
          body: StreamBuilder(
            stream: FirebaseAuth.instance.userChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  // return const LoginScreen();
                  return const ResponsiveLayout(
                    mobileScreenLayout: MobileScreenLayout(),
                    webScreenLayout: WebScreenLayout(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      '${snapshot.error}',
                    ),
                  );
                }
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return const LoginScreen();
            },
          ),
        ),
      ),
    );
  }
}
