class MvPlayContext {

  String id = "";
  String type = "";

  String client = "";
  String context = "";
  String contextItem = "";

  String payloadId = "";
  String kind = "";
  String title = "";
  String description = "";
  String coverUri = "";
  String counts = "";
  String likesCount = "";
  String trackCount = "";
  String year = "";
  List<MvArtist> artists = [];

}

class MvArtist {
  String id = "";
  String name = "";
  String cover = "";
}