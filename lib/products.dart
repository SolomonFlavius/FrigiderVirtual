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

  updateList(ProductItem modifiedProduct) {
    for (var element in products) {
      if (element.getId == modifiedProduct.getId) {
        element = modifiedProduct;
        break;
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
                  Product(
                      product: ProductItem("Banane", "1", DateTime.now(), focus: false),
                      updateFunc: updateList
                  ),
                  Expanded(
                      child: ListView.builder(
                          itemCount: products.length,
                          itemBuilder: (context, index) => Dismissible(
                              key: ValueKey(products[index].getId),
                              onDismissed: (direction) {
                                setState(() => {products.removeAt(index)});
                              },
                              child: Product(
                                product: products[index],
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
      required this.product,
      required this.updateFunc})
      : super(key: key);

  final ProductItem product;
  final Function updateFunc;

  @override
  State<StatefulWidget> createState() {
    return _ProductState();
  }
}

class _ProductState extends State<Product> {
  FocusNode myFocusNode = FocusNode();
  final myNameController = TextEditingController();
  final myQuantityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    myNameController.text = widget.product.getName;
    myQuantityController.text = widget.product.getQuantity;
    if (widget.product.getFocus == true) {
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
                                      controller: myNameController,
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
                                      onChanged: (text) => {
                                        widget.product.setName = text,
                                        widget.updateFunc(widget.product)},
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
                                    onChanged: (text) => {
                                      widget.product.setQuantity = text,
                                      widget.updateFunc(widget.product)},
                                  )))),
                    ]),
                    Row(children: [
                      const SizedBox(
                          width: 60,
                          child: Icon(Icons.schedule,
                              size: 40, color: Colors.blue)),
                      const Text("Expiring date: ",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          )),
                      ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: const BorderSide(
                                          color: Colors.red)))),
                          onPressed: () async {
                            DateTime? newDate = await showDatePicker(
                                context: context,
                                initialDate: widget.product.getExpireDate,
                                firstDate: DateTime(
                                    min(DateTime.now().year, widget.product.getExpireDate.year)),
                                lastDate: DateTime(DateTime.now().year + 5,
                                    DateTime.now().month, DateTime.now().day));

                            if (newDate != null) {
                              setState(() => {widget.product.setExpireDate = newDate});
                              widget.updateFunc(widget.product);
                            }
                          },
                          child: Text(
                              '${widget.product.getExpireDate.day}/${widget.product.getExpireDate.month}/${widget.product.getExpireDate.year}'))
                    ])
                  ])),
            )));
  }
}
