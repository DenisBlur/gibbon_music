class MixModel {
  final String? title;
  final String? url;
  final String? urlScheme;
  final String? textColor;
  final String? backgroundColor;
  final String? backgroundImageUri;
  final String? coverWhite;

  MixModel(this.title, this.url, this.urlScheme, this.textColor, this.backgroundColor, this.backgroundImageUri, this.coverWhite);

  static MixModel fromMap(Map<String, dynamic> map) {
    MixModel mixModelBean = MixModel(
     map['title'],
     map['url'],
     map['urlScheme'],
     map['textColor'],
     map['backgroundColor'],
     map['backgroundImageUri'],
     map['coverWhite'],
    );
    return mixModelBean;
  }

  Map toJson() => {
    "title": title,
    "url": url,
    "urlScheme": urlScheme,
    "textColor": textColor,
    "backgroundColor": backgroundColor,
    "backgroundImageUri": backgroundImageUri,
    "coverWhite": coverWhite,
  }..removeWhere((k,v)=>v==null);
}