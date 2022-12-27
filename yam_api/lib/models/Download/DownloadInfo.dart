import '../InvocationInfoBean.dart';

/// invocationInfo : {"req-id":"1652449125883807-11004117104061394942","hostname":"music-stable-back-vla-56.vla.yp-c.yandex.net","exec-duration-millis":1}
/// result : [{"codec":"mp3","gain":false,"preview":true,"downloadInfoUrl":"https://storage.mds.yandex.net/file-download-info/21196_079997da.86879642.13.58511192/preview?sign=ea5132fd4f977e9afdfc499288ca87d90576db0998224f7bdbafb3423bc3a773&ts=627e5fa1&offset=5335","direct":false,"bitrateInKbps":128}]

class DownloadInfoModel {
  final InvocationInfoBeanInt? invocationInfo;
  final List<ResultBean>? result;

  DownloadInfoModel(this.invocationInfo, this.result);

  static DownloadInfoModel fromMap(Map<String, dynamic> map) {
    DownloadInfoModel modelBean = DownloadInfoModel(
      map['invocationInfo']!=null ? InvocationInfoBeanInt.fromMap(map['invocationInfo']) : null,
      map['result']!=null ? ([...(map['result'] as List).map((o) => ResultBean.fromMap(o))]) : null,
    );
    return modelBean;
  }

  Map toJson() => {
    "invocationInfo": invocationInfo?.toJson(),
    "result": result?.map((o)=>o.toJson()).toList(growable: false),
  }..removeWhere((k,v)=>v==null);
}

/// codec : "mp3"
/// gain : false
/// preview : true
/// downloadInfoUrl : "https://storage.mds.yandex.net/file-download-info/21196_079997da.86879642.13.58511192/preview?sign=ea5132fd4f977e9afdfc499288ca87d90576db0998224f7bdbafb3423bc3a773&ts=627e5fa1&offset=5335"
/// direct : false
/// bitrateInKbps : 128

class ResultBean {
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