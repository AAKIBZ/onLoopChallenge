class TagsModel {
  late List<LearnContent> learnContent;

  TagsModel({required this.learnContent});

  TagsModel.fromJson(Map<String, dynamic> json) {
    if (json['learn_content'] != null) {
      learnContent = new List<LearnContent>.filled(
          0,
          LearnContent(
              createdAt: '',
              type: '',
              title: '',
              description: '',
              thumbnailUrl: '',
              contentUrl: '',
              tags: []),growable: false);
      json['learn_content'].forEach((v) {
        learnContent.add(new LearnContent.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.learnContent != null) {
      data['learn_content'] = this.learnContent.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LearnContent {
  late String createdAt;
  late String type;
  late String title;
  late String description;
  late String thumbnailUrl;
  late String contentUrl;
  late List<Tags> tags;

  LearnContent(
      {required this.createdAt,
      required this.type,
      required this.title,
      required this.description,
      required this.thumbnailUrl,
      required this.contentUrl,
      required this.tags});

  LearnContent.fromJson(Map<String, dynamic> json) {
    createdAt = json['created_at'];
    type = json['type'];
    title = json['title'];
    description = json['description'];
    thumbnailUrl = json['thumbnail_url'];
    contentUrl = json['content_url'];
    if (json['tags'] != null) {
      tags = new List.of(List<Tags>.filled(0, Tags(color: '', name: ''), growable: true));
      json['tags'].forEach((v) {
        tags.add(new Tags.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['created_at'] = this.createdAt;
    data['type'] = this.type;
    data['title'] = this.title;
    data['description'] = this.description;
    data['thumbnail_url'] = this.thumbnailUrl;
    data['content_url'] = this.contentUrl;
    if (this.tags != null) {
      data['tags'] = this.tags.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Tags {
  late String name;
  late String color;

  Tags({required this.name, required this.color});

  Tags.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['color'] = this.color;
    return data;
  }
}
