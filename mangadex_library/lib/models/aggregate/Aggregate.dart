class Aggregate {
  late final String result;
  late final List<Volume> volumes;
  Aggregate({required this.result, required this.volumes});
  Aggregate.fromJson(Map<String, dynamic> json) {
    result = json['result'] ?? '';
    volumes = <Volume>[];
    if (json['volumes'] != null) {
      json['volumes'].forEach((s, e) {
        volumes.add(Volume.fromJson(e));
      });
    } else {
      print('null json xdxdxd');
    }
  }
}

class Volume {
  late final String volume;
  late final int count;
  late final Map<String, ChapterInfo> chapters;
  Volume(this.volume, this.count, this.chapters);
  Volume.fromJson(Map<String, dynamic> json) {
    volume = json['volume'] ?? '';
    count = json['count'] ?? 0;
    chapters = {};
    if (json['chapters'] != null) {
      json['chapters'].keys.forEach((key) {
        chapters[key] = ChapterInfo.fromJson(json['chapters'][key]);
      });
    }
  }
}

class ChapterInfo {
  late final String chapter;
  late final String id;
  late final List<String> others;
  late final int count;
  ChapterInfo(
      {required this.chapter,
      required this.id,
      required this.others,
      required this.count});
  ChapterInfo.fromJson(Map<String, dynamic> json) {
    chapter = json['chapter'] ?? '';
    id = json['id'] ?? '';
    others = [];
    if (json['others'] != null) {
      json['others'].forEach((e) {
        others.add(e);
      });
    }
    count = json['count'] ?? '';
  }
}
