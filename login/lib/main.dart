import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/Screens/homeScreen.dart';
import 'package:login/Screens/login_screen.dart';
import 'package:login/cubits/login_cubit.dart';
import 'package:login/firebase_options.dart';
import 'package:login/services/shared_prefernces_helper.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SharedPrefsHelper().init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform);
    
  // await Supabase.initialize(
  //   TODO: Replace with your own Supabase project URL
  //   url: 'https://YOUR_PROJECT_URL.supabase.co',

  //   TODO: Replace with your own Supabase anon/public API key
  //   anonKey: 'YOUR_SUPABASE_ANON_KEY',
  // );
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SharedPrefsHelper().getString('userEmail') == null
      ? BlocProvider(
      create: (_) => LoginCubit(), 
      child: LoginScreen())
      : HomeView(),
    ),
  );
}


// TODO: Add your own Firebase config files:
// android/app/google-services.json
// ios/Runner/GoogleService-Info.plist



