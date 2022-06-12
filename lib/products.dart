import 'dart:math';

import 'package:flutter/material.dart';
import 'package:frigider_virtual/models/product_item.dart';
import 'package:frigider_virtual/services/products_service.dart';

class MyProductsPage extends StatefulWidget {
  const MyProductsPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MyProductsPageState();
  }
}

class _MyProductsPageState extends State<MyProductsPage> {
  final List<ProductItem> products = <ProductItem>[];
  final ProductsService _productsService = ProductsService();

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
                  // Product(
                  //     product: ProductItem("Banane", "", "100", "-", "",
                  //         "Other", DateTime.now(), DateTime.now(),
                  //         focus: false),
                  //     updateFunc: updateList),
                  Expanded(
                      child: ListView.builder(
                          itemCount: products.length + 1,
                          itemBuilder: (context, index) {
                            if (index < products.length) {
                              return Dismissible(
                                  key: ValueKey(products[index].getId),
                                  background: Container(
                                      color: Colors.red,
                                      child: const Icon(Icons.delete_forever,
                                          size: 100)),
                                  onDismissed: (direction) {
                                    setState(() => {products.removeAt(index)});
                                  },
                                  child: Product(
                                    product: products[index],
                                    updateFunc: updateList,
                                  ));
                            } else {
                              return const SizedBox(height: 150);
                            }
                          }))
                ]),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              setState(() => products.add(ProductItem("", "", "100", "-", "",
                  "Other", DateTime.now(), DateTime.now())));
            },
            backgroundColor: Colors.white,
            child: const Icon(Icons.add, color: Colors.black, size: 40),
          ),
        ));
  }
}

class Product extends StatefulWidget {
  const Product({Key? key, required this.product, required this.updateFunc})
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
  final myDescriptionController = TextEditingController();
  final myQuantityController = TextEditingController();
  final myAmountController = TextEditingController();
  bool isExpanded = false;
  var measurement = ['-', 'g', 'kg', 'ml', 'l'];
  var categories = [
    "Other",
    "Dairy",
    "Vegetables",
    "Snacks",
    "Fruits",
    "Bakery",
    "Meat",
    "Pasta",
    "Fish",
    "Condiments",
    "Frozen foods",
    "Beverages",
    "Canned goods"
  ];

