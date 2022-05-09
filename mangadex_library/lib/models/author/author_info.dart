class AuthorInfo {
  late String result;
  late String response;
  late Data data;
  late List<Relationship> relationships;
  AuthorInfo(this.result, this.response, this.data);
  AuthorInfo.fromJson(Map<String, dynamic> json) {
    result = json['result'] ?? '';
    response = json['response'] ?? '';
    if (json['data'] != null) {
      data = Data.fromJson(json['data']);
    }
    relationships = [];
    if (json['relationships'] != null) {
      json['relationships'].forEach((e) {
        relationships.add(Relationship.fromJson(json['relationships']));
      });
    }
  }
}

class Data {
  late String id;
  late String type;
  late Attributes attributes;
  Data(this.id, this.type, this.attributes);
  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    if (json['attributes'] != null) {
      attributes = Attributes.fromJson(json['attributes']);
    }
  }
}

class Attributes {
  late String name;
  late String? imageUrl;
  late List<String> biography;
  late String twitter;
  late String pixiv;
  late String melonBook;
  late String fanBox;
  late String booth;
  late String nicoVideo;
  late String skeb;
  late String fantia;
  late String tumblr;
  late String youtube;
  late String weibo;
  late String naver;
  late String website;
  late String createdAt;
  late String updateAt;
  late int version;
  Attributes(
      this.name,
      this.imageUrl,
      this.biography,
      this.twitter,
      this.pixiv,
      this.melonBook,
      this.fanBox,
      this.booth,
      this.nicoVideo,
      this.skeb,
      this.fantia,
      this.tumblr,
      this.youtube,
      this.weibo,
      this.naver,
      this.website,
      this.createdAt,
      this.updateAt,
      this.version);

  Attributes.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? '';
    imageUrl = json['imageUrl'] ?? '';
    biography = json['biography'] ?? '';
    twitter = json['twitter'] ?? '';
    pixiv = json['pixiv'] ?? '';
    melonBook = json['melonBook'] ?? '';
    fanBox = json['fanBox'] ?? '';
    booth = json['booth'] ?? '';
    nicoVideo = json['nicoVideo'] ?? '';
    skeb = json['skeb'] ?? '';
    fantia = json['fantia'] ?? '';
    tumblr = json['tumblr'] ?? '';
    youtube = json['youtube'] ?? '';
    weibo = json['weibo'] ?? '';
    naver = json['naver'] ?? '';
    website = json['website'] ?? '';
    createdAt = json['createdAt'] ?? '';
    updateAt = json['updateAt'] ?? '';
    version = json[version] ?? 0;
  }
}

class Relationship {
  late String id;
  late String type;
  Relationship(this.id, this.type);
  Relationship.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    type = json['type'] ?? '';
  }
}
