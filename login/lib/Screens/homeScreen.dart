// // import 'package:draggable_button/draggable_button.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:login/Screens/creatPostScreen.dart';
// import 'package:login/Screens/postDetails.dart';
// import 'package:login/core/theme/app_colors.dart' show AppColors;
// import 'package:login/core/theme/app_text_styles.dart';
// import 'package:login/cubits/home_cubit.dart';
// import 'package:login/States/home_state.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       // دوت دوت معناها انك بتنادي على الداله راح تنادي على الكيوبيت
//       create: (_) => HomeCubit()..fetchPosts(),
//       child: const HomePage(),
//     );
//   }
// }

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   bool isFav = false;
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Scaffold(
//           backgroundColor: Colors.transparent,
// appBar: AppBar(
//   backgroundColor: Colors.transparent,
//   automaticallyImplyLeading: false,
//   title: Text(
//     "𓁿",
//     style: GoogleFonts.monomaniacOne(
//       fontSize: 50,
//       color: Colors.white,
//     ),
//   ),
// ),
//           body: BlocBuilder<HomeCubit, HomeState>(
//             builder: (_, state) {
//               if (state is HomeLoding) {
//                 return const Center(child: CircularProgressIndicator());
//               } else if (state is HomeSuccess) {
//                 final posts = state.posts;
//                 if (posts.isEmpty) {
//                   return const Center(child: Text("No posts found"));
//                 }
//                 return ListView.builder(
//                   padding: const EdgeInsets.only(top: 20),
//                   itemCount: posts.length,
//                   itemBuilder: (_, index) {
//                     final post = posts[index];
//                     return GestureDetector(
//                       onTap: (){
//                         Navigator.of(context).push(
//                           MaterialPageRoute(
//                             builder: (_) => PostDetails(post),
//                           ),
//                         );
//                       },
//                       child: Container(
//                         margin: const EdgeInsets.only(bottom: 1),
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 5,
//                           vertical: 10,
//                         ),
//                         decoration: BoxDecoration(
//                           color: const Color.fromARGB(2, 0, 0, 0),
//                           borderRadius: BorderRadius.circular(0),
//                           border: Border(
//                             top: BorderSide(
//                               width: 0.2,
//                               color: const Color.fromARGB(138, 255, 255, 255),
//                             ),
//                             bottom: BorderSide(
//                               width: 0.2,
//                               color: const Color.fromARGB(138, 255, 255, 255),
//                             ),
//                           ),
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.only(right: 10),
//                                   child: const Icon(
//                                     Icons.more_horiz,
//                                     color: Color.fromARGB(129, 255, 255, 255),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             Row(
//                               children: [
//                                 CircleAvatar(
//                                   radius: 22,
//                                   backgroundImage: AssetImage(
//                                     'assets/avatar.jpeg',
//                                   ),
//                                 ),
//                                 const SizedBox(width: 10),
//                                 Text(
//                                   post['title'] ?? '',
//                                   style: AppTextStyles.title,
//                                 ),
//                                 const SizedBox(width: 5),
//                                 Align(
//                                   alignment: Alignment.bottomRight,
//                                   child: Text(
//                                     "${post['@IMarwa_MK'] ?? '@IMarwa_MK'}",
//                                     style: TextStyle(
//                                       fontSize: 12,
//                                       color: Colors.grey.shade600,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.all(18.0),
//                               child: Text(
//                                 post['content'] ?? '',
//                                 style: AppTextStyles.subtitle,
//                                 overflow: TextOverflow.ellipsis,
//                                 maxLines: 2,
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceAround,
//                                 children: [
//                                   Row(
//                                     children: [
//                                       const Icon(
//                                         Icons.share,
//                                         color: Color.fromARGB(
//                                           129,
//                                           255,
//                                           255,
//                                           255,
//                                         ),
//                                       ),
//                                       SizedBox(width: 3),
//                                       Text(
//                                         '10',
//                                         style: TextStyle(color: Colors.grey),
//                                       ),
//                                     ],
//                                   ),
//                                   Row(
//                                     children: [
//                                       const Icon(
//                                         Icons.repeat,
//                                         color: Color.fromARGB(
//                                           129,
//                                           255,
//                                           255,
//                                           255,
//                                         ),
//                                       ),
//                                       SizedBox(width: 3),
//                                       Text(
//                                         '10k',
//                                         style: TextStyle(color: Colors.grey),
//                                       ),
//                                     ],
//                                   ),
//                                   Row(
//                                     children: [
//                                       GestureDetector(
//                                         onTap: () {
//                                           setState(() {
//                                             isFav = !isFav;
//                                           });
//                                         },
//                                         child: Icon(
//                                           isFav
//                                               ? Icons.favorite
//                                               : Icons.favorite_border_outlined,
//                                           color: isFav
//                                               ? const Color.fromARGB(
//                                                   222,
//                                                   248,
//                                                   3,
//                                                   3,
//                                                 )
//                                               : const Color.fromARGB(
//                                                   129,
//                                                   255,
//                                                   255,
//                                                   255,
//                                                 ),
//                                         ),
//                                       ),
//                                       SizedBox(width: 3),
//                                       Text(
//                                         '7K',
//                                         style: TextStyle(color: Colors.grey),
//                                       ),
//                                     ],
//                                   ),
//                                   Row(
//                                     children: [
//                                       const Icon(
//                                         Icons.bookmark_outline,
//                                         color: Color.fromARGB(
//                                           129,
//                                           255,
//                                           255,
//                                           255,
//                                         ),
//                                       ),
//                                       SizedBox(width: 3),
//                                       Text(
//                                         '1K',
//                                         style: TextStyle(color: Colors.grey),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               } else if (state is HomeFailure) {
//                 return Center(child: Text(state.errorMessage));
//               }
//               return const SizedBox();
//             },
//           ),
//           floatingActionButton: FloatingActionButton(
//             onPressed: () {
//               final cubit = context.read<HomeCubit>();
//               Navigator.of(context)
//                   .push(
//                     PageRouteBuilder(
//                       transitionDuration: const Duration(milliseconds: 10),
//                       pageBuilder: (context, animation, secondaryAnimation) =>
//                           const CreatePostView(),
//                       transitionsBuilder:
//                           (context, animation, secondaryAnimation, child) {
//                             return FadeTransition(
//                               opacity: animation,
//                               child: child,
//                             );
//                           },
//                     ),
//                   )
//                   .then((_) {
//                     cubit.fetchPosts();
//                   });
//             },
//             backgroundColor: AppColors.primary,
//             foregroundColor: Colors.white, // لون الأيقونة
//             elevation: 8, // ارتفاع الظل
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(50),
//             ),
//             child: const Icon(Icons.add, size: 32),
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/Screens/creatPostScreen.dart';
import 'package:login/Screens/postDetails.dart';
import 'package:login/States/home_state.dart';
import 'package:login/core/Widgets/post_card.dart';
import 'package:login/core/theme/app_colors.dart';
import 'package:login/cubits/home_cubit.dart';

// ---------------- Home View ----------------

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit()..fetchPosts(),
      child: const HomePage(),
    );
  }
}

// ---------------- UI Page ----------------

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (_, state) {
          if (state is HomeLoding) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HomeSuccess) {
            final posts = state.posts;

            if (posts.isEmpty) {
              return const Center(
                child: Text(
                  "No posts found",
                  style: TextStyle(color: Colors.black),
                ),
              );
            }

            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  pinned: false,
                  elevation: 0,
                  backgroundColor: Colors.black,
                  expandedHeight: 70,
                  title: const Text(
                    "𓁿",
                    style: TextStyle(fontSize: 60, color: Colors.white),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((_, index) {
                      final post = posts[index];
                      return PostCard(
                        post: post,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => PostDetails(post),
                            ),
                          );
                        },
                      );
                    }, childCount: posts.length),
                  ),
                ),
              ],
            );
          } else if (state is HomeFailure) {
            return Center(child: Text(state.errorMessage));
          }

          return const SizedBox();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final cubit = context.read<HomeCubit>();
          Navigator.of(context)
              .push(
                PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 10),
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const CreatePostView(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                        return FadeTransition(opacity: animation, child: child);
                      },
                ),
              )
              .then((_) => cubit.fetchPosts());
        },
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        child: const Icon(Icons.add, size: 32),
      ),
    );
  }
}
