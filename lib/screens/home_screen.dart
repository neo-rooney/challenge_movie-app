import 'package:challenge_movie_app/models/movie_list_model.dart';
import 'package:challenge_movie_app/screens/detail_screen.dart';
import 'package:challenge_movie_app/services/api_service.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Future<List<MovieListModel>> popularMovies =
      ApiService.getPopularMovies();

  final Future<List<MovieListModel>> nowPlayingMovies =
      ApiService.getNowPlayingMovies();

  final Future<List<MovieListModel>> commingSoonMovies =
      ApiService.getComingSoonMovies();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 120,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Popular Movies',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 200,
                child: FutureBuilder(
                  future: popularMovies,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return makeList(snapshot, 250);
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Now in Cinemas',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 200,
                child: FutureBuilder(
                  future: nowPlayingMovies,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return makeList(snapshot, 200);
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Coming Soon',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 200,
                child: FutureBuilder(
                  future: commingSoonMovies,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return makeList(snapshot, 200);
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ListView makeList(
    AsyncSnapshot<List<MovieListModel>> snapshot,
    double width,
  ) {
    return ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          var movie = snapshot.data![index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(
                      id: movie.id,
                      posterPath: movie.posterPath,
                    ),
                  ));
            },
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              width: width,
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemCount: snapshot.data!.length);
  }
}
