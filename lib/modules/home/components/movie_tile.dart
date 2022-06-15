import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_db/core/models/movie.dart';
import 'package:movie_db/modules/detail/screens/detail_screen.dart';

class MovieTile extends StatelessWidget {
  final Movie movie;

  const MovieTile(this.movie, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DetailScreen(
            movie: movie,
          ),
        ));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            child: CachedNetworkImage(
              imageUrl: movie.posterUri.toString(),
              fit: BoxFit.fitWidth,
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Flexible(
            child: Text(
              movie.title,
              style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }
}
