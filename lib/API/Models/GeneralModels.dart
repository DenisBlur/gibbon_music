class MvAlbum {

  String id;
  String year;
  String trackCount;
  String likesCount;

  String title;
  String releaseDate;
  String coverUri;
  String genre;

  String recent;

  List<MvArtist> artists;
  List<String> bests;

}

class MvArtist {
  String id = "";
  String name = "";
  String cover = "";
}

class MvChart {

  String position;
  String listeners;
  String shift;

  String progress;
}

