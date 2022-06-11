class ProductItem {
  static int nextId = 0;
  late int id;
  late bool focus;
  String name;
  String quantity;
  DateTime expires;

  ProductItem(this.name, this.quantity, this.expires, {this.focus = true}){
    id = nextId;
    nextId++;
  }

  int get getId{
    return id;
  }
  bool get getFocus{
    bool lastFocus = focus;
    focus = false;
    return lastFocus;
  }
  String get getName{
    return name;
  }
  String get getQuantity{
    return quantity;
  }
  DateTime get getExpireDate{
    return expires;
  }
  set setName(String name){
    this.name = name;
  }
  set setQuantity(String quantity){
    this.quantity = quantity;
  }
  set setExpireDate(DateTime expires){
    this.expires = expires;
  }
}