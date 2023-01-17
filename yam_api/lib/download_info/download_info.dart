class DownloadInfo {
  final List<ResultBean>? result;

  DownloadInfo(this.result);

  static DownloadInfo fromMap(Map<String, dynamic> map) {
    DownloadInfo modelBean = DownloadInfo(
      map['result']!=null ? ([...(map['result'] as List).map((o) => ResultBean.fromMap(o))]) : null,
    );
    return modelBean;
  }

  Map toJson() => {
    "result": result?.map((o)=>o.toJson()).toList(growable: false),
  }..removeWhere((k,v)=>v==null);
}

class ResultBean  {
  final String? codec;
  final bool? gain;
  final bool? preview;
  final String? downloadInfoUrl;
  final bool? direct;
  final int? bitrateInKbps;

  ResultBean(this.codec, this.gain, this.preview, this.downloadInfoUrl, this.direct, this.bitrateInKbps);

  static ResultBean fromMap(Map<String, dynamic> map) {
    ResultBean resultBean = ResultBean(
      map['codec'],
      map['gain'],
      map['preview'],
      map['downloadInfoUrl'],
      map['direct'],
      map['bitrateInKbps'],
    );
    return resultBean;
  }

  Map toJson() => {
    "codec": codec,
    "gain": gain,
    "preview": preview,
    "downloadInfoUrl": downloadInfoUrl,
    "direct": direct,
    "bitrateInKbps": bitrateInKbps,
  }..removeWhere((k,v)=>v==null);
}