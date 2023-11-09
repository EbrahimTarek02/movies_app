import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/ui/util/app_assets.dart';
import 'package:movies_app/ui/util/app_colors.dart';

class MoviePosterView extends StatelessWidget {
  final String posterImageSource;
  final bool inListView;

  const MoviePosterView(this.posterImageSource, this.inListView, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: inListView
            ? BorderRadius.circular(8.0)
            : BorderRadius.circular(12.0),
      ),
      child: Stack(
        alignment: AlignmentDirectional.topStart,
        children: [
          CachedNetworkImage(
            imageUrl: "https://image.tmdb.org/t/p/w500$posterImageSource",
            fit: BoxFit.fill,
            height: inListView
                ? MediaQuery.of(context).size.height * 0.2
                : MediaQuery.of(context).size.height * 0.25,
            width: inListView
                ? MediaQuery.of(context).size.width * 0.25
                : MediaQuery.of(context).size.width * 0.3,
            errorWidget: (_, __, ___) {
              return Image.network(
                'https://michaelnakache.com/wp-content/uploads/2018/08/movie-poster-coming-soon-2.png',
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width * 0.3,
              );
            },
          ),
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Image.asset(
                AppAssets.bookmarkAdd,
                color: AppColors.darkGrey,
              ),
              IconButton(
                icon: Icon(
                  Icons.add,
                  size: 20,
                  color: AppColors.white,
                ),
                onPressed: (){},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
