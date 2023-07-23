class ImageModel {
  String? provider;
  String? license;
  String? terms;
  String? url;
  Size? size;

  ImageModel({this.provider, this.license, this.terms, this.url, this.size});

  ImageModel.fromJson(Map<String, dynamic> json) {
    provider = json['provider'];
    license = json['license'];
    terms = json['terms'];
    url = json['url'];
    size = json['size'] != null ? Size.fromJson(json['size']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['provider'] = provider;
    data['license'] = license;
    data['terms'] = terms;
    data['url'] = url;
    if (size != null) {
      data['size'] = size!.toJson();
    }
    return data;
  }
}

class Size {
  int? height;
  int? width;

  Size({this.height, this.width});

  Size.fromJson(Map<String, dynamic> json) {
    height = json['height'];
    width = json['width'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['height'] = height;
    data['width'] = width;
    return data;
  }
}
