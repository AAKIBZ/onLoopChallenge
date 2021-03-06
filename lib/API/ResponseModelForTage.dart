class Autogenerated {
  late List<Tags_Chip> tags;

  Autogenerated({required this.tags});

  Autogenerated.fromJson(Map<String, dynamic> json) {
    if (json['tags'] != null) {
      tags =
          new List<Tags_Chip>.filled(0, Tags_Chip(name: '', color: ''), growable: true);
      json['tags'].forEach((v) {
        tags.add(new Tags_Chip.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.tags != null) {
      data['tags'] = this.tags.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Tags_Chip {
  late String name;
  late String color;

  Tags_Chip({required this.name, required this.color});

  Tags_Chip.fromJson(Map<String, dynamic> json) {
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
