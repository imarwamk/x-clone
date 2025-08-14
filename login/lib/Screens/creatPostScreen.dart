// import 'dart:io';
// import 'dart:typed_data';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:login/States/createPostState.dart';
// import 'package:login/core/Widgets/custom_button.dart';
// import 'package:login/core/theme/app_text_styles.dart';
// import 'package:login/cubits/createPostCubit.dart';
// import 'package:login/utilities/pick_image.dart';

// // ---------------- View Wrapper ----------------

// class CreatePostView extends StatelessWidget {
//   const CreatePostView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => CreatePostCubit(),
//       child: const CreatePostPage(),
//     );
//   }
// }

// // ---------------- Page UI ----------------

// class CreatePostPage extends StatefulWidget {
//   const CreatePostPage({super.key});

//   @override
//   State<CreatePostPage> createState() => _CreatePostPageState();
// }

// class _CreatePostPageState extends State<CreatePostPage> {
//   final titleController = TextEditingController();
//   final contentController = TextEditingController();

//   String? uploadedImageUrl;
//   Uint8List? _imageData;

// Future<void> _pickAndUploadImage() async{
//   final pickedImage = await pickImage();
//  if (pickedImage != null) {
//       try {
//         // final file = File(pickedImage.path);
//         final bytes = await pickedImage.readAsBytes();
//         final fileName = pickedImage.name;

//         print('islam: image read successfully');

//         setState(() {
//           _imageData = bytes;
//         });

//         final imagePath = await uploadImageFromBytes(bytes, fileName);

//         setState(() {
//           uploadedImageUrl = imagePath;
//         });
//       } catch (e) {
//         print(' Failed to upload image: $e');
//       }
//     }
//   }

//   void _submitPost() {
//   context.read<CreatePostCubit>().submitPost(
//   titleController.text.trim(),
//   contentController.text.trim(),
//   imageUrl: uploadedImageUrl,
// );

//   }
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Scaffold(
//           backgroundColor: Colors.transparent,
//           appBar: AppBar(
//             backgroundColor: Colors.transparent,
//             // automaticallyImplyLeading: false,
//             title: Text(
//               "𓁿",
//               style: TextStyle(fontSize: 50, color: Colors.white),
//             ),
//             ),
//           body: BlocConsumer<CreatePostCubit, CreatePostState>(
//             listener: (_, state) {
//               if (state is CreatePostLoading) {
//                 showDialog(
//                   context: context,
//                   barrierDismissible: false,
//                   builder: (_) =>
//                       const Center(child: CircularProgressIndicator()),
//                 );
//               } else {
//                 Navigator.of(context, rootNavigator: true).pop();

//                 if (state is CreatePostSuccess) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(
//                       backgroundColor: Colors.green,
//                       content: Text("Post added successfully"),
//                     ),
//                   );
//                   Navigator.of(context).pop();
//                 } else if (state is CreatePostFailure) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       backgroundColor: Colors.red,
//                       content: Text(state.errorMessage),
//                     ),
//                   );
//                 }
//               }
//             },
//             builder: (_, state) {
//               return Stack(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(20),
//                     child: Column(
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: [
//                             SizedBox(
//                               child: CustomButton(
//                                 onPressed: _submitPost,
//                                 text: "Post",
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 16),
//                         TextField(
//                           controller: titleController,
//                           decoration: const InputDecoration(
//                             labelText: "Name",
//                             enabledBorder: OutlineInputBorder(
//                               borderSide: BorderSide(
//                                 color: Color.fromARGB(255, 87, 39, 176),
//                               ),
//                             ),
//                           ),
//                           style: AppTextStyles.title,
//                         ),
//                         const SizedBox(height: 16),
//                         TextField(
//                           controller: contentController,
//                           maxLines: 5,
//                           decoration: const InputDecoration(
//                             labelText: "Content",
//                             enabledBorder: OutlineInputBorder(
//                               borderSide: BorderSide(
//                                 color: Color.fromARGB(255, 87, 39, 176),
//                               ),
//                             ),
//                           ),
//                           style: AppTextStyles.subtitle,
//                         ),
//                         const SizedBox(height: 24),
//                         GestureDetector(
//                           onTap: _pickAndUploadImage,
//                           child: Container(
//                             width: double.infinity,
//                             height: 350,
//                             alignment: Alignment.center,
//                             child: _imageData == null
//                             ? const Icon(Icons.image,
//                             size: 40, color: Colors.grey,)
//                             : Image.memory(_imageData!,
//                             width: double.infinity,
//                             height: 150,
//                             fit: BoxFit.cover,)
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/States/createPostState.dart';
import 'package:login/cubits/createPostCubit.dart';
import 'package:login/utilities/pick_image.dart';

class CreatePostView extends StatelessWidget {
  const CreatePostView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CreatePostCubit(),
      child: const CreatePostPage(),
    );
  }
}

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({super.key});

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  String? uploadedImageUrl;
  Uint8List? _imageData;

  Future<void> _pickAndUploadImage() async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      try {
        final bytes = await pickedImage.readAsBytes();
        final fileName = pickedImage.name;

        setState(() => _imageData = bytes);

        if (!mounted) return;
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => const Center(child: CircularProgressIndicator()),
        );

        final imagePath = await uploadImageFromBytes(bytes, fileName);
        setState(() => uploadedImageUrl = imagePath);

        if (!mounted) return;
        Navigator.of(context).pop();
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error uploading image: $e')));
      }
    }
  }

  void _submitPost() {
    if (titleController.text.trim().isEmpty ||
        contentController.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please fill all fields')));
      return;
    }

    context.read<CreatePostCubit>().submitPost(
      titleController.text.trim(),
      contentController.text.trim(),
      imageUrl: uploadedImageUrl,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            title: Text(
              "𓁿",
              style: TextStyle(fontSize: 60, color: Colors.white),
            ),
          ),
          body: BlocConsumer<CreatePostCubit, CreatePostState>(
            listener: (_, state) {
              if (state is CreatePostLoading) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) =>
                      const Center(child: CircularProgressIndicator()),
                );
              } else {
                Navigator.of(context, rootNavigator: true).pop();
                if (state is CreatePostSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Post added successfully"),
                      backgroundColor: Colors.green,
                    ),
                  );
                  Navigator.of(context).pop();
                } else if (state is CreatePostFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.errorMessage),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              }
            },
            builder: (_, state) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                                  child: const Text('Cancel', 
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15)),
                                  onPressed: () => Navigator.pop(context),
                                ),
                        ElevatedButton(
                          onPressed: _submitPost,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Text(
                            "Post",
                            style: TextStyle(color: Colors.white,
                            fontSize: 15),
                          ),
                        ),
                        
                      ],
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: titleController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: "Name",
                        labelStyle: const TextStyle(color: Colors.grey),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.deepPurple.withOpacity(0.5),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.deepPurple,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                  TextField(
                      controller: contentController,
                      maxLines: 5,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: "Content",
                        labelStyle: const TextStyle(color: Colors.grey),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.deepPurple.withOpacity(0.5),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.deepPurple,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    GestureDetector(
                      onTap: _pickAndUploadImage,
                      child: Container(
                        width: double.infinity,
                        height: 400,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.deepPurple.withOpacity(0.5),
                            width: 1,
                          ),
                        ),
                        child: _imageData == null
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.image,
                                    size: 40,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    "Add Image",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.memory(
                                  _imageData!,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
