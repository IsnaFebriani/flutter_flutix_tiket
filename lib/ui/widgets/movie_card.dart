part of 'widgets.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  final Function onTap; //muncul kalau di tap

  MovieCard(this.movie, {this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if (onTap != null) {
            onTap();
          }
        },
        child: Container(
          //background moviecard
          height: 140,
          width: 210,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                  image:
                      NetworkImage(imageBaseUrl + "w780" + movie.backdropPath),
                  fit: BoxFit.cover)),

          child: Container(
            //gradasi moviecard
            height: 140,
            width: 210,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withOpacity(0.61),
                      Colors.black.withOpacity(0)
                    ])),
            child: Column(
              //memuat judul dan rating
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  movie.title,
                  style: whiteTextFont,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                RatingStars(
                  voteAverage: movie.voteAverage,
                )
              ],
            ),
          ),
        ));
  }
}
