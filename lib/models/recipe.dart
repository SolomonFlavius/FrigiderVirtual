import 'package:cloud_firestore/cloud_firestore.dart';

class Ingredients {
  int? id;
  late String name;
  int? quantity;
  late String quantityMeasure;

  String get getName {
    return name;
  }

  String get getQuantityMeasure {
    return quantityMeasure;
  }

  int? get getQuantity {
    return quantity;
  }

  set setName(String name) {
    this.name = name;
  }

  set setQuantityMeasuree(String quantityMeasure) {
    this.quantityMeasure = quantityMeasure;
  }

  set setQuantity(int quantity) {
    this.quantity = quantity;
  }
}

class Recipe {
  String? id;
  String name;
  String description;
  int? preparationTime;
  Timestamp? createdAt;
  Timestamp? updatedAt;
  List<Ingredients> ingredients;

  Recipe(this.name, this.description, this.preparationTime, this.createdAt,
      this.updatedAt, this.ingredients) {}

  String? get getId {
    return id;
  }

  String get getName {
    return name;
  }

  List<Ingredients> get getIngredients {
    return ingredients;
  }

  int? get getPreparationTime {
    return preparationTime;
  }

  String get getDescription {
    return description;
  }

  Timestamp? get getCreatedAt {
    return createdAt;
  }

  Timestamp? get getUpdatedAt {
    return updatedAt;
  }

  set setName(String name) {
    this.name = name;
  }

  set setDescription(String description) {
    this.description = description;
  }

  set setCreatedAt(Timestamp createdAt) {
    this.createdAt = createdAt;
  }

  set setUpdatedAt(Timestamp updatedAt) {
    this.updatedAt = updatedAt;
  }
}
