import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:minapharm_task/presentation/blocs/managing/movies/movies_bloc.dart';
import 'package:minapharm_task/presentation/resources/colors_manager.dart';
import 'package:minapharm_task/presentation/resources/strings_manager.dart';
import 'package:minapharm_task/presentation/resources/values_manager.dart';
import 'package:minapharm_task/presentation/screens/movies/movie_card.dart';
import 'package:minapharm_task/presentation/widgets/error/error_screen.dart';

class MoviesScreen extends StatelessWidget {
  const MoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.movies),
        leading: const BackButton(
          color: AppColor.white,
        ),
      ),
      body: BlocBuilder<MoviesBloc, MoviesState>(
        builder: (context, state) {
          if (state is MoviesLoadingState) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else if (state is MoviesLoadedState) {
            final movies = state.movies;
            return SizedBox(
              height: ScreenUtil().screenHeight,
              child: ListView.builder(
                  itemCount: movies.length,
                  itemBuilder: (context, index) {
                    final movie = movies.elementAt(index);
                    return Container(
                      padding: EdgeInsets.only(
                        top: AppSize.s12.h,
                        right: AppSize.s12.w,
                        left: AppSize.s12.w,
                      ),
                      height: ScreenUtil().screenHeight * .65,
                      child: MovieCard(
                        movie: movie,
                      ),
                    );
                  }),
            );
          }
          if (state is MoviesFailureState) {
            return ErrorScreen(
                message: state.failure.message,
                retryFunction: () {
                  context.read<MoviesBloc>().add(MoviesGetRecentMoviesEvent());
                });
          }
          return Container();
        },
      ),
    );
  }
}
