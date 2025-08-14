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
