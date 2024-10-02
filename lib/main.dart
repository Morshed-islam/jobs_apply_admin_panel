import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jobs_apply_admin_panel/providers/add_slider_provider/add_slider_provider.dart';
import 'package:jobs_apply_admin_panel/providers/add_villa_provider/add_villa_provider.dart';
import 'package:jobs_apply_admin_panel/providers/dashboard/page_provider.dart';
import 'package:jobs_apply_admin_panel/providers/login_provider/login_provider.dart';
import 'package:jobs_apply_admin_panel/screens/add_post/add_job_screen.dart';
import 'package:jobs_apply_admin_panel/screens/add_slider/add_slider.dart';
import 'package:jobs_apply_admin_panel/screens/dashboard/starter_screen.dart';
import 'package:jobs_apply_admin_panel/screens/login/login_screen.dart';
import 'package:jobs_apply_admin_panel/screens/orders/orders_request_page.dart';
import 'package:jobs_apply_admin_panel/screens/premium_request/premium_request_screen.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyCx0AdlE-XHio_owRXpPZ6yxy8w4UKuXh4",
        authDomain: "jobapplyservicebd-1bda4.firebaseapp.com",
        projectId: "jobapplyservicebd-1bda4",
        storageBucket: "jobapplyservicebd-1bda4.appspot.com",
        messagingSenderId: "890086279190",
        appId: "1:890086279190:web:bddf43c0d69f5c5888cd37",
        measurementId: "G-9VYM65PJR7"
    ),
  );

  // Initialize AuthProvider to check login status
  final authProvider = AuthProvider();
  await authProvider.checkLoginStatus(); // Check if the user is logged in

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PageProvider()), // Manage page navigation
        ChangeNotifierProvider(create: (_) => AuthProvider()), // Use the same instance of AuthProvider
        ChangeNotifierProvider(create: (_) => SliderProvider()),
        ChangeNotifierProvider(create: (_) => AddVillaProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Job Service Apply',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Consumer<AuthProvider>(
        builder: (context, authProvider, _) {
          log("isLoggedIn: ${authProvider.isLoggedIn}");
          // Show login screen if not logged in, otherwise show dashboard
          return authProvider.isLoggedIn
              ? StarterScreen() // Redirect to Admin Dashboard if logged in
              : AdminLoginScreen(); // Show login screen otherwise
        },
      ),
      routes: {
        '/adminDashboard': (context) => StarterScreen(),
        '/addPost': (context) => AddJobPage(),
        '/premium': (context) => PremiumRequestPage(),
        '/addSlider': (context) => AddSliderPage(),
        '/orders': (context) => OrdersRequestPage(),
      },
    );
  }
}
