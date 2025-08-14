import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// الاب
class BaseState {}

class IntialState extends BaseState {}

class SuccuessState extends BaseState {
  String succuessMessage;
  SuccuessState(this.succuessMessage);
}

class FailureState extends BaseState {
  String failureMessage;
  FailureState(this.failureMessage);
}

class LodingState extends BaseState {}

class LoginCubit extends Cubit<BaseState> {
  LoginCubit() : super(IntialState());

  Future<void> login(String email, String password) async {
    emit(LodingState());
  try{
    final response = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    emit(SuccuessState(
      'Welcome!'
    ));
  }on FirebaseAuthException catch(e){
    emit(FailureState(
      e.message ?? ''
      ),
      );
  }
    
  }
}