  @override
  void initState() {
    super.initState();
    myNameController.text = widget.product.getName;
    myDescriptionController.text = widget.product.getDescription;
    myQuantityController.text = widget.product.getQuantity;
    myAmountController.text = widget.product.getAmount;
    if (widget.product.getIsExpanded == true) {
      setState(() => {isExpanded = true});
    }
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
            child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: ExpansionPanelList(
                  children: [
                    ExpansionPanel(
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return Row(
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
                                            widget.updateFunc(widget.product)
                                          },
                                        )))),
                          ],
                        );
                      },
                      body: Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(
                                    width: 60,
                                    child: Icon(Icons.description,
                                        size: 40, color: Colors.blue)),
                                Expanded(
                                    child: Padding(
                                        padding:
                                        const EdgeInsets.only(left: 0.0),
                                        child: SingleChildScrollView(
                                            keyboardDismissBehavior:
                                            ScrollViewKeyboardDismissBehavior
                                                .onDrag,
                                            child: TextField(
                                              controller:
                                              myDescriptionController,
                                              minLines: 1,
                                              maxLines: 5,
                                              maxLength: 100,
                                              textAlignVertical:
                                              TextAlignVertical.center,
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 26,
                                              ),
                                              decoration: const InputDecoration(
                                                hintText: "Description",
                                                border: InputBorder.none,
                                                counterText: "",
                                              ),
                                              onChanged: (text) => {
                                                widget.product.setDescription =
                                                    text,
                                                widget
                                                    .updateFunc(widget.product)
                                              },
                                            )))),
                              ],
                            ),
                            Row(children: [
                              const SizedBox(
                                  width: 60,
                                  child: Icon(Icons.shopping_bag,
                                      size: 40, color: Colors.blue)),
                              SizedBox(
                                  width: 70,
                                  child: SingleChildScrollView(
                                      keyboardDismissBehavior:
                                      ScrollViewKeyboardDismissBehavior
                                          .onDrag,
                                      child: TextField(
                                        controller: myQuantityController,
                                        keyboardType: TextInputType.number,
                                        minLines: 1,
                                        textAlignVertical:
                                        TextAlignVertical.center,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 26,
                                        ),
                                        decoration: const InputDecoration(
                                          hintText: "1.0",
                                          border: InputBorder.none,
                                          counterText: "",
                                        ),
                                        onChanged: (text) => {
                                          widget.product.setQuantity = text,
                                          widget.updateFunc(widget.product)
                                        },
                                      ))),
                              Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 2.0, color: Colors.blue),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20))),
                                  child: Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: DropdownButton(
                                        value: widget.product.getMeasurement,
                                        icon: const Icon(
                                            Icons.keyboard_arrow_down),
                                        items: measurement.map((String item) {
                                          return DropdownMenuItem(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (String? newValue) {
                                          if (newValue != null) {
                                            setState(() => {
                                              widget.product
                                                  .setMeasurement =
                                                  newValue,
                                              widget.updateFunc(
                                                  widget.product)
                                            });
                                          }
                                        },
                                      ))),
                              const Padding(
                                  padding: EdgeInsets.only(left: 5, right: 5),
                                  child: Text("X",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue,
                                        fontSize: 26,
                                      ))),
                              SizedBox(
                                  width: 100,
                                  child: Padding(
                                      padding: const EdgeInsets.only(left: 0.0),
                                      child: SingleChildScrollView(
                                          keyboardDismissBehavior:
                                          ScrollViewKeyboardDismissBehavior
                                              .onDrag,
                                          child: TextField(
                                            controller: myAmountController,
                                            keyboardType: TextInputType.number,
                                            minLines: 1,
                                            textAlignVertical:
                                            TextAlignVertical.center,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 26,
                                            ),
                                            decoration: const InputDecoration(
                                              hintText: "amount",
                                              border: InputBorder.none,
                                              counterText: "",
                                            ),
                                            onChanged: (text) => {
                                              widget.product.setAmount = text,
                                              widget.updateFunc(widget.product)
                                            },
                                          ))))
                            ]),
                            Row(children: [
                              const SizedBox(
                                  width: 60,
                                  child: Icon(Icons.fastfood,
                                      size: 40, color: Colors.blue)),
                              const Padding(
                                  padding: EdgeInsets.only(right: 8),
                                  child: Text("Category:",
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold))),
                              Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 2.0, color: Colors.blue),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20))),
                                  child: Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: DropdownButton(
                                        value: widget.product.getCategory,
                                        icon: const Icon(
                                            Icons.keyboard_arrow_down),
                                        items: categories.map((String item) {
                                          return DropdownMenuItem(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (String? newValue) {
                                          if (newValue != null) {
                                            setState(() => {
                                              widget.product.setCategory =
                                                  newValue,
                                              widget.updateFunc(
                                                  widget.product)
                                            });
                                          }
                                        },
                                      ))),
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
                                              borderRadius:
                                              BorderRadius.circular(18.0),
                                              side: const BorderSide(
                                                  color: Colors.red)))),
                                  onPressed: () async {
                                    DateTime? newDate = await showDatePicker(
                                        context: context,
                                        initialDate:
                                        widget.product.getExpireDate,
                                        firstDate: DateTime(min(
                                            DateTime.now().year,
                                            widget.product.getExpireDate.year)),
                                        lastDate: DateTime(
                                            DateTime.now().year + 5,
                                            DateTime.now().month,
                                            DateTime.now().day));

                                    if (newDate != null) {
                                      setState(() => {
                                        widget.product.setExpireDate =
                                            newDate
                                      });
                                      widget.updateFunc(widget.product);
                                    }
                                  },
                                  child: Text(
                                      '${widget.product.getExpireDate.day}/${widget.product.getExpireDate.month}/${widget.product.getExpireDate.year}'))
                            ]),
                            Row(children: [
                              const SizedBox(
                                  width: 60,
                                  child: Icon(Icons.schedule,
                                      size: 40, color: Colors.blue)),
                              const Text("Purchased date: ",
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
                                              borderRadius:
                                              BorderRadius.circular(18.0),
                                              side: const BorderSide(
                                                  color: Colors.red)))),
                                  onPressed: () async {
                                    DateTime? newDate = await showDatePicker(
                                        context: context,
                                        initialDate:
                                        widget.product.getPurchaseDate,
                                        firstDate: DateTime(min(
                                            DateTime.now().year,
                                            widget
                                                .product.getPurchaseDate.year)),
                                        lastDate: DateTime(
                                            DateTime.now().year + 5,
                                            DateTime.now().month,
                                            DateTime.now().day));

                                    if (newDate != null) {
                                      setState(() => {
                                        widget.product.setPurchaseDate =
                                            newDate
                                      });
                                      widget.updateFunc(widget.product);
                                    }
                                  },
                                  child: Text(
                                      '${widget.product.getPurchaseDate.day}/${widget.product.getPurchaseDate.month}/${widget.product.getPurchaseDate.year}'))
                            ])
                          ])),
                      isExpanded: isExpanded,
                    )
                  ],
                  expansionCallback: (i, isOpen) => {
                    setState(() {
                      isExpanded = !isOpen;
                      widget.product.setIsExpanded = isExpanded;
                      widget.updateFunc(widget.product);
                    })
                  },
                ))));
  }
}
