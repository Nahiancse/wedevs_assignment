import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:wedevs_assignment/models/productModel.dart';

//fetch function
Future<ProductList> fetchProduct() async {
  final String response = await rootBundle.loadString('assets/response.json');
  var data = ProductList.fromJson(jsonDecode(response));
  return data;
}

class Home extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Home> {
  bool value = false;

  List<Product>? allProducts;
  List<Product>? filterProducts;
  List<Product>? result;
  PageController? pageController;
  int page = 0;

  late Future<ProductList> futureProduct;

  @override
  void initState() {
    super.initState();
    futureProduct = fetchProduct();
    fetchProduct().then((value) {
      setState(() {
        allProducts = filterProducts = value.products;
      });
    });
  }

  List<Product> _filterProd() {
    return result = allProducts!.where((element) => element.on_sale).toList();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          centerTitle: true,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black54,
            ),
          ),
          title: const Text('Product List',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          actions: [Icon(Icons.search)],
        ),
        body: Center(
          child: FutureBuilder<ProductList>(
            future: futureProduct,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    Container(
                        // margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        height: 60.0,
                        child: Card(
                          elevation: 5,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      showModalBottomSheet(
                                          isScrollControlled: true,
                                          context: context,
                                          builder: (context) {
                                            return Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                ListTile(
                                                  title: Text(
                                                    'Filter',
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  // leading: new Icon(Icons.photo),
                                                  // title: new Text(_firstName.text),
                                                  // onTap: () {
                                                  //   Navigator.pop(context);
                                                  // },
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      'On Sale',
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Checkbox(
                                                      value: value,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          this.value = value!;
                                                          // print(allProducts!.length);
                                                        });
                                                      },
                                                    ),
                                                  ],
                                                ),
                                                Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 10),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                                  primary: Colors
                                                                      .blue),
                                                          onPressed: () {
                                                            setState(() {
                                                              allProducts =
                                                                  _filterProd();
                                                              print(result!
                                                                  .length);
                                                              Navigator.pop(
                                                                  context);
                                                              value = false;
                                                            });
                                                          },
                                                          child: Text('Apply')),
                                                    ],
                                                  ),
                                                ),
                                                Divider()
                                              ],
                                            );
                                          });
                                    },
                                    child: Row(children: [
                                      Icon(Icons.compare_arrows),
                                      Text('Filter')
                                    ])),
                                Row(children: [
                                  Text('Sort by'),
                                  Icon(Icons.arrow_drop_down),
                                  Icon(Icons.menu)
                                ]),
                              ]),
                        )),
                    Expanded(
                      child: GridView.builder(
                          itemCount: allProducts!.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 5,
                            crossAxisSpacing: 5,
                            childAspectRatio: 0.75,
                          ),
                          itemBuilder: (context, index) {
                            return Card(
                              elevation: 5,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                        child: Image(
                                      fit: BoxFit.fill,
                                      height: double.infinity,
                                      width: double.infinity,
                                      image: NetworkImage(
                                        "${allProducts![index].image[0]['src']}",
                                      ),
                                    )),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(5),
                                    // padding: const EdgeInsets.symmetric(vertical: 10 / 4),
                                    child: Text(
                                      // products is out demo list
                                      "${allProducts![index].name}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        if (allProducts![index].on_sale ==
                                            true) ...[
                                          Text(
                                            "\$${allProducts![index].regular_price}",
                                            style: TextStyle(
                                                decoration:
                                                    TextDecoration.lineThrough,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                        ] else ...[
                                          Text(
                                            "\$${allProducts![index].regular_price}",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                        ],
                                        if (allProducts![index].on_sale ==
                                            true) ...[
                                          Text(
                                            "\$${allProducts![index].sale_price}",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                        ],
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Text(
                                      "${allProducts![index].total_sales} sold",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    ),
                                  )
                                ],
                              ),
                            );
                          }),
                    ),
                  ],
                );
              }

              /////

              if (snapshot.hasData) {
                // return Text(snapshot.data!.doctors[1].de);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
