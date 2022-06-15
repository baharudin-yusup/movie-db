import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_db/core/models/movie.dart';

class DetailScreen extends StatefulWidget {
  final Movie movie;

  const DetailScreen({Key? key, required this.movie}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = const TextStyle(color: Colors.white);
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            floating: true,
            expandedHeight: 500,
            backgroundColor: Colors.black,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: CachedNetworkImageProvider(widget.movie.posterUri.toString()),
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter),
                ),
                child: Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.black, Colors.transparent],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter)),
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        widget.movie.title,
                        style: textStyle.copyWith(
                          fontSize: 42,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(
                height: 30,
                child: ListView.builder(
                    itemCount: widget.movie.genres.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        margin: EdgeInsets.only(left: index == 0 ? 30 : 0, right: 12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(99),
                            border: Border.all(color: Colors.white, width: 1)),
                        child: Center(
                          child: Text(widget.movie.genres[index], style: textStyle),
                        ),
                      );
                    }),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 30, right: 30, bottom: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.movie.description, style: textStyle),
                    const SizedBox(
                      height: 12,
                    ),
                    Text('Release Date',
                        style: textStyle.copyWith(fontWeight: FontWeight.w700, fontSize: 18)),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      widget.movie.releaseDate?.toString().substring(0, 10) ?? 'Unknown',
                      style: textStyle,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text('Rating',
                        style: textStyle.copyWith(fontWeight: FontWeight.w700, fontSize: 18)),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(widget.movie.voteAverage.toString(), style: textStyle),
                    const SizedBox(
                      height: 12,
                    ),
                    Text('Total Vote',
                        style: textStyle.copyWith(fontWeight: FontWeight.w700, fontSize: 18)),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(widget.movie.voteCount.toString(), style: textStyle),
                    const SizedBox(
                      height: 12,
                    ),
                    Text('Photos',
                        style: textStyle.copyWith(fontWeight: FontWeight.w700, fontSize: 18)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: CachedNetworkImage(
                    imageUrl: widget.movie.backdropUri.toString(),
                    fit: BoxFit.fitWidth,
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ]),
          )
        ],
      ),
    );
  }
}
