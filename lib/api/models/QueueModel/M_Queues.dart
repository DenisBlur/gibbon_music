class MQueues {
  MQueues({
      this.queues,});

  MQueues.fromJson(dynamic json) {
    if (json['queues'] != null) {
      queues = [];
      json['queues'].forEach((v) {
        queues.add(Queues.fromJson(v));
      });
    }
  }
  List<Queues> queues;
MQueues copyWith({  List<Queues> queues,
}) => MQueues(  queues: queues ?? this.queues,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (queues != null) {
      map['queues'] = queues.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Queues {
  Queues({
      this.id, 
      this.context, 
      this.initialContext, 
      this.modified,});

  Queues.fromJson(dynamic json) {
    id = json['id'];
    context = json['context'] != null ? Context.fromJson(json['context']) : null;
    initialContext = json['initialContext'] != null ? InitialContext.fromJson(json['initialContext']) : null;
    modified = json['modified'];
  }
  String id;
  Context context;
  InitialContext initialContext;
  String modified;
Queues copyWith({  String id,
  Context context,
  InitialContext initialContext,
  String modified,
}) => Queues(  id: id ?? this.id,
  context: context ?? this.context,
  initialContext: initialContext ?? this.initialContext,
  modified: modified ?? this.modified,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    if (context != null) {
      map['context'] = context.toJson();
    }
    if (initialContext != null) {
      map['initialContext'] = initialContext.toJson();
    }
    map['modified'] = modified;
    return map;
  }

}

class InitialContext {
  InitialContext({
      this.login, 
      this.id, 
      this.type,});

  InitialContext.fromJson(dynamic json) {
    login = json['login'];
    id = json['id'];
    type = json['type'];
  }
  String login;
  String id;
  String type;
InitialContext copyWith({  String login,
  String id,
  String type,
}) => InitialContext(  login: login ?? this.login,
  id: id ?? this.id,
  type: type ?? this.type,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['login'] = login;
    map['id'] = id;
    map['type'] = type;
    return map;
  }

}

class Context {
  Context({
      this.type,});

  Context.fromJson(dynamic json) {
    type = json['type'];
  }
  String type;
Context copyWith({  String type,
}) => Context(  type: type ?? this.type,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    return map;
  }

}