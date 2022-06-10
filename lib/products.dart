import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyProductsPage extends StatefulWidget {
  const MyProductsPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MyProductsPageState();
  }
}

class _MyProductsPageState extends State<MyProductsPage> {
  int maximum = 0;
  List<Product> products = <Product>[];

  deleteFromList(int index) {
    setState(() =>
        {products.removeWhere((element) => element.getValueInList == index)});
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
        child: Column(
          children: products,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          maximum++;
          setState(() => {
                products.add(Product(
                    productName: "",
                    focusOnInit: true,
                    valueInList: maximum,
                    deleteFunc: deleteFromList))
              });
        },
        backgroundColor: Colors.white,
        child: const Icon(Icons.add, color: Colors.black, size: 40),
      ),
    );
  }
}

class Product extends StatefulWidget {
  Product(
      {Key? key,
      required this.productName,
      required this.focusOnInit,
      required this.valueInList,
      required this.deleteFunc})
      : super(key: key);

  String productName;
  bool focusOnInit;
  int valueInList;
  Function deleteFunc;

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

  @override
  void initState() {
    super.initState();
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
                              child: TextFormField(
                                  initialValue: widget.productName,
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
                                  ))),
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
                      SizedBox(
                          width: 40,
                          child: ElevatedButton(
                              onPressed: () {
                                setState(() =>
                                    {widget.deleteFunc(widget.valueInList)});
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                elevation: 0.0,
                                shadowColor: Colors.transparent,
                                onPrimary: Colors.green,
                                padding: const EdgeInsets.only(right: 20),
                              ),
                              child: const Icon(Icons.delete,
                                  size: 40, color: Colors.red))),
                    ],
                  ),
                ))));
  }
}
