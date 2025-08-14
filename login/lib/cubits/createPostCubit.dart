import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/States/createPostState.dart';
import 'package:login/services/shared_prefernces_helper.dart';

class CreatePostCubit extends Cubit<CreatePostState> {
  CreatePostCubit() : super(CreatePostInitial());

Future<void> submitPost(String title, String content, {String? imageUrl}) async {
  if (title.isEmpty || content.isEmpty) {
    emit(CreatePostFailure("All fields are required"));
    return;
  }

  emit(CreatePostLoading());

  try {
    final author = SharedPrefsHelper().getString("userEmail") ?? "Unknown";

    await FirebaseFirestore.instance.collection("posts").add({
      'title': title,
      'content': content,
      'author': author,
      'imageUrl': imageUrl ?? '',
      'timestamp': Timestamp.now(),
    });

    emit(CreatePostSuccess());
  } catch (e) {
    emit(CreatePostFailure("Failed to create post"));
  }
}

}