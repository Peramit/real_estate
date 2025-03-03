class Property {
  String id;
  String title;
  String location;
  double price;
  int bedrooms;
  int bathrooms;
  int kitchens;
  String type; // เพิ่มฟิลด์ประเภท
  DateTime datePosted;

  Property({
    required this.id,
    required this.title,
    required this.location,
    required this.price,
    required this.bedrooms,
    required this.bathrooms,
    required this.kitchens,
    required this.type,
    required this.datePosted,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'location': location,
      'price': price,
      'bedrooms': bedrooms,
      'bathrooms': bathrooms,
      'kitchens': kitchens,
      'type': type, 
      'datePosted': datePosted.toIso8601String(),
    };
  }

  factory Property.fromMap(Map<String, dynamic> map) {
    return Property(
      id: map['id'],
      title: map['title'],
      location: map['location'],
      price: map['price'],
      bedrooms: map['bedrooms'] ?? 0,
      bathrooms: map['bathrooms'] ?? 0,
      kitchens: map['kitchens'] ?? 0,
      type: map['type'] ?? 'ไม่ระบุ',
      datePosted: DateTime.parse(map['datePosted']),
    );
  }
}
