import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/States/home_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeCubit extends Cubit<HomeState>{
  HomeCubit() : super(HomeInitial());

  Future<void> fetchPosts() async {
    emit(HomeLoding());
    try {
      final snapshot = await FirebaseFirestore.instance
      .collection('posts')
      .orderBy('timestamp')
      .get();
      
      
      final posts = snapshot.docs.map((doc) {
  final data = doc.data();

  return {
    'id': doc.id,
    'title': data['title'] ?? '',
    'content': data['content'] ?? '',
    'author': data['author'] ?? '',
    'imageUrl': data['imageUrl'] ?? '',
    'timestamp': data['timestamp'] ?? Timestamp.now(),
  };
}).toList();

      emit(HomeSuccess(posts));
    } catch (e){
      emit(HomeFailure('Failed to load posts'));
    }
  }


}