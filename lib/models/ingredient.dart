class Ingredient {
  String? id;
  String name;
  int quantity;
  String quantityMeasure;

  Ingredient(
    this.id,
    this.name,
    this.quantity,
    this.quantityMeasure,
  );

  factory Ingredient.fromMap(Map<String, dynamic>? map) {
    return Ingredient(
      map!['id'] as String?,
      map['name'] as String,
      map['quantity'] as int,
      map['quantity_measure'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'quantity_measure': quantityMeasure,
    };
  }

  Map<String, dynamic> toMapWithoutId() {
    return {
      'name': name,
      'quantity': quantity,
      'quantity_measure': quantityMeasure,
    };
  }
}
