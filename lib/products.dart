import 'package:flutter/cupertino.dart';
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

  updateList(int id, String name) {
    for (var element in products) {
      if (element.getId == id) {
        element.setName = name;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) => Dismissible(
                key: ValueKey(products[index].getId),
                onDismissed: (direction) {
                  setState(() => {products.removeAt(index)});
                },
                child: Product(
                  productName: products[index].getName,
                  valueInList: products[index].getId,
                  focusOnInit: products[index].getFocus,
                  updateFunc: updateList,
                ))),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() => products.add(ProductItem("", 0.0, DateTime.now())));
        },
        backgroundColor: Colors.white,
        child: const Icon(Icons.add, color: Colors.black, size: 40),
      ),
    );
  }
}

class Product extends StatefulWidget {
  const Product(
      {Key? key,
      required this.productName,
      required this.focusOnInit,
      required this.valueInList,
      required this.updateFunc})
      : super(key: key);

  final String productName;
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
  bool changeName = false;
  FocusNode myFocusNode = FocusNode();
  final myController = TextEditingController();

  @override
  void initState() {
    super.initState();
    myController.text = widget.productName;
    if (widget.focusOnInit == true) {
      setState(() => {
            changeName = true,
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
                    border: Border.all(color: Colors.green),
                    borderRadius: BorderRadius.circular(45)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 14.0, right: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                          child: Column(
                        children: [
                          SingleChildScrollView(
                              keyboardDismissBehavior:
                                  ScrollViewKeyboardDismissBehavior.onDrag,
                              child: TextField(
                                controller: myController,
                                minLines: 1,
                                maxLines: 3,
                                maxLength: 45,
                                focusNode: myFocusNode,
                                enabled: changeName,
                                textAlignVertical: TextAlignVertical.center,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 26,
                                ),
                                decoration: const InputDecoration(
                                  hintText: "Product name:",
                                  border: InputBorder.none,
                                  counterText: "",
                                ),
                                onChanged: (text) =>
                                    widget.updateFunc(widget.valueInList, text),
                              )),
                        ],
                      )),
                      SizedBox(
                          width: 40,
                          child: ElevatedButton(
                              onPressed: () {
                                setState(() => {
                                      changeName = !changeName,
                                      if (changeName == true)
                                        Future.delayed(
                                            const Duration(milliseconds: 20),
                                            () => FocusScope.of(context)
                                                .requestFocus(myFocusNode))
                                    });
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                elevation: 0.0,
                                shadowColor: Colors.transparent,
                                onPrimary: Colors.green,
                                padding: const EdgeInsets.only(right: 5),
                              ),
                              child: const Icon(CupertinoIcons.pencil,
                                  size: 40, color: Colors.black))),
                      // SizedBox(
                      //     width: 40,
                      //     child: ElevatedButton(
                      //         onPressed: () {},
                      //         style: ElevatedButton.styleFrom(
                      //           primary: Colors.white,
                      //           elevation: 0.0,
                      //           shadowColor: Colors.transparent,
                      //           onPrimary: Colors.green,
                      //           padding: const EdgeInsets.only(right: 20),
                      //         ),
                      //         child: const Icon(Icons.delete,
                      //             size: 40, color: Colors.red))),
                    ],
                  ),
                ))));
  }
}
