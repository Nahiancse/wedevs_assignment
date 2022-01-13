import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';

import 'package:flutter/material.dart';

class Product {
  String name;
  String short_description;
  String price;
  String regular_price;
  String sale_price;
  int total_sales;
  List image;
  bool on_sale;

  Product({
    required this.name,
    required this.short_description,
    required this.price,
    required this.regular_price,
    required this.sale_price,
    required this.total_sales,
    required this.image,
    required this.on_sale,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'],
      short_description: json['short_description'],
      price: json['price'],
      regular_price: json['regular_price'],
      sale_price: json['sale_price'],
      total_sales: json['total_sales'],
      image: json['images'],
      on_sale: json['on_sale'],
    );
  }
}

class ProductList {
   List<Product> products;

  ProductList({
    required this.products,
  });

  factory ProductList.fromJson(List<dynamic> parsedJson) {
    List<Product> products;
    products = parsedJson.map((i) => Product.fromJson(i)).toList();

    return ProductList(products: products);
  }
}

///////////////////////////////////////////////////////////////////////////////////

//fetch function
Future<ProductList> fetchAlbum() async {
  final String response = await rootBundle.loadString('assets/response.json');
  //  List data = await json.decode(response);
  var data = ProductList.fromJson(jsonDecode(response));
  return data;
  //  return ProductList.fromJson(jsonDecode(response));
}

///////////////////////////////////////////////////////////////////////////////////

// void main() => runApp(const MyApp());

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

  late Future<ProductList> futureAlbum;
  

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
     fetchAlbum().then((value){
       setState(() {
         allProducts=filterProducts=value.products;
       });
     });
  
     
  }
  List<Product> _filterProd(){
   return result=allProducts!.where((element) => element.on_sale).toList();
   

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
          title: const Text('Product List'),
        ),
        body: Center(
          child: FutureBuilder<ProductList>(
            future: futureAlbum,
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
                                                    Text('On Sale',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
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
                                                // Row(
                                                //   children: [
                                                //     Text('Newest'),
                                                //     Checkbox(
                                                //       value: false,
                                                //       onChanged: (value) {
                                                //         setState(() {});
                                                //       },
                                                //     ),
                                                //   ],
                                                // ),
                                                // Row(
                                                //   children: [
                                                //     Text('BestSelling'),
                                                //     Checkbox(
                                                //       value: false,
                                                //       onChanged: (value) {
                                                //         setState(() {});
                                                //       },
                                                //     ),
                                                //   ],
                                                // ),
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
                                                              allProducts=_filterProd();
                                                         print(result!.length);
                                                          Navigator.pop(context);
                                                          value=false;
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
                                        if (allProducts![index]
                                                .on_sale ==
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

                                        if (allProducts![index]
                                                .on_sale ==
                                            true) ...[
                                          Text(
                                            "\$${allProducts![index].sale_price}",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                        ],
                                        // Text(
                                        //   "\$${snapshot.data!.products[index].regular_price}",
                                        //   style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),
                                        // ),
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
