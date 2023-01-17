class QueuesList {
  QueuesList({
      this.queues,});

  QueuesList.fromJson(dynamic json) {
    if (json['queues'] != null) {
      queues = [];
      json['queues'].forEach((v) {
        queues?.add(Queues.fromJson(v));
      });
    }
  }
  List<Queues>? queues;
QueuesList copyWith({  List<Queues>? queues,
}) => QueuesList(  queues: queues ?? this.queues,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (queues != null) {
      map['queues'] = queues?.map((v) => v.toJson()).toList();
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
  String? id;
  Context? context;
  InitialContext? initialContext;
  String? modified;
Queues copyWith({  String? id,
  Context? context,
  InitialContext? initialContext,
  String? modified,
}) => Queues(  id: id ?? this.id,
  context: context ?? this.context,
  initialContext: initialContext ?? this.initialContext,
  modified: modified ?? this.modified,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    if (context != null) {
      map['context'] = context?.toJson();
    }
    if (initialContext != null) {
      map['initialContext'] = initialContext?.toJson();
    }
    map['modified'] = modified;
    return map;
  }

}

class InitialContext {
  InitialContext({
      this.description, 
      this.login, 
      this.id, 
      this.type,});

  InitialContext.fromJson(dynamic json) {
    description = json['description'];
    login = json['login'];
    id = json['id'];
    type = json['type'];
  }
  String? description;
  String? login;
  String? id;
  String? type;
InitialContext copyWith({  String? description,
  String? login,
  String? id,
  String? type,
}) => InitialContext(  description: description ?? this.description,
  login: login ?? this.login,
  id: id ?? this.id,
  type: type ?? this.type,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['description'] = description;
    map['login'] = login;
    map['id'] = id;
    map['type'] = type;
    return map;
  }

}

class Context {
  Context({
      this.description, 
      this.login, 
      this.id, 
      this.type,});

  Context.fromJson(dynamic json) {
    description = json['description'];
    login = json['login'];
    id = json['id'];
    type = json['type'];
  }
  String? description;
  String? login;
  String? id;
  String? type;
Context copyWith({  String? description,
  String? login,
  String? id,
  String? type,
}) => Context(  description: description ?? this.description,
  login: login ?? this.login,
  id: id ?? this.id,
  type: type ?? this.type,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['description'] = description;
    map['login'] = login;
    map['id'] = id;
    map['type'] = type;
    return map;
  }

}