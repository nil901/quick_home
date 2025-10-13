class HomeModel {
  List<Section> sections;

  HomeModel({required this.sections});

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    var list = json['sections'] as List? ?? [];
    List<Section> sectionsList = list.map((e) => Section.fromJson(e)).toList();
    return HomeModel(sections: sectionsList);
  }

  Map<String, dynamic> toJson() => {
    'sections': sections.map((e) => e.toJson()).toList(),
  };
}

class Section {
  String title;
  ItemsWrapper items;

  Section({required this.title, required this.items});

  factory Section.fromJson(Map<String, dynamic> json) {
    return Section(
      title: json['title'] ?? '',
      items: ItemsWrapper.fromJson(json['items']),
    );
  }

  Map<String, dynamic> toJson() => {'title': title, 'items': items.toJson()};
}

class ItemsWrapper {
  List<Item> items;

  ItemsWrapper({required this.items});

  factory ItemsWrapper.fromJson(Map<String, dynamic> json) {
    var list = json['items'] as List? ?? [];
    List<Item> itemList = list.map((e) => Item.fromJson(e)).toList();
    return ItemsWrapper(items: itemList);
  }

  Map<String, dynamic> toJson() => {
    'items': items.map((e) => e.toJson()).toList(),
  };
}

class Item {
  int id;
  int categoryId;
  int subcategoryId;
  String name;
  String description;

  String imageUrl;

  Item({
    required this.id,
    required this.categoryId,
    required this.subcategoryId,
    required this.name,
    required this.description,

    required this.imageUrl,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'] ?? 0,
      categoryId: json['category_id'] ?? 0,
      subcategoryId: json['subcategory_id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',

      imageUrl: json['image_url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'category_id': categoryId,
    'subcategory_id': subcategoryId,
    'name': name,

    'image_url': imageUrl,
  };
}
