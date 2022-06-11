import 'dart:math';

import 'package:flutter/material.dart';
import 'package:frigider_virtual/models/product_item.dart';

class MyProductsPage extends StatefulWidget {
  const MyProductsPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MyProductsPageState();
  }
}

class _MyProductsPageState extends State<MyProductsPage> {
  final List<ProductItem> products = <ProductItem>[];

  updateList(int id, String name, String quantity, DateTime expire) {
    for (var element in products) {
      if (element.getId == id) {
        element.setName = name;
        element.setQuantity = quantity;
        element.setExpireDate = expire;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
          body: Container(
            alignment: Alignment.center,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  Color(0x665ac18e),
                  Color(0x995ac18e),
                  Color(0xcc5ac18e),
                  Color(0xff5ac18e),
                ])),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Padding(
                      padding: EdgeInsets.only(top: 50.0),
                      child: Text("Products",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 60,
                              fontWeight: FontWeight.bold,
                              color: Colors.white60))),
                  // Product(
                  //     productName: "Banane",
                  //     quantity: "2",
                  //     expireDate: DateTime.now(),
                  //     focusOnInit: false,
                  //     valueInList: 100,
                  //     updateFunc: updateList),
                  Expanded(
                      child: ListView.builder(
                          itemCount: products.length,
                          itemBuilder: (context, index) => Dismissible(
                              key: ValueKey(products[index].getId),
                              onDismissed: (direction) {
                                setState(() => {products.removeAt(index)});
                              },
                              child: Product(
                                productName: products[index].getName,
                                quantity: products[index].getQuantity,
                                expireDate: products[index].getExpireDate,
                                valueInList: products[index].getId,
                                focusOnInit: products[index].getFocus,
                                updateFunc: updateList,
                              ))))
                ]),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              setState(
                  () => products.add(ProductItem("", "1", DateTime.now())));
            },
            backgroundColor: Colors.white,
            child: const Icon(Icons.add, color: Colors.black, size: 40),
          ),
        ));
  }
}

class Product extends StatefulWidget {
  const Product(
      {Key? key,
      required this.productName,
        required this.quantity,
      required this.expireDate,
      required this.focusOnInit,
      required this.valueInList,
      required this.updateFunc})
      : super(key: key);

  final String productName;
  final String quantity;
  final DateTime expireDate;
  final bool focusOnInit;
  final int valueInList;
  final Function updateFunc;

  int get getValueInList {
    return valueInList;
  }

  @override
  State<StatefulWidget> createState() {
    return _ProductState();
  }
}

class _ProductState extends State<Product> {
  FocusNode myFocusNode = FocusNode();
  final myController = TextEditingController();
  final myQuantityController = TextEditingController();
  late DateTime expireDate;

  @override
  void initState() {
    super.initState();
    myController.text = widget.productName;
    myQuantityController.text = widget.quantity;
    expireDate = widget.expireDate;
    if (widget.focusOnInit == true) {
      setState(() => {
            Future.delayed(const Duration(milliseconds: 20),
                () => FocusScope.of(context).requestFocus(myFocusNode))
          });
    }
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 6),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.circular(45)),
              child: Padding(
                  padding: const EdgeInsets.only(left: 14.0, right: 12.0),
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(
                            width: 60,
                            child: Icon(Icons.food_bank,
                                size: 40, color: Colors.blue)),
                        Expanded(
                            child: Padding(
                                padding: const EdgeInsets.only(left: 0.0),
                                child: SingleChildScrollView(
                                    keyboardDismissBehavior:
                                        ScrollViewKeyboardDismissBehavior
                                            .onDrag,
                                    child: TextField(
                                      controller: myController,
                                      minLines: 1,
                                      maxLines: 3,
                                      maxLength: 45,
                                      focusNode: myFocusNode,
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 26,
                                      ),
                                      decoration: const InputDecoration(
                                        hintText: "Product name",
                                        border: InputBorder.none,
                                        counterText: "",
                                      ),
                                      onChanged: (text) => widget.updateFunc(
                                          widget.valueInList, text, myQuantityController.text, expireDate),
                                    )))),
                      ],
                    ),
                    Row(children: [
                      const SizedBox(
                          width: 60,
                          child: Icon(Icons.shopping_bag,
                              size: 40, color: Colors.blue)),
                      Expanded(
                          child: Padding(
                              padding: const EdgeInsets.only(left: 0.0),
                              child: SingleChildScrollView(
                                  keyboardDismissBehavior:
                                      ScrollViewKeyboardDismissBehavior.onDrag,
                                  child: TextField(
                                    controller: myQuantityController,
                                    minLines: 1,
                                    textAlignVertical: TextAlignVertical.center,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 26,
                                    ),
                                    decoration: const InputDecoration(
                                      hintText: "1 kg",
                                      border: InputBorder.none,
                                      counterText: "",
                                    ),
                                    onChanged: (text) => widget.updateFunc(
                                        widget.valueInList, myController.text, text, expireDate),
                                  )))),
                      const SizedBox(
                          width: 40,
                          child: Icon(Icons.schedule,
                              size: 40, color: Colors.blue)),
                      Text('${expireDate.day}/${expireDate.month}/${expireDate.year}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      )),
                      ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: const BorderSide(color: Colors.red)
                                  )
                              )
                          ),
                          onPressed: () async {
                            DateTime? newDate = await showDatePicker(
                                context: context,
                                initialDate: expireDate,
                                firstDate: DateTime(
                                    min(DateTime.now().year, expireDate.year)),
                                lastDate: DateTime(DateTime.now().year + 5,
                                    DateTime.now().month, DateTime.now().day));

                            if (newDate != null) {
                              setState(() => {expireDate = newDate});
                              widget.updateFunc(widget.valueInList, myController.text, myQuantityController.text, expireDate);
                            }
                          },
                          child: const Text("PICK")),
                    ])
                  ])),
            )));
  }
}
