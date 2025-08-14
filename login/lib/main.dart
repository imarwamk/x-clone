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

  // تسوي كائن للشيريد بريفرينسس
  await SharedPrefsHelper().init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform);
    
    await Supabase.initialize(
      url: 'https://fcctwwdgqtfivesfbtct.supabase.co' ,
      anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZjY3R3d2RncXRmaXZlc2ZidGN0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTI3MDMyNTQsImV4cCI6MjA2ODI3OTI1NH0.LFFGie5z36zMV1_B294tVody-oq00DJ0jXafjnoF70U',
    );
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      // لو كان مسجل يوجهة للهوم لو لا يروح  لصفحة تسجيل الدخول 
      home: SharedPrefsHelper().getString('userEmail') == null
      ? BlocProvider(
      create: (_) => LoginCubit(), 
      child: LoginScreen())
      : HomeView(),
    ),
  );
}


