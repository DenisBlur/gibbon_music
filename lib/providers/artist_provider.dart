import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/api/mainYamFunction.dart';
import 'package:gibbon_music/api/models/PageModels/M_PageArtist.dart';
import 'package:gibbon_music/api/models/PageModels/M_PageDashboard.dart';

class ArtistProvider {
  ArtistProvider();

  Future<void> init(int id) async {
    mPageArtist  = await getArtist(id);
  }

  MPageArtist mPageArtist;
}
