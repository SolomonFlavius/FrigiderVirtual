class ProductItem {
  static int nextId = 0;
  late int id;
  late bool focus;
  String name;
  String description;
  late double quantity;
  String measurement;
  late double amount;
  late bool showAmount;
  String category;
  DateTime expires;
  DateTime purchased;
  bool isExpanded;

  ProductItem(this.name, this.description, String quantity, this.measurement,
      String amount, this.category, this.expires, this.purchased,
      {this.focus = true, this.isExpanded = true}) {
    id = nextId;
    nextId++;
    this.quantity = double.parse(quantity);
    if (amount.compareTo("") == 0) {
      this.amount = 1;
      showAmount = false;
    } else {
      this.amount = double.parse(amount);
      showAmount = true;
    }
  }

  int get getId {
    return id;
  }

  bool get getFocus {
    bool lastFocus = focus;
    focus = false;
    return lastFocus;
  }

  String get getName {
    return name;
  }

  String get getDescription {
    return description;
  }

  String get getQuantity {
    return quantity.toString();
  }

  String get getMeasurement {
    return measurement;
  }

  String get getAmount {
    if(showAmount == true) {
      return amount.toString();
    } else {
      return "";
    }
  }

  String get getCategory{
    return category;
  }

  DateTime get getExpireDate {
    return expires;
  }

  DateTime get getPurchaseDate {
    return purchased;
  }

  bool get getIsExpanded {
    return isExpanded;
  }

  set setName(String name) {
    this.name = name;
  }

  set setDescription(String description) {
    this.description = description;
  }

  set setQuantity(String quantity) {
    this.quantity = double.parse(quantity);
  }

  set setMeasurement(String measurement) {
    this.measurement = measurement;
  }

  set setAmount(String amount) {
    if (amount.compareTo("") == 0) {
      this.amount = 1;
      showAmount = false;
    } else {
      this.amount = double.parse(amount);
      showAmount = true;
    }
  }

  set setCategory(String category) {
    this.category = category;
  }

  set setExpireDate(DateTime expires) {
    this.expires = expires;
  }

  set setPurchaseDate(DateTime purchased) {
    this.purchased = purchased;
  }

  set setIsExpanded(bool isExpanded) {
    this.isExpanded = isExpanded;
  }
}
