import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/States/signupstate.dart';
import 'package:login/services/shared_prefernces_helper.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());

  Future<void> signup(String email, String password) async {
    emit(SignupLoading());

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await SharedPrefsHelper().setString('userEmail', email);

      emit(SignupSuccess());
    } on FirebaseAuthException catch (e) {
      emit(
        SignupFailure(
          e.message ?? "An unknown error occurred",
        ),
      );
    }
  }
}