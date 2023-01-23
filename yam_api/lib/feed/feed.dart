import 'day.dart';
import 'generated_playlist.dart';
import 'other.dart';

class Feed {
  Feed({
      this.nextRevision, 
      this.canGetMoreEvents, 
      this.pumpkin, 
      this.isWizardPassed, 
      this.generatedPlaylists, 
      this.headlines, 
      this.today, 
      this.days,});

  Feed.fromJson(dynamic json) {
    nextRevision = json['nextRevision'];
    canGetMoreEvents = json['canGetMoreEvents'];
    pumpkin = json['pumpkin'];
    isWizardPassed = json['isWizardPassed'];
    if (json['generatedPlaylists'] != null) {
      generatedPlaylists = [];
      json['generatedPlaylists'].forEach((v) {
        generatedPlaylists?.add(GeneratedPlaylists.fromJson(v));
      });
    }
    if (json['headlines'] != null) {
      headlines = [];
      json['headlines'].forEach((v) {
        headlines?.add(Headlines.fromJson(v));
      });
    }
    today = json['today'];
    if (json['days'] != null) {
      days = [];
      json['days'].forEach((v) {
        days?.add(Day.fromJson(v));
      });
    }
  }
  String? nextRevision;
  bool? canGetMoreEvents;
  bool? pumpkin;
  bool? isWizardPassed;
  List<GeneratedPlaylists>? generatedPlaylists;
  List<Headlines>? headlines;
  String? today;
  List<Day>? days;
Feed copyWith({  String? nextRevision,
  bool? canGetMoreEvents,
  bool? pumpkin,
  bool? isWizardPassed,
  List<GeneratedPlaylists>? generatedPlaylists,
  List<Headlines>? headlines,
  String? today,
  List<Day>? days,
}) => Feed(  nextRevision: nextRevision ?? this.nextRevision,
  canGetMoreEvents: canGetMoreEvents ?? this.canGetMoreEvents,
  pumpkin: pumpkin ?? this.pumpkin,
  isWizardPassed: isWizardPassed ?? this.isWizardPassed,
  generatedPlaylists: generatedPlaylists ?? this.generatedPlaylists,
  headlines: headlines ?? this.headlines,
  today: today ?? this.today,
  days: days ?? this.days,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['nextRevision'] = nextRevision;
    map['canGetMoreEvents'] = canGetMoreEvents;
    map['pumpkin'] = pumpkin;
    map['isWizardPassed'] = isWizardPassed;
    if (generatedPlaylists != null) {
      map['generatedPlaylists'] = generatedPlaylists?.map((v) => v.toJson()).toList();
    }
    if (headlines != null) {
      map['headlines'] = headlines?.map((v) => v.toJson()).toList();
    }
    map['today'] = today;
    if (days != null) {
      map['days'] = days?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}
