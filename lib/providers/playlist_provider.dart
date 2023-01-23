import 'package:event/event.dart';
import 'package:flutter/foundation.dart';
import 'package:gibbon_music/domain/interfaces/iplaylist_loop_strategy.dart';
import 'package:gibbon_music/domain/models/loop_strategy/loop_strategies.dart';
import 'package:gibbon_music/domain/models/playlist.dart';
import 'package:yam_api/track/track.dart';

import 'yandex_provider.dart';

// class PlayListProvider extends ChangeNotifier {
//
//   YandexProvider yandexProvider;
//
//   PlayListProvider(this.yandexProvider)
//   {
//     yandexProvider.queueModel.onSyncDevice.subscribe((args) {
//       setPlaylist(args!.tracks);
//       setCurrentTrack(args.currentIndex!.toInt());
//     });
//   }
//
//   Event onNextTrackPlay = Event();
//   Event onCurrentTrackUpdated = Event();
//
//   bool get shuffled => _playlist.shuffled;
//
//   final Playlist _playlist = Playlist();
//
//   Track? get currentTrack => _playlist.currentTrack;
//
//   IPlaylistLoopStrategy get loopStrategy => _playlist.loopStrategy;
//
//   List<Track?>? get queue => _playlist.queue;
//
//   List<IPlaylistLoopStrategy> loopStrategies = [
//     PlaylistLoopStrategy(),
//   ];
//
//   void _raiseEvent(bool value) {
//     if (value) {
//       // onNextTrackPlay.broadcast();
//       onCurrentTrackUpdated.broadcast();
//     }
//   }
//
//   void end() {
//     _raiseEvent(_playlist.afterTrackEnd());
//     notifyListeners();
//   }
//
//   void next() {
//     _raiseEvent(_playlist.nextTrack());
//     notifyListeners();
//   }
//
//   void previous() {
//     _raiseEvent(_playlist.previousTrack());
//     notifyListeners();
//   }
//
//   void toggleShuffle() {
//     _playlist.shuffle(!shuffled);
//     notifyListeners();
//   }
//
//   void setPlaylist(List<Track?>? tracks) {
//     _playlist.tracks = tracks;
//     onCurrentTrackUpdated.broadcast();
//     notifyListeners();
//   }
//
//   void setCurrentTrack(int index) {
//     _playlist.currentTrackIndex = index;
//     onCurrentTrackUpdated.broadcast();
//     notifyListeners();
//   }
//
//   bool canNext() => _playlist.canNext();
//
//   bool canPrevious() => _playlist.canPrevious();
//
//   void nextLoopStrategy() {
//     //TODO: set
//   }
// }
