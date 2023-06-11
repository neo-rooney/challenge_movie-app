import 'package:challenge_movie_app/models/movie_detail_model.dart';
import 'package:challenge_movie_app/services/api_service.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  final String posterPath;
  final int id;
  const DetailScreen({
    super.key,
    required this.posterPath,
    required this.id,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<MovieDetailModel> movie;

  String getRunTime(int runtime) {
    int hour = runtime ~/ 60;
    int min = runtime - 60 * hour;
    return '${hour}h ${min}min';
  }

  String getGenres(List<dynamic> genres) {
    var data = genres.map((item) => item['name']).toList().join(', ');
    return data;
  }

  int getRate(double rate) {
    return (rate * 0.5).round();
  }

  @override
  void initState() {
    super.initState();
    movie = ApiService.getToonById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(widget.posterPath),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          title: const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Back to List',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ),
        body: FutureBuilder(
          future: movie,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 50,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    Text(
                      snapshot.data!.title,
                      style: const TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: List.generate(5, (index) {
                        if (index < getRate(snapshot.data!.voteAverage)) {
                          return const Icon(Icons.star, color: Colors.yellow);
                        } else {
                          return const Icon(Icons.star, color: Colors.grey);
                        }
                      }),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      '${getRunTime(snapshot.data!.runtime)} | ${getGenres(snapshot.data!.genres)}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withOpacity(0.8),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      "Storyline",
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      snapshot.data!.overview,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 30,
                            ),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.yellow,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(14), // 원하는 값을 지정
                                ), // 노란색으로 변경
                              ),
                              onPressed: () {},
                              child: const Text(
                                'Buy Ticket',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            return const Text('....');
          },
        ),
      ),
    );
  }
}
