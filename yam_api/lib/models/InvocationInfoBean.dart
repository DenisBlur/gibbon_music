class InvocationInfoBeanStr {
  final String? hostname;
  final String? reqId;
  final String? execDurationMillis;

  InvocationInfoBeanStr(this.hostname, this.reqId, this.execDurationMillis);

  static InvocationInfoBeanStr fromMap(Map<String, dynamic> map) {
    InvocationInfoBeanStr invocationInfoBean = InvocationInfoBeanStr(
      map['hostname'],
      map['req-id'],
      map['exec-duration-millis'],
    );
    return invocationInfoBean;
  }

  Map toJson() => {
    "hostname": hostname,
    "req-id": reqId,
    "exec-duration-millis": execDurationMillis,
  }..removeWhere((k,v)=>v==null);
}

class InvocationInfoBeanInt {
  final String? hostname;
  final String? reqId;
  final int? execDurationMillis;

  InvocationInfoBeanInt(this.hostname, this.reqId, this.execDurationMillis);

  static InvocationInfoBeanInt fromMap(Map<String, dynamic> map) {
    InvocationInfoBeanInt invocationInfoBean = InvocationInfoBeanInt(
      map['hostname'],
      map['req-id'],
      map['exec-duration-millis'],
    );
    return invocationInfoBean;
  }

  Map toJson() => {
    "hostname": hostname,
    "req-id": reqId,
    "exec-duration-millis": execDurationMillis,
  }..removeWhere((k,v)=>v==null);
}