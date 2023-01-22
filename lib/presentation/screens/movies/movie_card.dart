import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:minapharm_task/presentation/widgets/loading/loading_Indicator.dart';

import 'package:minapharm_task/domain/entities/movie_entity.dart';
import 'package:minapharm_task/presentation/resources/values_manager.dart';

class MovieCard extends StatelessWidget {
  final MovieEntity movie;
  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppSize.s12.h),
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              placeholder: (context, url) {
                return const LoadingIndicator();
              },
              errorWidget: (context, url, error) {
                return   const LoadingIndicator();
              },
              imageUrl: movie.url,
            ),
          ),
        ),
        SizedBox(
          height: AppSize.s12.h,
        ),
        Text(
          movie.title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium,
        )
      ],
    );
  }
}
