class CartModel {
  final int? id;
  final String? itemType;
  final int? itemId;
  final String? itemName;
  final Service? service;
  final int? serviceFrequencyId;
  final String? serviceFrequencyName;
  final int? quantity;
  final int? providersCount;
  final int? includeMaterial;
  final List<int>? selectedAddons;
  final String? basePrice;
  final String? addonsPrice;
  final String? unitPrice;
  final String? totalPrice;
  final int? allowIncrement;
  CartModel({
    this.id,
    this.itemType,
    this.itemId,
    this.itemName,
    this.service,
    this.serviceFrequencyId,
    this.serviceFrequencyName,
    this.quantity,
    this.providersCount,
    this.includeMaterial,
    this.selectedAddons,
    this.basePrice,
    this.addonsPrice,
    this.unitPrice,
    this.totalPrice,
    this.allowIncrement,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'],
      itemType: json['item_type'],
      itemId: json['item_id'],
      itemName: json['item_name'],
      service:
          json['service'] != null ? Service.fromJson(json['service']) : null,
      serviceFrequencyId: json['service_frequency_id'],
      serviceFrequencyName: json['service_frequency_name'],
      quantity: json['quantity'],
      providersCount: json['providers_count'],
      includeMaterial: json['include_material'],
      selectedAddons:
          json['selected_addons'] != null
              ? List<int>.from(json['selected_addons'])
              : [],
      basePrice: json['base_price'],
      addonsPrice: json['addons_price'],
      unitPrice: json['unit_price'],
      totalPrice: json['total_price'],
      allowIncrement: json['allow_increment'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'item_type': itemType,
      'item_id': itemId,
      'item_name': itemName,
      'service': service?.toJson(),
      'service_frequency_id': serviceFrequencyId,
      'service_frequency_name': serviceFrequencyName,
      'quantity': quantity,
      'providers_count': providersCount,
      'include_material': includeMaterial,
      'selected_addons': selectedAddons,
      'base_price': basePrice,
      'addons_price': addonsPrice,
      'unit_price': unitPrice,
      'total_price': totalPrice,
      'allow_increment': allowIncrement,
    };
  }

  // ✅ Add copyWith method
  CartModel copyWith({
    int? id,
    String? itemType,
    int? itemId,
    String? itemName,
    Service? service,
    int? serviceFrequencyId,
    String? serviceFrequencyName,
    int? quantity,
    int? providersCount,
    int? includeMaterial,
    List<int>? selectedAddons,
    String? basePrice,
    String? addonsPrice,
    String? unitPrice,
    String? totalPrice,
    int? allowIncrement,
  }) {
    return CartModel(
      id: id ?? this.id,
      itemType: itemType ?? this.itemType,
      itemId: itemId ?? this.itemId,
      itemName: itemName ?? this.itemName,
      service: service ?? this.service,
      serviceFrequencyId: serviceFrequencyId ?? this.serviceFrequencyId,
      serviceFrequencyName: serviceFrequencyName ?? this.serviceFrequencyName,
      quantity: quantity ?? this.quantity,
      providersCount: providersCount ?? this.providersCount,
      includeMaterial: includeMaterial ?? this.includeMaterial,
      selectedAddons: selectedAddons ?? this.selectedAddons,
      basePrice: basePrice ?? this.basePrice,
      addonsPrice: addonsPrice ?? this.addonsPrice,
      unitPrice: unitPrice ?? this.unitPrice,
      totalPrice: totalPrice ?? this.totalPrice,
      allowIncrement: allowIncrement ?? this.allowIncrement,
    );
  }
}

class Service {
  final int? id;
  final String? name;
  final String? description;
  final String? image;

  Service({this.id, this.name, this.description, this.image});

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'description': description, 'image': image};
  }

  Service copyWith({
    int? id,
    String? name,
    String? description,
    String? image,
  }) {
    return Service(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      image: image ?? this.image,
    );
  }
}
