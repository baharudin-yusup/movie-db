import 'package:flutter/material.dart';
import 'package:movie_db/core/models/movie.dart';

import '../../../core/apis/tmdb.dart';
import '../components/movie_tile.dart';

class DiscoveryScreen extends StatelessWidget {
  const DiscoveryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Movie>>(
      future: Api.movies,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const _ErrorUI();
        }

        if (!snapshot.hasData) {
          return const Center(
              child: CircularProgressIndicator(
            color: Colors.white,
          ));
        }

        return _MainUI(
          movies: snapshot.data!,
        );
      },
    );
  }
}

class _ErrorUI extends StatelessWidget {
  const _ErrorUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class _MainUI extends StatelessWidget {
  final List<Movie> movies;

  const _MainUI({Key? key, required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tiles = List<MovieTile>.generate(movies.length, (index) => MovieTile(movies[index]));

    return GridView(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 150,
        childAspectRatio: 150 / 275,
        crossAxisSpacing: 10,
        mainAxisSpacing: 20,
      ),
      children: tiles,
    );
  }
}
