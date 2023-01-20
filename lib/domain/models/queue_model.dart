import 'package:darq/darq.dart';
import 'package:event/event.dart';
import 'package:gibbon_music/domain/models/like_model.dart';
import 'package:yam_api/enums.dart';
import 'package:yam_api/track/track.dart';

import '../../main.dart';

class QueueModel {

  Event<QueueSync> onSyncDevice = Event<QueueSync>();

  QueueModel(){
    init();
  }

  String? queueId;

  init() async {
    _getQueueList();
  }

  Future _getQueueList() async {
    await client.getQueuesList().then((value) async {
      var queue = await client.getQueue(queueId: value.queues![0].id.toString());
      List<String?>? tracksIds = queue.tracks?.select((element, _) => element.trackId).toList();
      List<Track?>? tracks = await client.getList(type: ObjectType.track, list: tracksIds);
      //onSyncDevice.broadcast(QueueSync(tracks, queue.currentIndex!.toInt()));
      ///TODO:реализовать в будущем
      //createQueue(tracks, queue.currentIndex!.toInt(), "album", ObjectType.album);
    });
  }

  Future createQueue(List<Track?>? tracks, int currentIndex, String objectId, ObjectType type) async {
    var result = await client.createQueue(tracks, currentIndex, objectId, type);
    print(result);
  }

}

class QueueSync extends EventArgs {
  List<Track?>? tracks;
  int? currentIndex;

  QueueSync(this.tracks, this.currentIndex);
}