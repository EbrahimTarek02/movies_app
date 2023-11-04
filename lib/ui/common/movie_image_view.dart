import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/ui/util/app_colors.dart';

class MovieImageViewer extends StatelessWidget {
  final String movieImageSource;

  const MovieImageViewer(this.movieImageSource, {super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          CachedNetworkImage(
            imageUrl: "https://image.tmdb.org/t/p/w500$movieImageSource",
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            errorWidget: (_, __, ___) {
              return Image.network(
                'https://michaelnakache.com/wp-content/uploads/2018/08/movie-poster-coming-soon-2.png',
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
              );
            },
          ),
          const Icon(
            Icons.play_circle_fill,
            size: 60.0,
            color: AppColors.white,
          ),
        ],
      ),
    );
  }
}